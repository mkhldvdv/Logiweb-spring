package com.mkhldvdv.logiweb.servlets;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by mkhldvdv on 23.11.2015.
 */
public class LoginServlet extends HttpServlet {

    private static final Logger LOGGER = LogManager.getLogger(LoginServlet.class);

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("LoginServlet entry");

//        UserServicesImpl user = new UserServicesImpl();
//        User myUser = user.getUser(req.getParameter("login"), req.getParameter("password"));
//        if (myUser != null) {
//            req.getSession().setAttribute("myUser", myUser);
//            req.getSession().setAttribute("loggedInUser", myUser);
//            // if not driver then full access
//            if (myUser.getRole() != 3) {
//                resp.sendRedirect("/info.jsp");
//            }
//            // restricted access
//            else {
//                resp.sendRedirect("/infoDriver.jsp");
//            }
//        } else {
//            req.getSession().setAttribute("noUser", true);
//            resp.sendRedirect("/login.jsp");
//        }
        LOGGER.error("LoginServlet entry");
    }
}
