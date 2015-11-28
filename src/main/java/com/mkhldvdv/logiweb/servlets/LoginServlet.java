package com.mkhldvdv.logiweb.servlets;

import com.mkhldvdv.logiweb.entities.User;
import com.mkhldvdv.logiweb.services.impl.UserServicesImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by mkhldvdv on 23.11.2015.
 */
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        UserServicesImpl user = new UserServicesImpl();
        User myUser = user.getUser(req.getParameter("login"), req.getParameter("password"));
        req.getSession().setAttribute("myUser", myUser.getFisrtName());

        resp.sendRedirect("/info.jsp");
    }
}
