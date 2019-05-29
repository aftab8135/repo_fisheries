<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AdministratorMaster.master" AutoEventWireup="true" CodeFile="ObjectMaster.aspx.cs" Inherits="Administrator_ObjectMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../js/jquery-2.1.1.min.js" type="text/javascript"></script>
    <%-- Define Validation Rule --%>
    <script type="text/javascript">
        var isValid = false
        $(document).ready(function () {
            $('#objectMaster').bootstrapValidator({
                framework: 'bootstrap',
                icon: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    txtObjectCode: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'The Object Code is required.'
                            }
                        }
                    },
                    txtObjectName: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'The Object Name is required.'
                            }
                        }
                    }
                }
            }).on('success.field.bv', function (e, data) {
                isValid = true;
            });
        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {

            $('#btnCancel').click(function () {
                window.location.reload();
            });

            $('#btnSave').click(function () {
                if (isValid) {
                    var Object = {};

                    Object.ObjectCode = $("#txtObjectCode").val();
                    Object.ObjectEnglishName = $("#txtObjectName").val();

                    if ($("#hidObjectKey").val() != '') {
                        Object.ObjectKey = $("#hidObjectKey").val();
                    }
                    else {
                        Object.ObjectKey = $("#hidObjectKey").val();
                        Object.IsActive = true;
                    }
                    $.ajax({
                        type: "POST",
                        url: "ObjectMaster.aspx/Save",
                        data: '{objObjectMaster: ' + JSON.stringify(Object) + '}',
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            var gg = $.parseJSON(data.d)
                            alert(gg);
                            window.location.href = "../Administrator/ObjectMaster.aspx";
                        }
                    });
                }
            });

        });

        $(document).on("click", ".deleteButton", function () {
            var id = $(this).attr("data-id");

            if (confirm("Are you sure you want to delete this record !")) {

                $.ajax({
                    type: "Post",
                    contentType: "application/json; charset=utf-8",
                    url: "ObjectMaster.aspx/Delete",
                    data: '{ObjectKey: ' + id + '}',
                    dataType: "json",
                    success: function () {
                        alert("Record deleted successfully.", function () {
                            window.location.reload();
                        });

                    },
                    error: function (data) {
                        alert("Error while deleting data of :" + id);
                    }
                });

            }

        });

        $(document).on("click", ".activateButton", function () {
            var id = $(this).attr("data-id");

            if (confirm("Are you sure you want to activate/deactivate this record !")) {
                $.ajax({
                    type: "Post",
                    contentType: "application/json; charset=utf-8",
                    url: "ObjectMaster.aspx/DeActive",
                    data: '{ObjectKey: ' + id + '}',
                    dataType: "json",
                    success: function (data) {
                        window.location.reload();
                    }
                });
            }
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="content-container">
        <!--Page Title-->
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <div class="pageheader hidden-xs">
            <h3><i class="fa fa-home"></i>Object</h3>
            <div class="breadcrumb-wrapper">
                <span class="label">You are here:</span>
                <ol class="breadcrumb">
                    <li><a href="#">Home </a></li>
                    <li class="active">Object</li>
                </ol>
            </div>
        </div>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <!--End page title-->
        <form class="form-horizontal" id="objectMaster">
            <input type="hidden" id="hidObjectKey" value="0" />
            <div id="page-content">
                <div class="row">
                    <div class="col-lg-12">
                        <!--Default Tabs (Left Aligned)-->
                        <!--===================================================-->
                        <div class="tab-base">
                            <!--Nav Tabs-->
                            <ul class="nav nav-tabs" id="scheme" role="tablist">
                                  <li class="nav-item active">
                                    <a class="nav-link active" id="profile-tab" data-toggle="tab" href="#tab-list-scheme" role="tab" aria-controls="profile" aria-selected="false">Object Detail</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="add-tab" data-toggle="tab" href="#tab-add-scheme" role="tab" aria-controls="home" aria-selected="true">Add Object</a>
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
                                                            <span class="col-md-10">Add Object </span>
                                                        </h3>
                                                    </div>
                                                    <div class="panel-body mar-top">
                                                        <div class="form-group">
                                                            <label class="control-label col-sm-3" for="txtObjectCode">Object Code *</label>
                                                            <div class="col-sm-4">
                                                                <input type="text" id="txtObjectCode" name="txtObjectCode" placeholder="Object Code" class="form-control" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-sm-3" for="txtObjectName">Object Name *</label>
                                                            <div class="col-sm-4">
                                                                <input type="text" id="txtObjectName" name="txtObjectName" placeholder="Object Name" class="form-control" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="panel-footer">
                                                        <div class="row">
                                                            <div class="col-sm-7 col-sm-offset-3">
                                                                <button class="btn btn-info btn-lg" id="btnSave" type="submit">Submit</button>
                                                                <button class="btn btn-warning btn-lg" id="btnCancel" type="reset">Cancel</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="tab-list-scheme" class="tab-pane fade active in">
                                    <div id="page-content2">
                                        <div class="row">
                                            <!-- Row selection (single row) -->
                                            <!--===================================================-->
                                            <div class="panel" id="pnlSchemeDetail">
                                                <div class="panel-heading">
                                                    <h3 class="panel-title">Object <strong>Details</strong></h3>
                                                </div>
                                                <div class="panel-body">
                                                    <table id="demo-dt-selection" class="table table-striped table-bordered">
                                                         <colgroup>
                                                            <col width="5%" />
                                                            <col width="10%" />
                                                             <col width="69%" />
                                                            <col width="8%" />
                                                            <col width="8%" />
                                                        </colgroup>
                                                        <thead>
                                                            <tr>
                                                                <th class="min-desktop" style="text-align: center">S.No.</th>
                                                                <th class="min-desktop">Object Code</th>
                                                                <th class="min-desktop">Object Name</th>
                                                                <th class="min-desktop" style="text-align: center">Status</th>
                                                                <th class="min-desktop" style="text-align: center">Action</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <% for (var data = 0; data < dtObjectMaster.Rows.Count; data++)
                                                               { %>
                                                            <tr>
                                                                <td style="text-align: center"><%= data + 1 %>. </td>
                                                                <td><%=dtObjectMaster.Rows[data]["ObjectCode"].ToString()%></td>
                                                                <td><%=dtObjectMaster.Rows[data]["ObjectEnglishName"].ToString()%></td>
                                                                <td style="text-align: center">
                                                                    <%if (Convert.ToBoolean(dtObjectMaster.Rows[data]["IsActive"]))
                                                                      {
                                                                    %>

                                                                    <span class="btn btn-xs btn-success activateButton" data-id="<%=dtObjectMaster.Rows[data]["ObjectKey"] %>">Active</span>
                                                                    <%     
                                                                      }
                                                                      else
                                                                      {
                                                                    %>
                                                                    <span class="btn btn-xs btn-warning activateButton" data-id="<%=dtObjectMaster.Rows[data]["ObjectKey"] %>">Disable</span>
                                                                    <% 
                                                                      }
                                                                    %>
                                                                </td>
                                                                <td style="text-align: center">
                                                                    <div class="btn-group btn-group-xs">
                                                                        <a href="#" class="btn btn-danger btn-icon icon-xs fa fa-trash deleteButton" data-id="<%=dtObjectMaster.Rows[data]["ObjectKey"] %>"
                                                                            data-placement="top" data-original-title="Delete"></a>
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

