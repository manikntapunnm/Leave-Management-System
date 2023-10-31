


<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%
    String userid = request.getParameter("userid");
    String pass = request.getParameter("password");
    out.println(userid);
    out.println(pass);

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/codebook", "root", "");
        ps = con.prepareStatement("SELECT * FROM facultyd WHERE userid=? AND password=?");
        ps.setString(1, userid);
        ps.setString(2, pass);
        rs = ps.executeQuery();

        if (rs.next()) {
            String firstname = rs.getString("firstname");
            session.setAttribute("firstname", firstname);

            String category = rs.getString("category");
            session.setAttribute("category", category);
            
            String userid2 = rs.getString("userid");
            session.setAttribute("userid", userid2);

            if (category.equalsIgnoreCase("HOD")) {
                response.sendRedirect("hod-dashboard.jsp");
            } else {
                response.sendRedirect("hod-login.jsp");
            }
        } else {
            response.sendRedirect("hod-login.jsp");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    } finally {
        // Close the JDBC objects
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
