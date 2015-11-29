package com.mkhldvdv.logiweb.servlets;

import com.mkhldvdv.logiweb.dto.OrderDTO;
import com.mkhldvdv.logiweb.dto.UserDTO;
import com.mkhldvdv.logiweb.services.impl.AdminServicesImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Created by mkhldvdv on 29.11.2015.
 */
public class ListOrdersServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        AdminServicesImpl adminServices = new AdminServicesImpl();
        List<OrderDTO> orderDTOList = adminServices.getOrders();
        req.getSession().setAttribute("ordersList", orderDTOList);
        resp.sendRedirect("/listOrders.jsp");
    }
}
