package com.mkhldvdv.logiweb.controllers;

import com.mkhldvdv.logiweb.entities.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.validation.Valid;

/**
 * Created by mkhldvdv on 25.12.2015.
 */

@Controller
public class LogiwebController {

    @RequestMapping(value = {"/", "/goLogin"}, method = RequestMethod.GET)
    public String viewLogin(Model model) {
        model.addAttribute("loginForm", new User());
        return "login";
    }

    @RequestMapping(value = "/info", method = RequestMethod.POST)
    public String doLogin(@ModelAttribute("loginForm") @Valid User user,
                          BindingResult result, Model model) {

        if (result.hasErrors()) {
            return "login";
        }

        return "info";
    }

    @RequestMapping(value = {"/userProfile"}, method = RequestMethod.GET)
    public String viewUserProfile() {
        return "userProfile";
    }
}
