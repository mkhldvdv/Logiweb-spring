package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.dao.GenericDaoImpl;
import com.mkhldvdv.logiweb.entities.Cargo;
import com.mkhldvdv.logiweb.entities.Waypoint;

import javax.persistence.EntityManager;
import java.util.List;

/**
 * Created by mkhldvdv on 24.11.2015.
 */
public class WaypointDaoImpl extends GenericDaoImpl<Waypoint> {

    public WaypointDaoImpl(EntityManager em) {
        super(em);
    }

}
