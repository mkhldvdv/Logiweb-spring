package com.mkhldvdv.logiweb.controllers;

import com.mkhldvdv.logiweb.dto.CargoDTO;
import com.mkhldvdv.logiweb.dto.OrderDTO;
import com.mkhldvdv.logiweb.entities.*;
import com.mkhldvdv.logiweb.exceptions.WrongIdException;
import com.mkhldvdv.logiweb.services.AdminServices;
import com.mkhldvdv.logiweb.services.UserServices;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

/**
 * Created by mkhldvdv on 25.12.2015.
 */

@Controller
public class LogiwebController {

    private static final Logger LOG = LogManager.getLogger(LogiwebController.class);

    @Autowired
    private UserServices userServices;

    @Autowired
    private AdminServices adminServices;

    @RequestMapping(value = {"/", "/welcome"}, method = RequestMethod.GET)
    public String viewLoginPage() {
        LOG.info("LogiwebController: view welcome page");
        return "welcome";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String viewLogin() {
        LOG.info("LogiwebController: view login");
        return "login";
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logoutPage(HttpServletRequest request, HttpServletResponse response) {
        LOG.info("LogiwebController: logout");
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            new SecurityContextLogoutHandler().logout(request, response, auth);
        }
        return "redirect:/welcome?logout";
    }

    //
    // users actions
    //
    @RequestMapping(value = "/AccessDenied", method = RequestMethod.GET)
    public String accessDeniedPage() {
        LOG.info("LogiwebController: view AccessDenied");
        return "AccessDenied";
    }

    @RequestMapping(value = "/info", method = RequestMethod.GET)
    public String viewInfo() {
        LOG.info("LogiwebController: view info");
        return "info";
    }

    @RequestMapping(value = {"/userProfile"}, method = RequestMethod.GET)
    public String viewUserProfile(HttpServletRequest request, Model model) {
        LOG.info("LogiwebController: view userProfile");
        // get users profile info
        getUsersProfileInfo(request, model);
        return "userProfile";
    }

    /**
     * get user profile info
     * @param request   http request
     * @param model     model for adding the attribute
     */
    private void getUsersProfileInfo(HttpServletRequest request, Model model) {
        String login = request.getUserPrincipal().getName();
        User user = userServices.getUserByLogin(login);
        model.addAttribute("myUser", user);
    }

    @RequestMapping(value = {"/addCargo"}, method = RequestMethod.GET)
    public String viewAddCargo(Model model) {
        LOG.info("LogiwebController: view addCargo GET");

        Cargo cargo = new Cargo();
        model.addAttribute("cargo", cargo);

        return "addCargo";
    }

    @RequestMapping(value = {"/addCargo"}, method = RequestMethod.POST)
    public String addCargo(@ModelAttribute("cargo") Cargo cargo, Model model,
                               @RequestParam("cityLoad") long cityLoad, @RequestParam("cityUnload") long cityUnload) {
        LOG.info("LogiwebController: view addCargo POST");

        cargo.setWaypoints(new ArrayList<Waypoint>());
        // where to load waypoint
        Waypoint load = new Waypoint();
        load.setCargoTypeId((byte) 1);
        load.setCityId(cityLoad);
        // where to unload waypoint
        Waypoint unLoad = new Waypoint();
        unLoad.setCargoTypeId((byte) 2);
        unLoad.setCityId(cityUnload);

        // add waypoints to cargo
        cargo.getWaypoints().add(load);
        cargo.getWaypoints().add(unLoad);

        // add new cargo
        Cargo newCargo = adminServices.addCargo(cargo);

        model.addAttribute("object", newCargo.getId());

        return "success";
    }

    @RequestMapping(value = {"/addDriver"}, method = RequestMethod.GET)
    public String viewAddDriver(@ModelAttribute("user") User user, Model model) {
        LOG.info("LogiwebController: view addDriver");

        if (user == null) {
            user = new User();
        }
        model.addAttribute("user", user);
        return "addDriver";
    }

    @RequestMapping(value = "/addEditUser", method = RequestMethod.POST)
    public String addEditUser(@ModelAttribute("user") @Valid User user,
                          BindingResult result, Model model, @RequestParam("pass") String pass) {
        LOG.info("LogiwebController: view addEditUser POST");

        try {
            String urlString = "success";

            if (result.hasErrors()) {
                return "addDriver";
            }

            User newUser;
            if (user.getId() == 0) {
                newUser = adminServices.addUser(user);
            } else {
                // find the user first and if its null then catch the exception and show the error
                User updatedUser = adminServices.getUser(user.getId());
                // check if password was changed or nor
                if (pass.equals(user.getPassword())) {
                    newUser = adminServices.updateUser(user, true);
                } else {
                    newUser = adminServices.updateUser(user, false);
                }
            }
            model.addAttribute("object", newUser.getId());

            return urlString;
        } catch (DataIntegrityViolationException e) {
        LOG.error("LogiwebController: DataIntegrityViolationException " + e.getMessage());
        model.addAttribute("error", "Not unique login name");
        return "error";
    } catch (WrongIdException e) {
        LOG.error("LogiwebController: WrongIdException " + e.getMessage());
        model.addAttribute("error", "No user found with ID: " + user.getId());
        return "error";
    }
    }

    @RequestMapping(value = {"/addOrder"}, method = RequestMethod.GET)
    public String viewAddOrder(Model model) {

        LOG.info("LogiwebController: view addOrder GET");

        List<Cargo> cargos = adminServices.getAllUnassignedCargos();
        model.addAttribute("cargos", cargos);

        return "addOrder";
    }

    @RequestMapping(value = {"/addOrder"}, method = RequestMethod.POST)
    public String addOrder(@RequestParam("drivers") List<Long> driverIds,
                           @RequestParam("truck") String truckString,
                           @RequestParam("cargos") String cargoString,
                           Model model) {
        LOG.info("LogiwebController: view addOrder POST");

        // transfer truckId from string to long
        Long truckId = Long.parseLong(truckString);
        try {
            // get the truck
            Truck truck = adminServices.getTruck(truckId);

            // transfer cargos from string to longs
            List<Long> cargoIds = getCargoIdsFromString(cargoString);

            // finally add new order
            Order newOrder = adminServices.addOrder(cargoIds, truck, driverIds);
            model.addAttribute("object", newOrder.getId());

            return "success";
        } catch (WrongIdException e) {
            LOG.error("LogiwebController: WrongIdException " + e.getMessage());
            model.addAttribute("error", "No truck found with ID: " + truckId);
            return "error";
        }
    }

    /**
     * parse string with cargoIDs to array of cargoIDs
     * @param cargoString   string of cargoIDs
     * @return              array list of cargoIDs
     */
    private List<Long> getCargoIdsFromString(String cargoString) {
        LOG.info("LogiwebController: getCargoIdsFromString(" + cargoString + ")");

        cargoString = cargoString.substring(1, cargoString.length() - 1);
        String[] cargoStringSplitted = cargoString.split(", ");
        List<Long> cargoIds = new ArrayList<Long>();
        for (String s : cargoStringSplitted) {
            cargoIds.add(Long.parseLong(s));
        }
        return cargoIds;
    }

    @RequestMapping(value = {"/addOrderDrivers"}, method = RequestMethod.POST)
    public String addOrderDrivers(@RequestParam("truck") long truckId,
                                  @RequestParam("cargos") String cargoString,
                                  Model model) {
        LOG.info("LogiwebController: view addOrderDrivers POST");

        try {
            // transfer cargos from string to longs
            List<Long> cargoIds = getCargoIdsFromString(cargoString);

            List<User> drivers = adminServices.getAllAvailableDrivers(truckId, cargoIds);
            Truck truck = adminServices.getTruck(truckId);
            model.addAttribute("cargos", cargoIds);
            model.addAttribute("truck", truck);
            model.addAttribute("drivers", drivers);

            return "addOrderDrivers";
        } catch (WrongIdException e) {
            LOG.error("LogiwebController: WrongIdException " + e.getMessage());
            model.addAttribute("error", "No truck found with ID: " + truckId);
            return "error";
        }
    }

//    @RequestMapping(value = {"/addOrderTruck"}, method = RequestMethod.GET)
//    public String addTruckToOrder(@ModelAttribute("cargoIds") ArrayList<Long> cargoIds,
//                                  @ModelAttribute("trucks") ArrayList<Truck> trucks,
//                                  Model model) {
//
//        model.addAttribute("trucks", trucks);
//        model.addAttribute("cargoIds", cargoIds);
//
//        return "addOrderTruck";
//    }

    @RequestMapping(value = {"/addOrderTruck"}, method = RequestMethod.POST)
    public String viewAddOrderTruck(@RequestParam("cargos") List<Long> cargoIds,
                                    Model model) {
        LOG.info("LogiwebController: view addOrderTruck POST");

        List<Truck> trucks = adminServices.getAllAvailableTrucks(cargoIds);
        model.addAttribute("trucks", trucks);
        model.addAttribute("cargos", cargoIds);

        return "addOrderTruck";
    }

    @RequestMapping(value = {"/addTruck"}, method = RequestMethod.GET)
    public String viewAddTruck(@ModelAttribute("truck") Truck truck, Model model) {
        LOG.info("LogiwebController: view addTruck");

        if (truck == null) {
            truck = new Truck();
        }
        model.addAttribute("truck", truck);
        return "addTruck";
    }

    @RequestMapping(value = "/addEditTruck", method = RequestMethod.POST)
    public String addEditTruck(@ModelAttribute("truck") @Valid Truck truck,
                              BindingResult result, Model model) {
        LOG.info("LogiwebController: view addEditTruck POST");

        try {
            String urlString = "success";

            if (result.hasErrors()) {
                return "addTruck";
            }

            Truck newTruck;
            if (truck.getId() == 0) {
                newTruck = adminServices.addTruck(truck);
            } else {
                // find the truck first and if its null the catch the exception and show the error
                Truck updatedTruck = adminServices.getTruck(truck.getId());

                newTruck = adminServices.updateTruck(truck);
            }
            model.addAttribute("object", newTruck.getId());

            return urlString;
        } catch (DataIntegrityViolationException e) {
            LOG.error("LogiwebController: DataIntegrityViolationException " + e.getMessage());
            model.addAttribute("error", "Not unique registration number");
            return "error";
        } catch (WrongIdException e) {
            LOG.error("LogiwebController: WrongIdException " + e.getMessage());
            model.addAttribute("error", "No truck found with ID: " + truck.getId());
            return "error";
        }
    }

    @RequestMapping(value = {"/deleteDriver"}, method = RequestMethod.GET)
    public String viewDeleteDriver() {
        LOG.info("LogiwebController: view deleteDriver");
        return "deleteDriver";
    }

    @RequestMapping(value = {"/deleteDriver"}, method = RequestMethod.POST)
    public String deleteUser(@RequestParam("driverId") long userId, Model model) {

        LOG.info("LogiwebController: view deleteDriver POST");

        // check if the user exists and if not, show the error
        try {
            User user = adminServices.getNotDeletedUser(userId);
            // check if user has constraints
            if (user.getTruck() != null) {
                throw new DataIntegrityViolationException("User has constraints, delete it logically");
            }

            adminServices.deleteUser(userId);
            model.addAttribute("object", userId);
            return "success";
        } catch (WrongIdException e) {
            LOG.error("LogiwebController: WrongIdException " + e.getMessage());
            model.addAttribute("error", "No user found with ID: " + userId);
            return "error";
        } catch (DataIntegrityViolationException e) {
            // truck has active constraints
            // delete it logically
            LOG.error("LogiwebController: DataIntegrityViolationException " + e.getMessage());
            LOG.error("LogiwebController: deleted flag for the user set to up");
            try {
                User user = adminServices.getNotDeletedUser(userId);
                // logical delete
//                user.setTruck(null);
                user.setDeleted((byte) 1);
                User deletedUser = adminServices.updateUser(user, true);
                model.addAttribute("object", userId);
                return "success";
            } catch (WrongIdException e1) {
                // truck surely exists here, no actions required
                // but in case smth goes really wrong
                model.addAttribute("error", "Something really wrong with user ID: " + userId + ", please check logs");
                return "error";
            }
        }
    }

    @RequestMapping(value = {"/deleteTruck"}, method = RequestMethod.GET)
    public String viewDeleteTruck() {
        LOG.info("LogiwebController: view deleteTruck GET");
        return "deleteTruck";
    }

    @RequestMapping(value = {"/deleteTruck"}, method = RequestMethod.POST)
    public String deleteTruck(@RequestParam("truckId") long truckId, Model model) {

        LOG.info("LogiwebController: view deleteTruck POST");
        // check if the truck exists and if not, show the error
        try {
            Truck truck = adminServices.getNotDeletedTruck(truckId);

            adminServices.deleteTruck(truckId);
            model.addAttribute("object", truckId);
            return "success";
        } catch (WrongIdException e) {
            LOG.error("LogiwebController: WrongIdException " + e.getMessage());
            model.addAttribute("error", "No truck found with ID: " + truckId);
            return "error";
        } catch (DataIntegrityViolationException e) {
            // truck has active constraints
            // delete it logically
            LOG.error("LogiwebController: DataIntegrityViolationException " + e.getMessage());
            LOG.error("LogiwebController: deleted flag for the truck set to up ");
            try {
                Truck truck = adminServices.getNotDeletedTruck(truckId);
                truck.setDeleted((byte) 1);
                Truck deletedTruck = adminServices.updateTruck(truck);
                model.addAttribute("object", truckId);
                return "success";
            } catch (WrongIdException e1) {
                // truck surely exists here, no actions required
                // but in case smth goes really wrong
                model.addAttribute("error", "Something really wrong with truck ID: " + truckId + ", please check logs");
                return "error";
            }
        }
    }

    @RequestMapping(value = {"/editDriver"}, method = RequestMethod.GET)
    public String viewEditDriver() {
        LOG.info("LogiwebController: view editDriver GET");
        return "editDriver";
    }

    @RequestMapping(value = {"/editDriver"}, method = RequestMethod.POST)
    public String editDriver(@RequestParam("driverId") long driverId, Model model) {

        LOG.info("LogiwebController: view editDriver POST");

        User user = userServices.getUser(driverId);
        model.addAttribute("user", user);

        return "addDriver";
    }

    @RequestMapping(value = {"/editTruck"}, method = RequestMethod.GET)
    public String viewEditTruck() {
        LOG.info("LogiwebController: view editTruck GET");
        return "editTruck";
    }

    @RequestMapping(value = {"/editTruck"}, method = RequestMethod.POST)
    public String editTruck(@RequestParam("truckId") long truckId, Model model) {
        LOG.info("LogiwebController: view editTruck POST");

        try {
            Truck truck = adminServices.getTruck(truckId);
            model.addAttribute("truck", truck);

            return "addTruck";
        } catch (WrongIdException e) {
            LOG.error("LogiwebController: WrongIdException " + e.getMessage());
            model.addAttribute("error", "No truck found with ID: " + truckId);
            return "error";
        }
    }

    @RequestMapping(value = {"/error"}, method = RequestMethod.GET)
    public String viewError() {
        LOG.info("LogiwebController: view error page");
        return "error";
    }

    @RequestMapping(value = {"/findCargo"}, method = RequestMethod.GET)
    public String viewFindCargo() {
        LOG.info("LogiwebController: view findCargo");
        return "findCargo";
    }

    @RequestMapping(value = {"/findOrder"}, method = RequestMethod.GET)
    public String viewFindOrder() {
        LOG.info("LogiwebController: view findOrder");
        return "findOrder";
    }

    @RequestMapping(value = {"/listCargo"}, method = RequestMethod.POST)
    public String viewListCargo(@RequestParam("cargoId") long cargoId, Model model) {
        LOG.info("LogiwebController: view findOrder POST");

        try {
            CargoDTO cargoDTO = adminServices.getCargo(cargoId);
            model.addAttribute("cargo", cargoDTO);
            return "listCargo";
        } catch (WrongIdException e) {
            LOG.error("LogiwebController: WrongIdException " + e.getMessage());
            model.addAttribute("error", "No cargo found with ID: " + cargoId);
            return "error";
        }
    }

    @RequestMapping(value = {"/listDrivers"}, method = RequestMethod.GET)
    public String viewListDrivers(Model model) {
        LOG.info("LogiwebController: view listDrivers");
        // get all drivers
        List<User> drivers = adminServices.getDrivers();
        model.addAttribute("driversList", drivers);
        return "listDrivers";
    }

    @RequestMapping(value = {"/listOneOrder"}, method = RequestMethod.GET)
    public String viewListOneOrder() {
        LOG.info("LogiwebController: view listOneOrder");
        return "listOneOrder";
    }

    @RequestMapping(value = {"/listOrders"}, method = RequestMethod.GET)
    public String viewListOrders(Model model) {
        LOG.info("LogiwebController: view listOrders");
        // get list of all orders
        List<OrderDTO> orders = adminServices.getOrders();
        model.addAttribute("ordersList", orders);
        return "listOrders";
    }

    @RequestMapping(value = {"/listOrders"}, method = RequestMethod.POST)
    public String viewOrder(@RequestParam("orderId") long orderId, RedirectAttributes redir, Model model) {
        LOG.info("LogiwebController: view listOneOrder");
        // get list of all orders
        try {
            OrderDTO orderDTO = adminServices.getOrder(orderId);
            redir.addFlashAttribute("ordersList", orderDTO);
            return "redirect:/listOneOrder";
        } catch (WrongIdException e) {
            LOG.error("LogiwebController: WrongIdException " + e.getMessage());
            model.addAttribute("error", "No order found with ID: " + orderId);
            return "error";
        }
    }

    @RequestMapping(value = {"/listTrucks"}, method = RequestMethod.GET)
    public String viewListTrucks(Model model) {
        LOG.info("LogiwebController: view listTrucks");
        // get list of all trucks
        List<Truck> trucks = adminServices.getTrucks();
        model.addAttribute("trucksList", trucks);
        return "listTrucks";
    }

    @RequestMapping(value = {"/success"}, method = RequestMethod.GET)
    public String viewSuccess() {
        LOG.info("LogiwebController: view success page");
        return "success";
    }

    //
    // drivers actions
    //
    @RequestMapping(value = "/infoDriver", method = RequestMethod.GET)
    public String viewInfoDriver() {
        LOG.info("LogiwebController: view infoDriver");
        return "infoDriver";
    }

    @RequestMapping(value = "/infoForDriver", method = RequestMethod.POST)
    public String viewInfoForDriver(HttpServletRequest request,
                                    @RequestParam("driverId") long driverId,
                                    Model model) {
        LOG.info("LogiwebController: view infoForDriver");

        try {
            User driver = userServices.getUser(driverId);
            // if there is no such user in the database then fail
            if (driver == null) {
                throw new WrongIdException("No user found with ID: " + driverId);
            }
            // if this is not current driver, then fail
            if (!driver.getLogin().equals(request.getUserPrincipal().getName())) {
                model.addAttribute("error", "You are not allowed to get the info about other users");
                return "errorDriver";
            }

            Set<Long> coDrivers = userServices.getCoDriversIds(driverId);
            String regNum = userServices.getRegNum(driverId);
            Set<Long> orders = userServices.getDriversOrders(driverId);
            Set<String> cities = userServices.getDriversCities(driverId);

            model.addAttribute("driver", driverId);
            model.addAttribute("coDrivers", coDrivers);
            model.addAttribute("regNum", regNum);
            model.addAttribute("orders", orders);
            model.addAttribute("cities", cities);

            return "infoForDriver";
        } catch (WrongIdException e) {
            LOG.error("LogiwebController: WrongIdException " + e.getMessage());
            model.addAttribute("error", "No user found with ID: " + driverId);
            return "errorDriver";
        }
    }

    @RequestMapping(value = "/driverProfile", method = RequestMethod.GET)
    public String viewDriverProfile(HttpServletRequest request, Model model) {
        LOG.info("LogiwebController: view driverProfile");
        // get drivers profile info
        getUsersProfileInfo(request, model);
        return "driverProfile";
    }

    @RequestMapping(value = "/errorDriver", method = RequestMethod.GET)
    public String viewErrorDriver() {
        LOG.info("LogiwebController: view errorDriver page");
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


    /**
     * encoder for passwords
     * just for checking
     */
//    public static class PasswordEncoderGenerator {
//
//        public static void main(String[] args) {
//            LOG.info("LogiwebController: PasswordEncoderGenerator");
//
//            String password = "admin";
//            BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
//            String hashedPassword = passwordEncoder.encode(password);
//
//            System.out.println(hashedPassword);
//
//            password = "driver";
//            hashedPassword = passwordEncoder.encode(password);
//
//            System.out.println(hashedPassword);
//        }
//    }
}
