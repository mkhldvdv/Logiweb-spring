package com.mkhldvdv.logiweb.services.impl;

import com.mkhldvdv.logiweb.dao.impl.CityDao;
import com.mkhldvdv.logiweb.dao.impl.TruckDao;
import com.mkhldvdv.logiweb.dao.impl.TruckStatusDao;
import com.mkhldvdv.logiweb.entities.*;
import com.mkhldvdv.logiweb.services.AdminService;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.List;

/**
 * Created by mkhldvdv on 21.11.2015.
 */
public class AdminServiceImp implements AdminService {
    /**
     * gets all trucks
     *
     * @return the list of all trucks
     */
    @Override
    public List<Truck> getAllTrucks() {
        TruckDao truckDao = new TruckDao();
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("Logiweb");
        try {
            truckDao.em = emf.createEntityManager();
            return truckDao.getAll();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            truckDao.em.close();
            emf.close();
        }
    }

    /**
     * adds new truck
     *
     * @param truck truck to add
     * @return  new truck
     */
    @Override
    public Truck addTruck(Truck truck) {
        TruckDao truckDao = new TruckDao();
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("Logiweb");
        try {
            truckDao.em = emf.createEntityManager();
            truckDao.em.getTransaction().begin();
            Truck newTruck = truckDao.create(truck);
            truckDao.em.flush();
            truckDao.em.getTransaction().commit();
            return newTruck;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (truckDao.em.getTransaction().isActive()) truckDao.em.getTransaction().rollback();
            truckDao.em.close();
            emf.close();
        }
    }

    /**
     * deletes the specified truck
     *
     * @param truck truck to delete
     */
    @Override
    public void deleteTruck(Truck truck) {
        TruckDao truckDao = new TruckDao();
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("Logiweb");
        try {
            truckDao.em = emf.createEntityManager();
            truckDao.em.getTransaction().begin();
            truckDao.remove(truck);
            truckDao.em.flush();
            truckDao.em.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (truckDao.em.getTransaction().isActive()) truckDao.em.getTransaction().rollback();
            truckDao.em.close();
            emf.close();
        }
    }

    /**
     * updates the specified truck
     *
     * @param truck truck to update
     * @return updated truck
     */
    @Override
    public Truck updateTruck(Truck truck) {
        TruckDao truckDao = new TruckDao();
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("Logiweb");
        try {
            truckDao.em = emf.createEntityManager();
            truckDao.em.getTransaction().begin();
            Truck truckUpd = truckDao.update(truck);
            truckDao.em.flush();
            truckDao.em.getTransaction().commit();
            return truckUpd;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (truckDao.em.getTransaction().isActive()) truckDao.em.getTransaction().rollback();
            truckDao.em.close();
            emf.close();
        }
    }

    /**
     * gets all drivers
     *
     * @return the list of drivers
     */
    @Override
    public List<Driver> getAllDrivers() {
        return null;
    }

    /**
     * adds new driver
     *
     * @param driver driver to add
     * @return id of the new truck
     */
    @Override
    public long addDriver(Driver driver) {
        return 0;
    }

    /**
     * delete the specified driver
     *
     * @param id driver to delete
     */
    @Override
    public void deleteDriver(long id) {

    }

    /**
     * updates the specified driver
     *
     * @param id driver to update
     * @return updated driver
     */
    @Override
    public Driver updateDriver(long id) {
        return null;
    }

    /**
     * gets all orders
     *
     * @return the list of orders
     */
    @Override
    public List<Order> getAllOrders() {
        return null;
    }

    /**
     * updates the specified order
     *
     * @param id order to update
     * @return updated order
     */
    @Override
    public Order updateOrder(long id) {
        return null;
    }

    /**
     * gets the specified order
     *
     * @param id order to view
     * @return specified order
     */
    @Override
    public Order getOrder(long id) {
        return null;
    }

    /**
     * gets all cargos
     *
     * @return the list of cargos
     */
    @Override
    public List<Cargo> getAllCargos() {
        return null;
    }

    /**
     * updates the specified cargo
     *
     * @param id cargo to update
     * @return updated cargo
     */
    @Override
    public Cargo updateCargo(long id) {
        return null;
    }

    /**
     * gets the specified cargo
     *
     * @param id cargo to view
     * @return specified cargo
     */
    @Override
    public Cargo getCargo(long id) {
        return null;
    }

    /**
     * assign drivers according to shift number, driver status and time limit
     *
     * @param truck id of the truck
     * @return list of assigned drivers
     */
    @Override
    public List<Driver> assignDrivers(long truck) {
        return null;
    }

    // check
    public static void main(String[] args) {

        // prepare starts
        CityDao cityDao = new CityDao();
        TruckStatusDao truckStatusDao = new TruckStatusDao();
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("Logiweb");

        cityDao.em = emf.createEntityManager();
        City city = cityDao.getById((long) 3);
        cityDao.em.close();

        truckStatusDao.em = emf.createEntityManager();
        TruckStatus truckStatus = truckStatusDao.getByDescription("valid");
        truckStatusDao.em.close();

        emf.close();
        // prepare ends

        AdminServiceImp adm = new AdminServiceImp();
        Truck newTruck = new Truck("xx55555", (byte) 2, (byte) 15, truckStatus, city);

        newTruck= adm.addTruck(newTruck);

        List<Truck> trucks = adm.getAllTrucks();

        for (Truck truck : trucks) {
            System.out.println(truck);
        }
    }
}
