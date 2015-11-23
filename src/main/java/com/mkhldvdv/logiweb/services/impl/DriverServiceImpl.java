package com.mkhldvdv.logiweb.services.impl;

import com.mkhldvdv.logiweb.dao.impl.DriverDaoImpl;
import com.mkhldvdv.logiweb.dao.impl.OrderDaoImpl;
import com.mkhldvdv.logiweb.dao.impl.TruckDaoImpl;
import com.mkhldvdv.logiweb.dao.impl.WaypointDaoImpl;
import com.mkhldvdv.logiweb.entities.Driver;
import com.mkhldvdv.logiweb.entities.Order;
import com.mkhldvdv.logiweb.entities.Truck;
import com.mkhldvdv.logiweb.entities.Waypoint;
import com.mkhldvdv.logiweb.services.DriverService;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by mkhldvdv on 22.11.2015.
 */
public class DriverServiceImpl implements DriverService {

    private DriverDaoImpl driverDaoImpl;
    private OrderDaoImpl orderDaoImpl;
    private TruckDaoImpl truckDaoImpl;
    private WaypointDaoImpl waypointDaoImpl;

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
    @Override
    public List<String> getAllInfoForDriver(long user) {
        List<String> allInfo = new ArrayList<String>();
        // 1. driver id
        allInfo.add(Long.toString(user));

        // 2. ids of co-drivers
        Driver driver = driverDaoImpl.getByUserId(user);
        Truck truck = driver.getTruck();
        List<Driver> driverList = driverDaoImpl.getByTruckId(truck.getId());
        // remove current driver from the list
        boolean isRemoved = driverList.remove(driver);
        StringBuilder sb = new StringBuilder();
        // adds the rest of the drivers to string for the driver
        for (Driver tmpDriver : driverList) {
            sb.append(Long.toString(tmpDriver.getId())).append(" ");
        }
        allInfo.add(sb.toString());

        // 3. regNum of the truck
        allInfo.add(truck.getRegNum());

        // 4. order id
        Order order = orderDaoImpl.getOrderByTruckId(truck.getId());
        allInfo.add(Long.toString(order.getId()));

        // 5. waypoints list
        sb = new StringBuilder();
        List<Waypoint> waypointList = waypointDaoImpl.getWayPointsByOrderId(order.getId());
        for (Waypoint waypoint : waypointList) {
            sb.append(waypoint.getCity().getCityName()).append(" ");
        }
        allInfo.add(sb.toString());

        return allInfo;
    }
}