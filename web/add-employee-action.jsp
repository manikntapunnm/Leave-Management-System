

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.FileInputStream" %>

<%@ page import="java.io.ByteArrayOutputStream" %>
<%@ page import="java.util.Random" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.Calendar" %>
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
<!DOCTYPE html>
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
    String address1 = request.getParameter("address1");
    String state = request.getParameter("state");
    String address2 = request.getParameter("address2");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String postcode = request.getParameter("postcode");
    String city = request.getParameter("city");
    String image=request.getParameter("image");
    

    String country = request.getParameter("country");
    
        out.println(image);
    


    String prefix = "FAC";
    int randomNumber = new Random().nextInt(1000);
    String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    int length = 6;
    StringBuilder passwordBuilder = new StringBuilder();

    for (int i = 0; i < length; i++) {
        int index = new Random().nextInt(characters.length());
        passwordBuilder.append(characters.charAt(index));
    }

    String userid = prefix + randomNumber;
    String password = passwordBuilder.toString();

    if (userid != null) {
        // JDBC connection variables
        String url = "jdbc:mysql://localhost:3306/codebook";
        String username = "root";
        String dbpassword = "";
        // JDBC objects
        Connection connection = null;
        PreparedStatement statement = null;
       // ResultSet resultSet=null;
        FileInputStream input=null;


        try {
            // Create a connection to the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, username, dbpassword);
            input=new FileInputStream("C:\\Users\\manikanta\\OneDrive\\Documents\\NetBeansProjects\\LMS\\web\\images\\teachers\\"+image);
            String sql = "INSERT INTO facultyd (userid, password, firstname, lastname, gender, date, category, address1, state, address2, email, phone, postcode,  city,   country,image, imagename) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            statement = connection.prepareStatement(sql);
         

            statement.setString(1, userid);
            statement.setString(2, password);
            statement.setString(3, firstname);
            statement.setString(4, lastname);
            statement.setString(5, gender);
            statement.setString(6, date);
            statement.setString(7, category);
            statement.setString(8, address1);
            statement.setString(9, state);
            statement.setString(10, address2);
            statement.setString(11, email);
            statement.setString(12, phone);
            statement.setString(13, postcode);
            statement.setString(14, city);
            statement.setString(15, country);
            statement.setBlob(16, input);
            statement.setString(17, image);
            

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
            String successMessage = "Registration Successful. An email has been sent to your registered email address.";
            out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.all.min.js'></script>");
            out.println("<script>");
            out.println("Swal.fire({");
            out.println("  icon: 'success',");
            out.println("  title: 'Success',");
            out.println("  text: '" + successMessage + "',");
            out.println("}).then(function() { window.location.href = 'admin-employee-list.jsp'; });");
            out.println("</script>");

        } catch (ClassNotFoundException | SQLException | MessagingException e) {
            e.printStackTrace();
            // Display error message
            String errorMessage = "An error occurred during employee registration. Please try again.";
            out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.all.min.js'></script>");
            out.println("<script>");
            out.println("Swal.fire({");
            out.println("  icon: 'error',");
            out.println("  title: 'Error',");
            out.println("  text: '" + errorMessage + "',");
            out.println("}).then(function() { window.location.href = 'admin-add-employee.jsp'; });");
            out.println("</script>");

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
    }

%>


</body>
</html>



<%--! 

// Assuming you have the byte[] representation of the photo here
   // Part photoPart = request.getPart("photo");
    //InputStream photoStream = photoPart.getInputStream();

    //byte[] photoData = getPhotoDataFromStream(photoStream);


    private byte[] getPhotoDataFromStream(InputStream photoStream) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        byte[] buffer = new byte[102400];
        int bytesRead;

        while ((bytesRead = photoStream.read(buffer)) != -1) {
            baos.write(buffer, 0, bytesRead);
        }

        return baos.toByteArray();
    }
--%>


            

       



<!--<%--@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Random" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.Calendar" %>
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
    String address1 = request.getParameter("address1");
    String state = request.getParameter("state");
    String address2 = request.getParameter("address2");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String postcode = request.getParameter("postcode");
    String city = request.getParameter("city");
    String photo = request.getParameter("photo");
    String country = request.getParameter("country");

    String prefix = "FAC";
    int randomNumber = new Random().nextInt(1000);
    String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    int length = 6;
    StringBuilder passwordBuilder = new StringBuilder();

    for (int i = 0; i < length; i++) {
        int index = new Random().nextInt(characters.length());
        passwordBuilder.append(characters.charAt(index));
    }

    String userid = prefix + randomNumber;
    String password = passwordBuilder.toString();

    if (userid != null) {
        // JDBC connection variables
        String url = "jdbc:mysql://localhost:3306/codebook";
        String username = "root";
        String dbpassword = "";
        // JDBC objects
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            // Create a connection to the database
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(url, username, dbpassword);
            String sql = "INSERT INTO facultyd (userid, password, firstname, lastname, gender, date, category, address1, state, address2, email, phone, postcode,  city,  photo, country) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            statement = connection.prepareStatement(sql);

            statement.setString(1, userid);
            statement.setString(2, password);
            statement.setString(3, firstname);
            statement.setString(4, lastname);
            statement.setString(5, gender);
            statement.setString(6, date);
            statement.setString(7, category);
            statement.setString(8, address1);
            statement.setString(9, state);
            statement.setString(10, address2);
            statement.setString(11, email);
            statement.setString(12, phone);
            statement.setString(13, postcode);
            statement.setString(14, city);
            statement.setString(15, photo);
            statement.setString(16, country);

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
            String successMessage = "Registration Successful. An email has been sent to your registered email address.";
            out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.all.min.js'></script>");
            out.println("<script>");
            out.println("Swal.fire({");
            out.println("  icon: 'success',");
            out.println("  title: 'Success',");
            out.println("  text: '" + successMessage + "',");
            out.println("}).then(function() { window.location.href = 'admin-employee-list.jsp'; });");
            out.println("</script>");
            
            
            
            
            

        } catch (ClassNotFoundException | SQLException | MessagingException e) {
            e.printStackTrace();
            // Display error message
            String errorMessage = "An error occurred during student registration. Please try again.";
            out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.all.min.js'></script>");
            out.println("<script>");
            out.println("Swal.fire({");
            out.println("  icon: 'error',");
            out.println("  title: 'Error',");
            out.println("  text: '" + errorMessage + "',");
            out.println("}).then(function() { window.location.href = 'admin-add-employee.jsp'; });");
            out.println("</script>");

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
    }
--%>


    </body>
</html>-->




<%--@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.InputStream" %>

<%@ page import="java.io.ByteArrayOutputStream" %>

<%@ page import="java.util.Random" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.Calendar" %>
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
    String address1 = request.getParameter("address1");
    String state = request.getParameter("state");
    String address2 = request.getParameter("address2");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String postcode = request.getParameter("postcode");
    String city = request.getParameter("city");
   // String photo = request.getParameter("photo");
   
   // Assuming you have the byte[] representation of the photo here
    Part photoPart = request.getPart("photo");
    InputStream photoStream = photoPart.getInputStream();
    
    byte[] photoData = getPhotoDataFromStream(photoStream);
    
    
    String country = request.getParameter("country");

    String prefix = "FAC";
    int randomNumber = new Random().nextInt(1000);
    String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    int length = 6;
    StringBuilder passwordBuilder = new StringBuilder();

    for (int i = 0; i < length; i++) {
        int index = new Random().nextInt(characters.length());
        passwordBuilder.append(characters.charAt(index));
    }

    String userid = prefix + randomNumber;
    String password = passwordBuilder.toString();

    if (userid != null) {
        // JDBC connection variables
        String url = "jdbc:mysql://localhost:3306/codebook";
        String username = "root";
        String dbpassword = "";
        // JDBC objects
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            // Create a connection to the database
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(url, username, dbpassword);
            String sql = "INSERT INTO facultyd (userid, password, firstname, lastname, gender, date, category, address1, state, address2, email, phone, postcode,  city,  photo, country) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            statement = connection.prepareStatement(sql);

            statement.setString(1, userid);
            statement.setString(2, password);
            statement.setString(3, firstname);
            statement.setString(4, lastname);
            statement.setString(5, gender);
            statement.setString(6, date);
            statement.setString(7, category);
            statement.setString(8, address1);
            statement.setString(9, state);
            statement.setString(10, address2);
            statement.setString(11, email);
            statement.setString(12, phone);
            statement.setString(13, postcode);
            statement.setString(14, city);
            //statement.setString(15, photo);
            statement.setBytes(15, photoData);
            statement.setString(16, country);

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
            String successMessage = "Registration Successful. An email has been sent to your registered email address.";
            out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.all.min.js'></script>");
            out.println("<script>");
            out.println("Swal.fire({");
            out.println("  icon: 'success',");
            out.println("  title: 'Success',");
            out.println("  text: '" + successMessage + "',");
            out.println("}).then(function() { window.location.href = 'admin-employee-list.jsp'; });");
            out.println("</script>");
            
            
            
            
            

        } catch (ClassNotFoundException | SQLException | MessagingException e) {
            e.printStackTrace();
            // Display error message
            String errorMessage = "An error occurred during student registration. Please try again.";
            out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.all.min.js'></script>");
            out.println("<script>");
            out.println("Swal.fire({");
            out.println("  icon: 'error',");
            out.println("  title: 'Error',");
            out.println("  text: '" + errorMessage + "',");
            out.println("}).then(function() { window.location.href = 'admin-add-employee.jsp'; });");
            out.println("</script>");

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
    }

%>

    <%!

  byte[] getPhotoDataFromStream(InputStream photoStream) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        byte[] buffer = new byte[102400];
        int bytesRead;

        while ((bytesRead = photoStream.read(buffer)) != -1) {
            baos.write(buffer, 0, bytesRead);
        }

        return baos.toByteArray();
    }
--%>

