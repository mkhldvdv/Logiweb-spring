package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.entities.Roles;
import com.mkhldvdv.logiweb.dao.GenericDaoImpl;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.List;

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

    // check
    public static void main(String[] args) {
        RolesDao roleDao = new RolesDao();
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("Logiweb");
        roleDao.em = emf.createEntityManager();

        roleDao.em.getTransaction().begin();
        roleDao.em.persist(new Roles("administrator"));
        roleDao.em.flush();
        roleDao.em.getTransaction().commit();

        List<Roles> roles = roleDao.getAll();

        for (Roles role : roles) System.out.println(role);

        roleDao.em.close();
        emf.close();

        System.out.println("close");
    }
}
