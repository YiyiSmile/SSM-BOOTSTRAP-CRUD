package com.tom.curd.bean;

public class Department {
    private Integer deptId;

    private String deptName;
    
    

    public Department() {
		super();
	}
    
    //设置有参构造器的同时，一定要生成午餐构造器
	public Department(Integer deptId, String deptName) {
		super();
		this.deptId = deptId;
		this.deptName = deptName;
	}

	public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName == null ? null : deptName.trim();
    }
}