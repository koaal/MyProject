/*
 * 
 *     $("#tabCot_product_2").selectTable({
			url : "/readmin/listPermissionRegions.do",
			data : {userid: '${editUser.id}'},
			defaultFilterValue : "输入区域名...",
			leftTitle : "未分配区域编号",
			rightTitle : "已分配区域编号"
		}); 
 * 
 * 
 * 
 * 
 * 
 */


(function($) {
	$.fn.selectTable = function(options) {
		$.fn.selectTable.defaults = {
				availabled : [],
				selected : [],
				selectingLeft : [],
				selectingRight : [],
				defaultFilterValue : "请输入编号...",
				leftTitle : '可选',
				rightTitle : '已选',
				filter : false,
				extend : false,
				returnValueInput : "permission"
		};
		
		var opts = $.extend({}, $.fn.selectTable.defaults, options);
    	this.availabled = opts.availabled;
    	this.selected = opts.selected;
    	this.selectingLeft = opts.selectingLeft;
    	this.selectingRight = opts.selectingRight;
    	this.url = opts.url;
    	this.data = opts.data;
    	this.defaultFilterValue = opts.defaultFilterValue;
    	draw(this);
    	init();
		return this.each(function() {
			
			
		});
		
		function init(){
			 for(var i = 0 ; i<opts.availabled.length;i++){
				 purseAvailableItems(opts.availabled[i].id, opts.availabled[i].name);
			 }
			 for(var i = 0 ; i<opts.selected.length;i++){
				 purseSelectedItems(opts.selected[i].id, opts.selected[i].name);
			 }
			 if(opts.url != "" || opts.url != null){
				 loadData();
			 }
			 bindSelectEvent();
			 bindAdd();
			 bindRemove();
			 bindAvailabledFilter();
			 bindSelectedFilter();
			 purseValueInput();
			 fillValues();
		 };
		 
		 function draw(obj){
			 
			 var rightTitle =   ' <table border="0" style="width:100%" cellpadding="0" cellspacing="0" id="tablelist">'
								+'   <tr>'
				 				+'     <td bgcolor="#efefef" height="25px" style="border-bottom:0;"><strong>'+opts.rightTitle+'</strong></td>'
				 				+'     </tr>'
				 				+' </table>';
			 if(opts.extend){
				 rightTitle = '<table border="0" style="width:100%" cellpadding="0" cellspacing="0" id="title_tablelist">'
								 +'  <tr>'
								 +'      <td id="selecttitleText"  bgcolor="#efefef" height="25px" style="border-bottom:0;"><strong>'+opts.rightTitle+'</strong></td>'
								 +'      <td  id="viewTitle" width="51px;" bgcolor="#efefef" style="border-bottom:0;align:center"><strong>读权限</strong></td>'
								 +'       <td  id="editTitle" width="51px;" bgcolor="#efefef" style="border-bottom:0;align:center"><strong>写权限</strong></td>'
								 +' </tr>'
								 +'</table>';
			 }
			 
			 var tableHead = '<table border="0" cellspacing="2" cellpadding="0">'
					        +'<tr>'
					        +'    <td colspan="2"><table border="0">';
			 
			 var filterHtml =	'      <tr>'
						        +'        <td  height="34" valign="top">'
						        +'         <table border="0" cellspacing="0" cellpadding="0" width="100%">'
						        +'            <tr>'
						        +'              <td ><input name="availabledFilter" id="availabledFilter" type="text" class="search_input" style="width: 200px;" value="'+opts.defaultFilterValue+'"'
						        +'              	onblur="if (this.value == \'\') {this.value = \''+opts.defaultFilterValue+'\';}"'
				 				+'				onfocus="if (this.value == \''+opts.defaultFilterValue+'\') {this.value = \'\';}"/></td>'
				 				+'              <td  align="right"><a href="#" id="availabledFilterButton" class="search_button"></a></td>'
				 				+'              </tr>'
				 				+'            </table>'
				 				+'          <td >&nbsp;</td>'
				 				+'        <td height="34" valign="top"><table border="0" cellspacing="0" cellpadding="0" width="100%">'
				 				+'          <tr>'
				 				+'            <td><input name="selectedFilter" type="text" class="search_input" id="selectedFilter" style="width: 200px;" value="'+opts.defaultFilterValue+'"'
				 				+'            	onblur="if (this.value == \'\') {this.value = \''+opts.defaultFilterValue+'\';}"'
				 				+'				onfocus="if (this.value == \''+opts.defaultFilterValue+'\') {this.value = \'\';}"/></td>'
				 				+'            <td align="right"><a href="#" id="selectedFilterButton" class="search_button"></a></td>'
				 				+'            </tr>'
				 				+'          </table>'
				 				+'			</td>'
				 				+'        </tr>';
			 
				var tableFoot =	'      <tr>'
					 				+'        <td valign="top">'
					 				+'          <div class="tablelist_selection">'
					 				+'            <table id="tablelist" border="0" cellspacing="0" cellpadding="0">'
					 				+'              <tr class="tr_over" >'
					 				+'                <td bgcolor="#efefef"><strong>'+opts.leftTitle+'</strong></td>'
					 				+'              	</tr>'
					 				+'              </table>'
					 				+'              <ol id="availableTable"></ol>'
					 				+'            </div>'
					 				+'          </td>'
					 				+'        <td><span style="margin: 13px 14px 10px 7px;width: 31px;float:left;	display:block;">'
					 				+'          <a href="#" id="remove" class="ui-button"><span><</span></a>'
					 				+'          <a href="#" id="add" class="ui-button"><span>></span></a>'
					 				+'          </span></td>'
					 				+'        <td valign="top">'
					 				+'          <div class="tablelist_selection">'
					 				+ rightTitle
					 				+'              <div id="selectValueDiv"></div>'
					 				+'              <ol id="selectedTable"></ol>'
					 				+'            </div>'
					 				+'          </td>'
					 				+'        </tr>'
					 				+'    </table></td>'
					 				+'  </tr>'
					 				+' </table>';
					if(opts.filter){
						html = tableHead + filterHtml  + tableFoot;
					}else{
						html = tableHead + tableFoot;
					}
			 		obj.html(html);
			 
		 };
		 
		 function bindSelectEvent(){
			 $( "#availableTable" ).selectable({
	    			stop: function() {
	    				opts.selectingLeft = [];
	    				$( ".ui-selected", this ).each(function() {
	    					var idStr = $(this).attr('id');
	    					if(idStr.indexOf("Text") != -1){
	    						$(this).removeClass("ui-selected");
	    					}else{
	    						var id = idStr.replace("Available_","");
	    						var textId = "#"+id+"Text";
		    					var name = $(textId).text();
		    					var index = indexOfArray(opts.selectingLeft,id);
		    					if( index < 0){
		    						opts.selectingLeft.push(new Entity(id,name));
		    					}
	    					}
	    				});
	    			}
	    		});
			 
			 $( "#selectedTable" ).selectable({
	    			stop: function() {
	    				opts.selectingRight = [];
	    				$( ".ui-selected", this ).each(function() {
	    					var id = $(this).attr('id');
	    					if(id.indexOf("Text") != -1){
	    						$(this).removeClass("ui-selected");
	    					}else{
	    						var textId = "#"+id+"Text";
		    					var name = $(textId).text();
		    					var index = indexOfArray(opts.selectingRight,id);
		    					if(index < 0){
		    						opts.selectingRight.push(new Entity(id,name));
		    					}
	    					}
	    				});
	    			}
	    		});
		 };
		 
		 function purseAvailableItems( id, value){
	    		//var htmlStr =  '<li class="ui-widget-content" title="'+value+'" id="Available_'+id+'">'+value+'</li>';
			 	var li =document.createElement('li');
	    		$(li).addClass("ui-widget-content");
	    		$(li).attr('id', "Available_"+id);
	    		$(li).attr('title', value);
	    		
	    		var span = document.createElement('span');
	    		$(span).addClass("selectedTableSpanText");
	    		$(span).attr("id",id+"Text");
	    		$(span).attr("style","width:200px");
	    		$(span).append(value);
	    		$(li).append(span);
	    		$("#availableTable").append(li);
	     };		
	     
	      function purseSelectedItems(id,val){
	    		var li =document.createElement('li');
	    		$(li).addClass("ui-widget-content");
	    		$(li).attr('id', id);
	    		$(li).attr('title', val);
	    		
	    		var span = document.createElement('span');
	    		$(span).addClass("selectedTableSpanText");
	    		$(span).attr("id",id+"Text");
	    		$(span).append(val);
	    		if(!opts.extend){
	    			$(span).attr("style","width:200px");
	    		}
	    		$(li).append(span);
	    		
	    		//$(li).append(val);
	    		$("#selectedTable").append(li); 
	     };		
	     
	      function purseValueInput(){
	    	 var htmlStr =  '<input name="'+opts.returnValueInput+'" id="'+opts.returnValueInput+'" type="hidden" value="" />';
	    	 $( "#selectValueDiv" ).append(htmlStr);
	     };
	     
	     function purseRadio(id,info){
	    	var li = $("#"+id);
    		var radio1Div = document.createElement('div');
    		$(radio1Div).addClass("radioDiv");
    		var radio1 = $('<input>').attr({type: 'radio', name: id+'_radio',id : id+'_radio', value: 'view'});
    		if($(radio1).val() == info || info == null){
    			radio1.attr("checked","checked");
    		}
    		$(radio1Div).append(radio1);
    		
    		var radio2Div = document.createElement('div');
    		$(radio2Div).addClass("radioDiv");
    		var radio2 = $('<input>').attr({type: 'radio', name: id+'_radio',id : id+'_radio', value: 'edit'});
    		if($(radio2).val() == info || info == "*"){
    			radio2.attr("checked","checked");
    		}
    		$(radio2Div).append(radio2);
    		$(li).append(radio2Div);
    		$(li).append(radio1Div);
	     };
	     
	      function fillValues(){
	    	$( "#"+opts.returnValueInput ).val(getValues());
	     };
	     
	      function bindAdd(){
	    	 var selectedTableid = "#selectedTable";
	    	 var buttonId = "#add";
	    	 var add = function() {
	                return function() { 
	                	if(opts.availabled.length == 0){
	            			return;
	            		}
	                	
	            		if( opts.selectingLeft.length == 0){
	            			return;
	            		}
	            		for(var i = 0 ; i<opts.selectingLeft.length;i++){
	            			var entity = opts.selectingLeft[i];
	            			var index = indexOfArray(opts.selected,entity.id);
	            		 	if(index < 0){
	            		 		purseSelectedItems(entity.id, entity.name);
	            		 		if(opts.extend){
		    	       		 		purseRadio(entity.id, null);
		    	       		 	}
	            		 		opts.selected.push(new Entity(entity.id, entity.name));
	            		 		$("#Available_"+entity.id).remove();
	            		 		opts.availabled = jQuery.grep(opts.availabled, function(value) {
	            		 			return value.id != entity.id;
	            		 		});
	            		 	}
	            		}
	            		// fill values
	            		fillValues();
	            		opts.selectingLeft = [];
	            		sortRight();
	                }
	         };
	         $(buttonId).bind("click", add());
	     };
	     
	     
	     function bindRemove(){
	    	 var tableid = "#availableTable";
	    	 var remove = function() {
	                return function(evt) { 
	                	if(opts.selected.length == 0){
	            			return;
	            		}
	            		if( opts.selectingRight.length == 0){
	            			return;
	            		}
	            		for(var i = 0 ; i<opts.selectingRight.length;i++){
	            			var entity = opts.selectingRight[i];
	            		 	// if not exists in available items, then add it.
	            		 	var index = indexOfArray(opts.availabled,entity.id);
	            		 	if(index < 0){
	            		 		purseAvailableItems(entity.id,entity.name);
	            		 		opts.availabled.push(new Entity(entity.id, entity.name));
	            		 		$("#"+entity.id).remove();
	            		 		opts.selected = jQuery.grep(opts.selected, function(value) {
	            	 				return value.id != entity.id;
	            	 			});
	            		 	}
	            		}
	            		fillValues();
	            		selectingRight = [];
	            		sortLeft();
	                }
	         };
	         $("#remove").bind("click", remove());
	     };
	     
	     function sortRight(){
	    		var elems = $("#selectedTable").children('li').remove();
	    	    elems.sort(function(a,b){
	    	    	var compA = $(a).find('span').text().toUpperCase();
	    	    	var compB = $(b).find('span').text().toUpperCase();
	    	    	return (compA < compB) ? -1 : (compA > compB) ? 1 : 0;
	    	    });
	    	    $("#selectedTable").append(elems);
	    	};

	     function sortLeft(){
	    		var elems = $("#availableTable").children('li').remove();
	    	    elems.sort(function(a,b){
	    	    	var compA = $(a).find('span').text().toUpperCase();
	    	    	var compB = $(b).find('span').text().toUpperCase();
	    	    	return (compA < compB) ? -1 : (compA > compB) ? 1 : 0;
	    	    });
	    	    $("#availableTable").append(elems);
	     };
	     
	     function bindAvailabledFilter(){
	    	 var filterAvailabled = function() {
	                return function() {
	                	var name = $("#availabledFilter").val();
		    			$.each(opts.availabled, function(key,p){
		    				if(name != null && name != "" && name != opts.defaultFilterValue 
		    						&& p.name.toUpperCase().indexOf(name.toUpperCase()) == -1){
		    					$("#Available_"+p.id).hide();
		    				}else{
		    					$("#Available_"+p.id).show();
		    				}
		    			}); 
	                }
	         };
	         $("#availabledFilterButton").bind("click", filterAvailabled());
	     };
	     
	     function bindSelectedFilter(){
	    	 var filterSelected = function() {
	                return function() {
	                	var name = $("#selectedFilter").val();
		    			$.each(opts.selected,function(key,val){
		    				if(name != null && name != "" && name != opts.defaultFilterValue
		    						&& val.name.toUpperCase().indexOf(name.toUpperCase()) == -1){
			    					$("#"+val.id).hide();
		    				}else{
		    					$("#"+val.id).show();
		    				}
		    			}); 
	                }
	         };
	         $("#selectedFilterButton").bind("click", filterSelected());
	     };
	    	
	    	function loadData(){
	    		var selectedId = "#selectedTable";
	    		var availabledId = "#availableTable";
	    		//clear availableTS before search 
	    		opts.selected = [];
	    		opts.availabled = [];
	    		$(availabledId).empty();
	    		$(selectedId).empty();
	    		jQuery.ajax({  
	    	        type : 'GET',  
	    	        contentType : 'application/json',  
	    	        url : opts.url,  
	    	        data : opts.data,  
	    	        dataType : 'json',  
	    	        success : function(map){ 
	    	        	for(var i = 0 ; i<map.selected.length;i++){
	    	        		var entity = new Entity(map.selected[i].id, map.selected[i].name);
	    	        		opts.selected.push(entity); 
	    	       		 	purseSelectedItems(entity.id, entity.name);
	    	       		 	// We have put the permission info the station's description
	    	       		 	if(opts.extend){
	    	       		 		purseRadio(entity.id,map.selected[i].description);
	    	       		 	}
	    	        	}
	    	        	for(var i = 0 ; i<map.available.length;i++){
  	    	        		 var entity = map.available[i];
  	    	        		 var index = indexOfArray(opts.selected,entity.id);
	    					if( index < 0){
	  	    	        		 opts.availabled.push(new Entity(entity.id, entity.name)); 
	  	    	        		 purseAvailableItems( entity.id, entity.name);
	    					}
  	    	        	}  
	    	        	fillValues();
	    	        },  
	    	        error : function(data){  
	    	            //alert("Load selected data error");  
	    	        }  
	    	    }); 
	    	};
	    	
	    	function getValues(){
	    		var values = "";
	    		$("#selectedTable").children('li').each(function(i){  
	    			var id = $(this).attr('id');
	    			var textId = "#"+id+"Text";
					var name = $(textId).text();
	    			if(opts.extend){
	    				var accessType = $('input:radio[name='+id+'_radio]:checked').val();
	    				values += "ts:"+accessType+":"+id+";";
			    	 }else{
			    		 values += id+";";
			    	 }
	    		}); 
	    		return values;
	    	};
	    	
	    	 function Entity(id,name,info)
	    	 {
	    	 	this.id = id;
	    	 	this.name=name;
	    	 };
	};
	
})(jQuery);

