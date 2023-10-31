<%-- 
    Document   : faculty-image-upload
    Created on : 25-Jul-2023, 2:08:59 pm
    Author     : manikanta
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%@ page import="java.util.Random" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page import="org.apache.commons.io.IOUtils" %>



<%
    Connection con = null;
    PreparedStatement ps = null;
    FileInputStream input = null;
    try {
        String url = "jdbc:mysql://localhost:3306/codebook";
        String username = "root";
        String dbpassword = "";
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(url, username, dbpassword);

        String userid = request.getParameter("userid");
        Part imagePart = request.getPart("imageData");

        if (imagePart != null && imagePart.getSize() > 0) {
            InputStream imageInputStream = imagePart.getInputStream();
            byte[] imageData = IOUtils.toByteArray(imageInputStream);

            String query = "UPDATE facultyd SET image=? WHERE userid=?";
            ps = con.prepareStatement(query);
            ps.setBytes(1, imageData);
            ps.setString(2, userid);

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
               // request.getSession().setAttribute("updateSuccessMessage", "Image updated successfully.");
                response.sendRedirect("faculty-my-profile.jsp");
            } else {
                out.println("Failed to update image");
            }
        } else {
            out.println("No image selected for upload");
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





org.apache.jasper.JasperException: Unable to compile class for JSP: 

An error occurred at line: [31] in the jsp file: [/faculty-image-upload.jsp]
IOUtils cannot be resolved
28: 
29:         if (imagePart != null && imagePart.getSize() > 0) {
30:             InputStream imageInputStream = imagePart.getInputStream();
31:             byte[] imageData = IOUtils.toByteArray(imageInputStream);
32: 
33:             String query = "UPDATE facultyd SET image=? WHERE userid=?";
34:             ps = con.prepareStatement(query);
