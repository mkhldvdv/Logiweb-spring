package com.mkhldvdv.logiweb.api;

import com.mkhldvdv.logiweb.dao.impl.UserDaoImpl;
import com.mkhldvdv.logiweb.entities.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by mkhldvdv on 05.01.2016.
 */

@RestController
@RequestMapping("/drivers/{id}/status")
public class DriverStatusController {

    Map<String, Byte> statusMap = new HashMap<String, Byte>();
    {
        statusMap.put("vacant", (byte) 1);
        statusMap.put("in shift", (byte) 2);
        statusMap.put("driving", (byte) 3);
    }

    @Autowired
    UserDaoImpl userDao;

    @RequestMapping(method = RequestMethod.POST,
                    consumes = "application/json")
    public @ResponseBody
    String setDriverStatus(@PathVariable long id,
                           @RequestBody String status) {

        User driver = userDao.getById(id);
        driver.setUserStatusId(statusMap.get(status));
        User savedDriver = userDao.update(driver);

        return savedDriver.getId() + " " + savedDriver.getUserStatus();
    }

    @RequestMapping(method = RequestMethod.GET,
                    consumes = "application/json")
    public @ResponseBody
    String getDriverStatus(@PathVariable long id) {

        User driver = userDao.getById(id);

        return driver.getId() + " " + driver.getUserStatus();
    }
}
