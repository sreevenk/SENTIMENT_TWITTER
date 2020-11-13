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
    height: 500px;
}
tbody {
    height: 500px;
    display: inline-block;
    width: 100%;
    overflow: auto;
}
</style>

<%@ page  import="java.sql.*" import="CT.*" import="java.io.*" import="databaseconnection.*" import="java.util.*"%>
<table>
<%

	int i=0;
	String stt2=(String)session.getAttribute("words");
	String topic=(String)session.getAttribute("topic");
	String[] words=stt2.split(";");
	Vector<String> v=new Vector<String>();

	Connection con=databasecon.getconnection();
	Statement st=con.createStatement();
	Statement st2=con.createStatement();
	
for(String word: words){

%>
<table>
<tr><th><h1><%=word%>
<tr><th bgcolor="#838383">Sno<th  bgcolor="#838383">User<th  bgcolor="#838383">Tweet

<%
String line="";
 double pos=0.0;
 double neg=0.0;
 String res="";
String[] ws=null;
String pathToSWN = "D://Apache Software Foundation//Tomcat 8.0//webapps//Sentiment//Dataset//SentiWordNet_3.0.0_20130122.txt";
SentiWordNetDemoCode sentiwordnet = new SentiWordNetDemoCode(pathToSWN);

//System.out.println("select * from tweets where topic='"+word.trim()+"' ");
ResultSet rs=st.executeQuery("select * from tweets where topic='"+word.trim()+"'  order by sno");

while(rs.next()){
%>
	<tr><td><%=rs.getString(1)%>) <td> <%=rs.getString(3)%><td>  <%=rs.getString(4)%>

<%
		line=rs.getString(4).trim();
	line=line.toLowerCase();
		line=line.replace(".","");
		line=line.replace(",","");
		line=line.replace("|","");
		line=line.replace("!","");
		line=line.replace("#","");
		line=line.replace("@","");
		line=line.replace("*","");
		line=line.replace(":","");
		line=line.replace("?","");
		line=line.replace("/","");
		line=line.replace(";","");

pos=0.0;
neg=0.0;

ws=line.split("\\s+");
for(String w:ws){

		try{pos=pos+(Double)sentiwordnet.posextract(w);}catch(Exception e){}
			  try{neg=neg+(Double)sentiwordnet.negextract(w);}catch(Exception e){}

}
out.println("<tr><td><td><td><font color=#92f94d>Possitive Score= "+pos+"<BR>	");
out.println("<font color=#f81638>Negative Score= "+neg+"	");

try{
	if(pos>neg){
res="Positive";
}if(pos<neg){
	res="Negative";
}if(pos==neg){
res="Neutral";
}
st2.executeUpdate("update tweets  set pos='"+pos+"' , neg='"+neg+"', result='"+res+"' where sno='"+rs.getString(1)+"' and topic='"+rs.getString(2)+"' ");
out.println("<br><font color=#1474ba>Result = "+res+"	");

}
catch(Exception e){
System.out.println(e);
}
%>

	
	<%
}
%>
</table>
<br><br>
<%
}
%>
<form method="post" action="topic7.jsp">
	<input type="submit" value="Analysis">
</form>
<%@ include file="footer.jsp"%>
