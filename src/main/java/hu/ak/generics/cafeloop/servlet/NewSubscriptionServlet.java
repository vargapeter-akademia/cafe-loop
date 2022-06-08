package hu.ak.generics.cafeloop.servlet;

import hu.ak.generics.cafeloop.bo.Customer;
import hu.ak.generics.cafeloop.bo.Frequency;
import hu.ak.generics.cafeloop.bo.Product;
import hu.ak.generics.cafeloop.bo.Subscription;
import hu.ak.generics.cafeloop.bo.SubscriptionItem;
import hu.ak.generics.cafeloop.dao.Dao;
import hu.ak.generics.cafeloop.dao.SubscriptionDao;
import hu.ak.generics.cafeloop.dao.SubscriptionItemDao;

import javax.annotation.Resource;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import java.io.IOException;
import java.util.Map;
import java.util.Map.Entry;

public class NewSubscriptionServlet extends HttpServlet {

    @Resource(name = "jdbc/mysql")
    private DataSource dataSource;

    private Dao<Subscription> subscriptionDao;
    private Dao<SubscriptionItem> subscriptionItemDao;

    @Override
    public void init() {
        subscriptionDao = new SubscriptionDao(dataSource);
        subscriptionItemDao = new SubscriptionItemDao(dataSource);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String address = req.getParameter("address");
        String frequencyId = req.getParameter("frequencyId");

        HttpSession session = req.getSession();
        Customer loggedInCustomer = (Customer) session.getAttribute("loggedInCustomer");
        Map<Integer, SubscriptionItem> selectedProducts = (Map<Integer, SubscriptionItem>) session.getAttribute("selectedProducts");

        Subscription subscriptionPrototype = Subscription.builder()
                .address(address)
                .frequency(Frequency.builder().id(Integer.parseInt(frequencyId)).build())
                .customer(loggedInCustomer)
                .build();

        Subscription subscription = subscriptionDao.create(subscriptionPrototype);

        for (Entry<Integer, SubscriptionItem> selectedProductIdAndQuantity : selectedProducts.entrySet()) {
            Integer productId = selectedProductIdAndQuantity.getKey();
            SubscriptionItem subscriptionItem = selectedProductIdAndQuantity.getValue();
            int quantity = subscriptionItem.getQuantity();

            if (quantity > 0) {
                Product product = Product.builder()
                        .id(productId)
                        .build();

                SubscriptionItem item = SubscriptionItem.builder()
                        .product(product)
                        .subscription(subscription)
                        .quantity(quantity)
                        .build();

                subscriptionItemDao.create(item);
            }
        }

        session.setAttribute("selectedProducts", null);

        resp.sendRedirect(req.getContextPath() + "/customer-center/subscriptions.jsp");

    }
}
