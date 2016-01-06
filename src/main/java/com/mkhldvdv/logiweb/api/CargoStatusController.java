package com.mkhldvdv.logiweb.api;

import com.mkhldvdv.logiweb.dao.impl.CargoDaoImpl;
import com.mkhldvdv.logiweb.entities.Cargo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by mkhldvdv on 05.01.2016.
 */

@RestController
@RequestMapping("/cargos/{id}/status")
public class CargoStatusController {

    Map<String, Byte> statusMap = new HashMap<String, Byte>();
    {
        statusMap.put("prepared", (byte) 1);
        statusMap.put("delivered", (byte) 2);
        statusMap.put("unloaded", (byte) 3);
    }

    @Autowired
    CargoDaoImpl cargoDao;

    @RequestMapping(method = RequestMethod.POST,
                    consumes = "application/json")
    public @ResponseBody
    String setCargoStatus(@PathVariable long id,
                          @RequestBody String status) {

        Cargo cargo = cargoDao.getById(id);
        cargo.setCargoStatusId(statusMap.get(status));
        Cargo savedCargo = cargoDao.update(cargo);

        return savedCargo.getId() + " " + savedCargo.getCargoStatus();
    }

    @RequestMapping(method = RequestMethod.GET,
                    consumes = "application/json")
    public @ResponseBody
    String getCargoStatus(@PathVariable long id) {

        Cargo cargo = cargoDao.getById(id);

        return cargo.getId() + " " + cargo.getCargoStatus();
    }
}
