package com.mkhldvdv.logiweb.services;

import com.mkhldvdv.logiweb.dto.CargoDTO;
import com.mkhldvdv.logiweb.dto.OrderDTO;
import com.mkhldvdv.logiweb.entities.Cargo;
import com.mkhldvdv.logiweb.entities.Order;
import com.mkhldvdv.logiweb.entities.Truck;
import com.mkhldvdv.logiweb.entities.User;
import com.mkhldvdv.logiweb.exceptions.WrongIdException;

import java.util.List;

/**
 * Created by mkhldvdv on 25.11.2015.
 */
public interface AdminServices {

    /**
     * get the list of all trucks
     * @return  list of trucks
     */
    public List<Truck> getTrucks();

    /**
     * get the list of all drivers
     * @return
     */
    public List<User> getDrivers();

    /**
     * get the list of all orders
     * @return  orders
     */
    public List<OrderDTO> getOrders();

    /**
     * get the full info of order
     * @param orderId   order id
     * @return  specified order
     */
    public OrderDTO getOrder(long orderId) throws WrongIdException;

    /**
     * get specified cargo by its id
     * @param cargoId   cargo id
     * @return          cargo object
     */
    public Cargo getCargoById(long cargoId);

    /**
     * get the full info about the cargo
     * @param cargoId   cargo id
     * @return  specified cargo
     */
    public CargoDTO getCargo(long cargoId) throws WrongIdException;

    /**
     * update cargo object
     * @param cargo cargo object
     * @return      updated cargo object
     */
    public Cargo updateCargo(Cargo cargo);

    /**
     * get specified user by its id
     * @param userId    id of the user
     * @return          user object
     */
    User getUser(long userId);

    /**
     * adds new user/driver
     * @param user   new user to add
     * @return          id number of added user
     */
    User addUser(User user);


    /**
     * updates existing user
     * @param user   user to update
     * @return          updated user
     */
    User updateUser(User user, boolean hashed);

    /**
     * deletes specified user
     * @param userId    user to delete
     */
    void deleteUser(long userId);

    /**
     * adds new truck
     * @param truck  truck to add
     * @return  added truck
     */
    Truck addTruck(Truck truck);

    /**
     * deletes specified truck
     * @param truckId    truck to delete
     */
    void deleteTruck(long truckId) throws WrongIdException;

    /**
     * gets the specified truck
     * @param truckId   truck id
     * @return          specified truck
     */
    Truck getTruck(long truckId);

    /**
     * updates specified truck
     * @param truck  truck id to update
     * @return         specified truck int DTO object
     */
    Truck updateTruck(Truck truck);

    /**
     * creating new cargo with its waypoints
     * @param cargo  cargo to add, contains the list of its waypoints
     * @return          added cargo
     */
    Cargo addCargo(Cargo cargo);

    /**
     * get the list of all unassigned cargos to add in the order
     * @return  list of cargos
     */
    List<Cargo> getAllUnassignedCargos();

    /**
     * get the list of trucks available for delivery
     * @param cargosIds list of cargos for truck to deliver
     * @return  list of trucks
     */
    List<Truck> getAllAvailableTrucks(List<Long> cargosIds);

    /**
     * get the list of drivers available for the order and truck
     * @param truckId   specified truck id
     * @param cargosIds
     * @return          list of drivers
     */
    List<User> getAllAvailableDrivers(long truckId, List<Long> cargosIds);

    /**
     * add order into the database with all dependencies
     * @param cargoIds  list of cargos to update with order id
     * @param truck  truck to update with order id
     * @param userIds   list of users to update with order id
     * @return          new added order object
     */
    Order addOrder(List<Long> cargoIds, Truck truck, List<Long> userIds);
}
