<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
 <link rel="stylesheet" type="text/css" href="reg.css">
  <link rel="stylesheet" type="text/css" href="login.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CustomerCancelRes</title>
</head>
<body>
<a class="login100-form-title" href="index.html">Home</a>
<br>
<br>
<br>
<br>
<br>
<br>
 <div class="container wrap-input100" align="center">

<%									  
		try {

			//Create a connection string
				String url = "jdbc:mysql://cs336.ctrr9ro7iyao.us-east-2.rds.amazonaws.com:3306/cs336";
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver");

			//Create a connection to your DB
			Connection con = DriverManager.getConnection(url, "admin", "administrator");
					
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			String res = request.getParameter("Reservation");
			//Cancel the reservation
			Statement stmtdel = con.createStatement();
			
			String strdel = "DELETE FROM Passenger WHERE resNo=\""+res+"\";";
			stmtdel.executeUpdate(strdel);
			
			
			strdel = "DELETE FROM Leg WHERE Res_No=\""+res+"\";";
			stmtdel.executeUpdate(strdel);
			

			strdel = "DELETE FROM Reservation WHERE Res_No=\""+res+"\";";
			stmtdel.executeUpdate(strdel);
		
			//close the connection.
			con.close();
			
			out.print("Reservation number "+res+" has been cancelled");
			
		} catch (Exception e) {
			out.print("ERROR: Cancellation failed");
			e.printStackTrace(new java.io.PrintWriter(out));
		}

%>


<a href="Logout.jsp" class="login100-form-btn wrap-input100 m-b-16" style="width:350px">Logout</a>

<a href="CustomerResPort.jsp"class="login100-form-btn wrap-input100 m-b-16"style="width:350px">Back</a>
</div>

</body>
</html>