package com.mkhldvdv.logiweb.dto;

import com.mkhldvdv.logiweb.entities.Truck;
import com.mkhldvdv.logiweb.entities.User;
import com.mkhldvdv.logiweb.entities.Waypoint;

import java.util.List;

/**
 * Created by mkhldvdv on 25.11.2015.
 */
public class OrderDTO {

    private long id;

    private String orderStatus;

    private List<Waypoint> waypoints;

    private Truck truck;

    private List<User> drivers;
}
