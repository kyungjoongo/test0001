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

import com.nda.model.Blog;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Repository
public class ExampleDAO {
	@Autowired
	@Qualifier("firstSqlSessionTemplate")
	private SqlSession sqlSession;

	public List getBlog() {

		List<Blog> arrList = sqlSession.selectList("ExampleMapper.getBlog");
		return arrList;
	}

	/**
	 * 유저의 존재여부를 리턴.
	 * @param userMap
	 * @return
	 */
	public Boolean getUser(HashMap userMap) {

		int userCnt= sqlSession.selectOne("ExampleMapper.getUser", userMap);

		if (userCnt>0){
			return true;
		}else{
			return false;
		}
	}
	
	
	public List select_query_manager_userquery(JqGridObject jqgridobject) {

		List<HashMap> arrList = sqlSession.selectList("ExampleMapper.select_query_manager_userquery", jqgridobject);
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

		int count= sqlSession.selectOne("ExampleMapper.select_query_manager_userquery_count");
		
		return count;
	}


	
	
}
