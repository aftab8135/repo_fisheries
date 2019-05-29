<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DistrictMaster.master" AutoEventWireup="true" CodeFile="CriteriaFormScheme.aspx.cs" Inherits="Report_CriteriaFormScheme" %>

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
            if (parseInt('<%=RptKey%>') == 11 || parseInt('<%=RptKey%>') == 12 || parseInt('<%=RptKey%>') == 13) {
                $('#pnlScheme').hide();
            }
            if (parseInt('<%=FR%>') == 1) {
                $('#divForMandal').hide();
            }

            else {
                $('#divForMandal').show();
            }
            $.ajax({
                type: "POST",
                url: "CriteriaFormScheme.aspx/GetMandal",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var ddlType = $("#ddlDivisionName");
                    ddlType.empty();
                    ddlType.append($("<option selected disabled hidden></option>").val('').html('चयन करें'));
                    $.each(r.d, function () {
                        if (parseInt('<%=DivisionKey%>') > 0 && parseInt('<%=FR%>') == 2) {
                            if (parseInt('<%=DivisionKey%>') == parseInt(this['Value'])) {
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
                url: "CriteriaFormScheme.aspx/GetMonthName",
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

            $.ajax({
                type: "POST",
                url: "CriteriaFormScheme.aspx/GetSchemesType",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var ddlType = $("#ddlSchemeNameType");
                    ddlType.empty();
                    ddlType.append($("<option selected disabled hidden></option>").val('').html('चयन करें'));
                    $.each(r.d, function () {
                        if (parseInt('<%=SchemeTypeKey%>') > 0) {
                            if (parseInt('<%=SchemeTypeKey%>') == parseInt(this['Value'])) {
                                ddlType.empty();
                                ddlType.append($("<option></option>").val(this['Value']).html(this['Text']));
                                ddlType.attr('disabled', 'disabled');
                                getSchemeName();
                            }
                        }
                        else {
                            ddlType.append($("<option></option>").val(this['Value']).html(this['Text']));
                        }
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
            var SchemeKey = ($('#ddlSchemeName').val() == "" ? 0 : parseInt($('#ddlSchemeName').val()));

            var DivKey = ($('#ddlDivisionName').val() == "" ? 0 : parseInt($('#ddlDivisionName').val()));
            var DisKey = ($('#ddlDistrictName').val() == "" ? 0 : parseInt($('#ddlDistrictName').val()));

            DisKey = (isNaN(DisKey) ? 0 : DisKey);
            DivKey = (isNaN(DivKey) ? 0 : DivKey);
            SchemeKey = (isNaN(SchemeKey) ? 0 : SchemeKey);

            if (MonthId > 0) {
                $.ajax({
                    type: "POST",
                    url: "CriteriaFormScheme.aspx/ShowReport",
                    data: '{MonthID:' + MonthId + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        if (r.d == "1") {
                            if (parseInt("<%=RptKey%>") == 10) {
                                window.open("WebReportViewer.aspx?RptKey=<%=RptKey%>&FR=<%=FR%>&ST=<%=SchemeTypeKey%>&MonthKey=" + MonthId + "&DSKEY=" + (parseInt("<%=FR%>") == 1 ? parseInt("<%=DistrictKey%>") : DisKey) + "&DVKEY=" + (parseInt("<%=FR%>") == 1 ? 0 : (parseInt("<%=FR%>") == 2 ? parseInt("<%=DivisionKey%>") : DivKey)) + "&SchemeKey=" + SchemeKey + "", '_blank');
                            }
                            else if (parseInt("<%=RptKey%>") == 11) {
                                window.open("WebReportViewer.aspx?RptKey=<%=RptKey%>&FR=<%=FR%>&MonthKey=" + MonthId + "&DSKEY=" + (parseInt("<%=FR%>") == 1 ? parseInt("<%=DistrictKey%>") : DisKey) + "&DVKEY=" + (parseInt("<%=FR%>") == 1 ? 0 : (parseInt("<%=FR%>") == 2 ? parseInt("<%=DivisionKey%>") : DivKey)) + "", '_blank');
                            }
                            else if (parseInt("<%=RptKey%>") == 12) {
                                window.open("WebReportViewer.aspx?RptKey=<%=RptKey%>&FR=<%=FR%>&MonthKey=" + MonthId + "&DSKEY=" + (parseInt("<%=FR%>") == 1 ? parseInt("<%=DistrictKey%>") : DisKey) + "&DVKEY=" + (parseInt("<%=FR%>") == 1 ? 0 : (parseInt("<%=FR%>") == 2 ? parseInt("<%=DivisionKey%>") : DivKey)) + "", '_blank');
                            }
                            else if (parseInt("<%=RptKey%>") == 13) {
                                window.open("WebReportViewer.aspx?RptKey=<%=RptKey%>&FR=<%=FR%>&MonthKey=" + MonthId + "&DSKEY=" + (parseInt("<%=FR%>") == 1 ? parseInt("<%=DistrictKey%>") : DisKey) + "&DVKEY=" + (parseInt("<%=FR%>") == 1 ? 0 : (parseInt("<%=FR%>") == 2 ? parseInt("<%=DivisionKey%>") : DivKey)) + "", '_blank');
                                 }
                            else {
                                window.open("WebReportViewer.aspx?RptKey=1&FR=<%=FR%>&MonthKey=" + MonthId + "&DSKEY=" + (parseInt("<%=FR%>") == 1 ? parseInt("<%=DistrictKey%>") : DisKey) + "&DVKEY=" + (parseInt("<%=FR%>") == 1 ? 0 : (parseInt("<%=FR%>") == 2 ? parseInt("<%=DivisionKey%>") : DivKey)) + "&SchemeKey=" + SchemeKey + "", '_blank');
                            }
                            
                        }
                        else {
                            alert('Wrong Option Selection.');
                        }
                    }
                });
            }
        }

        function getSchemeName() {
            var schemetypeId = $("#ddlSchemeNameType").val();
            $("#ddlSchemeName").empty();
            if (schemetypeId > 0) {
                $.ajax({
                    type: "POST",
                    url: "CriteriaFormScheme.aspx/GetSchemes",
                    data: '{key : ' + schemetypeId + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        var ddl = $("#ddlSchemeName");
                        ddl.append($("<option selected disabled hidden></option>").val('').html('चयन करें'));
                        $.each(r.d, function () {
                            ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                        });
                        ddl.selectpicker('refresh');
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
                    url: "CriteriaFormScheme.aspx/GetDistrict",
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
                                <div class="row mar-top" id="divForMandal">
                                    <div class="col-lg-5">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="col-lg-4 control-label">मण्डल का नाम</label>
                                                <div class="col-lg-8">
                                                    <select class="form-control selectpicker" data-live-search="true" id="ddlDivisionName" onchange="getDistrictName();">
                                                    </select>
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>
                                    <div class="col-lg-5">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="col-lg-4 control-label">जनपद का नाम</label>
                                                <div class="col-lg-8">
                                                    <select class="form-control selectpicker" data-live-search="true" id="ddlDistrictName">
                                                    </select>
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>
                                </div>
                                <div class="row mar-top" id="pnlScheme">
                                    <div class="col-lg-5">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="col-lg-4 control-label">योजना का प्रकार </label>
                                                <div class="col-lg-8">
                                                    <select class="form-control selectpicker" data-live-search="true" id="ddlSchemeNameType" onchange="getSchemeName();">
                                                    </select>
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>
                                    <div class="col-lg-5">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="col-lg-4 control-label">योजना का चयन</label>
                                                <div class="col-lg-8">
                                                    <select class="form-control selectpicker" data-live-search="true" id="ddlSchemeName">
                                                    </select>
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>
                                </div>
                                <div class="row mar-top">
                                    <div class="col-lg-5">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="col-lg-4 control-label">माह का नाम </label>
                                                <div class="col-lg-8">
                                                    <select class="form-control selectpicker" id="ddlMonthName">
                                                    </select>
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>
                                    <div class="col-lg-6">
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