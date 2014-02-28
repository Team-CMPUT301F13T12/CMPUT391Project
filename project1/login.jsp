<HTML>
<HEAD>


<TITLE>Radiology Information System Login</TITLE>
</HEAD>

<BODY>
<!--A simple example to demonstrate how to use JSP to 
    connect and query a database. 
    @author  Hong-Yu Zhang, University of Alberta
 -->
<%@ page import="java.sql.*" %>
<%
 
        if(request.getParameter("bSubmit") != null)
        {

	        //get the user input from the login page
        	String username = (request.getParameter("USERID")).trim();
	        String password = (request.getParameter("PASSWD")).trim();
        	//out.println("<p>Your input User Name is "+username+"</p>");
        	//out.println("<p>Your input password is "+password+"</p>");


	        //establish the connection to the underlying database
        	Connection conn = null;
	
	        String driverName = "oracle.jdbc.driver.OracleDriver";
            	String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";

   	        try{
		        //load and register the driver
        		Class drvClass = Class.forName(driverName); 
	        	DriverManager.registerDriver((Driver) drvClass.newInstance());
        	}
	        catch(Exception ex){
		        out.println("<hr>" + ex.getMessage() + "<hr>");
	
	        }
	
        	try{
	        	//establish the connection 
		        conn = DriverManager.getConnection(dbstring,"your_user_id","your_pass_word");
        		conn.setAutoCommit(false);
	        }
        	catch(Exception ex){
	        
		        out.println("<hr>" + ex.getMessage() + "<hr>");
        	}
	

	        //select the user table from the underlying db and validate the user name and password
        	Statement stmt = null;
	        ResultSet rset = null;
        	String sql = "select PWD from login where id = '"+username+"'";
	        out.println(sql);
        	try{
	        	stmt = conn.createStatement();
		        rset = stmt.executeQuery(sql);
        	}
	
	        catch(Exception ex){
		        out.println("<hr>" + ex.getMessage() + "<hr>");
        	}

	        String truepwd = "";
	
        	while(rset != null && rset.next())
	        	truepwd = (rset.getString(1)).trim();
	
        	//display the result
	        if(password.equals(truepwd))
		        out.println("<p><b>Your Login is Successful!</b></p>");
        	else
	        	out.println("<p><b>Either your username or Your password is inValid!</b></p>");

                try{
                        conn.close();
                }
                catch(Exception ex){
                        out.println("<hr>" + ex.getMessage() + "<hr>");
                }
        }
        else
        {
                out.println("<H1><LEFT>Radiology Information System Login</LEFT></H1>");
                out.println("<form method=post action=menu.jsp>");
                out.println("<table>");
                out.println("<tr><th>Username:</th>");
                out.println("<td><input type=text name=USERID maxlength=20></td></tr>");
                out.println("<tr><th>Password:</th>");
                out.println("<td><input type=password name=PASSWD maxlength=20></td></tr>");
                out.println("<tr><td><input type=submit name=bSubmit value=Submit></td></tr>");
                out.println("</table>");
                out.println("</form>");
        }      
%>



</BODY>
</HTML>

