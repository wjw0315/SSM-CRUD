package com.ppx.crud.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ppx.crud.bean.Department;
import com.ppx.crud.dao.DepartmentMapper;
import com.ppx.crud.dao.EmployeeMapper;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {
	
	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	EmployeeMapper employeeMapper;
	@Test
	public void testCurd(){
		
		System.out.println(departmentMapper);
		//Department department=new Department();
		//departmentMapper.insertSelective(new Department(null,"sadf"));
		//departmentMapper.insertSelective(new Department(null,"≤‚ ‘≤ø"));
		
		System.out.println(employeeMapper.selectByExampleWithDept(null));
		
	}
}
