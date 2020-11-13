<%@ page  import="java.sql.*"  import="java.io.*"  import="databaseconnection.*" import="CT.*" import="Tag.*" %>

<%
   String fileid=request.getParameter("fileid");

   //
   Occurance.main("D://Apache Software Foundation//Tomcat 8.0//Tweets//"+fileid);
   TagCloud.main();
   response.sendRedirect("cloudtag2.jsp");
%>
