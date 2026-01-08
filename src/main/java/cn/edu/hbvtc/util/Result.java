package cn.edu.hbvtc.util;

import java.io.Serializable;
/**
 * 统一 API 响应结果封装类
 */
public class Result<T> implements Serializable {

    private static final long serialVersionUID = 1L;

    // 响应状态码：200 成功，500 失败，400 参数错误等（可自定义）
    private int code;

    // 响应消息：如 "操作成功"、"学号已存在"
    private String message;

    // 响应数据：泛型，可返回任意对象（如 Student、List<Student>、分页数据等）
    private T data;

    private boolean success;

    // 私有构造器，防止外部直接 new
    private Result() {}
    // 成功：无数据，返回成功
    public static <T> Result<T> success(String message) {
        Result<T> result = new Result<>();
        result.success = true;
        result.code = 200;
        result.message = message;
        result.data = null;
        return result;
    }
    // 成功：无数据，返回成功
    public static <T> Result<T> success() {
        Result<T> result = new Result<>();
        result.success = true;
        result.code = 200;
        result.message = "操作成功";
        result.data = null;
        return result;
    }

//    // 失败：自定义状态码和消息
    public static <T> Result<T> error(String message) {
        Result<T> result = new Result<>();
        result.success = false;
//        result.code = code;
        result.message = message;
        return result;
    }

    // 自定义构建（高级用法）
    public static <T> Result<T> build(int code, String message, T data, boolean success) {
        Result<T> result = new Result<>();
        result.success = success;
        result.code = code;
        result.message = message;
        result.data = data;
        return result;
    }

    // ===== Getter / Setter =====

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    public boolean getSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }
}