package hu.ak.generics.cafeloop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import hu.ak.generics.cafeloop.bo.Customer;
import hu.ak.generics.cafeloop.util.SecurityUtils;

import javax.sql.DataSource;

public class CustomerDao implements Dao<Customer>, AuthenticationDao {

    private static final String INSERT_SQL = "insert into customer(email, name, pw, salt) values(?, ?, ?, ?);";
    private static final String UPDATE_SQL = "update customer set email = ?, name = ? where id = ?;";
    private static final String SELECT_ONE_SQL = "select * from customer where id = ?;";
    private static final String SELECT_ALL_SQL = "select * from customer where id = ?;";
    private static final String DELETE_SQL = "delete from customer where id = ?;";
    private static final String FIND_BY_EMAIL_SQL = "select * from customer where email = ?;";

    private final DataSource dataSource;

    public CustomerDao(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @Override
    public Customer create(Customer entity) throws SQLException {
        try (Connection connection = dataSource.getConnection();
             PreparedStatement ps = connection.prepareStatement(INSERT_SQL, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, entity.getEmail());
            ps.setString(2, entity.getName());
            ps.setString(3, entity.getPassword());
            ps.setString(4, entity.getSalt());

            // Nem ez a helyes lekezelése a nem megfelelő mennyiségű módosított sorszámnak, de nem hagyható teljesen
            // figyelmen kívül
            int updatedRows = ps.executeUpdate();

            if (updatedRows == 1) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int generatedId = generatedKeys.getInt(1);
                        entity.setId(generatedId);
                    }
                }
            }

            return entity;

        }
    }

    @Override
    public Optional<Customer> findById(int id) throws SQLException {
        try (Connection connection = dataSource.getConnection();
             PreparedStatement ps = connection.prepareStatement(SELECT_ONE_SQL)) {
            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(extractCustomer(rs));
                }
            }
        }

        return Optional.empty();
    }

    @Override
    public List<Customer> findAll() throws SQLException {
        List<Customer> customers = new ArrayList<>();
        try (Connection connection = dataSource.getConnection();
             Statement s = connection.createStatement()) {

            try (ResultSet rs = s.executeQuery(SELECT_ALL_SQL)) {
                while (rs.next()) {
                    Customer customer = extractCustomer(rs);
                    customers.add(customer);
                }
            }
        }

        return customers;
    }

    @Override
    public boolean update(Customer entity) throws SQLException {
        try (Connection connection = dataSource.getConnection();
             PreparedStatement ps = connection.prepareStatement(UPDATE_SQL)) {
            ps.setString(1, entity.getEmail());
            ps.setString(2, entity.getName());
            ps.setInt(3, entity.getId());

            int rowsUpdated = ps.executeUpdate();

            return rowsUpdated == 1;
        }
    }

    @Override
    public boolean deleteById(int id) throws SQLException {
        try (Connection connection = dataSource.getConnection();
             PreparedStatement ps = connection.prepareStatement(DELETE_SQL)) {
            ps.setInt(1, id);

            int rowsDeleted = ps.executeUpdate();

            return rowsDeleted == 1;
        }

    }

    @Override
    public Optional<Customer> findCustomerByEmailAndPassword(String email, String password) throws SQLException {
        return findCustomerByEmail(email)
                .filter(customer -> {
                    String salt = customer.getSalt();
                    String encryptedPassword = SecurityUtils.encryptPassword(password, salt);
                    return encryptedPassword.equals(customer.getPassword());
                });
    }

    @Override
    public Optional<Customer> findCustomerByEmail(String email) throws SQLException {
        try (Connection connection = dataSource.getConnection();
             PreparedStatement ps = connection.prepareStatement(FIND_BY_EMAIL_SQL)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(extractCustomer(rs));
                }
            }
        }
        return Optional.empty();
    }

    @Override
    public void updatePassword(String email, String newPassword) throws SQLException {
        try (Connection connection = dataSource.getConnection();
             PreparedStatement ps = connection.prepareStatement("update customer set pw = ? where email = ?;")) {
            ps.setString(1, newPassword);
            ps.setString(2, email);

            ps.executeUpdate();
        }
    }

    private Customer extractCustomer(ResultSet rs) throws SQLException {
        Customer customer = new Customer();
        customer.setEmail(rs.getString("email"));
        customer.setId(rs.getInt("id"));
        customer.setName(rs.getString("name"));
        customer.setPassword(rs.getString("pw"));
        customer.setSalt(rs.getString("salt"));
        return customer;
    }

}
