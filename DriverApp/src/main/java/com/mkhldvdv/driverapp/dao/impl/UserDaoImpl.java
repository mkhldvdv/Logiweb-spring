package com.mkhldvdv.driverapp.dao.impl;

import com.mkhldvdv.driverapp.dao.UserDao;
import com.mkhldvdv.driverapp.entities.User;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;

/**
 * Created by mkhldvdv on 09.01.2016.
 */

@Stateless
public class UserDaoImpl implements UserDao {

    private static final Logger LOG = LogManager.getLogger(UserDaoImpl.class);

    public static final String DRIVER_ROLE = "ROLE_DRIVER";
    public static final byte NOT_DELETED = (byte) 0;
    @PersistenceContext
    private EntityManager em;

    /**
     * get user object by login name
     *
     * @param login login name of the user
     * @return user object
     */
    @Override
    public User getUserByLogin(String login) throws NoResultException {
        LOG.info("UserDao: getUserByLogin(" + login + ")");
            return em.createQuery("select u from User u where u.login = :login " +
                    "and u.role = :role " +
                    "and u.deleted = :deleted", User.class)
                    .setParameter("login", login)
                    .setParameter("role", DRIVER_ROLE)
                    .setParameter("deleted", NOT_DELETED)
                    .getSingleResult();
    }
}
