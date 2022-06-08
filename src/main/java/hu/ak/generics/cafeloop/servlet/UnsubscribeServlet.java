package hu.ak.generics.cafeloop.servlet;

import hu.ak.generics.cafeloop.bo.Product;
import hu.ak.generics.cafeloop.bo.Subscription;
import hu.ak.generics.cafeloop.bo.SubscriptionItem;
import hu.ak.generics.cafeloop.dao.Dao;
import hu.ak.generics.cafeloop.dao.ProductDao;
import hu.ak.generics.cafeloop.dao.SubscriptionDao;
import hu.ak.generics.cafeloop.dao.SubscriptionItemDao;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import java.io.IOException;
import java.sql.*;

public class UnsubscribeServlet extends HttpServlet {

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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));

        try (Connection connection = dataSource.getConnection();
             PreparedStatement ps = connection.prepareStatement("select id from subscription_item where subscription_id = ?;")) {
            ps.setInt(1, id);

            try (ResultSet resultSet = ps.executeQuery()) {
                while(resultSet.next()) {
                    subscriptionItemDao.deleteById(resultSet.getInt(1));
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        subscriptionDao.deleteById(id);

        resp.sendRedirect(req.getContextPath() + "/customer-center/subscriptions.jsp");
    }
}
