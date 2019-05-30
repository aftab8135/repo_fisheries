<%@ Page Language="C#" AutoEventWireup="true" CodeFile="frm_Login.aspx.cs" Inherits="Secure_Login_frm_Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Department Login | Fisheries Department </title>
    <link rel="shortcut icon" href="../../img/favicon.ico" />
    <!--STYLESHEET-->
    <!--=================================================-->
    <!--Roboto Slab Font [ OPTIONAL ] -->
    <link href="http://fonts.googleapis.com/css?family=Roboto+Slab:400,300,100,700" rel="stylesheet" />
    <link href="http://fonts.googleapis.com/css?family=Roboto:500,400italic,100,700italic,300,700,500italic,400" rel="stylesheet" />
    <!--Bootstrap Stylesheet [ REQUIRED ]-->
    <link href="<%=ResolveUrl("~/css/bootstrap.min.css") %>" rel="stylesheet" />
    <!--Jasmine Stylesheet [ REQUIRED ]-->
    <link href="<%=ResolveUrl("~/css/style.css") %>" rel="stylesheet" />
    <!--Font Awesome [ OPTIONAL ]-->
    <link href="<%=ResolveUrl("~/plugins/font-awesome/css/font-awesome.min.css") %>" rel="stylesheet" />
    <!--Switchery [ OPTIONAL ]-->
    <link href="<%=ResolveUrl("~/plugins/switchery/switchery.min.css") %>" rel="stylesheet" />
    <!--Bootstrap Select [ OPTIONAL ]-->
    <link href="<%=ResolveUrl("~/plugins/bootstrap-select/bootstrap-select.min.css") %>" rel="stylesheet" />
    <!--Demo [ DEMONSTRATION ]-->
    <link href="<%=ResolveUrl("~/css/demo/jasmine.css") %>" rel="stylesheet" />
    <!--SCRIPT-->
    <!--=================================================-->
    <!--Page Load Progress Bar [ OPTIONAL ]-->
    <%-- <link href="<%=ResolveUrl("~/plugins/pace/pace.min.css") %>" rel="stylesheet" />
    <script src="<%=ResolveUrl("~/plugins/pace/pace.min.js") %>"></script>--%>

    <%-- <link href="<%=ResolveUrl("~/css/demo/jquery.Wload.css") %>" rel="stylesheet" />--%>
    <script src="<%=ResolveUrl("~/js/jquery-2.1.1.min.js") %>"></script>

    <!--Form Loader-->
    <script src="<%=ResolveUrl("~/js/demo/jquery.Wload.js") %>"></script>
    <script>
        function dashboard() {
            var tt = $('.bootstrap-select').find("select > optgroup> option:selected").val();
            if (tt == 5) { //District
                window.location.href = "../../../DBT/District/Dashboard.aspx";
            }
            else if (tt == 6) { //Division
                window.location.href = "../../../DBT/Division/Dashboard.aspx";
            }
            else if (tt == 4) {
                window.location.href = "../../../DBT/HeadQuarter/Dashboard.aspx";
            }
            else {
                alert("Select Login Type");
            }
            //  window.location.href = "../../../DBT/District/Dashboard.aspx";
        }

        function AdminLogin() {

            window.location.href = "../../Secure/Login/DeptLogin.aspx";
        }

        $(document).ready(function () {

            $("div#divDistrict").hide();
            $("div#divDivision").hide();
            $("div#divUserName").show();

            $("#txtPassword").keyup(function (event) {
                if (event.keyCode === 13) {
                    $("#btnLogin").click();
                }
            });
        });

        function onLoginTypeChange() {
            var tt = $('.bootstrap-select').find("select > optgroup> option:selected").val();

            if (tt == 5) { //District
                $("div#divDistrict").show();
                $("div#divDivision").hide();
                $("div#divUserName").hide();
            }
            else if (tt == 6) { //Division
                $("div#divDistrict").hide();
                $("div#divDivision").show();
                $("div#divUserName").hide();
            }
            else {
                $("div#divDistrict").hide();
                $("div#divDivision").hide();
                $("div#divUserName").show();
            }

        }
    </script>

    <%-- For Load Control --%>
    <script type="text/javascript">
        $(document).ready(function () {
            //$('body').Wload({ text: ' Loading' });
            $.ajax({
                type: "POST",
                url: "frm_Login.aspx/GetDistrict",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var ddl = $("#ddlDistrict");
                    ddl.append($("<option selected disabled hidden></option>").val('').html('चयन करें'));
                    $.each(r.d, function () {
                        ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    ddl.selectpicker('refresh');
                }
            });
            $.ajax({
                type: "POST",
                url: "frm_Login.aspx/GetMandal",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var ddl = $("#ddlMandal");
                    ddl.append($("<option selected disabled hidden></option>").val('').html('चयन करें'));
                    $.each(r.d, function () {
                        ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    ddl.selectpicker('refresh');
                }
            });

            $.ajax({
                type: "POST",
                url: "frm_Login.aspx/GetFinancialYear",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var ddl = $("#ddlFinYear");
                    ddl.append($("<option selected disabled hidden></option>").val('').html('चयन करें'));
                    $.each(r.d, function () {
                        ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    ddl.selectpicker('refresh');
                    $('body').Wload('hide', { time: 0 });
                }
            });

        });


        function loginback() {
            window.location.href = "../../Default.aspx";
        }

    </script>

    <%-- For User Login --%>
    <script type="text/javascript">
        function login() {

            var UserName = $("#txtUsername").val();
            var Password = $("#txtPassword").val();
            var FinYear = $("#ddlFinYear").val();
            var loginType = $("#loginType").val();

            var DistrictName = $("[data-id='ddlDistrict']").text();
            var DivisionName = $("[data-id='ddlMandal']").text();

            var Division = $("#ddlMandal").val();
            var District = $("#ddlDistrict").val();

            if (loginType == 4) {
                if (FinYear == null) {
                    alert("कृपया वित्तीय वर्ष का चयन करें।");
                } else if (UserName.toString().trim() == '') {
                    alert("कृपया उपयोगकर्ता का नाम डालें।");
                }
                else if (Password.toString().trim() == '') {
                    alert("कृपया उपयोगकर्ता का पासवर्ड डालें।");
                }
                else {
                    //  $('body').Wload({ text: ' Loading' });
                    $.ajax({
                        type: "POST",
                        url: "frm_Login.aspx/UserLogin",
                        data: '{UserName : ' + JSON.stringify(UserName) + ', Password :' + JSON.stringify(Password) + ', FinancialYear : ' + JSON.stringify(FinYear) + ',UserType:"HeadOffice"}',
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (i) {
                            var id = i.d;
                            if (id == "1") {
                                // $('body').Wload('hide', { time: 0 });
                                window.location.href = "../../DBT/HeadQuarter/Dashboard.aspx";
                            } else if (id == "-1") {
                                alert('उपयोग कर्ता का विवरण नहीं हैं।');
                            } else {
                                alert('अज्ञात त्रुटि प्राप्त हुई।');
                            }
                        }
                    });

                }
            }
            else if (loginType == 6) {
                if (Division == 0) {
                    alert("कृपया मण्डल का चयन करें।");
                } else if (Password.toString().trim() == '') {
                    alert("कृपया उपयोगकर्ता का पासवर्ड डालें।");
                } else if (FinYear.toString().trim() == '') {
                    alert("कृपया वित्तीय वर्ष का चयन करें।");
                }
                else {
                    $.ajax({
                        type: "POST",
                        url: "frm_Login.aspx/UserLogin",
                        data: '{UserName : ' + JSON.stringify(DivisionName) + ', Password :' + JSON.stringify(Password) + ', FinancialYear : ' + JSON.stringify(FinYear) + ',UserType:"Division"}',
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (i) {
                            var id = i.d;
                            if (id == "1") {
                                window.location.href = "../../DBT/Division/Dashboard.aspx";
                            } else if (id == "-1") {
                                alert('उपयोग कर्ता का विवरण नहीं हैं।');
                            } else {
                                alert('अज्ञात त्रुटि प्राप्त हुई।');
                            }
                        }
                    });

                }

            }
            else if (loginType == 5) {
                if (District == 0) {
                    alert("कृपया जनपद का चयन करें।");
                }
                else if (Password.toString().trim() == '') {
                    alert("कृपया उपयोगकर्ता का पासवर्ड डालें।");
                } else if (FinYear.toString().trim() == '') {
                    alert("कृपया वित्तीय वर्ष का चयन करें।");
                }
                else {
                    $.ajax({
                        type: "POST",
                        url: "frm_Login.aspx/UserLogin",
                        data: '{UserName : ' + JSON.stringify(DistrictName) + ', Password :' + JSON.stringify(Password) + ', FinancialYear : ' + JSON.stringify(FinYear) + ',UserType:"District"}',
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (i) {
                            var id = i.d;
                            if (id == "1") {
                                window.location.href = "../../DBT/District/Dashboard.aspx";
                            } else if (id == "-1") {
                                alert('उपयोग कर्ता का विवरण नहीं हैं।');
                            } else {
                                alert('अज्ञात त्रुटि प्राप्त हुई।');
                            }
                        }
                    });

                }
            } else {
                alert('कृपया लोगिन स्तर का चयन करें।');
            }
        }
    </script>
</head>
<body>
    <div id="container">
        <div class="lock-wrapper" style="margin: 2% auto;">
            <div class="row">
                <div class="col-xs-12">
                    <div class="center logocenter">
                        <img alt="" src="../../img/Uttar-Pradesh-govt.png" class="img-circle" />
                    </div>
                    <h2>मत्स्य विभाग</h2>
                    <h3>उत्तर प्रदेश सरकार</h3>

                </div>
                <div class="col-md-12">
                    <h3 style="line-height: 33px">Scheme Monitoring System & Various
                         <br />
                        MIS Modules</h3>
                </div>
            </div>

            <div class="row mar-top">
                <div class="col-xs-12">
                    <div class="lock-box">
                        <div class="main">

                            <form role="form">
                                <h4 class="text-center" style="margin-bottom: 20px">Department Login</h4>
                                <div class="form-group">

                                    <select class="form-control selectpicker" id="loginType" name="logintype" onchange="onLoginTypeChange()">
                                        <option hidden disabled selected>लोगिन स्तर का चयन करें</option>
                                        <optgroup label="प्रदेश स्तर">
                                            <option value="4">निदेशक (मत्स्य)</option>

                                        </optgroup>
                                        <optgroup label="मण्डल स्तर ">
                                            <option value="6">उप निदेशक (मत्स्य)</option>

                                        </optgroup>
                                        <optgroup label="जनपद स्तर">
                                            <option value="5">सहायक निदेशक (मत्स्य)</option>

                                        </optgroup>

                                    </select>
                                </div>
                                <div class="form-group" id="divDivision">
                                    <label for="inputUsername">मण्डल</label>
                                    <select class="form-control selectpicker" data-live-search="true" id="ddlMandal">
                                    </select>
                                </div>
                                <div class="form-group" id="divDistrict">
                                    <label for="inputUsername">जनपद</label>
                                    <select class="form-control selectpicker" data-live-search="true" id="ddlDistrict">
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="inputUsername">वित्तीय वर्ष</label>
                                    <select class="form-control selectpicker" id="ddlFinYear">
                                    </select>
                                </div>
                                <div class="form-group" id="divUserName">
                                    <label for="inputUsername">यूजर का नाम</label>
                                    <input type="text" class="form-control" id="txtUsername" />
                                </div>
                                <div class="form-group">
                                    <%-- <a class="pull-right" href="ForgotPassword.aspx">Forgot password?</a>--%>
                                    <label for="inputPassword">पासवर्ड </label>
                                    <input type="password" class="form-control" id="txtPassword" />
                                </div>
                                <%-- <div class="pull-left pad-btm">
                                    <h5>New User? <a href="Registration.aspx"><span class="text-primary">Click Here</span></a> to Register </h5>
                                </div>--%>
                                <button type="button" class="btn btn btn-warning pull-left" onclick="loginback()" id="btnBack">
                                    Back
                                </button>
                                <button type="button" class="btn btn btn-primary pull-right" onclick="login()" id="btnLogin">
                                    लॉग इन
                                </button>

                                <%--   <button type="button" class="btn btn btn-warning" id="btnAdminLogin" onclick="AdminLogin()" >
                     कार्यालय लॉगिन
                     </button>--%>
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

    <!--BootstrapJS [ RECOMMENDED ]-->
    <script src="<%=ResolveUrl("~/js/bootstrap.min.js") %>"></script>
    <!--Fast Click [ OPTIONAL ]-->
    <script src="<%=ResolveUrl("~/plugins/fast-click/fastclick.min.js") %>"></script>
    <!--Switchery [ OPTIONAL ]-->
    <script src="<%=ResolveUrl("~/plugins/switchery/switchery.min.js") %>"></script>
    <!--Bootstrap Select [ OPTIONAL ]-->
    <script src="<%=ResolveUrl("~/plugins/bootstrap-select/bootstrap-select.min.js") %>"></script>
</body>
</html>
