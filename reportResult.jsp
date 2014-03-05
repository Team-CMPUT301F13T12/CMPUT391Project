
<html>
<title>Report Regeneration</title> 
<body> 
<H1><LEFT>Report Regeneration</LEFT></H1>


	Results for patients with 
		<%@ page import="java.sql.*, db.Database" %>
		<%
		Database db = new Database();
		db.connect();
		Connection conn = db.getConnection();
		Statement stmt = null;
        ResultSet rset = null;
    	String sql = "select * from persons";
    	try {
        	stmt = conn.createStatement();
	        rset = stmt.executeQuery(sql);
    	} catch(Exception e) {
	        out.println("<hr>" + e.getMessage() + "<hr>");
    	}
    	
    	while(rset != null && rset.next()) {
        	out.println(rset.getString(0));
        }
    	
		String iDiag = 	request.getParameter("DiagnosisInput");
		String iDate = 	request.getParameter("DateInput");
		out.print(iDiag);
		%>
	on
		<%
		out.print(iDate);
		%>
	:


<table border="1">
<tr> <th>Last Name</th> <th> First Name </th> <th>Address</th> <th>Phone Number</th> <th>Testing Date</th> </tr>
<tr> <td>Gates</td> <td> Bill </td> <td>555 Street</td> <td> 555 333 2345</td> <td>05-23-13</td> </tr>
<c:forEach var="row" items="${result.rows}">
<tr>
<td><c:out value="${row.last_name}"/></td>
<td><c:out value="${row.first_name}"/></td>
<td><c:out value="${row.address}"/></td>
<td><c:out value="${row.phone}"/></td>
<td><c:out value="${row.test_date}"/></td>
</tr>
</c:forEach>
</table> 
</body>
</html> 

<!-- SQL: 
select p.last_name, p.first_name, p.address, p.phone, r.test_date
from persons p, radiology_record r
where p.person_id = r.patient_id 
	AND [diagnosis] = r.diagnosis
	AND [date] = r.test_date
ORDER BY p.last_name
 -->