package com.mkhldvdv.driverapp.dao.impl;

import com.mkhldvdv.driverapp.dao.UserDao;
import com.mkhldvdv.driverapp.entities.User;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;

/**
 * Created by mkhldvdv on 09.01.2016.
 */

@Stateless
public class UserDaoImpl implements UserDao {

    public static final String DRIVER_ROLE = "ROLE_DRIVER";
    @PersistenceContext
    private EntityManager em;

    /**
     * get user object by login name
     *
     * @param login login name of the user
     * @return user object
     */
    @Override
    public User getUserByLogin(String login) {
        try {
            return em.createQuery("select u from User u where u.login = :login and u.role = :role", User.class)
                    .setParameter("login", login)
                    .setParameter("role", DRIVER_ROLE)
                    .getSingleResult();
        } catch (NoResultException e) {
            System.out.println("No user with appropriate role");
            return null;
        }
    }
}
