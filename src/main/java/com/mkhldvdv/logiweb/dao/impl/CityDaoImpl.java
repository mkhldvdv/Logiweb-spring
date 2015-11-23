package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.dao.GenericDaoImpl;
import com.mkhldvdv.logiweb.entities.City;

/**
 * Created by mkhldvdv on 19.11.2015.
 */
public class CityDaoImpl extends GenericDaoImpl<City> {

    /**
     * This method search the City entity by the name of this entity.
     *
     * @param name the city
     * @return City entity
     */
    public City getByName(String name) {
        return em.createQuery("select r from City r where r.cityName = :name", City.class)
                .setParameter("name", name)
                .getSingleResult();
    }
}
