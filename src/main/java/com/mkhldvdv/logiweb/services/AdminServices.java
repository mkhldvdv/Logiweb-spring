package com.mkhldvdv.logiweb.services;

import com.mkhldvdv.logiweb.dto.CargoDTO;
import com.mkhldvdv.logiweb.dto.OrderDTO;
import com.mkhldvdv.logiweb.dto.TruckDTO;
import com.mkhldvdv.logiweb.dto.UserDTO;
import com.mkhldvdv.logiweb.entities.Cargo;
import com.mkhldvdv.logiweb.entities.Order;
import com.mkhldvdv.logiweb.entities.Truck;
import com.mkhldvdv.logiweb.entities.User;
import com.mkhldvdv.logiweb.exceptions.RegNumNotMatchException;
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
    public List<TruckDTO> getTrucks();

    /**
     * get the list of all drivers
     * @return
     */
    public List<UserDTO> getDrivers();

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
     * get the full info about the cargo
     * @param cargoId   cargo id
     * @return  specified cargo
     */
    public CargoDTO getCargo(long cargoId) throws WrongIdException;

    /**
     * adds new user/driver
     * @param userDTO   new user to add
     * @return          id number of added user
     */
    UserDTO addUser(UserDTO userDTO);


    /**
     * updates existing user
     * @param userDTO   user to update
     * @return          updated user
     */
    UserDTO updateUser(UserDTO userDTO, boolean hashed);

    /**
     * deletes specified user
     * @param userId    user to delete
     */
    void deleteUser(long userId);

    /**
     * adds new truck
     * @param truckDTO  truck to add
     * @return  added truck
     */
    TruckDTO addTruck(TruckDTO truckDTO);

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
    TruckDTO getTruck(long truckId);

    /**
     * updates specified truck
     * @param truckDTO  truck id to update
     * @return         specified truck int DTO object
     */
    TruckDTO updateTruck(TruckDTO truckDTO);

    /**
     * creating new cargo with its waypoints
     * @param cargoDTO  cargo to add, contains the list of its waypoints
     * @return          added cargo
     */
    CargoDTO addCargo(CargoDTO cargoDTO);

    /**
     * get the list of all unassigned cargos to add in the order
     * @return  list of cargos
     */
    List<CargoDTO> getAllUnassignedCargos();

    /**
     * get the list of trucks available for delivery
     * @param cargosIds list of cargos for truck to deliver
     * @return  list of trucks
     */
    List<TruckDTO> getAllAvailableTrucks(List<Long> cargosIds);

    /**
     * get the list of drivers available for the order and truck
     * @param truckId   specified truck id
     * @param cargosIds
     * @return          list of drivers
     */
    List<UserDTO> getAllAvailableDrivers(long truckId, List<Long> cargosIds);

    /**
     * add order into the database with all dependencies
     * @param cargoIds  list of cargos to update with order id
     * @param truckDTO  truck to update with order id
     * @param userIds   list of users to update with order id
     * @return          new added order object
     */
    OrderDTO addOrder(List<Long> cargoIds, TruckDTO truckDTO, List<Long> userIds);
}
