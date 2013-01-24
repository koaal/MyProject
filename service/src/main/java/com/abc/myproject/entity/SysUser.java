package com.abc.myproject.entity;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

public class SysUser implements Serializable {

    private static final long    serialVersionUID = -8138151134273815905L;

    private Long                 id;

    private String               name;

    private String               password;

    private String               confirmPassword;

    private String               email;

    private String               mobile;

    private String               department;

    private String               address;

    private String               description;

    private String               role;

    private List<UserPermission> userPermissions  = Lists.newArrayList();

    private Map<String, String>  tsPermissions    = Maps.newHashMap();

    private Map<String, String>  edPermissions    = Maps.newHashMap();

    private Map<String, String>  rePermissions    = Maps.newHashMap();

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public List<UserPermission> getUserPermissions() {
        return userPermissions;
    }

    public void setUserPermissions(List<UserPermission> userPermissions) {
        this.userPermissions = userPermissions;
    }

    public Map<String, String> getTsPermissions() {

        return tsPermissions;
    }

    public Map<String, String> getEdPermissions() {

        return edPermissions;
    }


    public void setTsPermissions(Map<String, String> tsPermissions) {
        this.tsPermissions = tsPermissions;
    }

    public Map<String, String> getRePermissions() {
        return rePermissions;
    }

    public void setRePermissions(Map<String, String> rePermissions) {
        this.rePermissions = rePermissions;
    }

    public void setEdPermissions(Map<String, String> edPermissions) {
        this.edPermissions = edPermissions;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof SysUser){
            return this.id.equals(((SysUser)obj).getId());   
        }
        return false;
    }

    @Override
    public int hashCode() {
        return this.id.hashCode();
    }
}
