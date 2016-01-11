package com.mkhldvdv.logiweb.api;

import com.mkhldvdv.logiweb.entities.Cargo;
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
@RequestMapping("/cargos/status/{id}")
public class CargoStatusController {

    private static final Logger LOG = LogManager.getLogger(CargoStatusController.class);

    Map<String, Byte> statusMap = new HashMap<String, Byte>();
    {
        statusMap.put("prepared", (byte) 1);
        statusMap.put("delivered", (byte) 2);
        statusMap.put("unloaded", (byte) 3);
    }

    @Autowired
    AdminServices adminServices;

    @RequestMapping(method = RequestMethod.POST,
                    consumes = "application/json")
    public @ResponseBody Cargo setCargoStatus(@PathVariable long id,
                                                 @RequestParam(value = "status") String status) {
        LOG.info("LogiwebController: view deleteDriver POST");

        Cargo cargo = adminServices.getCargoById(id);
        cargo.setCargoStatusId(statusMap.get(status));
        Cargo savedCargo = adminServices.updateCargo(cargo);

        return adminServices.getCargoById(id);
    }

    @RequestMapping(method = RequestMethod.GET,
                    consumes = "application/json")
    public @ResponseBody Cargo getCargoStatus(@PathVariable long id) {
        LOG.info("LogiwebController: view deleteDriver POST");

        Cargo cargo = adminServices.getCargoById(id);

        return cargo;
    }
}
