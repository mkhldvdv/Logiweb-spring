package com.mkhldvdv.driverapp.dao.impl;

import com.mkhldvdv.driverapp.dao.CargoDao;
import com.mkhldvdv.driverapp.entities.Cargo;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.ejb.Stateless;
import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by mkhldvdv on 09.01.2016.
 */

@Stateless
public class CargoDaoImpl implements CargoDao {

    private static final Logger LOG = LogManager.getLogger(CargoDaoImpl.class);

    @PersistenceContext
    private EntityManager em;

    /**
     * get the list of not completed cargos of one user
     * @param userId    specified user
     * @return          list of cargos
     */
    @Override
    public List<Cargo> getCargoList(long userId) {
        LOG.info("CargoDao: getCargoList(" + userId + ")");
        try{
            String sqlQuery = "select c.cargo_id, c.cargo_name, c.cargo_status_id" +
                    "  from cargos c, waypoints w, orders o, trucks t, users u" +
                    " where c.cargo_id = w.cargo_id" +
                    "   and w.cargo_type_id = 1" +
                    "   and w.order_id = o.order_id" +
                    "   and o.order_status_id = 2" +
                    "   and o.truck_id = t.truck_id" +
                    "   and t.truck_status_id = 1" +
                    "   and t.truck_id = u.truck_id" +
                    "   and u.user_id = ?";

            return em.createNativeQuery(sqlQuery, Cargo.class)
                .setParameter(1, userId)
                .getResultList();

        } catch (Exception e) {
            LOG.error("CargoDao: No cargos returned");
            LOG.error("CargoDao: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<Cargo>();
        }
    }
}
