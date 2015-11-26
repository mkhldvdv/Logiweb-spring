package com.mkhldvdv.logiweb.tests;

import com.mkhldvdv.logiweb.dao.impl.UserDaoImpl;
import com.mkhldvdv.logiweb.entities.User;
import junit.framework.TestCase;

/**
 * Created by mkhldvdv on 27.11.2015.
 */
public class UserDaoImplTest extends TestCase {

    public static final String LOGIN = "operator";
    public static final String PASSWORD = "operator1";

    public void testGetUserByLoginPassword() throws Exception {
        UserDaoImpl userDao = new UserDaoImpl();
        String login = LOGIN;
        String pass = PASSWORD;
        User user = userDao.getUserByLoginPassword(login, pass);
        System.out.println(user);

        String hashedPass = userDao.SHAHashing(pass);
        System.out.println(hashedPass);
    }

    public void testGetAllDrivers() throws Exception {

    }

    public void testGetAllNotDeletedDrivers() throws Exception {

    }
}