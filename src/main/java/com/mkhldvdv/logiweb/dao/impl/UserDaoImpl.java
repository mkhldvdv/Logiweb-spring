package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.dao.GenericDaoImpl;
import com.mkhldvdv.logiweb.entities.User;

import javax.persistence.EntityManager;
import java.util.List;

/**
 * Created by mkhldvdv on 24.11.2015.
 */
public class UserDaoImpl extends GenericDaoImpl<User> {

    public static final String DRIVER = "driver";

    public UserDaoImpl(EntityManager em) {
        super(em);
    }

    /**
     * returns User by loginName and password
     * @param login login name
     * @param pass  password
     * @return  specified user
     */
    public User getUserByLoginAndPass(String login, String pass) {
        return em.createQuery("select u from User u where u.login = :login and u.password = :password", User.class)
                .setParameter("login", login)
                .setParameter("password", pass)
                .getSingleResult();
    }

    /**
     * return all drivers
     * @return all drivers
     */
    public List<User> getAllDrivers() {
        return em.createQuery("select u from User u where u.role = :role", User.class)
                .setParameter("role", DRIVER)
                .getResultList();
    }
}
