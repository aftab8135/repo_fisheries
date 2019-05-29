<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <title>Fisheries Department, Government of Uttar Pradesh </title>
     <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
      <link rel="shortcut icon" href="images/favicon.ico" />
      <!-- Fonts -->
      <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700' rel='stylesheet' type='text/css' />
      <link href="http://fonts.googleapis.com/css?family=Ek+Mukta:400,500,600&amp;subset=latin,devanagari" rel="stylesheet" type="text/css" />
      <!-- Css -->
      <link rel="stylesheet" href="../css/bootstrap.min.css" />
      <link rel="stylesheet" href="../css/font-awesome/css/font-awesome.min.css" />
      <link rel="stylesheet" href="../css/style_landingpage.css" />
      <link rel="stylesheet" href="../css/responsive.css" />
      <!-- jS -->
      <script src="../js/jquery.min.js" type="text/javascript"></script>
      <script src="../js/bootstrap.min.js" type="text/javascript"></script>
      <script src="../js/main.js" type="text/javascript"></script>
</head>
<body>
    <!-- MENU Start
         ================================================== -->
      <nav class="navbar navbar-default nav_bg">
         <div class="container">
         <a class="navbar-brand" href="#">
            <h5 class="text-white">Fisheries Department
               Government Of Uttar Pradesh
            </h5>
         </a>
         <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            </button>
         </div>
         <!-- End of /.navbar-header -->
         <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav nav-main">
               <li class="dropdown">
                  <a href="#">
                  <i class="fa fa-unlock-alt"></i>&nbsp; LOGIN
                  <span class="caret"></span>
                  </a>
                  <ul class="dropdown-menu">
                     <li><a href="Secure/Login/DeptLogin.aspx">ADMIN LOGIN</a></li>
                     <li><a href="Secure/Login/frm_Login.aspx">DEPARTMENT LOGIN</a></li>
                     <li><a href="http://pisfisheries.data-center.co.in/secure/login.aspx"  target="_blank">PIS LOGIN</a></li>
                     <li><a href="http://legalfisheries.data-center.co.in/Secure/Login/frm_Login.aspx" target="_blank">LEGAL LOGIN</a></li>
                  </ul>
               </li>
               <!-- End of /.dropdown -->
            </ul>
            <!-- End of /.nav-main -->
         </div>
         <!-- /.container-fluid -->
        </div>
      </nav>
      <!-- End of /.nav -->
      <!-- LOGO Start
         ================================================== -->
      <header>
         <div class="container">
            <div class="row">
               <div class="col-md-12 logo_sec">
                  <a href="#">
                  <img src="images/logo.png" alt="logo">
                  </a>
                  <h2>मत्स्य विभाग</h2>
                  <h2 style="font-size: 20px; font-weight: 400;">उत्तर प्रदेश सरकार</h2>
               </div>
               <!-- End of /.col-md-12 -->
            </div>
            <!-- End of /.row -->
         </div>
         <!-- End of /.container -->
      </header>
      <!-- End of /Header -->
      <section id="catagorie">
         <div class="container">
            <div class="row top-mar">
               <div class="col-sm-12 col-md-12 text-center">
                  <a href="../../Secure/Login/frm_ApplicantRegistration.aspx" title="Register here" class="btn btn-warning"> <i class="fa fa-user-plus"></i>&nbsp; New User</a>
                  <a href="../../Secure/Login/frm_ApplicantLogin.aspx" title="Login" class="btn btn-warning"><i class="fa fa-user"></i>&nbsp; Registered&nbsp;User</a>
               </div>
            </div>
         </div>
      </section>
      <!-- CATAGORIE Start
         ================================================== -->
      <section id="catagorie">
         <div class="container">
            <div class="row">
               <div class="col-md-12">
                  <div class="block">
                     <div class="block-heading">
                        <h5>Scheme Monitoring System &amp; Various  MIS Modules</h5>
                     </div>
                     <div class="row thumbnail_img">
                        <div class="col-sm-6 col-md-3 col-xs-6">
                           <div class="thumbnail text-center">
                              <img src="images/category-image-1.jpg" alt="...">
                           </div>
                           <!-- End of /.thumbnail -->
                        </div>
                        <!-- End of /.col-sm-6 col-md-4 -->
                        <div class="col-sm-6 col-md-3 col-xs-6">
                           <div class="thumbnail text-center">
                              <img src="images/category-image-2.jpg" alt="...">
                           </div>
                           <!-- End of /.thumbnail -->
                        </div>
                        <!-- End of /.col-sm-6 col-md-4 -->
                        <div class="col-sm-6 col-md-3 col-xs-6">
                           <div class="thumbnail text-center">
                              <img src="images/category-image-3.jpg" alt="...">
                           </div>
                           <!-- End of /.thumbnail -->
                        </div>
                        <!-- End of /.col-sm-6 col-md-4 -->
                        <div class="col-sm-6 col-md-3 col-xs-6">
                           <div class="thumbnail text-center">
                              <img src="images/category-image-4.jpg" alt="...">
                           </div>
                           <!-- End of /.thumbnail -->
                        </div>
                        <!-- End of /.col-sm-6 col-md-4 -->
                     </div>
                     <!-- End of /.row -->
                  </div>
                  <!-- End of /.block --> 
               </div>
               <!-- End of /.col-md-12 -->
            </div>
            <!-- End of /.row -->
         </div>
         <!-- End of /.container -->
      </section>
      <!-- End of Section -->
      <!-- FOOTER-BOTTOM Start
         ================================================== -->

      <div class="footer-bottom">
         <div class="container">
            <div class="row">
               <div class="col-md-12">
                  <p class="copyright-text text-center">© 2018 Fisheries Department, Government of Uttar Pradesh | Designed & Developed by MARG Software Solutions</p>
               </div>
               <!-- End Of /.col-md-12 -->	
            </div>
            <!-- End Of /.row -->	
         </div>
         <!-- End Of /.container -->	
      </div>
      <!-- End Of /.footer-bottom -->
    <!-- End Of Footer -->
</body>
</html>
