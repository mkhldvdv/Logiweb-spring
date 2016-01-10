package com.mkhldvdv.driverapp.jsf;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

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

    private static final Logger LOG = LogManager.getLogger(ChoiceBean.class);

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
        LOG.info("ChoiceBean: changeDriverStatus()");
        LOG.info("ChoiceBean: User ID passed from login page: " + loginBean.getUserId());
        return "driverStatus";
    }

    /**
     * go to cargos status page
     * @return
     */
    public String changeCargoStatus() {
        LOG.info("ChoiceBean: changeCargoStatus()");
        return "cargoStatus";
    }

    /**
     * logout
     * @return  login page
     */
    public String doLogout() {
        LOG.info("ChoiceBean: doLogout()");
        FacesContext.getCurrentInstance().getExternalContext().invalidateSession();
        return "/login.xhtml?faces-redirect=true";
    }
}
