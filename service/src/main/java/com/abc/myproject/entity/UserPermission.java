package com.abc.myproject.entity;

import java.io.Serializable;

public class UserPermission implements Serializable {

    private static final long serialVersionUID = -8138151234273815905L;

    private Long              userId;

    private String            node;

    private String            action;

    private String            instance;

    public UserPermission() {
    }

    // public UserPermission(Long userId, String permission) {
    // this.userId = userId;
    // this.permission = permission;
    // }

    public UserPermission(Long userId, String node, String action, String instance) {
        this.userId = userId;
        this.node = node;
        this.action = action;
        this.instance = instance;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getNode() {
        return node;
    }

    public void setNode(String node) {
        this.node = node;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getInstance() {
        return instance;
    }

    public void setInstance(String instance) {
        this.instance = instance;
    }

}
