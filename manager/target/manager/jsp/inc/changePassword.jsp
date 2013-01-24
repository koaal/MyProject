<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
  <div id="dialog_password" title='<spring:message code="admin.editUser.dialog.changeTitle"/>' style="display: none">
	<table>
       <tr style= "height:36px; ">
         <td class="titel_td">*<spring:message code="admin.editUser.input.oldPwd"/>：</td>
         <td><input type="password" id="oldPassword" name="oldPassword" class="textfield  padding-left:0;padding-right:0;" maxlength="20" /></td>
	     <td align="left">
	     	<div id="error-oldPassword" class="error" style="color:red; display: none"></div>
			<div id="tip-oldPassword" class="tip" style="display: none"></div>
	     </td>  
       </tr>
       <tr style= "height:36px; ">
         <td class="titel_td">*<spring:message code="admin.editUser.input.pwd"/>：</td>
         <td><input type="password" id="password" name="password" class="textfield  padding-left:0;padding-right:0;" maxlength="20"/></td>
	     <td align="left">
	     	<div id="error-password" class="error" style="color:red; display: none"></div>
			<div id="tip-password" class="tip"><spring:message code="admin.editUser.error.password"/></div>
	     </td>         
       </tr>
       <tr style= "height:36px; ">
         <td class="titel_td">*<spring:message code="admin.editUser.input.comfirmPwd"/>：</td>
         <td><input type="password" id="confirmPassword" name="confirmPassword" class="textfield  padding-left:0;padding-right:0;" maxlength="20"/></td>
	     <td align="left">
	     	<div id="error-confirmPassword" class="error" style="color:red; display: none"></div>
			<div id="tip-confirmPassword" class="tip" style="display: none"></div>
	     </td>  
       </tr>
  	</table>
  	<div style="float: left; margin: 25px 75px;">
     <a href="#" id="button-save-dialog" class="ui-button save_button_bg"><span class="save_button"></span><strong><spring:message code="admin.editUser.dialog.save"/></strong></a>
     <a href="#" id="button-close-dialog" class="ui-button"><strong><spring:message code="admin.editUser.dialog.close"/></strong></a>
  	</div>  	
  </div>
<script>

$("div#dialog_password").dialog({
    autoOpen: false,
    height: 300,
    width: 550,
    modal: true,
    close: function() {
		$("input#oldPassword").val("");
		$("input#password").val("");
		$("input#confirmPassword").val("");	
		//$("#password_changed_result").hide();
		$("#error-password").hide();
		$("#error-oldPassword").hide();
		$("#error-confirmPassword").hide();
		$("#tip-password").show();

    },
    open: function() {
    
    }
});

function changePassword(){
	$("div#dialog_password").dialog( "open" );
}


$("#button-save-dialog").click(function() {
	var oldPassword = $("input#oldPassword").val(),
		password = $("input#password").val(),
		confirmPassword = $("input#confirmPassword").val(),
		result = "";
	if (password == null || password.length < 6){
		result = '<spring:message code="admin.editUser.error.password"/>';
		$("#error-confirmPassword").hide();
		$("#tip-password").hide();
		$("#error-password").html(result).show();
		return;		
	}else if (password != confirmPassword){
		result = '<spring:message code="admin.editUser.dialog.confirmPasswordError"/>';
		$("#error-password").hide();
		$("#error-confirmPassword").html(result).show();
		return;
	}
	
    $.ajax({
   		type: 'POST',
   		url: '/admin/changePassword.do',
   		data: {"id" : $("input#id").val(), "oldPassword" : oldPassword, "password" : password},
   		dataType: 'html',
   		beforeSend: openLoadingDialog,
   		complete:closeLoadingDialog,
   		error: function(){
	    	globalAjaxError("password_changed_result");
	    },
		success: function (data){
   			var dataObj=eval("("+data+")");

   			if ("oldPasswordError" == dataObj.result){
	      		result = '<spring:message code="admin.editUser.dialog.oldPasswordError"/>';
	      		$("#error-password").hide();
	      		$("#error-confirmPassword").hide();        		
	      		$("#error-oldPassword").html(result).show(); 
      		}else{
				if ("success" == dataObj.result){
					result = '<spring:message code="admin.editUser.dialog.success"/>';
	        	}else {
	        	  	result = '<spring:message code="error.unknow"/>';
	          	}
				$("#error-password").hide();
				$("#error-oldPassword").hide();
				$("#error-confirmPassword").hide();			
				showMesssageByTime("password_changed_result", result, 8000);	
			    $("div#dialog_password").dialog( "close" );	
      		}
  		}
    });
});


$("#button-close-dialog").click(function() {
    $("div#dialog_password").dialog( "close" );
});


</script>