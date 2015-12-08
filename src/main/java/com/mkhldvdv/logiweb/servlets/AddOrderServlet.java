package com.mkhldvdv.logiweb.servlets;

import com.mkhldvdv.logiweb.dto.CargoDTO;
import com.mkhldvdv.logiweb.dto.OrderDTO;
import com.mkhldvdv.logiweb.dto.TruckDTO;
import com.mkhldvdv.logiweb.dto.UserDTO;
import com.mkhldvdv.logiweb.entities.Truck;
import com.mkhldvdv.logiweb.services.impl.AdminServicesImpl;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Created by mkhldvdv on 02.12.2015.
 */
public class AddOrderServlet extends HttpServlet {
    private static final Logger LOG = LogManager.getLogger(AddOrderServlet.class);

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        LOG.info("get into AddOrderServlet");

        try {
            AdminServicesImpl adminServices = new AdminServicesImpl();

            // step 0: prepare data for adding the order
            // get all the cargos without order id
            // after step 0 redirect to /addOrder.jsp
            String stepStr = req.getParameter("step");
            // if no step assigned then step 0
            if (stepStr == null || stepStr == "") {
                List<CargoDTO> cargoDTOs = adminServices.getAllUnassignedCargos();

                // set parameter...
                req.getSession().setAttribute("cargoList", cargoDTOs);
                // ...and redirect to the next step page
                resp.sendRedirect("/addOrder.jsp");
                // this is only for the sample while no methods implemeted yet
                stepStr = "0";
            }

            int step = Integer.parseInt(stepStr);

            // step 1: get the truck for order
            // after step 1 redirect to /addOrderTruck.jsp
            if (step == 1) {
                // array of cargos ids should exists here
                List<String> cargos = Arrays.asList(req.getParameterValues("cargos"));
                List<Long> cargosIds = new ArrayList<Long>();
                for (String cargo : cargos) {
                    cargosIds.add(Long.parseLong(cargo));
                }

                // get the list of trucks: not broken, with no order, appropriate capacity
                List<TruckDTO> truckDTOs = adminServices.getAllAvailableTrucks(cargosIds);

                // set parameters...
                req.getSession().setAttribute("truckList", truckDTOs);
                req.getSession().setAttribute("cargos", cargosIds);
                // ...and redirect to the next step page
                resp.sendRedirect("/addOrderTruck.jsp");
            }


            // step 2: get all the drivers which could be assigned to the order
            // after step 2 redirect to /addOrderDrivers.jsp
            if (step == 2) {
                // truckId shouldn't be null on this step as it was passed through the option on the form
                long truckId = Long.parseLong(req.getParameter("truck"));
                TruckDTO truck = adminServices.getTruck(truckId);
                // fill in the list of cargos ids
                List<Long> cargosIds = (List<Long>) req.getSession().getAttribute("cargos");

                // get drivers
                adminServices = new AdminServicesImpl();
                List<UserDTO> driverDTOs = adminServices.getAllAvailableDrivers(truckId, cargosIds);

                // set parameter...
                req.getSession().setAttribute("truckObj", truck);
                req.getSession().setAttribute("driverList", driverDTOs);
                // redirect to the next step page
                resp.sendRedirect("/addOrderDrivers.jsp");
            }


            // step 3: all info collected
            // this step will commit all the changes to the database
            // and will return the status of operation to user
            // after step 3 redirect to /success.jsp
            if (step == 3) {
                // check of all infos
                LOG.error("List of selected cargos:\n" + req.getSession().getAttribute("cargos"));
                LOG.error("List of selected trucks:\n" + req.getSession().getAttribute("truckObj"));
                LOG.error("List of selected drivers:\n" + req.getParameterValues("drivers"));

                // chosen cargos
                List<Long> cargos = (List<Long>) req.getSession().getAttribute("cargos");
                // chosen truck
                TruckDTO truck = (TruckDTO) req.getSession().getAttribute("truckObj");
                // chosen drivers
                // array of user ids, should exist here
                List<String> driversStr = Arrays.asList(req.getParameterValues("drivers"));
                // convert drivers from strings to long
                List<Long> drivers = new ArrayList<Long>();
                for (String driver : driversStr) {
                    drivers.add(Long.parseLong(driver));
                }

                //save into the database all the info
                OrderDTO orderDTO = adminServices.addOrder(cargos, truck, drivers);

                // if null -- error
                if (orderDTO == null) {
                    throw new Exception(">>> Exception: order was not created");
                }

                // set parameter...
                req.getSession().setAttribute("object", orderDTO.getId());
                // redirect to the next step page
                resp.sendRedirect("/success.jsp");
            }
        } catch (IOException e) {
            LOG.info("get into AddOrderServlet", e);
            resp.sendRedirect("/error.jsp");
        } catch (NumberFormatException e) {
            LOG.info("get into AddOrderServlet", e);
            resp.sendRedirect("/error.jsp");
        } catch (Exception e) {
            LOG.info("get into AddOrderServlet", e);
            resp.sendRedirect("/error.jsp");
        }
    }
}
