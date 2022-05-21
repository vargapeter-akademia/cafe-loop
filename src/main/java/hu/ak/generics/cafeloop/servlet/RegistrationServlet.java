package hu.ak.generics.cafeloop.servlet;

import java.io.IOException;
import java.security.SecureRandom;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import hu.ak.generics.cafeloop.bo.Customer;
import hu.ak.generics.cafeloop.dao.CustomerDao;
import hu.ak.generics.cafeloop.exception.ServerError;
import hu.ak.generics.cafeloop.util.SecurityUtils;

public class RegistrationServlet extends HttpServlet {

    @Resource(name = "jdbc/mysql")
    private DataSource dataSource;

    private CustomerDao customerDao;

    @Override
    public void init() {
        customerDao = new CustomerDao(dataSource);
    }

    // Érdemes megjegyezni, hogy jelszót nem szoktunk String-ként tárolni, mivel ez így benne lesz a String poolban is
    private static boolean isValidPassword(String password) {
        return password.matches("^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8}.*$");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String password = req.getParameter("password");
        String email = req.getParameter("email");

        // TODO ellenőrzés: email egyedisége, email formátuma
        List<String> errors = new ArrayList<>();
        if (!isValidPassword(password)) {
            errors.add("password-error");
        }

        if (!isValidEmail(email)) {
            errors.add("email-format-error");
        }

        try {
            customerDao.findCustomerByEmail(email)
                    .ifPresent(e -> errors.add("email-duplication-error"));
        } catch (SQLException e) {
            throw new ServerError(e);
        }

        Customer customer = new Customer();
        customer.setEmail(email);
        customer.setName(name);
        setPasswordAndSalt(customer, password);

        try {
            customerDao.create(customer);
        } catch (SQLException e) {
            throw new ServerError(e);
        }

        if (errors.isEmpty()) {
            resp.sendRedirect("login.jsp");
        } else {
            req.setAttribute("errors", errors);
            req.getRequestDispatcher("/registration.jsp")
                    .forward(req, resp);
        }
    }

    private static boolean isValidEmail(String email) {
        return email.matches("^(.+)@(\\S+)$");
    }

    private void setPasswordAndSalt(Customer customer, String password) {
        byte[] salt = SecureRandom.getSeed(16);

        String encryptedPassword = SecurityUtils.encryptPassword(password, salt);
        customer.setPassword(encryptedPassword);
        customer.setSalt(SecurityUtils.encodeSalt(salt));
    }

}
