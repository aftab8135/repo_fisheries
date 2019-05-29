<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AdministratorMaster.master" AutoEventWireup="true" CodeFile="wfUser.aspx.cs" Inherits="Administrator_wfUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../js/jquery-2.1.1.min.js" type="text/javascript"></script>
    <%-- Define Validation Rule --%>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#frmUser').bootstrapValidator({
                framework: 'bootstrap',
                icon: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    ddlUserType: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'Invalid Entry.'
                            }
                        }
                    },
                    txtName: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'Invalid Entry.'
                            }
                        }
                    },
                    ddlGender: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'Role is Requied.'
                            }
                        }
                    },
                    district: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'Invalid Entry.'
                            }
                        }
                    },
                    mobileno: {
                        row: '.col-xs-4',
                        validators: {
                            stringLength: {
                                min : 10,
                                max: 10,
                                message: 'Mobile No. must be 10 digit.'
                            },
                            integer: {
                                message: 'The value is not an number'
                            }
                        }
                    },
                    emailid: {
                        row: '.col-xs-4',
                        validators: {
                            emailAddress: {
                                message: 'The value is not a valid email address'
                            }
                        }
                    }

                }
            });
        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#profile-tab").click(function () {
                $("#pnlSchemeDetail").show();
            });

            $("#add-tab").click(function () {
                $("#pnlSchemeDetail").hide();
            });

            $('#txtMobileNo').keyup(function () {
                this.value = this.value.replace(/[^0-9\.]/g, '');
            });

            $.ajax({
                type: "POST",
                url: "wfUser.aspx/GetDistricts",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    //alert(r.d);
                    var ddlDistrict = $("[id*=ddlDistrict]");
                    $.each(r.d, function () {
                        //   alert(this['Value']);
                        ddlDistrict.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    ddlDistrict.selectpicker('refresh');
                }

            });

            $.ajax({
                type: "POST",
                url: "wfUser.aspx/GetLoginType",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    //alert(r.d);
                    var ddlUserType = $("[id*=ddlUserType]");
                    $.each(r.d, function () {
                        //   alert(this['Value']);
                        ddlUserType.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    ddlUserType.selectpicker('refresh');
                }

            });

            $(document).on("click", ".editButton", function () {

                $("#add-tab").trigger('click');
                $("#tab-add-scheme").addClass("tab-pane fade active in")
                $("#tab-list-scheme").removeClass("tab-pane fade active in")

                $("#tab-list-scheme").prop("aria-selected", "true")
                $("#tab-list-scheme").prop("aria-expanded", "false")


                $("#pnlSchemeDetail").hide();

                var id = $(this).attr("data-id");
                $('#UserKey').val(id);
                $.ajax({
                    type: "Post",
                    contentType: "application/json; charset=utf-8",
                    url: "wfUser.aspx/EditUserDetail",
                    data: '{UserKey: ' + id + '}',
                    dataType: "json",
                    success: function (data) {
                        var UserDetail = $.parseJSON(data.d);
                        var gender = null;
                        var district = null;
                        var usertype = null;
                        $.each(UserDetail, function (index, value) {

                            usertype = value.UserType;

                            $('#txtName').val(value.Name);

                            gender = value.Gender;

                            $('#txtMobileNo').val(value.MobileNo);
                            $('#txtEmailId').val(value.EmailID);

                            district = value.DistrictKey;

                        });

                        $("#ddlUserType option").each(function () {
                            if ($(this).val() == usertype)
                                $(this).prop('selected', true);
                            else
                                $(this).prop('selected', false);
                        });
                        $("#ddlUserType").selectpicker('refresh');

                        $("#ddlGender option").each(function () {
                            if ($(this).val() == gender)
                                $(this).prop('selected', true);
                            else
                                $(this).prop('selected', false);
                        });
                        $("#ddlGender").selectpicker('refresh');

                        $("#ddlDistrict option").each(function () {
                            if ($(this).val() == district)
                                $(this).prop('selected', true);
                            else
                                $(this).prop('selected', false);
                        });
                        $("#ddlDistrict").selectpicker('refresh');

                        $("#btnSubmit").text('Update');
                    },

                    error: function () {
                        alert("Error while retrieving data of :" + id);
                    }

                });
            });
        });
    </script>
    <script type="text/javascript">
       
    </script>
    <%-- Insert/Update/Delete Operation --%>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnSubmit").click(function () {

                var User = {};
                var mstKey = parseInt($('#UserKey').val());

                User.UserKey = mstKey
                User.UserType = $('#ddlUserType').val();
                User.Name = $('#txtName').val();
                User.Gender = $('#ddlGender').val();

                User.MobileNo = $('#txtMobileNo').val();
                User.EmailID = $('#txtEmailId').val();

                User.DistrictKey = $('#ddlDistrict').val();

                $.ajax({
                    type: "POST",
                    url: "wfUser.aspx/CreateUser",
                    data: '{objUserMaster: ' + JSON.stringify(User) + ', isUpdate : ' + ($("#btnSubmit").text() != "Update" ? 0 : 1) + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        data = (response.d);
                        if (data > 0) {
                            if (mstKey == 0) {
                                if (alert('Record Saved Successfully.')) {
                                    window.location.reload();
                                };
                            }
                            if (mstKey > 0) {
                                if (alert('Record Updated Successfully.')) {
                                    window.location.reload();
                                };
                            }
                        } else if (data == -1) {
                            alert('Please Correct Invalid Entries.')
                        } else if (data == -2) {
                            alert('Please Correct Mobile No.')
                        }
                        else
                            alert('Something Went Wrong.')
                    },
                    error: function (err) {
                        alert(err.statusText)
                    }
                });

            });

            $(document).on("click", ".deleteButton", function () {
                var id = $(this).attr("data-id");

                if (confirm("Role", "Are you sure?")) {
                    $.ajax({
                        type: "Post",
                        contentType: "application/json; charset=utf-8",
                        url: "wfUser.aspx/DeleteUser",
                        data: '{ID: ' + id + '}',
                        dataType: "json",
                        success: function (r) {
                            if (alert('Record Deleted Successfully.')) {
                                {
                                    window.location.reload();
                                }
                            }
                        },
                        error: function (data) {
                            alertMsg("Error while deleting data.");
                        }
                    });
                }
                return false;
            });


        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div id="content-container">
        <!--Page Title-->
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <div class="pageheader hidden-xs">
            <h3><i class="fa fa-home"></i>User </h3>
            <div class="breadcrumb-wrapper">
                <span class="label">You are here:</span>
                <ol class="breadcrumb">
                    <li><a href="#">Home </a></li>
                    <li class="active">User</li>
                </ol>
            </div>
        </div>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <!--End page title-->
        <form class="form-horizontal" id="frmUser">
            <input type="hidden" id="UserKey" name="UserKey" value="0" />
            <div id="page-content">
                <div class="row">
                    <div class="col-lg-12">
                        <!--Default Tabs (Left Aligned)-->
                        <!--===================================================-->
                        <div class="tab-base">
                            <!--Nav Tabs-->
                            <ul class="nav nav-tabs" id="scheme" role="tablist">
                                 <li class="nav-item active">
                                    <a class="nav-link active" id="profile-tab" data-toggle="tab" href="#tab-list-scheme" role="tab" aria-controls="profile" aria-selected="false">User Detail</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="add-tab" data-toggle="tab" href="#tab-add-scheme" role="tab" aria-controls="home" aria-selected="true">Add User</a>
                                </li>
                               
                            </ul>
                            <!--Tabs Content-->
                            <div class="tab-content">
                                <div id="tab-add-scheme" class="tab-pane fade">
                                    <div id="page-content1">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <div class="panel">
                                                    <div class="panel-heading">
                                                        <h3 class="panel-title">
                                                            <span class="col-md-10">Add User </span>
                                                        </h3>
                                                    </div>
                                                    <div class="panel-body mar-top">
                                                        <div class="form-group">
                                                            <label class="control-label col-sm-3" for="ddlUserType">User Role</label>
                                                            <div class="col-sm-4">
                                                                <select class="form-control selectpicker" id="ddlUserType" name="ddlUserType" required>
                                                                    <option value="" selected disabled hidden>Select User Role</option>
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label class="control-label col-sm-3" for="txtName">Name</label>
                                                            <div class="col-sm-4">
                                                                <input type="text" id="txtName" placeholder="Name" name="txtName" class="form-control" required />
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label class="control-label col-sm-3" for="txtName">Gender</label>
                                                            <div class="col-sm-4">
                                                                <select class="form-control selectpicker" id="ddlGender" name="ddlGender" required>
                                                                    <option value="" selected disabled hidden>Select Gender</option>
                                                                    <option>Male</option>
                                                                    <option>Female</option>
                                                                    <option>Transgender</option>
                                                                </select>
                                                            </div>


                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-sm-3" for="txtMobileNo">Mobile No.</label>
                                                            <div class="col-sm-4">
                                                                <input type="text" id="txtMobileNo" placeholder="Mobile No." class="form-control" name="mobileno" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-sm-3" for="txtEmailId">EmailID</label>
                                                            <div class="col-sm-4">
                                                                <input type="email" id="txtEmailId" placeholder="EmailID" name="emailid" class="form-control" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-sm-3" for="ddlDistrict">District</label>
                                                            <div class="col-sm-4">
                                                                <select title="Choose a Category..." data-placeholder="Choose a Category..." class="form-control selectpicker" data-live-search="true" id="ddlDistrict" name="district">
                                                                    <option value="" selected disabled hidden>Select District</option>
                                                                </select>
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
                                <div id="tab-list-scheme" class="tab-pane fade  active in">
                                    <div id="page-content2">
                                        <div class="row">
                                            <!-- Row selection (single row) -->
                                            <!--===================================================-->
                                            <div class="panel" id="pnlSchemeDetail">
                                                <div class="panel-heading">
                                                    <h3 class="panel-title">User <strong>Details</strong></h3>
                                                </div>
                                                <div class="panel-body">
                                                    <table id="demo-dt-selection" class="table table-striped table-bordered">
                                                        <thead>
                                                            <tr>
                                                                <th class="min-desktop" style="text-align: center">S.No.</th>
                                                                <th class="min-desktop">User Role</th>
                                                                <th class="min-desktop">Name</th>
                                                                <th class="min-desktop">Gender</th>
                                                                <th class="min-desktop">User Name</th>
                                                                <th class="min-desktop">Mobile No</th>
                                                                <th class="min-desktop">EmailID</th>
                                                                <th class="min-desktop">District</th>
                                                                <th class="min-desktop" style="text-align: center">Default Password</th>
                                                                <th class="min-desktop" style="text-align: center">Active</th>
                                                                <th class="min-desktop" style="text-align: center">Action</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <% for (var data = 0; data < dtUserDetail.Rows.Count; data++)
                                                               { %>
                                                            <tr>
                                                                <td style="text-align: center"><%= data + 1 %>. </td>

                                                                <td><%=dtUserDetail.Rows[data]["UserType"].ToString()%></td>
                                                                <td><%=dtUserDetail.Rows[data]["Name"].ToString()%></td>
                                                                <td><%=dtUserDetail.Rows[data]["Gender"].ToString()%></td>
                                                                <td><%=dtUserDetail.Rows[data]["UserName"].ToString()%></td>
                                                                <td><%=dtUserDetail.Rows[data]["MobileNo"].ToString()%></td>
                                                                <td><%=dtUserDetail.Rows[data]["EmailID"].ToString()%></td>
                                                                <td><%=dtUserDetail.Rows[data]["DistrictName"].ToString()%></td>
                                                                <td style="text-align: center">
                                                                    <%if (!Convert.ToBoolean(dtUserDetail.Rows[data]["DefaultPassword"]))
                                                                      {
                                                                    %>

                                                                    <span class="label label-table label-primary">Not Changed</span>
                                                                    <%     
                                                                      }
                                                                      else
                                                                      {
                                                                    %>
                                                                    <span class="label label-table label-warning">Changed</span>
                                                                    <% 
                                                                      }
                                                                    %>
                                                                </td>

                                                                <td style="text-align: center">
                                                                    <%if (Convert.ToBoolean(dtUserDetail.Rows[data]["IsActive"]))
                                                                      {
                                                                    %>

                                                                    <span class="label label-table label-success">Active</span>
                                                                    <%     
                                                                      }
                                                                      else
                                                                      {
                                                                    %>
                                                                    <span class="label label-table label-dark">Disable</span>
                                                                    <% 
                                                                      }
                                                                    %>
                                                                </td>
                                                                <td style="text-align: center">
                                                                    <div class="btn-group btn-group-xs">
                                                                        <a href="#" class="btn btn-info btn-icon icon-xs fa fa-edit editButton" data-id="<%=dtUserDetail.Rows[data]["UserKey"] %>"
                                                                            data-placement="top" data-original-title="Edit"></a>
                                                                        <a href="#" class="btn btn-danger btn-icon icon-xs fa fa-trash deleteButton" data-id="<%=dtUserDetail.Rows[data]["UserKey"] %>"
                                                                            data-placement="top" data-original-title="Remove"></a>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <%}%>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                            <!--===================================================-->
                                            <!-- End Row selection (single row) -->
                                        </div>
                                    </div>

                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <script src="../plugins/bootstrap-validator/bootstrapValidator.min.js"></script>
    <script src="../js/demo/form-validation.js"></script>
    <!--DataTables Sample [ SAMPLE ]-->
    <script src="../js/demo/tables-datatables.js"></script>
    <!--Form Component [ SAMPLE ]-->
    <!--Bootstrap Datepicker [ OPTIONAL ]-->
    <script src="../plugins/bootstrap-datepicker/bootstrap-datepicker.js"></script>
    <!--Form Component [ SAMPLE ]-->
    <script src="../js/demo/form-component.js"></script>

    <!-- JavaScript -->
    <script src="//cdn.jsdelivr.net/npm/alertifyjs@1.11.2/build/alertify.min.js"></script>
</asp:Content>

