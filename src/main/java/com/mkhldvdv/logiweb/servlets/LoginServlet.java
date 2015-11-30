package com.mkhldvdv.logiweb.servlets;

import com.mkhldvdv.logiweb.dto.UserDTO;
import com.mkhldvdv.logiweb.services.impl.UserServicesImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by mkhldvdv on 23.11.2015.
 */
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        UserServicesImpl user = new UserServicesImpl();
        UserDTO myUser = user.getUser(req.getParameter("login"), req.getParameter("password"));
        if (myUser != null) {
            req.getSession().setAttribute("myUser", myUser);
            req.getSession().setAttribute("loggedInUser", myUser);
            // if not driver then full access
            if (myUser.getRole() != 3) {
                resp.sendRedirect("/info.jsp");
            }
            // restricted access
            else {
                resp.sendRedirect("/infoDriver.jsp");
            }
        } else {
            req.getSession().setAttribute("noUser", true);
            resp.sendRedirect("/login.jsp");
        }
    }
}
