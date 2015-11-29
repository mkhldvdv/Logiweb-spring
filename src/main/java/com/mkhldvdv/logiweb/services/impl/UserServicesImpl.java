package com.mkhldvdv.logiweb.services.impl;

import com.mkhldvdv.logiweb.dao.impl.UserDaoImpl;
import com.mkhldvdv.logiweb.dto.UserDTO;
import com.mkhldvdv.logiweb.entities.Order;
import com.mkhldvdv.logiweb.entities.User;
import com.mkhldvdv.logiweb.entities.Waypoint;
import com.mkhldvdv.logiweb.exceptions.WrongIdException;
import com.mkhldvdv.logiweb.exceptions.WrongLoginPass;
import com.mkhldvdv.logiweb.services.PersistenceManager;
import com.mkhldvdv.logiweb.services.UserServices;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Created by mkhldvdv on 25.11.2015.
 */
public class UserServicesImpl implements UserServices {

    public static final String NOT_COMPLETE = "not complete";
    private UserDaoImpl userDao;

    private EntityManagerFactory emf = PersistenceManager.getInstance().getEntityManagerFactory();
    {
        EntityManager em = emf.createEntityManager();
        userDao = new UserDaoImpl();
        userDao.setEm(em);
    }

    /**
     * returns user by login name and password
     *
     * @param login login name
     * @param pass  password
     * @return specified user
     */
    @Override
    public UserDTO getUser(String login, String pass) {

        try {
            User user = userDao.getUserByLoginPassword(login, pass);
            // check user exists
            if (user == null) {
                throw new WrongLoginPass(">>> Exception: No user exists");
            }

            UserDTO userDTO = new UserDTO(user.getId(), user.getFirstName(), user.getLastName(),
                    user.getLogin(), user.getPassword(), user.getRole(), user.getHours(),
                    user.getUserStatus(), user.getCity(), user.getTruck(), user.getOrders(), user.getDeleted());
            return userDTO;

        } catch (WrongLoginPass wrongLoginPass) {
            return null;
        } finally {
            userDao.getEm().close();
        }
    }
}
