package com.abc.myproject.constant;

public enum ErrorCode {
    NOT_FOUND(404, "Resouce not found"),
    SERVER_ERROR(505, "Server execption");

    private final int    code;

    private final String message;

    private final byte[] bytes;

    private ErrorCode(int code, String message) {
        this.code = code;
        this.message = message;
        bytes = (code + " " + message).getBytes();
    }

    public int getCode() {
        return code;
    }

    public String getMessage() {
        return message;
    }

    public byte[] getBytes() {
        return bytes;
    }

    @Override
    public String toString() {
        return String.format("[%04d %s]", this.code, this.getMessage());
    }

}
