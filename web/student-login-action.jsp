<%-- 
    Document   : student-login-action
    Created on : 27-Jun-2023, 5:49:55 pm
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
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/codebook","root","");
                ps = con.prepareStatement("SELECT * FROM studentd WHERE userid=? AND password=?");
                ps.setString(1, userid);
                ps.setString(2, pass);
                rs = ps.executeQuery();
                
                if (rs.next()) {
                
                            String firstname = rs.getString("firstname");
                           session.setAttribute("firstname", firstname);
                       //System.out.println("FirstName: " + firstname);
                       
                       
                       
                       String userid2 = rs.getString("userid");
           // System.out.println("Category: " + category);
            session.setAttribute("userid", userid2);

            String branch = rs.getString("branch");
            session.setAttribute("branch", branch);
          //  System.out.println("Branch: " + branch);



                    response.sendRedirect("student-dashboard.jsp");
                } else {
                    response.sendRedirect("student-login.jsp");
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
