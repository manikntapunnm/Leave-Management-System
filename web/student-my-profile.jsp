<%-- 
    Document   : student-my-profile
    Created on : 22-Jun-2023, 2:42:16 pm
    Author     : manikanta
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Base64" %>
<!DOCTYPE html>
<html lang="en">

<head>
    
    
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.all.min.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/sweetalert/dist/sweetalert.css">

  <title>Codebook.in</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <link href="https://fonts.googleapis.com/css?family=Poppins:200,300,400,500,600,700,800,900&display=swap"
    rel="stylesheet">

  <link rel="stylesheet" href="css/open-iconic-bootstrap.min.css">
  <link rel="stylesheet" href="css/animate.css">

  <link rel="stylesheet" href="css/owl.carousel.min.css">
  <link rel="stylesheet" href="css/owl.theme.default.min.css">
  <link rel="stylesheet" href="css/magnific-popup.css">

  <link rel="stylesheet" href="css/aos.css">

  <link rel="stylesheet" href="css/ionicons.min.css">

  <link rel="stylesheet" href="css/flaticon.css">
  <link rel="stylesheet" href="css/icomoon.css">
  <link rel="stylesheet" href="css/style.css">
</head>

<body>
  <div class="bg-top navbar-light">
    <div class="container">
      <div class="row no-gutters d-flex align-items-center align-items-stretch">
        <div class="col-md-4 d-flex align-items-center py-4">
          <a class="navbar-brand" href="index.jsp">Leave Management System<span>Codebook.in</span></a>
        </div>

      </div>
    </div>
  </div>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark ftco-navbar-light" id="ftco-navbar">
    <div class="container d-flex align-items-center px-4">
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav"
        aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="oi oi-menu"></span> Menu
      </button>
      <form action="#" class="searchform order-lg-last">
        <div class="form-group d-flex">
          <a href="index.jsp"><button type="button" class="btn btn-outline-light btn-sm mt-2"
              style="border-radius: 5px; height:40px;">Logout</button></a>
        </div>
      </form>
      <div class="collapse navbar-collapse" id="ftco-nav">
        <ul class="navbar-nav mr-auto">
          <li class="nav-item "><a href="student-dashboard.jsp" class="nav-link pl-0">Dashboard</a></li>
          <li class="nav-item "><a href="student-request-leave.jsp" class="nav-link">Request Leave</a></li>
          <li class="nav-item"><a href="student-status.jsp" class="nav-link">Status</a></li>
          <li class="nav-item active"><a href="student-my-profile.jsp" class="nav-link">My Profile</a></li>
        </ul>
      </div>
    </div>
  </nav>
  <!-- END nav -->

  <section class="hero-wrap hero-wrap-2" style="background-image: url('images/bg_1.jpg');">
    <div class="overlay"></div>
    <div class="container">
      <div class="row no-gutters slider-text align-items-center justify-content-center">
        <div class="col-md-9 ftco-animate text-center">
          <h1 class="mb-2 bread"><%= session.getAttribute("firstname") %>'s  Profile</h1>
       <h3 class="mb-2 bread"><%= session.getAttribute("branch") %></h3>
                <h3 class="mb-2 bread"><%= session.getAttribute("userid") %></h3>
          <p class="breadcrumbs"><span class="mr-2"><a href="student-dashboard.jsp">Student <i
                  class="ion-ios-arrow-forward"></i></a></span> <span>My Profile<i
                class="ion-ios-arrow-forward"></i></span></p>
        </div>
      </div>
    </div>
  </section>
  <!-- profile -->
  <br>
  
 <%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        String url = "jdbc:mysql://localhost:3306/codebook";
        String username = "root";
        String dbpassword = "";
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(url, username, dbpassword);

        String userid = (String) session.getAttribute("userid");

        String query = "SELECT * FROM studentd WHERE userid = ?";
        ps = con.prepareStatement(query);
        ps.setString(1, userid);
        rs = ps.executeQuery();

        if (rs.next()) {
           
            %>
            
            
  
  <div class="container-fluid">
      <div class="row">
          <div class="col-md-12">
              <div class="row">
  
  
                          <div class="col-xl-4">
    <!-- Profile picture card -->
    <div class="card mb-4 mb-xl-0">
        <div class="card-header">Profile Picture</div>
        <div class="card-body text-center">
            <!-- Display the profile picture image -->
            <img style="width:100px; height:100px;" class="img-account-profile rounded-circle mb-2"
                src="getImage.jsp" alt="Student Image">
            
            <div class="small font-italic text-muted mb-4">JPG or PNG no larger than 5 MB</div>
            <!-- Profile picture upload button -->
            <!--button class="btn btn-primary" type="button">Upload new image</button-->
            <form action="student-my-profile-image-action.jsp" method="post" >
                <input type="file" onchage="readURL(this)" name="image" id="image" accept="image/*">
                <button type="submit" class="btn btn-primary">Upload new image</button>
            </form>
            
        </div>
    </div>
</div>      
       


            
            
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">Account Details</div>
                    <div class="card-body">
                        <form action="student-my-profile-action.jsp" method="post">
                            <div class="form-group row">
                                <label class="col-sm-2 col-form-label">UserId (Default)</label>
                                <div class="col-sm-10">
                                    <input class="form-control" type="text" value="<%= rs.getString("userid") %>" name="userid">
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-sm-2 col-form-label">Name</label>
                                <div class="col-sm-4">
                                    <input class="form-control" type="text" value="<%= rs.getString("firstname") %>" name="firstname">
                                </div>
                                <label class="col-sm-2 col-form-label">Birthday</label>
                                <div class="col-sm-4">
                                    <input class="form-control" type="text" value="<%= rs.getString("date") %>" name="date">
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-sm-2 col-form-label">Email</label>
                                <div class="col-sm-4">
                                    <input class="form-control" type="text" value="<%= rs.getString("email") %>" name="email">
                                </div>
                                <label class="col-sm-2 col-form-label">Address</label>
                                <div class="col-sm-4">
                                    <input class="form-control" type="text" value="<%= rs.getString("city") %>" name="city">
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-sm-2 col-form-label">Phone</label>
                                <div class="col-sm-10">
                                    <input class="form-control" type="text" value="<%= rs.getString("phone") %>" name="phone">
                                </div>
                            </div>
                            <div class="form-group">
                                <button class="btn btn-primary" type="submit">Save changes</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
                                
                                <%
String updateSuccessMessage = (String) request.getSession().getAttribute("updateSuccessMessage");
    if (updateSuccessMessage != null && !updateSuccessMessage.isEmpty()) {
        out.println("<script>");
        out.println("Swal.fire({");
        out.println("  icon: 'success',");
        out.println("  title: 'Success',");
        out.println("  text: '" + updateSuccessMessage + "',");
        out.println("});");
        out.println("</script>");
        // Remove the session attribute to prevent displaying the message again on subsequent requests
        request.getSession().removeAttribute("updateSuccessMessage");
    }
    %>

                                
                                
                                
            <%
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("An error occurred: " + e.getMessage());
    } finally {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
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


              </div>
          </div>
      </div>
  </div>



<br>




  <!-- /profile end -->

  <br><br>

  <footer class="ftco-footer ftco-bg-dark ftco-section">
    <div class="container">
      <div class="row mb-5">
        <div class="col-md-6 col-lg-3">
          <div class="ftco-footer-widget mb-5">
            <h2 class="ftco-heading-2">Address</h2>
            <div class="block-23 mb-3">
              <ul>
                <li><span class="icon icon-map-marker"></span><span class="text">2nd Floor metro piller No-A1662, Sirish
                    road snehapur colony, LB nagar, Telangana</span></li>
                <li><a href="#"><span class="icon icon-phone"></span><span class="text">+91 8555887986</span></a></li>
                <li><a href="#"><span class="icon icon-envelope"></span><span class="text">info@codebook.in</span></a>
                </li>
              </ul>
            </div>
          </div>
        </div>

        <div class="col-md-6 col-lg-3">
          <div class="ftco-footer-widget mb-5 ml-md-4">
            <h2 class="ftco-heading-2">Links</h2>
            <ul class="list-unstyled">
              <li><a href="#"><span class="ion-ios-arrow-round-forward mr-2"></span>Home</a></li>
              <li><a href="admin-login.jsp"><span class="ion-ios-arrow-round-forward mr-2"></span>Principle</a>
              </li>
              <li><a href="hod-login.jsp"><span class="ion-ios-arrow-round-forward mr-2"></span>HOD</a></li>
              <li><a href="faculty-login.jsp"><span class="ion-ios-arrow-round-forward mr-2"></span>Faculty</a></li>
              <li><a href="student-login.jsp"><span class="ion-ios-arrow-round-forward mr-2"></span>Student</a></li>
            </ul>
          </div>
        </div>
        <div class="col-md-6 col-lg-3">
          <div class="ftco-footer-widget mb-5">
            <h2 class="ftco-heading-2">Subscribe Us!</h2>
            <form action="#" class="subscribe-form">
              <div class="form-group">
                <input type="text" class="form-control mb-2 text-center" placeholder="Enter email address">
                <input type="submit" value="Subscribe" class="form-control submit px-3">
              </div>
            </form>
          </div>
          <div class="ftco-footer-widget mb-5">
            <h2 class="ftco-heading-2 mb-0">Connect With Us</h2>
            <ul class="ftco-footer-social list-unstyled float-md-left float-lft mt-3">
              <li class="ftco-animate"><a href="#"><span class="icon-twitter"></span></a></li>
              <li class="ftco-animate"><a href="#"><span class="icon-facebook"></span></a></li>
              <li class="ftco-animate"><a href="#"><span class="icon-instagram"></span></a></li>
            </ul>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-md-12 text-center">

          <p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
            Copyright &copy;
            <script>document.write(new Date().getFullYear());</script> All rights reserved | &copy; 2022 Designed and
            developed by <i class="icon-heart" aria-hidden="true"></i> by <a href="https://colorlib.com"
               >FZ INFOTECH</a>
            <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
          </p>
        </div>
      </div>
    </div>
  </footer>



  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px">
      <circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee" />
      <circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10"
        stroke="#F96D00" />
    </svg></div>


  <script src="js/jquery.min.js"></script>
  <script src="js/jquery-migrate-3.0.1.min.js"></script>
  <script src="js/popper.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/jquery.easing.1.3.js"></script>
  <script src="js/jquery.waypoints.min.js"></script>
  <script src="js/jquery.stellar.min.js"></script>
  <script src="js/owl.carousel.min.js"></script>
  <script src="js/jquery.magnific-popup.min.js"></script>
  <script src="js/aos.js"></script>
  <script src="js/jquery.animateNumber.min.js"></script>
  <script src="js/scrollax.min.js"></script>
  <script
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
  <script src="js/google-map.js"></script>
  <script src="js/main.js"></script>

</body>

</html>