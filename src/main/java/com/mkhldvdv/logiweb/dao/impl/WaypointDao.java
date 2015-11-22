package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.dao.GenericDaoImpl;
import com.mkhldvdv.logiweb.entities.Cargo;
import com.mkhldvdv.logiweb.entities.Waypoint;

import java.util.List;

/**
 * Created by mkhldvdv on 19.11.2015.
 */
public class WaypointDao extends GenericDaoImpl<Waypoint> {

    /**
     * returns waypoints list by cargo id
     * @param cargo id of specified cargo
     * @return  the list of waypoints
     */
    public List<Waypoint> getWayPointsByCargoId(long cargo) {
        return em.createQuery("select w from Waypoint w where " +
                "w.cargos.id = :cargo", Waypoint.class)
                .setParameter("cargo", cargo)
                .getResultList();
    }

    /**
     * returns waypoints list by order id
     * @param order id of the specified order
     * @return  the list of waypoints
     */
    public List<Waypoint> getWayPointsByOrderId(long order) {
        return em.createQuery("select w from Waypoint w where " +
                "w.order.id = :order", Waypoint.class)
                .setParameter("order", order)
                .getResultList();
    }
}
