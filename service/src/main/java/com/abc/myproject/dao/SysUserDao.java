package com.abc.myproject.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Component;

import com.abc.myproject.constant.NodePermission;
import com.abc.myproject.entity.SysUser;
import com.abc.myproject.entity.UserPermission;
import com.google.common.collect.Maps;

@Component
public class SysUserDao extends SqlSessionDaoSupport {

	@SuppressWarnings("unchecked")
	public List<SysUser> find(String name, String role, Long offset, Long limit) {
		Map<String, Object> params = Maps.newHashMap();
		params.put("name", name);
		params.put("role", role);
		params.put("offset", offset);
		params.put("limit", limit);
		return getSqlSession().selectList("SysUser.find", params);
	}

	@SuppressWarnings("unchecked")
	public List<SysUser> findByNodePermission(NodePermission node, Long instance) {
		Map<String, Object> params = Maps.newHashMap();
		params.put("node", node.getName());
		params.put("instance", String.valueOf(instance));
		return getSqlSession().selectList("SysUser.findByPermission", params);
	}

	public Long count(String name, String role) {
		Map<String, String> params = Maps.newHashMap();
		params.put("name", name);
		params.put("role", role);
		return (Long) getSqlSession().selectOne("SysUser.count", params);
	}

	public SysUser findByName(String name) {
		return (SysUser) getSqlSession().selectOne("SysUser.findByName", name);
	}

	public SysUser findById(Long id) {
		return (SysUser) getSqlSession().selectOne("SysUser.findById", id);
	}

	public void update(SysUser sysUser) {
		getSqlSession().update("SysUser.update", sysUser);
	}

	public void changePassword(Long id, String password) {
		Map<String, Object> params = Maps.newHashMap();
		params.put("id", id);
		params.put("password", password);
		getSqlSession().update("SysUser.changePassword", params);
	}

	public void insert(SysUser sysUser) {
		getSqlSession().insert("SysUser.insert", sysUser);
	}

	public void delete(Long id) {
		getSqlSession().delete("SysUser.delete", id);
	}

	public void insertPermissions(List<UserPermission> permissions) {
		getSqlSession().insert("SysUser.insertPermission", permissions);
	}

	public void deletePermissions(Long id) {
		getSqlSession().delete("SysUser.deletePermission", id);
	}

	public void deletePermissionByNode(List<Long> userIds, NodePermission node) {
		Map<String, Object> params = Maps.newHashMap();
		params.put("userids", userIds);
		if (node != null) {
			params.put("node", node.getName());
		}
		getSqlSession().delete("SysUser.deletePermissionByNode", params);
	}

	public void deletePermissionByInstance(Long instance, NodePermission node) {
		Map<String, Object> params = Maps.newHashMap();
		params.put("instance", instance.toString());
		if (node != null) {
			params.put("node", node.getName());
		}
		getSqlSession().delete("SysUser.deletePermissionByInstance", params);
	}

	@SuppressWarnings("unchecked")
	public List<UserPermission> bindPermissions(Long userId, NodePermission node) {
		Map<String, Object> params = Maps.newHashMap();
		params.put("userId", userId);
		params.put("node", node == null ? "" : node.getName());
		return getSqlSession().selectList("SysUser.bindPermissions", params);
	}

}
