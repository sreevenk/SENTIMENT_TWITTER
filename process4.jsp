<%@ include file="aheader.jsp"%>
<%@ page  import="java.sql.*"  import="java.util.*"  import="java.io.*" import="databaseconnection.*" import="CT.*" import="javax.swing.JOptionPane"%>
<%
String key=null;
String line=null;
String res=null;
String[] words=null;
BufferedReader bw=null; 
File f =null;
System.out.println("--------------------------------------");
Connection con1=databasecon.getconnection();
	Statement st2 = con1.createStatement();
%>

<style>
table {
    width: 100%;
    display:block;
	border: 1;
}
thead {
    display: inline-block;
    width: 100%;
    height: 420px;
} 
tbody {
    height: 800px;
    display: inline-block;
    width: 100%;
    overflow: auto;
}
</style>

<%
 Vector<String> set =new Vector<String>();
 set=(Vector)session.getAttribute("set");
  Vector<String> sno = (Vector)session.getAttribute("sno");
 double pos=0.0;
 double neg=0.0;
String[] ws=null;
String pathToSWN = "D://Apache Software Foundation//Tomcat 8.0//webapps//Sentiment//Dataset//SentiWordNet_3.0.0_20130122.txt";
SentiWordNetDemoCode sentiwordnet = new SentiWordNetDemoCode(pathToSWN);
	
%>
<h1> </h1>
<table border cellpadding="10" align="center" >
<%
String ss="";
//	for(String ss:set){
for(int j=0;j<set.size();j++){
	ss=set.get(j);

pos=0.0;
neg=0.0;

%>
<tr><th bgcolor="#838383">Tweet<th  bgcolor="#838383">Words

<tr><td width="30%"><%=ss%>

<td><%
ws=ss.split("\\s+");
for(String s:ws)
	out.println("["+s+"]");
%>
<tr><th>SentiWords<th>Sentiment Score

<tr><td>

<%
%><u><font size="" color="#ffff00"></font></u><br><%
ws=ss.split("\\s+");
for (String ngram : ws){

	       out.println(ngram);
try{
		pos=pos+(Double)sentiwordnet.posextract(ngram);
		   out.println("<font color=#92f94d>["+sentiwordnet.posextract(ngram)+"] </font>");
		   }
		   catch(Exception e){
			   //out.println("<font  color=#92f94d>[0.0]</font>");
			   } 
		   try{
			   neg=neg+(Double)sentiwordnet.negextract(ngram);
  
			   out.println("<font color=#f81638>["+sentiwordnet.negextract(ngram)+"] </font>");
			   }  catch(Exception e){
				   }


%>
<%

		   }
		%>
		<td>
		<%   
out.println("<br>");
out.println("<br> <b><font color=#92f94d>Possitive Score= "+pos+"");
out.println("<br> <font color=#f81638>Negative Score= "+neg+"</b></font>");

		   out.println("<br>");



try{
	if(pos>neg){
res="Positive";
}if(pos<neg){
	res="Negative";
}if(pos==neg){
res="Neutral";
}


//System.out.println("update tweets  set pos='"+pos+"' , neg='"+neg+"',result='"+res+"' where sno='"+sno.get(j)+"' ");
st2.executeUpdate("update tweets  set pos='"+pos+"' , neg='"+neg+"', result='"+res+"' where sno='"+sno.get(j)+"' ");
}catch(Exception e){
System.out.println(e);
}
}
%>

</table>
<br><br>
<form method="post" action="process7.jsp">
	<input type="submit" value="Next">
</form>
<br>                                          
<br>                                          
<br>                                          
<br>
<%@ include file="footer.jsp"%>
