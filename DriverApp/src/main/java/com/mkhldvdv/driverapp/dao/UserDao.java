package com.mkhldvdv.driverapp.dao;

import com.mkhldvdv.driverapp.entities.User;

/**
 * Created by mkhldvdv on 09.01.2016.
 */
public interface UserDao {

    /**
     * get user object by login name
     * @param login login name of the user
     * @return      user object
     */
    public User getUserByLogin(String login);
}
