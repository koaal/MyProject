<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./inc/tags.jsp" %>   

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>无标题文档</title>
<%@ include file="./inc/css.jsp" %>
<%@ include file="./inc/javascripts.jsp" %>

<style>
body {
  font-family: "微软雅黑","宋体",Arial,Helvetica,Verdana,sans-serif;
  font-size: 15px;
}

p {
  line-height: 1.5em;
}

ul#menu, ul#menu ul {
  list-style-type:none;
  margin-left: 0;
  padding: 10px;
}

ul#menu li ul{
	background-color: #efefef;
    padding: 0px;
}
ul#menu a {
  display: block;
  text-decoration: none;	
}

ul#menu li {
  margin-top: 1px;
  
}

ul#menu li a {
  background:#dfdfdf ;
  color: #000000;	
  padding: 0.5em;
}

ul#menu li a:hover {
  background: #fdfab5;
}

ul#menu li ul li a {
  background: #ffffff;
  color: #000;
   /*padding-left: 10px;
  margin-left: 10px; */

}

ul#menu li ul li a:hover,ul#menu li ul .current a {
  
  
  /* padding-left: 10px; */

}

ul#menu li ul li a:FOCUS{
	/* border-color: black;
  border-style: solid;
  border-width: 2px; */
 /*  padding-left: 10px; */
  background-color:#d2ecff;

}

/* .code { border: 1px solid #ccc; list-style-type: decimal-leading-zero; padding: 5px; margin: 0; }
.code code { display: block; padding: 3px; margin-bottom: 0; }
.code li { background: #ddd; border: 1px solid #ccc; margin: 0 0 2px 2.2em; }
.indent1 { padding-left: 1em; }
.indent2 { padding-left: 2em; }
	 */
</style>
<script type="text/javascript">
function initMenu() {
	  $('#menu ul').hide();
	  $('#menu ul').children('.current').parent().show();
	  //$('#menu ul:first').show();
	  $('#menu li a').click(
	    function() {
	      var checkElement = $(this).next();
	      if((checkElement.is('ul')) && (checkElement.is(':visible'))) {
	        return false;
	        }
	      if((checkElement.is('ul')) && (!checkElement.is(':visible'))) {
	        $('#menu ul:visible').slideUp('normal');
	        checkElement.slideDown('normal');
	        return false;
	        }
	      }
	    );
	  }
$(document).ready(function() {initMenu();});
</script>
	
<body>
<div id="left" style="width:90%;">
<div class="contentBox" style="width:96%;border:none">
    <table border="0" cellspacing="0" cellpadding="0" style="width:100%;">
        <tr>
          <td>
          	
          	<ul id="menu">
	
		<li>
			<a href="#">系统管理员</a>
			<ul>
				<li><a href="help-right.jsp#admin_user" target="mainframe">&bull;用户与权限</a></li>
				<li><a href="help-right.jsp#admin_region" target="mainframe">&bull;区域管理</a></li>
				<li><a href="help-right.jsp#data_backup" target="mainframe">&bull;数据备份恢复</a></li>
				<li><a href="help-right.jsp#server_monitor" target="mainframe">&bull;系统监控</a></li>
				<li><a href="help-right.jsp#server_config" target="mainframe">&bull;系统设置</a></li>
			</ul>
		</li>
		<li>
			<a href="#">设备管理员</a>
			<ul>
				<li><a href="help-right.jsp#equipment_admin" target="mainframe">&bull;设备管理</a></li>
				
			</ul>
		</li>
		<li>
			<a href="#">区域管理员</a>
			<ul>
				<li><a href="help-right.jsp#region_user" target="mainframe" >&bull;用户与权限</a></li>
				<li><a href="help-right.jsp#region_transformer" target="mainframe">&bull;变电站管理</a></li>
				
			</ul>
		</li>
		
		
		<li>
			<a href="#">变电站管理员</a>
			<ul>
				<li><a href="help-right.jsp#transformer_admin" target="mainframe">&bull;变电站管理</a></li>
				<li><a href="help-right.jsp#transformer_user" target="mainframe">&bull;用户与权限</a></li>
			</ul>
		</li>
	</ul>
          
          </td>
         
        </tr>
        
	</table>
	
</div>
</div>
</body>

</html>