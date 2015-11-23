package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.dao.GenericDaoImpl;
import com.mkhldvdv.logiweb.entities.Truck;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.List;

/**
 * Created by mkhldvdv on 19.11.2015.
 */
public class TruckDaoImpl extends GenericDaoImpl<Truck> {

    /**
     * searching for truck by registration number
     *
     * @param regnum    registration number of the truck
     * @return          Truck entity
     */
    public Truck getTruckByRegNum(String regnum) {
        return em.createQuery("select t from Truck t where t.regNum = :regNum", Truck.class)
                .setParameter("regNum", regnum)
                .getSingleResult();
    }

    /**
     * searching for all trucks that are available for the order and not broken
     * @return  list of Truck entities
     */
    public List<Truck> getTrucksByStatusWithoutOrder() {
        return em.createQuery("select t from Truck t JOIN t.truckStatus ts " +
                "where ts.id = :valid and not exists (select 1 from Order o " +
                "where o.truck = t and o.orderStatus.id != :notDone)", Truck.class)
                .setParameter("valid", 1L)
                .setParameter("notDone", 1L)
                .getResultList();
    }

    // check
    public static void main(String[] args) {
        TruckDaoImpl truckDaoImpl = new TruckDaoImpl();
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("Logiweb");
        try {
            truckDaoImpl.em = emf.createEntityManager();
            List<Truck> trucks = truckDaoImpl.getTrucksByStatusWithoutOrder();
            for (Truck truck : trucks) {
                System.out.println(truck);
            }

            Truck truck = truckDaoImpl.getTruckByRegNum("aa12345");
            System.out.println(truck);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            truckDaoImpl.em.close();
            emf.close();
        }
    }
}
