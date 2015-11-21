package com.mkhldvdv.logiweb.services.impl;

import com.mkhldvdv.logiweb.dao.impl.CityDao;
import com.mkhldvdv.logiweb.dao.impl.DriverDao;
import com.mkhldvdv.logiweb.dao.impl.TruckDao;
import com.mkhldvdv.logiweb.dao.impl.TruckStatusDao;
import com.mkhldvdv.logiweb.entities.*;
import com.mkhldvdv.logiweb.exceptions.RegNumNotMatchException;
import com.mkhldvdv.logiweb.services.AdminService;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.List;
import java.util.regex.Pattern;

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
     * @return new truck
     */
    @Override
    public Truck addTruck(Truck truck) {
        TruckDao truckDao = new TruckDao();
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("Logiweb");
        try {
            // check the regNum, should be 2 latin letters and 5 digits
            boolean matches = matchRegNum(truck.getRegNum());
            if (!matches) throw new RegNumNotMatchException("regNum of the truck doesn't match " +
                    "the pattern of 2 latin letters followed by 5 digits");

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
            if (truckDao.em != null && truckDao.em.getTransaction().isActive()) {
                truckDao.em.getTransaction().rollback();
                truckDao.em.close();
            }
            emf.close();
        }
    }

    private boolean matchRegNum(String regNum) {
        return Pattern.matches("[a-zA-Z]{2}[0-9]{5}", regNum);
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
            if (truckDao.em != null && truckDao.em.getTransaction().isActive()) {
                truckDao.em.getTransaction().rollback();
                truckDao.em.close();
            }
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
            // check the regNum, should be 2 latin letters and 5 digits
            boolean matches = matchRegNum(truck.getRegNum());
            if (!matches) throw new RegNumNotMatchException("regNum of the truck doesn't match " +
                    "the pattern of 2 latin letters followed by 5 digits");

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
            if (truckDao.em != null && truckDao.em.getTransaction().isActive()) {
                truckDao.em.getTransaction().rollback();
                truckDao.em.close();
            }
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
        DriverDao driverDao = new DriverDao();
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("Logiweb");
        try {
            driverDao.em = emf.createEntityManager();
            return driverDao.getAll();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            driverDao.em.close();
            emf.close();
        }
    }

    /**
     * adds new driver
     *
     * @param driver driver to add
     * @return new driver
     */
    @Override
    public Driver addDriver(Driver driver) {
        DriverDao driverDao = new DriverDao();
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("Logiweb");
        try {
            //toDo when creating the driver, user should be created as well
            driverDao.em = emf.createEntityManager();
            driverDao.em.getTransaction().begin();
            Driver newDriver = driverDao.create(driver);
            driverDao.em.flush();
            driverDao.em.getTransaction().commit();
            return newDriver;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (driverDao.em != null && driverDao.em.getTransaction().isActive()) {
                driverDao.em.getTransaction().rollback();
                driverDao.em.close();
            }
            emf.close();
        }
    }

    /**
     * delete the specified driver
     *
     * @param driver driver to delete
     */
    @Override
    public void deleteDriver(Driver driver) {
        DriverDao driverDao = new DriverDao();
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("Logiweb");
        try {
            driverDao.em = emf.createEntityManager();
            driverDao.em.getTransaction().begin();
            driverDao.remove(driver);
            driverDao.em.flush();
            driverDao.em.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (driverDao.em != null && driverDao.em.getTransaction().isActive()) {
                driverDao.em.getTransaction().rollback();
                driverDao.em.close();
            }
            emf.close();
        }
    }

    /**
     * updates the specified driver
     *
     * @param driver driver to update
     * @return updated driver
     */
    @Override
    public Driver updateDriver(Driver driver) {
        DriverDao driverDao = new DriverDao();
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("Logiweb");
        try {
            driverDao.em = emf.createEntityManager();
            driverDao.em.getTransaction().begin();
            Driver driverUpd = driverDao.update(driver);
            driverDao.em.flush();
            driverDao.em.getTransaction().commit();
            return driverUpd;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (driverDao.em != null && driverDao.em.getTransaction().isActive()) {
                driverDao.em.getTransaction().rollback();
                driverDao.em.close();
            }
            emf.close();
        }
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
     * @param order order to update
     * @return updated order
     */
    @Override
    public Order updateOrder(Order order) {
        return null;
    }

    /**
     * gets the specified order
     *
     * @param order order to view
     * @return specified order
     */
    @Override
    public Order getOrder(Order order) {
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
     * @param cargo cargo to update
     * @return updated cargo
     */
    @Override
    public Cargo updateCargo(Cargo cargo) {
        return null;
    }

    /**
     * gets the specified cargo
     *
     * @param cargo cargo to view
     * @return specified cargo
     */
    @Override
    public Cargo getCargo(Cargo cargo) {
        return null;
    }

    /**
     * assign drivers according to shift number, driver status and time limit
     *
     * @param truck id of the truck
     * @return list of assigned drivers
     */
    @Override
    public List<Driver> assignDrivers(Truck truck) {
        return null;
    }

    // check
    public static void main(String[] args) {

        EntityManagerFactory emf = Persistence.createEntityManagerFactory("Logiweb");
        try {
            // prepare starts
            CityDao cityDao = new CityDao();
            TruckStatusDao truckStatusDao = new TruckStatusDao();

            cityDao.em = emf.createEntityManager();
            City city = cityDao.getByName("paris");

            truckStatusDao.em = emf.createEntityManager();
            TruckStatus truckStatus = truckStatusDao.getByDescription("valid");
            // prepare ends

            AdminServiceImp adm = new AdminServiceImp();
            // check adding
//            Truck newTruck = new Truck("фx55555", (byte) 1, (byte) 5, truckStatus, city);
//            newTruck = adm.addTruck(newTruck);

            // check updating
//            TruckDao truckDao = new TruckDao();
//            truckDao.em = emf.createEntityManager();
//            Truck newTruck = truckDao.getTruckByRegNum("zz54321");
//            newTruck.setTruckStatus(truckStatus);
//            newTruck = adm.updateTruck(newTruck);

            // check deleting
            TruckDao truckDao = new TruckDao();
            truckDao.em = emf.createEntityManager();
            Truck newTruck = truckDao.getTruckByRegNum("zz54321");
            adm.deleteTruck(newTruck);

            List<Truck> trucks = adm.getAllTrucks();

            for (Truck truck : trucks) {
                System.out.println(truck);
            }
        } finally {
            emf.close();
        }
    }
}
