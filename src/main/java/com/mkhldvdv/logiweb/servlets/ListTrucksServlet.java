package com.mkhldvdv.logiweb.servlets;

import com.mkhldvdv.logiweb.dto.TruckDTO;
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
public class ListTrucksServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        AdminServicesImpl adminServices = new AdminServicesImpl();
        List<TruckDTO> trucksDTOList = adminServices.getTrucks();
        req.getSession().setAttribute("trucksList", trucksDTOList);
        resp.sendRedirect("/listTrucks.jsp");
    }
}
