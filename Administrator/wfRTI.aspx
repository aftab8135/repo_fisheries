<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AdministratorMaster.master" AutoEventWireup="true" CodeFile="wfRTI.aspx.cs" Inherits="Administrator_wfRTI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.11.2/build/css/alertify.min.css" />
    <!-- Default theme -->
    <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.11.2/build/css/themes/default.min.css" />
    <script src="../js/jquery-2.1.1.min.js" type="text/javascript"></script>
    <%-- Insert/Update/Delete Operation --%>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#dtpEffectiveDate').datepicker({ autoclose: true });
            function alertMsgAndReload(msg) {
                if (!alertify.alert('RTI', msg, function () {})) { window.location.reload(); }
            }

            function alertMsg(msg) {
                alertify.alert('RTI', msg, function () { })
            }


            $("#btnSubmit").click(function () {
                var RTI = {};
                var mstKey = parseInt($('#MasterKey').val());

                RTI.EffectiveDate = $('#dtpEffectiveDate').val();
                RTI.Amount = (isNaN(parseFloat($('#txtAmount').val())) ? 0 : parseFloat($('#txtAmount').val()));
                RTI.MasterKey = mstKey

                $.ajax({
                    type: "POST",
                    url: "wfRTI.aspx/CreateRTI",
                    data: '{objRTI: ' + JSON.stringify(RTI) + '}',
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

                if (confirm("Are you sure want to delete this record?")) {
                    $.ajax({
                        type: "Post",
                        contentType: "application/json; charset=utf-8",
                        url: "wfRTI.aspx/DeleteRTI",
                        data: '{MasterKey: ' + id + '}',
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
            <h3><i class="fa fa-home"></i>RTI </h3>
            <div class="breadcrumb-wrapper">
                <span class="label">You are here:</span>
                <ol class="breadcrumb">
                    <li><a href="#">Home </a></li>
                    <li class="active">RTI</li>
                </ol>
            </div>
        </div>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <!--End page title-->
        <form runat="server" class="form-horizontal" id="addscheme">
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
                                    <a class="nav-link active" id="profile-tab" data-toggle="tab" href="#tab-list-scheme" role="tab" aria-controls="profile" aria-selected="false">RTI Detail</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="add-tab" data-toggle="tab" href="#tab-add-scheme" role="tab" aria-controls="home" aria-selected="true">Add RTI</a>
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
                                                            <span class="col-md-10">Add RTI </span>
                                                        </h3>
                                                    </div>
                                                    <div class="panel-body mar-top">
                                                        <div class="form-group">
                                                            <label class="control-label col-sm-3" for="dtpEffectiveDate">Effective Date *</label>
                                                            <div class="col-sm-4">
                                                                <input type="text" id="dtpEffectiveDate" placeholder="dd/mm/yyyy" data-date-format='dd/mm/yyyy' data-mask="99/99/9999" class="form-control" readonly required />
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label class="control-label col-sm-3" for="txtBShare">Amount *</label>
                                                            <div class="col-sm-4">
                                                                <input type="number" id="txtAmount" class="form-control" name="amount" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="panel-footer">
                                                        <div class="row">
                                                            <div class="col-sm-7 col-sm-offset-3">
                                                                <button id="btnSubmit" class="btn btn-info btn-lg">Submit</button>
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
                                                    <h3 class="panel-title">RTI <strong>Details</strong></h3>
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
                                                                <th class="min-desktop">Effective Date</th>
                                                                <th class="min-desktop" style="text-align:right">Amount</th>
                                                                <th class="min-desktop" style="text-align: center">Action</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <% for (var data = 0; data < dtRTIDetail.Rows.Count; data++)
                                                               { %>
                                                            <tr>
                                                                <td style="text-align: center"><%= data + 1 %>. </td>
                                                                <td><%=dtRTIDetail.Rows[data]["EffectiveDate"].ToString()%></td>
                                                                <td style="text-align:right"><%=dtRTIDetail.Rows[data]["Amount"].ToString()%></td>
                                                                <td style="text-align: center">
                                                                    <div class="btn-group btn-group-xs">
                                                                        <a href="#" class="btn btn-danger btn-icon icon-xs fa fa-trash deleteButton" data-id="<%=dtRTIDetail.Rows[data]["MasterKey"] %>"
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

