package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.entities.Role;
import com.mkhldvdv.logiweb.dao.GenericDaoImpl;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.List;

public class RoleDaoImpl extends GenericDaoImpl<Role> {

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
        RoleDaoImpl roleDaoImpl = new RoleDaoImpl();
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("Logiweb");
        try {
            roleDaoImpl.em = emf.createEntityManager();

            roleDaoImpl.em.getTransaction().begin();
            roleDaoImpl.create(new Role("testrole"));
//            roleDaoImpl.em.persist(new Role("administrator"));
//            roleDaoImpl.em.persist(new Role("operator"));
//            roleDaoImpl.em.persist(new Role("driver"));
            roleDaoImpl.em.flush();
            roleDaoImpl.em.getTransaction().commit();

            List<Role> roles = roleDaoImpl.getAll();

            for (Role role : roles) System.out.println(role);

        } catch (Exception e) {
            roleDaoImpl.em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            roleDaoImpl.em.close();
            emf.close();
        }
    }
}
