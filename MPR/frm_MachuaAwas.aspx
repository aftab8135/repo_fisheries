<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DistrictMaster.master" AutoEventWireup="true" CodeFile="frm_MachuaAwas.aspx.cs" Inherits="MPR_frmFishProduction" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
            $.ajax({
                type: "POST",
                url: "frm_MachuaAwas.aspx/GetMonthName",
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

            //var objMachuaAwasYearlyTarget = {};
            //$.ajax({
            //    type: "POST",
            //    url: "frm_MachuaAwas.aspx/GetYearTarget",
            //    data: '{}',
            //    contentType: "application/json; charset=utf-8",
            //    dataType: "json",
            //    success: function (r) {
            //        objMachuaAwasYearlyTarget = r.d;
            //        $('#txtAwasTarget').val(objMachuaAwasYearlyTarget.MA_YearlyTarget);
            //        $('#hidYearlyTargetKey').val(objMachuaAwasYearlyTarget.YearlyTargetKey);

            //    }
            //});
        });

    </script>

    <%-- <script type="text/javascript">
        function calcTotal() {
            var FrPond = ($('#nmForPond').val() == "" ? 0 : parseFloat($('#nmForPond').val()));
            FrPond = (isNaN(FrPond) ? 0 : FrPond);
            var FrWA = ($('#nmWaterArea').val() == "" ? 0 : parseFloat($('#nmWaterArea').val()));
            FrWA = (isNaN(FrWA) ? 0 : FrWA);
            var FRLake = ($('#nmlake').val() == "" ? 0 : parseFloat($('#nmlake').val()));
            FRLake = (isNaN(FRLake) ? 0 : FRLake);
            var FrRiver = ($('#nmRiver').val() == "" ? 0 : parseFloat($('#nmRiver').val()));
            FrRiver = (isNaN(FrRiver) ? 0 : FrRiver);

            var total = parseFloat(FrPond) + parseFloat(FrWA) + parseFloat(FRLake) + parseFloat(FrRiver);
            $('#nmTotal').val(total.toFixed(2));
        }

    </script>--%>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnSubmit").click(function () {
                var MonthId = $('#ddlMonthName').val();
                var YearTargetKey = $('#hidYearlyTargetKey').val();
                if (MonthId > 0) {

                    var allocatedAmount = ($('#txtAllocatedAmount').val() == "" ? 0 : parseFloat($('#txtAllocatedAmount').val()));
                    allocatedAmount = (isNaN(allocatedAmount) ? 0 : allocatedAmount);

                    var firstInstallment = ($('#txtFirstInstallment').val() == "" ? 0 : parseFloat($('#txtFirstInstallment').val()));
                    firstInstallment = (isNaN(firstInstallment) ? 0 : firstInstallment);

                    var secondInstallment = ($('#txtSecondInstallment').val() == "" ? 0 : parseFloat($('#txtSecondInstallment').val()));
                    secondInstallment = (isNaN(secondInstallment) ? 0 : secondInstallment);

                    var expenditureAmount = ($('#txtExpenditureAmount').val() == "" ? 0 : parseFloat($('#txtExpenditureAmount').val()));
                    expenditureAmount = (isNaN(expenditureAmount) ? 0 : expenditureAmount);

                    var balanceAmount = parseFloat(allocatedAmount) - parseFloat(expenditureAmount);

                    var objMachuaAwas = {};

                    objMachuaAwas.MonthKey = parseInt(MonthId);

                    objMachuaAwas.YearlyTargetKey = parseInt(YearTargetKey);
                    objMachuaAwas.YearlyTarget = parseInt($('#txtAwasTarget').val());

                    objMachuaAwas.AwasCompleted = parseInt($('#txtCompletedAwas').val());
                    objMachuaAwas.AwasUnConstruction = parseInt($('#txtConstructedAwas').val());
                    objMachuaAwas.AwasUntimely = parseInt($('#txtNotStartedAwas').val());

                    objMachuaAwas.AllocatedAmount = allocatedAmount;
                    objMachuaAwas.FirstInstallment = firstInstallment;
                    objMachuaAwas.SecondInstallment = secondInstallment;
                    objMachuaAwas.ExpenditureAmount = expenditureAmount;

                    objMachuaAwas.BalanceAmount = balanceAmount;
                    objMachuaAwas.Remarks = $('#txtRemark').val();

                    $.ajax({
                        type: "POST",
                        url: "frm_MachuaAwas.aspx/Create",
                        data: '{objRecord:' + JSON.stringify(objMachuaAwas) + '}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            var r = $.parseJSON(data.d);
                            if (r.StatusCode == "200") {
                                alert(r.Msg);
                                window.location.href = "frm_MachuaAwas.aspx";
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

        function calcAmount() {
            var secAmount = 0;
            var fIns = 0;
            var sIns = 0;

            var availAmount = 0;
            var remAmount = 0;
            
            secAmount = ($('#txtAllocatedAmount').val() != "" ? parseFloat($('#txtAllocatedAmount').val()) : 0);
            fIns = ($('#txtFirstInstallment').val() != "" ? parseFloat($('#txtFirstInstallment').val()) : 0);
            sIns = ($('#txtSecondInstallment').val() != "" ? parseFloat($('#txtSecondInstallment').val()) : 0);

            availAmount = fIns + sIns;
            $('#txtExpenditureAmount').val((availAmount).toFixed(2));

            remAmount = secAmount - availAmount;
            $('#txtRemainAmout').val((remAmount).toFixed(2));
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="content-container">
        <%--  <asp:HiddenField ID="hidYearTargetKey" Value="" runat="server" />--%>
        <input type="hidden" id="hidYearlyTargetKey" value="" />
        <!--Page Title-->
        <!--------------------------------------------------------->
        <div class="pageheader hidden-xs">
            <h3><i class="fa fa-home"></i>Machua Awas Scheme</h3>
            <div class="breadcrumb-wrapper">
                <%--  <span class="label">You are here:</span>--%>
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">होम </a></li>
                    <li class="active">मछुआ आवास योजना</li>
                </ol>
            </div>
        </div>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <!--End page title-->
        <!--Page content-->
        <!--===================================================-->
        <div id="page-content">
            <div class="form-horizontal">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel">
                            <div class="panel-heading">
                                <h3 class="panel-title"><strong>मछुआ आवास योजना की वर्षवार भौतिक एवं वित्तीय सूचना</strong></h3>
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

                            <div class="panel-body" style="margin-top: -15px">
                                <div class="row mar-top">
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="ddlMonthName">माह का नाम</label>
                                            <div class="col-lg-6">
                                                <select class="form-control selectpicker" data-live-search="true" id="ddlMonthName"></select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6" hidden>
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="txtDate">दिनांक</label>
                                            <div class="col-lg-6">
                                                <input type="text" id="txtDate" value="31/03/2019" class="form-control" readonly="readonly" />
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
                            <div class="panel-heading">
                                <h3 class="panel-title">भौतिक प्रगति (संख्या में) </h3>
                            </div>
                            <div class="panel-body" style="margin-top: -15px">
                                <div class="row mar-top">
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="txtAwasTarget">आवास लक्ष्य</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="txtAwasTarget" value="0.00" class="form-control right" style="text-align: right" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="txtCompletedAwas">आवास पूर्ण</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="txtCompletedAwas" value="0.00" class="form-control right" style="text-align: right" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="nmYearlyTarget">आवास निर्माणाधीन</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="txtConstructedAwas" value="0.00" class="form-control right" style="text-align: right" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="nmYearlyTarget">आवास अनारम्भ</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="txtNotStartedAwas" value="0.00" class="form-control right" style="text-align: right" />
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
                            <div class="panel-heading">
                                <h3 class="panel-title">वित्तीय प्रगति (रु लाख में) </h3>
                            </div>
                            <!--No Label Form-->
                            <div class="panel-body" style="margin-top: -15px">
                                <div class="row mar-top">
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="txtAllocatedAmount">शासन से आवंटित धनराशी</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="txtAllocatedAmount" value="0.00" class="form-control right" style="text-align: right" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="nmRiver">प्रथम किश्त</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="txtFirstInstallment" value="0.00" class="form-control right" style="text-align: right" onchange="calcAmount();"/>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="nmTotal">द्वितीय किश्त</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="txtSecondInstallment" value="0.00" class="form-control right" style="text-align: right" onchange="calcAmount();"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="nmWaterArea">व्यय की गई धनराशी</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="txtExpenditureAmount" value="0.00" class="form-control right" style="text-align: right" readonly/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="txtRemainAmout">अवशेष धनराशी </label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="txtRemainAmout" value="0.00" class="form-control right" readonly="readonly" style="text-align: right" onchange="calcTotal();" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="form-group">
                                            <label class="control-label col-lg-2" for="nmTotal">विशेष विवरण</label>
                                            <div class="col-lg-9">
                                                <textarea rows="2" id="txtRemark" class="form-control"></textarea>
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
        <!--===================================================-->
        <!--End page content-->
    </div>

    <!--Jasmine Admin [ RECOMMENDED ]-->
    <script src="<%=ResolveUrl("~/js/scripts.js") %>"></script>
    <script src="<%=ResolveUrl("~/plugins/bootstrap-validator/bootstrapValidator.min.js") %>"></script>
</asp:Content>
