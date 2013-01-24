package com.abc.myproject.util;

import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.abc.myproject.json.JsonMapper;
import com.google.common.collect.Lists;

public class OperationLogger {

	private static Logger logger = LoggerFactory.getLogger("operationLogger");

	private static final JsonMapper mapper = JsonMapper.buildNonNullMapper();

	public enum BusinessObject {
		USER;
	}

	public enum OperationType {
		CREATE, UPDATE, DELETE
	}

	public static void logOperation(BusinessObject bizObject,
			OperationType operationType, Object... data) {
		String userName = SecurityUtils.getSubject().getPrincipals().toString();
		List<Object> content = Lists.newArrayList();
		content.add(userName);
		content.add(operationType);
		content.add(bizObject);
		content.add(data);

		logger.info(mapper.toJson(content));
	}
}
