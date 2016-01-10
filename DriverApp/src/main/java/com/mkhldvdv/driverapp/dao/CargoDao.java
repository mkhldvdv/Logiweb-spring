package com.mkhldvdv.driverapp.dao;

import com.mkhldvdv.driverapp.entities.Cargo;

import java.util.List;

/**
 * Created by mkhldvdv on 09.01.2016.
 */
public interface CargoDao {

    /**
     * get the list of not completed cargos of one user
     * @param userId    specified user
     * @return          list of cargos
     */
    public List<Cargo> getCargoList(long userId);
}
