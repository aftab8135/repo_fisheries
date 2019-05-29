<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DistrictMaster.master" AutoEventWireup="true" CodeFile="frmDeptGradePondNistarn.aspx.cs" Inherits="MPR_frmDeptGradePondNistarn" %>

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
                url: "frmDeptGradePondNistarn.aspx/GetMonthName",
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
        function calcTotalGR() {
            var GROne = ($('#nmGRGradeOne').val() == "" ? 0 : parseFloat($('#nmGRGradeOne').val()));
            GROne = (isNaN(GROne) ? 0 : GROne);
            var GRTwo = ($('#nmGRGradeTwo').val() == "" ? 0 : parseFloat($('#nmGRGradeTwo').val()));
            GRTwo = (isNaN(GRTwo) ? 0 : GRTwo);
            var GRThree = ($('#nmGRGradeThree').val() == "" ? 0 : parseFloat($('#nmGRGradeThree').val()));
            GRThree = (isNaN(GRThree) ? 0 : GRThree);
            var GRFour = ($('#nmGRGradeFour').val() == "" ? 0 : parseFloat($('#nmGRGradeFour').val()));
            GRFour = (isNaN(GRFour) ? 0 : GRFour);

            var total = parseFloat(GROne) + parseFloat(GRTwo) + parseFloat(GRThree) + parseFloat(GRFour);

            $('#nmGRGradeTotal').val(total.toFixed(2));
        }

        function calcTotalNS() {
            var GROne = ($('#nmNSGradeOne').val() == "" ? 0 : parseFloat($('#nmNSGradeOne').val()));
            GROne = (isNaN(GROne) ? 0 : GROne);
            var GRTwo = ($('#nmNSGradeTwo').val() == "" ? 0 : parseFloat($('#nmNSGradeTwo').val()));
            GRTwo = (isNaN(GRTwo) ? 0 : GRTwo);
            var GRThree = ($('#nmNSGradeThree').val() == "" ? 0 : parseFloat($('#nmNSGradeThree').val()));
            GRThree = (isNaN(GRThree) ? 0 : GRThree);
            var GRFour = ($('#nmNSGradeFour').val() == "" ? 0 : parseFloat($('#nmNSGradeFour').val()));
            GRFour = (isNaN(GRFour) ? 0 : GRFour);

            var total = parseFloat(GROne) + parseFloat(GRTwo) + parseFloat(GRThree) + parseFloat(GRFour);

            $('#nmNSGradeTotal').val(total.toFixed(2));
        }

        function calcTotalANS() {
            var GROne = ($('#nmANSGradeOne').val() == "" ? 0 : parseFloat($('#nmANSGradeOne').val()));
            GROne = (isNaN(GROne) ? 0 : GROne);
            var GRTwo = ($('#nmANSGradeTwo').val() == "" ? 0 : parseFloat($('#nmANSGradeTwo').val()));
            GRTwo = (isNaN(GRTwo) ? 0 : GRTwo);
            var GRThree = ($('#nmANSGradeThree').val() == "" ? 0 : parseFloat($('#nmANSGradeThree').val()));
            GRThree = (isNaN(GRThree) ? 0 : GRThree);
            var GRFour = ($('#nmANSGradeFour').val() == "" ? 0 : parseFloat($('#nmANSGradeFour').val()));
            GRFour = (isNaN(GRFour) ? 0 : GRFour);

            var total = parseFloat(GROne) + parseFloat(GRTwo) + parseFloat(GRThree) + parseFloat(GRFour);

            $('#nmANSGradeTotal').val(total.toFixed(2));
        }

    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnSubmit").click(function () {
                event.preventDefault();
                var MonthId = $('#ddlMonthName').val();
                if (MonthId > 0) {

                    var GROne = ($('#nmGRGradeOne').val() == "" ? 0 : parseFloat($('#nmGRGradeOne').val()));
                    GROne = (isNaN(GROne) ? 0 : GROne);
                    var GRTwo = ($('#nmGRGradeTwo').val() == "" ? 0 : parseFloat($('#nmGRGradeTwo').val()));
                    GRTwo = (isNaN(GRTwo) ? 0 : GRTwo);
                    var GRThree = ($('#nmGRGradeThree').val() == "" ? 0 : parseFloat($('#nmGRGradeThree').val()));
                    GRThree = (isNaN(GRThree) ? 0 : GRThree);
                    var GRFour = ($('#nmGRGradeFour').val() == "" ? 0 : parseFloat($('#nmGRGradeFour').val()));
                    GRFour = (isNaN(GRFour) ? 0 : GRFour);

                    var GRtotal = parseFloat(GROne) + parseFloat(GRTwo) + parseFloat(GRThree) + parseFloat(GRFour);

                    var NSOne = ($('#nmNSGradeOne').val() == "" ? 0 : parseFloat($('#nmNSGradeOne').val()));
                    NSOne = (isNaN(NSOne) ? 0 : NSOne);
                    var NSTwo = ($('#nmNSGradeTwo').val() == "" ? 0 : parseFloat($('#nmNSGradeTwo').val()));
                    NSTwo = (isNaN(NSTwo) ? 0 : NSTwo);
                    var NSThree = ($('#nmNSGradeThree').val() == "" ? 0 : parseFloat($('#nmNSGradeThree').val()));
                    NSThree = (isNaN(NSThree) ? 0 : NSThree);
                    var NSFour = ($('#nmNSGradeFour').val() == "" ? 0 : parseFloat($('#nmNSGradeFour').val()));
                    NSFour = (isNaN(NSFour) ? 0 : NSFour);

                    var NStotal = parseFloat(NSOne) + parseFloat(NSTwo) + parseFloat(NSThree) + parseFloat(NSFour);

                    var ANSOne = ($('#nmANSGradeOne').val() == "" ? 0 : parseFloat($('#nmANSGradeOne').val()));
                    ANSOne = (isNaN(ANSOne) ? 0 : ANSOne);
                    var ANSTwo = ($('#nmANSGradeTwo').val() == "" ? 0 : parseFloat($('#nmANSGradeTwo').val()));
                    ANSTwo = (isNaN(ANSTwo) ? 0 : ANSTwo);
                    var ANSThree = ($('#nmANSGradeThree').val() == "" ? 0 : parseFloat($('#nmANSGradeThree').val()));
                    ANSThree = (isNaN(ANSThree) ? 0 : ANSThree);
                    var ANSFour = ($('#nmANSGradeFour').val() == "" ? 0 : parseFloat($('#nmANSGradeFour').val()));
                    ANSFour = (isNaN(ANSFour) ? 0 : ANSFour);

                    var ANStotal = parseFloat(ANSOne) + parseFloat(ANSTwo) + parseFloat(ANSThree) + parseFloat(ANSFour);

                    var objPondGrdNistarnProgMaster = {};

                    objPondGrdNistarnProgMaster.MonthKey = parseInt(MonthId);

                    objPondGrdNistarnProgMaster.GRGradeOne = parseFloat(GROne);
                    objPondGrdNistarnProgMaster.GRGradeTwo = parseFloat(GRTwo);
                    objPondGrdNistarnProgMaster.GRGradeThree = parseFloat(GRThree);
                    objPondGrdNistarnProgMaster.GRGradeFour = parseFloat(GRFour);
                    objPondGrdNistarnProgMaster.GRGradeOneFourTotal = parseFloat(GRtotal);
                    objPondGrdNistarnProgMaster.GRGradeFive = parseFloat(($('#nmGRGradeFive').val() == "" ? 0 : parseFloat($('#nmGRGradeFive').val())));
                    objPondGrdNistarnProgMaster.GRAistanNos = parseFloat(($('#nmGRFishNos').val() == "" ? 0 : parseFloat($('#nmGRFishNos').val())));
                    objPondGrdNistarnProgMaster.GRPondNos = parseFloat(($('#nmGRPondNos').val() == "" ? 0 : parseFloat($('#nmGRPondNos').val())));

                    objPondGrdNistarnProgMaster.NSGradeOne = parseFloat(NSOne);
                    objPondGrdNistarnProgMaster.NSGradeTwo = parseFloat(NSTwo);
                    objPondGrdNistarnProgMaster.NSGradeThree = parseFloat(NSThree);
                    objPondGrdNistarnProgMaster.NSGradeFour = parseFloat(NSFour);
                    objPondGrdNistarnProgMaster.NSGradeOneTFourTotal = parseFloat(NStotal);
                    objPondGrdNistarnProgMaster.NSGradeFive = parseFloat(($('#nmNSGradeFive').val() == "" ? 0 : parseFloat($('#nmNSGradeFive').val())));
                    objPondGrdNistarnProgMaster.NSAistanNos = parseFloat(($('#nmNSFishNos').val() == "" ? 0 : parseFloat($('#nmNSFishNos').val())));
                    objPondGrdNistarnProgMaster.NSPondNos = parseFloat(($('#nmNSPondNos').val() == "" ? 0 : parseFloat($('#nmNSPondNos').val())));

                    objPondGrdNistarnProgMaster.ANSGradeOne = parseFloat(ANSOne);
                    objPondGrdNistarnProgMaster.ANSGradeTwo = parseFloat(ANSTwo);
                    objPondGrdNistarnProgMaster.ANSGradeThree = parseFloat(ANSThree);
                    objPondGrdNistarnProgMaster.ANSGradeFour = parseFloat(ANSFour);
                    objPondGrdNistarnProgMaster.ANSGradeOneTFourTotal = parseFloat(ANStotal);
                    objPondGrdNistarnProgMaster.ANSGradeFive = parseFloat(($('#nmANSGradeFive').val() == "" ? 0 : parseFloat($('#nmANSGradeFive').val())));
                    objPondGrdNistarnProgMaster.ANSAistanNos = parseFloat(($('#nmANSFishNos').val() == "" ? 0 : parseFloat($('#nmANSFishNos').val())));
                    objPondGrdNistarnProgMaster.ANSPondNos = parseFloat(($('#nmANSPondNos').val() == "" ? 0 : parseFloat($('#nmANSPondNos').val())));

                    $.ajax({
                        type: "POST",
                        url: "frmDeptGradePondNistarn.aspx/Create",
                        data: '{objPondGrdNistarnProgMaster:' + JSON.stringify(objPondGrdNistarnProgMaster) + '}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            var r = $.parseJSON(data.d);
                            if (r.StatusCode == "200") {
                                alert(r.Msg);
                                window.location.href = "frmDeptGradePondNistarn.aspx";
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
            <h3><i class="fa fa-home"></i>जलाशयों के निस्तारण की प्रगति</h3>
            <div class="breadcrumb-wrapper">
                <%--  <span class="label">You are here:</span>--%>
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">होम </a></li>
                    <li class="active">जलाशयों के निस्तारण की प्रगति</li>
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
                                <h3 class="panel-title"><strong>जलाशयों के निस्तारण की प्रगति</strong></h3>
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
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel">
                            <div class="panel-heading">
                                <h3 class="panel-title"><strong>श्रेंणीवार जलाशयों की विवरण</strong></h3>
                            </div>
                            <div class="panel-body" style="margin-top: -15px">
                                <div class="row mar-top">
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="nmGRGradeOne">श्रेंणी - 1 (5000 हेक्ट0 से अधिक)</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="nmGRGradeOne" value="0.00" class="form-control right" style="text-align: right" onchange="calcTotalGR();" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="nmGRGradeTwo">श्रेंणी - 2 (1000 हेक्ट0 से 5000 हेक्ट0)</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="nmGRGradeTwo" value="0.00" class="form-control right" style="text-align: right" onchange="calcTotalGR();" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="nmGRGradeThree">श्रेंणी - 3 (200 हेक्ट0 से 1000 हेक्ट0)</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="nmGRGradeThree" value="0.00" class="form-control right" style="text-align: right" onchange="calcTotalGR();" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="nmGRGradeFour">श्रेंणी - 4 (40 हेक्ट0 से 200 हेक्ट0)</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="nmGRGradeFour" value="0.00" class="form-control right" style="text-align: right" onchange="calcTotalGR();" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="nmGRGradeTotal">योग</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="nmGRGradeTotal" value="0.00" class="form-control right" style="text-align: right" readonly />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="nmGRGradeFive">श्रेणीं - 5 (.1 हेक्ट0 से 40 हेक्ट0)</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="nmGRGradeFive" value="0.00" class="form-control right" style="text-align: right" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="nmGRFishNos">मत्स्य अस्थान संख्या</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="nmGRFishNos" value="0.00" class="form-control right" style="text-align: right" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="nmGRPondNos">तालाबों की संख्या</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="nmGRPondNos" value="0.00" class="form-control right" style="text-align: right" />
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
                                <h3 class="panel-title"><strong>कार्यशील निस्तारित श्रेंणीवार जलाशयों की विवरण</strong></h3>
                            </div>
                            <div class="panel-body" style="margin-top: -15px">
                                <div class="row mar-top">
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="nmNSGradeOne">श्रेंणी - 1 (5000 हेक्ट0 से अधिक)</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="nmNSGradeOne" value="0.00" class="form-control right" style="text-align: right" onchange="calcTotalNS();" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="nmNSGradeTwo">श्रेंणी - 2 (1000 हेक्ट0 से 5000 हेक्ट0)</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="nmNSGradeTwo" value="0.00" class="form-control right" style="text-align: right" onchange="calcTotalNS();" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="nmNSGradeThree">श्रेंणी - 3 (200 हेक्ट0 से 1000 हेक्ट0)</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="nmNSGradeThree" value="0.00" class="form-control right" style="text-align: right" onchange="calcTotalNS();" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="nmNSGradeFour">श्रेंणी - 4 (40 हेक्ट0 से 200 हेक्ट0)</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="nmNSGradeFour" value="0.00" class="form-control right" style="text-align: right" onchange="calcTotalNS();" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="nmNSGradeTotal">योग</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="nmNSGradeTotal" value="0.00" class="form-control right" style="text-align: right" readonly />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="nmNSGradeFive">श्रेणीं - 5 (.1 हेक्ट0 से 40 हेक्ट0)</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="nmNSGradeFive" value="0.00" class="form-control right" style="text-align: right"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="nmNSFishNos">मत्स्य अस्थान संख्या</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="nmNSFishNos" value="0.00" class="form-control right" style="text-align: right" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="nmNSPondNos">तालाबों की संख्या</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="nmNSPondNos" value="0.00" class="form-control right" style="text-align: right"/>
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
                                <h3 class="panel-title"><strong>कार्यशील अनिस्तारित श्रेंणीवार जलाशयों की विवरण</strong></h3>
                            </div>
                            <div class="panel-body" style="margin-top: -15px">
                                <div class="row mar-top">
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="nmANSGradeOne">श्रेंणी - 1 (5000 हेक्ट0 से अधिक)</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="nmANSGradeOne" value="0.00" class="form-control right" style="text-align: right" onchange="calcTotalANS();" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="nmANSGradeTwo">श्रेंणी - 2 (1000 हेक्ट0 से 5000 हेक्ट0)</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="nmANSGradeTwo" value="0.00" class="form-control right" style="text-align: right" onchange="calcTotalANS();" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="nmANSGradeThree">श्रेंणी - 3 (200 हेक्ट0 से 1000 हेक्ट0)</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="nmANSGradeThree" value="0.00" class="form-control right" style="text-align: right" onchange="calcTotalANS();" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="nmANSGradeFour">श्रेंणी - 4 (40 हेक्ट0 से 200 हेक्ट0)</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="nmANSGradeFour" value="0.00" class="form-control right" style="text-align: right" onchange="calcTotalANS();" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="nmANSGradeTotal">योग</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="nmANSGradeTotal" value="0.00" class="form-control right" style="text-align: right" readonly />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="nmANSGradeFive">श्रेणीं - 5 (.1 हेक्ट0 से 40 हेक्ट0)</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="nmANSGradeFive" value="0.00" class="form-control right" style="text-align: right" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="nmANSFishNos">मत्स्य अस्थान संख्या</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="nmANSFishNos" value="0.00" class="form-control right" style="text-align: right"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="nmANSPondNos">तालाबों की संख्या</label>
                                            <div class="col-lg-6">
                                                <input type="number" step="0.01" min="0.00" id="nmANSPondNos" value="0.00" class="form-control right" style="text-align: right"/>
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
            <!--===================================================-->
            <!--End page content-->
        </div>

        <!--Jasmine Admin [ RECOMMENDED ]-->
        <script src="<%=ResolveUrl("~/js/scripts.js") %>"></script>
        <script src="<%=ResolveUrl("~/plugins/bootstrap-validator/bootstrapValidator.min.js") %>"></script>
</asp:Content>
