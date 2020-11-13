
<%@ page import="CT.*" %>

<%

	int pos=Integer.parseInt(request.getParameter("pos"));

	int neg=Integer.parseInt(request.getParameter("neg"));

	int nue=Integer.parseInt(request.getParameter("nue"));

	PieChart.main(pos,neg,nue);

%>
<center><img src="PieChart.jpeg" width="640" height="480" border="0" alt="">
</center>