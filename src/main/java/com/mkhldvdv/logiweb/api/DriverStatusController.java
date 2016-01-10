package com.mkhldvdv.logiweb.api;

import com.mkhldvdv.logiweb.entities.User;
import com.mkhldvdv.logiweb.services.AdminServices;
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

        User driver = adminServices.getUser(id);
        driver.setUserStatusId(statusMap.get(status));
        User savedDriver = adminServices.updateUser(driver, true);

        return adminServices.getUser(id);
    }

    @RequestMapping(method = RequestMethod.GET,
                    consumes = "application/json")
    public @ResponseBody User getDriverStatus(@PathVariable long id) {

        User driver = adminServices.getUser(id);

        return driver;
    }
}
