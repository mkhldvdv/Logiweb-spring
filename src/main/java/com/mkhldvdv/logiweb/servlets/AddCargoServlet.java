package com.mkhldvdv.logiweb.servlets;

import com.mkhldvdv.logiweb.dto.CargoDTO;
import com.mkhldvdv.logiweb.entities.Waypoint;
import com.mkhldvdv.logiweb.services.impl.AdminServicesImpl;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

/**
 * Created by mkhldvdv on 01.12.2015.
 */
public class AddCargoServlet extends HttpServlet {

    private static final Logger LOG = LogManager.getLogger(AddCargoServlet.class);

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        LOG.info("add cargo servlet");
        try {
            AdminServicesImpl adminServices = new AdminServicesImpl();

            // creating necessary objects
            CargoDTO cargoDTO = new CargoDTO();
            Waypoint waypointLoad = new Waypoint();
            Waypoint waypointUnload = new Waypoint();

            cargoDTO.setCargoName(req.getParameter("cargoName"));
            cargoDTO.setWeight(Integer.parseInt(req.getParameter("weight")));
            cargoDTO.setCargoStatus(Byte.parseByte(req.getParameter("cargoStatus")));

            // loading cargo waypoint
            waypointLoad.setCargoType((byte) 1);
            waypointLoad.setCity(Byte.parseByte(req.getParameter("cityLoad")));

            // unloading cargo waypoint
            waypointUnload.setCargoType((byte) 2);
            waypointUnload.setCity(Byte.parseByte(req.getParameter("cityUnload")));

            // adding waypoint to cargos waypoints list
            cargoDTO.setWaypoints(new ArrayList<Long>());
            cargoDTO.setFullWaypoints(new ArrayList<Waypoint>());
            cargoDTO.getFullWaypoints().add(waypointLoad);
            cargoDTO.getFullWaypoints().add(waypointUnload);

            // and call add catgo
            CargoDTO newCargo = new CargoDTO();
            newCargo = adminServices.addCargo(cargoDTO);

            if (newCargo == null) {
                throw new Exception(">>> Exception: Cargo was not added/updated for some reason");
            }

            req.getSession().setAttribute("object", newCargo);

            resp.sendRedirect("/success.jsp");
        } catch (Exception e) {
//            System.out.printf(">>> Exception: Something wrong while adding cargo:\nCheck log file\n");
            LOG.error("Error while adding new cargo in app", e);
            req.getSession().setAttribute("error", e.getMessage());
            resp.sendRedirect("/error.jsp");
        }
    }
}
