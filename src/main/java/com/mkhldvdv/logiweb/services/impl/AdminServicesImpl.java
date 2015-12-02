package com.mkhldvdv.logiweb.services.impl;

import com.mkhldvdv.logiweb.dao.impl.*;
import com.mkhldvdv.logiweb.dto.CargoDTO;
import com.mkhldvdv.logiweb.dto.OrderDTO;
import com.mkhldvdv.logiweb.dto.TruckDTO;
import com.mkhldvdv.logiweb.dto.UserDTO;
import com.mkhldvdv.logiweb.entities.*;
import com.mkhldvdv.logiweb.exceptions.WrongIdException;
import com.mkhldvdv.logiweb.services.AdminServices;
import com.mkhldvdv.logiweb.services.PersistenceManager;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import java.util.*;

/**
 * Created by mkhldvdv on 25.11.2015.
 */
public class AdminServicesImpl implements AdminServices {

    private static final Logger LOG = LogManager.getLogger(AdminServicesImpl.class);

    public static final String VALID = "valid";
    public static final String NOT_DONE = "not done";
    private TruckDaoImpl truckDao;
    private UserDaoImpl userDao;
    private OrderDaoImpl orderDao;
    private CargoDaoImpl cargoDao;
    private WaypointDaoImpl waypointDao;
    private CityMapDaoImpl cityMapDao;

    private EntityManagerFactory emf = PersistenceManager.getInstance().getEntityManagerFactory();
    {
        EntityManager em = emf.createEntityManager();
        userDao = new UserDaoImpl();
        userDao.setEm(em);
        truckDao = new TruckDaoImpl();
        truckDao.setEm(em);
        orderDao = new OrderDaoImpl();
        orderDao.setEm(em);
        cargoDao = new CargoDaoImpl();
        cargoDao.setEm(em);
        waypointDao = new WaypointDaoImpl();
        waypointDao.setEm(em);
        cityMapDao = new CityMapDaoImpl();
        cityMapDao.setEm(em);
    }

    /**
     * get the list of all trucks
     *
     * @return list of trucks
     */
    @Override
    public List<TruckDTO> getTrucks() {
        LOG.info("getTrucks");
        try {
            List<TruckDTO> truckDTOList = new ArrayList<TruckDTO>();
            List<Truck> truckList = truckDao.getAll();
            // check if it's empty
            if (truckList.isEmpty()) {
                throw new WrongIdException(">>> Exception: trucks list is empty");
            }

            for (Truck truck : truckList) {
                TruckDTO truckDTO = new TruckDTO(truck.getId(), truck.getRegNum(), truck.getDriverCount(),
                        truck.getCapacity(), truck.getTruckStatus(), truck.getCity(), truck.getDeleted());
                truckDTOList.add(truckDTO);
            }

            return truckDTOList;
        } catch (Exception e) {
            LOG.error("Error while getting trucks", e);
            return null;
        } finally {
            if (truckDao.getEm().isOpen()) {
                truckDao.getEm().close();
            }
        }
    }

    /**
     * get the list of all drivers
     *
     * @return the list of all drivers
     */
    @Override
    public List<UserDTO> getDrivers() {

        LOG.info("getDrivers");

        try {
            List<UserDTO> userDTOList = new ArrayList<UserDTO>();
            List<User> userList = userDao.getAllDrivers();
            // check if list is empty
            if (userList.isEmpty()) {
                throw new WrongIdException(">>> Exception: drivers list is empty");
            }

            for (User user : userList) {
                UserDTO userDTO = new UserDTO(user.getId(), user.getFirstName(), user.getLastName(),
                        user.getLogin(), user.getPassword(), user.getRole(), user.getHours(),
                        user.getUserStatus(), user.getCity(), user.getTruck(), user.getOrders(), user.getDeleted());
                userDTOList.add(userDTO);
            }

            return userDTOList;

        } catch (Exception e) {
            LOG.error("Error during getDrivers", e);
            return null;
        } finally {
            if (userDao.getEm().isOpen()) {
                userDao.getEm().close();
            }
        }
    }

    /**
     * get the list of all orders
     *
     * @return orders
     */
    @Override
    public List<OrderDTO> getOrders() {

        LOG.info("getOrders");

        try {
            List<OrderDTO> orderDTOList = new ArrayList<OrderDTO>();
            List<Order> orderList = orderDao.getAll();
            // check if order list is empty
            if (orderList.isEmpty()) {
                throw new WrongIdException(">>> Exception: orders list is empty");
            }

            for (Order order : orderList) {
                // collect all cities for the order
                Set<Long> waypointsSet = new HashSet<Long>();
                for (Waypoint waypoint : order.getWaypoints()) {
                    waypointsSet.add((long) waypoint.getCity());
                }
                // collect all drivers for the order
                Set<Long> driversSet = new HashSet<Long>();
                for (User driver : order.getDrivers()) {
                    driversSet.add(driver.getId());
                }

                OrderDTO orderDTO = new OrderDTO(order.getId(),order.getOrderStatus(), waypointsSet,
                        order.getTruck(), driversSet, order.getDeleted());
                orderDTOList.add(orderDTO);
            }

            return orderDTOList;
        } catch (Exception e) {
            LOG.error("Error during getOrders", e);
            return null;
        } finally {
            if (orderDao.getEm().isOpen()) {
                orderDao.getEm().close();
            }
        }
    }

    /**
     * get the full info of order
     *
     * @param orderId order id
     * @return specified order
     */
    @Override
    public OrderDTO getOrder(long orderId) {

        LOG.info("getOrder");

        try {
            Order order = orderDao.getById(orderId);
            // check if null
            if (order == null) {
                throw new WrongIdException("Wrong order id");
            }

            Set<Long> waypointsList = new HashSet<Long>();
            Set<Long> driversList = new HashSet<Long>();
            for (Waypoint waypoint : order.getWaypoints()) {
                waypointsList.add((long) waypoint.getCity());
            }
            for (User user : order.getDrivers()) {
                driversList.add(user.getId());
            }
            // complete DTO object
            OrderDTO orderDTO = new OrderDTO(order.getId(), order.getOrderStatus(), waypointsList, order.getTruck(),
                    driversList, order.getDeleted());

            return orderDTO;
        } catch (WrongIdException e) {
            LOG.error("getOrder: ", e);
            return null;
        } finally {
            if (orderDao.getEm().isOpen()) {
                orderDao.getEm().close();
            }
        }
    }

    /**
     * get the full info about the cargo
     *
     * @param cargoId cargo id
     * @return specified cargo
     */
    @Override
    public CargoDTO getCargo(long cargoId) {
        LOG.info("getCargo");
        try {
            Cargo cargo = cargoDao.getById(cargoId);
            // check if null
            if (cargo == null) {
                throw new WrongIdException("Wrong cargo id");
            }

            List<Long> waypointsList = new ArrayList<Long>();
            for (Waypoint waypoint : cargo.getWaypoints()) {
                waypointsList.add((long) waypoint.getCity());
            }

            // complete DTO object
            CargoDTO cargoDTO = new CargoDTO(cargo.getId(), cargo.getCargoName(), cargo.getWeight(),
                    cargo.getCargoStatus(), waypointsList, cargo.getDeleted());

            return cargoDTO;
        } catch (WrongIdException e) {
            LOG.error("getCargo: ", e);
            return null;
        } finally {
            if (cargoDao.getEm().isOpen()) {
                cargoDao.getEm().close();
            }
        }
    }

    /**
     * adds new user/driver
     *
     * @param userDTO new user to add
     * @return id number of added user
     */
    @Override
    public UserDTO addUser(UserDTO userDTO) {
        LOG.info("getUser");
        try {
            // check input
            if (userDTO == null) {
                throw new WrongIdException(">>> Exception: added user was null");
            }

            User user = new User(userDTO.getFirstName(), userDTO.getLastName(), userDTO.getLogin(),
                    userDTO.getPassword(), userDTO.getRole(), userDTO.getHours(), userDTO.getUserStatus(),
                    userDTO.getCity(), userDTO.getTruck(), userDTO.getOrders(), userDTO.getDeleted());

            userDao.getEm().getTransaction().begin();
            User newUser = userDao.create(user);
            // check user was added successfully
            if (newUser == null) {
                throw new WrongIdException(">>> Exception: user was null due to some reason");
            }
            userDao.getEm().getTransaction().commit();

            userDTO.setId(newUser.getId());

            return userDTO;
        } catch (Exception e) {
            LOG.error("addUser", e);
            return null;
        } finally {
            if (userDao.getEm().getTransaction().isActive()) {
                userDao.getEm().getTransaction().rollback();
            }
            if (userDao.getEm().isOpen()) {
                userDao.getEm().close();
            }
        }
    }

    /**
     * updated existing user
     *
     * @param userDTO user to update
     * @return updated user
     */
    @Override
    public UserDTO updateUser(UserDTO userDTO, boolean hashed) {
        LOG.info("updateUser");
        try {
            // check input
            if (userDTO == null) {
                throw new WrongIdException(">>> Exception: updated user was null");
            }

            User user = new User(userDTO.getFirstName(), userDTO.getLastName(), userDTO.getLogin(),
                    userDTO.getPassword(), userDTO.getRole(), userDTO.getHours(), userDTO.getUserStatus(),
                    userDTO.getCity(), userDTO.getTruck(), userDTO.getOrders(), userDTO.getDeleted());
            user.setId(userDTO.getId());

            // updating user
            userDao.getEm().getTransaction().begin();
            User newUser = userDao.update(user, hashed);
            userDao.getEm().getTransaction().commit();
            // check user was added successfully
            if (newUser == null) {
                throw new WrongIdException(">>> Exception: user was not added for some reason");
            }

            // construct DTO object and return it back
//            userDTO.setId(newUser.getId());
            userDTO.setFirstName(newUser.getFirstName());
            userDTO.setLastName(newUser.getLastName());
            userDTO.setLogin(newUser.getLogin());
            userDTO.setPassword(newUser.getPassword());
            userDTO.setRole(newUser.getRole());
            userDTO.setHours(newUser.getHours());
            userDTO.setUserStatus(newUser.getUserStatus());
            userDTO.setCity(newUser.getCity());
            userDTO.setTruck(newUser.getTruck());
            userDTO.setOrders(newUser.getOrders());
            userDTO.setDeleted(newUser.getDeleted());

            return userDTO;
        } catch (Exception e) {
            LOG.error("updateUser", e);
            return null;
        } finally {
            if (userDao.getEm().getTransaction().isActive()) {
                userDao.getEm().getTransaction().rollback();
            }
            if (userDao.getEm().isOpen()) {
                userDao.getEm().close();
            }
        }
    }

    /**
     * deletes specified user
     *
     * @param userId user to delete
     */
    @Override
    public void deleteUser(long userId) {

        LOG.info("deleteUser");
        // check input
        try {
            if (userId == 0 || userId == -1) {
                throw new WrongIdException(">>> Exception: deleted user was 0");
            }
            User user = userDao.getById(userId);
            // delete user
            userDao.getEm().getTransaction().begin();
            userDao.remove(user);
            userDao.getEm().getTransaction().commit();

        } catch (Exception e) {
            LOG.error("deleteUser", e);
        } finally {
            if (userDao.getEm().getTransaction().isActive()) {
                userDao.getEm().getTransaction().rollback();
            }
            if (userDao.getEm().isOpen()) {
                userDao.getEm().close();
            }
        }
    }

    /**
     * adds new truck
     *
     * @param truckDTO truck to add
     * @return added truck
     */
    @Override
    public TruckDTO addTruck(TruckDTO truckDTO) {
        LOG.info("addTruck");
        try {
            // check input
            if (truckDTO == null) {
                throw new WrongIdException(">>> Exception: added truck was null");
            }

            Truck truck = new Truck(truckDTO.getRegNum(), truckDTO.getDriverCount(), truckDTO.getCapacity(),
                    truckDTO.getTruckStatus(), truckDTO.getCity());

            truckDao.getEm().getTransaction().begin();
            Truck newTruck = truckDao.create(truck);
            // check user was added successfully
            if (newTruck == null) {
                throw new WrongIdException(">>> Exception: truck was not added for some reason");
            }
            truckDao.getEm().getTransaction().commit();

            truckDTO.setId(newTruck.getId());

            return truckDTO;
        } catch (Exception e) {
            LOG.error("addTruck", e);
            return null;
        } finally {
            if (truckDao.getEm().getTransaction().isActive()) {
                truckDao.getEm().getTransaction().rollback();
            }
            if (truckDao.getEm().isOpen()) {
                truckDao.getEm().close();
            }
        }
    }

    /**
     * deletes specified truck
     *
     * @param truckId truck to delete
     */
    @Override
    public void deleteTruck(long truckId) {
        LOG.info("deleteTruck");
        // check input
        try {
            if (truckId == 0 || truckId == -1) {
                throw new WrongIdException(">>> Exception: deleted truck was 0");
            }
            Truck truck = truckDao.getById(truckId);
            // delete user
            truckDao.getEm().getTransaction().begin();
            truckDao.remove(truck);
            truckDao.getEm().getTransaction().commit();

        } catch (Exception e) {
            LOG.error("deleteTruck", e);
        } finally {
            if (truckDao.getEm().getTransaction().isActive()) {
                truckDao.getEm().getTransaction().rollback();
            }
            if (truckDao.getEm().isOpen()) {
                truckDao.getEm().close();
            }
        }
    }

    /**
     * gets the specified truck
     *
     * @param truckId truck id
     * @return specified truck
     */
    @Override
    public TruckDTO getTruck(long truckId) {
        LOG.info("getTruck");
        try {
            Truck truck = truckDao.getById(truckId);
            // check truck exists
            if (truck == null) {
                throw new WrongIdException(">>> Exception: No truck exists");
            }

            TruckDTO truckDTO = new TruckDTO(truck.getId(), truck.getRegNum(), truck.getDriverCount(),
                    truck.getCapacity(), truck.getTruckStatus(), truck.getCity(), truck.getDeleted());
            return truckDTO;

        } catch (WrongIdException e) {
            LOG.error("getTruck", e);
            return null;
        } finally {
            if (truckDao.getEm().isOpen()) {
                truckDao.getEm().close();
            }
        }
    }

    /**
     * updates specified truck
     *
     * @param truckDTO truck to update
     * @return specified truck int DTO object
     */
    @Override
    public TruckDTO updateTruck(TruckDTO truckDTO) {
        LOG.info("update truck");
        try {
            // check input
            if (truckDTO == null) {
                throw new WrongIdException(">>> Exception: truck id was not valid");
            }

            // transfer to entity
            Truck truck = new Truck(truckDTO.getRegNum(), truckDTO.getDriverCount(), truckDTO.getCapacity(),
                    truckDTO.getTruckStatus(), truckDTO.getCity());
            truck.setId(truckDTO.getId());
            // and update truck
            truckDao.getEm().getTransaction().begin();
            Truck newTruck = truckDao.update(truck);
            truckDao.getEm().getTransaction().commit();

            // check truck was added successfully
            if (newTruck == null) {
                throw new WrongIdException(">>> Exception: truck was not added for some reason");
            }

            // construct DTO object and return it back
            truckDTO.setRegNum(newTruck.getRegNum());
            truckDTO.setDriverCount(newTruck.getDriverCount());
            truckDTO.setCapacity(newTruck.getCapacity());
            truckDTO.setTruckStatus(newTruck.getTruckStatus());
            truckDTO.setCity(newTruck.getCity());

            return truckDTO;
        } catch (WrongIdException e) {
            LOG.error("update truck", e);
            return null;
        } finally {
            if (truckDao.getEm().getTransaction().isActive()) {
                truckDao.getEm().getTransaction().rollback();
            }
            if (truckDao.getEm().isOpen()) {
                truckDao.getEm().close();
            }
        }
    }

    /**
     * creating new cargo with its waypoints
     *
     * @param cargoDTO cargo to add, contains the list of its waypoints
     * @return added cargo
     */
    @Override
    public CargoDTO addCargo(CargoDTO cargoDTO) {
        LOG.info("add cargo");
        try {
            // check input
            if (cargoDTO == null) {
                throw new WrongIdException(">>> Exception: cargo id was not valid");
            }

            List<Waypoint> waypointList = cargoDTO.getFullWaypoints();
            // ensure it is clear as we are going to add som info there
//            cargoDTO.getFullWaypoints().clear();
            // entity object for transaction
            Cargo cargo = new Cargo();
            cargo.setCargoName(cargoDTO.getCargoName());
            cargo.setWeight(cargoDTO.getWeight());
            cargo.setCargoStatus(cargoDTO.getCargoStatus());
            // initializing the list of waypoints
            cargo.setWaypoints(new ArrayList<Waypoint>());

            // begin transaction
            cargoDao.getEm().getTransaction().begin();
            // create cargo
            Cargo newCargo = cargoDao.create(cargo);
            // creating waypoints
            for (Waypoint waypoint : waypointList) {
                Waypoint tmpWay = waypointDao.create(waypoint);
                // setting link to created cargo
                tmpWay.setCargo(newCargo);
                // adding waypoint to waypoints list in cargo
                newCargo.getWaypoints().add(tmpWay);
                // update waypoint in database
                tmpWay = waypointDao.update(tmpWay);
            }
            // update cargo in database
            newCargo = cargoDao.update(newCargo);
            // end of transaction
            cargoDao.getEm().getTransaction().commit();

            // transfer data to dto object and return it
            cargoDTO.setId(newCargo.getId());
            cargoDTO.setCargoName(newCargo.getCargoName());
            cargoDTO.setCargoStatus(newCargo.getCargoStatus());
            cargoDTO.setWeight(newCargo.getWeight());
            // adding waypoints
            cargoDTO.setFullWaypoints(newCargo.getWaypoints());
            if (!cargoDTO.getWaypoints().isEmpty()) {
                // will fill in the data from new cargo
                cargoDTO.getWaypoints().clear();
            }
            // fill in the list
            for (Waypoint waypoint : newCargo.getWaypoints()) {
                cargoDTO.getWaypoints().add(waypoint.getId());
            }

            return cargoDTO;
        } catch (WrongIdException e) {
            LOG.error("add cargo", e);
            return null;
        } finally {
            if (cargoDao.getEm().getTransaction().isActive()) {
                cargoDao.getEm().getTransaction().rollback();
            }
            if (cargoDao.getEm().isOpen()) {
                cargoDao.getEm().close();
            }
        }
    }

    /**
     * get the list of all unassigned cargos to add in the order
     *
     * @return list of cargos
     */
    @Override
    public List<CargoDTO> getAllUnassignedCargos() {
        LOG.info("get all unassigned cargos");

        try {
            List<Cargo> cargos = cargoDao.getAllUnassigned();
            List<CargoDTO> cargoDTOs = new ArrayList<CargoDTO>();
            for (Cargo cargo : cargos) {
                CargoDTO cargoDTO = new CargoDTO();
                cargoDTO.setId(cargo.getId());
                cargoDTO.setCargoName(cargo.getCargoName());
                cargoDTO.setWeight(cargo.getWeight());
                cargoDTO.setCargoStatus(cargo.getCargoStatus());
                cargoDTO.setFullWaypoints(cargo.getWaypoints());
                cargoDTO.setWaypoints(new ArrayList<Long>());
                for (Waypoint waypoint : cargo.getWaypoints()) {
                    cargoDTO.getWaypoints().add(waypoint.getId());
                }
                cargoDTOs.add(cargoDTO);
            }

            return cargoDTOs;
        } catch (Exception e) {
            LOG.error("get all unassigned cargos", e);
            return null;
        } finally {
            if (cargoDao.getEm().isOpen()) {
                cargoDao.getEm().close();
            }
        }
    }

    /**
     * get the list of trucks available for delivery
     *
     * @param cargosIds list of cargos for truck to deliver
     * @return list of trucks
     */
    @Override
    public List<TruckDTO> getAllAvailableTrucks(List<Long> cargosIds) {
        LOG.info("get all available trucks");

        try {
            // creating map of cargos weight balance for the city
            Map<Byte, Integer> waypointWeightMap = new HashMap<Byte, Integer>();
            for (Long cargoId : cargosIds) {
                // find cargo
                Cargo cargo = cargoDao.getById(cargoId);
                int cargoWeight = cargo.getWeight();
                // get waypoints for cargo
                List<Waypoint> waypoints = waypointDao.getByCargoId(cargoId);
                // sorting it
                Collections.sort(waypoints);
                LOG.error("size of waypoints for cargo: " + waypoints.size());
                // adding info for cargo to map
                waypointWeightMap = fillMapCityWeight(waypointWeightMap, cargoWeight, waypoints);
            }

            Map<Byte, Integer> tmpMap = new HashMap<Byte, Integer>();
            tmpMap.putAll(waypointWeightMap);
            int commonweight = 0;
            for (Map.Entry<Byte, Integer> entry : waypointWeightMap.entrySet()) {
                commonweight += entry.getValue();
                tmpMap.put(entry.getKey(), commonweight);
            }
            // check the map
//        LOG.error("waypointWeightMap: " + waypointWeightMap);
            LOG.error("tmpMap: " + tmpMap);
            waypointWeightMap = tmpMap;

            List<TruckDTO> truckDTOs = new ArrayList<TruckDTO>();
            // not broken and no active order
            List<Truck> trucks = truckDao.getAllAvailableTrucks();
            // try to find suitable trucks for deliver
            for (Truck truck : trucks) {
                boolean flag = true;
                // capacity of the truck in tons, should be in kilos for comparison
                int capacity = truck.getCapacity() *  1000;
                // select only available trucks for order
                for (Integer cityWeight : waypointWeightMap.values()) {
                    if (capacity - cityWeight < 0) {
                        flag = false;
                    }
                }
                // if flag is true, add truck to truck list for order
                if (flag) {
                    TruckDTO truckDTO = new TruckDTO();
                    truckDTO.setId(truck.getId());
                    truckDTO.setRegNum(truck.getRegNum());
                    truckDTO.setDriverCount(truck.getDriverCount());
                    truckDTO.setCapacity(truck.getCapacity());
                    truckDTO.setTruckStatus(truck.getTruckStatus());
                    truckDTO.setCity(truck.getCity());
                    truckDTO.setOrders(truck.getOrders());

                    truckDTOs.add(truckDTO);
                    LOG.error("truck ID added: " + truckDTO.getId());
                }
            }

            // return available for order trucks
            return truckDTOs;
        } catch (Exception e) {
            LOG.error("get all available trucks", e);
            return null;
        } finally {
            if (cargoDao.getEm().isOpen()) {
                cargoDao.getEm().close();
            }
        }
    }

    /**
     *
     * fill the map with cities and weight balance
     */
    private Map<Byte, Integer> fillMapCityWeight(Map<Byte, Integer> waypointWeightMap, int cargoWeight, List<Waypoint> waypoints) {
        LOG.info("get all available trucks: fill the map");
        try {
            for (Waypoint waypoint : waypoints) {
                //
                LOG.error(waypoint.getId());
                //
                byte city = waypoint.getCity();
                // if load then add it to the map with plus
                if (waypoint.getCargoType() == 1) {
                    waypointWeightMap.put(city, waypointWeightMap.get(city) == null ? cargoWeight : waypointWeightMap.get(city) + cargoWeight);
                } else {
                    waypointWeightMap.put(city, waypointWeightMap.get(city) == null ? -cargoWeight : waypointWeightMap.get(city) - cargoWeight);
                }
            }
            return waypointWeightMap;
        } catch (Exception e) {
            LOG.error("get all available trucks: fill the map", e);
            return null;
        }
    }

    /**
     * get all available drivers for truck
     * @param truckId   specified truck id
     * @param cargosIds
     * @return          list of drivers
     */
    @Override
    public List<UserDTO> getAllAvailableDrivers(long truckId, List<Long> cargosIds) {
        LOG.info("get all available drivers for order and truck");
        try {
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
                    if (order != null && order.getOrderStatus() == 2) {
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
            LOG.error("get all available drivers for order and truck:\n" + driLongList);
            // check done

            // convert drivers to UserDTOs
            List<UserDTO> userDTOs = new ArrayList<UserDTO>();
            for (User driver : driversWithoutOrder) {
                UserDTO userDTO = new UserDTO();
                // convert
                userDTO.setId(driver.getId());
                userDTO.setFirstName(driver.getFirstName());
                userDTO.setLastName(driver.getLastName());
                userDTO.setLogin(driver.getLogin());
                userDTO.setPassword(driver.getPassword());
                userDTO.setRole(driver.getRole());
                userDTO.setHours(driver.getHours());
                userDTO.setUserStatus(driver.getUserStatus());
                userDTO.setCity(driver.getCity());
                userDTO.setTruck(driver.getTruck());
                userDTO.setOrders(driver.getOrders());
                // adding to list
                userDTOs.add(userDTO);
            }

            return userDTOs;
        } catch (Exception e) {
            LOG.error("get all available drivers for order and truck", e);
            return null;
        }
    }

    @Override
    public OrderDTO addOrder(List<Long> cargoIds, TruckDTO truckDTO, List<Long> userIds) {
        LOG.info("add order");
        try {

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

            // get truck to add in order
            Truck truck = new Truck();
            truck.setId(truckDTO.getId());
            truck.setRegNum(truckDTO.getRegNum());
            truck.setDriverCount(truckDTO.getDriverCount());
            truck.setCapacity(truckDTO.getCapacity());
            truck.setTruckStatus(truckDTO.getTruckStatus());
            truck.setCity(truckDTO.getCity());
            // creating drivers list if it's still empty for any reason
            if (truck.getDrivers() == null || truck.getDrivers().isEmpty()) {
                truck.setDrivers(userList);
            } else {
                truck.getDrivers().addAll(userList);
            }
            truck.setOrders(truckDTO.getOrders());
            // end of truck creating

            // create order
            Order order = new Order();
            order.setOrderStatus((byte) 2);
            order.setWaypoints(waypointList);
            order.setTruck(truck);
            order.setDrivers(userList);

            // begin transaction
            orderDao.getEm().getTransaction().begin();
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
            // transaction ends
            orderDao.getEm().getTransaction().commit();

            // list of users ids long for dto object
            Set<Long> userLongs = new HashSet<Long>();
            for (User user : orderNew.getDrivers()) {
                userLongs.add(user.getId());
            }

            // list of waypoints for user
            Set<Long> wayslong = new HashSet<Long>();
            for (Waypoint waypoint : order.getWaypoints()) {
                wayslong.add(waypoint.getId());
            }

            OrderDTO orderDTO = new OrderDTO(orderNew.getId(), orderNew.getOrderStatus(),
                    wayslong, orderNew.getTruck(), userLongs, (byte) 0);

            return orderDTO;
        } catch (Exception e) {
            LOG.error("add order", e);
            return null;
        } finally {
            // rollback transaction in case of any error
            if (orderDao.getEm().getTransaction().isActive()) {
                orderDao.getEm().getTransaction().rollback();
            }

            if (orderDao.getEm().isOpen()) {
                orderDao.getEm().close();
            }
        }
    }
}
