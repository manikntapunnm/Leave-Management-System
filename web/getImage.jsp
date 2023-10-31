<%--@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.Base64" %>

<%
try {
    // Establish database connection
    Class.forName("com.mysql.jdbc.Driver");
    String DB_URL = "jdbc:mysql://localhost:3306/codebook";
    String DB_USER = "root";
    String DB_PASSWORD = "";
    String userid = (String) session.getAttribute("userid");
    Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

    // Retrieve the image from the database
    String sql = "SELECT image FROM facultyd WHERE userid = ?";
    PreparedStatement statement = connection.prepareStatement(sql);
    statement.setString(1, userid);
    ResultSet resultSet = statement.executeQuery();

    if (resultSet.next()) {
        // Get the image data as InputStream
        InputStream inputStream = resultSet.getBinaryStream("image");

        // Set the content type of the response to image/jpeg
        response.setContentType("image/jpeg");

        // Write the image data to the response output stream
        OutputStream outputStream = response.getOutputStream();
        byte[] buffer = new byte[4096];
        int bytesRead;
        while ((bytesRead = inputStream.read(buffer)) != -1) {
            outputStream.write(buffer, 0, bytesRead);
        }

        // Close streams and database connection
        outputStream.close();
        inputStream.close();
    } else {
        response.setStatus(HttpServletResponse.SC_NOT_FOUND); // Set HTTP 404 status if no image found
    }

    statement.close();
    connection.close();
} catch (SQLException | ClassNotFoundException | IOException e) {
    e.printStackTrace();
    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // Set HTTP 500 status on error
}
--%>


<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.Base64" %>

<%
try {
    // Establish database connection
    Class.forName("com.mysql.jdbc.Driver");
    String DB_URL = "jdbc:mysql://localhost:3306/codebook";
    String DB_USER = "root";
    String DB_PASSWORD = "";
    String userid = (String) session.getAttribute("userid");
    Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

    // Determine the table name based on the userid
    String tableName;
    if (userid.startsWith("F")) {
        tableName = "facultyd";
    } else if (userid.startsWith("S")) {
        tableName = "studentd";
    } else {
        response.setStatus(HttpServletResponse.SC_NOT_FOUND); // Invalid userid, set HTTP 404 status
        return;
    }

    // Retrieve the image from the appropriate table
    String sql = "SELECT image FROM " + tableName + " WHERE userid = ?";
    PreparedStatement statement = connection.prepareStatement(sql);
    statement.setString(1, userid);
    ResultSet resultSet = statement.executeQuery();

    if (resultSet.next()) {
        // Get the image data as InputStream
        InputStream inputStream = resultSet.getBinaryStream("image");

        // Set the content type of the response to image/jpeg
        response.setContentType("image/jpeg");

        // Write the image data to the response output stream
        OutputStream outputStream = response.getOutputStream();
        byte[] buffer = new byte[4096];
        int bytesRead;
        while ((bytesRead = inputStream.read(buffer)) != -1) {
            outputStream.write(buffer, 0, bytesRead);
        }

        // Close streams and database connection
        outputStream.close();
        inputStream.close();
    } else {
        response.setStatus(HttpServletResponse.SC_NOT_FOUND); // Set HTTP 404 status if no image found
    }

    statement.close();
    connection.close();
} catch (SQLException | ClassNotFoundException | IOException e) {
    e.printStackTrace();
    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // Set HTTP 500 status on error
}
%>

