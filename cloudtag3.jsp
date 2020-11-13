<%@ page  import="java.sql.*"   import="java.io.*" import="databaseconnection.*" import="details.*"  import="javax.swing.JOptionPane"%>


<%
try{
File f=new File("tagdata/out.png");
FileInputStream fis=new FileInputStream(f);

Connection con = databasecon.getconnection();
Statement st3=con.createStatement();
st3.executeUpdate("delete from temp");

PreparedStatement pst=con.prepareStatement("insert into temp(tag_img) values(?)");
pst.setBinaryStream(1,(InputStream)fis,(int)(f.length()));
int i=pst.executeUpdate();
//response.sendRedirect("cloudtag3.jsp");
}catch(Exception E){
System.out.println(E);
}%>
<table align="center">
<tr>
	<td ><img src="view1.jsp" border="0" alt="" width="850" height="580" ></td>
	<td>
	
	</td>
</tr>
</table>
