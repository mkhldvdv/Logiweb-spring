package com.mkhldvdv.driverapp.jsf;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.RequestScoped;
import javax.faces.context.FacesContext;

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

    /**
     * go to drivers status page
     * @return
     */
    public String changeDriverStatus() {
        System.out.println("ChoiceBean: User ID passed from login page: " + loginBean.getUserId());
        return "driverStatus";
    }

    /**
     * go to cargos status page
     * @return
     */
    public String changeCargoStatus() {
        return "cargoStatus";
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
