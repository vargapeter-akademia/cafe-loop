package hu.ak.generics.cafeloop.servlet;

import hu.ak.generics.cafeloop.bo.Customer;
import hu.ak.generics.cafeloop.dao.AuthenticationDao;
import hu.ak.generics.cafeloop.dao.CustomerDao;
import hu.ak.generics.cafeloop.exception.ServerError;
import hu.ak.generics.cafeloop.util.SecurityUtils;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Optional;

public class UpdatePasswordServlet extends HttpServlet {

    @Resource(name = "jdbc/mysql")
    private DataSource dataSource;

    private AuthenticationDao authenticationDao;

    @Override
    public void init() throws ServletException {
        authenticationDao = new CustomerDao(dataSource);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String newPassword = req.getParameter("password");
        String oldPassword = req.getParameter("password-old");

        HttpSession session = req.getSession();
        Customer loggedInCustomer = (Customer) session.getAttribute("customer");

        try {
            Optional<Customer> customerFound = authenticationDao.findCustomerByEmailAndPassword(loggedInCustomer.getEmail(), oldPassword);

            if (customerFound.isPresent()) {
                String encryptedNewPassword = SecurityUtils.encryptPassword(newPassword, loggedInCustomer.getSalt());
                authenticationDao.updatePassword(loggedInCustomer.getEmail(), encryptedNewPassword);
                resp.sendRedirect(req.getContextPath() + "/customer-center/profile.jsp");
            } else {
                req.setAttribute("invalid-password-error", true);
                req.getRequestDispatcher(req.getContextPath() + "/customer-center/profile.jsp");
            }
        } catch (SQLException e) {
            throw new ServerError(e);
        }

    }
}
