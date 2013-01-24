<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/tags.jsp"%>

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
    <link href="../css/style.css" rel="stylesheet">

  </head>
  <body>
	  <!-- Include Header Page -->
	  <jsp:include page="../inc/header.jsp">
	  	<jsp:param name="active" value="home" />
	  </jsp:include>

    <div class="container-fluid">
      <div class="row-fluid">
        <div class="span3">
				  <!-- Include Header Page -->
				  <jsp:include page="../inc/menu.jsp">
				  	<jsp:param name="active" value="dashboard" />
				  </jsp:include>
        </div><!--/span-->
        <div class="span9">
			    <ul class="breadcrumb">
				    <li>
				    <a href="${ctx}/jsp/index.jsp">Home</a> <span class="divider">/</span>
				    </li>
				    <li class="active">Dashboard</li>
			    </ul>
			    
			  	<div id="placeholder" style="width:600px;height:300px;margin-left:5%;"></div>          

        </div><!--/span-->
      </div><!--/row-->

      <hr>
      <footer>
        <p>&copy; Company 2012</p>
      </footer>

    </div><!--/.fluid-container-->

    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="../js/jquery-1.7.1.min.js"></script>
    <script src="../js/jquery.flot.min.js"></script>
    <script src="../js/bootstrap.js"></script>
		<script type="text/javascript">
		$(function () {
		    var sin = [], cos = [];
		    for (var i = 0; i < 20; i += 0.5) {
		        sin.push([i, Math.sin(i)]);
		        cos.push([i, Math.cos(i)]);
		    }

		    var plot = $.plot($("#placeholder"),
		           [ { data: sin, label: "sin(x)"}, { data: cos, label: "cos(x)" } ], {
		               series: {
		                   lines: { show: true },
		                   points: { show: true }
		               },
		               grid: { hoverable: true, clickable: true },
		               yaxis: { min: -1.2, max: 1.2 }
		             });

		    function showTooltip(x, y, contents) {
		        $('<div id="tooltip">' + contents + '</div>').css( {
		            position: 'absolute',
		            display: 'none',
		            top: y + 5,
		            left: x + 5,
		            border: '1px solid #fdd',
		            padding: '2px',
		            'background-color': '#fee',
		            opacity: 0.80
		        }).appendTo("body").fadeIn(200);
		    }

		    var previousPoint = null;
		    $("#placeholder").bind("plothover", function (event, pos, item) {
            if (item) {
                if (previousPoint != item.dataIndex) {
                    previousPoint = item.dataIndex;
                    
                    $("#tooltip").remove();
                    var x = item.datapoint[0].toFixed(2),
                        y = item.datapoint[1].toFixed(2);
                    
                    showTooltip(item.pageX, item.pageY,
                                item.series.label + " of " + x + " = " + y);
                }
            }
            else {
                $("#tooltip").remove();
                previousPoint = null;            
            }

		    });


		});
		</script>
  </body>
</html>
