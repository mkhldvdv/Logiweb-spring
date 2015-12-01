package com.mkhldvdv.logiweb.services;

import com.mkhldvdv.logiweb.dto.UserDTO;
import com.mkhldvdv.logiweb.entities.Order;
import com.mkhldvdv.logiweb.entities.User;
import com.mkhldvdv.logiweb.entities.Waypoint;
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
     * returns user by login name and password
     * @param login login name
     * @param pass  password
     * @return      specified user
     */
    public UserDTO getUser(String login, String pass) throws UnsupportedEncodingException, NoSuchAlgorithmException;

    /**
     * returns the specified user
     * @param userId        specified userId, long
     * @return              specified user
     */
    public UserDTO getUser(long userId);

    /**
     * gets all co-drivers for the driver with his id
     * @param driverId  specified driver
     * @return          list of co-drivers
     */
    public List<Long> getCoDriversIds(long driverId);

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
    public List<Long> getDriversOrders(long driverId);

    /**
     * gets waypoint for the driver
     * @param driverId  specified driver
     * @return          set of cities ids
     */
    public Set<Byte> getDriversCities(long driverId);

}
