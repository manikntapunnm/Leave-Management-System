<%--
    Document   : faculty-leave-request-action
    Created on : 30-Jun-2023, 5:48:48 pm
    Author     : manikanta
--%>


<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>



<%
    
    String firstName = (String) session.getAttribute("firstname");
    String start = request.getParameter("start");
    String end = request.getParameter("end");
    String reason = request.getParameter("reason");
    //String image = request.getParameter("image");
    String category = (String) session.getAttribute("category");
    String userid = (String) session.getAttribute("userid");
    
  
    
   
    
    Connection conn = null;
    PreparedStatement ps = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/codebook", "root", "");
        String sql = "INSERT INTO leaves (firstname, start, end, reason, category, userid, action ) VALUES (?, ?, ?, ?, ?, ?, ?)";
        ps = conn.prepareStatement(sql);
        ps.setString(1, firstName);
        ps.setString(2, start);
        ps.setString(3, end);
        ps.setString(4, reason);
        ps.setString(5, category);
        ps.setString(6, userid);
        ps.setString(7,"Pending");
       
        
       // ps.setString(6, "faculty");
        
        
        int rowsAffected = ps.executeUpdate();
        if (rowsAffected > 0) {
        
String leaveSuccessMessage = "Leave submitted successfully."; // You can set any custom message here
request.getSession().setAttribute("leaveSuccessMessage", leaveSuccessMessage);

           // out.println("<p>Leave request submitted successfully.</p>");
            response.sendRedirect("faculty-status.jsp");
        } else {
           response.sendRedirect("faculty-leave-request.jsp");
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
    Document   : faculty-leave-request-action
    Created on : 30-Jun-2023, 5:48:48 pm
    Author     : manikanta

image updated but errors

<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@page import="java.io.*, java.util.*, javax.servlet.*" %>
<%@page import="javax.servlet.http.*" %>
<%@page import="org.apache.commons.fileupload.*" %>
<%@page import="org.apache.commons.fileupload.disk.*" %>
<%@page import="org.apache.commons.fileupload.servlet.*" %>




<%
    
    String firstName = (String) session.getAttribute("firstname");
    String start = request.getParameter("start");
    String end = request.getParameter("end");
    String reason = request.getParameter("reason");
    //String image = request.getParameter("image");
    String category = (String) session.getAttribute("category");
    String userid = (String) session.getAttribute("userid");
    
  
    
   // Check if the request is a multipart request
    if (ServletFileUpload.isMultipartContent(request)) {
        // Create a file upload handler
        DiskFileItemFactory factory = new DiskFileItemFactory();

        // Set the directory to temporarily store the uploaded files (if needed)
        // Change this path to the temporary folder location on your server.
        factory.setRepository(new File("C:\\Users\\manikanta\\Downloads\\image"));

        ServletFileUpload upload = new ServletFileUpload(factory);

        try {
            // Parse the request to get a list of FileItems representing the uploaded files
            List<FileItem> items = upload.parseRequest(request);

            // Process each uploaded file
            for (FileItem item : items) {
                // Check if the current item is a file
                if (!item.isFormField()) {
                    // Get the file name
                    String fileName = new File(item.getName()).getName();
                    
                    byte[] fileData = item.get();
        
        
    
    Connection conn = null;
    PreparedStatement ps = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/codebook", "root", "");
        String sql = "INSERT INTO leaves (firstname, start, end, reason, category, userid, action,filename,imagedata ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        ps = conn.prepareStatement(sql);
        ps.setString(1, firstName);
        ps.setString(2, start);
        ps.setString(3, end);
        ps.setString(4, reason);
        ps.setString(5, category);
        ps.setString(6, userid);
        ps.setString(7,"Pending");
        ps.setString(8, fileName);
        ps.setBytes(9, fileData);

       
        
      
        
        
        int rowsAffected = ps.executeUpdate();
        if (rowsAffected > 0) {
        
String leaveSuccessMessage = "Leave submitted successfully."; // You can set any custom message here
request.getSession().setAttribute("leaveSuccessMessage", leaveSuccessMessage);

           // out.println("<p>Leave request submitted successfully.</p>");
            response.sendRedirect("faculty-status.jsp");
        } else {
           response.sendRedirect("faculty-leave-request.jsp");
            //out.println("<p>Error: Failed to submit leave request.</p>");
        }
    }
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
    } else {
        out.println("<p>No file has been selected for upload.</p>");
    }
%>


<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*, java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>

<%
    String firstName = (String) session.getAttribute("firstname");
    String start = request.getParameter("start");
   
    String image = request.getParameter("image");
    
    String end = request.getParameter("end");
    String reason = request.getParameter("reason");
    String category = (String) session.getAttribute("category");
    String userid = (String) session.getAttribute("userid");

    // Check if the request is a multipart request
    if (ServletFileUpload.isMultipartContent(request)) {
        // Create a file upload handler
        DiskFileItemFactory factory = new DiskFileItemFactory();

        // Set the directory to temporarily store the uploaded files (if needed)
        // Change this path to the temporary folder location on your server.
        factory.setRepository(new File("C:\\Users\\manikanta\\Downloads\\image"));

        ServletFileUpload upload = new ServletFileUpload(factory);

        try {
            // Parse the request to get a list of FileItems representing the uploaded files
            List<FileItem> items = upload.parseRequest(request);

            // Process each uploaded file
            for (FileItem item : items) {
                // Check if the current item is a file
                if (!item.isFormField()) {
                    // Get the file name
                    String fileName = new File(item.getName()).getName();
                    
                    byte[] fileData = item.get();

                    Connection conn = null;
                    PreparedStatement ps = null;
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/codebook", "root", "");
                        String sql = "INSERT INTO leaves (firstname, start, end, reason, category, userid, action,filename,imagedata ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                        ps = conn.prepareStatement(sql);
                        ps.setString(1, firstName);
                        ps.setString(2, start);
                        ps.setString(3, end);
                        ps.setString(4, reason);
                        ps.setString(5, category);
                        ps.setString(6, userid);
                        ps.setString(7, "Pending");
                        ps.setString(8, fileName);
                        ps.setBytes(9, fileData);

                        int rowsAffected = ps.executeUpdate();
                        if (rowsAffected > 0) {
                            String leaveSuccessMessage = "Leave submitted successfully.";
                            request.getSession().setAttribute("leaveSuccessMessage", leaveSuccessMessage);
                            response.sendRedirect("faculty-status.jsp");
                        } else {
                            response.sendRedirect("faculty-leave-request.jsp");
                        }
                    } catch (ClassNotFoundException e) {
                        e.printStackTrace();
                        out.println("<p>Error: Database driver not found.</p>");
                    } catch (SQLException e) {
                        e.printStackTrace();
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
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    } else {
        out.println("<p>No file has been selected for upload.</p>");
    }
%>
--%>