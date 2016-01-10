package com.mkhldvdv.driverapp.jsf;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;

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
    public String changeStatus(String status) throws IOException {

        System.out.println("DriverStatusBean: User ID passed from login page: " + loginBean.getUserId());

        String url = "http://localhost:8080/Logiweb/drivers/status/" + loginBean.getUserId() + "?status=" + status;

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
