package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.dao.GenericDaoImpl;
import com.mkhldvdv.logiweb.entities.Truck;

import java.util.List;

/**
 * Created by mkhldvdv on 25.11.2015.
 */
public class TruckDaoImpl extends GenericDaoImpl<Truck> {

    /**
     * returns truck specified by registration number
     * @param regNum    registration number
     * @return          truck
     */
    public Truck getTruckByRegNum(String regNum) {
        return em.createQuery("select t from Truck t where t.regNum = :regNum", Truck.class)
                .setParameter("regNum", regNum)
                .getSingleResult();
    }

    /**
     * get all not deleted trucks
     * @return list of trucks
     */
    public List<Truck> getAllNotDeletedTrucks() {
        return em.createQuery("select t from Truck t " +
                "where t.deleted = :deleted")
                .setParameter("deleted", false)
                .getResultList();
    }

    /**
     * get the list of trucks, not broken and with no current active orders
     * @return  list of trucks
     */
    public List<Truck> getAllAvailableTrucks() {
        return em.createQuery("select t from Truck t where t.truckStatus = 1 " +
                "and not exists (select 1 from Order o " +
                "where o.orderStatus = 2 and o.truck = t) order by t.id desc", Truck.class)
                .getResultList();
    }
}
