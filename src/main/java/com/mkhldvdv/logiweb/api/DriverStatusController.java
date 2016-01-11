package com.mkhldvdv.logiweb.api;

import com.mkhldvdv.logiweb.entities.User;
import com.mkhldvdv.logiweb.exceptions.WrongIdException;
import com.mkhldvdv.logiweb.services.AdminServices;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by mkhldvdv on 05.01.2016.
 */

@RestController
@RequestMapping("/drivers/status/{id}")
public class DriverStatusController {

    private static final Logger LOG = LogManager.getLogger(DriverStatusController.class);

    Map<String, Byte> statusMap = new HashMap<String, Byte>();
    {
        statusMap.put("vacant", (byte) 1);
        statusMap.put("shift", (byte) 2);
        statusMap.put("driving", (byte) 3);
    }

    @Autowired
    AdminServices adminServices;

    @RequestMapping(method = RequestMethod.POST,
                    consumes = "application/json")
    public @ResponseBody User setDriverStatus(@PathVariable long id,
                                              @RequestParam(value = "status") String status) {
        LOG.info("LogiwebController: view deleteDriver POST");

        try {
            User driver = adminServices.getUser(id);
            driver.setUserStatusId(statusMap.get(status));
            User savedDriver = adminServices.updateUser(driver, true);

            return adminServices.getUser(id);
        } catch (WrongIdException e) {
            LOG.error("LogiwebController: WrongIdException " + e.getMessage());
            LOG.error("No user found with ID: " + id);
            return null;
        }
    }

    @RequestMapping(method = RequestMethod.GET,
                    consumes = "application/json")
    public @ResponseBody User getDriverStatus(@PathVariable long id) {
        LOG.info("LogiwebController: view deleteDriver POST");

        try {
            User driver = adminServices.getUser(id);

            return driver;
        } catch (WrongIdException e) {
            LOG.error("LogiwebController: WrongIdException " + e.getMessage());
            LOG.error("No user found with ID: " + id);
            return null;
        }
    }
}
