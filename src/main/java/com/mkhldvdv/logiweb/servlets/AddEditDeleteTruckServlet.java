package com.mkhldvdv.logiweb.servlets;

import com.mkhldvdv.logiweb.dto.TruckDTO;
import com.mkhldvdv.logiweb.services.impl.AdminServicesImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by mkhldvdv on 30.11.2015.
 */
public class AddEditDeleteTruckServlet extends HttpServlet {

    public static final String ADD = "add";
    public static final String DELETE = "delete";

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // what to do: add truck, edit truck or delete truck
        String action = req.getParameter("action");
        //
        AdminServicesImpl adminServices = new AdminServicesImpl();
        // for delete and edit operation there should be truckId hidden field
        String truckId = req.getParameter("truckId");

        try {
            // create DTO object for the truck
            TruckDTO truckDTO = new TruckDTO();
            // if add or update then fill in the truckDTO object
            // else skip it
            if (ADD.equals(action)) {
                // fill in with new/edit fields
                truckDTO.setRegNum(req.getParameter("regNum"));
                truckDTO.setDriverCount(Byte.parseByte(req.getParameter("shift")));
                truckDTO.setCapacity(Byte.parseByte(req.getParameter("capacity")));
                truckDTO.setTruckStatus(Byte.parseByte(req.getParameter("status")));
                truckDTO.setCity(Long.parseLong(req.getParameter("city")));
            }
            // action
            TruckDTO newTruck = new TruckDTO();
            if (ADD.equals(action) && truckId == "") {
                // add new truck
                newTruck = adminServices.addTruck(truckDTO);
            } else if (ADD.equals(action) && truckId != "") {
                // update truck
                truckDTO.setId(Long.parseLong(truckId));
                newTruck = adminServices.updateTruck(truckDTO);
            } else if (DELETE.equals(action)) {
                // delete truck
                truckDTO.setId(Long.parseLong(truckId));
                adminServices.deleteTruck(truckDTO.getId());
            }

            if (newTruck == null) {
                throw new Exception(">>> Exception: Truck was not added/updated for some reason");
            }

            // create response
            if (DELETE.equals(action)) {
                req.getSession().setAttribute("object", truckId);
            }
            else {
                req.getSession().setAttribute("object", newTruck);
            }

            resp.sendRedirect("/success.jsp");
        } catch (Exception e) {
            System.out.printf(">>> Exception: Something wrong with truck id: %s\nCheck log file\n", truckId);
            e.printStackTrace();
            req.getSession().setAttribute("error", e);
            resp.sendRedirect("/error.jsp");
        }
    }
}
