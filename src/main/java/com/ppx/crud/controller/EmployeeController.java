package com.ppx.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.objenesis.instantiator.sun.MagicInstantiator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ppx.crud.bean.Employee;
import com.ppx.crud.bean.Msg;
import com.ppx.crud.service.EmployeeService;

@Controller
public class EmployeeController {
	@Autowired
	EmployeeService employeeService;
	/**
	 * ���⣺
	 * �����������ݣ�����employee�����װ����
	 * 
	 * ԭ��
	 * Tomcat��
	 * 		1�����������е����ݷ�װ��һ��map
	 * 		2��request.getParmeter("empName")���Ǵ�map��ȡֵ
	 * 		3��Springmvc��װ��POJO�����ʱ����POJO�е�ÿ�����Ե�ֵ��request.getParmeter
	 * ajax����Put�������������⣺
	 * 		PUT���������������request.getParmeter����Ҫȡ���������ò���
	 * 		Tomcat�п�����put����Ͳ���������е����ݽ��з�װ��map
	 * 
	 * ���������
	 * 		��web.xml�ж����������������:HttpPutFormContentFilter
	 * 
	 * 
	 * ɾ��Ա����Ϣ,����ɾ��������ɾ��
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmp(@PathVariable("ids")String ids){
		//System.out.println("��������idֵ��"+id);
		if(ids.contains("-")){
			List<Integer> del_ids=new ArrayList<Integer>();
			String[] sp_ids=ids.split("-");
			for (String string : sp_ids) {
				//��װids�ļ���
				//Integer.parseInt(string);
				del_ids.add(Integer.parseInt(string));
				employeeService.deleteBatch(del_ids);
			}
		}else {
			int id=Integer.parseInt(ids);
			employeeService.deleteEmp(id);
			
		}
		return Msg.success();
	}
	
	
	/**
	 * ����Ա����Ϣ
	 * @param employee
	 * @return
	 */
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	@ResponseBody
	public Msg updateEmp(Employee employee){
		employeeService.updateEmp(employee);
		return Msg.success();
	}
	/**
	 * ͨ��id��ѯ����ǰ��Ա����Ϣ
	 * @param empId
	 * @return
	 */
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id") Integer empId){
		Employee employee=employeeService.getEmp(empId);
		//System.out.println("��ȡ����id��"+empId);
		return Msg.success().add("emp", employee);
	}
	/**
	 * ajax��֤�û����Ƿ��ظ�
	 * @param empName
	 * @return
	 */
	@RequestMapping("/checkuser")
	@ResponseBody
	public Msg checkUser(@RequestParam(value="empName")String empName){
		//���ж��û����Ƿ�Ϸ�
		String name_regex ="(^[a-zA-Z0-9_-]{5,16}$)|(^[\\u2E80-\\u9FFF]{3,6}$)";
		if(!empName.matches(name_regex)){
			return Msg.fail().add("va_msg", "�û���Ϊ5-16λ��ĸ����3-6λ����");
		}
		//���ݿ��ٽ���
		boolean b=employeeService.checkUser(empName);
		if (b) {
			return Msg.success();
		}
		return Msg.fail().add("va_msg", "�û����ظ�������");
	}
	
	/**
	 * �����û���Ϣ
	 * @param employee
	 * @return
	 */
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	@ResponseBody
	public Msg serveEmp(@Valid Employee employee,BindingResult result){
		if(result.hasErrors()){
			Map<String, Object> map=new HashMap<String, Object>();
			List<FieldError> error=result.getFieldErrors();
			for (FieldError fieldError : error) {
				System.out.println("�����ֶ���"+fieldError.getField());
				System.out.println("�������Ϣ"+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("fieldError", map);
			
		}else {
			employeeService.serveEmp(employee);
			
			return Msg.success();
		}
		
	}
	
	/**
	 * ��ѯ����ʹ��pagehelper��ҳ��ʾ����ȡ�����û���Ϣ
	 * @param pageNum
	 * @param model
	 * @return
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value="pageNum" ,defaultValue="1")Integer pageNum,Model model){
		//����pagehelper��ҳ���
		PageHelper.startPage(pageNum, 5);
		//�����ҳ�ĺ��������ѯ�����ݾ��Ƿ�ҳ��ѯ
		List<Employee>  list =employeeService.getAll();
		//ʹ��pageInfo����װ��ѯ�Ľ��
		//��װ��ҳ����Ϣ��������ѯ���������� ��������Ҫ��ʾ��ҳ��  eg:5
		PageInfo page =new PageInfo(list, 5);
		
	//	model.addAttribute("pageinfo", page);
		
		return Msg.success().add("pageinfo", page);
	}
	
	
	/**
	 * pagehelper��ҳ��
	 * @param pageNum
	 * @param model
	 * @return
	 */
	//@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pageNum" ,defaultValue="1")Integer pageNum,Model model){
		//����pagehelper��ҳ���
		PageHelper.startPage(pageNum, 5);
		//�����ҳ�ĺ��������ѯ�����ݾ��Ƿ�ҳ��ѯ
		List<Employee>  list =employeeService.getAll();

		//ʹ��pageInfo����װ��ѯ�Ľ��
		//��װ��ҳ����Ϣ��������ѯ���������� ��������Ҫ��ʾ��ҳ��  eg:5
		PageInfo page =new PageInfo(list, 5);
		
		model.addAttribute("pageinfo", page);
		return "list";
		
	}
}
