package com.abc.myproject.service;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.abc.myproject.common.UUIDUtils;
import com.abc.myproject.constant.NodePermission;
import com.abc.myproject.dao.SysUserDao;
import com.abc.myproject.entity.SysUser;
import com.abc.myproject.entity.UserPermission;

@Component
public class SysUserManager {

	private SysUserDao sysUserDao;

	@Transactional(readOnly = true)
	public SysUser findById(Long id) {
		return sysUserDao.findById(id);
	}

	@Transactional(readOnly = true)
	public SysUser findByName(String name) {
		if (StringUtils.isNotBlank(name)) {
			return sysUserDao.findByName(name);
		} else {
			return null;
		}
	}

	@Transactional(readOnly = true)
	public List<SysUser> find(String name, String role, Long offset, Long limit) {
		return sysUserDao.find(name, role, offset, limit);
	}

	@Transactional(readOnly = true)
	public List<SysUser> findByNodePermission(NodePermission node, Long instance) {
		return sysUserDao.findByNodePermission(node, instance);
	}

	@Transactional(readOnly = true)
	public Long count(String name, String role) {
		return sysUserDao.count(name, role);
	}

	/**
	 * create user/user permission/user parent for new user, or update user/user
	 * permission for old user
	 * 
	 * @param parentUserId
	 * @param sysUser
	 * @return
	 */
	@Transactional(propagation = Propagation.REQUIRED)
	public SysUser save(Long parentUserId, SysUser sysUser) {
		boolean isNew = sysUser.getId() == null || sysUser.getId() == 0;
		if (isNew) {
			String password = sysUser.getPassword();
			String hashedPassword = new Md5Hash(password).toHex();
			sysUser.setId(UUIDUtils.generate());
			sysUser.setPassword(hashedPassword);
			sysUserDao.insert(sysUser);
			insertPermissions(sysUser);

		} else {
			sysUserDao.update(sysUser);
			sysUserDao.deletePermissions(sysUser.getId());
			insertPermissions(sysUser);

		}
		return sysUserDao.findById(sysUser.getId());
	}

	/**
	 * just for change user password
	 * 
	 * @param id
	 * @param password
	 */
	@Transactional(propagation = Propagation.REQUIRED)
	public void changePassword(Long id, String password) {
		sysUserDao.changePassword(id, new Md5Hash(password).toHex());
	}

	public SysUser save(SysUser sysUser) {
		return save(null, sysUser);
	}

	private void insertPermissions(SysUser sysUser) {
		List<UserPermission> permissions = sysUser.getUserPermissions();
		if (CollectionUtils.isNotEmpty(permissions)) {
			for (UserPermission permission : permissions) {
				permission.setUserId(sysUser.getId());
			}
			sysUserDao.insertPermissions(permissions);
		}
	}

	@Transactional
	public void delete(Long id) {
		sysUserDao.deletePermissions(id);
		sysUserDao.delete(id);
	}

	@Transactional(readOnly = true)
	public SysUser bindAllPermission(SysUser user) {
		List<UserPermission> permissions = sysUserDao.bindPermissions(
				user.getId(), null);
		user.setUserPermissions(permissions);
		return user;
	}

	@Autowired
	public void setSysUserDao(SysUserDao sysUserDao) {
		this.sysUserDao = sysUserDao;
	}

}
