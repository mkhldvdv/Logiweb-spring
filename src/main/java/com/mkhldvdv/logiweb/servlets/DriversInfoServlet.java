package com.mkhldvdv.logiweb.servlets;

import com.mkhldvdv.logiweb.dto.DriverInfoDTO;
import com.mkhldvdv.logiweb.services.impl.UserServicesImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by mkhldvdv on 29.11.2015.
 */
public class DriversInfoServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

            long driverId = Long.parseLong(req.getParameter("driverId"));

            UserServicesImpl userServices = new UserServicesImpl();
            DriverInfoDTO driverInfoDTO = new DriverInfoDTO();

            // fill in the info for driver
            driverInfoDTO.setId(driverId);
            driverInfoDTO.setCoDriversIds(userServices.getCoDriversIds(driverId));
            driverInfoDTO.setRegNum(userServices.getRegNum(driverId));
            driverInfoDTO.setOrderId(userServices.getDriversOrders(driverId));
            driverInfoDTO.setCities(userServices.getDriversCities(driverId));

            req.getSession().setAttribute("drivers", driverInfoDTO);
            resp.sendRedirect("/infoForDriver.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("error", "\nYou are not allowed for this operation");
            resp.sendRedirect("/errorDriver.jsp");
        }
    }
}
