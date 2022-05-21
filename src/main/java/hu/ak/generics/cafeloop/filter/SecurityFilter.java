package hu.ak.generics.cafeloop.filter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class SecurityFilter extends HttpFilter {

    @Override
    protected void doFilter(HttpServletRequest req, HttpServletResponse res, FilterChain chain) throws IOException, ServletException {
        Object loggedInCustomer = req.getSession().getAttribute("customer");

        if (loggedInCustomer == null) {
            res.sendRedirect(req.getContextPath() + "/index.jsp");
        } else {
            super.doFilter(req, res, chain);
        }
    }
}
