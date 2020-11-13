<%@ include file="aheader.jsp"%>
		  <head>
<style>
table, th, td {
  border: 1px solid black;
}
th, td {
    padding: 15px;
    text-align: left;
}
</style>
</head>

<h1>Analysis</h1>
<%@ page  import="java.sql.*" import="CT.*" import="java.io.*" import="databaseconnection.*" import="java.util.*"%>

<table width="100%">
<tr ><th bgcolor="#838383">Topic<th  bgcolor="#838383">Sub Topic<th  bgcolor="#838383">Pos Score<th  bgcolor="#838383">Neg Score<th  bgcolor="#838383">Nue Score<th  bgcolor="#838383">Total Tweets <th  bgcolor="#838383">Graph

<%

int pos=0,neg=0,nue=0;
	Connection con=databasecon.getconnection();
	Statement st=con.createStatement();
ResultSet rs=st.executeQuery("select *  from analysis ");
while(rs.next()){
%>
	<tr><td><%=rs.getString(1)%><td><%=rs.getString(2)%>
	<td>
	<!-- <a href="#" onclick="window.open('cloudtag.jsp?fileid=<%=rs.getString("fileid")%>pos', 'newwindow', 'width=750, height=550'); return false;"><%=rs.getString("pos")%></a> -->

	<a href="cloudtag.jsp?fileid=<%=rs.getString("fileid")%>pos" target="_blank"><%=rs.getString("pos")%></a>




	<td>
	<a href="cloudtag.jsp?fileid=<%=rs.getString("fileid")%>neg" target="_blank"><%=rs.getString("neg")%></a>

	
	<td><a href="cloudtag.jsp?fileid=<%=rs.getString("fileid")%>nue" target="_blank"><%=rs.getString("nue")%></a>

	
	<td><%=rs.getString("tot")%><td>
	<a href="#" onclick="window.open('piegraph.jsp?pos=<%=rs.getString("pos")%>&&neg=<%=rs.getString("neg")%>&&nue=<%=rs.getString("nue")%>', 'newwindow', 'width=750, height=550'); return false;">Graph</a> 
<%
}
%>
</table>
<br><br>

<%@ include file="footer.jsp"%>
