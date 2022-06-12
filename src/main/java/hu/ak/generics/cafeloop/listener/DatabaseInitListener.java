package hu.ak.generics.cafeloop.listener;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.logging.Logger;

import javax.annotation.Resource;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.sql.DataSource;

import hu.ak.generics.cafeloop.bo.Customer;
import hu.ak.generics.cafeloop.bo.Frequency;
import hu.ak.generics.cafeloop.bo.Product;
import hu.ak.generics.cafeloop.bo.Subscription;
import hu.ak.generics.cafeloop.bo.SubscriptionItem;
import hu.ak.generics.cafeloop.dao.CustomerDao;
import hu.ak.generics.cafeloop.dao.Dao;
import hu.ak.generics.cafeloop.dao.FrequencyDao;
import hu.ak.generics.cafeloop.dao.ProductDao;
import hu.ak.generics.cafeloop.dao.SubscriptionDao;
import hu.ak.generics.cafeloop.dao.SubscriptionItemDao;


public class DatabaseInitListener implements ServletContextListener {

    private static final Logger logger = Logger.getLogger(DatabaseInitListener.class.getName());

    private static final String CREATE_CUSTOMER_TABLE_SQL = """
            create table if not exists customer (
                id int primary key auto_increment,
                email varchar(255) not null unique,
                name varchar(255) not null,
                pw varchar(255) not null,
                salt char(24) not null
            );
            """;

    private static final String CREATE_PRODUCT_TABLE_SQL = """
            create table if not exists product (
                id int primary key auto_increment,
                name varchar(255) not null unique,
                price int not null,
                description varchar(255),
                image_path varchar(255)
            );
             """;

    private static final String CREATE_FREQUENCY_TABLE_SQL = """
            create table if not exists frequency (
                id int primary key auto_increment,
                name varchar(255) not null unique,
                code varchar(255) not null unique
            );
             """;

    private static final String CREATE_SUBSCRIPTION_TABLE_SQL = """
            create table if not exists subscription (
                id int primary key auto_increment,
                subscription_date date not null,
                customer_id int not null,
                frequency_id int not null,
                address varchar(255) not null,
                foreign key (customer_id) references customer(id),
                foreign key (frequency_id) references frequency(id)
            );
             """;

    private static final String CREATE_SUBSCIPTION_ITEM_TABLE_SQL = """
            create table if not exists subscription_item (
                id int primary key auto_increment,
                product_id int not null,
                subscription_id int not null,
                quantity int not null check ( quantity > 0 ),
                foreign key (product_id) references product(id),
                foreign key (subscription_id) references subscription(id)
            );
            """;


    @Resource(name = "jdbc/mysql")
    private DataSource dataSource;
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        logger.info("Database init started");
        try (Connection connection = dataSource.getConnection()) {

            try (Statement statement = connection.createStatement()) {
                statement.execute("drop table if exists subscription_item");
                statement.execute("drop table if exists subscription");
                statement.execute("drop table if exists customer");
                statement.execute("drop table if exists frequency");
                statement.execute("drop table if exists product");

                statement.execute(CREATE_CUSTOMER_TABLE_SQL);
                statement.execute(CREATE_PRODUCT_TABLE_SQL);
                statement.execute(CREATE_FREQUENCY_TABLE_SQL);
                statement.execute(CREATE_SUBSCRIPTION_TABLE_SQL);
                statement.execute(CREATE_SUBSCIPTION_ITEM_TABLE_SQL);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        logger.info("Initializing test data");
        Dao<SubscriptionItem> subscriptionItemDao = new SubscriptionItemDao(dataSource);
        Dao<Subscription> subscriptionDao = new SubscriptionDao(dataSource);
        Dao<Product> productDao = new ProductDao(dataSource);
        Dao<Frequency> frequencyDao = new FrequencyDao(dataSource);
        Dao<Customer> customerDao = new CustomerDao(dataSource);

        logger.info("Initializing customer");

        // Teszt felhasználó jelszava: Abcd1234
        Customer testElek = Customer.builder()
                .email("teszt@elek.hu")
                .name("Teszt Elek")
                .password("AusPGv5yMXJjsdECEspuXA==")
                .salt("NPLs7/cPOJHkRpa/9fYTUg==")
                .build();

        testElek = customerDao.create(testElek);

        logger.info("Initializing frequencies");

        Frequency twiceAWeek = frequencyDao.create(Frequency.builder().name("Heti kétszer").code("FIRST_MONDAY_OF_EACH_MONTH").build());
        Frequency onceAWeek = frequencyDao.create(Frequency.builder().name("Heti egyszer").code("EACH_MONDAY").build());
        Frequency everyOtherWeek = frequencyDao.create(Frequency.builder().name("Minden második héten").code("EVERY_OTHER_MONDAY").build());
        Frequency monthly = frequencyDao.create(Frequency.builder().name("Havonta egyszer").code("EACH_MONDAY_AND_THURSDAY").build());

        logger.info("Initializing products");

        Product arabicaElite = Product.builder()
                .name("Arabica Elite")
                .price(2000)
                .description("Ízében a dió tónusai törnek felszínre, amit a bogyós gyümölcs enyhe savassága kísér.")
                .imagePath("coffee-sample.jpg")
                .build();

        arabicaElite = productDao.create(arabicaElite);

        Product robustaFantasy = Product.builder()
                .name("Robusta Fantasy")
                .price(2500)
                .description("Ízében minimális savassággal, a csokoládé és karamell tónusai dominálnak, mely a szárított fügére emlékeztet.")
                .imagePath("coffee-sample-2.jpeg")
                .build();

        robustaFantasy = productDao.create(robustaFantasy);

        Product robustaHarmony = Product.builder()
                .name("Robusta Harmony")
                .price(2750)
                .description("Ízében a friss trópusi gyümölcsök édes tónusai dominálnak tejcsokoládéval és nádcukorral kombinálva.")
                .imagePath("coffee-sample-3.jpeg")
                .build();

        robustaHarmony = productDao.create(robustaHarmony);

        createDummySubscription("Budapest, Fraknó utca 99.", monthly, testElek, Map.of(robustaFantasy, 3), subscriptionDao, subscriptionItemDao);
        createDummySubscription("Budapest, Királyfürdő utca 128.", everyOtherWeek, testElek, Map.of(robustaFantasy, 10), subscriptionDao, subscriptionItemDao);
        createDummySubscription("Budapest, Fraknó utca 99.", twiceAWeek, testElek, Map.of(arabicaElite, 1, robustaHarmony, 5), subscriptionDao, subscriptionItemDao);

        logger.info("Database init finished");

    }

    private void createDummySubscription(
            String address,
            Frequency frequency,
            Customer customer,
            Map<Product, Integer> products,
            Dao<Subscription> subscriptionDao,
            Dao<SubscriptionItem> subscriptionItemDao
    ) {
         Subscription subscriptionPrototype = Subscription.builder()
                .address(address)
                .frequency(frequency)
                .customer(customer)
                .build();

        Subscription subscription = subscriptionDao.create(subscriptionPrototype);

        for (Entry<Product, Integer> productEntry : products.entrySet()) {
            Integer quantity = productEntry.getValue();


            SubscriptionItem item = SubscriptionItem.builder()
                    .product(productEntry.getKey())
                    .subscription(subscription)
                    .quantity(quantity)
                    .build();

            subscriptionItemDao.create(item);
        }
    }


}
