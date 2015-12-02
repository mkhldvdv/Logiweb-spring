package com.mkhldvdv.logiweb.tests;

import com.mkhldvdv.logiweb.services.impl.AdminServicesImpl;
import org.junit.Test;

import java.util.Arrays;
import java.util.List;

/**
 * Created by mkhldvdv on 02.12.2015.
 */
public class AdminServicesImplTest {

    @Test
    public void testGetAllAvailableTrucks() throws Exception {

        // test array
        List<Long> longs = Arrays.asList(1005L, 1006L, 1007L);
//        List<Long> longs = Arrays.asList(1005L);

        AdminServicesImpl adminServices = new AdminServicesImpl();
        adminServices.getAllAvailableTrucks(longs);
    }

    @Test
    public void testGetAllAvailableDrivers() throws Exception {
        long truck = 1010L;
        List<Long> longs = Arrays.asList(1005L, 1006L, 1007L);
        AdminServicesImpl adminServices = new AdminServicesImpl();
        adminServices.getAllAvailableDrivers(truck, longs);
    }
}