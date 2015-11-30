package com.mkhldvdv.logiweb.services.impl;

import com.mkhldvdv.logiweb.dao.impl.*;
import com.mkhldvdv.logiweb.dto.CargoDTO;
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
    private WaypointDaoImpl waypointDao;

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
            if (truckList.isEmpty()) throw new WrongIdException(">>> Exception: trucks list is empty");

            for (Truck truck : truckList) {
                TruckDTO truckDTO = new TruckDTO(truck.getId(), truck.getRegNum(), truck.getDriverCount(),
                        truck.getCapacity(), truck.getTruckStatus(), truck.getCity(), truck.getDeleted());
                truckDTOList.add(truckDTO);
            }

            return truckDTOList;
        } catch (Exception e) {
            return null;
        } finally {
            if (truckDao.getEm().isOpen()) truckDao.getEm().close();
        }
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
            return null;
        } finally {
            if (userDao.getEm().isOpen()) userDao.getEm().close();
        }
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
                throw new WrongIdException(">>> Exception: orders list is empty");
            }

            for (Order order : orderList) {
                // collect all cities for the order
                Set<Long> waypointsSet = new HashSet<Long>();
                for (Waypoint waypoint : order.getWaypoints()) waypointsSet.add((long) waypoint.getCity());
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
            if (orderDao.getEm().isOpen()) orderDao.getEm().close();
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
        try {
            Order order = orderDao.getById(orderId);
            // check if null
            if (order == null) {
                throw new WrongIdException("Wrong order id");
            }

            Set<Long> waypointsList = new HashSet<Long>();
            Set<Long> driversList = new HashSet<Long>();
            for (Waypoint waypoint : order.getWaypoints()) waypointsList.add((long) waypoint.getCity());
            for (User user : order.getDrivers()) driversList.add(user.getId());
            // complete DTO object
            OrderDTO orderDTO = new OrderDTO(order.getId(), order.getOrderStatus(), waypointsList, order.getTruck(),
                    driversList, order.getDeleted());

            return orderDTO;
        } catch (WrongIdException e) {
            e.printStackTrace();
            return null;
        } finally {
            if (orderDao.getEm().isOpen()) orderDao.getEm().close();
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
        try {
            Cargo cargo = cargoDao.getById(cargoId);
            // check if null
            if (cargo == null) {
                throw new WrongIdException("Wrong cargo id");
            }

            Set<Long> waypointsList = new HashSet<Long>();
            for (Waypoint waypoint : cargo.getWaypoints()) waypointsList.add((long) waypoint.getCity());
            // complete DTO object
            CargoDTO cargoDTO = new CargoDTO(cargo.getId(), cargo.getCargoName(), cargo.getWeight(),
                    cargo.getCargoStatus(), waypointsList, cargo.getDeleted());

            return cargoDTO;
        } catch (WrongIdException e) {
            e.printStackTrace();
            return null;
        } finally {
            if (cargoDao.getEm().isOpen()) cargoDao.getEm().close();
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
        try {
            // check input
            if (userDTO == null) throw new WrongIdException(">>> Exception: added user was null");

            User user = new User(userDTO.getFirstName(), userDTO.getLastName(), userDTO.getLogin(),
                    userDTO.getPassword(), userDTO.getRole(), userDTO.getHours(), userDTO.getUserStatus(),
                    userDTO.getCity(), userDTO.getTruck(), userDTO.getOrders(), userDTO.getDeleted());

            userDao.getEm().getTransaction().begin();
            User newUser = userDao.create(user);
            // check user was added successfully
            if (newUser == null) throw new WrongIdException(">>> Exception: user was not added for some reason");
            userDao.getEm().getTransaction().commit();

            userDTO.setId(newUser.getId());
//            userDTO.setFirstName(newUser.getFirstName());
//            userDTO.setLastName(newUser.getLastName());
//            userDTO.setLogin(newUser.getLogin());
//            userDTO.setPassword(newUser.getPassword());
//            userDTO.setRole(newUser.getRole());
//            userDTO.setHours(newUser.getHours());
//            userDTO.setUserStatus(newUser.getUserStatus());
//            userDTO.setCity(newUser.getCity());
//            userDTO.setTruck(newUser.getTruck());
//            userDTO.setOrders(newUser.getOrders());
//            userDTO.setDeleted(newUser.getDeleted());

            return userDTO;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (userDao.getEm().getTransaction().isActive()) userDao.getEm().getTransaction().rollback();
            if (userDao.getEm().isOpen()) userDao.getEm().close();
        }
    }

    /**
     * updated existing user
     *
     * @param userDTO user to update
     * @return updated user
     */
    @Override
    public UserDTO updateUser(UserDTO userDTO) {
        try {
            // check input
            if (userDTO == null) throw new WrongIdException(">>> Exception: updated user was null");

            User user = new User(userDTO.getFirstName(), userDTO.getLastName(), userDTO.getLogin(),
                    userDTO.getPassword(), userDTO.getRole(), userDTO.getHours(), userDTO.getUserStatus(),
                    userDTO.getCity(), userDTO.getTruck(), userDTO.getOrders(), userDTO.getDeleted());
            user.setId(userDTO.getId());

            // updating user
            userDao.getEm().getTransaction().begin();
            User newUser = userDao.update(user);
            // check user was added successfully
            if (newUser == null) throw new WrongIdException(">>> Exception: user was not added for some reason");
            userDao.getEm().getTransaction().commit();

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
            e.printStackTrace();
            return null;
        } finally {
            if (userDao.getEm().getTransaction().isActive()) userDao.getEm().getTransaction().rollback();
            if (userDao.getEm().isOpen()) userDao.getEm().close();
        }
    }

    /**
     * deletes specified user
     *
     * @param userId user to delete
     */
    @Override
    public void deleteUser(long userId) {
        // check input
        try {
            if (userId == 0 || userId == -1) throw new WrongIdException(">>> Exception: deleted user was 0");
            User user = userDao.getById(userId);
            // delete user
            userDao.getEm().getTransaction().begin();
            userDao.remove(user);
            userDao.getEm().getTransaction().commit();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (userDao.getEm().getTransaction().isActive()) userDao.getEm().getTransaction().rollback();
            if (userDao.getEm().isOpen()) userDao.getEm().close();
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
        try {
            // check input
            if (truckDTO == null) throw new WrongIdException(">>> Exception: added truck was null");

            Truck truck = new Truck(truckDTO.getRegNum(), truckDTO.getDriverCount(), truckDTO.getCapacity(),
                    truckDTO.getTruckStatus(), truckDTO.getCity());

            truckDao.getEm().getTransaction().begin();
            Truck newTruck = truckDao.create(truck);
            // check user was added successfully
            if (newTruck == null) throw new WrongIdException(">>> Exception: truck was not added for some reason");
            truckDao.getEm().getTransaction().commit();

            truckDTO.setId(newTruck.getId());

            return truckDTO;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (truckDao.getEm().getTransaction().isActive()) truckDao.getEm().getTransaction().rollback();
            if (truckDao.getEm().isOpen()) truckDao.getEm().close();
        }
    }

    /**
     * deletes specified truck
     *
     * @param truckId truck to delete
     */
    @Override
    public void deleteTruck(long truckId) throws WrongIdException {
        // check input
        try {
            if (truckId == 0 || truckId == -1) throw new WrongIdException(">>> Exception: deleted truck was 0");
            Truck truck = truckDao.getById(truckId);
            // delete user
            truckDao.getEm().getTransaction().begin();
            truckDao.remove(truck);
            truckDao.getEm().getTransaction().commit();

//        } catch (Exception e) {
//            e.printStackTrace();
        } finally {
            if (truckDao.getEm().getTransaction().isActive()) truckDao.getEm().getTransaction().rollback();
            if (truckDao.getEm().isOpen()) truckDao.getEm().close();
        }
    }
}
