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
	 * 问题：
	 * 请求中有数据，但是employee对象封装不上
	 * 
	 * 原因：
	 * Tomcat：
	 * 		1、将请求体中的数据封装成一个map
	 * 		2、request.getParmeter("empName")就是从map中取值
	 * 		3、Springmvc封装的POJO对象的时候会把POJO中的每个属性的值，request.getParmeter
	 * ajax发送Put请求引发的问题：
	 * 		PUT请求，请求的数据中request.getParmeter中需要取出的数据拿不到
	 * 		Tomcat中看到是put请求就不会对请求中的数据进行封装成map
	 * 
	 * 解决方案：
	 * 		在web.xml中对所有添加上拦截器:HttpPutFormContentFilter
	 * 
	 * 
	 * 删除员工信息,单个删除和批量删除
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmp(@PathVariable("ids")String ids){
		//System.out.println("传过来的id值："+id);
		if(ids.contains("-")){
			List<Integer> del_ids=new ArrayList<Integer>();
			String[] sp_ids=ids.split("-");
			for (String string : sp_ids) {
				//组装ids的集合
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
	 * 更新员工信息
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
	 * 通过id查询到当前的员工信息
	 * @param empId
	 * @return
	 */
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id") Integer empId){
		Employee employee=employeeService.getEmp(empId);
		//System.out.println("获取到的id："+empId);
		return Msg.success().add("emp", employee);
	}
	/**
	 * ajax验证用户名是否重复
	 * @param empName
	 * @return
	 */
	@RequestMapping("/checkuser")
	@ResponseBody
	public Msg checkUser(@RequestParam(value="empName")String empName){
		//先判断用户名是否合法
		String name_regex ="(^[a-zA-Z0-9_-]{5,16}$)|(^[\\u2E80-\\u9FFF]{3,6}$)";
		if(!empName.matches(name_regex)){
			return Msg.fail().add("va_msg", "用户名为5-16位字母或者3-6位中文");
		}
		//数据库再进行
		boolean b=employeeService.checkUser(empName);
		if (b) {
			return Msg.success();
		}
		return Msg.fail().add("va_msg", "用户名重复不可用");
	}
	
	/**
	 * 新增用户信息
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
				System.out.println("错误字段名"+fieldError.getField());
				System.out.println("错误的信息"+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("fieldError", map);
			
		}else {
			employeeService.serveEmp(employee);
			
			return Msg.success();
		}
		
	}
	
	/**
	 * 查询数据使用pagehelper分页显示，获取所有用户信息
	 * @param pageNum
	 * @param model
	 * @return
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value="pageNum" ,defaultValue="1")Integer pageNum,Model model){
		//引入pagehelper分页插件
		PageHelper.startPage(pageNum, 5);
		//引入分页的后面紧跟查询的内容就是分页查询
		List<Employee>  list =employeeService.getAll();
		//使用pageInfo来包装查询的结果
		//封装分页的信息，包括查询出来的数据 并传入需要显示的页数  eg:5
		PageInfo page =new PageInfo(list, 5);
		
	//	model.addAttribute("pageinfo", page);
		
		return Msg.success().add("pageinfo", page);
	}
	
	
	/**
	 * pagehelper分页条
	 * @param pageNum
	 * @param model
	 * @return
	 */
	//@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pageNum" ,defaultValue="1")Integer pageNum,Model model){
		//引入pagehelper分页插件
		PageHelper.startPage(pageNum, 5);
		//引入分页的后面紧跟查询的内容就是分页查询
		List<Employee>  list =employeeService.getAll();

		//使用pageInfo来包装查询的结果
		//封装分页的信息，包括查询出来的数据 并传入需要显示的页数  eg:5
		PageInfo page =new PageInfo(list, 5);
		
		model.addAttribute("pageinfo", page);
		return "list";
		
	}
}
