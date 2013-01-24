<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./inc/tags.jsp" %>   

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>帮助</title>
<%@ include file="./inc/css.jsp" %>
<%@ include file="./inc/javascripts.jsp" %>
<style type="text/css">
	body{
		background: #f8f8f8;
	}
</style>
<body >
<div class="header_content">
<div class="logo"><span class="header_Name">M2M 智能电网管理系统</span></div>

</div>
<div id="left_menu" style="width:280px; float:left; height:100%;">
	<iframe  src="help-left.jsp" width="100%" height="100%" frameborder="0" scrolling="no"  ></iframe>
</div>
<div id="main_content" style="left:290px;float:left;">
	<iframe name="mainframe" src="help-right.jsp" width="100%" height="100%" frameborder="0" scrolling="auto" ></iframe>
	
</div>

</body>

<!-- <script type="text/javascript">

var hL =document.getElementById("left_menu");
var hR = document.getElementById("right_menu");
//hl.style.width = window.screen.availWidth-20; //得到宽度 
var s_height=document.body.scrollHeight; 
if(s_height<window.screen.availHeight) 
{ 
s_height=window.screen.availHeight; 
}  

hL.style.height=s_height+"px";
hR.style.height= s_height+"px";
</script> -->
</html>
