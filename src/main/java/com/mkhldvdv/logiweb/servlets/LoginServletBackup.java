package com.mkhldvdv.logiweb.servlets;

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
public class LoginServletBackup extends HttpServlet {

    public List<String> list;
//    public String stringUser;
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (list == null) {
            list = new ArrayList<String>();
        }
        UserServicesImpl user = new UserServicesImpl();
        list.add(req.getParameter("username"));
        list.add(user.getUser(req.getParameter("username"), req.getParameter("password")).toString());
//        stringUser = user.getUser(req.getParameter("username"), req.getParameter("password")).toString();
        req.getSession().setAttribute("list", list);
//        req.getSession().setAttribute("list", stringUser);
//        PrintWriter out = resp.getWriter();
//        for (String s : list) {
//            out.println(s);
//        }

        resp.sendRedirect("/LoginFormBackup.jsp");
//        resp.sendRedirect("/NameAge.jsp");
    }
}
