<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>




<%
    Connection con = null;
    PreparedStatement ps = null;
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
        
        String query = "UPDATE facultyd SET firstname=?, date=?, email=?, city=?, phone=? WHERE userid=?";
        ps = con.prepareStatement(query);
        
        ps.setString(1, firstname);
        ps.setString(2, date);
        ps.setString(3, email);
        ps.setString(4, city);
        ps.setString(5, phone);
        ps.setString(6, userid);
        
        int rowsAffected = ps.executeUpdate();
        if (rowsAffected > 0) {
            //out.println("Data updated successfully");
            // out.println("window.location.href = 'index.jsp';");
            request.getSession().setAttribute("updateSuccessMessage", "Details updated successfully.");
           response.sendRedirect("faculty-my-profile.jsp");
        } else {
            out.println("<script>alert('Failed to update data');</script>");
            response.setHeader("Refresh", "0; URL=faculty-my-profile.jsp");
        }
    } catch (Exception e) {
        e.printStackTrace();
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



