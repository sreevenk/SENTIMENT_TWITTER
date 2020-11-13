
<%@ include file="header.jsp"%>
<font size="+1">
<h1><font align="center" size="" color="#ff9900">Admin Page</h1></font><br>

<form method="post" action="alogin.jsp">
	<table align=left width="50%"><tr><td>
	<tr><td><div class="input-group input-group-lg">
				<span class="input-group-addon"  id="sizing-addon1">ID</span>
				<input type="text" name ="uid" required class="form-control" placeholder="Username" aria-describedby="sizing-addon1"></div>


		<tr><td><div class="input-group input-group-lg">
				<span class="input-group-addon" id="sizing-addon1">***</span>
				<input type="password" name ="pwd" required	  class="form-control" placeholder="Password" aria-describedby="sizing-addon1"></div>

			<tr><td>		<span class="input-group-btn">
							<button  class="btn btn-default" type="submit">Login</button>
						</span>
<td>

</tr>
</table>

					<table align=right ><tr><td><td>
	                  <%
                                                       String m=request.getParameter("id");
                                                       if(m!=null && m.equalsIgnoreCase("fail"))
                                                       {
                                                               out.println("<font  color='red'><blink><h3>&nbsp;&nbsp;&nbsp;Login Fail   !! </blink></font></h3>");
                                                       }
                                               %>
											   </table>

</form>
				
											   <br><br><br><br>
											  



<%@ include file="footer.jsp"%>