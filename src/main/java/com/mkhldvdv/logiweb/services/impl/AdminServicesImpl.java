package com.mkhldvdv.logiweb.services.impl;

import com.mkhldvdv.logiweb.dao.impl.CargoDaoImpl;
import com.mkhldvdv.logiweb.dao.impl.OrderDaoImpl;
import com.mkhldvdv.logiweb.dao.impl.TruckDaoImpl;
import com.mkhldvdv.logiweb.dao.impl.UserDaoImpl;
import com.mkhldvdv.logiweb.entities.Cargo;
import com.mkhldvdv.logiweb.entities.Order;
import com.mkhldvdv.logiweb.entities.Truck;
import com.mkhldvdv.logiweb.entities.User;
import com.mkhldvdv.logiweb.exceptions.RegNumNotMatchException;
import com.mkhldvdv.logiweb.exceptions.WrongIdException;
import com.mkhldvdv.logiweb.services.AdminServices;

import java.util.List;
import java.util.regex.Pattern;

/**
 * Created by mkhldvdv on 25.11.2015.
 */
public class AdminServicesImpl implements AdminServices {
    private TruckDaoImpl truckDao;
    private UserDaoImpl userDao;
    private OrderDaoImpl orderDao;
    private CargoDaoImpl cargoDao;

    /**
     * get the list of all trucks
     *
     * @return list of trucks
     */
    @Override
    public List<Truck> getTrucks() {
        return truckDao.getAll();
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
    public List<User> getDrivers() {
        return userDao.getAllDrivers();
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
}
