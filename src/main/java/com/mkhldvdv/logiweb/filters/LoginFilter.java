package com.mkhldvdv.logiweb.filters;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by mkhldvdv on 28.11.2015.
 */
public class LoginFilter implements Filter {

    public static final String IGNORE_PATH = "/login.jsp";

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        String path = request.getRequestURI();

        HttpSession session = request.getSession(false);
        if ((session == null || session.getAttribute("loggedInUser") == null) && !IGNORE_PATH.equals(path)) {
            ((HttpServletRequest) req).getSession().setAttribute("noUser", false);
//            response.sendRedirect(request.getContextPath() + "/login.jsp");
            response.sendRedirect("/login.jsp");
        } else {
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {

    }
}
