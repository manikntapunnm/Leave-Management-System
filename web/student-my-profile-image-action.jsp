<%-- 
    Document   : student-my-profile-image-action
    Created on : 26-Jul-2023, 12:13:39 am
    Author     : manikanta
--%>

<%-- 
    Document   : updateimage
    Created on : 25-Jul-2023, 9:09:00 pm
    Author     : manikanta
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.io.*"%>

<!DOCTYPE html>

<%
    
   String userid = (String) session.getAttribute("userid");
    String image=request.getParameter("image");
    out.println(image);
    
    
    
         Connection conn=null;
         PreparedStatement ps=null;
       
        FileInputStream input=null;
       
    try {
        Class.forName("com.mysql.jdbc.Driver"); 
        conn =DriverManager.getConnection("jdbc:mysql://localhost:3306/codebook","root","");
         
         //input=new FileInputStream("C:\\Users\\manikanta\\Documents\\LMS\\"+image);
         input=new FileInputStream("C:\\Users\\manikanta\\OneDrive\\Documents\\NetBeansProjects\\LMS\\web\\images\\students\\"+image);
                                    
         
     
        ps =conn.prepareStatement("UPDATE studentd SET image = ?,imagename = ? WHERE userid = ?");
        
     
        ps.setBlob(1, input);
        ps.setString(2, image);
        ps.setString(3, userid);
        

   int n = ps.executeUpdate();
        if (n > 0) {
            
            response.sendRedirect("student-my-profile.jsp");
        } else {
            out.println("Image update failed");
        }
        
} catch (Exception e) {
        e.printStackTrace();
        out.println(e);
    } finally {
        try {
            ps.close();
            conn.close();
        } catch (Exception e) {
        }
    }
%>