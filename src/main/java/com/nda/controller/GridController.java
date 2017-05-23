package com.nda.controller;

import ch.qos.logback.classic.Logger;
import com.nda.dao.BlogDao;
import com.nda.dao.ExampleDAO;
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
import java.util.Map;

@Controller
@RequestMapping("/gridmain")
public class GridController {
	
	private static final Logger logger = (Logger) LoggerFactory.getLogger(GridController.class);

    @Autowired
    private BlogDao blogDao;


    @Autowired
    private ExampleDAO exampleDao;

    @RequestMapping("/graph")
    public String graph(Model model,
                        @RequestParam(value = "name", required = false, defaultValue = "World") String name) {
        model.addAttribute("name", "고경준천재지~~~~~~~~");

        // sdlkfsdlkflsdklfkdslfklkdsf
        
        logger.info("야이놈시키야slfklsdkfldkf");

        return "graph";
    }


    @RequestMapping("/pieGraph")
    public String pieGraph(Model model,
                           @RequestParam(value = "name", required = false, defaultValue = "World") String name) {
        model.addAttribute("name", "고경준천재지222~~~~~~~~");

        // sdlkfsdlkflsdklfkdslfklkdsf

        return "pieGraph";
    }
    
    @RequestMapping("/getGridData2")
	public @ResponseBody String getGridData(
			@RequestParam(value = "name", required = false, defaultValue = "Stranger") String name)
			throws JsonGenerationException, JsonMappingException, IOException {

		List arrList = blogDao.selecContents(null);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("page", 1);
		
		//totalPage
		map.put("total", 5);
		map.put("records", 200);
		map.put("rows", arrList);
		return JSONValue.toJSONString(map);

	}

	@RequestMapping("/grid")
	public String grid(Model model,
			@RequestParam(value = "name", required = false, defaultValue = "World") String name) {

		return "grid";
	}
	
	@RequestMapping("/grid2")
	public String grid2(Model model,
			@RequestParam(value = "name", required = false, defaultValue = "World") String name) {

		return "grid2";
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
	@RequestMapping("/getGridData")
		public @ResponseBody String getGridData2(
				@RequestParam(value = "name", required = false, defaultValue = "Stranger") String name
				,@RequestParam(value = "page", required = false) int page
				,@RequestParam(value = "rows", required = false) int rows
				,@RequestParam(value = "sidx", required = false) String sidx//SortColumn
				,@RequestParam(value = "sord", required = false) String sord//SortOrder
				
				)
				throws JsonGenerationException, JsonMappingException, IOException {
		 
		 
		 	int startNo = (page-1) * rows +1;
		 	
		 	JqGridObject jqgridobject=new JqGridObject();
		 	
		 	jqgridobject.setStartNo(startNo);
		 	jqgridobject.setPageSize(rows);

			List<HashMap> arrList = exampleDao.select_query_manager_userquery(jqgridobject);
			
			
			int count = exampleDao.select_query_manager_userquery_count();
			
			

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
	
	
	
	@RequestMapping("/getGraphData")
	public @ResponseBody String getGraphData()
			
			throws JsonGenerationException, JsonMappingException, IOException {

		List arrList = blogDao.getGraphData();

		/*Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", arrList);*/
		return JSONValue.toJSONString(arrList);

	}
	
	
	

}
