package com.abc.myproject.constant;

public enum Roles {
    ADMIN("admin");

    private String name;

    private Roles(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public static Roles valueOfName(String name) {
        for (Roles e : Roles.values()) {
            if (e.getName().equals(name)) {
                return e;
            }
        }
        return null;
    }

}
