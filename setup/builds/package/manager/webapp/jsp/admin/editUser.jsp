<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/tags.jsp" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<%@ include file="../inc/css.jsp" %>
<%@ include file="../inc/javascripts.jsp" %>

<script>
<c:set var="defaultValue" ><spring:message code="admin.showUsers.search.default"/></c:set>
<c:set var="readminTitle" ><spring:message code="admin.showUsers.selectRole.readmin"/></c:set>
<c:set var="edadminTitle" ><spring:message code="admin.showUsers.selectRole.edadmin"/></c:set>
<c:set var="filterValue" ><spring:message code="admin.editUsers.filterValue.default"/></c:set>
<c:set var="leftTitle" ><spring:message code="admin.editUsers.selectTable.leftTitle"/></c:set>
<c:set var="rightTitle" ><spring:message code="admin.editUsers.selectTable.rightTitle"/></c:set>

$(document).ready(function() {
	<c:if test="${! empty UPDATE_LEFT_MENU_KEY}">
		var name = $("#left_frame",parent.document.body).contents().find("#name").val();
		name = name == '${defaultValue}'? "":name;
		var type = $("#left_frame",parent.document.body).contents().find("#type").val();
		var page = $("#left_frame",parent.document.body).contents().find("#page").val();
		
		var id = $("input#id").val();
		var src = "${ctx}/admin/searchUsers.do?id="+id+"&name="+name+"&type="+type+"&page="+page;
		$(window.parent.document).find("#left_frame").attr("src",src);
		//$(window.parent.document).find("#left_frame").contentWindow.location.reload(true); 
		//$(window.parent.document).find("#left_frame").contentDocument.location.reload(true);
		//parent.leftmenu.location.reload();
	</c:if>
	<c:if test="${editUser.role != 'edadmin'}">
		$("#tabCot_product_2").selectTable({
			url : "/readmin/listPermissionRegions.do",
			data : {userid: '${editUser.id}'},
			leftTitle : "${leftTitle}",
			rightTitle : "${rightTitle}",
			filter : true,
			defaultFilterValue : "${filterValue}"
		}); 
	</c:if>
	
	if($("#name\\.errors").text() != ''){
		$("#nameTip").hide();
	}
});

</script>

</head>
<body>
<div id="right">
<div id="loading-dialog" class="loading-dialog">
  	<p class="loading-content"><img src="/images/loading.gif"/></p>
</div>
<form:form id="editForm" action="updateUser.do" method="post" commandName="editUser">
  <form:hidden path="id" value="${editUser.id}"/>
  <div class="right_header">
  <div class="titel"><span style="margin-top:-3px; margin-right:5px;"><img src="../images/ts_admin.png" width="32" height="32" /></span>
	  <span>
	  	<c:out value="${editUser.role == 'readmin' ? readminTitle : edadminTitle}"/> <c:out value="${editUser.name}"/>
	  </span>
  </div>
  <div style="float:right;">
  <a href="javascript:go('createUser.do');" class="ui-button"><span class="add_button"></span><strong><spring:message code="admin.editUser.button.new"/></strong></a>
  <span class="seperator">&nbsp;&nbsp;</span>
  <a href="javascript:deleteConfirm('deleteUser.do?id=${editUser.id}');" class="ui-button del_button_bg" style="color:#FFF;"><span class="del_button" ></span><strong><spring:message code="admin.editUser.button.delete"/></strong></a>
  <a href="javascript:$('#editForm').submit();" class="ui-button save_button_bg" style="color:#FFF;"><span class="save_button "></span><span><strong><spring:message code="admin.editUser.button.edit"/></strong></span></a>
  </div>
  </div>
    
  <div id="tabCot_product" class="tab">
    <div class="tabContainer">
      <ul class="tabHead" id="tabCot_product-li-currentBtn-">
        <li class="currentBtn"><a href="javascript:void(0)" title="" rel="1"><spring:message code="admin.editUser.tab.text.basic"/></a></li>
        <c:if test="${editUser.role != 'edadmin'}">
        	<li><a href="javascript:void(0)" title="" rel="2"><spring:message code="admin.editUser.tab.text.permission"/></a></li>
        </c:if>
      </ul>
    </div>
    
    <div id="tabCot_product_1" class="tabCot">
      
        <table border="0" cellspacing="2" cellpadding="0">
          <tr>
            <td width="130" class="titel_td">*<spring:message code="admin.editUser.input.name"/>：</td>
            <td><form:input path="name" maxlength="20"/></td>
            <td align="left" class="tip" id="nameTip"><spring:message code="admin.editUser.tip.name"/></td>
           	<td><form:errors path="name" cssStyle="color:red" /></td>
          </tr>
          <tr>
            <td class="titel_td">*<spring:message code="admin.editUser.input.type"/>：</td>
            <td>
	            <form:select path="role" cssClass="select">
				<form:option value="readmin" label="${readminTitle}" />
				<form:option value="edadmin" label="${edadminTitle}" />
				</form:select>
			</td>
            <td>&nbsp;</td>            
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td class="titel_td">*<spring:message code="admin.editUser.input.email"/>：</td>
            <td><form:input path="email" /></td>
            <td><form:errors path="email" cssStyle="color:red" /></td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td class="titel_td"><spring:message code="admin.editUser.input.mobileno"/>：</td>
            <td><form:input path="mobile" /></td>
            <td><form:errors path="mobile" cssStyle="color:red" /></td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td class="titel_td"><spring:message code="admin.editUser.input.addr"/>：</td>
            <td><form:input path="address"  maxlength="250"/></td>
            <td><form:errors path="address" cssStyle="color:red" /></td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td class="titel_td"><spring:message code="admin.editUser.input.department"/>：</td>
            <td><form:input path="department"  maxlength="50"/></td>
            <td><form:errors path="department" cssStyle="color:red" /></td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td class="titel_td"><spring:message code="admin.editUser.input.desc"/>：</td>
            <td><form:textarea path="description" cssClass="textfield" rows="5"  maxlength="250"/></td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td class="titel_td">&nbsp;</td>
            <td colspan="3"><a href="javascript:changePassword();" id="button-open-dialog"><strong><spring:message code="admin.editUser.dialog.resetTitle"/></strong></a></td>
          </tr>
        </table>

  		<!-- change password dialog -->
  		<div id="password_changed_result" class="messagebox"></div>
		<%@ include file="../inc/resetPassword.jsp" %>  
         
   	</div>
      
      <div id="tabCot_product_2" class="tabCot" style="display: none;">

      </div>
 
</form:form>
</div>
      

       

<div class="noprint">	
  <script type="text/javascript" language="jscript">
function tab(o, s, cb, ev){
	var $ = function(o){return document.getElementById(o)};
	var css = o.split((s||'_'));
	if(css.length!=4)return;
	this.event = ev || 'onclick';
	o = $(o);
	if(o){
		this.ITEM = [];
		o.id = css[0];
		var item = o.getElementsByTagName(css[1]);
		var j=1;
		for(var i=0;i<item.length;i++){
			if(item[i].className.indexOf(css[2])>=0 || item[i].className.indexOf(css[3])>=0){
				if(item[i].className == css[2])o['cur'] = item[i];
				item[i].callBack = cb||function(){};
				item[i]['css'] = css;
				item[i]['link'] = o;
				this.ITEM[j] = item[i];
				item[i]['Index'] = j++;
				item[i][this.event] = this.ACTIVE;
			}
		}
		return o;
	}
}
tab.prototype = {
	ACTIVE:function(){
		var $ = function(o){return document.getElementById(o)};
		this['link']['cur'].className = this['css'][3];
		this.className = this['css'][2];
		try{
			$(this['link']['id']+'_'+this['link']['cur']['Index']).style.display = 'none';
			$(this['link']['id']+'_'+this['Index']).style.display = 'block';
		}catch(e){}
		this.callBack.call(this);
		this['link']['cur'] = this;
	}
}
new tab('tabCot_product-li-currentBtn-', '-');
</script>
</div>


</body>
</html>
