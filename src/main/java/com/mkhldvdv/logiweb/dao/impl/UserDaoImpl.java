package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.dao.GenericDaoImpl;
import com.mkhldvdv.logiweb.entities.User;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

/**
 * Created by mkhldvdv on 25.11.2015.
 */
public class UserDaoImpl extends GenericDaoImpl<User> {

    /**
     * returns for user ny login name and password, for autorization
     * @param login login name
     * @param pass  password
     * @return      specified user
     */
    public User getUserByLoginPassword(String login, String pass) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("Logiweb");
        em = emf.createEntityManager();

        try {
            String hashedPass = SHAHashing(pass);

            return em.createQuery("select u from User u " +
                    "where u.login = :login and u.password = :pass", User.class)
                    .setParameter("login", login)
                    .setParameter("pass", hashedPass)
                    .getSingleResult();

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
            emf.close();
        }
    }

    public static void main(String[] args) throws UnsupportedEncodingException, NoSuchAlgorithmException {
        UserDaoImpl userDao = new UserDaoImpl();
        String login = "admin";
        String pass = "admin";
        User user = userDao.getUserByLoginPassword(login, pass);
        System.out.println(user);

        String hashedPass = userDao.SHAHashing(pass);
        System.out.println(hashedPass);
    }

    private String SHAHashing(String textToHash) throws UnsupportedEncodingException, NoSuchAlgorithmException {
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
        return em.createQuery("select u from User u " +
                "where u.role = :driver", User.class)
                .setParameter("driver", 2)
                .getResultList();
    }

    /**
     * return all not deleted drivers
     * @return
     */
    public List<User> getAllNotDeletedDrivers() {
        return em.createQuery("select u from User u " +
                "where u.role = :driver and u.isDeleted = :deleted", User.class)
                .setParameter("driver", 2)
                .setParameter("deleted", false)
                .getResultList();
    }
}
