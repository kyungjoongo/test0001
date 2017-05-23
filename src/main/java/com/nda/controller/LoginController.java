package com.nda.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.nda.dao.BlogDao;
import com.nda.dao.ExampleDAO;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;

@Controller
@RequestMapping("/login")
public class LoginController {

    @Autowired
    private BlogDao blogDao;


    @Autowired
    private ExampleDAO exampleDao;
  


    @RequestMapping("/loginForm")
    public String loginForm(Model model,
                            @RequestParam(value = "name", required = false, defaultValue = "World") String name) {
        model.addAttribute("name", "testtt 222~~~~~~~~");

        return "loginForm";
    }


    @RequestMapping("/loginAction")
    public String loginProcess(Model model,HttpServletRequest request,
                               @RequestParam(value = "id", required = false) String id
                            , @RequestParam(value = "password", required = false) String password

    ) {


        System.out.println("loginActionloginActionloginActionloginActionloginActionloginAction---->");
        HashMap userMap=new HashMap();

        userMap.put("id", id);
        userMap.put("password", password);

        boolean isExistUser = exampleDao.getUser(userMap);



        if ( isExistUser){
            System.out.println("유저가 존재하네");

            request.getSession().setAttribute("id", id);

            return "/gridmain/grid";


        }else{
            System.out.println("유저가 존재하지 않는다..");

            model.addAttribute("message", "해당유저가 존재하지 않습니다.");
            return "/login/loginForm";
        }


    }


    @RequestMapping("/logoutAction")
    public String logoutAction(Model model,HttpServletRequest request,
                               @RequestParam(value = "name", required = false, defaultValue = "World") String name) {


        request.getSession().invalidate();

        return "/login/loginForm";
    }



}
