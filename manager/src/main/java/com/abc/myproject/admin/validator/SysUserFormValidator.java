package com.abc.myproject.admin.validator;

import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.abc.myproject.entity.SysUser;
import com.abc.myproject.service.SysUserManager;

@Component
public class SysUserFormValidator implements Validator {
	@Autowired
	private SysUserManager sysUserManager;

	@Override
	public boolean supports(@SuppressWarnings("rawtypes") Class clazz) {
		return SysUser.class.isAssignableFrom(clazz);
	}

	public static final String emailPattern = "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$";

	public static final String mobilePattern = "^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";

	@Override
	public void validate(Object model, Errors errors) {
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name",
				"required.name", "Name is required.");

		SysUser user = (SysUser) model;
		Long id = user.getId();
		if (StringUtils.isNotBlank(user.getName())) {
			SysUser userDB = sysUserManager.findByName(user.getName());
			if (userDB != null) {
				if (id == null) {
					errors.rejectValue("name", "notmatch.name",
							"Name should be unique.");
				} else if (id.compareTo(userDB.getId()) != 0) {
					errors.rejectValue("name", "notmatch.name",
							"Name should be unique.");
				}
			}
		}

		// new user should be validate password

		if (id == null) {

			ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password",
					"required.password", "Password is required.");

			ValidationUtils.rejectIfEmptyOrWhitespace(errors,
					"confirmPassword", "required.confirmPassword",
					"Conform password is required.");

			if (!(user.getPassword().equals(user.getConfirmPassword()))) {
				errors.rejectValue("password", "notmatch.password",
						"Password and Conform password is not match.");
			}

			if (StringUtils.isNotBlank(user.getPassword())
					&& user.getPassword().length() < 6) {
				errors.rejectValue("password", "length.password",
						"Password should contain more than 6 characters.");
			}
		}

		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "email",
				"required.email", "Email is required.");
		Pattern p = null;
		p = Pattern.compile(emailPattern);
		if (StringUtils.isNotBlank(user.getEmail())
				&& !p.matcher(user.getEmail()).matches()) {
			errors.rejectValue("email", "notmatch.email", "Email is invalid.");
		}

		p = Pattern.compile(mobilePattern);
		if (StringUtils.isNotBlank(user.getMobile())
				&& !p.matcher(user.getMobile()).matches()) {
			errors.rejectValue("mobile", "notmatch.mobile",
					"Mobile is invalid.");
		}
	}

}
