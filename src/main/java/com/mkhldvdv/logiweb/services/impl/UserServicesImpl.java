package com.mkhldvdv.logiweb.services.impl;

import com.mkhldvdv.logiweb.dao.impl.UserDaoImpl;
import com.mkhldvdv.logiweb.dto.UserDTO;
import com.mkhldvdv.logiweb.entities.Order;
import com.mkhldvdv.logiweb.entities.Truck;
import com.mkhldvdv.logiweb.entities.User;
import com.mkhldvdv.logiweb.entities.Waypoint;
import com.mkhldvdv.logiweb.exceptions.WrongIdException;
import com.mkhldvdv.logiweb.exceptions.WrongIdException;
import com.mkhldvdv.logiweb.services.PersistenceManager;
import com.mkhldvdv.logiweb.services.UserServices;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

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

    private static final Logger LOG = LogManager.getLogger(UserServicesImpl.class);

    public static final String NOT_COMPLETE = "not complete";
    private UserDaoImpl userDao;

    private EntityManagerFactory emf = PersistenceManager.getInstance().getEntityManagerFactory();
    {
        EntityManager em = emf.createEntityManager();
        userDao = new UserDaoImpl();
//        userDao.setEm(em);
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

        LOG.info("get user by login/pass");

        try {
            userDao.setEm(emf.createEntityManager());
            User user = userDao.getUserByLoginPassword(login, pass);
            // check user exists
            if (user == null) {
                throw new WrongIdException(">>> Exception: No user exists");
            }

            UserDTO userDTO = new UserDTO(user.getId(), user.getFirstName(), user.getLastName(),
                    user.getLogin(), user.getPassword(), user.getRole(), user.getHours(),
                    user.getUserStatus(), user.getCity(), user.getTruck(), user.getOrders(), user.getDeleted());

            return userDTO;

        } catch (WrongIdException wrongLoginPass) {
            LOG.error("get user by login/pass", wrongLoginPass);
            return null;
        } finally {
            if (userDao.getEm().isOpen()) {
                userDao.getEm().close();
            }
        }
    }

    /**
     * returns the specified user
     *
     * @param userId       specified userId, long
     * @return specified user
     */
    @Override
    public UserDTO getUser(long userId) {
        LOG.info("get user by ID");
        try {
            userDao.setEm(emf.createEntityManager());
            User user = userDao.getById(userId);
            // check user exists
            if (user == null) {
                throw new WrongIdException(">>> Exception: No user exists");
            }

            UserDTO userDTO = new UserDTO(user.getId(), user.getFirstName(), user.getLastName(),
                    user.getLogin(), user.getPassword(), user.getRole(), user.getHours(),
                    user.getUserStatus(), user.getCity(), user.getTruck(), user.getOrders(), user.getDeleted());

            return userDTO;

        } catch (WrongIdException e) {
            e.printStackTrace();
            return null;
        } finally {
            if (userDao.getEm().isOpen()) {
                userDao.getEm().close();
            }
        }
    }

    /**
     * gets all co-drivers for the driver with his id
     *
     * @param driverId specified driver
     * @return list of co-drivers
     */
    @Override
    public List<Long> getCoDriversIds(long driverId) {
        LOG.info("get co-drivers");
        try {
            userDao.setEm(emf.createEntityManager());
            User user = userDao.getById(driverId);
            // check user exists
            if (user == null) {
                throw new WrongIdException(">>> Exception: No user exists");
            }

            // fill in the list of co-drivers
            List<Long> coDriversList = new ArrayList<Long>();
            for (User driver : user.getTruck().getDrivers()) {
                coDriversList.add(driver.getId());
            }

            // remove specified user to have only co-drivers ids in the list
            coDriversList.remove(driverId);

            return coDriversList;

        } catch (WrongIdException e) {
            LOG.error("get co-drivers", e);
            return null;
        } finally {
            if (userDao.getEm().isOpen()) {
                userDao.getEm().close();
            }
        }
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
        try {
            userDao.setEm(emf.createEntityManager());
            User user = userDao.getById(driverId);
            // check user exists
            if (user == null) {
                throw new WrongIdException(">>> Exception: No user exists");
            }

            // get registration number and return it
            return user.getTruck().getRegNum();

        } catch (WrongIdException e) {
            LOG.error("get reg num", e);
            return null;
        } finally {
            if (userDao.getEm().isOpen()) {
                userDao.getEm().close();
            }
        }
    }

    /**
     * gets the list of orders for the driver
     *
     * @param driverId specified driver
     * @return list of orders
     */
    @Override
    public List<Long> getDriversOrders(long driverId) {
        LOG.info("get drivers orders");
        try {
            userDao.setEm(emf.createEntityManager());
            User user = userDao.getById(driverId);
            // check user exists
            if (user == null) {
                throw new WrongIdException(">>> Exception: No user exists");
            }

            List<Long> ordersIds = new ArrayList<Long>();
            // get the list of orders ids for the driver
            for (Order order : user.getOrders()) {
                ordersIds.add(order.getId());
            }

            return ordersIds;

        } catch (WrongIdException e) {
            LOG.error("get drivers orders", e);
            return null;
        } finally {
            if (userDao.getEm().isOpen()) {
                userDao.getEm().close();
            }
        }
    }

    /**
     * gets waypoints for the driver
     *
     * @param driverId specified driver
     * @return set of cities ids
     */
    @Override
    public Set<Byte> getDriversCities(long driverId) {
        LOG.info("get drivers cities");
        try {
            userDao.setEm(emf.createEntityManager());
            User user = userDao.getById(driverId);
            // check user exists
            if (user == null) {
                throw new WrongIdException(">>> Exception: No user exists");
            }

            Set<Byte> citiesIds = new HashSet<Byte>();
            // get the list of waypoint for the driver through the list of orders
            for (Order order : user.getOrders()) {
                for (Waypoint waypoint : order.getWaypoints()) {
                    citiesIds.add(waypoint.getCity());
                }
            }

            // return the list of cities ids
            return citiesIds;

        } catch (WrongIdException e) {
            LOG.error("get drivers cities", e);
            return null;
        } finally {
            if (userDao.getEm().isOpen()) {
                userDao.getEm().close();
            }
        }
    }
}
