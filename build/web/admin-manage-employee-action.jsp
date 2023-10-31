<%-- 
    Document   : admin-manage-employee-action
    Created on : 29-Jun-2023, 12:44:23 am
    Author     : manikanta

--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.net.URLEncoder" %>

<!Doctype html>

<html>
    
    <head>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.all.min.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/sweetalert/dist/sweetalert.css">
        
    </head>
    
    <body>
        
  
<%
    Connection con = null;
    Statement st = null;
    
    String id = request.getParameter("id");
    String firstname = request.getParameter("firstname");
    String category = request.getParameter("category");
    String phone = request.getParameter("phone");
    String email = request.getParameter("email");
    String city = request.getParameter("city");
    


    
    try {
        String url = "jdbc:mysql://localhost:3306/codebook";
        String username = "root";
        String dbpassword = "";
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(url, username, dbpassword);
        st = con.createStatement();
        PreparedStatement ps = con.prepareStatement("update facultyd set firstname=?, category=?, phone=?, email=?, city=? where id=?");

        ps.setString(1, firstname);
        ps.setString(2, category);
        ps.setString(3, phone);
        ps.setString(4, email);
        ps.setString(5, city);
         ps.setString(6, id);
        ps.executeUpdate();
     
        
        
        
        
        
        
    String updatedDetails = "Employee details updated successfully";
    // Set the success message in a session attribute
   // session.setAttribute("successMessage", updatedDetails);
    
    
    
    
   // response.sendRedirect("admin-employee-list.jsp?successMessage=" + URLEncoder.encode(updatedDetails, "UTF-8"));
    
    request.getSession().setAttribute("updateSuccessMessage", "Employee details updated successfully.");
        response.sendRedirect("admin-employee-list.jsp");
        
     
        
      
        
        
        
        
        
    } catch (Exception e) {
        e.printStackTrace();
       response.sendRedirect("admin-employee-list.jsp");
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
  </body>
</html>

