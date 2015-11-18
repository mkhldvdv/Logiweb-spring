package com.mkhldvdv.logiweb.dao.impl;

import com.mkhldvdv.logiweb.entities.Roles;

import java.util.List;

/**
 * Created by mkhldvdv on 19.11.2015.
 */
public class CheckRoles {
    public static void main(String[] args) {
        Roles role = new Roles("administrator");
        RolesDao rolesDao = new RolesDao();
        System.out.println(role);
        rolesDao.create(role);

        List<Roles> rolesList = rolesDao.getAll();

        for (Roles roles : rolesList) {
            System.out.println(roles);
        }
    }
}
