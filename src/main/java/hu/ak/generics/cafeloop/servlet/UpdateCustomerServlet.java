package hu.ak.generics.cafeloop.servlet;

import java.io.IOException;
import java.rmi.ServerError;
import java.sql.SQLException;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import hu.ak.generics.cafeloop.bo.Customer;
import hu.ak.generics.cafeloop.dao.CustomerDao;
import hu.ak.generics.cafeloop.dao.Dao;

public class UpdateCustomerServlet extends HttpServlet {

	@Resource(name = "jdbc/mysql")
	private DataSource dataSource;

	private Dao<Customer> customerDao;

	@Override
	public void init() throws ServletException {
		customerDao = new CustomerDao(dataSource);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String email = req.getParameter("email");
		String name = req.getParameter("name");

		HttpSession session = req.getSession();
		Customer customer = (Customer) session.getAttribute("loggedInCustomer");

		customer.setEmail(email);
		customer.setName(name);

		customerDao.update(customer);

		resp.sendRedirect(req.getContextPath() + "/customer-center/profile.jsp");

	}
}
