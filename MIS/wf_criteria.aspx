<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DistrictMaster.master" AutoEventWireup="true" CodeFile="wf_criteria.aspx.cs" Inherits="Report_District_wf_criteria" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="<%=ResolveUrl("~/js/jquery-2.1.1.min.js") %>"></script>
    <style>
        .panel-heading {
            background-color: #f9f9f9 !important;
        }

        .panel-title {
            line-height: 44px !important;
        }
    </style>


    <%-- For Load Data --%>
    <script type="text/javascript">
        var objMstArr = [];

        $(document).ready(function () {
            $('#pnlDetail').hide();

            if (parseInt('<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>') == 1) {
                $('#divForMandal').hide();
            }
            else {
                $('#divForMandal').show();
            }

            $.ajax({
                type: "POST",
                url: "wf_criteria.aspx/GetMandal",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var ddlType = $("#ddlDivisionName");
                    ddlType.empty();
                    ddlType.append($("<option selected disabled hidden></option>").val('').html('चयन करें'));
                    $.each(r.d, function () {
                        if (parseInt('<%=Convert.ToInt32(Session["DivisionKey"])%>') > 0 && parseInt('<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>') == 2) {
                            if (parseInt('<%=Convert.ToInt32(Session["DivisionKey"])%>') == parseInt(this['Value'])) {
                                ddlType.empty();
                                ddlType.append($("<option></option>").val(this['Value']).html(this['Text']));
                                ddlType.attr('disabled', 'disabled');
                                getDistrictName();
                            }
                        }
                        else {
                            ddlType.append($("<option></option>").val(this['Value']).html(this['Text']));
                        }
                    });
                    ddlType.selectpicker('refresh');
                }
            });

            $.ajax({
                type: "POST",
                url: "wf_criteria.aspx/GetMSR_Category",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var ddlType = $("#ddlCategoryName");
                    ddlType.empty();
                    ddlType.append($("<option selected></option>").val('').html('चयन करें'));
                    $.each(r.d, function () {
                        ddlType.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    ddlType.selectpicker('refresh');
                }
            });

            $.ajax({
                type: "POST",
                url: "wf_criteria.aspx/GetMonthName",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var ddlType = $("#ddlMonthName");
                    ddlType.empty();
                    ddlType.append($("<option selected disabled hidden></option>").val('').html('चयन करें'));
                    $.each(r.d, function () {
                        ddlType.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    ddlType.selectpicker('refresh');
                }
            });
        });

    </script>

    <%-- Show Report --%>
    <script type="text/javascript">
        function showReport() {
            var MonthId = $('#ddlMonthName').val();
            //var CateId = ($('#ddlCategoryName').val() == "" ? 0 : parseInt($('#ddlCategoryName').val()));
            var DivKey = ($('#ddlDivisionName').val() == "" ? 0 : parseInt($('#ddlDivisionName').val()));
            var DisKey = ($('#ddlDistrictName').val() == "" ? 0 : parseInt($('#ddlDistrictName').val()));

            DisKey = (isNaN(DisKey) ? 0 : DisKey);
            DivKey = (isNaN(DivKey) ? 0 : DivKey);

            if (MonthId > 0) {
                $.ajax({
                    type: "POST",
                    url: "wf_criteria.aspx/ShowReport",
                    data: '{MonthID:' + MonthId + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        if (r.d == "1") {
                          //  window.open("wf_ReportViewer.aspx?RptKey=1&FR=<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>&MonthKey=" + MonthId + "&DVKEY=" + DivKey + "", '_blank');
                            window.open("wf_ReportViewer.aspx?RptKey=1&FR=<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>&MonthKey=" + MonthId + "&DSKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 1 ? parseInt("<%=Convert.ToInt32(Session["DistrictKey"])%>") : DisKey) + "&DVKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 2 ? parseInt("<%=Convert.ToInt32(Session["DivisionKey"])%>") : DivKey) + "", '_blank');
                        }
                        else if (r.d == "2") {
                          //  window.open("wf_ReportViewer.aspx?RptKey=2&FR=<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>&MonthKey=" + MonthId + "&DVKEY=" + DivKey + "", '_blank');
                            window.open("wf_ReportViewer.aspx?RptKey=2&FR=<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>&MonthKey=" + MonthId + "&DSKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 1 ? parseInt("<%=Convert.ToInt32(Session["DistrictKey"])%>") : DisKey) + "&DVKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 2 ? parseInt("<%=Convert.ToInt32(Session["DivisionKey"])%>") : DivKey) + "", '_blank');
                        }
                        else if (r.d == "3") {
                            window.open("wf_ReportViewer.aspx?RptKey=3&FR=<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>&MonthKey=" + MonthId + "&DSKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 1 ? parseInt("<%= Convert.ToInt32(Session["DistrictKey"])%>") : DisKey) + "&DVKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 2 ? parseInt("<%=Convert.ToInt32(Session["DivisionKey"])%>") : DivKey) + "", '_blank');
                        }
                        else if (r.d == "4") {
                            window.open("wf_ReportViewer.aspx?RptKey=4&FR=<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>&MonthKey=" + MonthId + "&DSKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 1 ? parseInt("<%=Convert.ToInt32(Session["DistrictKey"])%>") : DisKey) + "&DVKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 2 ? parseInt("<%=Convert.ToInt32(Session["DivisionKey"])%>") : DivKey) + "", '_blank');
                        }
                        else if (r.d == "5") {
                            window.open("wf_ReportViewer.aspx?RptKey=5&FR=<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>&MonthKey=" + MonthId + "&DSKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 1 ? parseInt("<%=Convert.ToInt32(Session["DistrictKey"])%>") : DisKey) + "&DVKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 2 ? parseInt("<%=Convert.ToInt32(Session["DivisionKey"])%>") : DivKey) + "", '_blank');
                        }
                        else if (r.d == "6") {
                            window.open("wf_ReportViewer.aspx?RptKey=6&FR=<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>&MonthKey=" + MonthId + "&DSKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 1 ? parseInt("<%=Convert.ToInt32(Session["DistrictKey"])%>") : DisKey) + "&DVKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 2 ? parseInt("<%=Convert.ToInt32(Session["DivisionKey"])%>") : DivKey) + "", '_blank');
                        }
                        else if (r.d == "7") {
                            window.open("wf_ReportViewer.aspx?RptKey=7&FR=<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>&MonthKey=" + MonthId + "&DSKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 1 ? parseInt("<%=Convert.ToInt32(Session["DistrictKey"])%>") : DisKey) + "&DVKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 2 ? parseInt("<%=Convert.ToInt32(Session["DivisionKey"])%>") : DivKey) + "", '_blank');
                        }
                        else if (r.d == "8") {
                            window.open("wf_ReportViewer.aspx?RptKey=8&FR=<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>&MonthKey=" + MonthId + "&DSKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 1 ? parseInt("<%=Convert.ToInt32(Session["DistrictKey"])%>") : DisKey) + "&DVKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 2 ? parseInt("<%=Convert.ToInt32(Session["DivisionKey"])%>") : DivKey) + "", '_blank');
                        }
                        else if (r.d == "9") {
                            window.open("wf_ReportViewer.aspx?RptKey=9&FR=<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>&MonthKey=" + MonthId + "&DSKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 1 ? parseInt("<%=Convert.ToInt32(Session["DistrictKey"])%>") : DisKey) + "&DVKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 2 ? parseInt("<%=Convert.ToInt32(Session["DivisionKey"])%>") : DivKey) + "", '_blank');
                        }
                        else if (r.d == "10") {
                            window.open("wf_ReportViewer.aspx?RptKey=10&FR=<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>&MonthKey=" + MonthId + "&DSKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 1 ? parseInt("<%=Convert.ToInt32(Session["DistrictKey"])%>") : DisKey) + "&DVKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 2 ? parseInt("<%=Convert.ToInt32(Session["DivisionKey"])%>") : DivKey) + "", '_blank');
                        }
                        else if (r.d == "11") {
                            window.open("wf_ReportViewer.aspx?RptKey=11&FR=<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>&MonthKey=" + MonthId + "&DSKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 1 ? parseInt("<%=Convert.ToInt32(Session["DistrictKey"])%>") : DisKey) + "&DVKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 2 ? parseInt("<%=Convert.ToInt32(Session["DivisionKey"])%>") : DivKey) + "", '_blank');
                        }
                        else if (r.d == "12") {
                            window.open("wf_ReportViewer.aspx?RptKey=12&FR=<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>&MonthKey=" + MonthId + "&DSKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 1 ? parseInt("<%=Convert.ToInt32(Session["DistrictKey"])%>") : DisKey) + "&DVKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 2 ? parseInt("<%=Convert.ToInt32(Session["DivisionKey"])%>") : DivKey) + "", '_blank');
                        }
                        else if (r.d == "13") {
                            window.open("wf_ReportViewer.aspx?RptKey=13&FR=<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>&MonthKey=" + MonthId + "&DSKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 1 ? parseInt("<%=Convert.ToInt32(Session["DistrictKey"])%>") : DisKey) + "&DVKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 2 ? parseInt("<%=Convert.ToInt32(Session["DivisionKey"])%>") : DivKey) + "", '_blank');
                        }
                        else if (r.d == "14") {
                            window.open("wf_ReportViewer.aspx?RptKey=14&FR=<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>&MonthKey=" + MonthId + "&DSKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 1 ? parseInt("<%=Convert.ToInt32(Session["DistrictKey"])%>") : DisKey) + "&DVKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 2 ? parseInt("<%=Convert.ToInt32(Session["DivisionKey"])%>") : DivKey) + "", '_blank');
                        }
                        else if (r.d == "15") {
                            window.open("wf_ReportViewer.aspx?RptKey=15&FR=<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>&MonthKey=" + MonthId + "&DSKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 1 ? parseInt("<%=Convert.ToInt32(Session["DistrictKey"])%>") : DisKey) + "&DVKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 2 ? parseInt("<%=Convert.ToInt32(Session["DivisionKey"])%>") : DivKey) + "", '_blank');
                        }
                        else if (r.d == "16") {
                            window.open("wf_ReportViewer.aspx?RptKey=16&FR=<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>&MonthKey=" + MonthId + "&DSKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 1 ? parseInt("<%=Convert.ToInt32(Session["DistrictKey"])%>") : DisKey) + "&DVKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 2 ? parseInt("<%=Convert.ToInt32(Session["DivisionKey"])%>") : DivKey) + "", '_blank');
                        }
                        else if (r.d == "17") {
                            window.open("wf_ReportViewer.aspx?RptKey=17&FR=<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>&MonthKey=" + MonthId + "&DSKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 1 ? parseInt("<%=Convert.ToInt32(Session["DistrictKey"])%>") : DisKey) + "&DVKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 2 ? parseInt("<%=Convert.ToInt32(Session["DivisionKey"])%>") : DivKey) + "", '_blank');
                        }
                        else if (r.d == "18") {
                            window.open("wf_ReportViewer.aspx?RptKey=18&FR=<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>&MonthKey=" + MonthId + "&DSKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 1 ? parseInt("<%=Convert.ToInt32(Session["DistrictKey"])%>") : DisKey) + "&DVKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 2 ? parseInt("<%=Convert.ToInt32(Session["DivisionKey"])%>") : DivKey) + "", '_blank');
                        }
                        else if (r.d == "19") {
                            window.open("wf_ReportViewer.aspx?RptKey=19&FR=<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>&MonthKey=" + MonthId + "&DSKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 1 ? parseInt("<%=Convert.ToInt32(Session["DistrictKey"])%>") : DisKey) + "&DVKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 2 ? parseInt("<%=Convert.ToInt32(Session["DivisionKey"])%>") : DivKey) + "", '_blank');
                        }
                        else if (r.d == "20") {
                            window.open("wf_ReportViewer.aspx?RptKey=20&FR=<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>&MonthKey=" + MonthId + "&DSKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 1 ? parseInt("<%=Convert.ToInt32(Session["DistrictKey"])%>") : DisKey) + "&DVKEY=" + (parseInt("<%=Convert.ToInt32(HttpContext.Current.Session["FR"])%>") == 2 ? parseInt("<%=Convert.ToInt32(Session["DivisionKey"])%>") : DivKey) + "", '_blank');
                        }
                        else {
                            alert('Wrong Option Selection.');
                        }
                    }
                });
            }
        }

function getDistrictName() {
    var DivKey = $("#ddlDivisionName").val();
    $("#ddlDistrictName").empty();
    if (DivKey > 0) {
        $.ajax({
            type: "POST",
            url: "wf_criteria.aspx/GetDistrict",
            data: '{DivKey : ' + DivKey + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (r) {
                var ddl = $("#ddlDistrictName");
                ddl.append($("<option selected></option>").val('').html('चयन करें'));
                $.each(r.d, function () {
                    ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                });
                ddl.selectpicker('refresh');
            }
        });
    }
}
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="content-container">
        <asp:HiddenField ID="hidDistrictKey" runat="server" />
        <!--Page Title-->
        <!--------------------------------------------------------->
        <div class="pageheader hidden-xs">
            <h3><i class="fa fa-home"></i>
                <asp:Label ID="lblHeading" runat="server" Text="मत्स्य भौतिक कार्यक्रम सांख्यकीय - मासिक प्रतिवेदन "></asp:Label></h3>
            <div class="breadcrumb-wrapper">
                <%-- <span class="label">You are here:</span>--%>
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">होम </a></li>
                    <li class="active">
                        <asp:Label ID="lblHomeHeading" runat="server" Text="मत्स्य भौतिक कार्यक्रम सांख्यकीय - मासिक प्रतिवेदन "></asp:Label></li>
                </ol>
            </div>
        </div>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <!--End page title-->

        <div id="page-content">
            <div class="form-horizontal">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel">
                            <div class="panel-heading">
                                <h3 class="panel-title"><strong>
                                    <asp:Label ID="lblTitle" runat="server" Text="मत्स्य भौतिक कार्यक्रम सांख्यकीय - मासिक प्रतिवेदन "></asp:Label></strong></h3>
                            </div>
                            <!--No Label Form-->
                            <div class="panel-body" style="margin-top: -15px">
                                <h3 style="float: left">जनपद :
                                    <asp:Label ID="lblLoginType" runat="server" Text="कानपुर नगर"></asp:Label></h3>
                                <h3 style="float: right">वित्तीय वर्ष  :
                                     <asp:Label ID="lblFinYear" runat="server" Text="2018-2019"></asp:Label>
                                </h3>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel">
                            <%--<div class="panel-heading">
                                <h3 class="panel-title">माह का नाम</h3>
                            </div>--%>
                            <!--No Label Form-->
                            <div class="panel-body">
                                <!-- Inline Form  -->
                                <!--===================================================-->
                                <div class="row mar-top">
                                    <div id="divForMandal">
                                        <div class="col-lg-5">
                                            <fieldset>
                                                <div class="form-group">
                                                    <label class="col-lg-3 control-label">मण्डल का नाम</label>
                                                    <div class="col-lg-8">
                                                        <select class="form-control selectpicker" data-live-search="true" id="ddlDivisionName" onchange="getDistrictName();">
                                                        </select>
                                                    </div>
                                                </div>
                                            </fieldset>
                                        </div>
                                        <div class="col-lg-5" id="divForDistrict">
                                            <fieldset>
                                                <div class="form-group">
                                                    <label class="col-lg-3 control-label">जनपद का नाम</label>
                                                    <div class="col-lg-8">
                                                        <select class="form-control selectpicker" data-live-search="true" id="ddlDistrictName">
                                                        </select>
                                                    </div>
                                                </div>
                                            </fieldset>
                                        </div>
                                    </div>

                                    <div class="col-lg-5">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="col-lg-3 control-label">माह का नाम </label>
                                                <div class="col-lg-8">
                                                    <select class="form-control selectpicker" id="ddlMonthName">
                                                    </select>
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>
                                    <div class="col-lg-2">
                                        <button class="btn btn-warning align-right" type="button" onclick="showReport()">देखें</button>
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
