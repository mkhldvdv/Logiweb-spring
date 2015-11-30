package com.mkhldvdv.logiweb.servlets;

import com.mkhldvdv.logiweb.dto.UserDTO;
import com.mkhldvdv.logiweb.services.impl.AdminServicesImpl;
import com.mkhldvdv.logiweb.services.impl.UserServicesImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Created by mkhldvdv on 29.11.2015.
 */
public class ListDriversServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            AdminServicesImpl adminServices = new AdminServicesImpl();
            UserServicesImpl userServices = new UserServicesImpl();
            // get driverId from the params
            String driverParam = req.getParameter("driverId");
            // if it doesn't exist then get all the list of drivers
            if (driverParam == null || driverParam == "") {
                List<UserDTO> userDTOList = adminServices.getDrivers();
                req.getSession().setAttribute("driversList", userDTOList);
                resp.sendRedirect("/listDrivers.jsp");
            } else {
                // trying to parse the value (should be numeric after the form)
                long driverId = Long.parseLong(driverParam);
                // get the user to fill in the form on the next page with the default values
                UserDTO userDTO = userServices.getUser(driverId);
                req.getSession().setAttribute("driverId", driverParam);
                req.getSession().setAttribute("userObject", userDTO);
                resp.sendRedirect("/addDriver.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("error", e);
            resp.sendRedirect("/error.jsp");
        }
    }
}
