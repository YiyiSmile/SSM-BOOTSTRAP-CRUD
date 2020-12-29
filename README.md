## Overview

This is a excercise project which based on Spring, Spring MVC, Spring TEST, MyBatis(Mybatis generator), Bootstrap, Jquery，MySql etc.

The project is REST style, with a front-end and back-end separation architecture.

使用组件
--------

	Spring  
	Spring MVC  
	Spring test  
	Mybatis (Mybatis generator)  
	Spring boot  
	Jquery  
	Maven  
	Mysql  


URI约定 （REST 风格）
--------------------

	/emp/{id}	GET		获取   
	/emp		POST 	新增  
	/emp/{id}	PUT		更新/修改  
	/emp/{id}	DELETE	删除  


功能需求
---------
1、新增逻辑

	1）在index.jsp页面点击"新增"按钮，弹出新增对话框  
	2） 去数据库查询部门列表，显示在列表框中  
	3）用户输入完数据，进行校验  
	4）保存退出(发送新增ajax请求)，返回当前页并刷新数据。  
	5) 在服务端也需要校验(JSR303)   
2、删除单个用户

	1) 点击记录删除按钮，弹出确认对话框  
	2) 发送ajax请求，删除数据  
	3) 返回当前页最新数据  
3、批量删除用户

	1) 选中全选框，会选中当页所有记录  
	2) 手工选中所有记录，全选框会跟着选中，反之亦然  
	3) 点击全部删除按钮，弹出提示对话框  
	4) 确认，通过ajax发送删除请求  
4、编辑用户

	1) 点击编辑，发送ajax请求，查询单个用户，并显示在模态框中  
	2) 可以更改邮箱，性别，部门。焦点离开时对用户输入数据进行校验  
	3) 点击保存，发送ajax请求，更新用户  
	4) 在服务端也需要校验(JSR303)   
5、index页查询用户

	1) index.jsp只存放基本的标签，没有任何内容  
	2) 客户端收到index页，发送ajax查询用户数据，并分页显示，显示分页信息  
	
效果展示
--------
![](https://github.com/YiyiSmile/SSM-BOOTSTRAP-CRUD/blob/main/images/index.PNG)
![](https://github.com/YiyiSmile/SSM-BOOTSTRAP-CRUD/blob/main/images/add.PNG)
![](https://github.com/YiyiSmile/SSM-BOOTSTRAP-CRUD/blob/main/images/edit.PNG)

系统结构
--------
![](https://github.com/YiyiSmile/SSM-BOOTSTRAP-CRUD/blob/main/images/arch.PNG)



