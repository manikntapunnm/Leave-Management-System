<%-- 
    Document   : admin-student-list
    Created on : 22-Jun-2023, 2:19:01 pm
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
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>Codebook Admin</title>
  <!-- base:css -->
  <link rel="stylesheet" href="vendors/typicons/typicons.css">
  <link rel="stylesheet" href="vendors/css/vendor.bundle.base.css">
  <!-- endinject -->
  <!-- plugin css for this page -->
  <!-- End plugin css for this page -->
  <!-- inject:css -->
  <link rel="stylesheet" href="css/vertical-layout-light/style.css">
  <!-- endinject -->
  <link rel="shortcut icon" href="images/favicon.png" />
  
  <style>
  /* CSS code for pagination styling */
  .pagination {
    display: flex;
    justify-content: center;
    margin-top: 20px;
  }

  .page-box {
    display: inline-block;
    padding: 8px;
    margin: 2px;
    background-color: lightgray;
    border-radius: 4px;
    cursor: pointer;
    text-decoration: none;
    color: black;
    transition: background-color 0.3s;
  }

  .active-box {
    background-color: cyan;
    color: white;
  }

  .page-box:hover {
    background-color: white;
  }

  #page-input {
    width: 50px;
    height: 30px; 
    padding: 4px;
    border: none;
    background-color: lightgray;
    border-radius: 4px;
    text-align: center;
    font-weight: bold;
  }

  #page-input:focus {
    outline: none;
  }

  #page-form {
    display: inline-block;
  }

  #go-button {
    padding: 4px 8px;
    background-color: gray;
    border: none;
    color: white;
    cursor: pointer;
    transition: background-color 0.3s;
  }

  #go-button:hover {
    background-color: darkgray;
  }
</style>

</head>

<body>
  <div class="container-scroller">
    <!-- partial:partials/_navbar.jsp -->
    <nav class="navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
      <div class="navbar-brand-wrapper d-flex justify-content-center">
        <div class="navbar-brand-inner-wrapper d-flex justify-content-between align-items-center w-100">
          <a class="navbar-brand brand-logo" href="index.jsp">  <h5 style='color:white;'>Admin Dashboard</h5></a>
          <a class="navbar-brand brand-logo-mini" href="index.jsp">  <h6 style='color:white; font-size:"15px"'>Admin</h6></a>
          <button class="navbar-toggler navbar-toggler align-self-center" type="button" data-toggle="minimize">
            <span class="typcn typcn-th-menu"></span>
          </button>
        </div>
      </div>
      <div class="navbar-menu-wrapper d-flex align-items-center justify-content-end">
        <ul class="navbar-nav mr-lg-2">
          <li class="nav-item nav-profile dropdown">

            <div class="dropdown-menu dropdown-menu-right navbar-dropdown" aria-labelledby="profileDropdown">
              <a class="dropdown-item">
                <i class="typcn typcn-cog-outline text-primary"></i>
                Settings
              </a>
              <a class="dropdown-item">
                <button type="button" class="btn btn-primary">LogOut</button>
              </a>
            </div>
          </li>


        </ul>

        <ul class="navbar-nav navbar-nav-right">
          <ul class="navbar-nav navbar-nav-right">
            <li class="nav-item nav-search d-none d-md-block mr-0">
              <div class="input-group">
                <input type="text" class="form-control" placeholder="Search..." aria-label="search"
                  aria-describedby="search">
                <div class="input-group-prepend">
                  <span class="input-group-text" id="search">
                    <i class="typcn typcn-zoom"></i>
                  </span>
                </div>
              </div>
            </li>
          </ul>

          <li class="nav-item dropdown">
            <a class="nav-link count-indicator dropdown-toggle d-flex justify-content-center align-items-center"
              id="messageDropdown" href="#" data-toggle="dropdown">
              <i class="typcn typcn-cog-outline mx-0"></i>
              <span class="count"></span>
            </a>
            <div class="dropdown-menu dropdown-menu-right navbar-dropdown preview-list pb-2">
              <center> <button type="button" class="btn btn-warning"
                  style="color:white;background-color:rgb(198, 224, 52);"><a href="index.jsp">LogOut</a></button>
              </center>



            </div>
          </li>

        </ul>
        <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button"
          data-toggle="offcanvas">
          <span class="typcn typcn-th-menu"></span>
        </button>
      </div>
    </nav>
    <!-- partial -->
    <div class="container-fluid page-body-wrapper">
      <!-- partial:partials/_settings-panel.jsp -->
      <div class="theme-setting-wrapper">
        <div id="settings-trigger"><i class="typcn typcn-cog-outline"></i></div>
        <div id="theme-settings" class="settings-panel">
          <i class="settings-close typcn typcn-times"></i>
          <p class="settings-heading">SIDEBAR SKINS</p>
          <div class="sidebar-bg-options selected" id="sidebar-light-theme">
            <div class="img-ss rounded-circle bg-light border mr-3"></div>Light
          </div>
          <div class="sidebar-bg-options" id="sidebar-dark-theme">
            <div class="img-ss rounded-circle bg-dark border mr-3"></div>Dark
          </div>
          <p class="settings-heading mt-2">HEADER SKINS</p>
          <div class="color-tiles mx-0 px-4">
            <div class="tiles success"></div>
            <div class="tiles warning"></div>
            <div class="tiles danger"></div>
            <div class="tiles info"></div>
            <div class="tiles dark"></div>
            <div class="tiles default"></div>
          </div>
        </div>
      </div>
      <div id="right-sidebar" class="settings-panel">
        <i class="settings-close typcn typcn-times"></i>
        <ul class="nav nav-tabs" id="setting-panel" role="tablist">
          <li class="nav-item">
            <a class="nav-link active" id="todo-tab" data-toggle="tab" href="#todo-section" role="tab"
              aria-controls="todo-section" aria-expanded="true">TO DO LIST</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" id="chats-tab" data-toggle="tab" href="#chats-section" role="tab"
              aria-controls="chats-section">CHATS</a>
          </li>
        </ul>
        <div class="tab-content" id="setting-content">
          <div class="tab-pane fade show active scroll-wrapper" id="todo-section" role="tabpanel"
            aria-labelledby="todo-section">
            <div class="add-items d-flex px-3 mb-0">
              <form class="form w-100">
                <div class="form-group d-flex">
                  <input type="text" class="form-control todo-list-input" placeholder="Add To-do">
                  <button type="submit" class="add btn btn-primary todo-list-add-btn" id="add-task">Add</button>
                </div>
              </form>
            </div>
            <div class="list-wrapper px-3">
              <ul class="d-flex flex-column-reverse todo-list">
                <li>
                  <div class="form-check">
                    <label class="form-check-label">
                      <input class="checkbox" type="checkbox">
                      Team review meeting at 3.00 PM
                    </label>
                  </div>
                  <i class="remove typcn typcn-delete-outline"></i>
                </li>
                <li>
                  <div class="form-check">
                    <label class="form-check-label">
                      <input class="checkbox" type="checkbox">
                      Prepare for presentation
                    </label>
                  </div>
                  <i class="remove typcn typcn-delete-outline"></i>
                </li>
                <li>
                  <div class="form-check">
                    <label class="form-check-label">
                      <input class="checkbox" type="checkbox">
                      Resolve all the low priority tickets due today
                    </label>
                  </div>
                  <i class="remove typcn typcn-delete-outline"></i>
                </li>
                <li class="completed">
                  <div class="form-check">
                    <label class="form-check-label">
                      <input class="checkbox" type="checkbox" checked>
                      Schedule meeting for next week
                    </label>
                  </div>
                  <i class="remove typcn typcn-delete-outline"></i>
                </li>
                <li class="completed">
                  <div class="form-check">
                    <label class="form-check-label">
                      <input class="checkbox" type="checkbox" checked>
                      Project review
                    </label>
                  </div>
                  <i class="remove typcn typcn-delete-outline"></i>
                </li>
              </ul>
            </div>
            <div class="events py-4 border-bottom px-3">
              <div class="wrapper d-flex mb-2">
                <i class="typcn typcn-media-record-outline text-primary mr-2"></i>
                <span>Feb 11 2018</span>
              </div>
              <p class="mb-0 font-weight-thin text-gray">Creating component page</p>
              <p class="text-gray mb-0">build a js based app</p>
            </div>
            <div class="events pt-4 px-3">
              <div class="wrapper d-flex mb-2">
                <i class="typcn typcn-media-record-outline text-primary mr-2"></i>
                <span>Feb 7 2018</span>
              </div>
              <p class="mb-0 font-weight-thin text-gray">Meeting with Alisa</p>
              <p class="text-gray mb-0 ">Call Sarah Graves</p>
            </div>
          </div>
          <!-- To do section tab ends -->
          <div class="tab-pane fade" id="chats-section" role="tabpanel" aria-labelledby="chats-section">
            <div class="d-flex align-items-center justify-content-between border-bottom">
              <p class="settings-heading border-top-0 mb-3 pl-3 pt-0 border-bottom-0 pb-0">Friends</p>
              <small class="settings-heading border-top-0 mb-3 pt-0 border-bottom-0 pb-0 pr-3 font-weight-normal">See
                All</small>
            </div>
            <ul class="chat-list">
              <li class="list active">
                <div class="profile"><img src="images/faces/face1.jpg" alt="image"><span class="online"></span></div>
                <div class="info">
                  <p>Thomas Douglas</p>
                  <p>Available</p>
                </div>
                <small class="text-muted my-auto">19 min</small>
              </li>
              <li class="list">
                <div class="profile"><img src="images/faces/face2.jpg" alt="image"><span class="offline"></span></div>
                <div class="info">
                  <div class="wrapper d-flex">
                    <p>Catherine</p>
                  </div>
                  <p>Away</p>
                </div>
                <div class="badge badge-success badge-pill my-auto mx-2">4</div>
                <small class="text-muted my-auto">23 min</small>
              </li>
              <li class="list">
                <div class="profile"><img src="images/faces/face3.jpg" alt="image"><span class="online"></span></div>
                <div class="info">
                  <p>Daniel Russell</p>
                  <p>Available</p>
                </div>
                <small class="text-muted my-auto">14 min</small>
              </li>
              <li class="list">
                <div class="profile"><img src="images/faces/face4.jpg" alt="image"><span class="offline"></span></div>
                <div class="info">
                  <p>James Richardson</p>
                  <p>Away</p>
                </div>
                <small class="text-muted my-auto">2 min</small>
              </li>
              <li class="list">
                <div class="profile"><img src="images/faces/face5.jpg" alt="image"><span class="online"></span></div>
                <div class="info">
                  <p>Madeline Kennedy</p>
                  <p>Available</p>
                </div>
                <small class="text-muted my-auto">5 min</small>
              </li>
              <li class="list">
                <div class="profile"><img src="images/faces/face6.jpg" alt="image"><span class="online"></span></div>
                <div class="info">
                  <p>Sarah Graves</p>
                  <p>Available</p>
                </div>
                <small class="text-muted my-auto">47 min</small>
              </li>
            </ul>
          </div>
          <!-- chat tab ends -->
        </div>
      </div>
      <!-- partial -->
      <!-- partial:partials/_sidebar.jsp -->
      <nav class="sidebar sidebar-offcanvas" id="sidebar">
        <ul class="nav">
          <li class="nav-item">
            <a class="nav-link" href="admin-dashboard.jsp">
              <i class="typcn typcn-device-desktop menu-icon"></i>
              <span class="menu-title">Dashboard</span>
              <div class="badge badge-danger">new</div>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#ui-basic" aria-expanded="false" aria-controls="ui-basic">
              <img style="width:25px; height:25px;" src="icons/user.png" alt="">
              &nbsp; &nbsp;<span class="menu-title">Employee</span>
              <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="ui-basic">
              <ul class="nav flex-column sub-menu">
                <li class="nav-item"> <a class="nav-link" href="admin-add-employee.jsp">Add Employee</a></li>
                <li class="nav-item"> <a class="nav-link" href="admin-employee-list.jsp">Manage Employee</a></li>
              </ul>
            </div>
          </li>
          <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#form-elements" aria-expanded="false"
              aria-controls="form-elements">
              <img style="width:25px; height:25px;" src="icons/a1.png" alt="">
              &nbsp; &nbsp;<span class="menu-title">Student</span>
              <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="form-elements">
              <ul class="nav flex-column sub-menu">
                <li class="nav-item"> <a class="nav-link" href="admin-add-student.jsp">Add Student</a></li>
                <li class="nav-item"> <a class="nav-link" href="admin-student-list.jsp">Manage Student</a></li>

              </ul>
            </div>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="admin-leave-request.jsp">
              <img style="width:25px; height:25px;" src="icons/a2.png" alt="">
              &nbsp; &nbsp;<span class="menu-title">Leave Request</span>

            </a>
          </li>
      </nav>
      <!-- partial -->
      
      
      
      <%--
   Connection con = null;
   Statement st = null;
   ResultSet rs = null;

   try {
      String url = "jdbc:mysql://localhost:3306/codebook";
      String username = "root";
      String dbpassword = "";
      Class.forName("com.mysql.jdbc.Driver");
      con = DriverManager.getConnection(url, username, dbpassword);
      st = con.createStatement();
      rs = st.executeQuery("SELECT * FROM studentd");
--%>



  <%
    // Assuming you have retrieved the total number of leave requests in the database
    int totalLeaveRequests = 0; // Set an initial value

    // Define the number of leave requests to display per page
    int requestsPerPage = 6;

    // Calculate the total number of pages
    int totalPages = 0; // Set an initial value

    // Get the current page number from the request parameter
    int currentPage = 1;
    String pageParam = request.getParameter("page");
    if (pageParam != null) {
      currentPage = Integer.parseInt(pageParam);
      if (currentPage < 1) {
        currentPage = 1;
      }
    }

    // Calculate the starting index for the current page
    int startIndex = (currentPage - 1) * requestsPerPage;

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
      String url = "jdbc:mysql://localhost:3306/codebook";
      String username = "root";
      String dbpassword = "";
      Class.forName("com.mysql.jdbc.Driver");
      con = DriverManager.getConnection(url, username, dbpassword);

      // Retrieve the total number of leave requests from the database
      String countQuery = "SELECT COUNT(*) AS total FROM studentd";
      Statement countStatement = con.createStatement();
      ResultSet countResult = countStatement.executeQuery(countQuery);
      if (countResult.next()) {
        totalLeaveRequests = countResult.getInt("total");
      }
      countResult.close();
      countStatement.close();

      // Calculate the total number of pages
      totalPages = (int) Math.ceil((double) totalLeaveRequests / requestsPerPage);

      // Modify your database query to include pagination using the LIMIT clause
     String query = "SELECT * FROM studentd LIMIT ?, ?";

      ps = con.prepareStatement(query);
      ps.setInt(1, startIndex);
      ps.setInt(2, requestsPerPage);

      // Execute the query and process the results
      rs = ps.executeQuery();
  %>



      <div class="container-fluid">
        <div class="row">
          <div class="col-lg-12">
            <h4 class="card-title">Student Table</h4>
            <div class="table-responsive">
              <table class="table">
                <thead>
                  <tr>
                    <th>User</th>
                    <th>UserId</th>
                    <th>Name</th>
                    <th>Branch</th>
                    <th>Email</th>
                    <th>phone</th>
                    <th>Address</th>
                    <th>Action</th>
                  </tr>
                </thead>
                <tbody>
                        <% while (rs.next()) { %> 
                  <tr>
                    <td class="py-1">
                         <% if (rs.getBytes("image") != null) { %>
        <% byte[] imageData = rs.getBytes("image"); %>
        <% String base64Image = Base64.getEncoder().encodeToString(imageData); %>
        <img src="data:image/jpeg;base64, <%= base64Image %>" alt="user-image" width="50" height="50">
    <% } else { %>
        <img src="path/to/default-image.jpg" alt="default-user-image" width="50" height="50">
    <% } %>
                       <%--= rs.getString(1) --%>
                    </td>
                    <td ><%= rs.getString(2) %></td>
                    <td ><%= rs.getString(4) %></td>
                    <td ><%= rs.getString(9) %></td>
                    <td ><%= rs.getString(13) %></td>
                    <td ><%= rs.getString(14) %></td>
                    <td ><%= rs.getString(16) %></td>

                   
                    <td>
                   <a href="admin-manage-student.jsp?id=<%=rs.getString(1)%>"><button class="btn btn-sm btn-primary">Update</button></a>
                      <a href="remove-student.jsp?id=<%=rs.getString(1)%>"><button class="btn btn-sm btn-danger">Remove</button></a>
                    </td>

                  </tr>
                                    <% } %>
                </tbody>
              </table>
                
                 <div class="pagination text-center">
  <% if (currentPage > 1) { %>
    <a href="?page=<%= currentPage - 1 %>" class="page-box"><</a>
  <% } %>

  <a href="?page=<%= currentPage %>" class="page-box active-box"><%= currentPage %></a>

  <% if (currentPage < totalPages) { %>
    <a href="?page=<%= currentPage + 1 %>" class="page-box">></a>
  <% } %>

  <form id="page-form" action="" method="get">
    <input type="number" name="page" id="page-input" min="1" max="<%= totalPages %>" value="<%= currentPage %>">
 
  </form>
</div>
            </div>
          </div>
        </div>
      </div>
                
                
           
    
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.all.min.js"></script>

    <%-- Check if the success message session attribute exists and display the Sweet Alert --%>
    <%
        String removeSuccessMessage = (String) request.getSession().getAttribute("removeSuccessMessage");
        if (removeSuccessMessage != null && !removeSuccessMessage.isEmpty()) {
            out.println("<script>");
            out.println("Swal.fire({");
            out.println("  icon: 'success',");
            out.println("  title: 'Success',");
            out.println("  text: '" + removeSuccessMessage + "',");
            out.println("});");
            out.println("</script>");
            // Remove the session attribute to prevent displaying the message again on subsequent requests
            request.getSession().removeAttribute("removeSuccessMessage");
        }
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
    
    
    
    
    
    <!-- Display the success alert -->
    <%-- String successMessage = (String) request.getSession().getAttribute("registrationSuccess");
       if (successMessage != null) {
    %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <%= successMessage %>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
            
             <% // Remove the session attribute after displaying the success message
           request.getSession().removeAttribute("registrationSuccess");
        %>
    <% } %>

    <!-- Display the error alert -->
    <% String errorMessage = (String) request.getSession().getAttribute("registrationError");
       if (errorMessage != null) {
    %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <%= errorMessage %>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
            
            <% // Remove the session attribute after displaying the error message
           request.getSession().removeAttribute("registrationError");
        %>
    <% } --%>
    
    
    
    
           
                
<%
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close the resources in the reverse order of their creation
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
           /* if (st != null) {
                try {
                    st.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }*/
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>




      <!-- main-panel ends -->
    </div>
    <!-- page-body-wrapper ends -->
  </div>
  <!-- container-scroller -->

  <!-- base:js -->
  <script src="vendors/js/vendor.bundle.base.js"></script>
  <!-- endinject -->
  <!-- Plugin js for this page-->
  <script src="vendors/chart.js/Chart.min.js"></script>
  <!-- End plugin js for this page-->
  <!-- inject:js -->
  <script src="js/off-canvas.js"></script>
  <script src="js/hoverable-collapse.js"></script>
  <script src="js/template.js"></script>
  <script src="js/settings.js"></script>
  <script src="js/todolist.js"></script>
  <!-- endinject -->
  <!-- Custom js for this page-->
  <script src="js/dashboard.js"></script>
  <!-- End custom js for this page-->
</body>

</html>

