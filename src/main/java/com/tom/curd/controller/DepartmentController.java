package com.tom.curd.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tom.curd.bean.Department;
import com.tom.curd.bean.Msg;
import com.tom.curd.service.DepartmentService;

/**
 * 处理部门有关的请求
 * @author totian
 *
 *
1、URI约定 （REST 风格）

/emp/{id}	GET		获取 
/emp		POST 	新增
/emp/{id}	PUT		更新/修改
/emp/{id}	DELETE	删除


-------------
 *
 *
 */
/* test git */
/* test git */

@Controller
public class DepartmentController {
	
	@Autowired
	DepartmentService departmentService;
	
	@ResponseBody
	@RequestMapping("/depts")
	public Msg getDepts(){
		List<Department> list = departmentService.getAll();
		return Msg.success().add("depts", list);
	}
	
}
