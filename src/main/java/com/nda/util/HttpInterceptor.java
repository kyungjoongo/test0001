package com.nda.util;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@Component
public class HttpInterceptor extends HandlerInterceptorAdapter {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception { // HTTP 요청 처리 전 수행할 로직 작성


        System.out.println("인터셉트 prehandler!!!!");
        
        //세션에 등록된 아이디를 가지고 온다.
        HttpSession session = request.getSession();
        String sessionedId = (String)session.getAttribute("id");
        String uri = request.getRequestURI();
        System.out.println("uri---> ::"+uri);
        

        //인터셉트의 걸리지 않고 통과시킴..(uri가 로그인 폼인경우)
        if ( uri.equals("/login/loginForm")){
            return true;
        //인터셉트의 걸리지 않고 통과시킴..(uri가 로그인action 인경우)
        }else if ( uri.equals("/login/loginAction")){
            return true;
        }
        //세션 id가 있는 경우 걸르지 않고 통과시킴.
        else if(sessionedId!=null){
            return true;
        }else{//나머지의 경우 걸림.

            response.sendRedirect("/login/loginForm");//Here Login is action Name which is Mapped in Login Controller
            return false;
        }
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {


        System.out.println("intercept post handle");
    }
}


