package com.mkhldvdv.driverapp.jsf;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.RequestScoped;
import javax.faces.context.FacesContext;
import java.io.IOException;

/**
 * Created by mkhldvdv on 09.01.2016.
 */

@ManagedBean
@RequestScoped
public class DriverStatusBean {

    private static final Logger LOG = LogManager.getLogger(DriverStatusBean.class);

    @ManagedProperty("#{loginBean}")
    private LoginBean loginBean;

    public LoginBean getLoginBean() {
        return loginBean;
    }

    public void setLoginBean(LoginBean loginBean) {
        this.loginBean = loginBean;
    }

    /**
     * change status of driver
     * @param status    current status
     * @return          success of fail
     * @throws IOException
     */
    public String changeStatus(String status) {

        LOG.info("DriverStatusBean: changeStatus(" + status + ")");
        LOG.info("DriverStatusBean: User ID passed from login page: " + loginBean.getUserId());

        try {
            String url = "http://localhost:8080/Logiweb/drivers/status/" + loginBean.getUserId() + "?status=" + status;

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
            LOG.error("DriverStatusBean: " + e.getMessage());
            return "/failure.xhtml?faces-redirect=true";
        }
    }

    /**
     * logout
     * @return  login page
     */
    public String doLogout() {
        LOG.info("DriverStatusBean: doLogout()");
        FacesContext.getCurrentInstance().getExternalContext().invalidateSession();
        return "/login.xhtml?faces-redirect=true";
    }
}
