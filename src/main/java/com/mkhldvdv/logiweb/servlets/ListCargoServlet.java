package com.mkhldvdv.logiweb.servlets;

import com.mkhldvdv.logiweb.dto.CargoDTO;
import com.mkhldvdv.logiweb.services.impl.AdminServicesImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

/**
 * Created by mkhldvdv on 29.11.2015.
 */
public class ListCargoServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        AdminServicesImpl adminServices = new AdminServicesImpl();
        String cargoIdString = req.getParameter("cargoId");
        try {
            // search for specified cargo
            long cargoId = Long.parseLong(cargoIdString);
            CargoDTO cargoDTO = adminServices.getCargo(cargoId);
            // write session attributes
            List<CargoDTO> cargoDTOList = Arrays.asList(cargoDTO);

            req.getSession().setAttribute("cargoList", cargoDTOList);
            // redirect
            resp.sendRedirect("/listCargo.jsp");
        } catch (IOException e) {
            System.out.printf(">>> Exception: Something wrong with cargo id: %s\nCheck log file\n", cargoIdString);
            e.printStackTrace();
            req.getSession().setAttribute("error", e);
            resp.sendRedirect("/error.jsp");
        }
    }
}
