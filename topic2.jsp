<%@ page  import="java.sql.*" import="java.io.*" import="databaseconnection.*" import="javax.swing.JOptionPane"%>

<%
int i=0;
String st1=request.getParameter("st1");
session.setAttribute("topic",st1);
%>
<%

Connection con1=databasecon.getconnection();
//System.out.println(con1);

	Statement st = con1.createStatement();
	try{
	i=st.executeUpdate("insert into topic(topic) values('"+st1+"')");
			response.sendRedirect("topic3.jsp");
	}
	catch(Exception e)
	{
		System.out.println(e);
		response.sendRedirect("topic.jsp?m=fail");
		return;
	}
	

%>	
<%@ include file="footer.jsp"%>
