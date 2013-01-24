package com.abc.myproject.tools;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;

import com.abc.myproject.db.DbUnitUtils;

public class DBInitial {

	@Autowired
	DataSource dataSource;

	public void init() {
		try {
			System.out.println("insert test data to db");
			DbUnitUtils.loadDbUnitData(dataSource, "/data/sys_user.xml");
		} catch (Exception e) {
			System.err.println("Error occurs during test data creating.....");
			e.printStackTrace();
		}
	}

}
