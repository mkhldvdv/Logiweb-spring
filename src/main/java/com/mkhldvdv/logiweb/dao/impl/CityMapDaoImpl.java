package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.dao.GenericDaoImpl;
import com.mkhldvdv.logiweb.entities.CityMap;

import javax.persistence.EntityManager;

/**
 * Created by mkhldvdv on 24.11.2015.
 */
public class CityMapDaoImpl extends GenericDaoImpl<CityMap> {

    public CityMapDaoImpl(EntityManager em) {
        super(em);
    }
}
