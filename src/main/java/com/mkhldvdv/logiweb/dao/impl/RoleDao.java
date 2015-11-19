package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.entities.Role;
import com.mkhldvdv.logiweb.dao.GenericDaoImpl;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.List;

public class RoleDao extends GenericDaoImpl<Role> {

    /**
     * This method search the Role entity by the name of this entity.
     *
     * @param name the role that system user has
     * @return Role entity
     */
    public Role getByDescription(String name) {
        return em.createQuery("select r from Role r where r.roleName = :name", Role.class)
                .setParameter("name", name)
                .getSingleResult();
    }

    // check
    public static void main(String[] args) {
        RoleDao roleDao = new RoleDao();
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("Logiweb");
        try {
            roleDao.em = emf.createEntityManager();

            roleDao.em.getTransaction().begin();
            roleDao.create(new Role("testrole"));
//            roleDao.em.persist(new Role("administrator"));
//            roleDao.em.persist(new Role("operator"));
//            roleDao.em.persist(new Role("driver"));
            roleDao.em.flush();
            roleDao.em.getTransaction().commit();

            List<Role> roles = roleDao.getAll();

            for (Role role : roles) System.out.println(role);

        } catch (Exception e) {
            roleDao.em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            roleDao.em.close();
            emf.close();
        }
    }
}
