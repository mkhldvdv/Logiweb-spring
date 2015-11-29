package com.mkhldvdv.logiweb.services.impl;

import com.mkhldvdv.logiweb.dao.impl.UserDaoImpl;
import com.mkhldvdv.logiweb.dto.UserDTO;
import com.mkhldvdv.logiweb.entities.Order;
import com.mkhldvdv.logiweb.entities.User;
import com.mkhldvdv.logiweb.entities.Waypoint;
import com.mkhldvdv.logiweb.exceptions.WrongIdException;
import com.mkhldvdv.logiweb.exceptions.WrongLoginPass;
import com.mkhldvdv.logiweb.services.PersistenceManager;
import com.mkhldvdv.logiweb.services.UserServices;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Created by mkhldvdv on 25.11.2015.
 */
public class UserServicesImpl implements UserServices {

    public static final String NOT_COMPLETE = "not complete";
    private EntityManagerFactory emf = PersistenceManager.getInstance().getEntityManagerFactory();
    private UserDaoImpl userDao;

    {
        EntityManager em = emf.createEntityManager();
        userDao = new UserDaoImpl();
        userDao.setEm(em);
    }

    /**
     * returns user by login name and password
     *
     * @param login login name
     * @param pass  password
     * @return specified user
     */
    @Override
    public UserDTO getUser(String login, String pass) {

        try {
            User user = userDao.getUserByLoginPassword(login, pass);
            // check user exists
            if (user == null) {
                throw new WrongLoginPass("Exception: No user exists");
            }

            UserDTO userDTO = new UserDTO(user.getId(), user.getFisrtName(), user.getLastName(),
                    user.getLogin(), user.getPassword(), user.getRole(), user.getHours(),
                    user.getUserStatus(), user.getCity(), user.getTruck(), user.getOrders(), user.isDeleted());
            return userDTO;

        } catch (WrongLoginPass wrongLoginPass) {
            return null;
        } finally {
            userDao.getEm().close();
        }
    }

    /**
     * returns list of co-drivers for the specified driver
     *
     * @param driverId specified driver
     * @return list of co-drivers
     */
    @Override
    public List<User> getCoDrivers(long driverId) throws WrongIdException {
        User user = userDao.getById(driverId);
        // if driver doesn't exit
        if (user == null) throw new WrongIdException("Wrong driver id");

        List<User> drivers = user.getTruck().getDrivers();
        List<User> coDrivers = new ArrayList<User>();
        for (User driver : drivers) {
            if (driver.getId() != driverId) coDrivers.add(driver);
        }
        return coDrivers;
    }

    /**
     * returns registration number of the truck
     *
     * @param driverId driver's personal number
     * @return reg number of the truck
     */
    @Override
    public String getTruckRegNum(long driverId) throws WrongIdException {
        User user = userDao.getById(driverId);
        // if driver doesn't exit
        if (user == null) throw new WrongIdException("Wrong driver id");
        return user.getTruck().getRegNum();
    }

    /**
     * returns the list of all open assigned orders for the driver
     *
     * @param driverId driver's id
     * @return list of open assigned orders
     */
    @Override
    public List<Order> getOrderNumbers(long driverId) throws WrongIdException {
        return getNotCompleteOrders(driverId);
    }

    /**
     * returns not complete orders for the driver
     *
     * @param driverId driver's id
     * @return list of not complete orders
     */
    private List<Order> getNotCompleteOrders(long driverId) throws WrongIdException {
        User user = userDao.getById(driverId);
        // if driver doesn't exit
        if (user == null) throw new WrongIdException("Wrong driver id");

        List<Order> orders = user.getOrders();
        List<Order> notCompleteOrders = new ArrayList<Order>();
        for (Order order : orders) {
            if (NOT_COMPLETE.equals(order.getOrderStatus())) notCompleteOrders.add(order);
        }
        return notCompleteOrders;
    }

    /**
     * get list of waypoints
     *
     * @param driverId driver's id
     * @return list of waypoints
     */
    @Override
    public Set<Waypoint> getWaypoints(long driverId) throws WrongIdException {
        List<Order> orders = getNotCompleteOrders(driverId);
        // make list of all not repeated waypoints
        Set<Waypoint> waypoints = new HashSet<Waypoint>();
        for (Order order : orders) waypoints.addAll(order.getWaypoints());
        return waypoints;
    }
}
