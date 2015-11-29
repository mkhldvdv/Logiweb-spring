package com.mkhldvdv.logiweb.services;

import com.mkhldvdv.logiweb.dto.UserDTO;
import com.mkhldvdv.logiweb.entities.Order;
import com.mkhldvdv.logiweb.entities.User;
import com.mkhldvdv.logiweb.entities.Waypoint;
import com.mkhldvdv.logiweb.exceptions.WrongIdException;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.Set;

/**
 * Created by mkhldvdv on 25.11.2015.
 */
public interface UserServices {

    /**
     * returns user by login name and password
     * @param login login name
     * @param pass  password
     * @return      specified user
     */
    public UserDTO getUser(String login, String pass) throws UnsupportedEncodingException, NoSuchAlgorithmException;

}
