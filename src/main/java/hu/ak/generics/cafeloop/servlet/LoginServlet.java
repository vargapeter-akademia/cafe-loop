package hu.ak.generics.cafeloop.servlet;

import hu.ak.generics.cafeloop.bo.Customer;
import hu.ak.generics.cafeloop.dao.AuthenticationDao;
import hu.ak.generics.cafeloop.dao.CustomerDao;
import hu.ak.generics.cafeloop.exception.ServerError;

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

public class LoginServlet extends HttpServlet {

    @Resource(name="jdbc/mysql")
    private DataSource dataSource;

    private AuthenticationDao authenticationDao;

    @Override
    public void init() {
        authenticationDao = new CustomerDao(dataSource);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        Optional<Customer> customerFound;
        try {
            customerFound = authenticationDao.findCustomerByEmailAndPassword(email, password);
        } catch (SQLException e) {
            throw new ServerError(e);
        }

        if (customerFound.isPresent()) {
            HttpSession session = req.getSession();
            session.setAttribute("customer", customerFound.get());

            resp.sendRedirect(req.getContextPath() + "/index.jsp");
        } else {
            req.setAttribute("login_failed", true);
            req.getRequestDispatcher(req.getContextPath() + "/login.jsp")
                    .forward(req, resp);
        }


    }
}
