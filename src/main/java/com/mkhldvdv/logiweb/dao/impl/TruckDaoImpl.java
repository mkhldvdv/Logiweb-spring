package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.dao.GenericDaoImpl;
import com.mkhldvdv.logiweb.entities.Truck;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Created by mkhldvdv on 25.11.2015.
 */

@Component
public class TruckDaoImpl extends GenericDaoImpl<Truck> {

    private static final Logger LOG = LogManager.getLogger(TruckDaoImpl.class);

    /**
     * returns truck specified by registration number
     * @param regNum    registration number
     * @return          truck
     */
//    public Truck getTruckByRegNum(String regNum) {
//        LOG.info("TruckDao: getTruckByRegNum(" + regNum + ")");
//        return em.createQuery("select t from Truck t where t.regNum = :regNum", Truck.class)
//                .setParameter("regNum", regNum)
//                .getSingleResult();
//    }

    /**
     * get all not deleted trucks
     * @return list of trucks
     */
//    public List<Truck> getAllNotDeletedTrucks() {
//        return em.createQuery("select t from Truck t " +
//                "where t.deleted = :deleted", Truck.class)
//                .setParameter("deleted", (byte) 1)
//                .getResultList();
//    }

    /**
     * get the list of trucks, not broken and with no current active orders
     * @return  list of trucks
     */
    public List<Truck> getAllAvailableTrucks() {
        LOG.info("TruckDao: getAllAvailableTrucks()");
        return em.createQuery("select t from Truck t where t.truckStatusId = 1 " +
                "and t.deleted = 0 " +
                "and not exists (select 1 from Order o " +
                "where o.orderStatusId = 2 and o.truck = t) order by t.id desc", Truck.class)
                .getResultList();
    }

    /**
     * get not deleted truck by its id
     * @param truckId   specified truck
     * @return          not deleted truck
     */
    public Truck getNotDeletedTruckById(long truckId) {
        LOG.info("TruckDao: getNotDeletedTruckById(" + truckId + ")");
        return em.createQuery("select t from Truck t where t.deleted = 0" +
                "and t.id = :truckID", Truck.class)
                .setParameter("truckID", truckId)
                .getSingleResult();
    }
}
