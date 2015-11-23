package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.dao.GenericDaoImpl;
import com.mkhldvdv.logiweb.entities.DriverStatus;

/**
 * Created by mkhldvdv on 19.11.2015.
 */
public class DriverStatusDaoImpl extends GenericDaoImpl<DriverStatus> {

    /**
     * This method search the DriverStatus entity by the name of this entity.
     *
     * @param name name of the status (vacancy/shift/driving)
     * @return DriverStatus entity
     */
    public DriverStatus getByDescription(String name) {
        return em.createQuery("select cs from DriverStatus cs where cs.driverStatusName = :name", DriverStatus.class)
                .setParameter("name", name)
                .getSingleResult();
    }
}
