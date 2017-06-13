package com.nda.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.nda.dao.BlogDao;
import com.nda.dao.ExampleDAO;
import org.springframework.web.servlet.ModelAndView;


/**
 * CRUD 컨트롤러 example
 * @author kyungjoon
 *
 */
/*@RestController*/

@Controller
public class CRUDTestController {
 
    @Autowired
    private BlogDao blogDao;
    
    /*@Autowired
	private ExampleDAO exampleDao;*/

    @RequestMapping("/")
    public ModelAndView index() {
        ModelAndView mav=new ModelAndView();
        // mav.addObject("message", "업로드성공!");
        mav.setViewName("redirect:" + "/stats/list");
        return  mav;
    }


    @RequestMapping("/insertTest")
    public String insertTest() {
        blogDao.insertNewContent("고경준은 관연천재님이신가요??");
        
        
        blogDao.insertNewContent("고경준은 관연천재님이신가요?2222?");
        return "Greetings from Spring Boot!";
    }
    
    
    @RequestMapping("/insertTest2")
    public String insertTest2() {
        blogDao.insertNewContent("고경준은 관연천재님이신가요----------1");
        blogDao.insertNewContent("고경준은 관연천재님이신가요----------1");
        blogDao.insertNewContent("고경준은 관연천재님이신가요----------1");
        blogDao.insertNewContent("고경준은 관연천재님이신가요----------1");
        
        
        
        return "Greetings from Spring Boot!";
    }
    
    
    @RequestMapping("/selectTest")
	public String selectTest(Model model,	@RequestParam(value = "name", required = false, defaultValue = "Stranger") String name) {
		
    	List arrList = blogDao.selecContents(null);
    	
    	model.addAttribute("arrList",arrList);
		
		return "selectTest";
	}
    
    
    @RequestMapping("/mybatisTest")
  	public String mybatisTest(Model model,	@RequestParam(value = "name", required = false, defaultValue = "Stranger") String name) {
  		
      	
    	/*List arrList = exampleDao.getBlog();

    	System.out.println("list-->:"+ arrList.toString());
        System.out.println("list22222-->:"+ arrList.toString());*/
  		
  		return "grid";
  	}


    
  

    
  
  
 
 
}


