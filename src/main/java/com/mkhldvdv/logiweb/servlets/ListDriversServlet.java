package com.mkhldvdv.logiweb.servlets;

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
public class ListDriversServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        AdminServicesImpl adminServices = new AdminServicesImpl();
        List<UserDTO> userDTOList = adminServices.getDrivers();
        req.getSession().setAttribute("driversList", userDTOList);
        resp.sendRedirect("/listDrivers.jsp");
    }
}
