package com.mkhldvdv.logiweb.services.impl;

import com.mkhldvdv.logiweb.controllers.LogiwebController;
import com.mkhldvdv.logiweb.dao.impl.UserDaoImpl;
import com.mkhldvdv.logiweb.entities.Order;
import com.mkhldvdv.logiweb.entities.User;
import com.mkhldvdv.logiweb.entities.Waypoint;
import com.mkhldvdv.logiweb.services.UserServices;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Import;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Created by mkhldvdv on 25.11.2015.
 */

@Service
public class UserServicesImpl implements UserServices {

    private static final Logger LOG = LogManager.getLogger(UserServicesImpl.class);

    public static final String NOT_COMPLETE = "not complete";

    @Autowired
    private UserDaoImpl userDao;

    /**
     * returns the specified user
     *
     * @param userId specified userId, long
     * @return specified user
     */
    @Override
    public User getUser(long userId) {
        LOG.info("get user by ID");
        User user = userDao.getById(userId);
        return user;
    }

    /**
     * get user by login name
     *
     * @param login login name of the user
     * @return user
     */
    @Override
    public User getUserByLogin(String login) {
        LOG.info("get user by login name");
        User user = userDao.getUserByLogin(login);
        return user;
    }

    /**
     * gets all co-drivers for the driver with his id
     *
     * @param driverId specified driver
     * @return list of co-drivers
     */
    @Override
    public Set<Long> getCoDriversIds(long driverId) {
        LOG.info("get co-drivers");
        User user = userDao.getById(driverId);

        // fill in the list of co-drivers
        Set<Long> coDriversList = new HashSet<Long>();
        for (User driver : user.getTruck().getDrivers()) {
            coDriversList.add(driver.getId());
        }

        // remove specified user to have only co-drivers ids in the list
        coDriversList.remove(driverId);

        return coDriversList;
    }

    /**
     * gets the registration number of the truck
     *
     * @param driverId driver id
     * @return registration number
     */
    @Override
    public String getRegNum(long driverId) {
        LOG.info("get reg num");
        User user = userDao.getById(driverId);
        // get registration number and return it
        return user.getTruck().getRegNum();
    }

    /**
     * gets the list of orders for the driver
     *
     * @param driverId specified driver
     * @return list of orders
     */
    @Override
    public Set<Long> getDriversOrders(long driverId) {
        LOG.info("get drivers orders");
        User user = userDao.getById(driverId);
        Set<Long> ordersIds = new HashSet<Long>();
        // get the list of orders ids for the driver
        for (Order order : user.getOrders()) {
            ordersIds.add(order.getId());
        }

        return ordersIds;
    }

    /**
     * gets waypoints for the driver
     *
     * @param driverId specified driver
     * @return set of cities ids
     */
    @Override
    public Set<String> getDriversCities(long driverId) {
        LOG.info("get drivers cities");
        User user = userDao.getById(driverId);
        Set<String> cities = new HashSet<String>();
        // get the list of waypoint for the driver through the list of orders
        for (Order order : user.getOrders()) {
            for (Waypoint waypoint : order.getWaypoints()) {
                cities.add(waypoint.getCity());
            }
        }

        // return the list of cities ids
        return cities;
    }
}
