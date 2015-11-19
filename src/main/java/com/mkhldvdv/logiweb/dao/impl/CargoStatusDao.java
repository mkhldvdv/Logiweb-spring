package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.dao.GenericDaoImpl;
import com.mkhldvdv.logiweb.entities.CargoStatus;

/**
 * Created by mkhldvdv on 19.11.2015.
 */
public class CargoStatusDao extends GenericDaoImpl<CargoStatus> {

    /**
     * This method search the CargoStatus entity by the name of this entity.
     *
     * @param name name of the status (ready/unloaded/delivered)
     * @return CargoStatus entity
     */
    public CargoStatus getByDescription(String name) {
        return em.createQuery("select cs from CargoStatus cs where cs.cargoStatusName = :name", CargoStatus.class)
                .setParameter("name", name)
                .getSingleResult();
    }
}
