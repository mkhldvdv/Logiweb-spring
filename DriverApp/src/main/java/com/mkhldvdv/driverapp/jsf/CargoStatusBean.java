package com.mkhldvdv.driverapp.jsf;

import com.mkhldvdv.driverapp.dao.CargoDao;
import com.mkhldvdv.driverapp.entities.Cargo;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.RequestScoped;
import javax.faces.context.FacesContext;
import java.io.IOException;
import java.util.List;

/**
 * Created by mkhldvdv on 10.01.2016.
 */

@ManagedBean
@RequestScoped
public class CargoStatusBean {

    private static final Logger LOG = LogManager.getLogger(CargoStatusBean.class);

    @EJB
    CargoDao cargoDao;

    @ManagedProperty("#{loginBean}")
    private LoginBean loginBean;

    @ManagedProperty("#{param.cargoId}")
    private long cargoId;

    private List<Cargo> cargos;

    public LoginBean getLoginBean() {
        return loginBean;
    }

    public void setLoginBean(LoginBean loginBean) {
        this.loginBean = loginBean;
    }

    public long getCargoId() {
        return cargoId;
    }

    public void setCargoId(long cargoId) {
        this.cargoId = cargoId;
    }

    public List<Cargo> getCargos() {
        LOG.info("CargoStatusBean: getCargos()");
        LOG.info("CargoStatusBean: User ID passed from login page: " + loginBean.getUserId());
        cargos = cargoDao.getCargoList(loginBean.getUserId());
        return cargos;
    }

    public void setCargos(List<Cargo> cargos) {
        this.cargos = cargos;
    }

    /**
     * change status of cargo
     * @param status
     * @return
     */
    public String changeStatus(String status) {

        LOG.info("CargoStatusBean: changeStatus(" + status + ")");
        LOG.info("CargoStatusBean: cargoId, status: " + cargoId + " " + status);

        try {
            String url = "http://localhost:8080/Logiweb/cargos/status/" + cargoId + "?status=" + status;

            HttpClient client = new DefaultHttpClient();
            HttpPost post = new HttpPost(url);

            // add header
            post.setHeader("Content-type", "application/json");

            HttpResponse response = client.execute(post);
            int statusCode = Integer.parseInt(String.valueOf(response.getStatusLine().getStatusCode()));
            LOG.info("Sending 'POST' request to URL : " + url);
            LOG.info("Response Code : " +
                    response.getStatusLine().getStatusCode());

            if (statusCode == 200) {
                LOG.info("DriverStatusBean: status code 200");
                FacesContext.getCurrentInstance().getExternalContext().invalidateSession();
                return "/success.xhtml?faces-redirect=true";
            } else {
                LOG.info("DriverStatusBean: status code not 200");
                FacesContext.getCurrentInstance().getExternalContext().invalidateSession();
                return "/failure.xhtml?faces-redirect=true";
            }
        } catch (IOException e) {
            LOG.error("CargoStatusBean: " + e.getMessage());
            return "/failure.xhtml?faces-redirect=true";
        }
    }

    /**
     * logout
     * @return  login page
     */
    public String doLogout() {
        LOG.info("CargoStatusBean: doLogout()");
        FacesContext.getCurrentInstance().getExternalContext().invalidateSession();
        return "/login.xhtml?faces-redirect=true";
    }
}
