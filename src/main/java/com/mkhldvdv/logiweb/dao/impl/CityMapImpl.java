package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.dao.GenericDaoImpl;
import com.mkhldvdv.logiweb.entities.CityMap;

/**
 * Created by mkhldvdv on 25.11.2015.
 */
public class CityMapImpl extends GenericDaoImpl<CityMap> {

    /**
     * returns distance between 2 cities
     * @param city1 first city
     * @param city2 second city
     * @return      distance
     */
    public int getDistance(String city1, String city2) {
        return em.createQuery("select cm from CityMap cm " +
                "where cm.city1 = :city1 and cm.city2 = :city2", Integer.class)
                .setParameter("city1", city1)
                .setParameter("city2", city2)
                .getSingleResult();
    }
}
