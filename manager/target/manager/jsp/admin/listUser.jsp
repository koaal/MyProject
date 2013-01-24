<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/tags.jsp"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title><spring:message code="common.project.title" /></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->
    <link href="../css/bootstrap.css" rel="stylesheet">
    <link href="../css/style.css" rel="stylesheet">

    <!--  
    <link href="../assets/css/bootstrap-responsive.css" rel="stylesheet">
		-->
    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <!-- Le fav and touch icons 
    <link rel="shortcut icon" href="../assets/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="../assets/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="../assets/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="../assets/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="../assets/ico/apple-touch-icon-57-precomposed.png">
    -->
  </head>
		<c:set var="pagination" value="${LIST_USERS_PAGER}"/>
  <body>
	  <!-- Include Header Page -->
	  <jsp:include page="../inc/header.jsp">
	  	<jsp:param name="active" value="home" />
	  </jsp:include>

    <div class="container-fluid">
      <div class="row-fluid">
        <div class="span3">
				  <!-- Include Header Page -->
				  <jsp:include page="../inc/menu.jsp">
				  	<jsp:param name="active" value="user" />
				  </jsp:include>
        </div><!--/span-->
        <div class="span9">
			    <ul class="breadcrumb">
				    <li>
				    <a href="${ctx}/jsp/index.jsp">Home</a> <span class="divider">/</span>
				    </li>
				    <li class="active">User</li>
			    </ul>        
			    <form id="search" class="well form-search" action="${ctx}/admin/listUser.do">
				    <input type="text" name="name" id="name" class="input-medium search-query" placeholder="Type User Name…" value="${LIST_USERS_NAME_KEY}">
				    <input type="hidden" name="page" id="page" value="${pagination.currentPage == null ? 1 : pagination.currentPage}" />
				    <button type="submit" class="btn">Search</button>
			    	<a class="btn btn-primary pull-right" href="${ctx}/admin/createUser.do">Create User</a>
			    </form>        
		      <table class="table table-striped table-bordered">
		        <thead>
		          <tr>
		            <th>#</th>
		            <th>User Name</th>
		            <th>Role</th>
		            <th>Email</th>
		            <th>Mobile</th>
 		            <th>Actions</th>
		          </tr>
		        </thead>
		        <tbody>
							<c:if test="${! empty LIST_USERS_RESULTS_KEY}">
								<c:forEach var="user" items="${LIST_USERS_RESULTS_KEY}" varStatus="status">
				          <tr>
				            <td>${status.index+1}</td>
				            <td>${user.name}</td>
				            <td>${user.role}</td>
				            <td>${user.email}</td>
				            <td>${user.mobile}</td>
				            <td><a href="javascript:gotoDelete(${user.id})"><i class="icon-trash icon-red"></i></a></td>
				          </tr>
								</c:forEach>
							</c:if>
		        </tbody>
		      </table>

		      <c:if test="${! empty pagination.totalPages && pagination.totalPages > 0}">  
			    <div class="pagination" >
				    <ul>
				    	<c:if test="${pagination.currentPage > 1}">
					    <li><a href="javascript:gotoPage(${pagination.currentPage-1})">Prev</a></li>
					    </c:if>
							<c:forEach var="index" begin="1" end="${pagination.totalPages}" step="1" >
								<li ${pagination.currentPage == index ? 'class="active"' : ''} ><a href="javascript:gotoPage(${index})">${index}</a></li>
							</c:forEach>
					    <c:if test="${pagination.currentPage < pagination.totalPages}">
					    <li><a href="javascript:gotoPage(${pagination.currentPage+1})">Next</a></li>
					    </c:if>
				    </ul>
			    </div>
			    </c:if>	
        </div><!--/span-->
      </div><!--/row-->

      <hr>
      <footer>
        <p>&copy; Company 2012</p>
      </footer>

    </div><!--/.fluid-container-->

    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="../js/jquery-1.7.1.min.js"></script>
    <script src="../js/bootstrap.js"></script>
		<script type="text/javascript">
		function gotoPage(pageNumber){
			pageNumber = pageNumber == null ? 1:pageNumber;
			$('#page').val(pageNumber);
			$('#search').submit();
		}
		
		function gotoDelete(id){
			var isOK = confirm("Are you sure to delete?");
			if (isOK){
				var name = $('#name').val();
				var page = $('#page').val();
				window.location = "deleteUser.do?id="+id+"&name="+name+"&page="+page;
			}
		}
		</script>
  </body>
</html>
