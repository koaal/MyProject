package com.abc.myproject.service;

import java.util.List;

import javax.sql.DataSource;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;

import com.abc.myproject.constant.Roles;
import com.abc.myproject.db.DbUnitUtils;
import com.abc.myproject.entity.SysUser;
import com.abc.myproject.spring.SpringContextHolder;
import com.abc.myproject.tools.SpringContextTestCase;
import com.abc.myproject.util.PermissionUtil;

@ContextConfiguration(locations = { "/applicationContext-test.xml",
		"/applicationContext-service.xml" })
public class SysUserManagerTest extends SpringContextTestCase {

	private SysUserManager sysUserManager;

	private static DataSource dataSource;

	@Autowired
	public void setSysUserManager(SysUserManager sysUserManager) {
		this.sysUserManager = sysUserManager;
	}

	@Test
	public void find() {
		dataSource = SpringContextHolder.getBean("dataSource");
		try {
			DbUnitUtils.loadDbUnitData(dataSource, "/data/sys_user.xml");
		} catch (Exception e) {
			fail("load data error");
			e.printStackTrace();
		}

		List<SysUser> users = sysUserManager.find(null, null, 0L, 100L);
		assertEquals(1, users.size());

		SysUser user = sysUserManager.findById(1001L);
		assertNotNull(user);
		assertEquals("admin", user.getName());
		assertEquals(0, user.getUserPermissions().size());

	}

	@Test
	public void edit() {
		// create
		SysUser user = new SysUser();
		String name = "testUser";
		user.setName(name);
		user.setPassword("123456");
		user.setRole(Roles.ADMIN.getName());

		user.getUserPermissions().add(
				PermissionUtil.fromPermissionStr(null, "ts:view:*"));

		user = sysUserManager.save(user);
		assertNotNull(user);
		assertEquals(name, user.getName());
		user = sysUserManager.bindAllPermission(user);
		assertEquals(1, user.getUserPermissions().size());

		// update
		name = "updateUser";
		user.setName(name);
		user.getUserPermissions().add(
				PermissionUtil.fromPermissionStr(user.getId(),
						"ts:create:001,002"));

		user = sysUserManager.save(user);
		assertNotNull(user);
		assertEquals(name, user.getName());
		user = sysUserManager.bindAllPermission(user);
		assertEquals(2, user.getUserPermissions().size());

		// delete
		sysUserManager.delete(user.getId());
		user = sysUserManager.findById(user.getId());
		assertNull(user);
	}

}
