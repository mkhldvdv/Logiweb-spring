package com.mkhldvdv.driverapp.jsf;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.RequestScoped;

/**
 * Created by mkhldvdv on 09.01.2016.
 */

@ManagedBean
@RequestScoped
public class ChoiceBean {

    @ManagedProperty("#{loginBean}")
    private LoginBean loginBean;

    public LoginBean getLoginBean() {
        return loginBean;
    }

    public void setLoginBean(LoginBean loginBean) {
        this.loginBean = loginBean;
    }

    public String changeDriverStatus() {
        System.out.println("ChoiceBean: User ID passed from login page: " + loginBean.getUserId());
        return "driverStatus";
    }

    public String changeCargoStatus() {
        return "cargoStatus";
    }

    public void signOut() {

    }
}
