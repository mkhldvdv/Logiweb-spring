package com.mkhldvdv.logiweb.services.impl;

import com.mkhldvdv.logiweb.dao.impl.*;
import com.mkhldvdv.logiweb.dto.CargoDTO;
import com.mkhldvdv.logiweb.dto.OrderDTO;
import com.mkhldvdv.logiweb.entities.*;
import com.mkhldvdv.logiweb.exceptions.WrongIdException;
import com.mkhldvdv.logiweb.services.AdminServices;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.NoResultException;
import java.util.*;

/**
 * Created by mkhldvdv on 25.11.2015.
 */

@Service
public class AdminServicesImpl implements AdminServices {

    private static final Logger LOG = LogManager.getLogger(AdminServicesImpl.class);

    public static final byte NOT_COMPLETE = (byte) 2;

    @Autowired
    private TruckDaoImpl truckDao;
    @Autowired
    private UserDaoImpl userDao;
    @Autowired
    private OrderDaoImpl orderDao;
    @Autowired
    private CargoDaoImpl cargoDao;
    @Autowired
    private WaypointDaoImpl waypointDao;
    @Autowired
    private CityMapDaoImpl cityMapDao;

    /**
     * get the list of all trucks
     *
     * @return list of trucks
     */
    @Override
    public List<Truck> getTrucks() {
        LOG.info("AdminServices: getTrucks()");
        List<Truck> truckList = truckDao.getAll();
        return truckList;
    }

    /**
     * get the list of all drivers
     *
     * @return the list of all drivers
     */
    @Override
    public List<User> getDrivers() {
        LOG.info("AdminServices: getDrivers()");
        List<User> userList = userDao.getAllDrivers();
        return userList;
    }

    /**
     * get the list of all orders
     *
     * @return orders
     */
    @Override
    public List<OrderDTO> getOrders() {
        LOG.info("AdminServices: getOrders()");
        List<Order> orderList = orderDao.getAll();
        List<OrderDTO> orderDTOs = new ArrayList<OrderDTO>();
        // transfer info to dto object
        for (Order order : orderList) {
            OrderDTO orderDTO = new OrderDTO();
            orderDTO.setId(order.getId());
            orderDTO.setTruck(order.getTruck());
            orderDTO.setOrderStatus(order.getOrderStatus());
            orderDTO.setDrivers(new HashSet<Long>());
            for (User driver : order.getDrivers()) {
                orderDTO.getDrivers().add(driver.getId());
            }
            orderDTO.setWaypoints(new HashSet<String>());
            for (Waypoint waypoint : order.getWaypoints()) {
                orderDTO.getWaypoints().add(waypoint.getCity());
            }
            orderDTOs.add(orderDTO);
        }

        return orderDTOs;
    }

    /**
     * get the full info of order
     *
     * @param orderId order id
     * @return specified order
     */
    @Override
    public OrderDTO getOrder(long orderId) throws WrongIdException {
        LOG.info("AdminServices: getOrder(" + orderId + ")");
        Order order = orderDao.getById(orderId);
        // if null then throw exception
        if (order == null) {
            throw new WrongIdException("No order found with ID: " + orderId);
        }
        OrderDTO orderDTO = new OrderDTO();
        // transfer data to DTO object
        orderDTO.setId(order.getId());
        orderDTO.setOrderStatus(order.getOrderStatus());
        orderDTO.setTruck(order.getTruck());
        orderDTO.setDrivers(new HashSet<Long>());
        for (User driver : order.getDrivers()) {
            orderDTO.getDrivers().add(driver.getId());
        }
        orderDTO.setWaypoints(new HashSet<String>());
        for (Waypoint waypoint : order.getWaypoints()) {
            orderDTO.getWaypoints().add(waypoint.getCity());
        }

        return orderDTO;
    }

    /**
     * get specified cargo by its id
     *
     * @param cargoId cargo id
     * @return cargo object
     */
    @Override
    public Cargo getCargoById(long cargoId) {
        LOG.info("AdminServices: getCargoById(" + cargoId + ")");
        return cargoDao.getById(cargoId);
    }

    /**
     * update cargo object
     *
     * @param cargo cargo object
     * @return updated cargo object
     */
    @Override
    @Transactional
    public Cargo updateCargo(Cargo cargo) {
        LOG.info("AdminServices: updateCargo(" + cargo.getId() + ")");
        return cargoDao.update(cargo);
    }

    /**
     * get the full info about the cargo
     *
     * @param cargoId cargo id
     * @return specified cargo
     */
    @Override
    public CargoDTO getCargo(long cargoId) throws WrongIdException {
        LOG.info("AdminServices: getCargo(" + cargoId + ")");
        Cargo cargo = cargoDao.getById(cargoId);
        // if null -- exception
        if (cargo == null) {
            throw new WrongIdException("No cargo found with ID: " + cargoId);
        }
        // transfer data to DTO object for the view
        CargoDTO cargoDTO = new CargoDTO();
        cargoDTO.setId(cargo.getId());
        cargoDTO.setCargoName(cargo.getCargoName());
        cargoDTO.setWeight(cargo.getWeight());
        cargoDTO.setCargoStatus(cargo.getCargoStatus());
        cargoDTO.setWaypoints(new ArrayList<String>());
        for (Waypoint waypoint : cargo.getWaypoints()) {
            cargoDTO.getWaypoints().add(waypoint.getCity());
        }
        return cargoDTO;
    }

    /**
     * get specified user by its id
     *
     * @param userId id of the user
     * @return user object
     */
    @Override
    public User getUser(long userId) throws WrongIdException {
        LOG.info("AdminServices: getUser(" + userId + ")");
        User user = userDao.getById(userId);
        // if null or deleted then exception
        if (user == null || user.getDeleted() == 1) {
            throw new WrongIdException("No user found with ID: " + userId);
        }

        return user;
    }

    /**
     * get not deleted specified user
     *
     * @param userId user id
     * @return specified not deleted user
     * @throws WrongIdException
     */
    @Override
    public User getNotDeletedUser(long userId) throws WrongIdException {
        LOG.info("AdminServices: getNotDeletedUser(" + userId + ")");
        try {
            User user = userDao.getNotDeletedUserById(userId);
            return user;
        } catch (NoResultException e) {
            LOG.error("AdminServices: getNotDeletedUser " + e.getMessage());
            // if no user found
            throw new WrongIdException("No user found with ID: " + userId);
        }
    }

    /**
     * adds new user/driver
     *
     * @param user new user to add
     * @return id number of added user
     */
    @Override
    @Transactional
    public User addUser(User user) {
        LOG.info("AdminServices: addUser(" + user.getId() + ")");
        User newUser = userDao.create(user);
        return newUser;
    }

    /**
     * updated existing user
     *
     * @param user user to update
     * @return updated user
     */
    @Override
    @Transactional
    public User updateUser(User user, boolean hashed) {
        LOG.info("AdminServices: updateUser(" + user.getId() + ")");
        User newUser = userDao.update(user, hashed);
        return newUser;
    }

    /**
     * deletes specified user
     *
     * @param userId user to delete
     */
    @Override
    @Transactional
    public void deleteUser(long userId) {
        LOG.info("AdminServices: deleteUser(" + userId + ")");
        User user = userDao.getById(userId);
        userDao.remove(user);
    }

    /**
     * adds new truck
     *
     * @param truck truck to add
     * @return added truck
     */
    @Override
    @Transactional
    public Truck addTruck(Truck truck) {
        LOG.info("AdminServices: addTruck(" + truck.getId() + ")");
        Truck newTruck = truckDao.create(truck);
        return newTruck;
    }

    /**
     * deletes specified truck
     *
     * @param truckId truck to delete
     */
    @Override
    @Transactional
    public void deleteTruck(long truckId) {
        LOG.info("AdminServices: deleteTruck(" + truckId + ")");
        Truck truck = truckDao.getById(truckId);
        truckDao.remove(truck);
    }

    /**
     * gets the specified truck
     *
     * @param truckId truck id
     * @return specified truck
     */
    @Override
    public Truck getTruck(long truckId) throws WrongIdException {
        LOG.info("AdminServices: getTruck(" + truckId + ")");
        Truck truck = truckDao.getById(truckId);
        // if null then exception
        if (truck == null) {
            throw new WrongIdException("No truck found with ID: " + truckId);
        }
        return truck;
    }

    /**
     * get not deleted specified truck
     *
     * @param truckId truck id
     * @return specified not deleted truck
     * @throws WrongIdException
     */
    @Override
    public Truck getNotDeletedTruck(long truckId) throws WrongIdException {
        LOG.info("AdminServices: getNotDeletedUser(" + truckId + ")");
        try {
            Truck truck = truckDao.getNotDeletedTruckById(truckId);
            return truck;
        } catch (NoResultException e) {
            LOG.error("AdminServices: getNotDeletedTruck " + e.getMessage());
            // if no truck found
            throw new WrongIdException("No truck found with ID: " + truckId);
        }
    }

    /**
     * updates specified truck
     *
     * @param truck truck to update
     * @return specified truck int DTO object
     */
    @Override
    @Transactional
    public Truck updateTruck(Truck truck) {
        LOG.info("AdminServices: updateTruck(" + truck.getId() + ")");
        Truck newTruck = truckDao.update(truck);
        return newTruck;
    }

    /**
     * creating new cargo with its waypoints
     *
     * @param cargo cargo to add, contains the list of its waypoints
     * @return added cargo
     */
    @Override
    @Transactional
    public Cargo addCargo(Cargo cargo) {
        LOG.info("AdminServices: addCargo(" + cargo.getId() + ")");

        // add cargo
        Cargo newCargo = cargoDao.create(cargo);
        // update waypoints with created cargo.id
        for (Waypoint waypoint : newCargo.getWaypoints()) {
            waypoint.setCargo(newCargo);
            waypointDao.update(waypoint);
        }

        return newCargo;
    }

    /**
     * get the list of all unassigned cargos to add in the order
     *
     * @return list of cargos
     */
    @Override
    public List<Cargo> getAllUnassignedCargos() {
        LOG.info("AdminServices: getAllUnassignedCargos()");
        List<Cargo> cargos = cargoDao.getAllUnassigned();
        return cargos;
    }

    /**
     * get the list of trucks available for delivery
     *
     * @param cargosIds list of cargos for truck to deliver
     * @return list of trucks
     */
    @Override
    public List<Truck> getAllAvailableTrucks(List<Long> cargosIds) {
        LOG.info("AdminServices: getAllAvailableTrucks(" + cargosIds + ")");

        // creating map of cargos weight balance for the city
        Map<String, Integer> waypointWeightMap = new HashMap<String, Integer>();
        for (Long cargoId : cargosIds) {
            // find cargo
            Cargo cargo = cargoDao.getById(cargoId);
            int cargoWeight = cargo.getWeight();
            // get waypoints for cargo
            List<Waypoint> waypoints = waypointDao.getByCargoId(cargoId);
            // sorting it
            Collections.sort(waypoints);
            // adding info for cargo to map
            waypointWeightMap = fillMapCityWeight(waypointWeightMap, cargoWeight, waypoints);
        }

        Map<String, Integer> tmpMap = new HashMap<String, Integer>();
        tmpMap.putAll(waypointWeightMap);
        int commonweight = 0;
        for (Map.Entry<String, Integer> entry : waypointWeightMap.entrySet()) {
            commonweight += entry.getValue();
            tmpMap.put(entry.getKey(), commonweight);
        }
        // check the map
        LOG.info("AdminServices: tmpMap: " + tmpMap);
        waypointWeightMap = tmpMap;

        List<Truck> availableTrucksForOrder = new ArrayList<Truck>();
        // not broken and no active order
        List<Truck> trucks = truckDao.getAllAvailableTrucks();
        // try to find suitable trucks for deliver
        for (Truck truck : trucks) {
            boolean flag = true;
            // capacity of the truck in tons, should be in kilos for comparison
            int capacity = truck.getCapacity() * 1000;
            // select only available trucks for order
            for (Integer cityWeight : waypointWeightMap.values()) {
                if (capacity - cityWeight < 0) {
                    flag = false;
                }
            }
            // if flag is true, add truck to truck list for order
            if (flag) {
                availableTrucksForOrder.add(truck);
            }
        }

        // return available for order trucks
        return availableTrucksForOrder;
    }

    /**
     * fill the map with cities and weight balance
     */
    private Map<String, Integer> fillMapCityWeight(Map<String, Integer> waypointWeightMap, int cargoWeight, List<Waypoint> waypoints) {
        LOG.info("AdminServices: fillMapCityWeight()");
        for (Waypoint waypoint : waypoints) {
            String city = waypoint.getCity();
            // if load then add it to the map with plus
            if (waypoint.getCargoTypeId() == 1) {
                waypointWeightMap.put(city, waypointWeightMap.get(city) == null ? cargoWeight : waypointWeightMap.get(city) + cargoWeight);
            } else {
                waypointWeightMap.put(city, waypointWeightMap.get(city) == null ? -cargoWeight : waypointWeightMap.get(city) - cargoWeight);
            }
        }
        return waypointWeightMap;
    }

    /**
     * get all available drivers for truck
     *
     * @param truckId   specified truck id
     * @param cargosIds
     * @return list of drivers
     */
    @Override
    public List<User> getAllAvailableDrivers(long truckId, List<Long> cargosIds) {
        LOG.info("AdminServices: getAllAvailableDrivers()");
        // find truck
        Truck truck = truckDao.getById(truckId);
        // list of drivers without active orders
        List<User> driversWithoutOrder = new ArrayList<User>();
        // get all drivers with the same city for the truck
        List<User> drivers = userDao.getAllAvailableDrivers(truck);
        for (User driver : drivers) {
            boolean flag = true;
            for (Order order : driver.getOrders()) {
                // not completed orders not included
                if (order != null && "not complete".equals(order.getOrderStatus())) {
                    flag = true;
                }
            }
            // if no active orders found, add user to the list
            driversWithoutOrder.add(driver);
        }

        // get waypoints for cargo
//            List<Waypoint> waypoints = new ArrayList<Waypoint>();
//            for (Long cargoId : cargosIds) {
//                waypoints = waypointDao.getByCargoId(cargoId);
//            }
//            // sorting it
//            Collections.sort(waypoints);
//
//
//            // count the distance summary for the trip
//            int distanceSum = 0;
//            byte cityStart = 0;
//            for (int i = 0; i < waypoints.size(); i++) {
//                if (i == 0) {
//                    cityStart = waypoints.get(i).getCity();
//                } else {
//                    byte cityEnd = waypoints.get(i).getCity();
//                    distanceSum += cityMapDao.getCityMap(cityStart, cityEnd).getDistance();
//                    cityStart = cityEnd;
//                }
//            }

        // check
//            LOG.error("distance summary:\n" + distanceSum);
        List<Long> driLongList = new ArrayList<Long>();
        for (User driver : driversWithoutOrder) {
            driLongList.add(driver.getId());
        }
        LOG.info("AdminServices: get all available drivers for order and truck:\n" + driLongList);
        // check done
        return driversWithoutOrder;
    }

    @Override
    @Transactional
    public Order addOrder(List<Long> cargoIds, Truck truck, List<Long> userIds) {
        LOG.info("AdminServices: addOrder()");
        // get list of users by its id
        List<User> userList = new ArrayList<User>();
        for (Long user : userIds) {
            userList.add(userDao.getById(user));
        }
        // end of user list creating

        // get list of cargos by its id
        List<Cargo> cargoList = new ArrayList<Cargo>();
        for (Long cargoId : cargoIds) {
            cargoList.add(cargoDao.getById(cargoId));
        }
        // end of cargos list creating

        // creating list of waypoints for order
        List<Waypoint> waypointList = new ArrayList<Waypoint>();
        for (Cargo cargo : cargoList) {
            waypointList.addAll(cargo.getWaypoints());
        }
        // end of waypoints list

        // creating drivers list if it's still empty for any reason
        if (truck.getDrivers() == null || truck.getDrivers().isEmpty()) {
            truck.setDrivers(userList);
        }

//        truck.getDrivers().addAll(userList);
        // end of truck creating

        // create order
        Order order = new Order();
        order.setOrderStatusId(NOT_COMPLETE);
        order.setWaypoints(waypointList);
        order.setTruck(truck);
        order.setDrivers(userList);

        // 1. creating order in db
        Order orderNew = orderDao.create(order);

        // 2. update all waypoints
        for (Waypoint waypoint : orderNew.getWaypoints()) {
            // create link
            waypoint.setOrder(orderNew);
            // and update in db
            Waypoint tmpWay = waypointDao.update(waypoint);
        }

        // 3. update truck
        // creating orders list if it's still empty for any reason
        if (truck.getOrders() == null) {
            truck.setOrders(new ArrayList<Order>());
        }
        // links to new order
        truck.getOrders().add(orderNew);
        Truck tmpTruck = truckDao.update(truck);

        // 4. update drivers
        for (User user : userList) {
            if (user.getOrders() == null) {
                user.setOrders(new ArrayList<Order>());
            }
            // set order
            user.getOrders().add(orderNew);
            // set truck
            user.setTruck(tmpTruck);
            // update on database
            User tmpUser = userDao.update(user);
        }

        return orderNew;
    }
}
