<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查询数据</title>
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
				 	<button type="button" class="btn btn-primary">
				 		<span class="glyphicon glyphicon-align-left" aria-hidden="true"></span>
				 		新增
				 	</button>
				 	<button type="button" class="btn btn-danger">
					 	<span class="glyphicon glyphicon-align-left" aria-hidden="true"></span>
					 	删除
				 	</button>
				 </div>
			</div>
		
		<!-- 表格数据 -->
		<div class="row">
			<table class="table table-hover">
				<tr>
					<th>ID</th>
					<th>empname</th>
					<th>gender</th>
					<th>email</th>
					<th>deptname</th>
					<th>操作</th>
				</tr>
				
				<c:forEach items="${pageinfo.list }" var="emps">
				<tr>
					<td>${emps.empId }</td>
					<td>${emps.empName }</td>
					<td>${emps.gender=="M"?"男":"女" }</td>
					<td>${emps.email }</td>
					<td>${emps.department.deptName }</td>
					<td>
						<button type="button" class="btn btn-primary">
							<span class="glyphicon glyphicon glyphicon-pencil" aria-hidden="true"></span>
							修改
						</button>
				 		<button type="button" class="btn btn-danger">
					 		<span class="glyphicon glyphicon glyphicon-trash" aria-hidden="true"></span>
					 		删除
				 		</button>
					</td>
					</tr>
				</c:forEach>	
			</table>
		</div>
		<!-- 尾部 -->
		<div class="row">
			<div class="col-md-6">
				当前${pageinfo.pageNum }页，总共${pageinfo.pages }页，总数据${pageinfo.total }条
			</div>
			<div class="col-md-6">
				<nav aria-label="Page navigation">
				  <ul class="pagination">
				  	<li><a href="${APP_PATH}/emps?pageNum=1">首页</a></li>
				  	<c:if test="${pageinfo.pageNum>1 }">
				  		<li>
					      <a href="${APP_PATH}/emps?pageNum=${pageinfo.pageNum-1}" aria-label="Previous">
					        <span aria-hidden="true">&laquo;</span>
					      </a>
					    </li>
				  	</c:if>
				    <c:forEach items="${pageinfo.navigatepageNums }" var="page_num">
				    	<c:if test="${page_num==pageinfo.pageNum }">
				    		<li class="active"><a href="">${page_num }</a></li>
				    	</c:if>
				    	<c:if test="${page_num!=pageinfo.pageNum }">
				    		<li><a href="${APP_PATH}/emps?pageNum=${page_num}">${page_num }</a></li>
				    	</c:if>
				    </c:forEach>
				  <c:if test="${pageinfo.pageNum<pageinfo.pages }">
				  	 <li>
				      <a href="${APP_PATH }/emps?pageNum=${pageinfo.pageNum+1}" aria-label="Next">
				        <span aria-hidden="true">&raquo;</span>
				      </a>
				    </li>
				  </c:if>
				    <li><a href="${APP_PATH }/emps?pageNum=${pageinfo.pages}">末页</a></li>
				  </ul>
				</nav>
			</div>	
		</div>
	</div>
</body>
</html>