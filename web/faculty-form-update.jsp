<%-- 
    Document   : faculty-form-update
    Created on : 25-Jul-2023, 2:17:11 pm
    Author     : manikanta
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="org.apache.commons.io.IOUtils" %>
<%@ page import="java.util.Random" %>
<%@ page import="java.nio.charset.StandardCharsets" %>


<%
    Connection con = null;
    PreparedStatement ps = null;
    FileInputStream input=null;
    try {
        String url = "jdbc:mysql://localhost:3306/codebook";
        String username = "root";
        String dbpassword = "";
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(url, username, dbpassword);
        
        String userid = request.getParameter("userid");
        String firstname = request.getParameter("firstname");
        String date = request.getParameter("date");
        String email = request.getParameter("email");
        String city = request.getParameter("city");
        String phone = request.getParameter("phone");
       
        
       
        String query = "UPDATE facultyd SET userid=?, firstname=?, date=?, email=?, city=?, phone=? WHERE userid=?";
        ps = con.prepareStatement(query);
        ps.setString(1, userid);
        ps.setString(2, firstname);
        ps.setString(3, date);
        ps.setString(4, email);
        ps.setString(5, city);
        ps.setString(6, phone);
        
        ps.setString(7, userid);
        
        int rowsAffected = ps.executeUpdate();
        if (rowsAffected > 0) {
        request.getSession().setAttribute("updateSuccessMessage", " Details updated successfully.");
            response.sendRedirect("faculty-my-profile.jsp");
        } else {
            out.println("Failed to update data");
        }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        if (ps != null) {
            try {
                ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (con != null) {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>