package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.dao.GenericDaoImpl;
import com.mkhldvdv.logiweb.entities.CargoType;

/**
 * Created by mkhldvdv on 19.11.2015.
 */
public class CargoTypeDaoImpl extends GenericDaoImpl<CargoType> {

    /**
     * This method search the CargoType entity by the name of this entity.
     *
     * @param name name of the type (loading/unloading)
     * @return CargoType entity
     */
    public CargoType getByDescription(String name) {
        return em.createQuery("select cs from CargoType cs where cs.cargoTypeName = :name", CargoType.class)
                .setParameter("name", name)
                .getSingleResult();
    }
}
