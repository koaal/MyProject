package com.abc.myproject.admin.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.abc.myproject.admin.validator.SysUserFormValidator;
import com.abc.myproject.constant.Roles;
import com.abc.myproject.entity.SysUser;
import com.abc.myproject.security.UserManagerRealm;
import com.abc.myproject.service.SysUserManager;
import com.abc.myproject.util.OperationLogger;
import com.abc.myproject.util.OperationLogger.BusinessObject;
import com.abc.myproject.util.OperationLogger.OperationType;
import com.abc.myproject.util.Pager;
import com.google.common.collect.Maps;

@Controller
public class SysUserController {
	private static Logger			logger	= Logger.getLogger(SysUserController.class);

	@Autowired
	private SysUserManager			sysUserManager;

	@Autowired
	private SysUserFormValidator	validator;

	@Autowired
	private UserManagerRealm		userManagerRealm;

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}

	@RequestMapping("/admin/listUser")
	public ModelAndView searchUsers(@RequestParam(required = false, defaultValue = "") String name,
			@RequestParam(required = false, defaultValue = "") String type,
			@RequestParam(required = false, defaultValue = "") String page, @RequestParam(required = false) Long id) {
		name = name == null ? "" : name.trim();
		ModelAndView mav = new ModelAndView("admin/listUser");
		String role = StringUtils.isBlank(type) ? null : Roles.valueOfName(type).getName();
		Long currentPage = StringUtils.isBlank(page) ? 1L : Long.parseLong(page);
		Long totalRows = sysUserManager.count(name, role);
		Pager<SysUser> pager = new Pager<SysUser>(totalRows, currentPage);
		List<SysUser> users = sysUserManager.find(name, role, pager.getStartRow(), pager.getPageSize());

		mav.addObject("LIST_USERS_RESULTS_KEY", users);
		mav.addObject("LIST_USERS_TYPE_KEY", type);
		mav.addObject("LIST_USERS_NAME_KEY", name);
		mav.addObject("LIST_USERS_PAGER", pager);

		return mav;
	}

	@RequestMapping("/admin/test")
	public ModelAndView testCookie(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView mav = new ModelAndView("admin/test");

		writeCookie(request, response, "testCookie", "testValue", 3600);

		// Cookie cookie = new Cookie("testCookie", "testValue");
		// cookie.setMaxAge(0);
		// response.addCookie(cookie);

		return mav;
	}

	public void writeCookie(HttpServletRequest request, HttpServletResponse response, String name, String value,
			int maxAge) {
		String domain = request.getServerName();
		String path = request.getContextPath();
		String cookie = generateCookie(domain, path, name, value, maxAge);
		response.addHeader("Set-Cookie", cookie);
	}

	private String generateCookie(String domain, String path, String name, String value, int maxAge) {
		StringBuilder cookie = new StringBuilder();
		DateFormat df = new SimpleDateFormat("EEE, dd-MMM-yyyy HH:mm:ss 'GMT'", Locale.US);
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.SECOND, maxAge);
		cookie.append(name + "=" + value + "; ");
		cookie.append("Expires=" + df.format(cal.getTime()) + "; ");
		cookie.append("Max-Age=" + maxAge + "; ");

		return cookie.toString();
	}

	@RequestMapping(value = "/admin/editUser", method = RequestMethod.GET)
	public ModelAndView edit(@RequestParam("id") Long id) {
		ModelAndView mav = new ModelAndView("admin/editUser");
		SysUser user = sysUserManager.findById(id);
		mav.addObject("editUser", user);
		return mav;
	}

	@RequestMapping(value = "/admin/updateUser", method = RequestMethod.POST)
	public ModelAndView update(@ModelAttribute("editUser") SysUser user, BindingResult result, SessionStatus status,
			@RequestParam(required = false) String permission) {
		ModelAndView mav = new ModelAndView("admin/editUser");

		validator.validate(user, result);

		if (result.hasErrors()) {
			return mav;
		}
		sysUserManager.save(user);
		userManagerRealm.clearSubjectInfoInCache(user.getName());
		OperationLogger.logOperation(BusinessObject.USER, OperationType.UPDATE, user);
		// TODO research status
		status.setComplete();
		mav.addObject("UPDATE_LEFT_MENU_KEY", true);
		return mav;
	}

	@RequestMapping(value = "/admin/createUser", method = RequestMethod.GET)
	public ModelAndView create() {
		ModelAndView mav = new ModelAndView("admin/newUser");
		SysUser user = new SysUser();
		mav.getModelMap().put("newUser", user);
		return mav;
	}

	@RequestMapping(value = "/admin/saveUser", method = RequestMethod.POST)
	public ModelAndView save(@ModelAttribute("newUser") SysUser user, BindingResult result, SessionStatus status) {
		validator.validate(user, result);
		ModelAndView mav = new ModelAndView("admin/newUser");
		if (result.hasErrors()) {
			return mav;
		}
		sysUserManager.save(user);
		userManagerRealm.clearSubjectInfoInCache(user.getName());
		OperationLogger.logOperation(BusinessObject.USER, OperationType.CREATE, user);
		status.setComplete();
		mav = new ModelAndView("forward:listUser.do");
		mav.addObject("editUser", user);
		mav.addObject("UPDATE_LEFT_MENU_KEY", true);
		return mav;
	}

	@RequestMapping("/admin/deleteUser")
	public ModelAndView delete(@RequestParam("id") Long id,
			@RequestParam(required = false, defaultValue = "") String name,
			@RequestParam(required = false, defaultValue = "") String page) {
		ModelAndView mav = new ModelAndView("forward:listUser.do");
		SysUser user = sysUserManager.findById(id);
		userManagerRealm.clearSubjectInfoInCache(user.getName());
		sysUserManager.delete(id);
		OperationLogger.logOperation(BusinessObject.USER, OperationType.DELETE, user);
		return mav;
	}

	@RequestMapping("/admin/changePassword")
	public @ResponseBody
	Map<String, String> changePassword(@RequestParam("id") Long id, @RequestParam("oldPassword") String oldPassword,
			@RequestParam("password") String password) {
		Map<String, String> results = Maps.newHashMap();
		SysUser user = sysUserManager.findById(id);

		if (user == null || user.getPassword() == null) {
			results.put("result", "unknowError");
			logger.info("User: " + id + " try to change password, but failed.");
		} else if (!user.getPassword().equals(new Md5Hash(oldPassword).toHex())) {
			results.put("result", "oldPasswordError");
			logger.info("User: " + user.getName() + " try to change password, but failed.");
		} else {
			sysUserManager.changePassword(id, password);
			results.put("result", "success");
			logger.info("User: " + user.getName() + " change password.");
		}
		return results;
	}

	@RequestMapping("/admin/resetPassword")
	public @ResponseBody
	Map<String, String> resetPassword(@RequestParam("id") Long id, @RequestParam("password") String password) {
		Map<String, String> results = Maps.newHashMap();
		SysUser user = sysUserManager.findById(id);
		if (user != null) {
			sysUserManager.changePassword(id, password);
			results.put("result", "success");
			logger.info("User: " + user.getName() + " change password.");
		} else {
			results.put("result", "unknowError");
			logger.info("User: " + id + " try to change password, but failed.");
		}
		return results;
	}

	@RequestMapping(value = "/admin/dashboard", method = RequestMethod.GET)
	public ModelAndView dashboard() {
		ModelAndView mav = new ModelAndView("dashboard/dashboard");

		return mav;
	}

}
