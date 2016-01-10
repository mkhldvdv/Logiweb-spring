package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.dao.GenericDaoImpl;
import com.mkhldvdv.logiweb.entities.CityMap;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Component;

/**
 * Created by mkhldvdv on 25.11.2015.
 */

@Component
public class CityMapDaoImpl extends GenericDaoImpl<CityMap> {

    private static final Logger LOG = LogManager.getLogger(CityMapDaoImpl.class);

    /**
     * returns distance between 2 cities
     * @param city1 first city
     * @param city2 second city
     * @return      distance
     */
    public CityMap getCityMap(byte city1, byte city2) {
        LOG.info("CityMapDao: getCityMap()");
        return em.createQuery("select cm from CityMap cm " +
                "where cm.city1 = :city1 and cm.city2 = :city2", CityMap.class)
                .setParameter("city1", city1)
                .setParameter("city2", city2)
                .getSingleResult();
    }
}
