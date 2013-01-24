<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./inc/tags.jsp" %>    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>M2M 智能电网管理系统</title>
<%@ include file="./inc/css.jsp" %>
<%@ include file="./inc/javascripts.jsp" %>
</head>
<body>
<div class="header">
<iframe name="header" id="myframe" width="100%" height="100%" frameborder="0" scrolling="no" src="${ctx}/jsp/header.jsp"></iframe>
</div>
<div id="left_menu" style="width:280px; float:left; height:100%;">
<shiro:hasRole name="tsadmin">
<iframe name="leftmenu" id="left_frame" width="100%" height="100%" frameborder="0" scrolling="no" src="${ctx}/tsadmin/listStations.do"></iframe>
</shiro:hasRole>
<shiro:hasRole name="edadmin">
<iframe name="leftmenu" id="left_frame" width="100%" height="100%" frameborder="0" scrolling="no" src="${ctx}/edadmin/listStations.do"></iframe>
</shiro:hasRole>
<shiro:hasRole name="admin">
<iframe name="leftmenu" id="left_frame" width="100%" height="100%" frameborder="0" scrolling="no" src="${ctx}/admin/searchUsers.do"></iframe>
</shiro:hasRole>
<shiro:hasRole name="readmin">
<iframe name="leftmenu" id="left_frame" width="100%" height="100%" frameborder="0" scrolling="no" src="${ctx}/tsadmin/listStations.do"></iframe>
</shiro:hasRole>
<shiro:hasRole name="tsoperator">
<iframe name="leftmenu" id="left_frame" width="100%" height="100%" frameborder="0" scrolling="no" src="${ctx}/tsadmin/listStations.do"></iframe>
</shiro:hasRole>
</div>
<div id="main_content" style="left:290px;float:left;">
<shiro:hasRole name="tsadmin">
<iframe name="mainframe" id="myframe" width="100%" height="100%" frameborder="0" scrolling="no" src="${ctx}/tsadmin/createStation.do"></iframe>
</shiro:hasRole>
<shiro:hasRole name="edadmin">
<iframe name="mainframe" id="myframe" width="100%" height="100%" frameborder="0" scrolling="no" src="${ctx}/edadmin/showDevices.do"></iframe>
</shiro:hasRole>
<shiro:hasRole name="admin">
<iframe name="mainframe" id="myframe" width="100%" height="100%" frameborder="0" scrolling="no" src="${ctx}/admin/createUser.do"></iframe>
</shiro:hasRole>

<shiro:hasRole name="readmin">
<iframe name="mainframe" id="myframe" width="100%" height="100%" frameborder="0" scrolling="no" src="${ctx}/tsadmin/createStation.do"></iframe>

</shiro:hasRole>
<shiro:hasRole name="tsoperator">
<iframe name="mainframe" id="myframe" width="100%" height="100%" frameborder="0" scrolling="no" src="#"></iframe>
</shiro:hasRole>
  <!-- show log dialog -->

<!-- change password dialog -->
<input type="hidden" name="id" id="id" value="<shiro:principal property='id'/>">
<div id="password_changed_result" class="messagebox"></div>
<%@ include file="./inc/changePassword.jsp" %>  
<div id="OperationLogHolder" title='<spring:message code="admin.showLog.table"/>'></div>
</div>
<div id="loading-dialog" class="loading-dialog">
  	<p class="loading-content"><img src="/images/loading.gif"/></p>
</div>
</body>
</html>



