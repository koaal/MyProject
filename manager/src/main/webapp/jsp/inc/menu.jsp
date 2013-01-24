<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./tags.jsp"%>

<div class="well sidebar-nav">
  <ul class="nav nav-list">
    <li class="nav-header">System</li>
    <li ${param.active == 'user' ? 'class="active"' : ''}><a href="${ctx}/admin/listUser.do"><i class="icon-user"></i> Users</a></li>
    <li ${param.active == 'Settings' ? 'class="active"' : ''}><a href="#"><i class="icon-cog"></i> Settings</a></li>
    <li ${param.active == 'dashboard' ? 'class="active"' : ''}><a href="${ctx}/admin/dashboard.do"><i class="icon-th"></i> Dashboard</a></li>
    <li class="nav-header">Biz</li>
    <li ${param.active == 'storage' ? 'class="active"' : ''}><a href="#"><i class="icon-gift"></i> Storage</a></li>
    <li ${param.active == 'order' ? 'class="active"' : ''}><a href="#"><i class="icon-book"></i> Orders</a></li>
    

    <li class="divider"></li>
    <li><a href="#"><i class="icon-flag"></i> Help</a></li>
  </ul>
</div><!--/.well -->
                 