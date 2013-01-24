package com.abc.myproject.constant;

public enum NodePermission {
    ALL("*");

    private String name;

    private NodePermission(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public static NodePermission valueOfName(String name) {
        for (NodePermission e : NodePermission.values()) {
            if (e.getName().equals(name)) {
                return e;
            }
        }
        return null;
    }

    public static void main(String[] args) {
        System.out.print(NodePermission.valueOfName("*"));
    }
}
