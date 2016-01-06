package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.dao.GenericDaoImpl;
import com.mkhldvdv.logiweb.entities.Truck;
import com.mkhldvdv.logiweb.entities.User;
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

    public static final String DRIVER_ROLE = "ROLE_DRIVER";

    /**
     * returns list of drivers, i.e. users with the role "driver"
     *
     * @return list of drivers
     */
    public List<User> getAllDrivers() {
        try {
            List<User> userList = em.createQuery("select u from User u " +
                    "where u.role = :driver", User.class)
                    .setParameter("driver", DRIVER_ROLE)
                    .getResultList();
            return userList;
        } catch (Exception e) {
            System.out.printf("INFO: drivers list is empty\n");
            e.printStackTrace();
            return null;
        }
    }

    /**
     * return all not deleted drivers
     *
     * @return
     */
    public List<User> getAllNotDeletedDrivers() {
        return em.createQuery("select u from User u " +
                "where u.role = :driver", User.class)
                .setParameter("driver", DRIVER_ROLE)
                .getResultList();
    }

    @Override
    public User create(User user) {

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
        // order status "not completed", driver.city == truck.city
        return em.createQuery("select u from User u where u.city = :city and u.role = :driver " +
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
        return em.createQuery("select u from User u where u.login = :login", User.class)
                .setParameter("login", login)
                .getSingleResult();
    }
}
