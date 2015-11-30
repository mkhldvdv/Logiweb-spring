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
        try {
            AdminServicesImpl adminServices = new AdminServicesImpl();
            // get truckId from the params
            String truckIdParam = req.getParameter("truckId");
            // if it doesn't exist then get all the list of trucks
            if (truckIdParam == null || truckIdParam == "") {
                List<TruckDTO> truckDTOList = adminServices.getTrucks();
                req.getSession().setAttribute("trucksList", truckDTOList);
                resp.sendRedirect("/listTrucks.jsp");
            } else {
                // trying to parse the value (should be numeric after the form)
                long truckId = Long.parseLong(truckIdParam);
                // get the truck to fill in the form on the next page with the default values
                TruckDTO truckDTO = adminServices.getTruck(truckId);
                req.getSession().setAttribute("truckId", truckIdParam);
                req.getSession().setAttribute("userObject", truckDTO);
                resp.sendRedirect("/addTruck.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("error", e);
            resp.sendRedirect("/error.jsp");
        }
    }
}
