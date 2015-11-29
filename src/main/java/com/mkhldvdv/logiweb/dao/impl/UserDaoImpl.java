package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.dao.GenericDaoImpl;
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
    public static final byte NOT_DELETED = 0;

    /**
     * returns for user ny login name and password, for autorization
     * @param login login name
     * @param pass  password
     * @return      specified user
     */
    public User getUserByLoginPassword(String login, String pass) {

        try {
            String hashedPass = SHAHashing(pass);

            User user = em.createQuery("select u from User u " +
                    "where u.login = :login and u.password = :pass and u.deleted = :isDeleted", User.class)
                    .setParameter("login", login)
                    .setParameter("pass", hashedPass)
                    .setParameter("isDeleted", NOT_DELETED)
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
     * @param textToHash    what to hash
     * @return              hashed string
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
     * @return  list of drivers
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
     * @return
     */
    public List<User> getAllNotDeletedDrivers() {
        return em.createQuery("select u from User u " +
                "where u.role = :driver and u.deleted = :isDeleted", User.class)
                .setParameter("driver", DRIVER_ROLE)
                .setParameter("isDeleted", NOT_DELETED)
                .getResultList();
    }
}
