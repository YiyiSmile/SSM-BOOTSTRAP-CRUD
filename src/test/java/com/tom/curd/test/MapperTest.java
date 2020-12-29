package com.tom.curd.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.tom.curd.bean.Employee;
import com.tom.curd.dao.DepartmentMapper;
import com.tom.curd.dao.EmployeeMapper;

/**
 * 测试dao层能否正常工作
 * 
 * 推荐： spring项目，建议使用spring提供的单元测试方法，可以自动注入我们需要的组件
 * 1、导入srpingTest模块 
 * 2、使用@ContextConfiguration指定配置文件位置
 * 3、使用@RunWith(SpringJUnit4ClassRunner.class)指定使用哪个spring单元测试模块,@RunWith是junit提供
 * 的注解
 * 4、直接autowire
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {
	
	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	EmployeeMapper employeeMapper;
	
	@Autowired
	SqlSession sqlSession;
	@Test
	public void testCRUD(){
		
/*		以下是传统的测试方法
 * 
 *      //1、创建spring IOC容器
		ApplicationContext ioc = = new ClassPathXmlApplicationContext("applicationContext.xml");
		
		//2、从容器中获取mapper
		DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);*/
		
//		System.out.println(departmentMapper);
		
		//1、测试插入部门数据
		
//		departmentMapper.insertSelective(new Department(null, "开发部"));
//		
//		departmentMapper.insertSelective(new Department(null, "测试部"));
//		departmentMapper.insertSelective(new Department(null, "市场部"));
		
		//2、测试插入员工数据
		
//		employeeMapper.insertSelective(new Employee(null,"Tom", "M", "tom.tian@oracle.com", 8));
//		employeeMapper.insertSelective(new Employee(null,"Eva", "F", "eva.tian@school.com", 10));
//		employeeMapper.insertSelective(new Employee(null,"Carrie", "F", "eva.tian@school.com", 9));
		
		//3、批量插入数据
		
		/*
		 * 这种方式不推荐
		 */
//		for(){
//			employeeMapper.insertSelective(new Employee(null,"Carrie", "F", "eva.tian@school.com", 9));
//		}
		
		/*
		 * 推荐这种方式
		 */
		
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for(int i=0;i<1000;i++){
			String uid = UUID.randomUUID().toString().substring(0, 5)+i;
			mapper.insertSelective(new Employee(null, uid, "M",uid+"@tom.com", 11));
		}
	}
	
	
	
}
