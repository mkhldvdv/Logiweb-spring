package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.dao.GenericDaoImpl;
import com.mkhldvdv.logiweb.entities.Truck;

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
}
