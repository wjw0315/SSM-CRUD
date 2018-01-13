package com.ppx.crud.test;

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
import com.ppx.crud.bean.Employee;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations={"classpath:applicationContext.xml","file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
public class MvcTest {
	//传入springmvc 的ioc容器
	@Autowired
	WebApplicationContext webApplicationContext;
	//虚拟mvc请求,获取处理的结果
	MockMvc mockMvc;
	@Before
	public void initMockMvc(){
		mockMvc=MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
		
	}
	@Test
	public void MvcEmps() throws Exception{
		
		//模拟请求，获取返回值
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pageNum", "1")).andReturn();
		//请求成功后，在请求域中取出pageinfo的值进行验证
		MockHttpServletRequest request = result.getRequest();
		PageInfo pageinfo=(PageInfo)request.getAttribute("pageinfo");
		
		System.out.println("当前的页码："+pageinfo.getPageNum());
		System.out.println("总页码数"+pageinfo.getPages());
		System.out.println("总的记录数："+pageinfo.getTotal());
		System.out.println("在页面需要连续显示的页码：");
		int[] num=pageinfo.getNavigatepageNums();
		for (int i : num) {
			System.out.println(" "+i);
			
		}
		System.out.println(" ");
		List<Employee> list=pageinfo.getList();
		for (Employee employee : list) {
			System.out.println("empId:"+employee.getEmpId());
			System.out.println("empName:"+employee.getEmpName());
			System.out.println("empDepa:"+employee.getDepartment());
		}
	}
}
