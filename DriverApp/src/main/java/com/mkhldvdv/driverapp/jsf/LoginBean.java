package com.mkhldvdv.driverapp.jsf;

import com.mkhldvdv.driverapp.dao.UserDao;
import com.mkhldvdv.driverapp.entities.User;
import com.mkhldvdv.driverapp.exceptions.WrongCredentials;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.security.crypto.bcrypt.BCrypt;

import javax.ejb.EJB;
import javax.ejb.EJBException;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import javax.faces.context.FacesContext;
import javax.persistence.NoResultException;
import javax.servlet.http.HttpSession;


/**
 * Created by mkhldvdv on 09.01.2016.
 */

@ManagedBean
@SessionScoped
public class LoginBean {

    private static final Logger LOG = LogManager.getLogger(LoginBean.class);

    @EJB
    UserDao userDao;

    private String login;

    private String password;

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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * find user by login name
     * @param login login name
     * @return      user object
     */
    public User findUser(String login) {
        LOG.info("LoginBean: findUser(" + login + ")");
        try {
            User user = userDao.getUserByLogin(login);
            // to check passwords
            // if passwords do not match
            if ( !BCrypt.checkpw(password, user.getPassword()) ) {
                throw new WrongCredentials("Credentials are not valid");
            }
            return user;
        } catch (WrongCredentials e) {
            LOG.error("LoginBean: " + e.getMessage());
            error = "Credentials are not valid";
            return null;
        } catch (NoResultException e) {
            LOG.error("LoginBean: " + e.getMessage());
            error = "No such user found";
            return null;
        } catch (EJBException e) {
            LOG.error("LoginBean: " + e.getMessage());
            error = "No such user found";
            return null;
        }
    }

    /**
     * do login, transfer login from UI to findUser and check the result
     * @return  the page with success/fail result
     */
    public String doLogin() {

        LOG.info("LoginBean: doLogin()");

        if (login == "" || password == "") {
            LOG.error("LoginBean: Login and/or password values cannot be null or empty");
            error = "Login and/or password values cannot be null or empty";
            return "login";
        }

        User user = findUser(login);

        if (user != null) {
            userId = user.getId();
            LOG.info("LoginBean: User ID passed from login page: " + getUserId());
            HttpSession session = (HttpSession) FacesContext.getCurrentInstance()
                    .getExternalContext().getSession(false);
            session.setAttribute("username", user);
            return "choice";
        }
        else {
            LOG.error("LoginBean: No such user found");
            return "login";
        }
    }

    /**
     * Resets the user data back to the initial values.
     *
     */
    public void reset() {
        LOG.info("LoginBean: reset()");
        login = "";
        error = "";
    }
}