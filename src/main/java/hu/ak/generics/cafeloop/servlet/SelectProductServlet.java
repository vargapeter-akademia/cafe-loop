package hu.ak.generics.cafeloop.servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SelectProductServlet extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		
		Map<Integer, Integer> selectedProducts =  Optional.ofNullable(session.getAttribute("selectedProducts"))
			.map(e -> (Map<Integer, Integer>) e)
			.orElse(new HashMap<>());
		
		String productId = req.getParameter("productId");
		String quantity = req.getParameter("quantity");
		
		selectedProducts.put(Integer.valueOf(productId), Integer.valueOf(quantity));
		
		session.setAttribute("selectedProducts", selectedProducts);
		
		resp.sendRedirect(req.getContextPath() + "/customer-center/new-subscription.jsp");
	}

}
