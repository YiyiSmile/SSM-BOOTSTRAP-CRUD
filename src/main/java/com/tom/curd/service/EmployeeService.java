package com.tom.curd.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tom.curd.bean.Employee;
import com.tom.curd.bean.EmployeeExample;
import com.tom.curd.bean.EmployeeExample.Criteria;
import com.tom.curd.dao.EmployeeMapper;

@Service
public class EmployeeService {

	@Autowired
	EmployeeMapper employeeMapper;

	public List<Employee> getAll() {
		return employeeMapper.selectByExampleWithDept(null);
	}

	public void addEmployee(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.insertSelective(employee);
	}

	public boolean checkUsername(String userName) {
		EmployeeExample employeeExample = new EmployeeExample();
		Criteria criteria = employeeExample.createCriteria();
		criteria.andEmpNameEqualTo(userName);
		long count = employeeMapper.countByExample(employeeExample);
		return count != 0;
	}

	public Employee getEmployee(int empId) {
		// TODO Auto-generated method stub
		Employee emp = employeeMapper.selectByPrimaryKey(empId);
		return emp;
	}

	public void updateEmp(Employee emp) {
		// TODO Auto-generated method stub
		employeeMapper.updateByPrimaryKeySelective(emp);
	}

	public void deleteEmp(Integer empId) {
		// TODO Auto-generated method stub
		employeeMapper.deleteByPrimaryKey(empId);
		
	}

	public void deleteEmpsBatch(List<Integer> ids) {
		// TODO Auto-generated method stub
		
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpIdIn(ids);
		//delete from employee where emp_id in(xx,yy,zz);
		employeeMapper.deleteByExample(example);
	}
}
