package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.dao.GenericDaoImpl;
import com.mkhldvdv.logiweb.entities.OrderStatus;

/**
 * Created by mkhldvdv on 19.11.2015.
 */
public class OrderStatusDao extends GenericDaoImpl<OrderStatus> {

    /**
     * This method search the OrderStatus entity by the name of this entity.
     *
     * @param name name of the status (done/not done)
     * @return DriverStatus entity
     */
    public OrderStatus getByDescription(String name) {
        return em.createQuery("select cs from OrderStatus cs where cs.orderStatusName = :name", OrderStatus.class)
                .setParameter("name", name)
                .getSingleResult();
    }
}
