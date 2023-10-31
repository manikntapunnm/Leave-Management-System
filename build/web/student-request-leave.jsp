<%-- 
    Document   : student-request-leave
    Created on : 22-Jun-2023, 2:42:57 pm
    Author     : manikanta
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
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
          <li class="nav-item"><a href="student-dashboard.jsp" class="nav-link pl-0">Dashboard</a></li>
          <li class="nav-item active"><a href="student-request-leave.jsp" class="nav-link">Request Leave</a></li>
          <li class="nav-item"><a href="student-status.jsp" class="nav-link">Status</a></li>
          <li class="nav-item"><a href="student-my-profile.jsp" class="nav-link">My Profile</a></li>
        </ul>
      </div>
    </div>
  </nav>
  <!-- END nav -->

  <section class="ftco-section ftco-consult ftco-no-pt ftco-no-pb" data-stellar-background-ratio="0.5"
    style="background-image: url(images/bg_3.jpg);">
    <div class="overlay"></div>
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-md-6 py-5 px-md-5">
          <div class="py-md-5">
            <div class="heading-section heading-section-white ftco-animate mb-5">
              <h2 class="mb-4">Leave Request</h2>
              
                      <h6 style="background-color: blue; color: white; display: inline-block;"><%= session.getAttribute("firstname") %></h6></h2>
                    <h5 style="color:white;"><%= session.getAttribute("userid") %><br></h5>
                     <h4 style="color:white;"><%= session.getAttribute("branch") %><br></h4>

            </div>
            <form action="student-request-leave-action.jsp" class="appointment-form ftco-animate">

              <div class="d-md-flex">
                <div class="form-group">
                  <label for="date" style="color: white;">Start Date</label>
                  <input type="date" class="form-control pr-5" placeholder="Start Date" name="start">
                </div>

              </div>

              <div class="d-md-flex">
                <div class="form-group">
                  <label for="date" style="color: white;">End Date</label><br>
                  <input type="date" class="form-control pr-5" placeholder="Start Date" name="end">
                </div>
              </div>
              <div class="d-md-flex">
                <div class="form-group">
                  <textarea name="reason"  cols="30" rows="2" class="form-control"
                    placeholder="Reason for leave"></textarea>
                </div>
              </div>
              <div class="form-group ml-md-4">
                <input type="submit" value="Request Leave" class="btn btn-primary py-3 px-4">
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </section>



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
              <li><a href="admin-login.jsp"><span class="ion-ios-arrow-round-forward mr-2"></span>Principle</a></li>
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