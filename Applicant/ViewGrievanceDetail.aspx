<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ApplicantMaster.Master" AutoEventWireup="true" CodeFile="ViewGrievanceDetail.aspx.cs" Inherits="Applicant_ViewGrievanceDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../js/jquery-2.1.1.min.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="content-container">
        <!--Page Title-->
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <div class="pageheader hidden-xs">
            <h3><i class="fa fa-home"></i>Grievance Action Detail</h3>
            <div class="breadcrumb-wrapper">
                <span class="label">You are here:</span>
                <ol class="breadcrumb">
                    <li><a href="#">Home </a></li>
                    <li class="active">Grievance Action Detail </li>
                </ol>
            </div>
        </div>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <!--End page title-->
        <div class="form-horizontal" id="complainsource">
            <div id="page-content">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel">
                            <%-- <div class="panel-heading">
                                <h3 class="panel-title">Grievance Action Detail</h3>
                            </div>--%>
                            <div class="panel-body form-horizontal">
                                <div class="alert alert-success" role="alert">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="col-md-3"><strong>Grievance No. : </strong></div>
                                            <div class="col-md-3"><%=TableData.Tables[0].Rows[0]["ComplainTokenNo"]%></div>
                                        </div>
                                         <div class="col-md-6">
                                            <div class="col-md-2"><strong>Dated : </strong></div>
                                            <div class="col-md-4"><%=TableData.Tables[0].Rows[0]["ComplainDate"]%></div>
                                        </div>
                                    </div>
                                </div>

                                <div class="panel">
                                    <div class="alert alert-primary" role="alert" style="margin-bottom: 0;">
                                        Personal Detail
                                    </div>
                                    <div class="table-responsive">
                                        <table class="table table-striped  table-bordered">
                                            <tbody>
                                                <tr>
                                                    <td class="col-xs-2">
                                                        <b>Applicant Name</b>
                                                    </td>
                                                    <td class="col-xs-4">
                                                        <%=TableData.Tables[0].Rows[0]["FullName"]%>
                                                    </td>
                                                    <td class="col-xs-2"><b>Mobile No.</b></td>
                                                    <td class="col-xs-4"><%=TableData.Tables[0].Rows[0]["MobileNo"]%></td>
                                                </tr>
                                                <tr>
                                                    <td class="col-xs-2">
                                                        <b>Aadhar No.</b>
                                                    </td>
                                                    <td class="col-xs-4">
                                                        <%=TableData.Tables[0].Rows[0]["AadharNo"]%>
                                                    </td>
                                                    <td class="col-xs-2"><b>Email-ID</b></td>
                                                    <td class="col-xs-4"><%=TableData.Tables[0].Rows[0]["EmailId"]%></td>
                                                </tr>
                                                <tr>
                                                    <td class="col-xs-2">
                                                        <b>Postal Address</b>
                                                    </td>
                                                    <td class="col-xs-4">
                                                        <%=TableData.Tables[0].Rows[0]["CurrentAddress"]%>
                                                    </td>
                                                    <td class="col-xs-2"><b></b></td>
                                                    <td class="col-xs-4"></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="panel">
                                    <div class="alert alert-primary" role="alert" style="margin-bottom: 0;">
                                        Grievance Information
                                    </div>
                                    <div class="table-responsive">
                                        <table class="table table-striped  table-bordered">
                                            <tbody>
                                                <tr>
                                                    <td class="col-xs-2"><b>Grievance Type</b>
                                                    </td>
                                                    <td class="col-xs-4">
                                                        <%=TableData.Tables[0].Rows[0]["ComplainTypeName"]%>
                                                    </td>
                                                    <td class="col-xs-2"><b>Grievance Sub Type</b>
                                                    </td>
                                                    <td class="col-xs-4">
                                                        <%=TableData.Tables[0].Rows[0]["ComplainSubTypeName"]%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="col-xs-2"><b>Time Frame (In Days)</b>
                                                    </td>
                                                    <td class="col-xs-4">
                                                        <%=TableData.Tables[0].Rows[0]["TimeFrame"]%>
                                                    </td>
                                                    <td class="col-xs-2"><b>Attached Document</b>
                                                    </td>
                                                    <td class="col-xs-4">
                                                        <% if (TableData.Tables[0].Rows[0]["AttachmentFile"].ToString() == "")
                                                           { %>
                                            Not Available
                                            <%}
                                                           else
                                                           { %>
                                                        <a href='<%= "../" + DBLayer.LodgeGrievanceDirectory + "/" + TableData.Tables[0].Rows[0]["AttachmentFile"]%>'
                                                            target="_blank" class="btn btn-xs btn-primary">View File</a>
                                                        <%} %>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="col-xs-2"><b>Grievance</b>
                                                    </td>
                                                    <td class="col-xs-4">
                                                        <%=TableData.Tables[0].Rows[0]["Complain"]%>
                                                    </td>
                                                    <td class="col-xs-2"><b>Current Status</b>
                                                    </td>
                                                    <td class="col-xs-4">
                                                        <% if (TableData.Tables[0].Rows[0]["CurrentStatus"].ToString() == "Open")
                                                           { %>
                                                        <span class="label label-md label-primary">
                                                            <%=TableData.Tables[0].Rows[0]["CurrentStatus"]%></span>
                                                        <%}
                                                           else if (TableData.Tables[0].Rows[0]["CurrentStatus"].ToString() == "Forwarded")
                                                           {%>
                                                        <span class="label label-md label-warning">
                                                            <%=TableData.Tables[0].Rows[0]["CurrentStatus"]%></span>
                                                        <%}
                                                           else if (TableData.Tables[0].Rows[0]["CurrentStatus"].ToString() == "Approved")
                                                           {%>
                                                        <span class="label label-md label-success">
                                                            <%=TableData.Tables[0].Rows[0]["CurrentStatus"]%></span>
                                                        <%}
                                                           else if (TableData.Tables[0].Rows[0]["CurrentStatus"].ToString() == "Disapproved")
                                                           {%>
                                                        <span class="label label-md label-dark">
                                                            <%=TableData.Tables[0].Rows[0]["CurrentStatus"]%></span>
                                                        <%} %>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="panel">
                                    <div class="alert alert-primary" role="alert" style="margin-bottom: 0;">
                                        Grievance Fowarding Detail
                                    </div>
                                    <div class="table-responsive">
                                        <table class="table table-striped table-bordered">
                                            <thead>
                                                <tr>
                                                    <th style="width: 5%; text-align: center">#</th>
                                                    <th style="width: 20%">Officer Name</th>
                                                    <th style="width: 12%">Action Date</th>
                                                    <th style="width: 45%">Action Taken (Remark)</th>
                                                    <th style="width: 10%; text-align: center">Status</th>
                                                    <th style="width: 8%; text-align: center">Attachment</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%if (TableData2.Tables.Count > 0)
                                                  {

                                                      for (var data = 0; data < TableData2.Tables[0].Rows.Count; data++)
                                                      {%>
                                                <tr>
                                                    <td style="width: 5%; text-align: center">
                                                        <%= data + 1 %>.
                                                    </td>
                                                    <td style="width: 20%">
                                                        <% if (TableData2.Tables[0].Rows[data]["DesignationCode"].ToString() == "C.E.O.")
                                                           { %>
                                                        <%=TableData2.Tables[0].Rows[data]["DesignationName"] %>
                                                        <%}
                                                           else
                                                           {%>
                                                        <%=TableData2.Tables[0].Rows[data]["Designation"]  %>
                                                        <% if (Convert.ToBoolean(TableData2.Tables[0].Rows[data]["IsForwardedByCEO"]) == true)
                                                           { %>

                                                        <span class="label label-md label-success" style="line-height: 2!important">Action by C.E.O.</span>
                                                        <%} %>
                                                        <%} %>
                                           
                                                    </td>

                                                    <td style="width: 12%">
                                                        <%= TableData2.Tables[0].Rows[data]["DateofAction"].ToString() == "" ? "--" : GeneralClass.GetDateForUI(TableData2.Tables[0].Rows[data]["DateofAction"]) %>
                                                    </td>
                                                    <td style="width: 45%">
                                                        <%=TableData2.Tables[0].Rows[data]["Remarks"].ToString() == "" ? "--" : TableData2.Tables[0].Rows[data]["Remarks"]%>
                                                    </td>
                                                    <td style="width: 10%; text-align: center">


                                                        <% if (TableData2.Tables[0].Rows[data]["Status"].ToString() == "Open")
                                                           { %>
                                                        <span class="label label-md label-primary"><%=TableData2.Tables[0].Rows[data]["Status"]%></span>
                                                        <%}
                                                           else if (TableData2.Tables[0].Rows[data]["Status"].ToString() == "Forwarded")
                                                           {%>
                                                        <span class="label label-md label-warning"><%=TableData2.Tables[0].Rows[data]["Status"]%></span>
                                                        <%}
                                                           else if (TableData2.Tables[0].Rows[data]["Status"].ToString() == "Approved")
                                                           {%>
                                                        <span class="label label-md label-success"><%=TableData2.Tables[0].Rows[data]["Status"]%></span>
                                                        <%}
                                                           else if (TableData2.Tables[0].Rows[data]["Status"].ToString() == "Disapproved")
                                                           {%>
                                                        <span class="label label-md label-dark"><%=TableData2.Tables[0].Rows[data]["Status"]%></span>
                                                        <%} %>
                                           
                                                    </td>
                                                    <td style="width: 8%; text-align: center">
                                                        <%=TableData2.Tables[0].Rows[data]["AttachedFile"].ToString() == "" ? "--" :  "<a href='../" + DBLayer.LodgeGrievanceDirectory + "/" + TableData2.Tables[0].Rows[data]["AttachedFile"] +"' target='_blank' class='btn btn-success'>View File</a>" %>
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
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>


