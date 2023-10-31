<%-- 
    Document   : remove-employee
    Created on : 29-Jun-2023, 2:14:40 am
    Author     : manikanta
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    Connection con = null;
    Statement st = null;

    String id = request.getParameter("id");
    
    try {
        String url = "jdbc:mysql://localhost:3306/codebook";
        String username = "root";
        String dbpassword = "";
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(url, username, dbpassword);
        st = con.createStatement();
        
        int rowsAffected = st.executeUpdate("DELETE FROM facultyd WHERE id='" + id + "'");
        
        if (rowsAffected > 0) {
        
        request.getSession().setAttribute("removeSuccessMessage", "User ID removed successfully.");
            response.sendRedirect("admin-employee-list.jsp");
        } else {
            response.sendRedirect("admin-emploee-list.jsp");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("index.jsp?msg=invalid");
    } finally {
        // Close the resources in the reverse order of their creation
        if (st != null) {
            st.close();
        }
        if (con != null) {
            con.close();
        }
    }
%>
