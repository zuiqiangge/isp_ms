<%@ page language="java"  pageEncoding="ISO-8859-1"%><%
if(request.getRemoteHost().equals("127.0.0.1")
	||request.getRemoteHost().equals("localhost")
){
	request.getRequestDispatcher("WEB-INF/jsp/"+request.getParameter("path")).forward(request,response);
}else{
	response.sendError(404,"不是localhost，没有这个jsp");
}
%>