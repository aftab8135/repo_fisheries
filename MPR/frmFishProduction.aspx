<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DistrictMaster.master" AutoEventWireup="true" CodeFile="frmFishProduction.aspx.cs" Inherits="MPR_frmFishProduction" %>

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
                url: "frmFishProduction.aspx/GetMonthName",
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

    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnSubmit").click(function () {
                var MonthId = $('#ddlMonthName').val();
                if (MonthId > 0) {

                    var FrYear = ($('#nmYearlyTarget').val() == "" ? 0 : parseFloat($('#nmYearlyTarget').val()));
                    FrYear = (isNaN(FrYear) ? 0 : FrYear);

                    var FrPond = ($('#nmForPond').val() == "" ? 0 : parseFloat($('#nmForPond').val()));
                    FrPond = (isNaN(FrPond) ? 0 : FrPond);
                    var FrWA = ($('#nmWaterArea').val() == "" ? 0 : parseFloat($('#nmWaterArea').val()));
                    FrWA = (isNaN(FrWA) ? 0 : FrWA);
                    var FRLake = ($('#nmlake').val() == "" ? 0 : parseFloat($('#nmlake').val()));
                    FRLake = (isNaN(FRLake) ? 0 : FRLake);
                    var FrRiver = ($('#nmRiver').val() == "" ? 0 : parseFloat($('#nmRiver').val()));
                    FrRiver = (isNaN(FrRiver) ? 0 : FrRiver);

                    var total = parseFloat(FrPond) + parseFloat(FrWA) + parseFloat(FRLake) + parseFloat(FrRiver);

                    var objFishProd = {};

                    objFishProd.MonthKey = parseInt(MonthId);
                    objFishProd.YearlyTarget = FrYear;
                    objFishProd.Pond = FrPond;
                    objFishProd.WaterArea = FrWA;
                    objFishProd.Lake = FRLake;
                    objFishProd.River = FrRiver;
                    objFishProd.Total = total;
                    objFishProd.Remark = $('#txtRemark').val();

                    $.ajax({
                        type: "POST",
                        url: "frmFishProduction.aspx/Create",
                        data: '{objFishProductionTant:' + JSON.stringify(objFishProd) + '}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            var r = $.parseJSON(data.d);
                            if (r.StatusCode == "200") {
                                alert(r.Msg);
                                window.location.href = "frmFishProduction.aspx";
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="content-container">
        <!--Page Title-->
        <!--------------------------------------------------------->
        <div class="pageheader hidden-xs">
            <h3><i class="fa fa-home"></i>मत्स्य उत्पादन विवरण</h3>
            <div class="breadcrumb-wrapper">
                <%--  <span class="label">You are here:</span>--%>
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">होम </a></li>
                    <li class="active">मत्स्य उत्पादन विवरण</li>
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
                                <h3 class="panel-title"><strong>समस्त श्रोतों से अनुमानित मत्स्य उत्पादन (मी0टन)</strong></h3>
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
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="nmYearlyTarget">वार्षिक लक्ष्य</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="nmYearlyTarget" value="0.00" class="form-control right" style="text-align: right" />
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
                                            <label class="control-label col-lg-4" for="nmForPond">तालाबों से</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="nmForPond" value="0.00" class="form-control right" style="text-align: right" onchange="calcTotal();" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="nmWaterArea">जलासयों से</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="nmWaterArea" value="0.00" class="form-control right" style="text-align: right" onchange="calcTotal();" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="nmlake">झीलों से</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="nmlake" value="0.00" class="form-control right" style="text-align: right" onchange="calcTotal();" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="nmRiver">नदियों से</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="nmRiver" value="0.00" class="form-control right" style="text-align: right" onchange="calcTotal();" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="nmTotal">योग</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="nmTotal" value="0.00" class="form-control right" style="text-align: right" readonly />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="nmTotal">अभ्युक्ति</label>
                                            <div class="col-lg-6">
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
