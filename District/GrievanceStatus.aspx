<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DistrictMaster.master" AutoEventWireup="true" CodeFile="GrievanceStatus.aspx.cs" Inherits="Department_GrievanceStatus" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../js/jquery-2.1.1.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
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

                            row = row + '<td style="width: 10%;text-align:center" >' + value.RemainingTime + ' </td>';

                            if (value.Status == "Open")
                                row = row + '<td style="width: 10%;text-align:center"><span class="label label-table label-primary">Open</span> </td>';
                            else if (value.Status == "Forwarded")
                                row = row + '<td style="width: 10%;text-align:center"><span class="label label-table label-warning">Forwarded</span> </td>';
                            else if (value.Status == "Closed")
                                row = row + '<td style="width: 10%;text-align:center"><span class="label label-table label-danger">Closed</span> </td>';
                            else if (value.Status == "Disapproved")
                                row = row + '<td style="width: 10%;text-align:center"><span class="label label-table label-dark">Disapproved</span> </td>';
                            else if (value.Status == "Approved")
                                row = row + '<td style="width: 10%;text-align:center"><span class="label label-table label-success">Approved</span> </td>';

                            row = row + '<td style="width:10%;text-align:center"><div class="btn-group btn-group-xs">';
                            row = row + ' <a href= "EditGrievance.aspx?ckey=' + value.Complainkey + '" class="btn btn-info btn-icon icon-lg fa fa-edit ' + (value.Status != "Open" ? 'disabled' : '') + '" data-id="' + value.Complainkey + '"  data-placement="top" data-original-title="Edit" ></a>';
                            row = row + ' <a href= "ViewGrievanceDetail.aspx?ckey=' + value.Complainkey + '" class="btn btn-success btn-icon icon-lg fa fa-list" data-id="' + value.Complainkey + '"  data-placement="top" data-original-title="View"></a>';
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
        <!------------------------------------------------------->
        <!--End page title-->

        <!--Page content-->
        <!--===================================================-->
        <div id="page-content">
            <div class="row">
                <div class="col-md-12">
                    <div class="panel">
                        <div class="panel-heading">
                            <h3 class="panel-title">
                                <span class="col-md-10">Search Criteria</span>

                            </h3>
                        </div>
                        <div class="panel-body">
                            <!-- Inline Form  -->
                            <!--===================================================-->
                            <div id="grievancestatus">
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <label class="control-label">From Date</label>
                                        <input type="text" id="txtFromDate" placeholder="dd/mm/yyyy" data-mask="99/99/9999" class="form-control" />
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <label class="control-label">To Date</label>
                                        <input type="text" id="txtTodate" placeholder="dd/mm/yyyy" data-mask="99/99/9999" class="form-control" />
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

                            <h3 class="panel-title">Search Result</h3>
                        </div>
                        <div class="panel-body" id="pnlSearch">
                            <table id="demo-dt-basic" class="table table-striped table-bordered table-responsive">
                                <thead>
                                    <tr>
                                        <th style="width: 5%" class="text-center">S.No.</th>
                                        <th style="width: 10%">Grievance No</th>
                                        <th style="width: 10%" class="min-desktop">Grievance Type</th>
                                        <th style="width: 10%" class="min-desktop">Grievance Sub-Type</th>
                                        <th style="width: 5%" class="min-desktop">Grievance Date</th>
                                        <th style="width: 30%" class="min-desktop">Grievance Detail</th>
                                        <th style="width: 10%; text-align: center" class="min-desktop">Remaining Time</th>
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
                                        <td style="width: 5%">
                                            <%=GeneralClass.GetDateForUI(TableData.Tables[0].Rows[data]["ComplainDate"])%>
                                        </td>
                                        <td style="width: 30%">
                                            <%=TableData.Tables[0].Rows[data]["Complain"]%>
                                        </td>
                                        <td style="width: 10%; text-align: center">
                                            <%=TableData.Tables[0].Rows[data]["RemainingTime"]%>
                                        </td>
                                        <td style="width: 10%; text-align: center">
                                            <% if (TableData.Tables[0].Rows[data]["Status"].ToString() == "Open")
                                               { %>
                                            <span class="label label-table label-primary">Open</span>
                                            <%}
                                               else if (TableData.Tables[0].Rows[data]["Status"].ToString() == "Forwarded")
                                               {%>
                                            <span class="label label-table label-warning">Forwarded</span>
                                            <%}
                                               else if (TableData.Tables[0].Rows[data]["Status"].ToString() == "Approved")
                                               {%>
                                            <span class="label label-table label-success">Approved</span>
                                            <%}
                                               else if (TableData.Tables[0].Rows[data]["Status"].ToString() == "Disapproved")
                                               {%>
                                            <span class="label label-table label-dark">Disapproved</span>
                                            <%}
                                               else if (TableData.Tables[0].Rows[data]["Status"].ToString() == "Closed")
                                               {%>
                                            <span class="label label-table label-danger">Closed</span>
                                            <%} %>
                                        </td>
                                        <td style="width: 10%; text-align: center">
                                            <div class="btn-group btn-group-xs">
                                                <% if (TableData.Tables[0].Rows[data]["Status"].ToString() == "Open")
                                                   { %>
                                                <a href="EditGrievance.aspx?ckey=<%=TableData.Tables[0].Rows[data]["Complainkey"] %>" class="btn btn-info btn-icon icon-lg fa fa-edit " data-id="<%=TableData.Tables[0].Rows[data]["Complainkey"] %>"
                                                    data-placement="top" data-original-title="Edit"></a>
                                                <%}
                                                   else
                                                   {%>
                                                <a href="EditGrievance.aspx?ckey=<%=TableData.Tables[0].Rows[data]["Complainkey"] %>" class="btn btn-info btn-icon icon-lg fa fa-edit disabled" data-id="<%=TableData.Tables[0].Rows[data]["Complainkey"] %>"
                                                    data-placement="top" data-original-title="Edit"></a>
                                                <%}
                                                %>

                                                <a href="ViewGrievanceDetail.aspx?ckey=<%=TableData.Tables[0].Rows[data]["Complainkey"] %>" class="btn btn-success btn-icon icon-lg fa fa-list" data-id="<%=TableData.Tables[0].Rows[data]["Complainkey"] %>"
                                                    data-placement="top" data-original-title="View"></a>
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
    <script src="../js/jquery-2.1.1.min.js"></script>
    <script src="../js/demo/tables-datatables.js"></script>
</asp:Content>

