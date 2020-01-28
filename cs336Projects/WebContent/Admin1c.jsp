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
<title>Admin1c</title>
</head>
<body>
	  			<a class="login100-form-title" href="Admin.jsp"> Admin Home</a>
<br>
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
					
			// Check user id
			if(request.getSession().getAttribute("userid") != null){
				//Create a SQL statement
				Statement stmt = con.createStatement();
				// Get userid
				String id = (String) request.getSession().getAttribute("userid");
				//Make a SELECT query from the Employee table
				String str = "SELECT * FROM Emp_Manager M WHERE M.ID = '" + id +"'";
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
				//Check the result
				if (!result.next() ) {
					//Employee is a Customer Rep
					response.sendRedirect("Cust_Rep.jsp");
					}
			}
			else {
				// send back to employee login page
				response.sendRedirect("EmployeeHome.jsp");
			}
			
			//Create a SQL statement
			Statement stmt = con.createStatement();

			//Get parameters from the HTML form at the Manager1.jsp
			String id = request.getParameter("id");

			//Check that ID is numeric and is not empty
			if(!id.matches("((-|\\+)?[0-9]+(\\.[0-9]+)?)+") || id.equals("")) {
				con.close();
				throw new IndexOutOfBoundsException("ERROR: Not a valid Employee ID. Please enter up to 12 numeric characters.");
			}
			//Make a SELECT query from the Employee table
			String str = "SELECT * FROM Employee WHERE ID_No = '" + id + "'";
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
				if (!result.next() ) {
					con.close();
					throw new IndexOutOfBoundsException("ERROR: Employee does not exist; enter a valid Employee ID");
				}
				
			// Check if employee is a manager or customer respresentative
			str = "SELECT * FROM Emp_Manager WHERE ID = '" + id + "'";
			result = stmt.executeQuery(str);
			
			// Delete from Emp_CustomerRep or Emp_Manager Table
			if (!result.next() ) {
				str = "DELETE FROM Emp_CustomerRep WHERE ID = '" + id + "'";
				stmt.executeUpdate(str);
			}else{
				str = "DELETE FROM Emp_Manager WHERE ID = '" + id + "'";
				stmt.executeUpdate(str);
			}
			// Delete from Employee Table
			str = "DELETE FROM Employee WHERE ID_No = '" + id + "'";
			stmt.executeUpdate(str);
			// Delete from Person Table
			str = "DELETE FROM Person WHERE ID_No = '" + id + "'";
			stmt.executeUpdate(str);
				
			//Close the connection.
			con.close();
			
			out.print("Delete Succeeded!");
		} catch (Exception e) {
			out.print("ERROR: Delete Failed");
			e.printStackTrace(new java.io.PrintWriter(out));
		}
%>
</div>
<div align="center">
<a href="Logout.jsp" class="login100-form-btn wrap-input100 m-b-16" style="width:350px">Logout</a>
</div>
<div align="center">
<a href="Admin1.jsp"class="login100-form-btn wrap-input100 m-b-16"style="width:350px">Back</a>
</div>
</body>
</html>