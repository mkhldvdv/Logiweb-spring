package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.dao.GenericDaoImpl;
import com.mkhldvdv.logiweb.entities.Truck;

import javax.persistence.EntityManager;

/**
 * Created by mkhldvdv on 24.11.2015.
 */
public class TruckDaoImpl extends GenericDaoImpl<Truck> {

    public TruckDaoImpl(EntityManager em) {
        super(em);
    }
}
