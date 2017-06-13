package com.nda;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.boot.autoconfigure.jdbc.DataSourceBuilder;
import org.springframework.boot.autoconfigure.web.ServerProperties;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.context.annotation.PropertySource;

import javax.sql.DataSource;

@Configuration
public class DataSourceConfig {

	/*@ConfigurationProperties(prefix = "spring.datasource")*/

	@Bean
	@Primary
	@ConfigurationProperties(prefix = "spring.datasource")
	public DataSource firstDataSource() {
		return DataSourceBuilder.create().build();
	}

	@Bean
	public SqlSessionFactory firstSqlSessionFactory(DataSource firstDataSource, ApplicationContext applicationContext)
			throws Exception {
		SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
		sqlSessionFactoryBean.setDataSource(firstDataSource);
		sqlSessionFactoryBean.setMapperLocations(applicationContext.getResources("classpath:mapper/*.xml"));
		return sqlSessionFactoryBean.getObject();
	}

	@Bean
	public SqlSessionTemplate firstSqlSessionTemplate(SqlSessionFactory firstSqlSessionFactory) throws Exception {
		return new SqlSessionTemplate(firstSqlSessionFactory);
	}




	@Bean
	@ConfigurationProperties(prefix="spring.secondDatasource")
	public DataSource secondDataSource() {
		return DataSourceBuilder.create().build();
	}

	@Bean
	public SqlSessionFactory secondSqlSessionFactory(DataSource secondDataSource, ApplicationContext applicationContext)
			throws Exception {
		SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
		sqlSessionFactoryBean.setDataSource(secondDataSource);
		sqlSessionFactoryBean.setMapperLocations(applicationContext.getResources("classpath:mapper/*.xml"));
		return sqlSessionFactoryBean.getObject();
	}

	@Bean
	public SqlSessionTemplate secondSqlSessionTemplate(SqlSessionFactory secondSqlSessionFactory) throws Exception {
		return new SqlSessionTemplate(secondSqlSessionFactory);
	}

}
