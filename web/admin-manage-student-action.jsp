<%-- 
    Document   : admin-manage-student-action
    Created on : 29-Jun-2023, 12:16:00 pm
    Author     : manikanta



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    Connection con = null;
    Statement st = null;
    
    String id = request.getParameter("id");
    String firstname = request.getParameter("firstname");
    String branch = request.getParameter("branch");
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
        PreparedStatement ps = con.prepareStatement("update studentd set firstname=?, category=?, phone=?, email=?, city=? where id=?");

        ps.setString(1, firstname);
        ps.setString(2, branch);
        ps.setString(3, phone);
        ps.setString(4, email);
        ps.setString(5, city);
         ps.setString(6, id);
        ps.executeUpdate();
        
        
        response.sendRedirect("admin-student-list.jsp");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("admin-student-list.jsp");
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



--%>


<%-- 
    Document   : admin-manage-employee-action
    Created on : 29-Jun-2023, 12:44:23 am
    Author     : manikanta

--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    Connection con = null;
    Statement st = null;
    
    String id = request.getParameter("id");
    String firstname = request.getParameter("firstname");
    String branch = request.getParameter("branch");
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
        PreparedStatement ps = con.prepareStatement("update studentd set firstname=?, branch=?, phone=?, email=?, city=? where id=?");

        ps.setString(1, firstname);
        ps.setString(2, branch);
        ps.setString(3, phone);
        ps.setString(4, email);
        ps.setString(5, city);
         ps.setString(6, id);
        ps.executeUpdate();
        
         request.getSession().setAttribute("updateSuccessMessage", "Employee details updated successfully.");
        response.sendRedirect("admin-student-list.jsp");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("admin-student-list.jsp");
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
