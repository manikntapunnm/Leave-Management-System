

<%--
    Document   : faculty-login-action
    Created on : 27-Jun-2023, 5:25:58 pm
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
    <title>JSP Page</title>
</head>
<body>
<%
    String userid = request.getParameter("userid");
    String pass = request.getParameter("password");
    out.println(userid);
    out.println(pass);

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/codebook", "root", "");
        ps = con.prepareStatement("SELECT * FROM facultyd WHERE userid=? AND password=?");
        ps.setString(1, userid);
        ps.setString(2, pass);
        rs = ps.executeQuery();

        if (rs.next()) {

            // Retrieve the firstname value from the result set
            String firstname = rs.getString("firstname");
            session.setAttribute("firstname", firstname);
            

            String category = rs.getString("category");
            session.setAttribute("category", category);

            String userid2 = rs.getString("userid");
            session.setAttribute("userid", userid2);
            
                       

            if (category.equals("HOD")) {
                // Redirect to HOD login page
                response.sendRedirect("hod-dashboard.jsp");
                return; // Add this line to prevent further execution of the code
            }

            response.sendRedirect("faculty-dashboard.jsp");
        } else {
            response.sendRedirect("faculty-login.jsp");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        response.sendRedirect("");
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        response.sendRedirect("");
    } finally {
        try {
            if (rs != null) {
                rs.close();
            }
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
