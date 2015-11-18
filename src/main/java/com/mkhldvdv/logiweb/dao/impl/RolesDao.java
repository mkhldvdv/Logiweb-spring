package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.entities.Roles;
import com.mkhldvdv.logiweb.dao.GenericDaoImpl;

public class RolesDao extends GenericDaoImpl<Roles> {

    /**
     *This method search the Roles entity by the name of this entity.
     * @param authority the authority that system user have
     *                  @return Role entity
     */
    public Roles getByDescription(String authority) {
        return em.createQuery("select r from Roles r where r.roleName = :role", Roles.class)
                .setParameter("role", authority)
                .getSingleResult();
    }
}
