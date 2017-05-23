/*package com.example.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface ExampleDAO {
	@Select("select * from blogs order by id desc limit 1")
	HashMap getBlog();
}
*/

package com.nda.dao;

import com.nda.model.JqGridObject;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Repository
public class PeterpanDAO {
	@Autowired
	@Qualifier("firstSqlSessionTemplate")
	private SqlSession sqlSession;

	
	public List select_query_manager_userquery(JqGridObject jqGridObject) {

		List<HashMap> arrList = sqlSession.selectList("PeterpanMapper.select_query_manager_userquery", jqGridObject);
		List newArrayList = new ArrayList<>();
		
		/**
		 * query_text , query_response 합쳐준다.
		 */
		for ( HashMap arrOne : arrList){
			
			
			//query_text, query_response
			
			String query_text= (String) arrOne.get("query_text");
			String query_response= (String) arrOne.get("query_response");
			
			String queryTextAndResponse = query_text + ";" + query_response;
			
			arrOne.put("queryTextAndResponse", queryTextAndResponse);
			newArrayList.add(arrOne);
			
		}
		
		
		return newArrayList;
	}
	
	public int select_query_manager_userquery_count() {

		int count= sqlSession.selectOne("PeterpanMapper.select_query_manager_userquery_count");
		
		return count;
	}


	
	
}
