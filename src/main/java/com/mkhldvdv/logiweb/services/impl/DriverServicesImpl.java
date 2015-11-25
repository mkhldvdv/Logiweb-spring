package com.mkhldvdv.logiweb.services.impl;

import com.mkhldvdv.logiweb.dao.impl.OrderDaoImpl;
import com.mkhldvdv.logiweb.dao.impl.UserDaoImpl;
import com.mkhldvdv.logiweb.entities.Order;
import com.mkhldvdv.logiweb.entities.Truck;
import com.mkhldvdv.logiweb.entities.User;
import com.mkhldvdv.logiweb.entities.Waypoint;
import com.mkhldvdv.logiweb.services.DriverServices;

import java.util.List;

/**
 * Created by mkhldvdv on 25.11.2015.
 */
public class DriverServicesImpl implements DriverServices {

    private UserDaoImpl userDao;

    /**
     * return the list of co-drivers
     *
     * @param driverId specified driver id
     * @return the list of co-drivers
     */
    @Override
    public List<User> getCoDrivers(long driverId) {
        Order order = userDao.getById(driverId).getOrder();
        return order.getDrivers();
    }

    /**
     * return the regNum of specified truck
     *
     * @param driverId specified driver id
     * @return registration number
     */
    @Override
    public String getTruckRegNum(long driverId) {
        Truck truck = userDao.getById(driverId).getTruck();
        return truck.getRegNum();
    }

    /**
     * return the list of waypoints
     *
     * @param driverId specified driver id
     * @return the list of waypoints
     */
    @Override
    public List<Waypoint> getListOfWaypoints(long driverId) {
        Order order = userDao.getById(driverId).getOrder();
        return order.getWaypoints();
    }
}
