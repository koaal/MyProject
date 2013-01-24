package com.abc.myproject.constant;


public enum ActionPermission {
	ALL("*"), VIEW("view"), EDIT("edit");

	private String name;

	private ActionPermission(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public static ActionPermission valueOfName(String name) {
		for (ActionPermission e : ActionPermission.values()) {
			if (e.getName().equals(name)) {
				return e;
			}
		}
		return null;
	}

	public static void main(String[] args) {
		System.out.print(ActionPermission.valueOfName("*"));
	}
}
