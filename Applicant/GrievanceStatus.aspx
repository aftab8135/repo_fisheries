<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ApplicantMaster.Master" AutoEventWireup="true" CodeFile="GrievanceStatus.aspx.cs" Inherits="Applicant_GrievanceStatus" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .panel-heading {
            background-color: #f9f9f9 !important;
        }

        .panel-title {
            line-height: 44px !important;
        }
    </style>
    <script src="../js/jquery-2.1.1.min.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#txtFromDate').datepicker({ autoclose: true });
            $('#txtTodate').datepicker({ autoclose: true });

            $.ajax({
                type: "POST",
                url: "GrievanceStatus.aspx/PopulateComplainStatus",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var ddl = $("[id*=ddlStatus]");
                    $("#ddlStatus option").remove();
                    $.each(r.d, function () {
                        ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    ddl.selectpicker('refresh');
                }
            });

            function formatDate(date) {
                var d = new Date(date),
                    month = '' + (d.getMonth() + 1),
                    day = '' + d.getDate(),
                    year = d.getFullYear();

                if (month.length < 2) month = '0' + month;
                if (day.length < 2) day = '0' + day;

                return [day, month, year].join('-');
            }

            $("#btnSearch").click(function () {

                var fromdate = $("#txtFromDate").val();
                var todate = $("#txtTodate").val();

                var status = 0;

                if ($("#ddlStatus").val() != "") {
                    status = $("#ddlStatus").val()
                }
                var table = [];
                var tokenNo = $("#txtTokenNo").val();
                $.ajax({
                    type: "POST",
                    url: "GrievanceStatus.aspx/GetAllComplainData",
                    data: '{fromDate:' + JSON.stringify(fromdate) + ',toDate:' + JSON.stringify(todate) + ',status:' + status + ',tokenno:' + JSON.stringify(tokenNo) + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r, i) {
                        table = $.parseJSON(r.d);
                        $('#demo-dt-basic tbody').empty();
                        $.each(table, function (index, value) {
                            var row = '<tr><td style="width: 5%; text-align: center">' + (index + 1) + ' </td>';
                            row = row + '<td style="width: 10%">' + value.ComplainTokenNo + ' </td>';
                            row = row + '<td style="width: 10%"> ' + value.ComplainType + ' </td>';
                            row = row + '<td style="width: 10%"> ' + value.ComplainSubType + ' </td>';
                            row = row + '<td style="width: 5%"> ' + formatDate(value.ComplainDate) + '</td>';
                            row = row + '<td style="width: 30%"> ' + value.Complain + ' </td>';

                            if (value.FilePath == "")
                                row = row + '<td style="width: 10%;text-align:center" >' + 'Not Available' + ' </td>';
                            else
                                row = row + '<td style="width: 10%;text-align:center"><a href="../<%=DBLayer.LodgeGrievanceDirectory%>/' + value.FilePath + '" target="_blank" class="btn btn-xs btn-primary">View File</a></td>';

                            if (value.CurrentStatus == "1")
                                row = row + '<td style="width: 10%;text-align:center"><span class="label label-table label-primary">Open</span> </td>';
                            else if (value.CurrentStatus == "2")
                                row = row + '<td style="width: 10%;text-align:center"><span class="label label-table label-warning">Forwarded</span> </td>';
                            else if (value.CurrentStatus == "3")
                                row = row + '<td style="width: 10%;text-align:center"><span class="label label-table label-danger">Closed</span> </td>';
                            else if (value.CurrentStatus == "4")
                                row = row + '<td style="width: 10%;text-align:center"><span class="label label-table label-dark">Disapproved</span> </td>';
                            else if (value.CurrentStatus == "5")
                                row = row + '<td style="width: 10%;text-align:center"><span class="label label-table label-success">Approved</span> </td>';

                            row = row + '<td style="width:10%;text-align:center"><div class="btn-group btn-group-xs">';
                            row = row + ' <a href= "ViewGrievanceDetail.aspx?ckey=' + value.Complainkey + '" class="btn btn-info btn-icon icon-lg fa fa-list" data-id="' + value.Complainkey + '"  data-placement="top" data-original-title="View"></a>';
                            row = row + ' <a href= "PrintReceipt.aspx?ckey=' + value.Complainkey + '&type=S" class="btn btn-success btn-icon icon-lg fa fa-fax" data-id="' + value.Complainkey + '"  data-placement="top" data-original-title="Print"></a>';
                            row = row + '</div></td>';


                            row = row + '</tr>'

                            $('#demo-dt-basic tbody').append(row);

                        });
                        $('#demo-dt-basic tbody').DataTable.drow();
                    },
                    error: function (e) {
                        alert("Something Went Wrong.!");
                    }
                });
            })
        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="content-container">
        <!--Page Title-->
        <!--------------------------------------------------------->
        <div class="pageheader hidden-xs">
            <h3><i class="fa fa-home"></i>View Grievances Status </h3>
            <div class="breadcrumb-wrapper">
                <span class="label">You are here:</span>
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">Home </a></li>
                    <li class="active">Grievance Status</li>
                </ol>
            </div>
        </div>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <!--End page title-->

        <!--Page content-->
        <!--===================================================-->
        <div id="page-content">
            <div class="row">
                <div class="col-md-12">
                    <div class="panel">
                        <div class="panel-heading">
                            <h3 class="panel-title">
                                <span class="col-md-10"><strong>Search Criteria</strong></span>
                                <span class="col-md-2">
                                    <a href="LodgeGrievance.aspx"><span class="text-primary">Lodge New Grievance </span></a>
                                </span>
                            </h3>
                        </div>
                        <div class="panel-body">
                            <!-- Inline Form  -->
                            <!--===================================================-->
                            <div id="grievancestatus">
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <label class="control-label">From Date</label>
                                        <input type="text" id="txtFromDate" placeholder="dd/mm/yyyy" data-date-format="dd/mm/yyyy" data-date-viewmode="years" data-mask="99/99/9999" class="form-control" />
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <label class="control-label">To Date</label>
                                        <input type="text" id="txtTodate" placeholder="dd/mm/yyyy" data-date-format="dd/mm/yyyy" data-date-viewmode="years" data-mask="99/99/9999" class="form-control" />
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label class="control-label" for="ddlStatus">Grievance Status</label>
                                        <select class="form-control selectpicker col-lg-10" id="ddlStatus">
                                            <option>All Status</option>
                                            <option>Approved</option>
                                            <option>Disapproved</option>
                                            <option>Forwarded</option>
                                            <option>Open</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label class="control-label" for="txtTokenNo">Grievance No</label>
                                        <input type="text" class="form-control" placeholder="Grievance No" id="txtTokenNo" />
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group mar-top-25">
                                        <button class="btn btn-info" type="button" id="btnSearch">Search</button>
                                    </div>
                                </div>


                            </div>
                            <!--===================================================-->
                            <!-- End Inline Form  -->
                        </div>
                    </div>
                </div>

            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="panel">
                        <div class="panel-heading">
                            <h3 class="panel-title"><strong>Search Result</strong></h3>
                        </div>
                        <div class="panel-body" id="pnlSearch">
                            <table id="demo-dt-basic" class="table table-striped table-bordered table-responsive">
                                <thead>
                                    <tr>
                                        <th style="width: 5%" class="text-center">S.No.</th>
                                        <th style="width: 10%">Grievance No</th>
                                        <th style="width: 10%" class="min-desktop">Grievance Type</th>
                                        <th style="width: 10%" class="min-desktop">Grievance Sub-Type</th>
                                        <th style="width: 8%" class="min-desktop">Grievance Date</th>
                                        <th style="width: 27%" class="min-desktop">Grievance Detail</th>
                                        <th style="width: 10%; text-align: center" class="min-desktop">Attachment</th>
                                        <th style="width: 10%; text-align: center" class="min-desktop text-center">Status</th>
                                        <th style="width: 10%; text-align: center" class="min-desktop text-center">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%if (TableData.Tables.Count > 0)
                                      {
                                          for (var data = 0; data < TableData.Tables[0].Rows.Count; data++)
                                          {%>
                                    <tr>
                                        <td style="width: 5%; text-align: center">
                                            <%= data + 1%>.
                                        </td>
                                        <td style="width: 10%">
                                            <%=TableData.Tables[0].Rows[data]["ComplainTokenNo"]%>
                                        </td>
                                        <td style="width: 10%">
                                            <%=TableData.Tables[0].Rows[data]["ComplainType"]%>
                                        </td>
                                        <td style="width: 10%">
                                            <%=TableData.Tables[0].Rows[data]["ComplainSubType"]%>
                                        </td>
                                        <td style="width: 8%">
                                            <%=GeneralClass.GetDateForUI(TableData.Tables[0].Rows[data]["ComplainDate"])%>
                                        </td>
                                        <td style="width: 27%">
                                            <%=TableData.Tables[0].Rows[data]["Complain"]%>
                                        </td>
                                        <td style="width: 10%; text-align: center">
                                            <% if (TableData.Tables[0].Rows[data]["FilePath"].ToString() == "")
                                               { %>
                                                                            Not Available
                                                                        <%}
                                               else
                                               { %>
                                            <a href='<%= "../" + DBLayer.LodgeGrievanceDirectory + "/" + TableData.Tables[0].Rows[data]["FilePath"].ToString()%>'
                                                target="_blank" class="btn btn-xs btn-primary">View File</a>
                                            <%} %>
                                        </td>
                                        <td style="width: 10%; text-align: center">
                                            <% if (TableData.Tables[0].Rows[data]["CurrentStatus"].ToString() == "1")
                                               { %>
                                            <span class="label label-table label-primary">Open</span>
                                            <%}
                                               else if (TableData.Tables[0].Rows[data]["CurrentStatus"].ToString() == "2")
                                               {%>
                                            <span class="label label-table label-warning">Forwarded</span>
                                            <%}
                                               else if (TableData.Tables[0].Rows[data]["CurrentStatus"].ToString() == "5")
                                               {%>
                                            <span class="label label-table label-success">Approved</span>
                                            <%}
                                               else if (TableData.Tables[0].Rows[data]["CurrentStatus"].ToString() == "4")
                                               {%>
                                            <span class="label label-table label-dark">Disapproved</span>
                                            <%}
                                               else if (TableData.Tables[0].Rows[data]["CurrentStatus"].ToString() == "3")
                                               {%>
                                            <span class="label label-table label-danger">Closed</span>
                                            <%} %>
                                        </td>
                                        <td style="width: 10%; text-align: center">
                                            <div class="btn-group btn-group-xs">
                                                <a href="ViewGrievanceDetail.aspx?ckey=<%=TableData.Tables[0].Rows[data]["Complainkey"] %>" class="btn btn-info btn-icon icon-lg fa fa-list add-tooltip" data-id="<%=TableData.Tables[0].Rows[data]["Complainkey"] %>"
                                                    data-placement="top" data-original-title="View"></a>
                                                <a href="PrintReceipt.aspx?ckey=<%=TableData.Tables[0].Rows[data]["Complainkey"] %>&type=S" class="btn btn-success btn-icon icon-lg fa fa-fax" data-id="<%=TableData.Tables[0].Rows[data]["Complainkey"] %>"
                                                    data-placement="top" data-original-title="Print"></a>
                                            </div>
                                        </td>
                                    </tr>
                                    <%} %>
                                    <%} %>
                                </tbody>
                            </table>

                        </div>
                    </div>
                </div>


            </div>
            <!--===================================================-->
            <!--End page content-->
        </div>

    </div>
    <!--===================================================-->
    <!--END CONTENT CONTAINER-->
    <!--DataTables Sample [ SAMPLE ]-->
    <script src="../plugins/bootstrap-validator/bootstrapValidator.min.js"></script>
    <script src="../js/demo/form-validation.js"></script>
    <!--DataTables Sample [ SAMPLE ]-->
    <script src="../js/demo/tables-datatables.js"></script>
    <!--Form Component [ SAMPLE ]-->

    <!--Form Component [ SAMPLE ]-->
    <script src="../js/demo/form-component.js"></script>
</asp:Content>


