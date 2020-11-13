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

	int i=0;
		String topic=(String)session.getAttribute("topic");

	String stt2=(String)session.getAttribute("words");
	String[] words=stt2.split(";");
	
		Random randomGenerator = new Random();
		int fileid=0;
	




int pos=0,neg=0,nue=0;
	Connection con=databasecon.getconnection();
	Statement st=con.createStatement();
	

for(String word: words){
	fileid = randomGenerator.nextInt(200000);
ResultSet rs=st.executeQuery("select * from tweets where result='Positive' and topic='"+word.trim()+"' ");

	PrintWriter pw=new PrintWriter("Tweets//"+fileid+"pos");
while(rs.next()){
	//pw.println(rs.getString("tweet"));
		pw.println(StopWords.main(rs.getString("tweet")));
}
pw.close();
rs=st.executeQuery("select * from tweets where result='Negative' and topic='"+word.trim()+"' ");
	 pw=new PrintWriter("Tweets//"+fileid+"neg");
while(rs.next()){
	pw.println(rs.getString("tweet"));
}
pw.close();
rs=st.executeQuery("select * from tweets where result='Neutral' and topic='"+word.trim()+"' ");
	 pw=new PrintWriter("Tweets//"+fileid+"neu");
while(rs.next()){
	pw.println(rs.getString("tweet"));
}
pw.close();

//System.out.println("select * from tweets where topic='"+word.trim()+"' ");
 rs=st.executeQuery("select count(*)  from tweets where topic='"+word.trim()+"' and result='Positive'  ");

if(rs.next())
	pos=rs.getInt(1);

rs=st.executeQuery("select count(*)  from tweets where topic='"+word.trim()+"' and result='Negative'  ");

if(rs.next())
	neg=rs.getInt(1);

rs=st.executeQuery("select count(*)  from tweets where topic='"+word.trim()+"' and result='Neutral'  ");

if(rs.next())
	nue=rs.getInt(1);

%>
	<tr><td><%=topic%><td><%=word%> <td> <%=pos%><td>  <%=neg%><td>  <%=nue%><td>  <%=(pos+neg+nue)%><td>
	<a href="#" onclick="window.open('graph.jsp?topic=<%=topic%>&&topic2=<%=word.trim()%>', 'newwindow', 'width=750, height=550'); return false;">Graph</a> 

<%
try{
st.executeUpdate("insert into analysis values ('"+topic+"','"+word.trim()+"','"+(pos+neg+nue)+"', '"+pos+"', '"+neg+"', '"+nue+"' , '"+fileid+"' ) ");
}catch(Exception e){
}

}
%>
</table>
<br><br>

<%@ include file="footer.jsp"%>
