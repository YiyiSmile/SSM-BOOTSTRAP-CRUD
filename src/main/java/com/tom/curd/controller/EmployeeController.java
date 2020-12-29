package com.tom.curd.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.tom.curd.bean.Employee;
import com.tom.curd.bean.Msg;
import com.tom.curd.service.EmployeeService;


/**
 * 处理员工CRUD请求
 * 
 * @author totian
 *
 */
@Controller
public class EmployeeController {

	/**
	 * 查询所有员工数据（分页显示）,
	 * 
	 * @return
	 */

	@Autowired
	EmployeeService employeeService;

	/*
	 * 返回jason字符串，由客户端负责根据收到的jason数据进行展示。 这样无论客户端是浏览器，还是ios,android引用，都可以使用
	 */

	@ResponseBody
	@RequestMapping("/emps")
	public Msg getEmpsWithJason(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
		// pn: 页码，5： 每页大小
		PageHelper.startPage(pn, 5);

		List<Employee> emps = employeeService.getAll();

		/*
		 * 使用pageinfo包装查询出来的结果，只需将pageinfo传给页面就行了，
		 * 封装了分页信息，以及在创建pageinfo时，我们传入的第二个参数：在底部显示多少页
		 */
		PageInfo pageInfo = new PageInfo<>(emps, 5);

		return Msg.success().add("pageInfo", pageInfo);
	}

	/*
	 * 使用传统方式，返回list页面
	 */
	@RequestMapping("/emps-test")
	public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {

		/*
		 * employeeService.getAll不是一个分页查询
		 * 但是如果在调用它之前，调用ageHelper.startPage()，employeeService.getAll 就成为一个分页查询
		 * 
		 */

		// pn: 页码，5： 每页大小
		PageHelper.startPage(pn, 5);

		List<Employee> emps = employeeService.getAll();

		/*
		 * 使用pageinfo包装查询出来的结果，只需将pageinfo传给页面就行了，
		 * 封装了分页信息，以及在创建pageinfo时，我们传入的第二个参数：在底部显示多少页
		 */
		PageInfo page = new PageInfo<>(emps, 5);

		model.addAttribute("pageInfo", page);
		return "list";
	}

	/**
	 * 新增员工 1.对员工数据进行后端校验。只有前端校验，不安全，用户总有办法绕过前端javascript,比如通过浏览器开发者模式手工修 改js代码。 2.
	 * 完整的校验方式是前端，后端，数据库，三者都进行校验 3. 后端校验需要hibernate-vlidate.jar （jsr303） 4. 需要tomcat
	 * 7以及以上的版本。Tomcat 7以下版本由于使用的el表达式包 不支持，需要升级el包的版本。
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/emp", method = RequestMethod.POST)
	public Msg addEmp(@Valid Employee employee, BindingResult result) {

		if (result.hasErrors()) {
			// 校验失败，在客户端模态框中显示失败消息
			List<FieldError> fieldErrors = result.getFieldErrors();
			Map<String, String> errorFields = new HashMap<>();
			for (FieldError fieldError : fieldErrors) {
				errorFields.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", errorFields);
		} else {

			employeeService.addEmployee(employee);
			return Msg.success();
		}

	}

	/**
	 * 检查用户名是否已经存在
	 */

	@ResponseBody
	@RequestMapping("/checkuser")
	public Msg checkUsername(@RequestParam("empName") String userName) {
		// 我们在后端做用户重复检查时，顺便检查一下用户名长度规则是否符合要求。当然这也可以放在前端的代码去做。
		String regex = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)";
		if (!userName.matches(regex)) {
			return Msg.fail().add("validate_msg", "用户名必须是6-16位字母和数字的组合或者2-5位中文");
		}
		// 用户是否已存在
		boolean usernameExist = employeeService.checkUsername(userName);
		if (usernameExist) {
			return Msg.fail().add("validate_msg", "用户名已存在");
		} else {
			return Msg.success().add("validate_msg", "用户名可用");
		}
	}

	/**
	 * 根据员工id查询员工
	 * 
	 * @param empId
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
	public Msg getEmpolyee(@PathVariable("id") int empId) {

		Employee employee = employeeService.getEmployee(empId);
		return Msg.success().add("emp", employee);

	}

	/**
	 * 更新单个员工信息
	 * 
	 * @param emp
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/emp/{empId}"/* 这里的empId会赋给参数emp对象的empId，
	名称必须一样才可以 */, method = RequestMethod.PUT)
	public Msg updateEmp(Employee emp) {
		System.out.println(emp);
		employeeService.updateEmp(emp);
		return Msg.success();
	}
	
	/**
	 * 删除单个员工
	 * @return
	 */
	
	/*
	 * @ResponseBody
	 * 
	 * @RequestMapping(value = "/emp/{empId}",method = RequestMethod.DELETE) public
	 * Msg deleteEmpById(@PathVariable("empId") Integer empId) {
	 * employeeService.deleteEmp(empId); return Msg.success(); }
	 */
	
	/**
	 * 单个、批量删除合二为一
	 * "/emp/{empIds}"
	 * 单个删除： id1
	 * 批量删除：id1-id2-id3
	 * @return
	 */
	
	@ResponseBody
	@RequestMapping(value = "/emp/{empIds}",method = RequestMethod.DELETE)
	public Msg deleteEmpById(@PathVariable("empIds") String empIds) {
		System.out.println(empIds);
		if(empIds.contains("-")){
			String[] ids_str = empIds.split("-");
			List<Integer> ids_int = new ArrayList<>();
			for (String id : ids_str) {
				ids_int.add(Integer.parseInt(id));
			}
			employeeService.deleteEmpsBatch(ids_int);
		}else {
			int empId = Integer.parseInt(empIds);
			employeeService.deleteEmp(empId);
		}
		return Msg.success();
	}

}
