<%@ include file="aheader.jsp"%>
<style>
table {
    width: 100%;
    display:block;
  border: 1px solid black;
}
thead {
    display: inline-block;
    width: 100%;
    height: 100px;
}
tbody {
    height: 200px;
    display: inline-block;
    width: 100%;
    overflow: auto;
}
</style>

<%@ page  import="java.sql.*" import="CT.*" import="java.io.*" import="databaseconnection.*" import="java.util.*"%>
<table>
<%
	Connection con=databasecon.getconnection();
PreparedStatement ps=con.prepareStatement("delete from tweets");
ps.executeUpdate();
	
	int i=0;
	String stt2=request.getParameter("st1");
	session.setAttribute("words",stt2);
	String topic=(String)session.getAttribute("topic");
	String[] words=stt2.split(";");
	Vector<String> v=new Vector<String>();


for(String word: words){
	v=SearchTweets.main(word.trim());

%>
<table>
<tr><th><h1><%=word%>
<%
for(String s: v){
	%>
	<tr><td><%=s%>

	<%
}
%>
</table>
<br><br>
<%
}
%>
<form method="post" action="topic5.jsp">
	<input type="submit" value="User Duplicate Filter">
</form>
<%@ include file="footer.jsp"%>
