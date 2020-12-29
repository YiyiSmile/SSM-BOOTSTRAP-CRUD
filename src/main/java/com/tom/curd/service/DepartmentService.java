package com.tom.curd.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tom.curd.bean.Department;
import com.tom.curd.dao.DepartmentMapper;

@Service
public class DepartmentService {
	
	@Autowired
	DepartmentMapper departmentMapper;
	
	public List<Department> getAll(){
		return departmentMapper.selectByExample(null);
	}
}
