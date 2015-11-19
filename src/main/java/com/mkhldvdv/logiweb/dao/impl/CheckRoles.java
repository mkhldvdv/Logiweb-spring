package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.entities.Role;

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

        Role role = new Role("administrator");
        System.out.println(role);
        Role role2 = new Role("operator");
        System.out.println(role2);

        checkRoles.em.getTransaction().begin();
        checkRoles.em.persist(role);
        checkRoles.em.persist(role2);
        checkRoles.em.flush();
        checkRoles.em.getTransaction().commit();

        RolesDao rolesDao = new RolesDao();
        List<Role> listRoles = rolesDao.getAll();

        for (Role listRole : listRoles) {
            System.out.println(listRole);
        }
    }
}
