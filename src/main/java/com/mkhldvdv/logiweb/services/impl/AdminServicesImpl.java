package com.mkhldvdv.logiweb.services.impl;

import com.mkhldvdv.logiweb.dao.impl.CargoDaoImpl;
import com.mkhldvdv.logiweb.dao.impl.OrderDaoImpl;
import com.mkhldvdv.logiweb.dao.impl.TruckDaoImpl;
import com.mkhldvdv.logiweb.dao.impl.UserDaoImpl;
import com.mkhldvdv.logiweb.dto.OrderDTO;
import com.mkhldvdv.logiweb.dto.TruckDTO;
import com.mkhldvdv.logiweb.dto.UserDTO;
import com.mkhldvdv.logiweb.entities.*;
import com.mkhldvdv.logiweb.exceptions.RegNumNotMatchException;
import com.mkhldvdv.logiweb.exceptions.WrongIdException;
import com.mkhldvdv.logiweb.services.AdminServices;
import com.mkhldvdv.logiweb.services.PersistenceManager;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.regex.Pattern;

/**
 * Created by mkhldvdv on 25.11.2015.
 */
public class AdminServicesImpl implements AdminServices {
    public static final String VALID = "valid";
    public static final String NOT_DONE = "not done";
    private TruckDaoImpl truckDao;
    private UserDaoImpl userDao;
    private OrderDaoImpl orderDao;
    private CargoDaoImpl cargoDao;

    private EntityManagerFactory emf = PersistenceManager.getInstance().getEntityManagerFactory();
    {
        EntityManager em = emf.createEntityManager();
        userDao = new UserDaoImpl();
        userDao.setEm(em);
        truckDao = new TruckDaoImpl();
        truckDao.setEm(em);
        orderDao = new OrderDaoImpl();
        orderDao.setEm(em);
    }

    /**
     * get the list of all trucks
     *
     * @return list of trucks
     */
    @Override
    public List<TruckDTO> getTrucks() {
        try {
            List<TruckDTO> truckDTOList = new ArrayList<TruckDTO>();
            List<Truck> truckList = truckDao.getAll();
            // check if it's empty
            if (truckList.isEmpty()) throw new WrongIdException("Exception: trucks list is empty");

            for (Truck truck : truckList) {
                TruckDTO truckDTO = new TruckDTO(truck.getId(), truck.getRegNum(), truck.getDriverCount(),
                        truck.getCapacity(), truck.getTruckStatus(), truck.getCity(), truck.getDeleted());
                truckDTOList.add(truckDTO);
            }

            return truckDTOList;
        } catch (Exception e) {
            return null;
        } finally {
            truckDao.getEm().close();
        }
    }

    /**
     * adds a new truck
     * @param truck to add
     * @return added truck
     */
    @Override
    public long addTruck(Truck truck) throws RegNumNotMatchException, WrongIdException {
        if (truck == null) {
            throw new WrongIdException("truck is not defined");
        }
        checkRegNum(truck);
        return truckDao.create(truck).getId();
    }

    /**
     * check reg num matches the pattern
     * @param truck
     * @throws RegNumNotMatchException
     */
    private void checkRegNum(Truck truck) throws RegNumNotMatchException {
        if (!Pattern.matches("[a-zA-Z]{2}[0-9]{5}", truck.getRegNum())) {
            throw new RegNumNotMatchException("Registration number doesn't match the pattern");
        }
    }

    /**
     * updates specified truck
     *
     * @param truckId specified truck
     * @return updated truck
     */
    @Override
    public Truck updateTruck(long truckId) throws RegNumNotMatchException, WrongIdException {
        Truck truck = truckDao.getById(truckId);
        // if driver doesn't exit
        if (truck == null) throw new WrongIdException("Wrong truck id");
        checkRegNum(truck);
        return truckDao.update(truck);
    }

    /**
     * deletes specified truck
     *
     * @param truckId specified truck
     */
    @Override
    public void deleteTruck(long truckId) throws WrongIdException {
        Truck truck = truckDao.getById(truckId);
        // if driver doesn't exit
        if (truck == null) throw new WrongIdException("Wrong truck id");
        truckDao.remove(truck);
    }

    /**
     * get the list of all drivers
     *
     * @return the list of all drivers
     */
    @Override
    public List<UserDTO> getDrivers() {

        try {
            List<UserDTO> userDTOList = new ArrayList<UserDTO>();
            List<User> userList = userDao.getAllDrivers();
            // check if list is empty
            if (userList.isEmpty()) {
                throw new WrongIdException("Exception: drivers list is empty");
            }

            for (User user : userList) {
                UserDTO userDTO = new UserDTO(user.getId(), user.getFirstName(), user.getLastName(),
                        user.getLogin(), user.getPassword(), user.getRole(), user.getHours(),
                        user.getUserStatus(), user.getCity(), user.getTruck(), user.getOrders(), user.getDeleted());
                userDTOList.add(userDTO);
            }

            return userDTOList;

        } catch (Exception e) {
            return null;
        } finally {
            userDao.getEm().close();
        }
    }

    /**
     * adds a new driver
     *
     * @param user driver to add
     * @return id of the added driver
     */
    @Override
    public long addDriver(User user) throws WrongIdException {
        if (user == null) {
            throw new WrongIdException("driver is not defined");
        }
        return userDao.create(user).getId();
    }

    /**
     * updates driver
     *
     * @param driverId specified driver
     * @return updated driver
     */
    @Override
    public User updateDriver(long driverId) throws WrongIdException {
        User user = userDao.getById(driverId);
        if (user == null) {
            throw new WrongIdException("Wrong driver id");
        }
        return userDao.update(user);
    }

    /**
     * deletes specified driver
     *
     * @param driverId driver to delete
     */
    @Override
    public void deleteDriver(long driverId) throws WrongIdException {
        User user = userDao.getById(driverId);
        if (user == null) {
            throw new WrongIdException("Wrong driver id");
        }
        userDao.remove(user);
    }

    /**
     * get the list of all orders
     *
     * @return orders
     */
    @Override
    public List<OrderDTO> getOrders() {
        try {
            List<OrderDTO> orderDTOList = new ArrayList<OrderDTO>();
            List<Order> orderList = orderDao.getAll();
            // check if order list is empty
            if (orderList.isEmpty()) {
                throw new WrongIdException("Exception: orders list is empty");
            }

            for (Order order : orderList) {
                // collect all cities for the order
                Set<Long> waypointsSet = new HashSet<Long>();
                for (Waypoint waypoint : order.getWaypoints()) waypoint.getCity();
                // collect all drivers for the order
                Set<Long> driversSet = new HashSet<Long>();
                for (User driver : order.getDrivers()) driversSet.add(driver.getId());

                OrderDTO orderDTO = new OrderDTO(order.getId(),order.getOrderStatus(), waypointsSet,
                        order.getTruck(), driversSet, order.getDeleted());
                orderDTOList.add(orderDTO);
            }

            return orderDTOList;
        } catch (WrongIdException e) {
            e.printStackTrace();
            return null;
        } finally {
            orderDao.getEm().close();
        }
    }

    /**
     * get the full info of order
     *
     * @param orderId order id
     * @return specified order
     */
    @Override
    public Order getOrder(long orderId) throws WrongIdException {
        Order order = orderDao.getById(orderId);
        if (order == null) {
            throw new WrongIdException("Wrong order id");
        }
        return order;
    }

    /**
     * get the full info about the cargo
     *
     * @param cargoId cargo id
     * @return specified cargo
     */
    @Override
    public Cargo getCargo(long cargoId) throws WrongIdException {
        Cargo cargo = cargoDao.getById(cargoId);
        if (cargo == null) {
            throw new WrongIdException("Wrong cargo id");
        }
        return cargo;
    }

    /**
     * adds new order
     *
     * @param order order to add
     * @return id of added order
     * @throws WrongIdException (shit happens)
     */
    @Override
    public long addOrder(Order order) throws WrongIdException {
        if (order == null) {
            throw new WrongIdException("Specified order is null");
        }
        //toDo: check cargos types in the order, load and unload
        return 0;
    }

    /**
     * get the list of trucks which are able to delivery order
     *
     * @param orderId specified order id
     * @return list of trucks
     */
    @Override
    public List<Truck> getTruckForOrder(long orderId) throws WrongIdException {
        Order order = orderDao.getById(orderId);
        if (order == null) {
            throw new WrongIdException("Wrong order id");
        }

        List<Truck> tmpTruckList = truckDao.getAll();
        // filtered truck list
        List<Truck> truckList = new ArrayList<Truck>();

        for (Truck truck : tmpTruckList) {
            // check if truck is valid
            if (VALID.equals(truck.getTruckStatus())) {
                List<Order> ordersList = truck.getOrders();
                boolean isTrue = true;
                // check if there are no orders at the moment
                for (Order order1 : ordersList) {
                    if (NOT_DONE.equals(order1.getOrderStatus())) isTrue = false;
                }
                // of all is ok, add to the list
                if (isTrue) {
                    truckList.add(truck);
                }
            }
        }

        return truckList;
    }

    /**
     * get the list of drivers for the specified truck
     *
     * @param truckId specified truck
     * @return list of drivers
     */
    @Override
    public List<User> getDriversForTruck(long truckId) throws WrongIdException {
        Truck truck = truckDao.getById(truckId);
        if (truck == null) throw new WrongIdException("Wrong truck ID");
        // get first match the shift size which have no open orders at the moment
        byte shiftSize = truck.getDriverCount();
        List<User> driverList = userDao.getAllDrivers();
        List<User> assignedDrivers = new ArrayList<User>();
        //toDo: shift size filter
        return null;
    }
}
