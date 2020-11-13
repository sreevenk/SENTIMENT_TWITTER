<%@ page import="databaseconnection.*" %>

<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.awt.*" %>
<%@ page import="org.jfree.chart.ChartFactory" %>
<%@ page import="org.jfree.chart.ChartUtilities" %>
<%@ page import="org.jfree.chart.JFreeChart" %>
<%@ page import="org.jfree.chart.plot.PlotOrientation"%>
<%@ page import="org.jfree.data.*" %>
<%@ page import="org.jfree.data.jdbc.JDBCCategoryDataset"%>

<%
int c1=0, c2=0, c3=0;
try
{
Connection con = databasecon.getconnection();
Statement st=con.createStatement();



String query="SELECT count(*), pos, neg, nue, tot from analysis where topic='"+request.getParameter("topic")+"' and subtopic='"+request.getParameter("topic2")+"' ";

System.out.println(query);
JDBCCategoryDataset dataset=new JDBCCategoryDataset("jdbc:mysql://localhost:3306/sentiment_tweets","com.mysql.jdbc.Driver","root","root");

dataset.executeQuery( query);
JFreeChart chart = ChartFactory .createBarChart3D("EVALUATION GRAPH", "", "",dataset, PlotOrientation.VERTICAL, true, true, true);
                
ChartUtilities.saveChartAsJPEG(new File("D://Apache Software Foundation//Tomcat 8.0/webapps/Sentiment/images/logotype.jpg"), chart, 700, 300);
response.sendRedirect("graph2.jsp");
}
catch (Exception e)
{
System.out.println("Problem in creating chart."+e);
}
%>