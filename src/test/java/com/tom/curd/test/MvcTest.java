package com.tom.curd.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;
import com.tom.curd.bean.Employee;

/**
 * 使用spring测试模块，对controller进行单元测试
 * @author totian
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations={"classpath:applicationContext.xml","file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
public class MvcTest {
	
	//虚拟mvc请求，获取处理结果
	MockMvc mockMvc;
	
	@Autowired
	WebApplicationContext context;
	
	@Before
	public void initMockMvc(){
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
	
	@Test
	public void testPage() throws Exception{
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps-test").param("pn", "1")).andReturn();
	
		MockHttpServletRequest request = result.getRequest();
		PageInfo pi = (PageInfo) request.getAttribute("pageInfo");
		
		System.out.println("当前页码" + pi.getPageNum());
		System.out.println("总页码" + pi.getPages());
		System.out.println("总记录数" + pi.getTotal());
		System.out.println("在页面需要连续显示的页码：" );
		int[] npn = pi.getNavigatepageNums();
		
		for(int i=0;i<npn.length;i++){
			System.out.println(npn[i]);
			
		}
		//获取员工数据
		List<Employee> list = pi.getList();
		
		for (Employee employee : list) {
			System.out.println("员工id:" + employee.getEmpId());
			System.out.println("员工姓名:" + employee.getEmpName());
		}
	}

}
