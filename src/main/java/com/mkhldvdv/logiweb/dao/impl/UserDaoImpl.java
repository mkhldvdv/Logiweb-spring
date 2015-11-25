package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.dao.GenericDaoImpl;
import com.mkhldvdv.logiweb.entities.User;

import java.util.List;

/**
 * Created by mkhldvdv on 25.11.2015.
 */
public class UserDaoImpl extends GenericDaoImpl<User> {

    public static final String DRIVER = "driver";

    /**
     * returns for user ny login name and password, for autorization
     * @param login login name
     * @param pass  password
     * @return      specified user
     */
    public User getUserByLoginPassword(String login, String pass) {
        return em.createQuery("select u from User u " +
                "where u.login = :login and u.password = :pass", User.class)
                .setParameter("login", login)
                .setParameter("pass", pass)
                .getSingleResult();
    }

    /**
     * returns list of drivers, i.e. users with the role "driver"
     * @return  list of drivers
     */
    public List<User> getAllDrivers() {
        return em.createQuery("select u from User u " +
                "where u.role = :driver", User.class)
                .setParameter("driver", DRIVER)
                .getResultList();
    }
}
