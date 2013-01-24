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
 				    <li>
				    <a href="${ctx}/admin/listUser.do">User</a> <span class="divider">/</span>
				    </li>
				    <li class="active">Create</li>
			    </ul>        
        	
        	<form:form id="saveForm" action="saveUser.do" method="post" commandName="newUser" class="form-horizontal">
		        <fieldset>
		        	<legend>User Info</legend>
		          <div class="control-group">
		            <label class="control-label" for="name"><i class="icon-star"></i>User Name</label>
		            <div class="controls">
		            	<form:input path="name" id="name" maxlength="20" cssClass="span4 focused" autofocus="true" />
		            	<form:errors path="name" cssClass="error"/>
		            </div>
		          </div>
		          <div class="control-group">
		            <label class="control-label" for="role"><i class="icon-star"></i>Role</label>
		            <div class="controls">
		              <form:select path="role" cssClass="span4">
		           			<form:option value="admin" label="Adminitrator" />
		              	<form:option value="stoadmin" label="Storage Adminitrator" />
		              	<form:option value="bizadmin" label="Business Adminitrator" />
		              </form:select>
		            </div>
		          </div>		          
		          <div class="control-group">
		            <label class="control-label" for="email"><i class="icon-star"></i>Email</label>
		            <div class="controls">
		            	<form:input path="email" id="email" cssClass="span4"/>
		            	<form:errors path="email" id="email" cssClass="error" />
		            </div>
		          </div>		          
		          <div class="control-group">
		            <label class="control-label" for="mobile">Mobile</label>
		            <div class="controls">
		            	<form:input path="mobile" id="mobile" cssClass="span4"/>
		            	<form:errors path="mobile" id="mobile" cssClass="error" />
		            </div>
		          </div>			          
		          <div class="control-group">
		            <label class="control-label" for="address">Address</label>
		            <div class="controls">
		            	<form:input path="address" id="address" cssClass="span4"/>
		            	<form:errors path="address" id="address" cssClass="error" />
		            </div>
		          </div>			          
		          <div class="control-group">
		            <label class="control-label" for="description">Description</label>
		            <div class="controls">
		            	<form:textarea path="description" id="description" rows="3"  maxlength="250" cssClass="span4"/>
		            </div>
		          </div>
		        </fieldset>
 		        <fieldset>
		        	<legend> Password </legend>     		           		                 
		          <div class="control-group">
		            <label class="control-label" for="password"><i class="icon-star"></i>Password</label>
		            <div class="controls">
		            	<form:input path="password" id="password" cssClass="span4"/>
		            	<form:errors path="password" id="password" cssClass="error" />
		            	<p class="help-block">Password should contain more than 6 characters.</p>
		            </div>
		          </div>	
		          <div class="control-group">
		            <label class="control-label" for="confirmPassword"><i class="icon-star"></i>ConfirmPassword</label>
		            <div class="controls">
		            	<form:input path="confirmPassword" id="confirmPassword" cssClass="span4"/>
		            	<form:errors path="confirmPassword" id="confirmPassword" cssClass="error" />
		            </div>
		          </div>	    
		          <div class="form-actions">
		            <button type="submit" class="btn btn-primary">Save User</button>
		            <button class="btn">Cancel</button>
		          </div>
		        </fieldset>
		      </form:form>


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
    
    <!--  
    <script src="../assets/js/bootstrap-alert.js"></script>
    <script src="../assets/js/bootstrap-modal.js"></script>
    <script src="../assets/js/bootstrap-dropdown.js"></script>
    <script src="../assets/js/bootstrap-scrollspy.js"></script>
    <script src="../assets/js/bootstrap-tab.js"></script>
    <script src="../assets/js/bootstrap-tooltip.js"></script>
    <script src="../assets/js/bootstrap-popover.js"></script>
    <script src="../assets/js/bootstrap-button.js"></script>
    <script src="../assets/js/bootstrap-collapse.js"></script>
    <script src="../assets/js/bootstrap-carousel.js"></script>
    <script src="../assets/js/bootstrap-typeahead.js"></script>
		-->
  </body>
</html>
