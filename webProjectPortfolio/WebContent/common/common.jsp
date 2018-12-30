<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String sessionId = "";
	String guest = "";
	if(sessionId != null){
		sessionId = (String)session.getAttribute("sessionId");
		session.setAttribute("guest",sessionId);
		
	}
	
	if(sessionId == null){
		guest = (String)session.getId();
		session.setAttribute("guest",guest);
	}
%>