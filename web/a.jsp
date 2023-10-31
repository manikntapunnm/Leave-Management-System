
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


<%
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String gender = request.getParameter("gender");
    String phone = request.getParameter("phone");
    String date = request.getParameter("date");
    String photo = request.getParameter("photo");
    String category = request.getParameter("category");
    String address1 = request.getParameter("address1");
    String address2 = request.getParameter("address2");
    String state = request.getParameter("state");
    String email = request.getParameter("email");
    String postcode = request.getParameter("postcode");
    String city = request.getParameter("city");
    String country = request.getParameter("country");
    String nPassword = request.getParameter("password");
    String password = generateRandomPassword(8);

    String userid = generateUserId();
    
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
            String sql = "INSERT INTO facultyd (firstName, lastName, gender, phone, date, photo, category, address1, address2, state, email, postcode, city, country, password,userid) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            statement = connection.prepareStatement(sql);        
            statement.setString(1, firstName);
            statement.setString(2, lastName);
            statement.setString(3, gender);
            statement.setString(4, phone);
            statement.setString(5, date);
            statement.setString(6, photo);
            statement.setString(7, category);
            statement.setString(8, address1);
            statement.setString(9, address2);
            statement.setString(10, state);
            statement.setString(11, email);
            statement.setString(12, postcode);
            statement.setString(13, city);
            statement.setString(14, country);
            statement.setString(15, password);
            statement.setString(16, userid);
            
            // Execute the query
            statement.executeUpdate();

            out.println("<script>");
            out.println("alert('Generated password: " + password + "');");
            out.println("alert('Generated userId: " + userid + "');");
            out.println("window.location.href = 'admin-employee-list.jsp';"); // Redirect to login page
            out.println("</script>");
            
            
            
            
            
            
            
            
            
            
            
            

        } catch (SQLException e) {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        } finally {
            // Close the JDBC objects
            if (statement != null) {
                statement.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
    }
%>

<%! 
    private String generateRandomPassword(int length) {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder password = new StringBuilder();

        Random random = new Random();
        int charactersLength = characters.length();

        for (int i = 0; i < length; i++) {
            int index = random.nextInt(charactersLength);
            password.append(characters.charAt(index));
        }

        return password.toString();
    }
%>

<%! 
    private String generateUserId() {
        String result = null;
        boolean isUnique = false;

        try {
            // JDBC connection variables
            String url = "jdbc:mysql://localhost:3306/codebook";
            String username = "root";
            String dbpassword = "";
            
            // JDBC objects
            Connection connection = null;
            PreparedStatement statement = null;
            ResultSet resultSet = null;

            // Create a connection to the database
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(url, username, dbpassword);

            while (!isUnique) {
                // Generate a random number between 1 and 1000
                Random random = new Random();
                int randomNumber = random.nextInt(100) + 1;

                // Get the current year
                int currentYear = Calendar.getInstance().get(Calendar.YEAR);

                // Format the random number as a 2-digit string
                DecimalFormat randomFormat = new DecimalFormat("000");
                String randomString = randomFormat.format(randomNumber);

                // Concatenate the components to form the final string
                String generatedUserId = "FAC" + String.valueOf(currentYear).substring(2) + randomString;

                // Check if the generated user ID exists in the database
                String query = "SELECT userid FROM facultyd WHERE userid = ?";
                statement = connection.prepareStatement(query);
                statement.setString(1, generatedUserId);
                resultSet = statement.executeQuery();

                if (!resultSet.next()) {
                    // The generated user ID is unique
                    isUnique = true;
                    result = generatedUserId;
                }
            }

            // Close the JDBC objects
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        return result;
    }
%>
