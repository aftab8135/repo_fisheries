<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DistrictMaster.master" AutoEventWireup="true" CodeFile="frm_RKVY.aspx.cs" Inherits="MPR_frm_RKVY" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .panel-heading {
            background-color: #f9f9f9 !important;
        }

        .panel-title {
            line-height: 44px !important;
        }
    </style>
    <!--Bootstrap Validator [ OPTIONAL ]-->
    <link href="<%=ResolveUrl("~/plugins/bootstrap-validator/bootstrapValidator.min.css") %>" rel="stylesheet" />
    <script src="<%=ResolveUrl("~/js/jquery-2.1.1.min.js") %>"></script>
    <%-- For Load Data --%>
    <script type="text/javascript">
        $(document).ready(function () {
            //Load Scheme Type on Page Load
            var schemetypeId = $("#ContentPlaceHolder1_hidSchemeKey").val();
            $("#ddlSchemeNameType").empty();
            if (schemetypeId > 0) {
                $.ajax({
                    type: "POST",
                    url: "frm_RKVY.aspx/GetSchemeType",
                    data: '{key : ' + schemetypeId + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        var ddl = $("#ddlSchemeNameType");
                        ddl.append($("<option selected></option>").val('').html('चयन करें'));
                        $.each(r.d, function () {
                            ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                        });
                        ddl.selectpicker('refresh');
                    }
                });
            }

            $.ajax({
                type: "POST",
                url: "frm_RKVY.aspx/GetMonthName",
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

    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnSubmit").click(function () {
                var MonthId = $('#ddlMonthName').val();
                var SchemeSubTypeKey = $('#ddlSchemeNameType').val();
                if (MonthId > 0 && SchemeSubTypeKey > 0) {
                    var totalExpandPercent = parseFloat($('#txtTotalExpandAmount').val()) / parseFloat($('#txtTotalAllocatedAmount').val()) * 100;
                    var objRKVY = {};
                    objRKVY.MonthKey = parseInt(MonthId);
                    objRKVY.SchemeSubTypeKey = parseInt(SchemeSubTypeKey);
                    objRKVY.TotalApplicant = parseInt($('#txtTotalApplicant').val());
                    objRKVY.TotalArea = parseFloat($('#txtTotalArea').val())
                    objRKVY.TotalWorkStart = parseInt($('#txtWorkStart').val());
                    objRKVY.TotalWorkUnStart = parseInt($('#txtWorkNotStart').val());
                    objRKVY.TotalCompletedWork = parseInt($('#txtWorkCompleted').val());
                    objRKVY.TotalAllocatedAmount = parseFloat($('#txtTotalAllocatedAmount').val());
                    objRKVY.TotalExpandAmount = parseFloat($('#txtTotalExpandAmount').val());
                    objRKVY.TotalExpandPercent = totalExpandPercent;

                    $.ajax({
                        type: "POST",
                        url: "frm_RKVY.aspx/Create",
                        data: '{objRKVY_Scheme:' + JSON.stringify(objRKVY) + '}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            var r = $.parseJSON(data.d);
                            if (r.StatusCode == "200") {
                                alert(r.Msg);
                                //  window.location.href = "frm_BlueRevolution.aspx";
                            }
                            else {
                                alert(r.Msg);
                            }
                        },
                        error: function (e) {
                            alert('Something went wrong');
                        }
                    });
                }
                else {
                    alert('Please Select Month First.');
                    event.preventDefault();
                }
            });
        });

    </script>
    <script type="text/javascript">
        function LoadRecords() {
            var MonthId = $('#ddlMonthName').val();
            var SchemeSubTypeKey = $('#ddlSchemeNameType').val();
            if (MonthId > 0 && SchemeSubTypeKey > 0) {
                $.ajax({
                    type: "POST",
                    url: "frm_RKVY.aspx/Load_RKVY",
                    data: '{schemesubtypekey : ' + parseInt(SchemeSubTypeKey) + ',monthkey:' + parseInt(MonthId) + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        var BR = r.d;
                        if (BR.RKVYKey > 0) {
                            $('#ContentPlaceHolder1_hidBlueRevolutionKey').val(BR.RKVYKey);
                            $('#txtTotalApplicant').val(BR.TotalApplicant)
                            $('#txtTotalArea').val(BR.TotalArea)
                            $('#txtWorkStart').val(BR.TotalWorkStart)
                            $('#txtWorkNotStart').val(BR.TotalWorkUnStart)
                            $('#txtWorkCompleted').val(BR.TotalCompletedWork)
                            $('#txtTotalAllocatedAmount').val(BR.TotalAllocatedAmount)
                            $('#txtTotalExpandAmount').val(BR.TotalExpandAmount)
                        }
                        else {
                            $('#ContentPlaceHolder1_hidBlueRevolutionKey').val('');
                            $('#txtTotalApplicant').val(0)
                            $('#txtTotalArea').val(0.00)
                            $('#txtWorkStart').val(0)
                            $('#txtWorkNotStart').val(0)
                            $('#txtWorkCompleted').val(0)
                            $('#txtTotalAllocatedAmount').val(0.00)
                            $('#txtTotalExpandAmount').val(0.00)
                            $('#txtTotalApplicant').focus();
                        }
                    }
                });
            }
        }

        function calcUnStarted() {
            var totalApplicant = ($('#txtTotalApplicant').val() == "" ? 0 : $('#txtTotalApplicant').val());
            var totalWorkStart = ($('#txtWorkStart').val() == "" ? 0 : $('#txtWorkStart').val());
            var totalWorkComp = ($('#txtWorkCompleted').val() == "" ? 0 : $('#txtWorkCompleted').val());

            $('#txtWorkNotStart').val(totalApplicant - totalWorkStart - totalWorkComp);

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="content-container">
        <asp:HiddenField ID="hidDistrictKey" runat="server" />
        <asp:HiddenField ID="hidSchemeKey" runat="server" />
        <asp:HiddenField ID="hidBlueRevolutionKey" runat="server" />
        <!--Page Title-->
        <!--------------------------------------------------------->
        <div class="pageheader hidden-xs">
            <h3><i class="fa fa-home"></i>राष्ट्रीय कृषि विकास योजना </h3>
            <div class="breadcrumb-wrapper">
                <%-- <span class="label">You are here:</span>--%>
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">होम </a></li>
                    <li class="active">राष्ट्रीय कृषि विकास योजना </li>
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
                                <h3 class="panel-title"><strong>राष्ट्रीय कृषि विकास योजना </strong></h3>
                            </div>
                            <!--No Label Form-->
                            <div class="panel-body" style="margin-top: -15px">
                                <h3 style="float: left">जनपद :
                                    <asp:Label ID="lblLoginType" runat="server" Text=""></asp:Label></h3>
                                <h3 style="float: right">वित्तीय वर्ष  :
                                     <asp:Label ID="lblFinYear" runat="server" Text=""></asp:Label>
                                </h3>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel">
                            <!--No Label Form-->
                            <div class="panel-body" style="margin-top: -15px">
                                <div class="row mar-top">
                                    <div class="col-lg-8">
                                        <div class="form-group">
                                            <label class="control-label col-lg-3" for="ddlSchemeNameType">योजना का नाम</label>
                                            <div class="col-lg-6">
                                                <select class="form-control selectpicker" data-live-search="true" id="ddlSchemeNameType" onchange="LoadRecords()"></select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4">
                                        <div class="form-group">
                                            <label class="control-label col-lg-3" for="ddlMonthName">माह का नाम</label>
                                            <div class="col-lg-6">
                                                <select class="form-control selectpicker" data-live-search="true" id="ddlMonthName" onchange="LoadRecords()"></select>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel">
                            <!--No Label Form-->
                            <div class="panel-body" style="margin-top: -15px">

                                <div class="row mar-top">
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="txtTotalApplicant">कुल स्वीकृत लाभार्थी (स०) </label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="txtTotalApplicant" value="0" class="form-control right" style="text-align: right" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="txtTotalArea">कुल क्षेत्रफल (हे०) </label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="txtTotalArea" value="0.00" class="form-control right" style="text-align: right" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="txtWorkStart">निर्माण प्रारम्भ (स०) </label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="txtWorkStart" value="0" class="form-control right" style="text-align: right" onchange="calcUnStarted();"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="txtWorkCompleted">कार्यपूर्ण (स०) </label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="txtWorkCompleted" value="0" class="form-control right" style="text-align: right" onchange="calcUnStarted();" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                 <div class="row">
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="txtWorkNotStart">निर्माण कार्य अनारम्भ(स०) </label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="txtWorkNotStart" value="0" class="form-control right" style="text-align: right" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="txtTotalAllocatedAmount">कुल आवंटित धनराशि (रू लाख में) </label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="txtTotalAllocatedAmount" value="0.00" class="form-control right" style="text-align: right" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="txtTotalExpandAmount">कुल व्यय धनराशि (रू लाख में)  </label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="txtTotalExpandAmount" value="0.00" class="form-control right" style="text-align: right" />
                                            </div>
                                        </div>
                                    </div>
                                </div>


                            </div>
                            <div class="panel-footer">
                                <div class="col-lg-offset-2">
                                    <button id="btnSubmit" type="submit" class="btn btn-info">सुरक्षित करें</button>
                                    &nbsp;&nbsp;&nbsp;
                                    <button id="btnCancel" type="reset" class="btn btn-warning">निरस्त करें</button>
                                </div>
                            </div>

                        </div>

                    </div>
                </div>

            </div>

        </div>

    </div>
</asp:Content>

