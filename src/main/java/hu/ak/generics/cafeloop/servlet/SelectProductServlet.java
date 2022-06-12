package hu.ak.generics.cafeloop.servlet;

import hu.ak.generics.cafeloop.bo.Product;
import hu.ak.generics.cafeloop.bo.SubscriptionItem;
import hu.ak.generics.cafeloop.dao.Dao;
import hu.ak.generics.cafeloop.dao.ProductDao;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

public class SelectProductServlet extends HttpServlet {

    @Resource(name = "jdbc/mysql")
    private DataSource dataSource;

    private Dao<Product> productDao;

    @Override
    public void init() {
        productDao = new ProductDao(dataSource);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        int productId = Integer.parseInt(req.getParameter("productId"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));

        Map<Integer, SubscriptionItem> selectedProducts = (Map<Integer, SubscriptionItem>) session.getAttribute("selectedProducts");

        if (selectedProducts == null) {
            selectedProducts = new HashMap<>();
            session.setAttribute("selectedProducts", selectedProducts);
        }

        if (quantity == 0) {
            selectedProducts.remove(productId);
        } else {

            Product product = productDao.findById(productId)
                    .orElseThrow(() -> new RuntimeException("Invalid product selected"));

            SubscriptionItem subscriptionItem = SubscriptionItem.builder()
                    .product(product)
                    .quantity(quantity)
                    .build();

            selectedProducts.put(productId, subscriptionItem);

        }

        int totalCost = selectedProducts.values().stream()
                .mapToInt(e -> e.getProduct().getPrice() * e.getQuantity())
                .sum();

        session.setAttribute("totalCost", totalCost);

        resp.sendRedirect(req.getContextPath() + "/customer-center/new-subscription.jsp");
    }

}
