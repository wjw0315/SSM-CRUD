<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>首页</title>
<!-- web的路径
不以/相对路径找资源，容易出现错误，
以/相对路径找个资源，应该以服务的路径为标准：（http://localhost:3306）,以这种形式这里则需要这样使用：
   http://localhost:3306/ssm-crud-->
<!-- 为了避免错误使用下面的方式去获取路径： -->
<%
	pageContext.setAttribute("APP_PATH",request.getContextPath()); 
%>
	<link rel="stylesheet"  href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
	<script type="text/javascript" src="${APP_PATH}/static/jquery-3.2.1.min.js"></script>
	<script type="text/javascript" src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

</head>
<body>

	<!-- 修改数据的模态框 -->
		<!-- Modal -->
		<div class="modal fade" id="emps_update_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="myModalLabel">修改员工信息</h4>
		      </div>
		      <div class="modal-body">
		        <form class="form-horizontal">
				  <div class="form-group">
				    <label for="inputEmail3" class="col-sm-2 control-label">empName</label>
				    <div class="col-sm-10">
				      <p class="form-control-static" id="empname_update_static" ></p>
				  		<span  class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="inputPassword3" class="col-sm-2 control-label">email</label>
				    <div class="col-sm-10">
				      <input type="email" class="form-control" name="email" id="email_update_input" placeholder="email@ppx.com">
				    	<span  class="help-block"></span>
				    </div>
				  </div>
				   <div class="form-group">
				    <label for="inputPassword3" class="col-sm-2 control-label">gander</label>
				    <div class="col-sm-10">
				      	<div class="radio">
						  <label>
						    <input type="radio" name="gender" id="gender_update_input1" value="M" checked="checked">
							   男
						  </label>
						</div>
						<div class="radio">
						  <label>
						    <input type="radio" name="gender" id="gender_update_input2" value="F">
						 	   女
						  </label>
						</div>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <label for="inputPassword3" class="col-sm-2 control-label">deptName</label>
				    <div class="col-sm-4">
				      <select class="form-control" name="dId" id="dept_update_select">
						 
						</select>
				    </div>
				  </div>
				</form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		        <button type="button" class="btn btn-primary" id="emps_update_btn">更新</button>
		      </div>
		    </div>
		  </div>
		</div>
	<!-- 添加emps数据的模态框 -->
	<!-- Modal -->
	<div class="modal fade" id="emps_add_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">添加员工信息</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal">
			  <div class="form-group">
			    <label for="inputEmail3" class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" name="empName" id="empname_add_input" placeholder="empsName">
			  		<span  class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="inputPassword3" class="col-sm-2 control-label">email</label>
			    <div class="col-sm-10">
			      <input type="email" class="form-control" name="email" id="email_add_input" placeholder="email@ppx.com">
			    	<span  class="help-block"></span>
			    </div>
			  </div>
			   <div class="form-group">
			    <label for="inputPassword3" class="col-sm-2 control-label">gander</label>
			    <div class="col-sm-10">
			      	<div class="radio">
					  <label>
					    <input type="radio" name="gender" id="gender_add_input1" value="M" checked="checked">
						   男
					  </label>
					</div>
					<div class="radio">
					  <label>
					    <input type="radio" name="gender" id="gender_add_input2" value="F">
					 	   女
					  </label>
					</div>
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="inputPassword3" class="col-sm-2 control-label">deptName</label>
			    <div class="col-sm-4">
			      <select class="form-control" name="dId" id="dept_add_select">
					 
					</select>
			    </div>
			  </div>
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emps_serve">保存</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- 开始 -->
	<div class="container">
		<!-- 头部 -->
		<div class="row">
			<h1>SSM-CRUD</h1>
		</div>
		<hr>
		<!-- 中导航条 -->
		<div class="row">
			 <div class="col-md-4 col-md-offset-4"></div>
				 <div class="col-md-4">
				 	<button type="button" class="btn btn-primary"  id="emps_add_btn">
				 		<span class="glyphicon glyphicon-align-left" aria-hidden="true" ></span>
				 		新增
				 	</button>
				 	<button type="button" class="btn btn-danger" id="delete_all_btn">
					 	<span class="glyphicon glyphicon-align-left" aria-hidden="true" ></span>
					 	删除
				 	</button>
				 </div>
			</div>
		
		<!-- 表格数据 -->
		<div class="row">
			<table class="table table-hover" id="emps_table">
				<thead>
					<tr>
						<th><input type="checkbox" id="check_all"/></th>
						<th>ID</th>
						<th>empname</th>
						<th>gender</th>
						<th>email</th>
						<th>deptname</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody >
				
				</tbody>
			</table>
		</div>
		<!-- 尾部分页数据 -->
		<div class="row">
			<!-- 左侧分页信息 -->
			<div class="col-md-6" id="page_info" ></div>
			<!-- 右侧分页条 -->
			<div class="col-md-6" id="page_nav"></div>	
		</div>
	</div>
	<script type="text/javascript">
	//全局变量
	var pages_end,currentPageNum;
	//开始位置
		$(function(){
			//进首页
			To_Page(1);
		});
		function To_Page(pageNum){
			$.ajax({
				type: "GET",
			   url: "${APP_PATH}/emps",
			   data: "pageNum="+pageNum,
			   success: function(result){
			     //控制台测试结果数据
			     //console.log(msg);
			     //解析员工数据
			     build_emps_table(result);
			     //解析分页信息
			     build_emps_page(result);
			     //解析分页条
			     build_emps_nav(result);
			     
			   } 
			});
		}
		function build_emps_table(result){
			$("#emps_table tbody").empty();
			var emps=result.extend.pageinfo.list;
			$.each(emps,function(index,item){
				//alert(item.empName);
				var checkbox=$("<td><input type='checkbox' class='check_item'/></td>")
				var empsIdTd=$("<td></td>").append(item.empId);
				var empsNameTd=$("<td></td>").append(item.empName);
				var genderTd=$("<td></td>").append(item.gender=="M"?"男":"女");
				var emailTd=$("<td></td>").append(item.email);
				var deptNameTd=$("<td></td>").append(item.department.deptName);
				/*	<button type="button" class="btn btn-danger">
					 	<span class="glyphicon glyphicon-align-left" aria-hidden="true"></span>
					 	删除
				 	</button>*/
				var update_btn=$("<button></button>").addClass("btn btn-primary update_btn")
					 .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("修改");
			 //为了在点击修改按钮的时候获取到当前用户的id值，直接给每个修改的btn添加上empId,添加自定义属性。
				update_btn.attr("update_id",item.empId);
				var del_btn=$("<button></button>").addClass("btn btn-danger delete_btn")
					.append($("<span></span>").addClass("glyphicon glyphicon-trash del_btn")).append("删除");
				//给删除按钮附加empId的值
				del_btn.attr("delete_id",item.empId);
				var btn =$("<td></td>").append(update_btn).append(" ").append(del_btn);
				$("<tr></tr>").append(checkbox)
				.append(empsIdTd).append(empsNameTd)
					.append(genderTd).append(emailTd).append(deptNameTd)
					.append(btn).appendTo("#emps_table tbody");
			});
			
		}
		function build_emps_page(result){
			$("#page_info").empty();
			$("#page_info").append("当前"+result.extend.pageinfo.pageNum+"页，总共"
			+result.extend.pageinfo.pages+"页，总数据"+result.extend.pageinfo.total+"条");
			pages_end=result.extend.pageinfo.total;
			currentPageNum=result.extend.pageinfo.pageNum;
			
		}
		function build_emps_nav(result){
			$("#page_nav").empty();
			var ul=$("<ul></ul>").addClass("pagination");
			var firstPage=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			if(result.extend.pageinfo.isFirstPage == true){
				firstPage.addClass("disabled");
			}else{
				firstPage.click(function(){
				To_Page(1);
				});
			}
			var prePage=$("<li></li>").append($("<a></a>").append($("<span></span>").append("&laquo;")).attr("href","#"));
			if(result.extend.pageinfo.hasPreviousPage == false){
				prePage.addClass("disabled");
			}else{
				prePage.click(function(){
				To_Page(result.extend.pageinfo.pageNum-1);
				});
			}
			
			var nextPage=$("<li></li>").append($("<a></a>").append($("<span></span>").append("&raquo;")).attr("href","#"));
			if(result.extend.pageinfo.hasNextPage == false){
				nextPage.addClass("disabled");
			}else{
				nextPage.click(function(){
				To_Page(result.extend.pageinfo.pageNum+1);
				});
			}
			var lastPage=$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
			if(result.extend.pageinfo.isLastPage == true){
				lastPage.addClass("disabled");
			} else{
				lastPage.click(function(){
				To_Page(result.extend.pageinfo.pages);
				});
			}
			
			ul.append(firstPage).append(prePage);
			$.each(result.extend.pageinfo.navigatepageNums,function(index,item){
				var navigatepageNum=$("<li></li>").append($("<a></a>").append(item));
					if(result.extend.pageinfo.pageNum == item){
					navigatepageNum.addClass("active");
				}
				navigatepageNum.click(function(){
					To_Page(item);
					});
				ul.append(navigatepageNum);
				
			});
			
			ul.append(nextPage).append(lastPage);
			$("<nav></nav>").append(ul).appendTo("#page_nav");
			
		}
		
		//清空表单的样式及内容
		function reset_form(ele){
		//1\表单重置
		$(ele)[0].reset();
		//1、清空表单的样式（包括input的样式和span中的文本内容）
		$(ele).find("*").removeClass("has-success has-error");
		$(ele).find(".help-block").text("");
		
		}
		//手动打开模态框	
		$("#emps_add_btn").click(function(){
			//表单重置（通过DOM中的reset方法进行表单的重置，jQuery中没有reset的方法）
			reset_form("#emps_add_modal form")
			getdept("#dept_add_select");
			$("#emps_add_modal").modal({
				backdrop:"static"
			});
			
		});

		function getdept(ele){
			//发送ajax请求之前清空select控件中的内容，防止数据重复叠加
			$(ele).empty();
			$.ajax({
				type: "GET",
			   url: "${APP_PATH}/depts",
			   success: function(result){
			   		//console.log(result);
			   		$.each(result.extend.depts,function(index,item){
			   			var opt_dept=$("<option></option>").append(item.deptName).attr("value",item.deptId);
			   			//$("#dept_add_select").append(opt_dept);
			   			opt_dept.appendTo(ele);
			   		});
			   }
			});
		}
		
		//验证是否有重复的数据（用户名是否可用）
		
		$("#empname_add_input").change(function(){
			var empName=this.value;
			$.ajax({
				url:"${APP_PATH}/checkuser",
				type:"POST",
				data:"empName="+empName,
				success:function(msg){
					if(msg.code ==100){
						show_model("#empname_add_input","success","用户名可用");
						$("#emps_serve").attr("ajax-validate","success");
					}else{
					show_model("#empname_add_input","fail",msg.extend.va_msg);
					$("#emps_serve").attr("ajax-validate","fail");
					}
				}
			});
		});
			
			
		
		
		//新增数据保存提交至数据库
		$("#emps_serve").click(function(){
			
			//1、提交数据到服务器之前先进行数据的校验
			if(!validate_emps_form()){
				return false;
			}
			//2、对ajax校验的数据的成功性进行判断
			if($(this).attr("ajax-validate")=="fail"){
				return false;
			}
			//alert($("#emps_add_modal form").serialize());
			$.ajax({
				url:"${APP_PATH}/emp",
				type:"POST",
				data:$("#emps_add_modal form").serialize(),
				success:function(msg){
					//alert(msg.msg);
					if(msg.code == 100){
						//数据保存之后直接将模态框自动的关闭
						$("#emps_add_modal").modal("hide");
						//自动的跳转到最后一页查看数据是否插入
						To_Page(pages_end);
					}else{
					
					//console.log(msg);
					//alert(msg.extend.fieldError.empName);
					//alert(msg.extend.fieldError.email);
					//有哪个字段的信息就显示那一段返回的错误信息
					if(undefined !=msg.extend.fieldError.empName){
						show_model("#empname_add_input", "fail", msg.extend.fieldError.empName);
					}
					if(undefined != msg.extend.fieldError.email){
						show_model("#email_add_input", "fail", msg.extend.fieldError.email);
					}
					
					}
				}
			});
		
		});
		
		//表单验证,数据的校验
		function validate_emps_form(){
			
			var emps_name=$("#empname_add_input").val();
			var emps_email=$("#email_add_input").val();
			var name_pattern =/(^[a-zA-Z0-9_-]{5,16}$)|(^[\u2E80-\u9FFF]{3,6}$)/;
			var email_pattern =/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			
			if(!name_pattern.test(emps_name)){
				show_model("#empname_add_input", "fail", "5-16位字母和数字的组合或者3-6位中文");
				return false;
			}else{show_model("#empname_add_input", "success", "");}
			
			if(!email_pattern.test(emps_email)){
				show_model("#email_add_input", "fail", "邮箱格式不正确");
				return false;
			}else{show_model("#email_add_input", "success", "");}
			return true;
			
		}
		//抽取校验中的模块,ele:哪个控件 的Id值，struct：判断校验的结果是success还是fail，Msg：需要提示的信息
		function show_model(ele,struct,msg){
			//清除当前元素的校验状态
			$(ele).parent().removeClass("has-success has-error");
			if("success"==struct){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}
			if("fail" ==struct ){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
	//1、按钮是页面中直接创建的我们可以直接去绑定click的单击事件
	//2、现在是使用的修改的按钮时后续创建出来的，要想绑定点击事件就需要在添加btn的时候直接绑定单击事件
	//3、后续创建的btn我们可以使用live（）的方法去绑定单击事件
	//4、在jQuery中没有live的方法，所以选择使用的on方法去绑定单击事件
	//5、给后续添加的btn添加class的标识
	$(document).on("click",".update_btn",function(){
			//reset_form("#emps_add_modal form")
			getdept("#dept_update_select");
			//通过修改按钮获取empId的值
			var empid = $(this).attr("update_id");
			//给模态框中的更新按钮同样的赋值上empId的值
			$("#emps_update_btn").attr("update_btn_id",empid);
			getName(empid);
			$("#emps_update_modal").modal({
				backdrop:"static"
			});
		
	});
	//
		function getName(id){
			//1、获取empname的值
			$.ajax({
				url:"${APP_PATH}/emp/"+id,
				type:"GET",
				success:function(msg){
					console.log(msg);
					$("#empname_update_static").text(msg.extend.emp.empName);
					$("#email_update_input").val(msg.extend.emp.email);
					$("#emps_update_modal input[name=gender]").val([msg.extend.emp.gender]);
					$("#emps_update_modal select").val([msg.extend.emp.dId]);
				}
			});
		}
	$("#emps_update_btn").click(function(){
		//1、更新保存之前首先做邮箱验证
			var email_pattern =/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			var emp_email = $("#email_update_input").val();
			if(!email_pattern.test(emp_email)){
				show_model("#email_update_input", "fail", "邮箱格式不正确");
				return false;
			}else{show_model("#email_update_input", "success", "");}
			//2、发送ajax请求进行修改数据
			$.ajax({
				url:"${APP_PATH}/emp/"+$(this).attr("update_btn_id"),
				type:"POST",
				data:$("#emps_update_modal form").serialize()+"&_method=PUT",
				success:function(msg){
					if(msg.code == 100){
						//数据保存之后直接将模态框自动的关闭
						$("#emps_update_modal").modal("hide");
						//重新回到本页面
						To_Page(currentPageNum);
					}
				}
			});
		
		});
		//单个删除
		$(document).on("click",".delete_btn",function(){
			//发请求之前确认是否进行删除 
			//var empName=$(this).parents("tr").find("td").eq(1).text();
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			if(confirm("是否确定删除["+empName+"]?")){
			//alert($(this).attr("delete_id"));
				$.ajax({
					url:"${APP_PATH}/emp/"+$(this).attr("delete_id"),
					type:"DELETE",
					success:function(msg){
							alert(msg.msg);
							To_Page(currentPageNum);
						}
				});
			}
			
		});
		//批量删除：全选和全部选功能
		//attr获取自定义的属性值
		//prop修改和读取原生DOM的属性值
		$("#check_all").click(function(){
			
			//当选中check_all的时候，让.check_item的checked的属性值与之保持同样的状态：
			$(".check_item").prop("checked",$(this).prop("checked"));
			//console.log($(".check_item").prop("checked",$(this).prop("checked")).length);
		});
		//check_item
		$(document).on("click",".check_item",function(){
			var flag= $(".check_item:checked").length == $(".check_item").length;
			//console.log($(".check_item:checked").length);
			//console.log($(".check_item").length);
			$("#check_all").prop("checked",flag);
			
		});
		//全部删除和批量删除
		$("#delete_all_btn").click(function(){
			var empNames="";
			var empIds="";
		//遍历被选中的员工的empName
			$.each($(".check_item:checked"),function(){
				//alert($(this).parents("tr").find("td:eq(2)").text());
				 empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
				 empIds += $(this).parents("tr").find("td:eq(1)").text()+"-";
				
			});
			 empNames=empNames.substring(0, empNames.length-1);
			 empIds=empIds.substring(0, empIds.length-1);
			if(confirm("确认删除"+empNames+"吗？")){
					//发送ajax请求
					$.ajax({
						url:"${APP_PATH}/emp/"+empIds,
						type:"DELETE",
						success:function(msg){
							alert(msg.msg);
							To_Page(currentPageNum);
							$("#check_all").prop("checked",false);
						}
					});
				}
		});
		
	</script>
</body>
</html>