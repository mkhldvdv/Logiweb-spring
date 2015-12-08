package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.dao.GenericDaoImpl;
import com.mkhldvdv.logiweb.entities.Truck;
import com.mkhldvdv.logiweb.entities.User;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

/**
 * Created by mkhldvdv on 25.11.2015.
 */
public class UserDaoImpl extends GenericDaoImpl<User> {

    public static final byte DRIVER_ROLE = 3;

    /**
     * returns for user ny login name and password, for autorization
     *
     * @param login login name
     * @param pass  password
     * @return specified user
     */
    public User getUserByLoginPassword(String login, String pass) {

        try {
            String hashedPass = SHAHashing(pass);

            User user = em.createQuery("select u from User u " +
                    "where u.login = :login and u.password = :pass", User.class)
                    .setParameter("login", login)
                    .setParameter("pass", hashedPass)
                    .getSingleResult();

            return user;

        } catch (Exception e) {
            System.out.printf("INFO: No user exists with provided login/password: %s/%s\n", login, pass);
            e.printStackTrace();
            return null;
        }
    }

    /**
     * hash any string to not keep it in plain text
     *
     * @param textToHash what to hash
     * @return hashed string
     * @throws UnsupportedEncodingException
     * @throws NoSuchAlgorithmException
     */
    public String SHAHashing(String textToHash) throws UnsupportedEncodingException, NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        String text = textToHash;

        md.update(text.getBytes("UTF-8")); // Change this to "UTF-16" if needed
        byte[] digest = md.digest();

        return String.format("%064x", new java.math.BigInteger(1, digest));
    }

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
        try {
            String hashedPass = SHAHashing(user.getPassword());
            user.setPassword(hashedPass);
            return super.create(user);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            return null;
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }


    /**
     * update user
     * @param user      specified user
     * @param hashed    if the password hashed
     * @return          updated user
     */
    public User update(User user, boolean hashed) {
        try {
            if (!hashed) {
                String hashedPass = SHAHashing(user.getPassword());
                user.setPassword(hashedPass);
            }
            return super.update(user);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            return null;
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
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
}
