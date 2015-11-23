package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.dao.GenericDaoImpl;
import com.mkhldvdv.logiweb.entities.Order;

/**
 * Created by mkhldvdv on 19.11.2015.
 */
public class OrderDaoImpl extends GenericDaoImpl<Order> {

    /**
     * get the order by truck id
     * @param truck id of the truck
     * @return  order
     */
    public Order getOrderByTruckId(long truck) {
        return em.createQuery("select o from Order o where o.truck.id = :truck", Order.class)
                .setParameter("truck", truck)
                .getSingleResult();
    }
}
