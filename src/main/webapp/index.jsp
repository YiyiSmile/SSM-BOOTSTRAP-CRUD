<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!-- 

	关于web路径的问题：
	1、使用相对路径(不以/开始)： 容易出问题
	2、使用绝对路径(以/开始)：     不容易出问题， 比如: http://localhost:8080/crud/static/....，其中/代表的时服务器地址+端口号
	
	可以去掉http://localhost:8080，同时项目名（crud）不写死，通过如下方式实现
	
	${APP_PATH} 以斜线开始，不以斜线结尾。所以最终看起来是这样的： "${APP_PATH}/static/js/jquery.min.js"， 前边没有/

	pageContext.setAttribute("APP_PATH",request.getContextPath());
	
	request.getContextPath() 函数注释：
	
	 * Returns the portion of the request URI that indicates the context
     * of the request. The context path always comes first in a request
     * URI. The path starts with a "/" character but does not end with a "/"
     * character. F
 -->

<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。 -->
<script
	src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

<!-- Bootstrap -->
<link
	href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">

<title>员工列表</title>
</head>
<body>

	<!---------------------------------------修改员工模态框 ------------------------------------------->

	<div class="modal fade" id="emp_update_modal" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">修改员工信息</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<!-- for="empName_add_input" 可以不指定 
							 每个元素name属性需要指定，mvc把提交的数据自动封装成bean对象，唯一要求是元素name属性与bean属性名字一样
						-->
							<label for="empName_add_input" class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<p class="form-control-static" id="empName_update_static"></p>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">empEmail</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control"
									id="empEmail_update_input" placeholder="name@company.com">
								<span class="help-block"></span>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">Gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender_update_radio1" value="M"
									checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender_update_radio2" value="F"> 女
								</label>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">部门</label>
							<div class="col-sm-4">
								<select class="form-control" name="dId" id="dept_update_list">

								</select>
							</div>
						</div>

					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
				</div>
			</div>
		</div>
	</div>

	<!---------------------------------------新增员工模态框 ------------------------------------------->


	<div class="modal fade" id="emp_add_modal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">新增员工信息</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<!-- for="empName_add_input" 可以不指定 
							 每个元素name属性需要指定，mvc把提交的数据自动封装成bean对象，唯一要求是元素name属性与bean属性名字一样
						-->
							<label for="empName_add_input" class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<input type="text" name="empName" class="form-control"
									id="empName_add_input" placeholder="empNmae"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">empEmail</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control"
									id="empEmail_add_input" placeholder="name@company.com">
								<span class="help-block"></span>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">Gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender_add_radio1" value="M"
									checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender_add_radio2" value="F"> 女
								</label>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">部门</label>
							<div class="col-sm-4">
								<select class="form-control" name="dId" id="dept_add_list">

								</select>
							</div>
						</div>

					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
				</div>
			</div>
		</div>
	</div>





	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8"" >
				<button class="btn btn-primary" id="emp_add_btn">新增</button>
				<button class="btn btn-danger" id="emp_del_btn">删除</button>
			</div>
		</div>
		<!-- 表格 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th><input type="checkbox" id="checkAll" /></th>
							<th>#</th>
							<th>员工姓名</th>
							<th>性别</th>
							<th>邮箱</th>
							<th>部门</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
		<!-- 分页 -->
		<div class="row">
			<div class="col-md-6" id="page_info_area"></div>
			<!-- 导航条  -->
			<div class="col-md-6" id="page_nav_area"></div>
		</div>

	</div>

	<!--============================================JavaScript======================================================================-->
	<script type="text/javascript">
		//定义全局变量，保存总记录数,以及当前页
		var totalRecords;
		var currentPage;

		/*------------------------------------显示首页-------------------------------------------  */

		//页面加载完成之后，直接发送ajax请求，要到分页信息
		$(function() {
			to_page(1);
		});

		/*------------------------------------新增员工-------------------------------------------  */

		//点击新增按钮，弹出模态框
		$("#emp_add_btn").click(function() {
			//将表单数据清空(包括输入数据，样式以及提示信息),由于jquery没有reset方法，所以使用dom对象的reset方法（数组[0]）
			resetForm($("#emp_add_modal form"));
			//获取部门列表，并显示到下拉列表中
			//写成getDeptsFor("#emp_add_modal select")也可以，getDeptsFor内部调用appendTo()方法，该方法参数可以是字符串，也可以是jquery选择器对象;
			getDeptsFor($("#emp_add_modal select"));
			//弹出模态框
			$("#emp_add_modal").modal({
				backdrop : "static"
			})
		});

		//给用户名输入框绑定校验事件，检查用户名是否已经存在
		$("#empName_add_input").change(
				function() {
					var empName = this.value;
					$.ajax({
						url : "${APP_PATH}/checkuser",
						data : "empName=" + empName,
						type : "POST",
						success : function(result) {
							//这儿有一个问题，如果用户名后端数据检查通过没有重复，但是不符合长度规则，在点击保存按钮时又会报用户名不服可要求，
							//这样给用户一个矛盾的感觉。所有我们在后端做用户重复检查时，顺便检查一下用户名长度规则是否符合要求。当然这也可以放在前端的代码去做。
							if (result.code == 200) {
								show_validate_msg("#empName_add_input",
										"success", result.extend.validate_msg);
								$("#emp_save_btn").attr(
										"userName_exist_validate", "success");
								//给保存按钮添加自定义属性，来保存用户名校验结果，留给按钮点击时使用。也可以将结果保存在全局变量中，但是那样不够优雅
							} else if (result.code == 100) {
								show_validate_msg("#empName_add_input",
										"error", result.extend.validate_msg);
								$("#emp_save_btn").attr(
										"userName_exist_validate", "error");
							}
						}
					});
				});

		//给新增员工页面的保存按钮绑定点击事件
		$("#emp_save_btn")
				.click(
						function() {
							/* 第一种写法 ，推荐*/
							//alert($("#emp_add_modal form").serialize());
							//1、数据校验
							if (!validate_add_form()) {
								return;
							}
							//2. 判断用户名是否已经存在
							if ($("#emp_save_btn").attr(
									"userName_exist_validate") == "error") {
								return false;
							}
							//3、提交数据
							$
									.ajax({
										url : "${APP_PATH}/emp",
										type : "POST",
										data : $("#emp_add_modal form")
												.serialize(),
										success : function(result) {
											//服务端校验成功
											if (result.code == 200) {
												//1.关闭模态框
												$("#emp_add_modal").modal(
														'hide');
												/* 					2.显示最后一页,定义一个全局变量totalRecord(总记录数)，保存总记录数，pagehelper有个特性，
												 当请求的pagenumber大于最大页数时，返回的是最后一页数据,我们将访问的页数设置成
												 totalRecord，因为总记录数肯定大于总页数。totalRecord在build_page_info()方法
												 中赋值。 */
												to_page(totalRecords);

											} else {
												//服务端校验失败
												if (undefined != result.extend.errorFields.email) {
													show_validate_msg(
															"#empEmail_add_input",
															"error",
															result.extend.errorFields.email);
												}

												if (undefined != result.extend.errorFields.empName) {
													show_validate_msg(
															"#empName_add_input",
															"error",
															result.extend.errorFields.empName);
												}
											}

										}
									});

							/* 2、第二种写法 */

							/* 			var emp = {
							 empName: $("#empName_add_input").val(),
							 email: $("#empEmail_add_input").val(),
							 gender: $("input[name='gender']:checked").val(),
							 dId: $("#dept_add_list option:selected").val()		
							 }
							
							 $.ajax({
							 url: "${APP_PATH}/emp",
							 type: "POST",
							 data: emp,
							 success: function(msg){
							 console.log(msg);
							 } 
							
							 });*/
						});

		/*------------------------------------编辑员工-------------------------------------------  */

		//绑定表格中编辑，删除按钮单击事件
		/*下边这种方式是绑不上的，因为页面开始打开时，发送ajax请求去获取首页数据，ajax是异步的，浏览器不等ajax返回，就执行下边的绑定单击事件函数，而此时
		页面还没有edit-btn元素。
		
		解决方法有两种：
		1. 在生成表格，添加按钮是绑定
		2. 使用.live()函数，可以为后增加的元素绑定事件，但是新版本jquery不支持该方法，替代方法是on()
		3. on方法不能直接用在绑定事件的元素上，需要在其上级元素调用，我们这里使用整个文档元素document
		$(".edit_btn").click(function(){
			alert("test");
		});
		
		 */

		$(document).on("click", ".edit_btn", function() {
			//1.查询员工信息

			//这里边this 是htmlobject对象，而$（this）是object对象.而jquery选择器返回值都是object对象？
			var empId = $(this).attr("empIdForEdit");
			/* 			alert($(this));
			 alert(this);
			 alert($("#emp_update_modal")); */
			getEmp(empId);
			//2.查询部信息
			getDeptsFor($("#emp_update_modal select"));
			//3. 给更新按钮绑定empId的值
			$("#emp_update_btn").attr("epmIdForUpdate", empId);
			//4.弹出模态框
			$("#emp_update_modal").modal({
				backdrop : "static"
			});
		});

		//为编辑员工页面的“更新”按钮绑定单击事件

		/*ajax支持直接发送PUT请求，不需要通过post请求，然后在请求参数中加上"&_method=PUT"
		
		AJAX发送put请求引发的血案
		--------------------------
		问题：
		
		但是将type改成put之后，会发现在服务端控制器public Msg updateEmp(Employee emp)，	参数emp对象中，除了empId不是空的，其他全是null值
		Employee [empId=1008, empName=null, gender=null, email=null, dId=null]
		
		原因：
		
		通过跟踪，发现数据是有提给服务器的，只是数据没有绑定到emp对象中。
		这是tomcat的问题。Tomcat的工作方式是这样的：
		1.将请求参数都封装到一个map中
		2.request.getParameter("empName")这种调用就会从map取值
		3.spring mvc在封装pojo对象时，会调用每个request.getParameter()方法来构建pojo对象，比如controller的实参参数emp对象。
		
		但是在我们的case中，因为是put请求,tomcat就不会把请求体中的参数封装到map中，所以spring mvc通过request.getParameter()也
		拿不到数据去封装pojo对象。
		
		从tomcat源码中可以看到,tomcat只针对post请求，会解析参数， （不包含get请求？）
		
		解决方法：
		使用spring 提供的HttpPutFormContentFilter过滤器。因为tomcat在封装完request对象之后，虽然没有帮我们针对put请求将请求体中的
		参数封装到map，但是请求数据依然在request对象中，所以spring可以帮我们把这些请求数据重新放到map中，这样就和post请求的request对象一样了，
		都有一个map，保存了所有请求参数。
		 */
		$("#emp_update_btn").click(function() {
			//检查邮箱格式是否正确
			if (!validateEmail("#empEmail_update_input")) {
				return false;
			}

			//发送ajax请求，更型数据库，方式1
			$.ajax({
				url : "${APP_PATH}/emp/" + $(this).attr("epmIdForUpdate"),
				type : "PUT",

				//因为模态框没有员工id，而数据库更新我们选择根据主键更新，所以必须手工在这儿加上员工id。
				//也可以在控制器端， 将mapping url的占位符从id改成根Employee的id字段名一样： empId,比如改成
				//@RequestMapping(value="/emp/{empId}"
				/* @RequestMapping(value="/emp/{id}",method = RequestMethod.PUT)
				public Msg updateEmp(Employee emp)  */
				data : $("#emp_update_modal form").serialize(),
				success : function(result) {
					$("#emp_update_modal").modal('hide');
					to_page(currentPage);
				}

			});
			//发送ajax请求，更型数据库，方式2
			/* 			$.ajax({
			 url: "${APP_PATH}/emp/" + $(this).attr("epmIdForUpdate"),
			 type: "POST",
			
			 //因为模态框没有员工id，而数据库更新我们选择根据主键更新，所以必须手工在这儿加上员工id。
			 //也可以在控制器端， 将mapping url的占位符从id改成根Employee的id字段名一样： empId,比如改成
			 //@RequestMapping(value="/emp/{empId}"
			 //@RequestMapping(value="/emp/{id}",method = RequestMethod.PUT)
			 //public Msg updateEmp(Employee emp) 
			 data: "empId=" + $(this).attr("epmIdForUpdate") + "&" + $("#emp_update_modal form").serialize()+ "&_method=PUT",
			 success: function(result){
			 $("#emp_update_modal").modal('hide');
			 to_page(currentPage);
			 }
			
			 }); */
		});

		/*------------------------------------删除员工-------------------------------------------  */

		//为删除按钮绑定事件
		$(document).on("click", ".delete_btn", function() {

			//1. 弹出删除确认对话框
			var empName = $(this).parents("tr").find("td:eq(2)").text();

			if (confirm("确认删除员工【" + empName + "】么？")) {
				//2.获取员工id
				var empId = $(this).attr("empIdForDelete");
				//3.发送ajax请求
				$.ajax({
					url : "${APP_PATH}/emp/" + empId,
					type : "DELETE",
					success : function(result) {
						alert("处理成功");
						to_page(currentPage);
					}
				});

			}

		});

		/*------------------------------------删除多个选中员工-------------------------------------------  */

		//1. 给全选按钮绑定事件
		//全选，不全选按钮
		$("#checkAll").click(function() {
			//这里alert会打出undefined, 这是因为确实没有显示定义checked属性。
			//对于dom的元素的原生属性,用attr获取不到。可以用prop获取
			/* state = $("#checkAll").attr("checked");
			alert(state); */

			//$(this)是 将javascript this对象包装成jquery对象
			state = $(this).prop("checked");
			//使用javascript原生方法
			//state = document.getElementById("checkAll").checked;
			//alert(state);
			$(".check_item").prop("checked", state);
		});

		//2. 给每一行单元框绑定事件
		//因为是后加的，所以也用$(document).on()方式绑定， 当单选框全部选中时，全选按钮也要选中
		$(document)
				.on(
						"click",
						".check_item",
						function() {
							/* 			if($(".check_item:checked").length == $(".check_item").lenth){
							 $("#checkAll").prop("checked",true);
							 }else{
							 $("#checkAll").prop("checked",false);
							 } */
							//另一种写法：
							$("#checkAll")
									.prop(
											"checked",
											$(".check_item:checked").length == $(".check_item").lenth);
						});

		//3. 为多选删除按钮绑定事件
		$("#emp_del_btn").click(
				function() {
					//获取所有选中员工姓名
					var empNames = "";
					var empIds = "";
					$.each($(".check_item:checked"), function() {
						empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
						empIds += $(this).parents("tr").find("td:eq(1)").text() + "-";
					});
					//去除最后一个符号
					empNames = empNames.substring(0, empNames.length - 1);
					empIds = empIds.substring(0, empIds.length - 1);
					//弹出对话框
					if (confirm("确定要删除员工【" + empNames + "】么？")) {
						
						$.ajax({
							url : "${APP_PATH}/emp/" + empIds,
							type : "DELETE",
							success : function(result) {
								alert(result.msg);
								//回到当前页
								to_page(currentPage);
							}
						});
					}
					//发送ajax请求

				});

		/*------------------------------------公共方法-------------------------------------------  */

		function resetForm(jQueryElement) {
			jQueryElement[0].reset();
			jQueryElement.find("*").removeClass("has-success has-error");
			jQueryElement.find(".help-block").text("");
		}

		function to_page(pn) {
			$.ajax({
				url : "${APP_PATH}/emps",
				data : "pn=" + pn,
				type : "get",
				success : function(result) {
					//console.log(result);
					//1、解析员工数据
					build_emp_table(result);
					//显示左边分页信息
					build_page_info(result);
					//显示右边导航信息
					build_page_nav(result);
				}
			});
		}
		function build_emp_table(result) {

			//先清空数据
			$("#emps_table tbody").empty();

			var emps = result.extend.pageInfo.list;
			$
					.each(
							emps,
							function(index, item) {
								var checkboxTd = $("<td><input type='checkbox' class='check_item'</td>");
								var empIdTd = $("<td></td>").append(item.empId);
								var empNameTd = $("<td></td>").append(
										item.empName);
								var empGenderTd = $("<td></td>").append(
										item.gender == "M" ? "男" : "女");
								var empEmailTd = $("<td></td>").append(
										item.email);
								var empDeptTd = $("<td></td>").append(
										item.department.deptName);
								//添加按钮
								var btn_add = $("<button></button")
										.addClass(
												"btn btn-primary btn-sm edit_btn")
										.append(
												$("<span><span>")
														.addClass(
																"glyphicon glyphicon-pencil"))
										.append("编辑");

								//为编辑按钮提价一个自定义属性，保存员工id的值，方便点击编辑按钮的时候，绑定函数获取此值
								btn_add.attr("empIdForEdit", item.empId);

								var btn_del = $("<button></button")
										.addClass(
												"btn btn-danger btn-sm delete_btn")
										.append(
												$("<span><span>")
														.addClass(
																"glyphicon glyphicon-trash"))
										.append("删除");
								//为删除按钮绑定一个自定义属性，保存员工id的值，方便点击编辑删除的时候，绑定函数获取此值
								btn_del.attr("empIdForDelete", item.empId);
								var btnTd = $("<td></td>").append(btn_add)
										.append(" ").append(btn_del);
								$("<tr></tr>").append(checkboxTd).append(
										empIdTd).append(empNameTd).append(
										empGenderTd).append(empEmailTd).append(
										empDeptTd).append(btnTd).appendTo(
										"#emps_table tbody");
							});
		}

		//显示左边分页信息
		function build_page_info(result) {
			//先清空数据
			$("#page_info_area").empty()

			$("#page_info_area").append(
					"当前" + result.extend.pageInfo.pageNum + "页，总"
							+ result.extend.pageInfo.pages + "页，总"
							+ result.extend.pageInfo.total + "记录");

			//下边两个是全局变量
			totalRecords = result.extend.pageInfo.total;
			currentPage = result.extend.pageInfo.pageNum;
		}

		//显示右边分页条,导航信息
		function build_page_nav(result) {
			//先清空数据
			$("#page_nav_area").empty();

			var ulEle = $("<ul></ul>").addClass("pagination");

			//构建元素
			var firstPageLi = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href", "#"));
			var prePageLi = $("<li></li>").append(
					$("<a></a>").append("&laquo;").attr("href", "#"));

			//给元素绑定单击事件

			if (result.extend.pageInfo.hasPreviousPage == false) {
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			} else {
				firstPageLi.click(function() {
					to_page(1);
				});

				prePageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum - 1);
				});
			}
			var nextPageLi = $("<li></li>").append(
					$("<a></a>").append("&raquo;").attr("href", "#"));
			var lastPageLi = $("<li></li>").append(
					$("<a></a>").append("末页").attr("href", "#"));

			//给元素绑定单击事件

			if (result.extend.pageInfo.hasNextPage == false) {
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			} else {
				nextPageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum + 1);
				});

				lastPageLi.click(function() {
					to_page(result.extend.pageInfo.pages);
				});

			}
			ulEle.append(firstPageLi).append(prePageLi);
			$.each(result.extend.pageInfo.navigatepageNums, function(index,
					item) {
				var numLi = $("<li></li>").append(
						$("<a></a>").append(item).attr("href", "#"));
				if (result.extend.pageInfo.pageNum == item) {
					numLi.addClass("active");
				}
				numLi.click(function() {
					to_page(item);
				});
				ulEle.append(numLi);
			});
			ulEle.append(nextPageLi).append(lastPageLi);

			$("<nav></nav>").append(ulEle).appendTo("#page_nav_area");
		}

		//获取部门列表，并显示到下拉列表中
		function getDeptsFor(element) {
			//先清空
			$(element).empty();
			$.ajax({
				url : "${APP_PATH}/depts",
				type : "GET",
				success : function(result) {
					//	console.log(result);
					var depts = result.extend.depts
					//这里没有使用$("dept_add_list")， 提供另一种选择元素的方式，因为modal里只有一个select元素，可以用如下方式
					//var deptSelect = $("#emp_add_modal select")
					//这里不用function(index, item),遍历函数体内this可以访问遍历对象
					$.each(depts, function() {
						var optionEle = $("<option></option>").append(
								this.deptName).attr("value", this.deptId);
						//还可以写成：optionEle.appendTo(deptSelect)
						element.append(optionEle);
					})
				}
			});
		}

		//校验表单数据
		function validate_add_form() {
			//校验用户名
			var empName = $("#empName_add_input").val();
			regEmpName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
			if (!regEmpName.test(empName)) {
				//alert("用户名必须是6-16位字母和数字的组合或者2-5位中文");
				show_validate_msg("#empName_add_input", "error",
						"用户名必须是6-16位字母和数字的组合或者2-5位中文");
				return false;
			} else {
				show_validate_msg("#empName_add_input", "success", "");

			}

			//校验邮箱
			if (!validateEmail("#empEmail_add_input")) {
				return false
			}

			return true;

		}
		//校验邮箱
		function validateEmail(element) {
			var email = $(element).val();
			regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!regEmail.test(email)) {
				//alert("邮箱格式不正确");
				show_validate_msg(element, "error", "邮箱格式不正确");
				return false;
			} else {
				show_validate_msg(element, "success", "");
				return true;
			}
		}
		//显示错误信息
		function show_validate_msg(element, status, message) {
			//清楚当前元素的校验状态
			$(element).parent().removeClass("has-success has-error");
			$(element).next("span").text("");
			if ("success" == status) {
				$(element).parent().addClass("has-success");
				$(element).next("span").text(message);
			} else if ("error" == status) {
				$(element).parent().addClass("has-error");
				$(element).next("span").text(message);
			}
		}

		//查询单个员工信息 
		function getEmp(id) {

			$.ajax({
				url : "${APP_PATH}/emp/" + id,
				type : "GET",
				success : function(result) {

					var empData = result.extend.emp;

					$("#empName_update_static").text(empData.empName);
					$("#empEmail_update_input").val(empData.email);
					$("#emp_update_modal input[name=gender]").val(
							[ empData.gender ]);
					$("#dept_update_list").val([ empData.dId ]);
					console.log($("#dept_update_list"));
					console.log($("#emp_update_modal select"));
				}
			});
		}
	</script>
</body>
</html>