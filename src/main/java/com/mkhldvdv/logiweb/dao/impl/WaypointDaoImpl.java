package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.dao.GenericDaoImpl;
import com.mkhldvdv.logiweb.entities.Waypoint;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Created by mkhldvdv on 25.11.2015.
 */

@Component
public class WaypointDaoImpl extends GenericDaoImpl<Waypoint> {

    private static final Logger LOG = LogManager.getLogger(WaypointDaoImpl.class);

    /**
     * get all waypoint by cargo id
     * @param cargoId specified cargo
     * @return        list of waypoints for cargo
     */
    public List<Waypoint> getByCargoId(Long cargoId) {
        LOG.info("WaypointDao: getByCargoId(" + cargoId + ")");
        return em.createQuery("select w from Waypoint w where w.cargo.id = :cargo", Waypoint.class)
                .setParameter("cargo", cargoId)
                .getResultList();
    }
}
