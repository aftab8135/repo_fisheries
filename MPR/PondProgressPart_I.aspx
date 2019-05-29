<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DistrictMaster.master" AutoEventWireup="true" CodeFile="PondProgressPart_I.aspx.cs" Inherits="District_PondProgressPart_I" %>

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
    <script type="text/javascript">

        $(document).ready(function () {
            $('#pnlDetail').show();
            $.ajax({
                type: "POST",
                url: "PondProgressPart_I.aspx/GetMonthName",
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
        function showProgress() {
            var monthKey = $('#ddlMonthName').val();
            var yearTarget = $('#nm_yearlyTarget').val();
            if (monthKey > 0 && yearTarget > 0) {

                $('#pnlDetail').show();
                
                $('#nm_pond_nos').val(0.00);
                $('#nm_pond_hect').val(0.00);

                $('#nm_Past_nos').val(0.00);
                $('#nm_Past_hect').val(0.00);

                $('#nm_Curr_nos').val(0.00);
                $('#nm_Curr_hect').val(0.00);

                $('#nm_abort_nos').val(0.00);
                $('#nm_abort_hect').val(0.00);

                $('#nm_Present_nos').val(0.00);
                $('#nm_Present_hect').val(0.00);

            }
            else {
                alert('Please Enter Required Fields.');
            }
        }

        function onNosChange() {

            var pond_nos = 0;
            var pond_hect = 0;

            var Past_nos = 0;
            var Past_hect = 0;

            var Curr_nos = 0;
            var Curr_hect = 0;

            var abort_nos = 0;
            var abort_hect = 0;

            var Present_nos = 0;
            var Present_hect = 0;

            pond_nos = ($('#nm_pond_nos').val() != "" ? parseFloat($('#nm_pond_nos').val()) : 0);
            pond_hect = ($('#nm_pond_hect').val() != "" ? parseFloat($('#nm_pond_hect').val()) : 0);

            Past_nos = ($('#nm_Past_nos').val() != "" ? parseFloat($('#nm_Past_nos').val()) : 0);
            Past_hect = ($('#nm_Past_hect').val() != "" ? parseFloat($('#nm_Past_hect').val()) : 0);

            Curr_nos = ($('#nm_Curr_nos').val() != "" ? parseFloat($('#nm_Curr_nos').val()) : 0);
            Curr_hect = ($('#nm_Curr_hect').val() != "" ? parseFloat($('#nm_Curr_hect').val()) : 0);

            abort_nos = ($('#nm_abort_nos').val() != "" ? parseFloat($('#nm_abort_nos').val()) : 0);
            abort_hect = ($('#nm_abort_hect').val() != "" ? parseFloat($('#nm_abort_hect').val()) : 0);

            Present_nos = 0;
            Present_hect = 0;

            Present_nos = Past_nos + Curr_nos - abort_nos;
            Present_hect = Past_hect + Curr_hect - abort_hect;

            $('#nm_Present_nos').val(Present_nos.toFixed(2));
            $('#nm_Present_hect').val(Present_hect.toFixed(2));
        }

        //function onAreaChange() {

        //    var Scheme_Area = parseFloat($('#nm_Scheme_hect').val());

        //    var FCMale_Area = parseFloat($('#nm_FCMale_hect').val());
        //    var FCFemale_Area = parseFloat($('#nm_FCFemale_hect').val());

        //    var FshGov_Area = parseFloat($('#nm_FshGov_hect').val());

        //    var SCMale_Area = parseFloat($('#nm_SCMale_hect').val());
        //    var SCFemale_Area = parseFloat($('#nm_SCFemale_hect').val());

        //    var STMale_Area = parseFloat($('#nm_STMale_hect').val());
        //    var STFemale_Area = parseFloat($('#nm_STFemale_hect').val());

        //    var OBCMale_Area = parseFloat($('#nm_OBCMale_hect').val());
        //    var OBCFemale_Area = parseFloat($('#nm_OBCFemale_hect').val());

        //    var MusMale_Area = parseFloat($('#nm_MusMale_hect').val());
        //    var MusFemale_Area = parseFloat($('#nm_MusFemale_hect').val());

        //    var GenMale_Area = parseFloat($('#nm_GenMale_hect').val());
        //    var GenFemale_Area = parseFloat($('#nm_GenFemale_hect').val());

        //    $('#nm_total_hect').val(
        //            (
        //               Scheme_Area + FCMale_Area + FCFemale_Area + FshGov_Area + SCMale_Area + SCFemale_Area + STMale_Area + STFemale_Area + OBCMale_Area + OBCFemale_Area + MusMale_Area + MusFemale_Area + GenMale_Area + GenFemale_Area
        //            ).toFixed(2)
        //        );
        //}
    </script>
     <%--For Insert/Update Record --%>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnSubmit").click(function () {

                var objMst = {};
                var MonthId = $('#ddlMonthName').val();
                var YearTarget = $('#nm_yearlyTarget').val();

                if (MonthId > 0 && YearTarget>0) {

                    objMst.MonthKey = MonthId;
                    objMst.YearlyTarget = YearTarget;

                    objMst.PondNos = parseFloat($('#nm_pond_nos').val());
                    objMst.PondArea = parseFloat($('#nm_pond_hect').val());

                    objMst.PastPastNos = parseFloat($('#nm_Past_nos').val());
                    objMst.PastPastArea = parseFloat($('#nm_Past_hect').val());

                    objMst.CurrPattaNos = parseFloat($('#nm_Curr_nos').val());
                    objMst.CurrPattaArea = parseFloat($('#nm_Curr_hect').val());

                    objMst.AbortPattaNos = parseFloat($('#nm_abort_nos').val());
                    objMst.AbortPattaArea = parseFloat($('#nm_abort_hect').val());

                    objMst.TotalPattaNos = parseFloat($('#nm_Present_nos').val());
                    objMst.TotalPattaArea = parseFloat($('#nm_Present_hect').val());

                    $.ajax({
                        type: "POST",
                        url: "PondProgressPart_I.aspx/Create",
                        data: '{objPondProgressFirstMaster: ' + JSON.stringify(objMst) + '}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            var r = $.parseJSON(response.d);
                            if (r.StatusCode == "200") {
                                alert(r.Msg);
                                window.location.href = "PondProgressPart_I.aspx";
                            }
                            else {
                                alert(r.Msg);
                            }
                        },
                        error: function (err) {
                            alert(err.statusText)
                        }
                    });
                }
                else {
                    event.preventDefault();
                    alert('Please Enter Required Fields.');
                }
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div id="content-container">
        <asp:HiddenField ID="hidDistrictKey" runat="server" />
        <!--Page Title-->
        <!--------------------------------------------------------->
        <div class="pageheader hidden-xs">
            <h3><i class="fa fa-home"></i>ग्राम सभा के तालाबों के पट्टों की सूचना - प्रपत्र - I </h3>
            <div class="breadcrumb-wrapper">
                <%-- <span class="label">You are here:</span>--%>
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">होम </a></li>
                    <li class="active">ग्राम सभा के तालाबों के पट्टों की सूचना - प्रपत्र - I</li>
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
                                <h3 class="panel-title"><strong>ग्राम सभा के तालाबों के पट्टों की सूचना - प्रपत्र - I</strong></h3>
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
                                    <div class="col-lg-5">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="col-lg-4 control-label">वार्षिक लक्ष्य</label>
                                                <div class="col-lg-8">
                                                   <input type="number" class="form-control" value="0.00" style="text-align: right"  step="0.01" min="0.00" id="nm_yearlyTarget"/>
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>
                                    <div class="col-lg-2" hidden>
                                        <button class="btn btn-warning align-right" type="button" onclick="showProgress();">खोजें</button>
                                    </div>

                                </div>
                            </div>

                        </div>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel" id="pnlDetail">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="table-responsive">
                                            <table class="table tabel-responsive table-bordered">
                                                <colgroup>
                                                    <col style="text-align: center; width: 5%" />
                                                    <col style="text-align: center; width: 45%" />
                                                    <col style="text-align: right; width: 25%" />
                                                    <col style="text-align: right; width: 25%" />
                                                </colgroup>
                                                <thead>
                                                    <tr>
                                                        <th>क्र0सं0
                                                        </th>
                                                        <th>विवरण
                                                        </th>
                                                        <th style="text-align: right; width: 25%">संख्या
                                                        </th>
                                                        <th style="text-align: right; width: 25%">क्षेत्रफल (हे0)
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <label>1.</label>
                                                        </td>
                                                        <td>
                                                            <label>कुल उपलब्ध तालाब</label>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right"  step="0.01" min="0.00" id="nm_pond_nos" onchange="onNosChange();"/>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right"  step="0.01" min="0.00" id="nm_pond_hect" onchange="onNosChange();"/>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <label>2.</label>
                                                        </td>
                                                        <td>
                                                            <label>पिछले वित्तीय वर्ष 2018-2019 तक हुये कुल पट्टे</label>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right"  step="0.01" min="0.00" id="nm_Past_nos" onchange="onNosChange();"/>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right"  step="0.01" min="0.00" id="nm_Past_hect" onchange="onNosChange();"/>
                                                        </td>
                                                    </tr>
                                                     <tr>
                                                        <td>
                                                            <label>3.</label>
                                                        </td>
                                                        <td>
                                                            <label>चालू वित्तीय वर्ष 2019-2020 में गत माह तक हुये कुल पट्टे</label>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right"  step="0.01" min="0.00" id="nm_Curr_nos" onchange="onNosChange();"/>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right"  step="0.01" min="0.00" id="nm_Curr_hect" onchange="onNosChange();"/>
                                                        </td>
                                                    </tr>
                                                     <tr>
                                                        <td>
                                                            <label>4.</label>
                                                        </td>
                                                        <td>
                                                            <label>चालू वित्तीय वर्ष 2019-2020 में अवधि पूर्ण होने तक निरस्त पट्टे</label>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right" step="0.01" min="0.00" id="nm_abort_nos" onchange="onNosChange();"/>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right"  step="0.01" min="0.00" id="nm_abort_hect" onchange="onNosChange();"/>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <label>5.</label>
                                                        </td>
                                                        <td>
                                                            <label>अब तक हुए कुल पट्टे</label>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right"  step="0.01" min="0.00" id="nm_Present_nos" onchange="onNosChange();" readonly/>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right"  step="0.01" min="0.00" id="nm_Present_hect" onchange="onNosChange();" readonly/>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                                <tfoot>
                                                  <%--  <tr>
                                                        <td colspan="2" style="text-align: right; font-weight:bold" >
                                                            कुल योग
                                                        </td>
                                                        <td>
                                                             <input type="number" class="form-control" value="0.00" style="text-align: right"  step="0.01" min="0.00" id="nm_total_nos" readonly />
                                                        </td>
                                                        <td>
                                                             <input type="number" class="form-control" value="0.00" style="text-align: right"  step="0.01" min="0.00" id="nm_total_hect" readonly />
                                                        </td>
                                                    </tr>--%>
                                                </tfoot>
                                            </table>

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="panel-footer">
                                <button class="btn btn-info" type="submit" id="btnSubmit">सुरक्षित करें</button>
                                &nbsp;&nbsp;&nbsp;
                                 <button class="btn btn-warning" type="button">निरस्त करें</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
