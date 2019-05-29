<%@ Page Language="C#" AutoEventWireup="true" CodeFile="frm_ApplicantRegistration.aspx.cs" Inherits="Secure_Login_frm_ApplicantRegistration" %>

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

    <script src="../../js/jquery-2.1.1.min.js"></script>
    <script type="text/javascript">
        //Validation Rule
        var isFormValid = false;
        $(document).ready(function () {

            $('#registration').bootstrapValidator({
                framework: 'bootstrap',
                icon: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    txtName: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'Applicant Name is required.'
                            }
                        }
                    },
                    txtMobile: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'Mobile No. is required.'
                            },
                            stringLength: {
                                min: 10,
                                max: 10,
                                message: 'Mobile No. must be 10 digit.'
                            },
                            digits: {
                                message: 'Input Only Numeric Digit'
                            }
                        }
                    },
                    txtAadharNo: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'Aadhar No. is required.'
                            },
                            stringLength: {
                                min: 12,
                                max: 12,
                                message: 'Aadhar No. must be 12 digit.'
                            },
                            digits: {
                                message: 'Input Only Numeric Digit'
                            }
                        }
                    }
                }
            }).on('error.field.bv', function (e, data) {
                isFormValid = false;
            }).on('success.field.bv', function (e, data) {
                isFormValid = true;
            });
        });
    </script>
    <script type="text/javascript">
        function VerifyMobile() {
            var username = $('#txtName').val();
            var mobileno = $('#txtMobile').val();
            if (username == '') {
                alert("Enter your name !");
                return;
            }
            if (mobileno == '') {
                alert("Enter 10 digit Mobile number !");
                return;
            }
            if ($('#txtAadharNo').val() != "" && $('#txtAadharNo').val().length != 12) {
                alert("Enter 12 digit Aadhar number !");
                return;
            }

            if (mobileno.length == 10 && ($('#txtAadharNo').val() != "" || $('#txtAadharNo').val().length != 12)) {
                if (isFormValid) {
                    $.ajax({
                        type: "POST",
                        url: "frm_ApplicantRegistration.aspx/GetOTP",
                        data: '{mobno: "' + mobileno + '"}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (r) {
                            $('#ancOTP').click();
                        }
                    });
                }
            }
            else {
                alert("Invalid mobile no. Input 10 digit number !");
            }
        }


        function ResendOTP() {
            var mobileno = $('#txtMobile').val();

            if (mobileno.length == 10) {
                $.ajax({
                    type: "POST",
                    url: "frm_ApplicantRegistration.aspx/GetOTP",
                    data: '{mobno: "' + mobileno + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        $('#spnResendOTP').html('OTP Resend successfully.');

                    }
                });
            }
        }
    </script>

    <script type="text/javascript">
        function VerifyOTP() {
            $('#spnResendOTP').html('');
            var otptxt = $('#txtOTP').val();
            if (otptxt != '') {
                $.ajax({
                    type: "POST",
                    url: "frm_ApplicantRegistration.aspx/VerifyMobileOTP",
                    data: '{otp: "' + otptxt + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        data = JSON.parse(r.d);
                        if (data['status'] == 'VERIFY') {
                            $('#txtOTP').val('');
                            $('#otpModal').hide();
                            RegisterApplicant($('#txtName').val(), $('#txtAadharNo').val(), $('#txtMobile').val());
                        }
                        else {

                            alert("Invalid OTP");
                        }
                    }
                });
            }
            else {
                alert("Please Enter OTP");
            }
        }
        function RegisterApplicant(fullname, aadharno, mobileno) {
            var ApplicantRegistration = {}
            ApplicantRegistration.Name = fullname;
            ApplicantRegistration.MobileNo = mobileno;
            ApplicantRegistration.AadharNo = aadharno;

            $.ajax({
                type: "POST",
                url: "frm_ApplicantRegistration.aspx/ApplicantRegister",
                data: '{objApplicantRegistration: ' + JSON.stringify(ApplicantRegistration) + '}',
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    data = JSON.parse(data.d);
                    if (data['status'] == 'OK') {
                        alert(data['msg']);
                        window.location.href = "frm_ApplicantLogin.aspx";
                    }
                    else {
                        $('#otpModal').hide();
                        alert(data['msg']);
                    }
                }
            });
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
                            <div class="row" style="margin-bottom: 5px">
                                <div class="col-xs-12">
                                    <div class="lock-box">
                                        <div class="main">
                                            <form id="registration" action="#">
                                                <h4 class="text-center" style="margin-bottom: 10px; font-size: 24px">Applicant Registration</h4>
                                                <div class="form-group">
                                                    <label for="signupInputName" class="control-label">Name</label>
                                                    <input type="text" class="form-control" id="txtName" placeholder="Enter Name" name="txtName" />

                                                </div>
                                                <div class="form-group">
                                                    <label for="signupInputAadhar" class="control-label">Aadhar No</label>
                                                    <input type="number" class="form-control" id="txtAadharNo" placeholder="Enter Aadhar No" name="txtAadharNo" />

                                                </div>
                                                <div class="form-group">
                                                    <label for="signupInputMobile" class="control-label">Mobile No</label>
                                                    <input type="number" class="form-control" id="txtMobile" placeholder="Enter Mobile No" name="txtMobile" />

                                                </div>
                                                <div class="pull-left pad-btm">
                                                    <h5 style="font-size: 13px">Already Register <a href="frm_ApplicantLogin.aspx">
                                                        <span class="text-primary">Login Here</span></a></h5>
                                                </div>
                                                <button type="button" class="btn btn btn-primary pull-right" onclick="VerifyMobile()">Register </button>
                                                <a href="#" id="ancOTP" class="btn btn-primary" data-toggle="modal" data-target="#otpModal"
                                                    data-backdrop="static" data-keyboard="false" style="display: none"></a>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal fade form-horizontal" id="otpModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="myModalLabel">Validate OTP (One Time Password)</h5>
                                        <hr />
                                        <h5 class="modal-title" style="font-size: 18px">A OTP (One Time Password) has been sent to given mobile no. </h5>
                                        <h5 style="font-size: 18px">Please enter the OTP in the field below to verify</h5>
                                    </div>
                                    <div class="modal-body">
                                        <input type="number" id="txtOTP" name="txtOTP" class="form-control" />
                                        <br />
                                        <span id="spnResendOTP" style="color: green"></span>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary pull-left" id="btnResendOTP" onclick="ResendOTP()">Resend OTP</button>
                                        <button type="button" class="btn btn-primary pull-right" id="btnVerifyOTP" onclick="VerifyOTP()">Validate OTP</button>
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

      <!--jQuery [ REQUIRED ]-->
    <script src="../../js/jquery-2.1.1.min.js"></script>
    <!--BootstrapJS [ RECOMMENDED ]-->
    <script src="../../js/bootstrap.min.js"></script>
    <script src="../../plugins/bootstrap-select/bootstrap-select.min.js"></script>
    <!--Bootstrap Validator [ OPTIONAL ]-->
    <script src="../../plugins/bootstrap-validator/bootstrapValidator.min.js"></script>
    <!--Demo script [ DEMONSTRATION ]-->
    <script src="../../js/demo/pages-register.js"></script>
</body>
</html>
