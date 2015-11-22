package com.mkhldvdv.logiweb.services;

import java.util.List;

/**
 * Created by mkhldvdv on 22.11.2015.
 */
public interface DriverService {

    /**
     * get the info for the driver:
     * 1. driver id
     * 2. ids of co-drivers
     * 3. regNum of the truck
     * 4. order id
     * 5. waypoints list
     *
     * @param user driver id
     * @return list of strings with the info
     */
    public List<String> getAllInfoForDriver(long user);
}
