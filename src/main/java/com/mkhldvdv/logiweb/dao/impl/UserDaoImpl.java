package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.dao.GenericDaoImpl;
import com.mkhldvdv.logiweb.entities.User;

/**
 * Created by mkhldvdv on 19.11.2015.
 */
public class UserDaoImpl extends GenericDaoImpl<User> {

    /**
     * searching for unique user by provided login and pass
     *
     * @param login     login name
     * @param password  password
     * @return          User entity for the user with provided login and pass
     */
    public User findByLoginPass(String login, String password){
        return em.createQuery("SELECT c FROM User c WHERE " +
                "c.login = :login AND c.password = :password", User.class)
                .setParameter("login", login).setParameter("password", password)
                .getSingleResult();
    }
}
