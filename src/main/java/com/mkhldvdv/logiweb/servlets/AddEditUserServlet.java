package com.mkhldvdv.logiweb.servlets;

import com.mkhldvdv.logiweb.dto.UserDTO;
import com.mkhldvdv.logiweb.services.impl.AdminServicesImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by mkhldvdv on 29.11.2015.
 */
public class AddEditUserServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        AdminServicesImpl adminServices = new AdminServicesImpl();
        String driverIdString = req.getParameter("driverId");
        String deleteString = req.getParameter("delete");
        String pass = req.getParameter("pass");
        try {
            if (deleteString != null) {
                // delete user
                adminServices.deleteUser(Long.parseLong(driverIdString));
                req.getSession().setAttribute("object", driverIdString);
                resp.sendRedirect("/success.jsp");
            } else {
                UserDTO userDTO = new UserDTO();
                // fill in with new/edit fields
                userDTO.setFirstName(req.getParameter("firstName"));
                userDTO.setLastName(req.getParameter("lastName"));
                userDTO.setLogin(req.getParameter("loginName"));
                userDTO.setPassword(req.getParameter("password"));
                userDTO.setRole(Byte.parseByte(req.getParameter("role")));
                userDTO.setHours(Short.parseShort(req.getParameter("hours")));
                userDTO.setUserStatus(Byte.parseByte(req.getParameter("status")));
                userDTO.setCity(Long.parseLong(req.getParameter("city")));
                userDTO.setDeleted((byte) 0);

                // what to execute -- add or delete
                UserDTO newUserId;
                if (driverIdString == null || driverIdString == "") {
                    newUserId = adminServices.addUser(userDTO);
                } else {
                    userDTO.setId(Long.parseLong(driverIdString));
                    // check if "old" and "new" passwords identical
                    if (pass.equals(userDTO.getPassword())) {
                        newUserId = adminServices.updateUser(userDTO, true);
                    } else {
                        newUserId = adminServices.updateUser(userDTO, false);
                    }
                }

                // check all is fine
                if (newUserId == null) {
                    throw new Exception("User was not added/updated for some reason");
                }

                req.getSession().setAttribute("object", newUserId);
                resp.sendRedirect("/success.jsp");
            }
        } catch (Exception e) {
            System.out.printf(">>> Exception: Something wrong with user id: %s\nCheck log file\n", driverIdString);
            e.printStackTrace();
            req.getSession().setAttribute("error", e);
            resp.sendRedirect("/error.jsp");
        }
    }
}
