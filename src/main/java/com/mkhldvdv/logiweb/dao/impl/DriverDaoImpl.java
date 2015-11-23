package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.dao.GenericDaoImpl;
import com.mkhldvdv.logiweb.entities.Driver;
import com.mkhldvdv.logiweb.entities.Truck;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.List;

/**
 * Created by mkhldvdv on 19.11.2015.
 */
public class DriverDaoImpl extends GenericDaoImpl<Driver> {

    /**
     * searching for the driver by its id number
     *
     * @param user  id number of the driver
     * @return      Driver entity
     */
    public Driver getByUserId(long user) {
        return em.createQuery("select d from Driver d join d.user u where u.id = :user", Driver.class)
                .setParameter("user", user)
                .getSingleResult();
    }

    /**
     * searching for drivers assigned to the truck
     *
     * @param truck truck id
     * @return  list of drivers
     */
    public List<Driver> getByTruckId(long truck) {
        return em.createQuery("select d from Driver d where d.truck.id = :truck", Driver.class)
                .setParameter("truck", truck)
                .getResultList();
    }

    /**
     * searching for available drivers in the city where the truck is
     *
     * @param truck searching the drivers for this truck
     * @return      list of available drivers for the truck
     */
    public List<Driver> getAvailableDriversCity(Truck truck) {
        return em.createQuery("select d from Driver d join d.driverStatus ds " +
                "where d.truck != :truck and d.city = :city and ds.id = :available and not exists " +
                "(select 1 from OrderDriver od join od.order o join o.orderStatus os " +
                "where od.driver = d and os.id != :notDone)", Driver.class)
                .setParameter("truck", truck)
                .setParameter("city", truck.getCity())
                .setParameter("available", 1L)
                .setParameter("notDone", 1L)
                .getResultList();
    }

    // check
//    public static void main(String[] args) {
//        DriverDaoImpl driver = new DriverDaoImpl();
//        EntityManagerFactory emf = Persistence.createEntityManagerFactory("Logiweb");
//        try {
//            driver.em = emf.createEntityManager();
//            TruckDaoImpl truck = new TruckDaoImpl();
//            truck.em = emf.createEntityManager();
//
////            List<Driver> driverList = driver.getAll();
////            for (Driver driver1 : driverList) {
////                System.out.println(driver1);
////            }
//
//            Driver driver2 = driver.getByUserId(1);
//            System.out.println(driver2);
//
//            List<Driver> drivers = driver.getAvailableDriversCity(truck.getTruckByRegNum("aa12345"));
//            for (Driver driver1 : drivers) System.out.println(driver1);
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        } finally {
//            driver.em.close();
//            emf.close();
//        }
//    }
}