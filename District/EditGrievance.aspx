<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DistrictMaster.master" AutoEventWireup="true" EnableEventValidation="false" CodeFile="EditGrievance.aspx.cs" Inherits="District_EditGrievance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="http://www.google.com/jsapi"></script>
    <script src="../js/jquery-2.1.1.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#pnlForward').hide();
            $.ajax({
                type: "POST",
                url: "EditGrievance.aspx/GetSection",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",

                success: function (r) {
                    var section = $("#<%=ddlSection.ClientID%>");
                    section.empty().append('<option selected="selected" value="0">Select</option>');
                    $.each(r.d, function () {
                        section.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    section.selectpicker('refresh');
                }
            });
        });

            function getOfficerName() {
                var sectionkey = $('#<%=ddlSection.ClientID%> :selected').val();

                $("#ContentPlaceHolder1_hidSection").val(sectionkey);
                $.ajax({
                    type: "POST",
                    url: "EditGrievance.aspx/GetOfficerDesignation",
                    data: '{seckey: "' + sectionkey + '" }',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    success: function (r) {
                        var desig = $("#<%=ddlDesignation.ClientID%>");
                        desig.empty().append('<option selected="selected" value="0">Select</option>');
                        $.each(r.d, function () {
                            desig.append($("<option></option>").val(this['Value']).html(this['Text']));
                        });
                        desig.selectpicker('refresh');
                    }
                });

                }

                function getStatus() {
                    var status = $('#<%=ddlStatus.ClientID%>').val();
                    if (status == 2) {
                        $('#pnlForward').show();
                    }
                    else
                        $('#pnlForward').hide();
                }

                function getofficerwithdesig() {
                    var desig = $('#ContentPlaceHolder1_ddlDesignation :selected').val();
                    $("#ContentPlaceHolder1_hidOfficerWithDesig").val(desig);
                }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="content-container">
        <!--Page Title-->
        <!--------------------------------------------------------->
        <div class="pageheader hidden-xs">
            <h3><i class="fa fa-home"></i>Edit Grievance </h3>
            <div class="breadcrumb-wrapper">
                <span class="label">You are here:</span>
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">Home </a></li>
                    <li class="active">Edit Grievance</li>
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
                        <div class="panel">
                            <div class="alert alert-primary" role="alert" style="margin-bottom: 0;">
                                About Applicant
                            </div>
                            <div class="table-responsive">
                                <table class="table table-striped  table-bordered">
                                    <tbody>
                                        <tr>
                                            <td class="col-xs-2">
                                                <strong>Grievance No</strong>
                                            </td>
                                            <td class="col-xs-4">
                                                <strong>
                                                    <%=TableData.Tables[0].Rows[0]["ComplainTokenNo"]%></strong>
                                            </td>
                                            <td class="col-xs-2">
                                                <strong>Grievance Date</strong>
                                            </td>
                                            <td class="col-xs-4">
                                                <strong>
                                                    <%=TableData.Tables[0].Rows[0]["ComplainDate"]%></strong>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="col-xs-2">Grievance Type
                                            </td>
                                            <td class="col-xs-4">
                                                <%=TableData.Tables[0].Rows[0]["ComplainTypeName"]%>
                                            </td>
                                            <td class="col-xs-2">Grievance Sub Type
                                            </td>
                                            <td class="col-xs-4">
                                                <%=TableData.Tables[0].Rows[0]["ComplainSubTypeName"]%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="col-xs-2">Applicant Name
                                            </td>
                                            <td class="col-xs-4">
                                                <%=TableData.Tables[0].Rows[0]["FullName"]%>
                                            </td>
                                            <td class="col-xs-2">Mobile No
                                            </td>
                                            <td class="col-xs-4">
                                                <%=TableData.Tables[0].Rows[0]["MobileNo"]%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="col-xs-2">Applicant Address
                                            </td>
                                            <td class="col-xs-4">
                                                <%=TableData.Tables[0].Rows[0]["CurrentAddress"]%>
                                            </td>
                                            <td class="col-xs-2">Attached Document
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
                                    </tbody>
                                </table>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <div class="panel panel-white">
                        <div class="panel-heading">
                            <h4 class="panel-title">Grievance <span class="text-bold">Status</span></h4>
                        </div>
                        <div class="panel-body" style="height: 405px; overflow-y: scroll">
                            <table class="table table-condensed table-hover">
                                <% if (TableData2.Tables.Count > 0)
                                   {
                                       for (var data = 0; data < TableData2.Tables[0].Rows.Count; data++)
                                       {%>
                                <thead>
                                    <tr>
                                        <th colspan="3">Step
                                        <%=TableData2.Tables[0].Rows[data]["StepNo"]%>.
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Action Taken By
                                        </td>
                                        <td>
                                            <% if (TableData2.Tables[0].Rows[data]["DesignationCode"].ToString() == "C.E.O.")
                                               { %>
                                            <%=TableData2.Tables[0].Rows[data]["FromOfficerName"] + " (" + TableData2.Tables[0].Rows[data]["DesignationName"] + ")"%>
                                            <%}
                                               else
                                               {%>
                                            <%=TableData2.Tables[0].Rows[data]["FromOfficerName"] +" ("+ TableData2.Tables[0].Rows[data]["Designation"] +")" %>
                                            <%} %>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Date of Action
                                        </td>
                                        <td>
                                            <%=GeneralClass.GetDateForUI(TableData2.Tables[0].Rows[data]["DateOfAction"])%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Remarks
                                        </td>
                                        <td>
                                            <%=TableData2.Tables[0].Rows[data]["Remarks"]%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Status
                                        </td>
                                        <td>
                                            <% if (TableData2.Tables[0].Rows[data]["Status"].ToString() == "Forwarded")
                                               { %>
                                            <%=TableData2.Tables[0].Rows[data]["Status"]%>
                                            <%}
                                               else
                                               {%>
                                            <%=TableData2.Tables[0].Rows[data]["Status"]%>
                                            <%} %>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Attached File
                                        </td>
                                        <td>
                                            <% if (TableData2.Tables[0].Rows[data]["AttachedFile"].ToString() == "")
                                               { %>
                                        Not Available
                                        <%}
                                               else
                                               { %>
                                            <a href='<%= "../" + DBLayer.LodgeGrievanceDirectory + "/" + TableData2.Tables[0].Rows[data]["AttachedFile"]%>'
                                                target="_blank" class="btn btn-xs btn-primary">View File</a>
                                            <%} %>
                                        </td>
                                    </tr>
                                </tbody>
                                <%} %>
                                <%}
                                   else
                                   { %>

                                <%} %>
                            </table>
                            <div class="list-group-item list-group-item-info">
                                <strong>No Action Taken</strong>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="col-md-6">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="panel">
                                <div class="panel-heading">
                                    <h4 class="panel-title">Action <span class="text-bold">To Be Taken</span></h4>
                                </div>
                                <form class="form-horizontal" runat="server">
                                    <div class="panel-body">
                                        <div class="col-sm-12">
                                            <div class="form-group">
                                                <label class="control-label" for="txtRemark">Remark *</label>
                                                <asp:TextBox ID="txtRemark" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-sm-12">
                                            <div class="form-group">
                                                <label class="control-label" for="ddlStatus">Action (Status) *</label>
                                                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control selectpicker" onchange="getStatus()">
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div id="pnlForward">
                                            <div class="col-sm-12">
                                                <div class="form-group">
                                                    <label class="control-label" for="ddlSection">Forward To (Section) *</label>
                                                    <asp:DropDownList ID="ddlSection" runat="server" CssClass="form-control selectpicker" onchange="getOfficerName()">
                                                    </asp:DropDownList>
                                                    <asp:HiddenField ID="hidSection" runat="server" />
                                                </div>
                                            </div>
                                            <div class="col-sm-12">
                                                <div class="form-group">
                                                    <label class="control-label" for="ddlDesignation">Officer (With Designation) *</label>
                                                    <asp:DropDownList ID="ddlDesignation" runat="server" CssClass="form-control selectpicker" onchange="getofficerwithdesig()">
                                                    </asp:DropDownList>
                                                    <asp:HiddenField ID="hidOfficerWithDesig" runat="server" />
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-sm-12">
                                            <div class="form-group">
                                                <label class="control-label" for="flAttachmentfile">Attachment (If Any)</label>
                                                <asp:FileUpload ID="flAttachmentfile" runat="server" CssClass="form-control" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="panel-footer">
                                        <div class="row">
                                            <div class="col-sm-7 col-sm-offset-3">
                                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-success btn-lg"
                                                    OnClick="btnSubmit_Click" />

                                                <a href="GrievanceStatus.aspx" class="btn btn-warning btn-lg">Back</a>

                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
        </div>

        <!--===================================================-->
        <!--End page content-->
    </div>
    <!--===================================================-->
    <!--END CONTENT CONTAINER-->
    <!--DataTables Sample [ SAMPLE ]-->
    <script src="../js/jquery-2.1.1.min.js"></script>
    <script src="../js/demo/tables-datatables.js"></script>
</asp:Content>


