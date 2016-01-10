package com.mkhldvdv.driverapp.jsf;

import com.mkhldvdv.driverapp.dao.CargoDao;
import com.mkhldvdv.driverapp.entities.Cargo;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;

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
        System.out.println("CargoStatusBean: User ID passed from login page: " + loginBean.getUserId());
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
    public String changeStatus(String status) throws IOException {
        System.out.println("CargoStatusBean: cargoId, status: " + cargoId + " " + status);

        String url = "http://localhost:8080/Logiweb/cargos/status/" + cargoId + "?status=" + status;

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("Content-type", "application/json");

        HttpResponse response = client.execute(post);
        int statusCode = Integer.parseInt(String.valueOf(response.getStatusLine().getStatusCode()));
        System.out.println("\nSending 'POST' request to URL : " + url);
        System.out.println("Response Code : " +
                response.getStatusLine().getStatusCode());

        if (statusCode == 200) {
            FacesContext.getCurrentInstance().getExternalContext().invalidateSession();
            return "/success.xhtml?faces-redirect=true";
        } else {
            FacesContext.getCurrentInstance().getExternalContext().invalidateSession();
            return "/failure.xhtml?faces-redirect=true";
        }
    }

    /**
     * logout
     * @return  login page
     */
    public String doLogout() {
        FacesContext.getCurrentInstance().getExternalContext().invalidateSession();
        return "/login.xhtml?faces-redirect=true";
    }
}
