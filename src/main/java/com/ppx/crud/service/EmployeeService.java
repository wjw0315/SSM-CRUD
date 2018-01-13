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
	 * ��ȡ���е�Ա����Ϣ
	 * @return
	 */
	public List<Employee> getAll(){
		
		return employeeMapper.selectByExampleWithDept(null);
	}
	/**
	 * ����Ա����Ϣ
	 * @param employee
	 */
	public void serveEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.insertSelective(employee);
		
	}
	/**
	 * ajax��֤�û����Ƿ��ظ�
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
	 * ͨ��id��ѯ����ǰԱ����Ϣ
	 * @param empId
	 * @return
	 */
	public Employee getEmp(Integer empId) {
		// TODO Auto-generated method stub
		Employee employee=employeeMapper.selectByPrimaryKey(empId);
		return employee;
	}
	/**
	 * ����Ա����Ϣ
	 * @param employee
	 */
	public void updateEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.updateByPrimaryKeySelective(employee);
	}
	/**
	 * ɾ��Ա����Ϣ
	 * @param id
	 */
	public void deleteEmp(Integer id) {
		// TODO Auto-generated method stub
		employeeMapper.deleteByPrimaryKey(id);
	}
	/**
	 * ����ɾ��Ա������
	 */
	public void deleteBatch(List<Integer> ids) {
		// TODO Auto-generated method stub
		EmployeeExample example=new EmployeeExample();
		Criteria criteria=example.createCriteria();
		criteria.andEmpIdIn(ids);
		employeeMapper.deleteByExample(example);
	}
}
