<!--<%--@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Random" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.Properties" %>
<%@ page import="javax.mail.Message" %>
<%@ page import="javax.mail.MessagingException" %>
<%@ page import="javax.mail.PasswordAuthentication" %>
<%@ page import="javax.mail.Session" %>
<%@ page import="javax.mail.Transport" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.http.HttpServlet" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="java.io.FileInputStream" %>
<!Doctype html>
<html>
    <head>
       <!-- Example using CDN link -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.all.min.js"></script>
 
    </head>
    <body>
        

<%  
    String firstname = request.getParameter("firstname");
    String lastname = request.getParameter("lastname");
    String gender = request.getParameter("gender");
    String date = request.getParameter("date");
    String category = request.getParameter("category");
    String branch = request.getParameter("branch");
    String address1 = request.getParameter("address1");
    String state = request.getParameter("state");
    String address2 = request.getParameter("address2");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String postcode = request.getParameter("postcode");
    String city = request.getParameter("city");
    String image = request.getParameter("image");
    String country = request.getParameter("country");
    
String prefix = "STU";
int currentYear = Calendar.getInstance().get(Calendar.YEAR) % 100; // Get last two digits of the year
String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
int length = 8;
StringBuilder passwordBuilder = new StringBuilder();

Random random = new Random();
for (int i = 0; i < length; i++) {
    int index = random.nextInt(characters.length());
    passwordBuilder.append(characters.charAt(index));
}

String userid = prefix + String.format("%02d", currentYear) + random.nextInt(10000); // Generate a random 5-digit number
String password = passwordBuilder.toString();



    // JDBC connection variables
    String url = "jdbc:mysql://localhost:3306/codebook";
    String username = "root";
    String dbpassword = "";
    // JDBC objects
    Connection connection = null;
    PreparedStatement statement = null;
    FileInputStream input=null;
    try {
        // Create a connection to the database
        Class.forName("com.mysql.jdbc.Driver");
        connection = DriverManager.getConnection(url, username, dbpassword);    
        input=new FileInputStream("C:\\Users\\manikanta\\OneDrive\\Documents\\NetBeansProjects\\LMS\\web\\images\\students\\"+image);
        String sql = "INSERT INTO studentd (userid, password, firstname, lastname, gender, date, category, branch, address1, state, address2, email, phone, postcode,  city,  image, country) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        statement = connection.prepareStatement(sql); 
        
        statement.setString(1, userid);
        statement.setString(2, password);
        statement.setString(3, firstname);
        statement.setString(4, lastname);
        statement.setString(5, gender);
        statement.setString(6, date);
        statement.setString(7, category);
        statement.setString(8, branch);
        statement.setString(9, address1);
        statement.setString(10, state);
        statement.setString(11, address2);
        statement.setString(12, email);
        statement.setString(13, phone);
        statement.setString(14, postcode);
        statement.setString(15, city);
        statement.setBlob(16, input);
        statement.setString(17, country);
        
        // Execute the query
        statement.executeUpdate();
        
        
   

        final String senderEmail = "projects@codebook.in";
        final String senderPassword = "frwqvhawrnsxetyk";

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session esession = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        });

        MimeMessage message = new MimeMessage(esession);
        message.setFrom(new InternetAddress(senderEmail));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
        message.setSubject("Registration Successful");
        message.setText("Dear " + firstname + ",\n\nThank you for registering. Your account details are:\nUser ID: " + userid + "\nPassword: " + password);

        Transport.send(message);

        // Display success message
        //out.println("Registration Successful. An email has been sent to your registered email address.");
        
        
        
        
        
        
        
        
        
        
        
        
     // Display success message using SweetAlert
        String successMessage = "Registration Successful. An email has been sent to your registered email address.";
        out.println(""
            + "<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.all.min.js'></script>"
            + "<script>"
            + "Swal.fire({"
            + "  icon: 'success',"
            + "  title: 'Success',"
            + "  text: '" + successMessage + "',"
            + "}).then(function() { window.location.href = 'admin-student-list.jsp'; });"
            + "</script>"
        + "");  
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        

       // response.sendRedirect("admin-student-list.jsp");
    } catch (ClassNotFoundException | SQLException | MessagingException e) {
        e.printStackTrace();
        // Display error message
        //out.println("An error occurred: " + e.getMessage() + ". Please try again.");
        
        
        
        
        
        
       String errorMessage = "An error occurred during student registration. Please try again.";
        out.println(""
            + "<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.all.min.js'></script>"
            + "<script>"
            + "Swal.fire({"
            + "  icon: 'error',"
            + "  title: 'Error',"
            + "  text: '" + errorMessage + "',"
            + "});"
            + "</script>"
        + "");
        
        
        
        
        
        
        
        
        
    } catch (ClassNotFoundException | SQLException | MessagingException e) {
    e.printStackTrace();
    String errorMessage = "An error occurred during student registration. Please try again.";
    out.println("<h2>Error</h2>");
    out.println("<p>" + errorMessage + "</p>");
}finally {
        // Close resources
        if (statement != null) {
            try {
                statement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
--%>
    </body>
</html-->


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Random" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.Properties" %>
<%@ page import="javax.mail.Message" %>
<%@ page import="javax.mail.MessagingException" %>
<%@ page import="javax.mail.PasswordAuthentication" %>
<%@ page import="javax.mail.Session" %>
<%@ page import="javax.mail.Transport" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.http.HttpServlet" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="java.io.FileInputStream" %>
<!Doctype html>
<html>
<head>
    <!-- Example using CDN link -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.all.min.js"></script>

</head>
<body>

<%
    String firstname = request.getParameter("firstname");
    String lastname = request.getParameter("lastname");
    String gender = request.getParameter("gender");
    String date = request.getParameter("date");
    String category = request.getParameter("category");
    String branch = request.getParameter("branch");
    String address1 = request.getParameter("address1");
    String state = request.getParameter("state");
    String address2 = request.getParameter("address2");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String postcode = request.getParameter("postcode");
    String city = request.getParameter("city");
    String country = request.getParameter("country");
    String image = request.getParameter("image");
    

    String prefix = "STU";
    int currentYear = Calendar.getInstance().get(Calendar.YEAR) % 100; // Get last two digits of the year
    String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    int length = 8;
    StringBuilder passwordBuilder = new StringBuilder();

    Random random = new Random();
    for (int i = 0; i < length; i++) {
        int index = random.nextInt(characters.length());
        passwordBuilder.append(characters.charAt(index));
    }

    String userid = prefix + String.format("%02d", currentYear) + random.nextInt(10000); // Generate a random 5-digit number
    String password = passwordBuilder.toString();

    // JDBC connection variables
    String url = "jdbc:mysql://localhost:3306/codebook";
    String username = "root";
    String dbpassword = "";
    // JDBC objects
    Connection connection = null;
    PreparedStatement statement = null;
    FileInputStream input = null;
    try {
        // Create a connection to the database
        Class.forName("com.mysql.jdbc.Driver");
        connection = DriverManager.getConnection(url, username, dbpassword);
        input = new FileInputStream("C:\\Users\\manikanta\\OneDrive\\Documents\\NetBeansProjects\\LMS\\web\\images\\students\\" + image);
        String sql = "INSERT INTO studentd (userid, password, firstname, lastname, gender, date, category, branch, address1, state, address2, email, phone, postcode,  city,country,  image, imagename ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?, ?)";
        statement = connection.prepareStatement(sql);

        statement.setString(1, userid);
        statement.setString(2, password);
        statement.setString(3, firstname);
        statement.setString(4, lastname);
        statement.setString(5, gender);
        statement.setString(6, date);
        statement.setString(7, category);
        statement.setString(8, branch);
        statement.setString(9, address1);
        statement.setString(10, state);
        statement.setString(11, address2);
        statement.setString(12, email);
        statement.setString(13, phone);
        statement.setString(14, postcode);
        statement.setString(15, city);
        statement.setString(16, country);
        statement.setBlob(17, input);
        statement.setString(18, image);

        // Execute the query
        statement.executeUpdate();

        final String senderEmail = "projects@codebook.in";
        final String senderPassword = "frwqvhawrnsxetyk";

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session esession = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        });

        MimeMessage message = new MimeMessage(esession);
        message.setFrom(new InternetAddress(senderEmail));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
        message.setSubject("Registration Successful");
        message.setText("Dear " + firstname + ",\n\nThank you for registering. Your account details are:\nUser ID: " + userid + "\nPassword: " + password);

        Transport.send(message);

        // Display success message using SweetAlert
        String successMessage = "Registration Successful. An email has been sent to your registered email address.";
        out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.all.min.js'></script>");
        out.println("<script>");
        out.println("Swal.fire({");
        out.println("  icon: 'success',");
        out.println("  title: 'Success',");
        out.println("  text: '" + successMessage + "',");
        out.println("}).then(function() { window.location.href = 'admin-student-list.jsp'; });");
        out.println("</script>");

    } catch (ClassNotFoundException | SQLException | MessagingException e) {
        e.printStackTrace();
        // Display error message
        String errorMessage = "An error occurred during student registration. Please try again.";
        out.println("<h2>Error</h2>");
        out.println("<p>" + errorMessage + "</p>");
    } finally {
        // Close resources
        if (statement != null) {
            try {
                statement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
</body>
</html>
