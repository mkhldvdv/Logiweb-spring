package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.dao.GenericDaoImpl;
import com.mkhldvdv.logiweb.entities.Truck;
import com.mkhldvdv.logiweb.entities.User;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

/**
 * Created by mkhldvdv on 25.11.2015.
 */

@Repository
public class UserDaoImpl extends GenericDaoImpl<User> {

    private static final Logger LOG = LogManager.getLogger(TruckDaoImpl.class);

    public static final String DRIVER_ROLE = "ROLE_DRIVER";

    /**
     * returns list of drivers, i.e. users with the role "driver"
     *
     * @return list of drivers
     */
    public List<User> getAllDrivers() {
        LOG.info("UserDao: getAllDrivers()");
        List<User> userList = em.createQuery("select u from User u " +
                "where u.role = :driver", User.class)
                .setParameter("driver", DRIVER_ROLE)
                .getResultList();
        return userList;
    }

    /**
     * return all not deleted drivers
     *
     * @return
     */
//    public List<User> getAllNotDeletedDrivers() {
//        return em.createQuery("select u from User u " +
//                "where u.role = :driver", User.class)
//                .setParameter("driver", DRIVER_ROLE)
//                .getResultList();
//    }

    /**
     * create new user with hashed password
     * @param user  user object
     * @return      added user object
     */
    @Override
    public User create(User user) {
        LOG.info("UserDao: create()");

        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        String hashedPassword = passwordEncoder.encode(user.getPassword());

        user.setPassword(hashedPassword);
        return super.create(user);
    }


    /**
     * update user
     * @param user      specified user
     * @param hashed    if the password hashed
     * @return          updated user
     */
    public User update(User user, boolean hashed) {
        LOG.info("UserDao: update(" + user.getId() + ")");

        if (!hashed) {
            BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
            String hashedPassword = passwordEncoder.encode(user.getPassword());

            user.setPassword(hashedPassword);
        }

        return super.update(user);
    }

    /**
     * get the list of all drivers available for truck/order
     * @param truck specified truck
     * @return      list of drivers
     */
    public List<User> getAllAvailableDrivers(Truck truck) {
        LOG.info("UserDao: getAllAvailableDrivers(" + truck.getId() + ")");
        // order status "not completed", driver.city == truck.city
        return em.createQuery("select u from User u where u.city = :city and u.role = :driver " +
                "and u.deleted = 0 " +
                "order by u.id desc", User.class)
                .setParameter("city", truck.getCity())
                .setParameter("driver", DRIVER_ROLE)
                .getResultList();
    }


    /**
     * get user by login
     * @param login login name
     * @return      user
     */
    public User getUserByLogin(String login) {
        LOG.info("UserDao: getUserByLogin(" + login + ")");
        return em.createQuery("select u from User u where u.login = :login " +
                "and u.deleted = 0", User.class)
                .setParameter("login", login)
                .getSingleResult();
    }

    /**
     * get not deleted user by its id
     * @param userId   specified user
     * @return          not deleted user
     */
    public User getNotDeletedUserById(long userId) {
        LOG.info("UserDao: getNotDeletedUserById(" + userId + ")");
        return em.createQuery("select u from User u where u.deleted = 0" +
                "and u.id = :userID", User.class)
                .setParameter("userID", userId)
                .getSingleResult();
    }
}
