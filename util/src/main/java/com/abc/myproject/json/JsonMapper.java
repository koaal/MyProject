package com.abc.myproject.json;

import java.io.IOException;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.DeserializationConfig;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.SerializationConfig;
import org.codehaus.jackson.map.annotate.JsonSerialize.Inclusion;
import org.codehaus.jackson.map.util.JSONPObject;
import org.codehaus.jackson.type.JavaType;
import org.codehaus.jackson.util.JsonParserDelegate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class JsonMapper {

	private static Logger	logger	= LoggerFactory.getLogger(JsonMapper.class);

	private ObjectMapper	mapper;

	public JsonMapper(Inclusion inclusion) {
		mapper = new ObjectMapper();
		mapper.setSerializationInclusion(inclusion);
		mapper.configure(DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		mapper.configure(DeserializationConfig.Feature.FAIL_ON_NUMBERS_FOR_ENUMS, true);
		mapper.configure(JsonParserDelegate.Feature.ALLOW_SINGLE_QUOTES, true);
		mapper.configure(JsonParserDelegate.Feature.ALLOW_UNQUOTED_FIELD_NAMES, true);
	}

	public static JsonMapper buildNormalMapper() {
		return new JsonMapper(Inclusion.ALWAYS);
	}

	public static JsonMapper buildNonNullMapper() {
		return new JsonMapper(Inclusion.NON_NULL);
	}

	public static JsonMapper buildNonDefaultMapper() {
		return new JsonMapper(Inclusion.NON_DEFAULT);
	}

	public static JsonMapper buildNonEmptyMapper() {
		return new JsonMapper(Inclusion.NON_EMPTY);
	}

	public String toJson(Object object) {

		try {
			return mapper.writeValueAsString(object);
		} catch (IOException e) {
			logger.error("write to json string error:" + object, e);
			throw new RuntimeException(e);
		}
	}

	public <T> T fromJson(String jsonString, Class<T> clazz) {
		if (StringUtils.isEmpty(jsonString)) {
			return null;
		}

		try {
			return mapper.readValue(jsonString, clazz);
		} catch (IOException e) {
			logger.error("parse json string error:" + jsonString, e);
			throw new RuntimeException(e);
		}
	}

	@SuppressWarnings("unchecked")
	public <T> T fromJson(String jsonString, JavaType javaType) {
		if (StringUtils.isEmpty(jsonString)) {
			return null;
		}

		try {
			return (T) mapper.readValue(jsonString, javaType);
		} catch (IOException e) {
			logger.error("parse json string error:" + jsonString, e);
			throw new RuntimeException(e);
		}
	}

	public <T> List<T> listFromJson(String jsonString, Class<?> objectClass) {
		try {
			JavaType type = mapper.getTypeFactory().constructParametricType(List.class, objectClass);
			return mapper.readValue(jsonString, type);
		} catch (IOException e) {
			logger.error("parse json string error:" + jsonString, e);
			throw new RuntimeException(e);
		}
	}

	public JavaType constructParametricType(Class<?> parametrized, Class<?>... parameterClasses) {
		return mapper.getTypeFactory().constructParametricType(parametrized, parameterClasses);
	}

	@SuppressWarnings("unchecked")
	public <T> T update(T object, String jsonString) {
		try {
			return (T) mapper.readerForUpdating(object).readValue(jsonString);
		} catch (JsonProcessingException e) {
			logger.error("update json string:" + jsonString + " to object:" + object + " error.", e);
			throw new RuntimeException(e);
		} catch (IOException e) {
			logger.error("update json string:" + jsonString + " to object:" + object + " error.", e);
			throw new RuntimeException(e);
		}
	}

	public String toJsonP(String functionName, Object object) {
		return toJson(new JSONPObject(functionName, object));
	}

	public void setEnumUseToString(boolean value) {
		mapper.configure(SerializationConfig.Feature.WRITE_ENUMS_USING_TO_STRING, value);
		mapper.configure(DeserializationConfig.Feature.READ_ENUMS_USING_TO_STRING, value);
	}

	public ObjectMapper getMapper() {
		return mapper;
	}
}
