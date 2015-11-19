package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.dao.GenericDaoImpl;
import com.mkhldvdv.logiweb.entities.TruckStatus;

/**
 * Created by mkhldvdv on 19.11.2015.
 */
public class TruckStatusDao extends GenericDaoImpl<TruckStatus> {

    /**
     * This method search the TruckStatus entity by the name of this entity.
     *
     * @param name name of the status (valid/not valid)
     * @return TruckStatus entity
     */
    public TruckStatus getByDescription(String name) {
        return em.createQuery("select ts from TruckStatus ts where ts.truckStatusName = :name", TruckStatus.class)
                .setParameter("name", name)
                .getSingleResult();
    }
}
