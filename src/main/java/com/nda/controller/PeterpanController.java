package com.nda.controller;

import ch.qos.logback.classic.Logger;
import com.nda.dao.PeterpanDAO;
import com.nda.model.JqGridObject;
import net.minidev.json.JSONValue;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;


@Controller
@RequestMapping("/peterpan")
public class PeterpanController {

    private static final Logger logger = (Logger) LoggerFactory.getLogger(PeterpanController.class);


    @Autowired
    private PeterpanDAO peterpanDAO;


    @RequestMapping("/list")
    public String grid(Model model,
                       @RequestParam(value = "name", required = false, defaultValue = "World") String name) {

        return "/peterpan/list";
    }


    /**
     *
     * @param name
     * @return /gridmain/getGridData2
     * @throws JsonGenerationException
     * @throws JsonMappingException
     * @throws IOException
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping("/getList")
    public @ResponseBody String getList(
            @RequestParam(value = "name", required = false, defaultValue = "Stranger") String name
            ,@RequestParam(value = "page", required = false) int page
            ,@RequestParam(value = "rows", required = false) int rows
            ,@RequestParam(value = "sortColumn", required = false, defaultValue = "id") String sortColumn//sortColumn
            ,@RequestParam(value = "sortOrder", required = false) String sortOrder//sortOrder

    )
            throws JsonGenerationException, JsonMappingException, IOException {


        int startNo = (page-1) * rows ;

        if (sortColumn.equals("queryTextAndResponse")  ){
            sortColumn= "query_text";
        }

        JqGridObject jqGridObject=new JqGridObject();

        jqGridObject.setStartNo(startNo);
        jqGridObject.setPageSize(rows);
        jqGridObject.setSortOrder(sortOrder);
        jqGridObject.setSortColumn(sortColumn);

        List<HashMap> arrList = peterpanDAO.select_query_manager_userquery(jqGridObject);


        int count = peterpanDAO.select_query_manager_userquery_count();

        HashMap map = new HashMap();


        map.put("page", page);
        map.put("rows", arrList);
        //totalCounts
        map.put("records", count);

        //total pages
        map.put("total", Math.ceil(Double.parseDouble(String.valueOf(count))/rows));

        //map.put("Page", arrList);

        return JSONValue.toJSONString(map);

    }



}

