package com.mkhldvdv.logiweb.servlets;

import com.mkhldvdv.logiweb.dto.OrderDTO;
import com.mkhldvdv.logiweb.dto.UserDTO;
import com.mkhldvdv.logiweb.exceptions.WrongIdException;
import com.mkhldvdv.logiweb.services.impl.AdminServicesImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by mkhldvdv on 29.11.2015.
 */
public class ListOrdersServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        AdminServicesImpl adminServices = new AdminServicesImpl();
        String orderIdString = req.getParameter("orderId");
        List<OrderDTO> orderDTOList;

        try {
            // if parameter is not defined, return list of all orders
            if (orderIdString == null || orderIdString == "") {
                orderDTOList = adminServices.getOrders();
                req.getSession().setAttribute("ordersList", orderDTOList);
                resp.sendRedirect("/listOrders.jsp");
            } else {
                // if defined then only specified order
//                orderDTOList = new ArrayList<OrderDTO>();
                long orderId = Long.parseLong(orderIdString);
                OrderDTO orderDTO = adminServices.getOrder(orderId);
                req.getSession().setAttribute("ordersList", orderDTO);
                resp.sendRedirect("/listOneOrder.jsp");
            }

        } catch (Exception e) {
            System.out.printf(">>> Exception: Something wrong with order id: %s\nCheck log file\n", orderIdString);
            e.printStackTrace();
            resp.sendRedirect("#");
        }

    }
}
