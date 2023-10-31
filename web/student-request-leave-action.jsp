

<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    
    String firstname = (String) session.getAttribute("firstname");
    String start = request.getParameter("start");
    String end = request.getParameter("end");
    String reason = request.getParameter("reason");
    String category = (String) session.getAttribute("category");
    String userid = (String) session.getAttribute("userid");
   // String branch = (String) session.getAttribute("branch");
    
     // Retrieve first name from session

    Connection conn = null;
    PreparedStatement ps = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/codebook", "root", "");
        String sql = "INSERT INTO leaves (firstname, start, end, reason, category,userid, action ) VALUES (?, ?, ?, ?, ?, ?, ?)";
        ps = conn.prepareStatement(sql);
        ps.setString(1, firstname);
        ps.setString(2, start);
        ps.setString(3, end);
        ps.setString(4, reason);
        ps.setString(5, "Student");
         ps.setString(6, userid);
        ps.setString(7,"Pending");
        //ps.setString(6, );
        //ps.setString(6, "student");
        
        
        int rowsAffected = ps.executeUpdate();
        if (rowsAffected > 0) {
        String leaveSuccessMessage = "Leave submitted successfully."; // You can set any custom message here
request.getSession().setAttribute("leaveSuccessMessage", leaveSuccessMessage);

            //out.println("<p>Leave request submitted successfully.</p>");
            response.sendRedirect("student-status.jsp");
        } else {
           // out.println("<p>Error: Failed to submit leave request.</p>");
           response.sendRedirect("student-request-leave.jsp");
        }
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        out.println("<p>Error: Database driver not found.</p>");
    } catch (SQLException e) {
        e.printStackTrace();
       // out.println("<p>Error: Failed to connect to the database.</p>");
       out.println("<p>Error: Failed to connect to the database. Reason: " + e.getMessage() + "</p>");
    } finally {
        try {
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
