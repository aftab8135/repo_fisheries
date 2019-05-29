<%@ Page Language="C#" AutoEventWireup="true" CodeFile="frm_ApplicantLogin.aspx.cs" Inherits="Secure_Login_frm_ApplicantLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Fisheries Department, Government of Uttar Pradesh </title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
    <link rel="shortcut icon" href="../../images/favicon.ico" />
    <!-- Fonts -->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700' rel='stylesheet' type='text/css' />
    <link href="http://fonts.googleapis.com/css?family=Ek+Mukta:400,500,600&amp;subset=latin,devanagari" rel="stylesheet" type="text/css" />
    <!-- Css -->
    <link rel="stylesheet" href="../../css/bootstrap.min.css" />
    <link rel="stylesheet" href="../../css/font-awesome/css/font-awesome.min.css" />
    <link rel="stylesheet" href="../../css/style_landingpage.css" />
    <link rel="stylesheet" href="../../css/responsive.css" />
    <link rel="stylesheet" href="../../css/responsive.css" />
    <!-- jS -->
    <script src="../../js/jquery.min.js" type="text/javascript"></script>
    <script src="../../js/bootstrap.min.js" type="text/javascript"></script>
    <script src="../../js/main.js" type="text/javascript"></script>

      <script src="../../js/jquery-2.1.1.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#txtPassword").keyup(function (event) {
                if (event.keyCode === 13) {
                    login();
                }
            });
        });
    </script>
    <script>
      
        function login() {
            if ($("#txtUsername").val() == '') {
                alert("Please specify username");
                $("#txtUsername").focus();
            }
            else if ($("#txtPassword").val() == '') {
                alert("Please specify your password");
                $("#txtPassword").focus();

            }
            else {
                var ApplicantRegistration = {}
                ApplicantRegistration.UserName = $("#txtUsername").val();
                ApplicantRegistration.Password = $("#txtPassword").val();
                $.ajax({
                    type: "POST",
                    url: "frm_ApplicantLogin.aspx/ApplicantLogins",
                    data: '{objUserMaster: ' + JSON.stringify(ApplicantRegistration) + '}',
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {

                        var str1 = data.d[0];
                        var str2 = data.d[1];
                        var str3 = data.d[2];

                        if (str1 == 'Invalid' && str2 == '0') {
                            alert("Invalid username or password", function () {
                                $("txtPassword").val('');

                            });
                        }
                        else if (str1 == 'NotActive' && str2 == '0') {
                            alert("Invalid username ", function () {
                                $("txtPassword").val('');

                            });
                        }

                        else if (str1 == '1') {

                            window.location.href = "/department/Dashboard.aspx";
                        }

                        else {
                            window.location.href = "/Applicant/ApplicantDashboard.aspx";
                        }
                    }
                });
            }
        }

    </script>
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
                            <i class="fa fa-unlock-alt"></i>&nbsp;  	LOGIN
                  <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu">
                            <li><a href="../../Secure/Login/DeptLogin.aspx">ADMIN LOGIN</a></li>
                            <li><a href="../../Secure/Login/frm_Login.aspx">DEPARTMENT LOGIN</a></li>
                            <li><a href="http://pisfisheries.data-center.co.in/secure/login.aspx" target="_blank">PIS LOGIN</a></li>
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
    <header class="head_top">
        <div class="container">
            <div class="row">
                <div class="col-md-12 logo_sec">
                    <a href="#">
                        <img src="../../images/logo.png" alt="logo" />
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
    <%-- <section id="catagorie">
         <div class="container">
            <div class="row top-mar">
               <div class="col-sm-12 col-md-12 text-center">
                  <a href="Secure/Login/ApplicantLogin.aspx" title="Register here" class="btn btn-warning"> <i class="fa fa-user-plus"></i>&nbsp; New User</a>
                  <a href="Secure/Login/ApplicantRegistration.aspx" title="Login" class="btn btn-warning"><i class="fa fa-user"></i>&nbsp; Registered&nbsp;User</a>
               </div>
            </div>
         </div>
      </section>--%>
    <!-- CATAGORIE Start
         ================================================== -->
    <section id="catagorie">
        <div class="container">
            <div class="row">
                <div class="col-md-12 mar_bot">
                    <div class="block2">
                        <div class="block-heading">
                            <h5>Scheme Monitoring System &amp; Various  MIS Modules</h5>
                        </div>
                        <div class="lock-wrapper">
                        <div class="row" style="margin-bottom:5px">
                            <div class="col-xs-12">
                                <div class="lock-box">
                                    <div class="main">
                                        <form role="form">
                                            <h4 class="text-center" style="margin-bottom: 10px;font-size:24px">Applicant Login</h4>
                                            <div class="form-group">
                                                <label for="inputUsername">Username</label>
                                                <input type="text" class="form-control" id="txtUsername" placeholder="Enter username" />
                                            </div>
                                            <div class="form-group">
                                                <%-- <a class="pull-right" href="ForgotPassword.aspx">Forgot password?</a>--%>
                                                <label for="inputPassword">Password</label>
                                                <input type="password" class="form-control" id="txtPassword" placeholder="Enter password" />
                                            </div>
                                            <div class="pull-left pad-btm">
                                                <h5 style="font-size:13px">New User? <a href="frm_ApplicantRegistration.aspx">
                                                    <span class="text-primary">Click Here</span></a> to Register </h5>
                                            </div>
                                            <button type="button" class="btn btn btn-primary pull-right" onclick="login()">
                                                Log In
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                            </div>
                    </div>

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
