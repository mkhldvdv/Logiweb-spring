package com.mkhldvdv.logiweb.controllers;

import com.mkhldvdv.logiweb.entities.User;
import com.mkhldvdv.logiweb.services.UserServices;
import com.mkhldvdv.logiweb.services.impl.UserServicesImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Set;

/**
 * Created by mkhldvdv on 25.12.2015.
 */

@Controller
public class LogiwebController {

    @Autowired
    private UserServices userServices;

    @RequestMapping(value = {"/", "/welcome"}, method = RequestMethod.GET)
    public String viewLoginPage() {
//    public String viewLoginPage(Model model) {
//        User user = new User();
//        model.addAttribute("loginForm", user);
        return "welcome";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String veiwLogin() {
        return "login";
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logoutPage(HttpServletRequest request, HttpServletResponse response) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            new SecurityContextLogoutHandler().logout(request, response, auth);
        }
//        return "redirect:/welcome";
        return "redirect:/welcome?logout";
    }

    //
    // users actions
    //
    @RequestMapping(value = "/AccessDenied", method = RequestMethod.GET)
    public String accessDeniedPage() {
        return "AccessDenied";
    }

    @RequestMapping(value = "/info", method = RequestMethod.GET)
    public String veiwInfo() {
        return "info";
    }

    @RequestMapping(value = {"/userProfile"}, method = RequestMethod.GET)
    public String viewUserProfile() {
        return "userProfile";
    }

    @RequestMapping(value = {"/addCargo"}, method = RequestMethod.GET)
    public String viewAddCargo() {
        return "addCargo";
    }

    @RequestMapping(value = {"/addDriver"}, method = RequestMethod.GET)
    public String viewAddDriver() {
        return "addDriver";
    }

    @RequestMapping(value = {"/addOrder"}, method = RequestMethod.GET)
    public String viewAddOrder() {
        return "addOrder";
    }

    @RequestMapping(value = {"/addOrderDrivers"}, method = RequestMethod.GET)
    public String viewAddOrderDrivers() {
        return "addOrderDrivers";
    }

    @RequestMapping(value = {"/addOrderTruck"}, method = RequestMethod.GET)
    public String viewAddOrderTruck() {
        return "addOrderTruck";
    }

    @RequestMapping(value = {"/addTruck"}, method = RequestMethod.GET)
    public String viewAddTruck() {
        return "addTruck";
    }

    @RequestMapping(value = {"/deleteDriver"}, method = RequestMethod.GET)
    public String viewDeleteDriver() {
        return "deleteDriver";
    }

    @RequestMapping(value = {"/deleteTruck"}, method = RequestMethod.GET)
    public String viewDeleteTruck() {
        return "deleteTruck";
    }

    @RequestMapping(value = {"/editDriver"}, method = RequestMethod.GET)
    public String viewEditDriver() {
        return "editDriver";
    }

    @RequestMapping(value = {"/editTruck"}, method = RequestMethod.GET)
    public String viewEditTruck() {
        return "editTruck";
    }

    @RequestMapping(value = {"/error"}, method = RequestMethod.GET)
    public String viewError() {
        return "error";
    }

    @RequestMapping(value = {"/findCargo"}, method = RequestMethod.GET)
    public String viewFindCargo() {
        return "findCargo";
    }

    @RequestMapping(value = {"/findOrder"}, method = RequestMethod.GET)
    public String viewFindOrder() {
        return "findOrder";
    }

    @RequestMapping(value = {"/listCargo"}, method = RequestMethod.GET)
    public String viewListCargo() {
        return "listCargo";
    }

    @RequestMapping(value = {"/listDrivers"}, method = RequestMethod.GET)
    public String viewListDrivers() {
        return "listDrivers";
    }

    @RequestMapping(value = {"/listOneOrder"}, method = RequestMethod.GET)
    public String viewListOneOrder() {
        return "listOneOrder";
    }

    @RequestMapping(value = {"/listOrders"}, method = RequestMethod.GET)
    public String viewListOrders() {
        return "listOrders";
    }

    @RequestMapping(value = {"/listTrucks"}, method = RequestMethod.GET)
    public String viewListTrucks() {
        return "listTrucks";
    }

    @RequestMapping(value = {"/success"}, method = RequestMethod.GET)
    public String viewSuccess() {
        return "success";
    }

    //
    // drivers actions
    //
    @RequestMapping(value = "/infoDriver", method = RequestMethod.GET)
    public String veiwInfoDriver() {
        return "infoDriver";
    }

    @RequestMapping(value = "/infoForDriver", method = RequestMethod.POST)
    public String viewInfoForDriver(@RequestParam("driverId") long driverId, Model model) {

//        long driverId = driver.getId();

        List<Long> coDrivers = userServices.getCoDriversIds(driverId);
        String regNum = userServices.getRegNum(driverId);
        Set<Long> orders = userServices.getDriversOrders(driverId);
        Set<Byte> cities = userServices.getDriversCities(driverId);

        model.addAttribute("driver", driverId);
        model.addAttribute("coDrivers", coDrivers);
        model.addAttribute("regNum", regNum);
        model.addAttribute("orders", orders);
        model.addAttribute("cities", cities);

        return "infoForDriver";
    }

    @RequestMapping(value = "/driverProfile", method = RequestMethod.GET)
    public String viewDriverProfile(HttpServletRequest request, Model model) {
        // get drivers profile info
        String login = request.getUserPrincipal().getName();
        User driver = userServices.getUserByLogin(login);
        model.addAttribute("myUser", driver);
        return "driverProfile";
    }

    @RequestMapping(value = "/errorDriver", method = RequestMethod.GET)
    public String viewErrorDriver() {
        return "errorDriver";
    }

//    @RequestMapping(value = "/login", method = RequestMethod.POST)
//    public String doLogin(@ModelAttribute("loginForm") @Valid User user,
//                          BindingResult result, Model model) {
////        String urlString = "info";
//        String urlString = "redirect:/info";
//
//        if (result.hasErrors()) {
//            urlString = "login";
//        }
//
//        return urlString;
//    }

    public static class PasswordEncoderGenerator {

        public static void main(String[] args) {


            String password = "admin";
            BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
            String hashedPassword = passwordEncoder.encode(password);

            System.out.println(hashedPassword);

            password = "driver";
            hashedPassword = passwordEncoder.encode(password);

            System.out.println(hashedPassword);
        }
    }
}
