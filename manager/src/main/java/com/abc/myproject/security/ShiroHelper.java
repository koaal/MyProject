package com.abc.myproject.security;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.stereotype.Component;

@Component
public class ShiroHelper {

	public ShiroUser getShiroUser() {
		PrincipalCollection principals = SecurityUtils.getSubject()
				.getPrincipals();
		ShiroUser shiroUser = (ShiroUser) principals.getPrimaryPrincipal();
		return shiroUser;
	}
}
