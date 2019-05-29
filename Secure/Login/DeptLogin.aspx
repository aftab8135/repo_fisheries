<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DeptLogin.aspx.cs" Inherits="Secure_Login_DeptLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Admin Login | Fisheries Department </title>
    <link rel="shortcut icon" href="../../img/favicon.ico" />
    <!--STYLESHEET-->
    <!--=================================================-->
    <!--Roboto Slab Font [ OPTIONAL ] -->
    <link href="http://fonts.googleapis.com/css?family=Roboto+Slab:400,300,100,700" rel="stylesheet" />
    <link href="http://fonts.googleapis.com/css?family=Roboto:500,400italic,100,700italic,300,700,500italic,400" rel="stylesheet" />
    <!--Bootstrap Stylesheet [ REQUIRED ]-->
    <link href="../../css/bootstrap.min.css" rel="stylesheet" />
    <!--Jasmine Stylesheet [ REQUIRED ]-->
    <link href="../../css/style.css" rel="stylesheet" />
    <!--Font Awesome [ OPTIONAL ]-->
    <link href="../../plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
    <!--Bootstrap Select [ OPTIONAL ]-->
    <link href="../../plugins/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />
    <!--Demo [ DEMONSTRATION ]-->
    <link href="../../css/demo/jasmine.css" rel="stylesheet" />
    <!--SCRIPT-->
    <script src="../../js/jquery-2.1.1.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
        //    $('#pnlLogin').hide();
            $.ajax({
                type: "POST",
                url: "DeptLogin.aspx/GetLoginType",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var ddlUserType = $("[id*=ddlUserType]");
                    $.each(r.d, function () {
                        ddlUserType.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    ddlUserType.selectpicker('refresh');
                },
                error: function error(er) {
                    alert(er);
                }
            });

            $('#ddlUserType').on('change', function () {
                $('#pnlLogin').show();
            });

            $("#txtPassword").keyup(function (event) {
                if (event.keyCode === 13) {
                    $("#btnLogin").click();
                }
            });

        });
    </script>
    <script>
        function dashboard() {
            window.location.href = "../../Department/Dashboard.aspx";
        }

        function login() {

            if ($("#ddlUserType option:selected").val() == '0') {
                alert("Please select login type");    
            }

            else if ($("#txtUsername").val() == '') {
                alert("Please specify username");
            }
            else if ($("#txtPassword").val() == '') {
                alert("Please specify your password");
            }
            else {

                var UserMaster = {}
                UserMaster.UserName = $("#txtUsername").val();
                UserMaster.Password = $("#txtPassword").val();
                UserMaster.UserType = 4; //This is for super admin

                $.ajax({
                    type: "POST",
                    url: "DeptLogin.aspx/UserLogins",
                    data: '{objUserMaster: ' + JSON.stringify(UserMaster) + '}',
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {

                        var str1 = data.d[0];
                        var str2 = data.d[1];
                        var str3 = data.d[2];

                        if (str1 == 'Invalid' && str2 == '0') {
                            alert("Invalid username or password", function () {
                                $("#txtPassword").val('');

                            });
                        }
                        else if (str1 == 'NotActive' && str2 == '0') {
                            alert("User not activated", function () {

                            });
                        }

                        else if (str1 == '1') {
                            window.location.href = "/Administrator/Dashboard.aspx";
                        }

                        else if (str1 == '7') {
                            window.location.href = "/Shasan/Dashboard.aspx";
                        }
                    }
                });
            }
        }

        function loginback() {
            window.location.href = "../../Default.aspx";
        }
    </script>

</head>

<body>
    <div id="container">
        <div class="lock-wrapper"  style="margin: 2% auto;">
            <div class="row">
                 <div class="col-xs-12">
                    <div class="center logocenter">
                        <img alt="" src="../../img/Uttar-Pradesh-govt.png" class="img-circle" />
                    </div>
                    <h2>मत्स्य विभाग</h2>
                    <h3>उत्तर प्रदेश सरकार</h3>

                </div> 
                <div class="col-md-12" >
                     <h3 style="line-height:33px">Scheme Monitoring System & Various
                         <br /> MIS Modules</h3>
                </div>        
            </div>

            <div class="row mar-top">
                <div class="col-xs-12">
                    <div class="lock-box">
                        <div class="main">
                            <form role="form">
                                 <h4 class="text-center" style="margin-bottom:20px">Administrator Login</h4>
                                <div class="form-group">
                                    
                                       <label for="txtUsername">Login Type</label>
                                        <select class="form-control selectpicker" id="ddlUserType">
                                            <option value="0" selected>Select</option>
                                        </select>
                                      
                                </div>
                            
                                <div id="pnlLogin">
                                    <div class="form-group">
                                        <label for="txtUsername">Username</label>
                                        <input type="text" class="form-control" id="txtUsername" placeholder="Enter username" />
                                    </div>
                                    <div class="form-group">
                                     <%--   <a class="pull-right" href="ForgotPassword.aspx">Forgot password?</a>--%>
                                        <label for="txtPassword">Password</label>
                                        <input type="password" class="form-control" id="txtPassword" placeholder="Enter passsword" />
                                    </div>
                                </div>

                                <%-- <div class="pull-left pad-btm">
                                    <h5>New User? <a href="Registration.aspx"><span class="text-primary">Click Here</span></a> to Register </h5>
                                </div>--%>
                                  <button type="button" class="btn btn btn-warning pull-left" onclick="loginback()" id="btnBack">
                                    Back
                                </button>
                                <button type="button" class="btn btn btn-primary pull-right" onclick="login()" id="btnLogin">
                                    Log In
                                </button>
                            </form>

                        </div>

                    </div>
                </div>

            </div>
        </div>

    </div>
    <!--===================================================-->
    <!-- END OF CONTAINER -->
    <!--JAVASCRIPT-->
    <!--=================================================-->
    <!--jQuery [ REQUIRED ]-->
    <script src="../../js/jquery-2.1.1.min.js"></script>
    <!--BootstrapJS [ RECOMMENDED ]-->
    <script src="../../js/bootstrap.min.js"></script>
    <!--Fast Click [ OPTIONAL ]-->
    <script src="../../plugins/fast-click/fastclick.min.js"></script>
    <!--Switchery [ OPTIONAL ]-->
    <script src="../../plugins/switchery/switchery.min.js"></script>
    <!--Bootstrap Select [ OPTIONAL ]-->
    <script src="../../plugins/bootstrap-select/bootstrap-select.min.js"></script>
</body>
</html>
