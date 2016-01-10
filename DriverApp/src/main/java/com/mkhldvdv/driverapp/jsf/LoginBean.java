package com.mkhldvdv.driverapp.jsf;

import com.mkhldvdv.driverapp.dao.UserDao;
import com.mkhldvdv.driverapp.entities.User;

import javax.ejb.EJB;
import javax.ejb.SessionBean;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;
import javax.faces.bean.SessionScoped;
import javax.faces.context.FacesContext;
import javax.servlet.http.HttpSession;

/**
 * Created by mkhldvdv on 09.01.2016.
 */

@ManagedBean
@SessionScoped
public class LoginBean {

    @EJB
    UserDao userDao;

    private String login;

    private String error;

    private long userId;

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    /**
     * find user by login name
     * @param login login name
     * @return      user object
     */
    public User findUser(String login) {
        return userDao.getUserByLogin(login);
    }

    /**
     * do login, transfer login from UI to findUser and check the result
     * @return  the page with success/fail result
     */
    public String doLogin()
    {
        User user = findUser(login);

        if (user != null) {
            userId = user.getId();
            System.out.println("LoginBean: User ID passed from login page: " + getUserId());
            HttpSession session = (HttpSession) FacesContext.getCurrentInstance()
                    .getExternalContext().getSession(false);
            session.setAttribute("username", user);
            return "choice";
        }
        else {
            setError("No such user found");
            return "login";
        }
    }

    /**
     * Resets the user data back to the initial values.
     *
     */
    public void reset() {
        login = "";
        error = "";
    }
}