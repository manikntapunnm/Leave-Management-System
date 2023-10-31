
<%--
    Document   : faculty-leave-request-action
    Created on : 30-Jun-2023, 5:48:48 pm
    Author     : manikanta

--%>

<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    String userid = (String) session.getAttribute("userid");
    String firstName = (String) session.getAttribute("firstname");
    String start = request.getParameter("start");
    String end = request.getParameter("end");
    String reason = request.getParameter("reason");
    String category = (String) session.getAttribute("category");
    
  
    Connection conn = null;
    PreparedStatement ps = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/codebook", "root", "");
        String sql = "INSERT INTO leaves (userid,firstname, start, end, reason, category, action ) VALUES (?, ?, ?, ?, ?, ?, ?)";
        ps = conn.prepareStatement(sql);
        ps.setString(1, userid);
        ps.setString(2, firstName);
        ps.setString(3, start);
        ps.setString(4, end);
        ps.setString(5, reason);
        ps.setString(6, category);
        ps.setString(7, "Pending");
        
       // ps.setString(6, "faculty");
        
       // request.getSession().setAttribute("leaveSuccessMessage", "Leave submitted successfully.");
        int rowsAffected = ps.executeUpdate();
        if (rowsAffected > 0) {
            String leaveSuccessMessage = "Leave submitted successfully."; // You can set any custom message here
request.getSession().setAttribute("leaveSuccessMessage", leaveSuccessMessage);
            response.sendRedirect("hod-status.jsp");
        } else {
           response.sendRedirect("hod-request-leave.jsp");
            //out.println("<p>Error: Failed to submit leave request.</p>");
        }
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        out.println("<p>Error: Database driver not found.</p>");
    } catch (SQLException e) {
        e.printStackTrace();
        //out.println("<p>Error: Failed to connect to the database.</p>");
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

<%--


// out.println("<p>Leave request submitted successfully.</p>");
          String leaveSuccessMessage = "Leave submitted successfully."; // You can set any custom message here
request.getSession().setAttribute("leaveSuccessMessage", leaveSuccessMessage);

// Debug statement to verify the value being set for the attribute
out.println("leaveSuccessMessage: " + leaveSuccessMessage);
--%>
