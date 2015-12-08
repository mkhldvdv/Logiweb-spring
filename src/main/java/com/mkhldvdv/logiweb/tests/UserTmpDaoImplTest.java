package com.mkhldvdv.logiweb.tests;

import com.mkhldvdv.logiweb.dao.impl.UserTmpDaoImpl;
import com.mkhldvdv.logiweb.entities.UserTmp;
import com.mkhldvdv.logiweb.services.PersistenceManager;
import org.junit.Test;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

import static org.junit.Assert.*;

/**
 * Created by mkhldvdv on 06.12.2015.
 */
public class UserTmpDaoImplTest {

    @Test
    public void getUserTmpByIdCheck() {
        // set id
        long userId = 1001;

        EntityManagerFactory emf = PersistenceManager.getInstance().getEntityManagerFactory();
        EntityManager em = emf.createEntityManager();

        UserTmpDaoImpl userTmpDao = new UserTmpDaoImpl();
        userTmpDao.setEm(em);

        // check if userTmp could be accessible
        UserTmp user = userTmpDao.getById(userId);

        System.out.println(user);
    }

}