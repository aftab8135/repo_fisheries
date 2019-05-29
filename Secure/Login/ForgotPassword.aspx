<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs"  %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  
     <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Forgot Password | Fisheries Department </title>
    <link rel="shortcut icon" href="../img/favicon.ico" />
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
    <!--Switchery [ OPTIONAL ]-->
    <link href="../../plugins/switchery/switchery.min.css" rel="stylesheet" />
    <!--Bootstrap Select [ OPTIONAL ]-->
    <link href="../../plugins/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />
    <!--Demo [ DEMONSTRATION ]-->
    <link href="../../css/demo/jasmine.css" rel="stylesheet" />
    <!--SCRIPT-->
    <!--=================================================-->
    <!--Page Load Progress Bar [ OPTIONAL ]-->
  <%--  <link href="../../plugins/pace/pace.min.css" rel="stylesheet" />
    <script src="../../plugins/pace/pace.min.js"></script>--%>

        <script src="../../js/jquery-2.1.1.min.js"></script>
    <script>
        function dashboard() {
            window.location.href = "../../Department/Dashboard.aspx";
        }

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


                var UserMaster = {}


                UserMaster.UserName = $("#txtUsername").val();

                UserMaster.Password = $("#txtPassword").val();

                $.ajax({
                    type: "POST",
                    url: "ApplicantLogin.aspx/ApplicantLogins",
                    data: '{objUserMaster: ' + JSON.stringify(UserMaster) + '}',
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {

                        var str1 = data.d[0];
                        var str2 = data.d[1];
                        var str3 = data.d[2];

                        if (str1 == 'Invalid' && str2 == '0') {
                            alert("Invalid username or password", function () {
                                //  $("#txtUsername").val('');
                                $("txtPassword").val('');

                            });
                        }
                        else if (str1 == 'NotActive' && str2 == '0') {
                            bootbox.alert("User not activated", function () {
                                //  $("#txtUsername").val('');
                                // $("txtPassword").val('');

                            });
                        }

                        else if (str1 == '1') {

                            window.location.href = "/department/Dashboard.aspx";
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
        <div class="lock-wrapper">
            <div class="row">
                <div class="col-xs-12">
                    <div class="lock-box">
                        <div class="main">
                                <div class="center logocenter">
                    <img alt="" src="../../img/user.png" class="img-circle" />
                </div>
                            <h4>Forgot Password </h4>
                <p class="text-center">Please login to Access your Account</p>
                          
                            <form role="form">
                                <div class="form-group">
                                    <label for="inputUsername">User Name</label>
                                    <asp:TextBox ID="txtUser" type="text" class="form-control" runat="server">

                                    </asp:TextBox>
                                 
                                </div>
                               
                               <div class="form-group logocenter">
                                 <span>OR</span> 
                                </div>

                                 <div class="form-group">
                                    <label for="inputAadharNo">Aadhar No</label>
                                      <asp:TextBox ID="txtAadhar"  type="number" class="form-control" runat="server">

                                    </asp:TextBox>
                                    
                                </div>
                               <div class="form-group">
                                    <label for="inputMobileNo">Registered Mobile No</label>
                                     <asp:TextBox ID="txtMobile"  type="number" class="form-control" runat="server">
                                         </asp:TextBox>
                                
                                </div>
                                <div class="pull-left pad-btm">
                                  <a href="ApplicantLogin.aspx"><span class="text-primary">Back To Login</span></a>
                                </div>

                                <button type="button" class="btn btn btn-primary pull-right" onclick="login()">
                                    Get Password
                                </button>
                            </form>

                        </div>

                    </div>
                </div>

            </div>
        </div>
      
    </div>

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
