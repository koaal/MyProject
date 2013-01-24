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

<script>
function loadFrame(left,right){
	
    parent.leftmenu.location.href= left;
    
    if(right != null)
    	parent.mainframe.location.href= right;
}

$(function(){
 $('ul li').click(function(){
  $(this).css('background-color', '#efefef').siblings().css('background-color', '');
 });

 $('.menu_link').click(function(){
    if($(this).hasClass('regionadmin')){
    	loadFrame('${ctx}/region/searchRegions.do', '${ctx}/region/editRegion.do'); 
    }
    if($(this).hasClass('tsadmin')){
    	loadFrame('${ctx}/tsadmin/listStations.do', '${ctx}/tsadmin/createStation.do'); 
    }
    if($(this).hasClass('user')){
    	loadFrame('${ctx}/admin/searchUsers.do', '${ctx}/admin/createUser.do');  
    }
    if($(this).hasClass('edadmin')){
    	loadFrame('${ctx}/edadmin/listStations.do', '${ctx}/edadmin/showDevices.do');  
    }
    if($(this).hasClass('regionadmin_manageTSAdmin')){
    	loadFrame('${ctx}/readmin/searchTSAdmins.do', '${ctx}/readmin/createTSAdmin.do');  
    }
    if($(this).hasClass('tsadmin_manageTSOperator')){
    	loadFrame('${ctx}/tsoperator/searchOperators.do', '${ctx}/tsoperator/createOperator.do');  
    }
    if($(this).hasClass('tsoperator')){
    	loadFrame('${ctx}/tsadmin/listStations.do', null); 
    }
    if($(this).hasClass('monitor')){
    	loadFrame('${ctx}/admin/serverList.do', null); 
    }
    if($(this).hasClass('config')){
    	loadFrame('${ctx}/admin/serverConfigList.do','${ctx}/admin/serverConfigAlarmInit.do');
    }
  });

 $('ul li:first').css('background-color', '#efefef').siblings().css('background-color', '');

 window.parent.$("#OperationLogHolder").dialog({
	    autoOpen: false,
	    height: 480,
	    width: 870,
	    modal: true,
        close: function(){
	         window.parent.$('#OperationLogHolder').html(''); 
	          window.parent.$('#OperationLogHolder').html(''); 
     }
});   
})
function open_help() 
{
	window.open("${ctx}/jsp/help.jsp","_blank",'width=1024,height=768,menubar=no,location=no,left='+((screen.width/2)-512)+',top='+((screen.height/2)-384));
}

function open_log()
{
	 $.ajax({
		  type: 'GET',
	       url: '/jsp/admin/showLog.jsp',
	       error: function(){
	    	   globalAjaxError("SystemMessage");
		    },
	   success: function (data){
		 
          	 window.parent.$('#OperationLogHolder').html(data); 
          	window.parent.$("#OperationLogHolder").dialog("open");
	            },
	  dataType: 'html' 
	     });
}

function validateLicense(){
	$.ajax({
		   type: 'GET',
	       url: '/admin/licenseNotify.do',
	       dataType: 'json',
	       success: function (data){
	    	   var message = "<ul style='line-height: 30px'>";
	    	   if(data != null){
	    		   if(data.expiry_date != null){
	    			   message += '<li><spring:message code="admin.license.notify.message.expiryDate" arguments="'+data.expiry_date+'"/></li>';
	    		   }
	    		   if(data.activated_gatewayes != null && data.activated_gatewayes>0){
	    			   message += '<li><spring:message code="admin.license.notify.message.maxResource" arguments="'+data.activated_gatewayes+'"/></li>';
	    		   }
	    		   if(data.activated_devices != null && data.activated_devices>0){
	    			   message += '<li><spring:message code="admin.license.notify.message.maxDevice" arguments="'+data.activated_devices+'"/></li>';
	    		   }
	    		   message += "</ul>";
	    		   showMesssageByTime("SystemMessage", message, 20000);
	    	   }
	       }
	     });
}

</script>

</head>

<style>

Body{
font-size:9pt;
overflow-y:auto;
overflow-x:auto;
}

.td2{ font-size:15px; width:115px; padding:4px 0;}

.menu_link{color:#000 !important; text-decoration:none !important; padding:3px 15px; outline:none;}
</style>

<body>
<div class="header_content">
<div class="logo"><span class="header_Name">M2M 智能电网管理系统</span></div>
<div class="header_menu">
<c:set var="role">
<shiro:hasRole name="edadmin">
edadmin
</shiro:hasRole>
<shiro:hasRole name="tsadmin">
tsadmin
</shiro:hasRole>
<shiro:hasRole name="admin">
admin
</shiro:hasRole>
<shiro:hasRole name="readmin">
readmin
</shiro:hasRole>
<shiro:hasRole name="tsoperator">
tsoperator
</shiro:hasRole>
</c:set>
<span class="${role}_user">
<shiro:user><shiro:principal/></shiro:user>
</span>
&nbsp;&nbsp;|&nbsp;&nbsp;
<a href="javascript:changePassword();" id="button-open-dialog" target="_top">修改密码</a>
&nbsp;&nbsp;|&nbsp;&nbsp;
<a href='javascript:open_help()' id="button-help">帮助</a>
&nbsp;&nbsp;|&nbsp;&nbsp; 
<shiro:hasRole name="admin">
<a href='javascript:open_log()' id="button-open-log">查看日志</a>
&nbsp;&nbsp;|&nbsp;&nbsp; 
</shiro:hasRole>

<a href="javascript:go('${ctx}/logout.do');" target="_top">退出</a>
</div>

<div class="main-menu">

<script>
var clickOBJ=null;
</script>
<style>
.header_menu_list ul{
	margin: 0 0 0 10px;
	padding:0;
	float:left;
	}
.header_menu_list li{
	float:left;
	padding: 4px 4px 2px;
	font-size: 15px;
	list-style:none;
    border-radius: 5px 5px 0 0;
	}
</style>
<div class="header_menu_list">
<ul>
<shiro:hasRole name="edadmin">
<li><a href="#" class="menu_link edadmin">设备管理</a></li>
</shiro:hasRole>
<shiro:hasRole name="tsadmin">
<li><a href="#" class="menu_link tsadmin">变电站管理</a></li>
<li><a href="#" class="menu_link tsadmin_manageTSOperator"><spring:message code="user.menu.title"/></a></li>
</shiro:hasRole>
<shiro:hasRole name="admin">
<li><a href="#" class="menu_link user"><spring:message code="user.menu.title"/></a></li>
<li><a href="#" class="menu_link regionadmin"><spring:message code="region.menu.title"/></a></li>
<li><a href="#" class="menu_link monitor">系统监控</a></li>
<li><a href="#" class="menu_link config">系统设置</a>
</shiro:hasRole>
<shiro:hasRole name="readmin">
<li><a href="#" class="menu_link tsadmin">变电站管理</a></li>
<li><a href="#" class="menu_link regionadmin_manageTSAdmin"><spring:message code="user.menu.title"/></a></li>
</shiro:hasRole>
<shiro:hasRole name="tsoperator">
<li><a href="#" class="menu_link tsoperator">变电站管理</a></li>
</shiro:hasRole>
</ul>
</div>
</div>
</div>
<div id="SystemMessage" class="messagebox"></div>
<shiro:hasRole name="admin">
<script>validateLicense();</script>
</shiro:hasRole>
</body>
</html>
