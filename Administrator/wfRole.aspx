<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AdministratorMaster.master" AutoEventWireup="true" CodeFile="wfRole.aspx.cs" Inherits="Administrator_wfRole" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../js/jquery-2.1.1.min.js" type="text/javascript"></script>
    <%-- Define Validation Rule --%>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#frmRole').bootstrapValidator({
                framework: 'bootstrap',
                icon: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    txtRoleName: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'Role is Requied.'
                            }
                        }
                    }
                }
            });
        });
    </script>
    <%-- Insert/Update/Delete Operation --%>
    <script type="text/javascript">
        $(document).ready(function () {

            function alertMsgAndReload(msg) {
                if (!alertify.alert('Role', msg, function () { })) { window.location.reload(); }
            }

            function alertMsg(msg) {
                alertify.alert('Role', msg, function () { })
            }
            $("#btnCancel").click(function () { window.location.reload(); });

            $("#btnSubmit").click(function () {
                var Role = {};
                var mstKey = parseInt($('#MasterKey').val());

                Role.RoleName = $('#txtRoleName').val();
                Role.ID = mstKey

                $.ajax({
                    type: "POST",
                    url: "wfRole.aspx/CreateRole",
                    data: '{objRole: ' + JSON.stringify(Role) + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        data = (response.d);
                        if (data > 0) {
                            if (mstKey == 0) {
                                if (alert('Record Saved Successfully.')) {
                                    window.location.reload(true);
                                };
                            }
                        } else if (data == -1) {
                            alertMsg('Please Correct Invalid Entries.')
                        }
                        else
                            alertMsg('Something Went Wrong.')
                    },
                    error: function (err) {
                        alertMsg(err.statusText)
                    }
                });

            });

            $(document).on("click", ".deleteButton", function () {
                var id = $(this).attr("data-id");

                if (confirm("Are you sure want to delete this role?")) {
                    $.ajax({
                        type: "Post",
                        contentType: "application/json; charset=utf-8",
                        url: "wfRole.aspx/DeleteRole",
                        data: '{ID: ' + id + '}',
                        dataType: "json",
                        success: function (r) {
                            if(r.d > 0)
                            {
                                alert('Record Deleted Successfully.');
                                window.location.reload(true);
                            }
                            else if(r.d == -1)
                                alertMsg("Error while deleting data.");
                        },
                        error: function (data) {
                            alertMsg("Error while deleting data.");
                        }
                    });
                }
                return false;
            });

            $(document).on("click", ".activateButton", function () {
                var id = $(this).attr("data-id");

                if (confirm("Are you sure?")) {
                    $.ajax({
                        type: "Post",
                        contentType: "application/json; charset=utf-8",
                        url: "wfRole.aspx/ActivateRole",
                        data: '{ID: ' + id + '}',
                        dataType: "json",
                        success: function (r) {
                            if (r.d > 0) {
                                alert('Record Updated Successfully.');
                                window.location.reload(true);
                            }
                            else if (r.d == -1)
                                alertMsg("Error while updating data.");
                        },
                        error: function (data) {
                            alertMsg("Error while updating data.");
                        }
                    });
                }
                return false;
            });

            $(document).on("click", ".editButton", function () {
                var id = $(this).attr("data-id");

                if (confirm("Role", "Are you sure?")) {
                    $.ajax({
                        type: "Post",
                        contentType: "application/json; charset=utf-8",
                        url: "wfRole.aspx/DeleteRole",
                        data: '{ID: ' + id + '}',
                        dataType: "json",
                        success: function (r) {
                            if (alert('Record Updated Successfully.')) {
                                {
                                    window.location.reload();
                                }
                            }
                        },
                        error: function (data) {
                            alertMsg("Error while updating data.");
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
            <h3><i class="fa fa-home"></i>Role </h3>
            <div class="breadcrumb-wrapper">
                <span class="label">You are here:</span>
                <ol class="breadcrumb">
                    <li><a href="#">Home </a></li>
                    <li class="active">Role</li>
                </ol>
            </div>
        </div>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <!--End page title-->
        <form class="form-horizontal" id="frmRole">
            <input type="hidden" id="MasterKey" name="MasterKey" value="0" />
            <div id="page-content">
                <div class="row">
                    <div class="col-lg-12">
                        <!--Default Tabs (Left Aligned)-->
                        <!--===================================================-->
                        <div class="tab-base">
                            <!--Nav Tabs-->
                            <ul class="nav nav-tabs" id="scheme" role="tablist">
                                    <li class="nav-item active">
                                    <a class="nav-link active" id="profile-tab" data-toggle="tab" href="#tab-list-scheme" role="tab" aria-controls="profile" aria-selected="false">Role Detail</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="add-tab" data-toggle="tab" href="#tab-add-scheme" role="tab" aria-controls="home" aria-selected="true">Add Role</a>
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
                                                            <span class="col-md-10">Add Role </span>
                                                        </h3>
                                                    </div>
                                                    <div class="panel-body mar-top">
                                                        <div class="form-group">
                                                            <label class="control-label col-sm-3" for="txtRoleName">Role Name</label>
                                                            <div class="col-sm-4">
                                                                <input type="text" id="txtRoleName" placeholder="Role Name" name="txtRoleName" class="form-control" required />
                                                            </div>
                                                        </div>

                                                      <%--  <div class="form-group">
                                                            <label class="control-label col-sm-3" for="chkIsActive">Is Active</label>
                                                            <div class="col-sm-4">
                                                                <input type="checkbox" id="chkIsActive" name="isactive" checked />
                                                            </div>
                                                        </div>--%>
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
                                                    <h3 class="panel-title">Role <strong>Details</strong></h3>
                                                </div>
                                                <div class="panel-body">
                                                    <table id="demo-dt-selection" class="table table-striped table-bordered">
                                                        <colgroup>
                                                            <col width="5%" />
                                                            <col width="79%" />
                                                            <col width="8%" />
                                                            <col width="8%" />
                                                        </colgroup>
                                                        <thead>
                                                            <tr>
                                                                <th class="min-desktop" style="text-align: center">S.No.</th>
                                                                <th class="min-desktop">Role Name</th>
                                                                <th class="min-desktop" style="text-align: center">Status</th>
                                                                <th class="min-desktop" style="text-align: center">Action</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <% for (var data = 0; data < dtRoleDetail.Rows.Count; data++)
                                                               { %>
                                                            <tr>
                                                                <td style="text-align: center"><%= data + 1 %>. </td>

                                                                <td><%=dtRoleDetail.Rows[data]["RoleName"].ToString()%></td>
                                                                
                                                                <td style="text-align: center">
                                                                    <%if (Convert.ToBoolean(dtRoleDetail.Rows[data]["IsActive"]))
                                                                      {
                                                                    %>

                                                                    <span class="btn btn-xs btn-success activateButton " data-id="<%=dtRoleDetail.Rows[data]["ID"] %>">Active</span>
                                                                    <%     
                                                                      }
                                                                      else
                                                                      {
                                                                    %>
                                                                    <span class="btn btn-xs btn-warning activateButton" data-id="<%=dtRoleDetail.Rows[data]["ID"] %>">Disable</span>
                                                                    <% 
                                                                      }
                                                                    %>
                                                                </td>
                                                                <td style="text-align: center">
                                                                    <div class="btn-group btn-group-xs">
                                                                        <%--<a href="#" class="btn btn-info btn-icon icon-xs fa fa-edit editButton" data-id="<%=dtRoleDetail.Rows[data]["ID"] %>"
                                                                            data-placement="top" data-original-title="Edit"></a>--%>
                                                                        <a href="#" class="btn  btn-xs btn-danger btn-icon icon-xs fa fa-trash deleteButton" data-id="<%=dtRoleDetail.Rows[data]["ID"] %>"
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

