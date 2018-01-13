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
	//����springmvc ��ioc����
	@Autowired
	WebApplicationContext webApplicationContext;
	//����mvc����,��ȡ����Ľ��
	MockMvc mockMvc;
	@Before
	public void initMockMvc(){
		mockMvc=MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
		
	}
	@Test
	public void MvcEmps() throws Exception{
		
		//ģ�����󣬻�ȡ����ֵ
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pageNum", "1")).andReturn();
		//����ɹ�������������ȡ��pageinfo��ֵ������֤
		MockHttpServletRequest request = result.getRequest();
		PageInfo pageinfo=(PageInfo)request.getAttribute("pageinfo");
		
		System.out.println("��ǰ��ҳ�룺"+pageinfo.getPageNum());
		System.out.println("��ҳ����"+pageinfo.getPages());
		System.out.println("�ܵļ�¼����"+pageinfo.getTotal());
		System.out.println("��ҳ����Ҫ������ʾ��ҳ�룺");
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
