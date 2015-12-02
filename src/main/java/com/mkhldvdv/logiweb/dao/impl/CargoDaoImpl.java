package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.dao.GenericDaoImpl;
import com.mkhldvdv.logiweb.entities.Cargo;

import java.util.List;

/**
 * Created by mkhldvdv on 24.11.2015.
 */
public class CargoDaoImpl extends GenericDaoImpl<Cargo> {

    /**
     * get all unassigned cargos
     * @return
     */
    public List<Cargo> getAllUnassigned() {
        return em.createQuery("select w.cargo from Waypoint w " +
                "where w.order is null and w.cargoType = :load", Cargo.class)
                .setParameter("load",(byte) 1)
                .getResultList();
    }
}
