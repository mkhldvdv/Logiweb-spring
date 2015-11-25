package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.dao.GenericDaoImpl;
import com.mkhldvdv.logiweb.entities.Order;

import javax.persistence.EntityManager;

/**
 * Created by mkhldvdv on 24.11.2015.
 */
public class OrderDaoImpl extends GenericDaoImpl<Order> {

    public OrderDaoImpl(EntityManager em) {
        super(em);
    }


}
