package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.dao.GenericDaoImpl;
import com.mkhldvdv.logiweb.entities.Cargo;

import javax.persistence.EntityManager;

/**
 * Created by mkhldvdv on 24.11.2015.
 */
public class CargoDaoImpl extends GenericDaoImpl<Cargo> {

    public CargoDaoImpl(EntityManager em) {
        super(em);
    }
}
