<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/HOMaster.master" AutoEventWireup="true" CodeFile="~/HO/SchemeStatus.aspx.cs"
    Inherits="HO_SchemeStatus" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .modal-lg {
            width: 1024px !important;
            margin-top: 15px;
        }

        .modal-header {
            background-color: #ccc !important;
            color: #fff;
            border-radius: 6px 6px 0px 0px !important;
        }

        .modal-content {
            border-radius: 6px 6px 0px 0px !important;
        }

        .modal-body h3 {
            padding: 0px 0px 15px 0px !important;
        }

        .colorCss {
            color: red;
            font-size: 12px;
        }
    </style>

    <script src="<%=ResolveUrl("~/js/jquery-2.1.1.min.js") %>"></script>
    <%-- View Application Model --%>
    <script type="text/javascript">
        $(document).ready(function () {
            //Load Scheme Type on Page Load
            $.ajax({
                type: "POST",
                url: "SchemeStatus.aspx/GetSchemesType",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var ddlType = $("#ddlSchemeNameType");
                    ddlType.empty();
                    ddlType.append($("<option selected disabled hidden></option>").val('').html('चयन करें'));
                    $.each(r.d, function () {
                        ddlType.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    ddlType.selectpicker('refresh');
                }
            });
        });

        function getSchemeName() {
            var schemetypeId = $("#ddlSchemeNameType").val();
            $("#<%=ddlSchemeName.ClientID%>").empty();
            if (schemetypeId > 0) {
                $.ajax({
                    type: "POST",
                    url: "SchemeStatus.aspx/GetSchemes",
                    data: '{key : ' + schemetypeId + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        var ddl = $("#<%=ddlSchemeName.ClientID%>");
                        ddl.append($("<option selected disabled hidden></option>").val('').html('चयन करें'));
                        $.each(r.d, function () {
                            ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                        });
                        ddl.selectpicker('refresh');
                    }
                });
                }
            }

            function setSchemeDet(appNo) {
                if (appNo != "") {
                    $.ajax({
                        type: "POST",
                        url: "SchemeStatus.aspx/GetApplicationScheme",
                        data: '{ApplicatonNo : ' + parseInt(appNo) + '}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (r) {
                            var schDet = $.parseJSON(r.d)[0];
                            $('#<%=lblApplicationNo.ClientID%>').text(schDet.ApplicationCode);
                            $('#<%=lblAppliedDate.ClientID%>').text(schDet.Applieddate);
                            $('#<%=lblApplicantName.ClientID%>').text(schDet.Name);
                            $('#<%=lblGender.ClientID%>').text(schDet.Gender);
                            $('#<%=lblDOB.ClientID%>').text(schDet.DateOfBirth);
                            $('#<%=lblCategory.ClientID%>').text(schDet.Caste);
                            $('#<%=lblPostalAddress.ClientID%>').text(schDet.PostallAddress);
                            $('#<%=lblVillage.ClientID%>').text(schDet.RevenueVillage);
                            $('#<%=lblPostOffice.ClientID%>').text(schDet.PostOffice);
                            $('#<%=lblTehsil.ClientID%>').text(schDet.TehsilName);
                            $('#<%=lblBlock.ClientID%>').text(schDet.BlockName);
                            $('#<%=lblDistrict.ClientID%>').text(schDet.DistrictName);
                            $('#<%=lblMobileNo.ClientID%>').text(schDet.MobileNo);
                            $('#<%=lblEmailId.ClientID%>').text(schDet.EmailID);
                            $('#<%=lblPinCode.ClientID%>').text(schDet.PinNo);

                            $('#<%=lblProposedWork.ClientID%>').text(schDet.ProposedWork);
                            $('#<%=lblLandArea.ClientID%>').text(schDet.LandArea);
                            $('#<%=lblWaterArea.ClientID%>').text(schDet.WaterArea);
                            $('#<%=lblPlotNo.ClientID%>').text(schDet.PlotNo);
                            $('#<%=lblProjectCost.ClientID%>').text(schDet.ProjectCost);
                            $('#<%=lblBeneficiariesSahre.ClientID%>').text(schDet.BenShareCost);
                            $('#<%=lblSubsidyAmount.ClientID%>').text(schDet.TotalSubAmount);
                            $('#<%=lblCentralShare.ClientID%>').text(schDet.CenShareCost);
                            $('#<%=lblStateShare.ClientID%>').text(schDet.StaShareCost);
                            $('#<%=lblExperience.ClientID%>').text(schDet.APTExperience);
                            $('#<%=lblEconomicOperation.ClientID%>').text(schDet.EcoOperation);

                            $('#<%=lblBankName.ClientID%>').text(schDet.BankName);
                            $('#<%=lblBranchName.ClientID%>').text(schDet.BranchName);
                            $('#<%=lblBankAddress.ClientID%>').text(schDet.BranchAddress);
                            $('#<%=lblIFSCCode.ClientID%>').text(schDet.UserBankIFSC);
                            $('#<%=lblAccountNo.ClientID%>').text(schDet.UserAcNo);

                            $('#lblheading').text(schDet.SchemeName);
                            $('#ApplicationModel').modal('show');

                        }
                    });
                }
            }
    </script>

    <%-- View Document Model --%>
    <script type="text/javascript">
        function setSchemeDocs(appNo) {
            if (appNo != "") {
                $.ajax({
                    type: "POST",
                    url: "SchemeStatus.aspx/GetApplicationBasicWithDocs",
                    data: '{ApplicatonNo : ' + parseInt(appNo) + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        var sr = 1;
                        var schDet = $.parseJSON(r.d);
                        $('#tblApplicantDocs tbody').empty();
                        $.each(schDet, function (index, value) {

                            $('#<%=lblApplicationNo2.ClientID%>').text(value.ApplicationCode);
                            $('#<%=lblAppliedDate2.ClientID%>').text(value.Applieddate);
                            $('#<%=lblApplicantName2.ClientID%>').text(value.Name);
                            $('#<%=lblAadharNo.ClientID%>').text(value.ApplicationCode);
                            $('#<%=lblMobileNo2.ClientID%>').text(value.MobileNo);
                            $('#<%=lblEmailId2.ClientID%>').text(value.EmailID);

                            $('#lblDocHead').text(value.SchemeName);

                            var row = '<tr> <td class="text-center">' + sr + '.</td>';
                            row = row + '<td>' + value.DocumentName + '</td>';
                            row = row + '<td class="text-center"><a data-placement="top" href="../<%=DBLayer.APT_SchemeDocuments%>/' + value.DocFilePath + '"';
                            row = row + 'data-original-title="Click to view document" class="btn btn-primary tooltips btn-xs " target="_blank">';
                            row = row + '<i class="glyphicon glyphicon-upload"></i>&nbsp;<span>View</span></a>';
                            row = row + ' </td></tr>';

                            sr = parseInt(sr) + 1;

                            $('#tblApplicantDocs tbody').append(row);

                        });

                        $('#documentModel').modal('show');

                    }
                });
            }
        }
    </script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#divObjectionRemark').css({ 'display': 'none' });
            $('#divStatusRemark').css({ 'display': 'none' });

            $("#chkForward").attr("disabled", "disabled");
            $("#chkApplication").attr("disabled", "disabled");
            $("#chkDocument").attr("disabled", "disabled");

            $("input[name='ST']").change(function () {
                if ($(this).val() == 1) {
                    $("#chkForward").attr("disabled", "disabled");
                    $("#chkApplication").removeAttr("disabled");
                    $("#chkDocument").removeAttr("disabled");
                    $('#chkForward').attr('checked', false);
                    $('#divStatusRemark').fadeOut('slow');
                }
                else {
                    $("#chkForward").removeAttr("disabled");
                    $("#chkApplication").attr("disabled", "disabled");
                    $("#chkDocument").attr("disabled", "disabled");

                    $('#chkApplication').attr('checked', false);
                    $('#chkDocument').attr('checked', false);
                    $('#divObjectionRemark').fadeOut('slow');
                }
            });

            $('#chkForward').change(function () {
                if (this.checked)
                    $('#divStatusRemark').fadeIn('slow');
                else
                    $('#divStatusRemark').fadeOut('slow');

            });

            $("input[name='ApplicationObjection']").change(function () {
                if (this.checked)
                    $('#divObjectionRemark').fadeIn('slow');
                else
                    $('#divObjectionRemark').fadeOut('slow');

            });

        });
    </script>
    <%-- Update Status --%>
    <script type="text/javascript">
        function OnSubmit() {
            var appNos = [];
            event.preventDefault();
            $(".chkIds:checked").each(function () {
                var appNo = $(this).val();
                appNos.push(appNo);
            });

            if (appNos.length > 0) {
                var strappNos = "";
                $.each(appNos, function (ind, val) {
                    if (strappNos != "") {
                        strappNos = strappNos + "," + val;
                    } else {
                        strappNos = val;
                    }
                });

                $.ajax({
                    type: "POST",
                    url: "SchemeStatus.aspx/FinalSubmit",
                    data: '{appNos : ' + JSON.stringify(strappNos) + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        var data = $.parseJSON(r.d);
                        if (data.StatusCode) {
                            alert(data.Msg);
                        }
                    },
                    error: function (e) {

                    }
                });
            }
            else {
                alert('Please Select Applicant For Scheme Benefits');
            }
        }


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="content-container">
        <!--Page Title-->
        <!--------------------------------------------------------->
        <div class="pageheader hidden-xs">
            <h3><i class="fa fa-home"></i>Scheme Status </h3>
            <div class="breadcrumb-wrapper">
                <span class="label">You are here:</span>
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">Home </a></li>
                    <li class="active">Scheme Status</li>
                </ol>
            </div>
        </div>
        <!------------------------------------------------------->
        <!--End page title-->
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
                            <div id="schemeStatus">
                                <div class="row mar-top">
                                    <div class="col-lg-6">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="col-lg-3 control-label">Scheme Type </label>
                                                <div class="col-lg-9">
                                                    <select class="form-control selectpicker" data-live-search="true" id="ddlSchemeNameType" onchange="getSchemeName();">
                                                    </select>
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>
                                    <div class="col-lg-6">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="col-lg-3 control-label" for="ddlStatus">Scheme Name</label>
                                                <div class="col-lg-9">
                                                    <select class="form-control selectpicker" data-live-search="true" id="ddlSchemeName" runat="server">
                                                    </select>
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>
                                </div>
                                <div class="row mar-top">
                                    <div class="col-lg-3">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="col-lg-6 control-label" style="text-align: left; padding-top: 5px;">From Date</label>
                                                <div class="col-lg-6">
                                                    <input type="text" id="txtFromDate" placeholder="dd/mm/yyyy" data-mask="99/99/9999" class="form-control" style="margin-left: 5px;" />
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>
                                    <div class="col-lg-3">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class=" col-lg-6 control-label" style="text-align: right; padding-top: 5px;">To Date</label>
                                                <div class="col-lg-6">
                                                    <input type="text" id="txtTodate" placeholder="dd/mm/yyyy" data-mask="99/99/9999" class="form-control" />
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>
                                    <div class="col-lg-6">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="col-lg-3 control-label" for="ddlStatus">Scheme Status</label>
                                                <div class="col-lg-9">
                                                    <select class="form-control selectpicker" id="ddlStatus" runat="server">
                                                    </select>
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>
                                </div>
                                <div class="row mar-top">
                                    <div class="col-lg-6">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="col-lg-3 control-label" for="txtTokenNo">Application No</label>
                                                <div class="col-lg-9">
                                                    <input type="text" class="form-control" placeholder="Appication No" id="txtSearchApplicationNo" />
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <button class="btn btn-info" type="button" id="btnSearch">Search</button>
                                        </div>
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
                            <asp:Repeater ID="rptApplication" runat="server">
                                <HeaderTemplate>
                                    <table id="demo-dt-basic" class="table table-striped table-bordered table-responsive">
                                        <colgroup>
                                            <col width="5%" class="text-center" />
                                            <col width="5%" class="text-center" />
                                            <col width="10%" />
                                            <col width="30%" />
                                            <col width="26%" />
                                            <%--  <col width="15%" />--%>
                                            <col width="12%" />
                                            <col width="12%" />


                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th class="text-center">S.No.</th>
                                                <th class="text-center">#</th>
                                                <th>Application No</th>
                                                <th class="min-desktop">Scheme Name</th>
                                                <th class="min-desktop">Applicant Name</th>
                                                <%--                                                <th class="min-desktop">Father Name</th>--%>
                                                <th class="min-desktop">Applied Date</th>
                                                <th class="min-desktop text-center">Status</th>
                                                <th colspan="2" class="min-desktop text-center">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td class="text-center">
                                            <%#Container.ItemIndex+1 %>
                                            <asp:HiddenField ID="hidApplicationNo" runat="server" Value='<%#DataBinder.Eval(Container.DataItem, "ApplicationNo")%>' />
                                        </td>
                                        <td style="text-align: center;">
                                            <input type="checkbox" class="chkIds" value="<%#DataBinder.Eval(Container.DataItem, "ApplicationNo")%>" <%#(DataBinder.Eval(Container.DataItem, "StatusCode").ToString() == "47" ? "disabled" : "")%>></td>
                                        <td><%#DataBinder.Eval(Container.DataItem, "ApplicationCode")%></td>
                                        <td><%#DataBinder.Eval(Container.DataItem, "SchemeName")%></td>
                                        <td><%#DataBinder.Eval(Container.DataItem, "ApplicantName")%></td>
                                        <%-- <td><%#DataBinder.Eval(Container.DataItem, "FatherName")%></td>--%>
                                        <td>
                                            <%# GeneralClass.GetDateForUI(DataBinder.Eval(Container.DataItem,"Applieddate")) %>

                                        </td>
                                        <td class="text-center">
                                            <span class="label <%#DataBinder.Eval(Container.DataItem, "CssClass")%>">
                                                <%#DataBinder.Eval(Container.DataItem, "currentStatus")%></span>
                                        </td>
                                        <td class="text-center">
                                            <a href="javascript:void(0);" class="btn btn-xs btn-info" data-placement="top"
                                                data-original-title="View Application" onclick="setSchemeDet('<%#DataBinder.Eval(Container.DataItem, "ApplicationNo")%>')">View Application</a>
                                        </td>
                                        <td class="text-center">
                                            <a href="javascript:void(0);" class="btn btn-xs btn-mint" data-placement="top"
                                                data-original-title="View Application" onclick="setSchemeDocs('<%#DataBinder.Eval(Container.DataItem, "ApplicationNo")%>')">View Documents</a>

                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    </tbody>
                                     </table>
                                </FooterTemplate>
                            </asp:Repeater>

                        </div>
                        <div class="panel-footer">
                            <button class="btn btn-info" type="button" id="btnSubmit" onclick="OnSubmit()">सुरक्षित करें</button>
                            &nbsp;&nbsp;&nbsp;
                                 <button class="btn btn-warning" type="button">निरस्त करें</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- start: Application Print Popup -->
    <div class="modal fade bd-example-modal-lg form-horizontal" id="ApplicationModel" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="myLargeModalLabel">Application View
                    </h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <h3>
                        <label id="lblheading"></label>
                    </h3>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="list-group-item list-group-item-warning">
                                <strong>About Applicant</strong>
                            </div>
                            <table class="table table-striped table-hover table-full-width text-black">
                                <tbody>
                                    <tr>
                                        <td class="col-xs-2">
                                            <strong>Application No</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="lblApplicationNo" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        <td class="col-xs-2">
                                            <strong>Applied Date</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="lblAppliedDate" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-2">
                                            <strong>Applicant Name</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="lblApplicantName" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        <td class="col-xs-2">
                                            <strong>Father's Name</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="lblFatherName" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-2">
                                            <strong>Gender </strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="lblGender" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        <td class="col-xs-2">
                                            <strong>Date of Birth</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="lblDOB" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-2">
                                            <strong>Category</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="lblCategory" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        <td class="col-xs-2">
                                            <%--<strong>Caste</strong>--%>
                                        </td>
                                        <td class="col-xs-4">
                                            <%--<asp:Label ID="lblCaste" runat="server" CssClass="control-lable"></asp:Label>--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-2">
                                            <strong>Postal Address</strong>
                                        </td>
                                        <td class="col-xs-8" colspan="3">
                                            <asp:Label ID="lblPostalAddress" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td class="col-xs-2">
                                            <strong>Village</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="lblVillage" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        <td class="col-xs-2">
                                            <strong>Post Office</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="lblPostOffice" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-2">
                                            <strong>Tehsil </strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="lblTehsil" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        <td class="col-xs-2">
                                            <strong>Block</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="lblBlock" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-2">
                                            <strong>District</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="lblDistrict" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        <td class="col-xs-2">
                                            <strong>Pin Code</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="lblPinCode" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-2">
                                            <strong>Mobile No</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="lblMobileNo" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        <td class="col-xs-2">
                                            <strong>Email Id</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="lblEmailId" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="list-group-item list-group-item-warning">
                                <strong>Particular of Project</strong>
                            </div>
                            <table class="table table-striped table-hover table-full-width text-black">
                                <tbody>
                                    <tr>
                                        <td class="col-xs-3">
                                            <strong>Detail Of The Proposed Work</strong>
                                        </td>

                                        <td class="col-xs-8" colspan="3">
                                            <asp:Label ID="lblProposedWork" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-3">
                                            <strong>Total Land/Pond Area (ha)</strong>
                                        </td>
                                        <td class="col-xs-3">
                                            <asp:Label ID="lblLandArea" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        <td class="col-xs-3">
                                            <strong>Total Water Area (ha) </strong>
                                        </td>
                                        <td class="col-xs-3">
                                            <asp:Label ID="lblWaterArea" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-3">
                                            <strong>Survey/Khasra/Plot No. </strong>
                                        </td>
                                        <td class="col-xs-3">
                                            <asp:Label ID="lblPlotNo" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        <td class="col-xs-3">
                                            <strong>Projet Cost of Work</strong>
                                        </td>
                                        <td class="col-xs-3">
                                            <asp:Label ID="lblProjectCost" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="col-xs-3">
                                            <strong>Beneficiaries 60.00% Share (Rs.)</strong>
                                        </td>
                                        <td class="col-xs-3">
                                            <asp:Label ID="lblBeneficiariesSahre" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        <td class="col-xs-3">
                                            <strong>Total Subsidy Amount (Rs.)</strong>
                                        </td>
                                        <td class="col-xs-3">
                                            <asp:Label ID="lblSubsidyAmount" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-3">
                                            <strong>Central Share 50.00% of Total Subsidy (Rs.)</strong>
                                        </td>
                                        <td class="col-xs-3">
                                            <asp:Label ID="lblCentralShare" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        <td class="col-xs-3">
                                            <strong>State Share 50.00% of Total Subsidy (Rs.)</strong>
                                        </td>
                                        <td class="col-xs-3">
                                            <asp:Label ID="lblStateShare" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-3">
                                            <strong>Experience Of The Applicant</strong>
                                        </td>
                                        <td class="col-xs-8" colspan="3">
                                            <asp:Label ID="lblExperience" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td class="col-xs-3">
                                            <strong>Details Regarding Economics Of Operation</strong>
                                        </td>
                                        <td class="col-xs-8" colspan="3">
                                            <asp:Label ID="lblEconomicOperation" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>

                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="list-group-item list-group-item-warning">
                                <strong>Bank Detail</strong>
                            </div>
                            <table class="table table-striped table-hover table-full-width text-black">
                                <tbody>
                                    <tr>
                                        <td class="col-xs-2">
                                            <strong>Bank Name</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="lblBankName" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        <td class="col-xs-2">
                                            <strong>Branch Name</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="lblBranchName" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-2">
                                            <strong>IFSC Code</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="lblIFSCCode" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        <td class="col-xs-2">
                                            <strong>Account No.</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="lblAccountNo" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-2">
                                            <strong>Address </strong>
                                        </td>
                                        <td class="col-xs-4" colspan="3">
                                            <asp:Label ID="lblBankAddress" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>

                                    </tr>

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal" id="btnApplicationClose">Close</button>
                    <button type="button" class="btn btn-primary" id="btPrintApplication">Print Application Form</button>
                </div>
            </div>
        </div>
    </div>

    <!-- end: Application Print Popup -->

    <!-- start: Application Document Popup -->
    <div class="modal fade bd-example-modal-lg form-horizontal" id="documentModel" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel2" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="myLargeModalLabel2">Document View
                    </h4>

                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <h3>
                        <label id="lblDocHead"></label>
                    </h3>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="list-group-item list-group-item-warning">
                                <strong>About Applicant</strong>
                            </div>
                            <table class="table table-bordered text-black">
                                <tbody>
                                    <tr>
                                        <td class="col-xs-2">
                                            <strong>Application No</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="lblApplicationNo2" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        <td class="col-xs-2">
                                            <strong>Applied Date</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="lblAppliedDate2" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-2">
                                            <strong>Applicant Name</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="lblApplicantName2" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        <td class="col-xs-2">
                                            <strong>Aadhar No</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="lblAadharNo" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-2">
                                            <strong>Mobile No. </strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="lblMobileNo2" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        <td class="col-xs-2">
                                            <strong>Email ID</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="lblEmailId2" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                    </tr>

                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="list-group-item list-group-item-warning">
                                <strong>Document Details</strong>
                            </div>
                            <table class="table table-bordered text-black" id="tblApplicantDocs">
                                <colgroup>
                                    <col width="5%" />
                                    <col width="85%" />
                                    <col width="10%" />
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th class="text-center">S.No</th>
                                        <th>Document Name</th>
                                        <th class="text-center">View</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal" id="btnDocClose">Close</button>
                    <button type="button" class="btn btn-primary" id="btnDocPrint">Print Document</button>
                </div>
            </div>
        </div>
    </div>

    <!-- end: Application Document Popup -->
</asp:Content>

