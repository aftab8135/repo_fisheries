<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AdministratorMaster.master" AutoEventWireup="true" CodeFile="ComplainSubType.aspx.cs" Inherits="Administrator_ComplainSubType" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../js/jquery-2.1.1.min.js" type="text/javascript"></script>
    <%-- Define Validation Rule --%>
    <script type="text/javascript">
        var isValid = false;
        $(document).ready(function () {
            $('#complainsubtype').bootstrapValidator({
                framework: 'bootstrap',
                icon: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    txtComplainSubType: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'The Grievance Sub Type Name is required.'
                            }
                        }
                    },
                    ddlComplainType: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'The Grievance Type is required'
                            }
                        }
                    },
                    ddlDesignation: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'The Designation is required'
                            }
                        }
                    },
                    ddlSection: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'The Section is required'
                            }
                        }
                    },
                    txtTimeFrame: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'The Section is required'
                            }
                        }
                    }
                }
            }).on('success.field.bv', function () {
                isValid = true;
            });
        });
    </script>
    <%-- For Get Data --%>
    <script type="text/javascript">
        $(document).ready(function () {

            $("#ddlDesignation").prop("disabled", true);
            $("#ddlSection").prop("disabled", true);
            $("#txtTimeFrame").prop("disabled", true);

            $('#btnCancel').click(function () {
                window.location.reload();
            });

            $.ajax({
                type: "POST",
                url: "ComplainSubType.aspx/PopulateComplainType",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {

                    var ddl = $("[id*=ddlComplainType]");
                    $.each(r.d, function () {
                        ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    ddl.selectpicker('refresh');
                }
            });
        });

        function populateDesignation() {
            $("#ddlDesignation").prop("disabled", false);
            $("#ddlSection").prop("disabled", false);
            $("#txtTimeFrame").prop("disabled", false);

            $.ajax({
                type: "POST",
                url: "ComplainSubType.aspx/BindDesignation",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (r) {

                    var ddl = $("[id*=ddlDesignation]");
                    $.each(r.d, function () {
                        ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    ddl.selectpicker('refresh');
                }
            });
        }

        function populateSection() {
            $.ajax({
                type: "POST",
                url: "ComplainSubType.aspx/BindSection",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (r) {

                    var ddl = $("[id*=ddlSection]");
                    $.each(r.d, function () {
                        ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    ddl.selectpicker('refresh');
                }
            });
        }

        $(document).on("click", ".editButton", function () {
            $("#add-tab").trigger('click');
            $("#tab-add-scheme").addClass("tab-pane fade active in")
            $("#tab-list-scheme").removeClass("tab-pane fade active in")

            $("#tab-list-scheme").prop("aria-selected", "true")
            $("#tab-list-scheme").prop("aria-expanded", "false")

            $("#pnlSchemeDetail").hide();

            var id = $(this).attr("data-id");
            $("#SubTypeKey").val(id);

            $.ajax({
                type: "Post",
                contentType: "application/json; charset=utf-8",
                url: "ComplainSubType.aspx/EditComplainType",
                data: '{SubTypeKey: ' + id + '}',
                dataType: "json",
                success: function (data) {

                    var SubTypeDetail = $.parseJSON(data.d);

                    var designation = null;
                    var complainType = null;
                    var section = null;
                    populateSection();
                    populateDesignation()
                    $.each(SubTypeDetail, function (index, value) {
                        $('#txtComplainSubType').val(value.SubTypeName);
                        $('#txtTimeFrame').val(value.TimeFrame);
                        $('#chkIsActive').prop("checked", value.IsActive);

                        designation = value.DesignationKey;
                        complainType = value.ComplainTypeKey;
                        section = value.SectionKey;
                    });

                    $("#ddlComplainType option").each(function () {
                        if ($(this).val() == complainType)
                            $(this).prop('selected', true);
                        else
                            $(this).prop('selected', false);
                    });
                    $("#ddlComplainType").selectpicker('refresh');

                    $("#ddlDesignation option").each(function () {
                        if ($(this).val() == designation)
                            $(this).prop('selected', true);
                        else
                            $(this).prop('selected', false);
                    });
                    $("#ddlDesignation").selectpicker('refresh');

                    $("#ddlSection option").each(function () {
                        if ($(this).val() == section)
                            $(this).prop('selected', true);
                        else
                            $(this).prop('selected', false);
                    });

                    $("#ddlSection").selectpicker('refresh');

                    $("#btnSubmit").text('Update');
                },

                error: function () {
                    alert("Error while retrieving data of :" + id);
                }
            });
        });

    </script>
    <%--For Control Event--%>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#profile-tab").click(function () {
                $("#pnlSchemeDetail").show();
            });

            $("#add-tab").click(function () {
                $("#pnlSchemeDetail").hide();
            });
        });

    </script>

    <%-- Insert/Update/Delete Operation --%>
    <script type="text/javascript">

        $(document).ready(function () {
            $("#btnSubmit").click(function () {
                if (isValid) {
                    var CreateSubType = {};

                    var mstKey = parseInt($('#SubTypeKey').val());

                    CreateSubType.SubTypeName = $('#txtComplainSubType').val();
                    CreateSubType.SubTypeKey = mstKey;

                    CreateSubType.ComplainTypeKey = $('#ddlComplainType').val();
                    CreateSubType.DesignationKey = $('#ddlDesignation').val();
                    CreateSubType.SectionKey = $('#ddlSection').val();
                    CreateSubType.TimeFrame = $('#txtTimeFrame').val();

                    if ($('#chkIsActive').prop("checked") == true) {
                        CreateSubType.IsActive = true;
                    }
                    else {
                        CreateSubType.IsActive = false;
                    }

                    $.ajax({
                        type: "POST",
                        url: "ComplainSubType.aspx/CreateSubType",
                        data: '{objComplainSubType: ' + JSON.stringify(CreateSubType) + '}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            data = (response.d);
                            if (data > 0) {
                                if (mstKey == 0) {
                                    alert('Record Saved Successfully.')
                                } else
                                    alert('Record Updated Successfully.')
                                window.location.reload();
                            } else if (data == -1) {
                                alert('Please Correct Invalid Entries.')
                            }
                            else
                                alert('Something Went Wrong.')
                        },
                        error: function (err) {
                            alert(err.statusText)
                        }
                    });

                }

            });

            $(document).on("click", ".deleteButton", function () {
                var id = $(this).attr("data-id");

                if (confirm("Are you sure want to delete this record?")) {
                    $.ajax({
                        type: "Post",
                        contentType: "application/json; charset=utf-8",
                        url: "ComplainSubType.aspx/DeleteComplainType",
                        data: '{SubTypeKey: ' + id + '}',
                        dataType: "json",
                        success: function () {
                            alert("Record deleted successfully");
                            window.location.reload();
                        },
                        error: function (data) {
                            alert("Error while deleting data.");
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
            <h3><i class="fa fa-home"></i>Grievance Sub Type </h3>
            <div class="breadcrumb-wrapper">
                <span class="label">You are here:</span>
                <ol class="breadcrumb">
                    <li><a href="#">Home </a></li>
                    <li class="active">Grievance Sub Type </li>
                </ol>

            </div>
        </div>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <!--End page title-->
        <form class="form-horizontal" id="complainsubtype">
            <input type="hidden" id="SubTypeKey" name="SubTypeKey" value="0" />
            <div id="page-content">
                <div class="row">
                    <div class="col-lg-12">
                        <!--Default Tabs (Left Aligned)-->
                        <!--===================================================-->
                        <div class="tab-base">
                            <!--Nav Tabs-->
                            <ul class="nav nav-tabs" id="scheme" role="tablist">
                                  <li class="nav-item active">
                                    <a class="nav-link active" id="profile-tab" data-toggle="tab" href="#tab-list-scheme" role="tab" aria-controls="profile" aria-selected="false">Grievance Sub Type Detail</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="add-tab" data-toggle="tab" href="#tab-add-scheme" role="tab" aria-controls="home" aria-selected="true">Add Grievance Sub Type</a>
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
                                                            <span class="col-md-10">Add Grievance Sub Type </span>
                                                        </h3>
                                                    </div>
                                                    <div class="panel-body mar-top">
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3" for="txtComplainSubType">Grievance Sub Type *</label>
                                                            <div class="col-md-7">
                                                                <input type="text" id="txtComplainSubType" class="form-control" placeholder="Grievance Sub Type" name="txtComplainSubType" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3" for="ddlComplainType">Under Grievance Type *</label>
                                                            <div class="col-md-7">
                                                                <!-- Bootstrap Select with Multiple Selects -->
                                                                <!--===================================================-->
                                                                <select class="form-control selectpicker" data-placeholder="Choose a Category..." title="Choose Grievance Type..." name="ddlComplainType" id="ddlComplainType" data-live-search="true" onchange="populateDesignation(); populateSection()" required>
                                                                </select>
                                                                <!--===================================================-->
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3" for="ddlDesignation">Reporting Designation *</label>
                                                            <div class="col-md-7">
                                                                <!-- Bootstrap Select with Multiple Selects -->
                                                                <!--===================================================-->
                                                                <select class="form-control selectpicker" data-placeholder="Choose a Designation..." title="Choose Designation..." name="ddlDesignation" id="ddlDesignation" data-live-search="true" required>
                                                                </select>
                                                                <!--===================================================-->
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3" for="ddlSection">Under Section *</label>
                                                            <div class="col-md-7">
                                                                <!-- Bootstrap Select with Multiple Selects -->
                                                                <!--===================================================-->
                                                                <select class="form-control selectpicker" data-placeholder="Choose a Category..." title="Choose Section..." name="ddlSection" id="ddlSection" data-live-search="true" required>
                                                                </select>
                                                                <!--===================================================-->
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3" for="txtTimeFrame">Time Frame (in Days.) *</label>
                                                            <div class="col-md-7">
                                                                <input type="number" id="txtTimeFrame" class="form-control" name="txtTimeFrame" name="txtTimeFrame" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3" for="chkIsActive">IsActive </label>
                                                            <div class="col-md-8">
                                                                <input id="chkIsActive" type="checkbox" checked />
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
                                <div id="tab-list-scheme" class="tab-pane fade active in">
                                    <div id="page-content2">
                                        <div class="row">
                                            <!-- Row selection (single row) -->
                                            <!--===================================================-->
                                            <div class="panel" id="pnlSchemeDetail">
                                                <div class="panel-heading">
                                                    <h3 class="panel-title">Grievance Sub Type <strong>Details</strong></h3>
                                                </div>
                                                <div class="panel-body">
                                                    <table id="demo-dt-selection" class="table table-striped table-bordered">
                                                         <colgroup>
                                                            <col width="5%" />
                                                            <col width="24%" />
                                                            <col width="15%" />
                                                            <col width="15%" />
                                                            <col width="15%" />
                                                            <col width="10%" />
                                                            <col width="8%" />
                                                            <col width="8%" />
                                                        </colgroup>
                                                        <thead>
                                                            <tr>
                                                                <th class="min-desktop" style="text-align: center">S.No.</th>
                                                                <th class="min-desktop">Grievance Type</th>
                                                                <th class="min-desktop">Grievance Sub Type</th>
                                                                <th class="min-desktop">Designation</th>
                                                                <th class="min-desktop">Section</th>
                                                                <th class="min-desktop">Time Frame (in Days.)</th>
                                                                <th class="min-desktop">Status</th>
                                                                <th class="min-desktop" style="text-align: center">Action</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <% for (var data = 0; data < dtSubType.Rows.Count; data++)
                                                               { %>
                                                            <tr>
                                                                <td style="text-align: center"><%= data + 1 %>. </td>
                                                                <td><%=dtSubType.Rows[data]["ComplainTypeName"].ToString()%></td>
                                                                <td><%=dtSubType.Rows[data]["SubTypeName"].ToString()%></td>
                                                                <td><%=dtSubType.Rows[data]["DesignationName"].ToString()%></td>
                                                                <td><%=dtSubType.Rows[data]["SectionName"].ToString()%></td>
                                                                <td><%=dtSubType.Rows[data]["TimeFrame"].ToString()%></td>
                                                                <td style="text-align: center">
                                                                    <%if (Convert.ToBoolean(dtSubType.Rows[data]["IsActive"]))
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
                                                                        <a href="#" class="btn btn-info btn-icon icon-xs fa fa-edit editButton" data-id="<%=dtSubType.Rows[data]["SubTypeKey"] %>"
                                                                            data-placement="top" data-original-title="Edit"></a>
                                                                        <a href="#" class="btn btn-danger btn-icon icon-xs fa fa-trash deleteButton" data-id="<%=dtSubType.Rows[data]["SubTypeKey"] %>"
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
</asp:Content>

