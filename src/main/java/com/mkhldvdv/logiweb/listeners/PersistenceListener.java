package com.mkhldvdv.logiweb.listeners;

import com.mkhldvdv.logiweb.services.PersistenceManager;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * Created by mkhldvdv on 29.11.2015.
 */
public class PersistenceListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {

    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
        PersistenceManager.getInstance().closeEntityManagerFactory();
    }
}
