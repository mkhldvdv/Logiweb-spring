package com.mkhldvdv.logiweb.servlets;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by mkhldvdv on 23.11.2015.
 */
public class Servlet extends HttpServlet {

    public List<String> list;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if(list == null) {
            list = new ArrayList<String>();
        }
        list.add(req.getParameter("username") + " : " + req.getParameter("age"));
        req.getSession().setAttribute("list", list);

//        PrintWriter out = resp.getWriter();
//        for (String s : list) {
//            out.println(s);
//        }



        resp.sendRedirect("/NameAge.jsp");
    }
}
