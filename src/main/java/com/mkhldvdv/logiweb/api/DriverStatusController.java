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
@RequestMapping("/drivers")
public class DriverStatusController {

    Map<String, Byte> statusMap = new HashMap<String, Byte>();
    {
        statusMap.put("vacant", (byte) 1);
        statusMap.put("in shift", (byte) 2);
        statusMap.put("driving", (byte) 3);
    }

    @Autowired
    UserDaoImpl userDao;

    @RequestMapping(value = "/{id}",
                    method = RequestMethod.POST,
                    consumes = "application/json",
                    params = "status")
    public @ResponseBody
    User setDriverStatus(@PathVariable long driverId,
                         @RequestParam(value = "status") String status) {

        User driver = userDao.getById(driverId);
        driver.setUserStatusId(statusMap.get(status));
        User savedDriver = userDao.update(driver);

        return savedDriver;
    }
}
