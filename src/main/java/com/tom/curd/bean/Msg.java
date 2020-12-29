package com.tom.curd.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * 通用的响应给客户端的数据封装类
 * @author totian
 *
 */
public class Msg {
	
	//自定义状态码，比如200成功，100失败
	private int code;
	//提示信息
	private String msg;
	//用户要的返回给客户端的信息
	private Map<String, Object> extend= new HashMap();
	
	public static Msg success(){
		Msg msg = new Msg();
		msg.setCode(200);
		msg.setMsg("处理成功！");
		
		return msg;
	}
	
	public static Msg fail(){
		Msg msg = new Msg();
		msg.setCode(100);
		msg.setMsg("处理失败！");
		
		return msg;
	}
	
	public Msg add(String key, Object value){
		extend.put(key, value);
		return this;
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Map<String, Object> getExtend() {
		return extend;
	}

	public void setExtend(Map<String, Object> extend) {
		this.extend = extend;
	}
	
	
	
}
