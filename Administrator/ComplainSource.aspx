<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AdministratorMaster.master" AutoEventWireup="true" CodeFile="ComplainSource.aspx.cs" Inherits="Administrator_ComplainSource" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
   <script src="../js/jquery-2.1.1.min.js" type="text/javascript"></script>
     <%-- Define Validation Rule --%>
    <script type="text/javascript">
        var isValid = false
        $(document).ready(function () {
         
            $('#complainsource').bootstrapValidator({
                framework: 'bootstrap',
                icon: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    txtComplainSource: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'The Grievance Source Name is required.'
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
                    var SourceName = {};

                    SourceName.ComplainSourceName = $("#txtComplainSource").val();

                    if ($("#hidComplainSourseKey").val() != '') {
                        SourceName.ComplainSourcekey = $("#hidComplainSourseKey").val();
                    }
                    else {
                        SourceName.ComplainSourcekey = $("#hidComplainSourseKey").val();
                        SourceName.IsActive = true;
                    }
                    $.ajax({
                        type: "POST",
                        url: "ComplainSource.aspx/SaveComplainSourse",
                        data: '{objSourceMaster: ' + JSON.stringify(SourceName) + '}',
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            var gg = $.parseJSON(data.d)

                            if (gg == 'insert') {
                                alert("Grievance Source Saved successfully.");
                                $("#txtComplainSource").val('');
                                $("hidComplainSourseKey").val('');
                                window.location.reload();
                            }
                            else if (gg == 'update') {
                                alert("Grievance Source Upadted successfully.");
                                $("#txtComplainSource").val('');
                                $("hidComplainSourseKey").val('');
                                window.location.reload();
                            }
                            else if (gg == 'Exist') {
                                alert("Record Already Exist!.", function () {
                                });
                            }
                            else {
                                alert("Error while inserting data");
                            }
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
                    url: "ComplainSource.aspx/DeleteComplainSource",
                    data: '{Sourcekey: ' + id + '}',
                    dataType: "json",
                    success: function () {
                        alert("Grievance Source deleted successfully.", function () {
                            window.location.reload();
                        });

                    },
                    error: function (data) {
                        alert("Error while deleting data of :" + id);
                    }
                });

            }


        });
        $(document).on("click", ".editButton", function () {
            var id = $(this).attr("data-id");

            $("#hidComplainSourseKey").val(id);
            $.ajax({
                type: "Post",
                contentType: "application/json; charset=utf-8",
                url: "ComplainSource.aspx/EditComplainSource",
                data: '{Sourcekey: ' + id + '}',
                dataType: "json",
                success: function (data) {
                    var Source = $.parseJSON(data.d);

                    $.each(Source, function (index, value) {
                        $("#txtComplainSource").val(value.ComplainSourceName);
                        $("#btnSave").text('Update');

                    });

                },
                error: function () {
                    alert("Error while retrieving data of :" + id);
                    $("#btnSave").text('Update');
                }
            });
        });

        $(document).on("click", ".activateButton", function () {
            var id = $(this).attr("data-id");

            if (confirm("Are you sure you want to activate/deactivate this record !")) {
                $.ajax({
                    type: "Post",
                    contentType: "application/json; charset=utf-8",
                    url: "ComplainSource.aspx/ActivateComplainSource",
                    data: '{Sourcekey: ' + id + '}',
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
            <h3><i class="fa fa-home"></i>Grievance Source</h3>
            <div class="breadcrumb-wrapper">
                <span class="label">You are here:</span>
                <ol class="breadcrumb">
                    <li><a href="#">Home </a></li>
                    <li class="active">Grievance Source</li>
                </ol>
            </div>
        </div>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <!--End page title-->
        <form class="form-horizontal" id="complainsource">
            <input type="hidden" id="hidComplainSourseKey" value="0" />
            <div id="page-content">
                <div class="row">
                    <div class="col-lg-12">
                        <!--Default Tabs (Left Aligned)-->
                        <!--===================================================-->
                        <div class="tab-base">
                            <!--Nav Tabs-->
                            <ul class="nav nav-tabs" id="scheme" role="tablist">
                                   <li class="nav-item active">
                                    <a class="nav-link active" id="profile-tab" data-toggle="tab" href="#tab-list-scheme" role="tab" aria-controls="profile" aria-selected="false">Grievance Source Detail</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="add-tab" data-toggle="tab" href="#tab-add-scheme" role="tab" aria-controls="home" aria-selected="true">Add Grievance Source</a>
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
                                                            <span class="col-md-10">Add Grievance Source </span>
                                                        </h3>
                                                    </div>
                                                    <div class="panel-body mar-top">
                                                        <div class="form-group">
                                                            <label class="control-label col-sm-3" for="txtComplainSource">Grievance Source Name</label>
                                                            <div class="col-sm-4">
                                                                <input type="text" id="txtComplainSource" name="txtComplainSource" placeholder="Grievance Source Name" class="form-control" />
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="panel-footer">
                                                        <div class="row">
                                                            <div class="col-sm-7 col-sm-offset-3">
                                                                <button id="btnSave" class="btn btn-info btn-lg">Submit</button>
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
                                                    <h3 class="panel-title">Grievance Source <strong>Details</strong></h3>
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
                                                                <th class="min-desktop">Grievance Source Name</th>
                                                                <th class="min-desktop" style="text-align: center">Active</th>
                                                                <th class="min-desktop" style="text-align: center">Action</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <% for (var data = 0; data < dtCompalinSource.Rows.Count; data++)
                                                               { %>
                                                            <tr>
                                                                <td style="text-align: center"><%= data + 1 %>. </td>

                                                                <td><%=dtCompalinSource.Rows[data]["ComplainSourceName"].ToString()%></td>
                                                                <td style="text-align: center">
                                                                    <%if (Convert.ToBoolean(dtCompalinSource.Rows[data]["IsActive"]))
                                                                      {
                                                                    %>

                                                                    <span class="btn btn-xs btn-success activateButton" data-id="<%=dtCompalinSource.Rows[data]["ComplainSourcekey"] %>">Active</span>
                                                                    <%     
                                                                      }
                                                                      else
                                                                      {
                                                                    %>
                                                                    <span class="btn btn-xs btn-warning activateButton" data-id="<%=dtCompalinSource.Rows[data]["ComplainSourcekey"] %>">Disable</span>
                                                                    <% 
                                                                      }
                                                                    %>
                                                                </td>
                                                                <td style="text-align: center">
                                                                    <div class="btn-group btn-group-xs">
                                                                        <a href="#" class="btn btn-danger btn-icon icon-xs fa fa-trash deleteButton" data-id="<%=dtCompalinSource.Rows[data]["ComplainSourcekey"] %>"
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

