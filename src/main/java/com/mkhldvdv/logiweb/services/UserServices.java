package com.mkhldvdv.logiweb.services;

import com.mkhldvdv.logiweb.entities.User;
import com.mkhldvdv.logiweb.exceptions.WrongIdException;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.Set;

/**
 * Created by mkhldvdv on 25.11.2015.
 */
public interface UserServices {

    /**
     * returns the specified user
     * @param userId        specified userId, long
     * @return              specified user
     */
    public User getUser(long userId) throws WrongIdException;

    /**
     * gets all co-drivers for the driver with his id
     * @param driverId  specified driver
     * @return          list of co-drivers
     */
    public Set<Long> getCoDriversIds(long driverId);

    /**
     * gets the registration number of the truck
     * @param driverId  driver id
     * @return          registration number
     */
    public String getRegNum(long driverId);

    /**
     * gets the list of orders for the driver
     * @param driverId  specified driver
     * @return          list of orders
     */
    public Set<Long> getDriversOrders(long driverId);

    /**
     * gets waypoint for the driver
     * @param driverId  specified driver
     * @return          set of cities ids
     */
    public Set<String> getDriversCities(long driverId);

    /**
     * get user by login name
     * @param login login name of the user
     * @return      user
     */
    User getUserByLogin(String login);
}
