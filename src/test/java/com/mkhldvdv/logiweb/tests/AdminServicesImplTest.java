package com.mkhldvdv.logiweb.tests;

import com.mkhldvdv.logiweb.dao.impl.TruckDaoImpl;
import com.mkhldvdv.logiweb.dto.OrderDTO;
import com.mkhldvdv.logiweb.entities.Cargo;
import com.mkhldvdv.logiweb.entities.Order;
import com.mkhldvdv.logiweb.entities.Truck;
import com.mkhldvdv.logiweb.entities.User;
import com.mkhldvdv.logiweb.services.impl.AdminServicesImpl;
import org.junit.Test;
import org.mockito.Mockito;

import static org.junit.Assert.*;

/**
 * Created by mkhldvdv on 12.01.2016.
 */
public class AdminServicesImplTest {

    AdminServicesImpl services = new AdminServicesImpl();
    TruckDaoImpl truckDao = new TruckDaoImpl();

    @Test
    public void testGetOrder() throws Exception {

        long orderID = 1014;
        OrderDTO order = services.getOrder(orderID);

        // check the value
        assertNotNull(order);
        assertEquals(order.getId(), 1014);

    }

    @Test
    public void testGetCargoById() throws Exception {

        long cargoID = 1025;
        Cargo cargo = services.getCargoById(cargoID);

        // check the value
        assertNotNull(cargo);
        assertEquals(cargo.getId(), 1025);

    }

    @Test
    public void testGetUser() throws Exception {

        long userID = 1001;
        User user = services.getUser(userID);

        // check the value
        assertNotNull(user);
        assertEquals(user.getId(), 1001);
    }

    @Test
    public void testGetNotDeletedUser() throws Exception {

        long userID = 1042;
        User user = services.getNotDeletedUser(userID);

        // check the value
        assertNull(user);
    }

    @Test
    public void testGetTruck() throws Exception {

        long truckID = 1010;
        Truck truck = services.getTruck(truckID);

        // check the value
        assertNotNull(truck);
        assertEquals(truck.getId(), 1010);
    }

    @Test
    public void testGetNotDeletedTruck() throws Exception {

        long truckID = 1025;
        Truck truck = truckDao.getNotDeletedTruckById(truckID);
//        Truck truck = services.getNotDeletedTruck(truckID);

        // check the value
        assertNull(truck);
    }
}