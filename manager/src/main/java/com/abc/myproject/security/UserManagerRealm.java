package com.abc.myproject.security;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.abc.myproject.entity.SysUser;
import com.abc.myproject.entity.UserPermission;
import com.abc.myproject.service.SysUserManager;
import com.abc.myproject.util.PermissionUtil;
import com.google.common.collect.Lists;

@Component
public class UserManagerRealm extends AuthorizingRealm {

	private static Logger logger = Logger.getLogger(UserManagerRealm.class);

	@Autowired
	private SysUserManager userManager;

	public UserManagerRealm() {
		setCredentialsMatcher(new HashedCredentialsMatcher(
				Md5Hash.ALGORITHM_NAME));
		// setCredentialsMatcher(new SimpleCredentialsMatcher());
	}

	protected AuthenticationInfo doGetAuthenticationInfo(
			AuthenticationToken authcToken) throws AuthenticationException {
		UsernamePasswordToken token = (UsernamePasswordToken) authcToken;
		SysUser user = userManager.findByName(token.getUsername());

		if (user != null) {
			logger.info("User: " + user.getName() + " login.");
			return new SimpleAuthenticationInfo(new ShiroUser(user.getId(),
					user.getName()), user.getPassword(), getName());
		}
		logger.info("User: " + token.getUsername()
				+ " try to login, but failed.");

		return null;
	}

	protected AuthorizationInfo doGetAuthorizationInfo(
			PrincipalCollection principals) {
		ShiroUser shiroUser = (ShiroUser) principals.fromRealm(getName())
				.iterator().next();
		SysUser user = userManager.findById(shiroUser.getId());
		if (user != null) {
			SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
			info.addRole(user.getRole());
			user = userManager.bindAllPermission(user);
			List<UserPermission> permissions = user.getUserPermissions();
			if (CollectionUtils.isNotEmpty(permissions)) {
				List<String> strPermissions = Lists.newArrayList();
				for (UserPermission permission : permissions) {
					strPermissions.add(PermissionUtil
							.toPermissionStr(permission));
				}
				info.addStringPermissions(strPermissions);
			}

			return info;
		}

		return null;
	}

	/**
	 * Clear the subject's cache in shiro.
	 */
	public void clearCurrentSubjectInfoInCache() {
		clearCachedAuthorizationInfo(SecurityUtils.getSubject().getPrincipals());
	}

	/**
	 * Clear subject info in cache by user
	 * 
	 * @param userName
	 */
	public void clearSubjectInfoInCache(String userName) {
		SimplePrincipalCollection principals = new SimplePrincipalCollection(
				userName, getName());
		clearCachedAuthorizationInfo(principals);
	}

	/**
	 * Clear all subjects cache in shiro.
	 */
	public void clearAllSubjectInfoInCache() {
		Cache<Object, AuthorizationInfo> cache = getAuthorizationCache();
		if (cache != null) {
			for (Object key : cache.keys()) {
				cache.remove(key);
			}
		}
	}

}
