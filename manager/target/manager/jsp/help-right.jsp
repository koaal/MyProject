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
<style type="text/css">
	.first_title{
		color: #108ac6;
		font-size: 20px;
	}
	.second_title{
		font-size:18px;
	}
	.main_body{
		font-size: 15px;
	}
</style>
</head>
<body>
   <div id="right">
  <div class="right_header">
  <div class="titel"><span style="margin-top:-3px; margin-right:5px;">帮助信息</span></div>

    <div id="tabCot_product" class="tab">
      
      <span class="first_title">系统管理员<a id="admin_main" name="admin_main"  ></a></span><br><br>
      <ul class="second_title">
      
      	<li>&nbsp;&nbsp;&nbsp;&nbsp;1.用户与权限<a id="admin_user" name="admin_user"  ></a><br>
      		<p class="main_body">
      		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;在用户与权限面板中，是对区域管理员和设备管理员的添加、删除、查找、修改，以及分配区域：<br><br>
      		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;添加：在用户类型中，共有两种类型(区域管理员和设备管理员)可供选择，带有*的为必填项，邮箱和手机号都要符合常规格式，基本信息添加完后，点击右上角的保存新建按钮即可完成对新建用户的保存。<br><br>
      		<img align="middle" alt="" src="/images/help/admin_add.png">
      		<br><br>
      		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;删除：如果要删除区域管理员或设备管理员，在左侧面板中选中要删除的用户，右上角会出现删除用户按钮，点击即可删除该用户。<br><br>
      		<img align="middle" alt="" src="/images/help/admin_delete.png">
      		<br><br>
      		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;查找：在左侧面板的上方，可以查找用户，可以分类查找(三种类型：全部，区域管理员，设备管理员)，查找支持精确查找和模糊查找，输入用户的部分或全部名称后，点击查找按钮，即可查找用户。<br><br>
      		<img align="middle" alt="" src="/images/help/admin_search.png">
      		<br><br>
      		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;修改：如果想修改某个用户，首先选中该用户，对该用户的基本信息进行修改，带有*的为必填项，邮箱和手机号都要符合常规格式，点击右上角的保存更新按钮即可完成对用户的修改。<br><br>
      		<img align="middle" alt="" src="/images/help/admin_update.png">
      		<br><br>
      		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;分配区域：选中区域管理员，在管理权限面板中，可以给该区域管理员分配区域。<br><br>
      		<img align="middle" alt="" src="/images/help/admin_allocation.png">
      			<br><br>
      		</p>
      	
      	</li>
      	
      	<li>&nbsp;&nbsp;&nbsp;&nbsp;2.区域管理<a id="admin_region" name="admin_region"  ></a><br>
      		<p class="main_body">
      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;在区域管理面板中，可以实现对区域的新建、删除、查找、修改：<br><br>
      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;添加：在区域管理面板中，可以新建区域，其中区域名称是必填项，如果已经新建了区域管理员，在新建区域的同时，可以增加区域管理员对该区域的管理。<br><br>
      			<img alt="" src="/images/help/admin_region_add.png">
      			<br><br>
      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;删除：如果要删除某个区域，在左侧面板中选中要删除的区域，右上角会出现删除按钮，点击即可删除该区域。<br><br>
      			<img alt="" src="/images/help/admin_region_delete.png">
      			<br><br>
      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;查找：在左侧面板的上方，可以查找区域，支持精确查找和模糊查找，输入区域的部分或全部名称后，点击查找按钮，即可查找区域。<br><br>
      			<img alt="" src="/images/help/admin_region_search.png">
      			<br><br>
      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;修改：如果要修改某个区域，选中该区域，对该区域的基本信息进行修改，点击右上角的保存更新按钮即可完成对区域的修改。<br><br>
      			<img alt="" src="/images/help/admin_region_update.png">
      			<br><br>
      		</p>
      	
      	</li>
      	<li>&nbsp;&nbsp;&nbsp;&nbsp;3.数据备份恢复<a id="data_backup" name="data_backup"  ></a><br>
      		<p class="main_body">
      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;数据库服务器每天自动备份数据库文件，压缩后存放在<i>/opt/ericsson/sdp/backup</i>目录下：<br><br>
      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;备份：管理员也可以手工备份数据库文件，备份方法是以<i>root</i>用户登陆到数据库服务器，执行如下命令：<br><br>
      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i>/opt/ericsson/sdp/setup-tool/builds/config/mysql/bin/backup.sh</i><br><br>
      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;恢复：如果需要恢复数据，管理员需要先停止应用系统，然后以<i>root</i>用户登陆到数据库服务器，选中需要恢复的数据库文件执行如下命令恢复数据库：<br><br>
      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i>gunzip MysqlDB_2012-05-09.sql.gz</i><br><br>
      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i>mysql -h127.0.0.1 -uroot -proot sdp &lt; MysqlDB_2012-05-09.sql 2&gt;&amp;1&gt;&gt; Mysql_restore.log</i><br><br>
      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i>mysql -h127.0.0.1 -uroot -proot dac &lt; MysqlDB_2012-05-09.sql 2&gt;&amp;1&gt;&gt; Mysql_restore.log</i><br><br>
      			<br><br>

      		</p>
      	
      	</li>  
      	<li>&nbsp;&nbsp;&nbsp;&nbsp;4.系统监控<a id="server_monitor" name="server_monitor"></a><br>
      		<p class="main_body">
      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;在系统监控面板中，可以监控服务器的CPU使用率、磁盘使用率和空闲内存：<br><br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CPU使用率：可以显示服务器在过去的1小时、3小时、5小时和24小时内的CPU使用率情况。<br><br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;建议：当CPU使用率持续超过80%的时候，请联系爱立信支持人员，在支持人员协助下可以适当调低系统并发执行线程数量和设备检测间隔时间。<br><br>
				<img alt="" src="/images/help/admin_CPU.png">
				<br><br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;磁盘使用率：可以显示服务器在过去的1小时、3小时、5小时和24小时内的磁盘使用率情况，存放MYSQL数据文件和日志文件的磁盘需要密切关注，确保可用空间足够。<br><br>
	      		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;建议：当系统部署磁盘或者MYSQL数据库安装磁盘的使用率超过90%的时候，请联系爱立信支持人员，在支持人员协助下可以适当清理系统日志文件、数据备份文件。<br><br>
	      		<img alt="" src="/images/help/admin_disk.png">
				<br><br>
	      		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;空闲内存：可以显示服务器在过去的1小时、3小时、5小时和24小时内的空闲内存。<br><br>
	      		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;建议：当空闲内存持续低于50M的时候，请联系爱立信支持人员，在支持人员协助下可以适当调低系统并发执行线程数量和设备检测间隔时间。<br><br>
				<img alt="" src="/images/help/admin_memory.png">
				<br><br>     			
      		</p>
      	
      	
      	</li>
		<li>&nbsp;&nbsp;&nbsp;&nbsp;5.系统设置<a id="server_config" name="server_config"></a><br>
			<p class="main_body">
      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;在系统设置面板中，可以对系统参数进行配置，可以查看当前许可证信息：<br><br>
      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;声音告警：在系统配置面板中，告警级别分为紧急告警，重要告警和一般告警，默认情况下只勾选紧急告警，用户可根据情况来选择告警级别声音提示。<br><br>
      			<img alt="" src="/images/help/admin_alarm.png">
      			<br><br>
      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;许可证管理：显示许可证的授权用户，颁发时间，到期时间，激活网关数和设备数，以及绑定地址。<br><br>
			    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;许可证到期后设备采集节点将停止服务，系统不再可用。系统激活网关数或者设备数到达许可证允许最大数量后系统将不能激活新网关或设备，但系统可以继续正常使用。<br><br>
  			    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;如果您需要新的许可证请联系爱立信，取得新的许可证以后把key文件和license文件复制到设备采集节点的WEB部署目下，然后重启设备采集节点，系统将恢复正常使用。<br><br>
      			<img alt="" src="/images/help/admin_license.png">
      			<br><br>
      			

      		</p>
		
		</li>
      </ul>
      <span class="first_title">设备管理员<a id="equipment" name="equipment"></a></span><br><br>
      <ul class="second_title">
      	<li>&nbsp;&nbsp;&nbsp;&nbsp;设备管理<a id="equipment_admin" name="equipment_admin"></a><br>
      		<p class="main_body">
      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;在设备管理面板中，可以实现对设备的新建、删除、查找、修改：<br><br>
      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;添加：只有在新建了变电站之后才允许新建变电站下面的设备，带*号的为必填项，基本信息添加完后，点击右上角的保存新建按钮完成对设备的新建。<br><br>
      			<img alt="" src="/images/help/equip_add.png">
      			<br><br>
      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;删除：如果要删除设备，在左侧面板中选中变电站，会列出该变电站下面所有的设备，每一行的最后一列可以执行对该行设备的删除操作。<br><br>
      			<img alt="" src="/images/help/equip_delete.png">
      			<br><br>
      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;查找：可以实现对变电站的查找和对每个变电站下面的设备的查找，如果要查找变电站，在左侧面板中，输入变电站的部分或全部名称后，点击查找按钮，即可查找变电站；如果要查找设备，选中某个变电站，在右侧面板中，输入设备的部分或全部名称后，点击查找按钮，即可查找设备。<br><br>
      			<img alt="" src="/images/help/equip_search.png">
      			<br><br>
      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;修改：如果要修改设备，在左侧面板中选中该设备的变电站，在该设备的最后一列可以执行对该设备的修改操作。<br><br>
      			<img alt="" src="/images/help/equip_update.png">
      			<br><br>      			
      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;导入：设备管理员可用根据系统提供的模板，批量导入多个网关或者设备，并可查询导入结果。<br><br>
      			<br><br> 
      		</p>
      	</li>
      </ul>
      
      <span class="first_title">区域管理员<a id="region" name="region"  ></a></span><br><br>
     <ul class="second_title">
      
      	<li>&nbsp;&nbsp;&nbsp;&nbsp;1.用户与权限<a id="region_user" name="region_user"  ></a><br>
      		<p class="main_body">
      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;在用户与权限面板中，是对变电站管理员的添加、删除、查找、修改，以及管理变电站：<br><br>
      		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;添加：带有*的为必填项，邮箱和手机号都要符合常规格式，基本信息添加完后，点击右上角的保存新建按钮即可完成对新建变电站管理员的保存。<br><br>
      		<img alt="" src="/images/help/region_user_add.png">
      		<br><br>
      		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;删除：如果要删除变电站管理员，在左侧面板中选中要删除的用户，右上角会出现删除用户按钮，点击即可删除该用户。<br><br>
      		<img alt="" src="/images/help/region_user_delete.png">
      		<br><br>
      		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;查找：在左侧面板的上方，可以查找用户，查找支持精确查找和模糊查找，输入用户的部分或全部名称后，点击查找按钮，即可查找用户。<br><br>
      		<img alt="" src="/images/help/region_user_search.png">
      		<br><br>
      		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;修改：如果想修改某个变电站管理员，首先选中该用户，对该用户的基本信息进行修改，带有*的为必填项，邮箱和手机号都要符合常规格式，点击右上角的保存更新按钮即可完成对用户的修改。<br><br>
      		<img alt="" src="/images/help/region_user_update.png">
      		<br><br>
      		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;管理变电站：选中变电站管理员，在管理权限面板中，可以给该变电站管理员分配变电站。<br><br>
      		<img alt="" src="/images/help/region_user_adminStation.png">
      		<br><br>
      		</p>
      	</li>
      	
      	<li>&nbsp;&nbsp;&nbsp;&nbsp;2.变电站管理<a id="region_transformer" name="region_transformer"  ></a><br>
      		<p class="main_body">
      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;区域管理员对属于他管理的区域下面的所有变电站有任意的操作权限，详细操作说明参考变电站管理员的变电站管理<br><br>
      		<br><br>	
      		</p>
      	</li>
      </ul>
      
      <span class="first_title">变电站管理员<a id="transformer" name="transformer" ></a></span><br><br>
      <ul class="second_title">
     	 <li>&nbsp;&nbsp;&nbsp;&nbsp;1.变电站管理<a id="transformer_admin" name="transformer_admin"  ></a><br>
      		<p class="main_body">
      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;在变电站管理面板中，可以实现对变电站的新建、删除、查找、修改以及对变电站的管理：<br><br>
      			
      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;添加：在变电站管理面板中，可以新建变电站，其中带*的是必填项，基本信息添加完后，点击右上角的保存新建按钮即可完成对新建变电站的保存。<br><br>
      			<img alt="" src="/images/help/region_trans_add.png">
      			<br><br>
      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;删除：如果要删除某个变电站，在左侧面板中选中要删除的变电站，右上角会出现删除按钮，点击即可删除该变电站。<br><br>
      			<img alt="" src="/images/help/region_trans_delete.png">
      			<br><br>
      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;查找：在左侧面板的上方，可以查找变电站，支持精确查找和模糊查找，输入变电站的部分或全部名称后，点击查找按钮，即可查找变电站。<br><br>
      			<img alt="" src="/images/help/region_trans_search.png">
      			<br><br>
      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;修改：如果该变电站管理员对要修改的变电站只具有读权限，则不能修改该变电站；
      			如果该变电站管理员对要修改的变电站有写权限，则可以修改变电站，选中该变电站，对该区域的基本信息、列表视图进行修改，在基本信息中，可以添加变电站管理员的读或写权限；
      			在变电站列表视图中，可以添加线路，如果该线路上还没有添加设备，则该线路是可删除的，如果该线路上已经添加了设备，该线路只允许修改不允许删除。点击右上角的保存更新按钮即可完成对变电站的修改。<br><br>
      			<img alt="" src="/images/help/region_trans_update.png">
      			<br><br>
      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;变电站拓扑：拓扑图中可以查看变电站下所有线路，点击查看汇聚模块可以查看线路下所有网关，点击网关弹出网关下所有模块并以其路由状态展现，同时列出脱网模块，点击网关或者模块ID的链接，可以查看和导出性能数据。<br><br>
      			<img alt="" src="/images/help/tsa_user_topu.png">
      			<br><br>  
      			<img alt="" src="/images/help/tsa_user_performance.png">
      			<br><br>      			
      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;变电站列表：变电站列表可以以树形列表方式展现线路，点击某条线路可以以树形列表方式展现该线路下的所有网关和模块，并可以当个或者批量配置网关或者模块的参数。<br><br>
      			<img alt="" src="/images/help/tsa_user_list.png">
      			<br><br>  
      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;节点管理：在节点管理中，可以分配分配网关的IP地址，绑定网关到某个线路上，当个或者批量分配模块到各个网关上，已经绑定的网关或模块可以进行重新分配或者取消分配。<br><br>
      			<img alt="" src="/images/help/tsa_user_nodeManage.png">
      			<br><br>
      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;告警信息：在告警面板中，可以根据开始时间、结束时间、告警级别、节点名称、ip地址和地址来查找告警，可以对告警单个或批量处理，可以导出为EXCEL文件。<br><br>
      			<img alt="" src="/images/help/tsa_user_alarm.png">
      			<br><br>
      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;固件管理：在固件管理中，首先需要上传固件文件，选中需要升级的模块，可以单个模块升级，也可以批量升级同类模块，升级结果可用在查看固件升级状态列表中看到。<br><br>
      			<img alt="" src="/images/help/tsa_user_upgrade_firmware.png">
      			<br><br>
      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;端口映射：在端口映射中，可以对不同的网关下面的设备分配端口号，选择网关后，会列出该网关下所有的设备，选择要映射端口的设备，进行端口映射，也可以导出该网关下所有的设备的ip、地址和端口号。<br><br>
      			<img alt="" src="/images/help/tsa_user_port.png">
      			<br><br>
      		</p>
      	
      	</li>
      	<li>&nbsp;&nbsp;&nbsp;&nbsp;2.用户与权限<a id="transformer_user" name="transformer_user"  ></a><br>
      		<p class="main_body">
      			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;在用户与权限面板中，是对变电站操作员的添加、删除、查找、修改，以及管理变电站：<br><br>
      		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;添加：带有*的为必填项，邮箱和手机号都要符合常规格式，基本信息添加完后，点击右上角的保存新建按钮即可完成对新建变电站操作员的保存。<br><br>
      		<img alt="" src="/images/help/trans_user_add.png">
      		<br><br>
      		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;删除：如果要删除变电站操作员，在左侧面板中选中要删除的用户，右上角会出现删除用户按钮，点击即可删除该用户。<br><br>
      		<img alt="" src="/images/help/trans_user_delete.png">
      		<br><br>
      		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;查找：在左侧面板的上方，可以查找用户，查找支持精确查找和模糊查找，输入用户的部分或全部名称后，点击查找按钮，即可查找用户。<br><br>
      		<img alt="" src="/images/help/trans_user_search.png">
      		<br><br>
      		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;修改：如果想修改某个变电站操作员，首先选中该用户，对该用户的基本信息进行修改，带有*的为必填项，邮箱和手机号都要符合常规格式，点击右上角的保存更新按钮即可完成对用户的修改。<br><br>
      		<img alt="" src="/images/help/trans_user_update.png">
      		<br><br>
      		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;管理变电站：选中变电站操作员，在管理权限面板中，可以给该变电站操作员分配该管理员拥有的变电站，但是变电站操作员对变电站只具有读权限。<br><br>
      		<img alt="" src="/images/help/trans_user_adminStation.png">
      		<br><br>
      		</p>
      	
      	</li>
      	
      	
      </ul>
     
    </div>
  </div>
  </div>

</body>
</html>