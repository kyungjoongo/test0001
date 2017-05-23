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

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository
public class __TinkerbellDAO {
	@Autowired
	@Qualifier("firstSqlSessionTemplate")
	private SqlSession sqlSession;
	
	
	public List select_tinkerbell_query_manager() {

		List<HashMap> arrList = sqlSession.selectList("com.nda.TinkerbellMapper.select_tinkerbell_query_manager");
		
		
		
		return arrList;
	}

	
	
}
