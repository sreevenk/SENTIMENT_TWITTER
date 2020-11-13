<%@ include file="aheader.jsp"%>
<%@ page  import="java.sql.*" import="databaseconnection.*" import="javax.swing.JOptionPane"%>




<%
int count=1;
Connection con1=databasecon.getconnection();
//System.out.println(con1);
	Statement st = con1.createStatement();
	ResultSet rs=st.executeQuery("select * from topic");
%>	
<h1>

<font size="" color="#66cc66"><b>Enter New Topic </h1></h2></font>
                  <%
                                                       String message=request.getParameter("m");
                                                       if(message!=null && message.equalsIgnoreCase("fail"))
                                                       {
                                                               out.println("<font color='red'><blink>You Entered String is dupicate</blink></font>");
                                                       }
                                               %>


<form method="post" action="topic4.jsp">
	
<table>
<tr><td><h3>Topic: <%=session.getAttribute("topic")%>
<tr><td><input type="text" name="st1" size="40" required placeholder="Enter Topic words, use ; for multiple words"><input type="submit" value="   Next  ">


                                              
											 
</table></table>
</form>
<br><br><br><br><br><br><br>
<%@ include file="footer.jsp"%>
