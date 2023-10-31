<%-- 
    Document   : admin-action
    Created on : 24-Jun-2023, 11:49:44 am
    Author     : manikanta
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Action</title>
</head>
<body>
<%
    String n = request.getParameter("username");
    String p = request.getParameter("password");
            
    Connection con = null;
    PreparedStatement ps = null;
            
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/codebook", "root", "");
        ps = con.prepareStatement("SELECT * FROM adminlogin WHERE username=? AND password=?");
        ps.setString(1, n);
        ps.setString(2, p);
        ResultSet rs = ps.executeQuery();
                
        if (rs.next()) {
            response.sendRedirect("admin-dashboard.jsp");
        } else {
            response.sendRedirect("admin-login.jsp");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("Database Error: " + e.getMessage());
        //response.sendRedirect("error.jsp");
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        out.println("Class Not Found Error: " + e.getMessage());
        //response.sendRedirect("error.jsp");
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Unknown Error: " + e.getMessage());
        //response.sendRedirect("error.jsp");
    } finally {
        try {
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
%>      
</body>
</html>
