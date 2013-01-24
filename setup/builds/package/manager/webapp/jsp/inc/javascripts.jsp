
<script type="text/javascript" src="/js/jquery-1.7.1.min.js" ></script>
<script type="text/javascript" src="/js/jquery-ui-1.8.18.custom.min.js"></script>
<script type="text/javascript" src="/js/util.js"></script>
<script type="text/javascript" src="/js/jquery-selectTable.js"></script>
<script type="text/javascript" src="/js/grid.locale-zh.js"></script>
<script type="text/javascript" src="/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript" src="/js/jquery.loadmask.min.js"></script>
<script type="text/javascript" src="/js/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript">
  $(document).ready(function() {
  });

  var dacFailed = '<spring:message code="error.dac_failed"/>';
  var dataNotFound = '<spring:message code="error.data_not_found"/>';  
  var badGateway = '<spring:message code="error.bad_gateway"/>';  
  var badModule = '<spring:message code="error.bad_module"/>';
  var defaultError = '<spring:message code="tsadmin.topology.dialog.error"/>';
  var unknowError = '<spring:message code="error.unknow"/>';

  var statusInactive = '<spring:message code="common.status.inactive"/>';
  var statusNew = '<spring:message code="common.status.new"/>';
  
  var wrong_auth = '<spring:message code="error.wrong_auth"/>';
  var connection_refused = '<spring:message code="error.connection_refused"/>';
  var connection_protocal_exception = '<spring:message code="error.connection_protocal_exception"/>';
  var response_parse_failure = '<spring:message code="error.response_parse_failure"/>';
  var command_execution_failure = '<spring:message code="error.command_execution_failure"/>';
  var gateway_connection_wrong_host_exception = '<spring:message code="error.gateway_connection_wrong_host_exception"/>';
  var module_load_failure = '<spring:message code="error.module_load_failure"/>';
  var root_not_find = '<spring:message code="error.root_not_find"/>';
  var internal_error = '<spring:message code="error.internal_error"/>';
  var import_error = "<spring:message code='edadmin.listLine.listGateway.importSetting.error'/>";
  
	var lowLevel = '<spring:message code="tsadmin.editStation.listAlarm.header.alarmLevel.low"/>';
	var mediumLevel = '<spring:message code="tsadmin.editStation.listAlarm.header.alarmLevel.medium"/>';
	var highLevel = '<spring:message code="tsadmin.editStation.listAlarm.header.alarmLevel.high"/>';
	
	var hvolt = '<spring:message code="tsadmin.editStation.listAlarm.text.alarmtype.hvolt"/>';
	var lvolt = '<spring:message code="tsadmin.editStation.listAlarm.text.alarmtype.lvolt"/>';
	var htemp = '<spring:message code="tsadmin.editStation.listAlarm.text.alarmtype.htemp"/>';
	var ltemp = '<spring:message code="tsadmin.editStation.listAlarm.text.alarmtype.ltemp"/>';
	var hrssi = '<spring:message code="tsadmin.editStation.listAlarm.text.alarmtype.hrssi"/>';
	var lrssi = '<spring:message code="tsadmin.editStation.listAlarm.text.alarmtype.lrssi"/>';
	var hpowe = '<spring:message code="tsadmin.editStation.listAlarm.text.alarmtype.hpowe"/>';
	var lpowe = '<spring:message code="tsadmin.editStation.listAlarm.text.alarmtype.lpowe"/>';
	var other = '<spring:message code="tsadmin.editStation.listAlarm.text.alarmtype.other"/>';
  
  
  function getErrorMsgByCode(errorCode){
	  var error = "";
	  if(errorCode == 1001){
		  error = dacFailed;
	  }else if(errorCode == 1002){
		  error =  dacFailed;
	  }else if(errorCode == 1003){
		  error =  dataNotFound;
	  }else if(errorCode == 1011){
		  error =  badGateway;
	  }else if(errorCode == 1012){
		  error =  badModule;
	  }else if(errorCode == 401){
		  error =  wrong_auth;
	  }else if(errorCode == 504){
		  error =  connection_refused;
	  }else if(errorCode == 505){
		  error =  connection_protocal_exception;
	  }else if(errorCode == 506){
		  error =  response_parse_failure;
	  }else if(errorCode == 508){
		  error =  command_execution_failure;
	  }else if(errorCode == 507){
		  error =  module_load_failure;
	  }else if(errorCode == 510){
		  error =  gateway_connection_wrong_host_exception;
	  }else if(errorCode == 502){
		  error =  root_not_find;
	  }else if(errorCode == 500){
		  error =  internal_error;
	  }else if(errorCode == 1015){
		  error = import_error;
	  }else{
		  errorCode = unknowError;
		  error =  defaultError;
	  }
	  return errorCode +" : " + error;
  }
  
  $("document").ready(function() {
	   $('textarea[maxlength]').live('keyup change', function() {
	   		var str = $(this).val();
	   		var mx = parseInt($(this).attr('maxlength'));
	   		if (str.length > mx) {
	  			$(this).val(str.substr(0, mx));
			}
	   });
})
  
  function alarmtypeFormatter(cellvalue, options, rowObject){
	if(cellvalue == "hvolt") 
		return hvolt;
	if(cellvalue == "lvolt") 
		return lvolt;
	if(cellvalue == "htemp") 
		return htemp;
	if(cellvalue == "ltemp") 
		return ltemp;
	if(cellvalue == "hrssi") 
		return hrssi;
	if(cellvalue == "lrssi") 
		return lrssi;
	if(cellvalue == "hpowe") 
		return hpowe;
	if(cellvalue == "lpowe") 
		return lpowe;
	if(cellvalue == "new") 
		return "<spring:message code='common.status.new'/>";
	if(cellvalue == "ina") 
		return "<spring:message code='common.status.inactive'/>";
    return cellvalue == null ? "" : cellvalue;
}
  
  function alarmLevelFormatter(cellvalue, options, rowObject){
		var lowImage = "";
		var mediumImage = "";
		var highImage = "";
		var lowLevelText = lowLevel;
		var mediumLevelText = mediumLevel;
		var highLevelText = highLevel;
		var alarmText = '<spring:message code="tsadmin.editStation.tab.text.alarm"/>';
		if(rowObject != null){
			lowImage = "<img src='/images/low-alarm.png' width='19px' height='19px'>&nbsp;";
			mediumImage = "<img src='/images/list_warning.png' width='17px' height='17px'>&nbsp;";
			highImage = "<img src='/images/warn.png' width='16px' height='16px'>&nbsp;";
		}
		if(options != null){
			lowLevelText = lowLevel.replace(alarmText,"");
			mediumLevelText = mediumLevel.replace(alarmText,"");
			highLevelText = highLevel.replace(alarmText,"");
		}
		if(cellvalue == "LOW") 
			return lowImage+lowLevelText;
		if(cellvalue == "MEDIUM") 
			return mediumImage+mediumLevelText;
		if(cellvalue == "HIGH") 
			return highImage+highLevelText;
	    return cellvalue == null ? "" : cellvalue;
	}
  
  
  function globalAjaxError(msgBox){
	  showMesssageByTime(msgBox, '<spring:message code="error.ajax.global.error"/>', 10000);
  }
  
  function editstationErrorHandler(){
		globalAjaxError("StationMessageBox");
  }
</script>

