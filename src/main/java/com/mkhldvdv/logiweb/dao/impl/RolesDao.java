package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.entities.Role;
import com.mkhldvdv.logiweb.dao.GenericDaoImpl;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.List;

public class RolesDao extends GenericDaoImpl<Role> {

    /**
     *This method search the Role entity by the name of this entity.
     * @param authority the authority that system user have
     *                  @return Role entity
     */
    public Role getByDescription(String authority) {
        return em.createQuery("select r from Role r where r.roleName = :role", Role.class)
                .setParameter("role", authority)
                .getSingleResult();
    }

    // check
    public static void main(String[] args) {
        RolesDao roleDao = new RolesDao();
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("Logiweb");
        roleDao.em = emf.createEntityManager();

        roleDao.em.getTransaction().begin();
        roleDao.em.persist(new Role("administrator"));
        roleDao.em.persist(new Role("operator"));
        roleDao.em.persist(new Role("driver"));
        roleDao.em.flush();
        roleDao.em.getTransaction().commit();

        List<Role> roles = roleDao.getAll();

        for (Role role : roles) System.out.println(role);

        roleDao.em.close();
        emf.close();

//        System.out.println("close");
    }
}
