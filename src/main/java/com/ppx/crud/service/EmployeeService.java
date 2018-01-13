package com.ppx.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ppx.crud.bean.Employee;
import com.ppx.crud.bean.EmployeeExample;
import com.ppx.crud.bean.EmployeeExample.Criteria;
import com.ppx.crud.dao.EmployeeMapper;

@Service
public class EmployeeService {
	@Autowired
	EmployeeMapper employeeMapper;
	/**
	 * 获取所有的员工信息
	 * @return
	 */
	public List<Employee> getAll(){
		
		return employeeMapper.selectByExampleWithDept(null);
	}
	/**
	 * 新增员工信息
	 * @param employee
	 */
	public void serveEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.insertSelective(employee);
		
	}
	/**
	 * ajax验证用户名是否重复
	 * @param empName
	 * @return
	 */
	public boolean checkUser(String empName) {
		EmployeeExample employeeExample=new EmployeeExample();
		Criteria criteria= employeeExample.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		//employeeExample.createCriteria().andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(employeeExample);
		return count == 0;
		
	}
	/**
	 * 通过id查询到当前员工信息
	 * @param empId
	 * @return
	 */
	public Employee getEmp(Integer empId) {
		// TODO Auto-generated method stub
		Employee employee=employeeMapper.selectByPrimaryKey(empId);
		return employee;
	}
	/**
	 * 更新员工信息
	 * @param employee
	 */
	public void updateEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.updateByPrimaryKeySelective(employee);
	}
	/**
	 * 删除员工信息
	 * @param id
	 */
	public void deleteEmp(Integer id) {
		// TODO Auto-generated method stub
		employeeMapper.deleteByPrimaryKey(id);
	}
	/**
	 * 批量删除员工数据
	 */
	public void deleteBatch(List<Integer> ids) {
		// TODO Auto-generated method stub
		EmployeeExample example=new EmployeeExample();
		Criteria criteria=example.createCriteria();
		criteria.andEmpIdIn(ids);
		employeeMapper.deleteByExample(example);
	}
}
