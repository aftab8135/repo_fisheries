<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/HOMaster.master" AutoEventWireup="true" CodeFile="ChangePassword.aspx.cs" Inherits="Secure_Login_ChangePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../js/jquery-2.1.1.min.js" type="text/javascript"></script>
    <%-- Define Validation Rule --%>
    <script type="text/javascript">
        var isValid = false;
        $(document).ready(function () {
            $('#frm_ChangePassword').bootstrapValidator({
                framework: 'bootstrap',
                icon: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    txtOldPassword: {
                        row: '.col-sm-4',
                        validators: {
                            notEmpty: {
                                message: 'Old password is required.'
                            }
                        }
                    },
                    txtNewPassword: {
                        row: '.col-sm-4',
                        validators: {
                            notEmpty: {
                                message: 'New password is required'
                            }
                        }
                    },
                    txtConfirmPassword: {
                        row: '.col-sm-4',
                        validators: {
                            notEmpty: {
                                message: 'Confirm password required'
                            }
                        }
                    }
                }
            }).on('success.field.bv', function () {
                isValid = true;
            });
        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnSubmit").click(function () {
                if (isValid) {
                    var OldPassword = $("#txtOldPassword").val();
                    var NewPassword = $("#txtNewPassword").val();

                    $.ajax({
                        type: "POST",
                        url: "ChangePassword.aspx/UserChangePassword",
                        data: '{Curr_Password : ' + JSON.stringify(OldPassword) + ', New_Password :' + JSON.stringify(NewPassword) + '}',
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (i) {
                            var id = i.d;
                            if (id == "1") {
                                alert("Password change successfully.")
                            } else {
                                alert('Old password not correct');
                            }
                        }
                    });
                }

            });
        });
    </script>
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="content-container">
        <!--Page Title-->
        <!--------------------------------------------------------->
        <div class="pageheader hidden-xs">
            <h3><i class="fa fa-home"></i>
                <asp:Label ID="lblHeading" runat="server" Text="Change Password"></asp:Label></h3>
            <div class="breadcrumb-wrapper">
                <%-- <span class="label">You are here:</span>--%>
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">Home </a></li>
                    <li class="active">
                        <asp:Label ID="lblHomeHeading" runat="server" Text="Change Password"></asp:Label></li>
                </ol>
            </div>
        </div>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <!--End page title-->
        <div class="form-horizontal" id="frm_ChangePassword">
            <div id="page-content">
                <div class="form-horizontal">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="panel">
                                <div class="panel-heading">
                                    <h3 class="panel-title"><strong>
                                        <asp:Label ID="lblTitle" runat="server" Text="Change your password"></asp:Label></strong></h3>
                                </div>
                                <!--No Label Form-->
                                <div class="panel-body mar-top">
                                    <div class="form-group">
                                        <label class="control-label col-sm-3" for="txtOldPassword">Old Password <span style="color: red">*</span></label>
                                        <div class="col-sm-4">
                                            <input type="password" id="txtOldPassword" placeholder="Old Password" class="form-control" name="txtOldPassword" required />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-sm-3" for="txtNewPassword">New Password <span style="color: red">*</span></label>
                                        <div class="col-sm-4">
                                            <input type="password" id="txtNewPassword" placeholder="New Password" class="form-control" name="txtNewPassword" required />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-sm-3" for="txtConfirmPassword">Confirm Password <span style="color: red">*</span></label>
                                        <div class="col-sm-4">
                                            <input type="password" id="txtConfirmPassword" placeholder="Confirm Password" class="form-control" name="txtConfirmPassword" required />
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-footer">
                                    <div class="row">
                                        <div class="col-sm-7 col-sm-offset-3">
                                            <button id="btnSubmit" class="btn btn-info btn-lg" type="submit">Submit</button>
                                            <button class="btn btn-warning btn-lg" id="btnCancel" type="reset">Cancel</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


                </div>
            </div>
        </div>
    </div>
    <script src="../../plugins/bootstrap-validator/bootstrapValidator.min.js"></script>
    <script src="../../js/demo/form-validation.js"></script>
    <!--Form Component [ SAMPLE ]-->
    <script src="../../js/demo/form-component.js"></script>
</asp:Content>

