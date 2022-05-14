package hu.ak.generics.cafeloop.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hu.ak.generics.cafeloop.bo.Customer;
import hu.ak.generics.cafeloop.dao.CustomerDao;
import hu.ak.generics.cafeloop.dao.Dao;

public class RegistrationServlet extends HttpServlet {
	
	private final Dao<Customer> customerDao = new CustomerDao();
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String name = req.getParameter("name");
		String password = req.getParameter("password");
		String email = req.getParameter("email");
		
		// TODO ellenőrzés: email egyedisége, email formátuma
		
		Customer customer = new Customer();
		customer.setEmail(email);
		customer.setName(name);
		customer.setPassword("alma");
		customer.setSalt(42);
//		customer.setId(???);
		
		Customer createdCustomer = customerDao.create(customer);
		
		resp.sendRedirect("login.jsp");
	}

}
