function showMesssageByTime(id, msg,timeout){
	if(msg != null){
		  $('#'+id).html(msg);
	  }
	if(timeout != null && timeout > 0 ){
		$('#'+id).show('highlight',timeout, function(){
			$('#'+id).html('');
		});
	}else{
		$('#'+id).show();
	}
}

function go(url) {
	window.location = url;
}

function deleteConfirm(url)
{
	
 var isOK = confirm("确定要删除？");
 if(isOK)
 {
  go(url);
 }
}

$(function(){
	 $('ul li').click(function(){
	  $(this).css('background-color', '#D2ECFF').siblings().css('background-color', '');
	 });    
	})
	
String.prototype.startsWith = function(prefix) {
    return this.indexOf(prefix) === 0;
}

String.prototype.endsWith = function(suffix) {
    return this.match(suffix+"$") == suffix;
};

jQuery.removeFromArray = function(value, arr) {
    return jQuery.grep(arr, function(elem, index) {
        return elem !== value;
    });
};

$.fn.serializeObject = function() {     
    var o = {};     
    var a = this.serializeArray();     
    $.each(a, function() {     
      if (o[this.name]) {     
        if (!o[this.name].push) {     
          o[this.name] = [ o[this.name] ];     
        }     
        o[this.name].push(this.value || '');     
      } else {     
        o[this.name] = this.value || '';     
      }     
    });     
    return o;     
  };     
  
 function indexOfArray(array,id){
	 for(var i =0 ; i<array.length;i++){
		 if(array[i].id == id){
			 return i;
		 }
	 }
	 return -1;
 }


 /**
  * Jqgrid object abstract
  */
 (function($) {
		$.fn.grid = function(options) {
			$.fn.grid.defaults = {
					jsonReader : {
							root:"results",
							repeatitems : false,
							rows:function(result) {
							   return result.results;
							},
							total: function(result) {
						      return result.totalPages;
						    },
						    records: function(result) {
						    	//Total number of records
						        return result.totalRows;
						    },
						    page:function(result){
						    	return result.currentPage;
						    }
						},
					rowNum : 10,
					datatype: "json",
					mtype: "GET",
					height: "auto",
					width: "auto",
					//rowList: [10,20,30],
					prmNames:{rows:'pageSize', page:'currentPage'},
					rownumbers : false,  
			        viewrecords: true,
			        sortname: "id",
			        sortorder: 'desc',
			        id: "id",
					loadError: function(xhr, status, error) {
						//alert(error);
					},
					emptyrecords:'no records',
			        loadtext:'loading...',
			        recordtext:'View {0} - {1} of {2}',
			        gridview: false,
			        pgbuttons : true,
			        pginput: false,
			        autowidth: true,
					hidegrid: false,
					shrikToFit: true,
					footerrow : false,
					treeGrid: false,
					//treeIcons: { leaf: 'ui-icon-locked' },
					//treeIcons: { leaf: ' ' },
					ExpandColumn : null,
					multiselectWidth : 50,
					multiselect : false,
					subGrid: false,
					ExpandColClick: true,
					treeGridModel: null,
					treeReader : null,
					ondblClickRow: null,
				    gridComplete:null,
				    onSelectRow : null,
				    subGridRowExpanded:null,
				    loadComplete: null,
				    onSelectAll:null,
				    afterInsertRow : null
			};
			var opts = $.extend({}, $.fn.grid.defaults, options);
			$(this).jqGrid({
				url: opts.url,
				datatype: opts.datatype,
				id: opts.id,
				mtype: opts.mtype,
				height: opts.height,
				width: opts.width,
				colModel: opts.colModel,
				rowNum: opts.rowNum,
				rowList: opts.rowList,
				prmNames:opts.prmNames,
		        rownumbers : opts.rownumbers,  
		        viewrecords: opts.viewrecords, 
		        gridview: opts.gridview,
		        pginput: opts.pginput,
		        pgbuttons : opts.pgbuttons,
		        recordtext:opts.recordtext,
		        autowidth: opts.autowidth,
		        sortname: opts.sortname,
		        sortorder : opts.sortorder,
		        altRows: opts.altRows,
				jsonReader: opts.jsonReader,
				loadError: opts.loadError,
				pager: opts.pager,
				emptyrecords:opts.emptyrecords,
		        loadtext:opts.loadtext,
				hidegrid: opts.hidegrid,
				shrikToFit: opts.shrikToFit,
				footerrow : opts.footerrow,
				rownumWidth : opts.rownumWidth,
				multiselect : opts.multiselect,
				multiselectWidth : opts.multiselectWidth,
				subGrid: opts.subGrid,
				treeGrid: opts.treeGrid,
				treeIcons: opts.treeIcons,
				ExpandColClick: opts.ExpandColClick,
				treeGridModel: opts.treeGridModel,
				treeReader : opts.treeReader,
				ExpandColumn : opts.ExpandColumn,
				ondblClickRow: opts.ondblClickRow,
			    gridComplete:opts.gridComplete,
			    onSelectRow : opts.onSelectRow,
			    subGridRowExpanded:opts.subGridRowExpanded,
			    loadComplete: opts.loadComplete,
			    onSelectAll:opts.onSelectAll,
			    afterInsertRow:opts.afterInsertRow
			});
			return this.each(function() {
				
			});
		};
		
 })(jQuery);
 
 
 /**
 * Date format
 */
 Date.prototype.format = function(format)
 {
 /*
 * format="yyyy-MM-dd hh:mm:ss";
 */
 var o = {
	 "M+" : this.getMonth() + 1,
	 "d+" : this.getDate(),
	 "h+" : this.getHours(),
	 "m+" : this.getMinutes(),
	 "s+" : this.getSeconds(),
	 "q+" : Math.floor((this.getMonth() + 3) / 3),
	 "S" : this.getMilliseconds()
 }

 if (/(y+)/.test(format))
 {
	 format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4
	 - RegExp.$1.length));
 }

 for (var k in o)
 {
 if (new RegExp("(" + k + ")").test(format))
 {
	 format = format.replace(RegExp.$1, RegExp.$1.length == 1
 ? o[k]
 : ("00" + o[k]).substr(("" + o[k]).length));
 }
 }
 return format;
 }
 
 /**
  * Date picker region zh-cn
  */
 jQuery(function($){
     $.datepicker.regional['zh-CN'] = {
             closeText: '关闭',
             prevText: '<上月',
             nextText: '下月>',
             currentText: '今天',
             monthNames: ['一月','二月','三月','四月','五月','六月',
             '七月','八月','九月','十月','十一月','十二月'],
             monthNamesShort: ['一','二','三','四','五','六',
             '七','八','九','十','十一','十二'],
             dayNames: ['星期日','星期一','星期二','星期三','星期四','星期五','星期六'],
             dayNamesShort: ['周日','周一','周二','周三','周四','周五','周六'],
             dayNamesMin: ['日','一','二','三','四','五','六'],
             weekHeader: '周',
             dateFormat: 'yy-mm-dd',
             firstDay: 1,
             isRTL: false,
             showMonthAfterYear: true,
             Time : '时间',
             Hour : '时',
             Minute : '分',
             Now : '当前',
             Done : '确定'
             //yearSuffix: '年'
         };
     $.datepicker.setDefaults($.datepicker.regional['zh-CN']);
});
 
//Jquery map
 (function($){  
     $.imap = function(){  
          var imap = this.map = {};  
          this.get = function(key){  
              var val = eval("imap."+key);  
              return  (typeof val === undefined) ? null : val;  
          };  
          this.set = function(key,value){  
              eval("imap."+key+"=value");  
          };  
     };  
  })(jQuery);  

 
 function readFile(fileBrowser) {  
 　　　 if (navigator.userAgent.indexOf("MSIE")!=-1) {
  　　　　　　　return readFileIE(fileBrowser);  
 　　　 } else　if (navigator.userAgent.indexOf("Firefox")!=-1　|| navigator.userAgent.indexOf("Mozilla")!=-1)    {
　　　　　　 return readFileFirefox(fileBrowser);  
 　　　 } else { 
　　　　　　　return;  
   		}
    }
  
   function readFileFirefox(fileBrowser) {  
     try {    　　　　　　　
      netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");  
     } catch (e) {
      return;  　　　
     }
     var fileName=fileBrowser.value;  
　　　return fileName;
  }
   
   String.prototype.replaceAll  = function(s1,s2){   
	    return this.replace(new RegExp(s1,"gm"),s2);   
	}  

   
   function openLoadingDialog(){
	  $("#loading-dialog").show();
   }
   
   function closeLoadingDialog(){
	  $("#loading-dialog").hide();
   }
