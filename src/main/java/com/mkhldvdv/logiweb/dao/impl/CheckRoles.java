package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.entities.Roles;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.PersistenceContext;
import java.util.List;

/**
 * Created by mkhldvdv on 19.11.2015.
 */
public class CheckRoles {

    @PersistenceContext
    protected EntityManager em;

    public static void main(String[] args) {

        CheckRoles checkRoles = new CheckRoles();
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("Logiweb");
        checkRoles.em = emf.createEntityManager();

        Roles role = new Roles("administrator");
        System.out.println(role);
        Roles role2 = new Roles("operator");
        System.out.println(role2);

        checkRoles.em.getTransaction().begin();
        checkRoles.em.persist(role);
        checkRoles.em.persist(role2);
        checkRoles.em.flush();
        checkRoles.em.getTransaction().commit();

        RolesDao rolesDao = new RolesDao();
        List<Roles> listRoles = rolesDao.getAll();

        for (Roles listRole : listRoles) {
            System.out.println(listRole);
        }
    }
}
