package com.abc.myproject.util;

import com.abc.myproject.entity.UserPermission;

public class PermissionUtil {

    public static final String semicolon = ";";

    public static final String colon     = ":";

    public static final String star      = "*";

    /**
     * convert permission string to entity
     * 
     * @param userId
     * @param permissionStr
     * @return
     */
    public static UserPermission fromPermissionStr(Long userId, String permissionStr) {
        if (permissionStr != null && permissionStr.indexOf(PermissionUtil.colon) > 0) {
            String[] splits = permissionStr.split(PermissionUtil.colon);
            return new UserPermission(userId, splits[0], splits[1], splits[2]);
        }
        return null;
    }

    /**
     * convert permission entity to string
     * 
     * @param permission
     * @return
     */
    public static String toPermissionStr(UserPermission permission) {
        StringBuilder permissonStr = new StringBuilder("");

        permissonStr.append(permission.getNode());
        permissonStr.append(PermissionUtil.colon);
        permissonStr.append(permission.getAction());
        permissonStr.append(PermissionUtil.colon);
        permissonStr.append(permission.getInstance());

        return permissonStr.toString();
    }

}
