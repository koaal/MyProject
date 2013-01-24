<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./inc/tags.jsp"%>


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
    <style type="text/css">
      body {
        padding-top: 30px;
        padding-bottom: 70px;
      }

    </style>
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

    <div class="container-fluid">
   
			<div class="row-fluid">

				<!--/span-->
				<div class="span2">
		      <form class="form-horizontal" action="${ctx}/login.do" method="post">
		        <fieldset>
		        
        		  <div class="page-header control-group" style="text-align: center;">
		    				<h2>Sign In <small>Or register <a href="">here</a></small></h2>
		  				</div> 
		          <div class="control-group">
		            <label class="control-label" for="username"><i class="icon-star"></i>User Name</label>
		            <div class="controls">
		              <input class="focused" id="username" name="username" type="text" value="">
		            </div>
		          </div>
		          <div class="control-group">
		            <label class="control-label" for="password"><i class="icon-star"></i>Password</label>
		            <div class="controls">
		              <input id="password" name="password" type="password" value="">
		            </div>
		          </div>		          
		          <div class="control-group">
		            <label class="control-label" for="rememberMe">Remember Me</label>
		            <div class="controls">
		                <input type="checkbox" id="rememberMe" name="rememberMe" value="true" >
		            </div>
		          </div>

		          <div class="form-actions">
		            <button type="submit" class="btn btn-primary">Sign In</button>
		            <button class="btn">Cancel</button>
		          </div>
		        </fieldset>
		      </form>
				</div>
				<!--/span-->


				<!--/span-->
			</div>
		<!--/row-->



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
