<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DistrictMaster.master" AutoEventWireup="true" CodeFile="PondProgressPart_II.aspx.cs" Inherits="District_PondProgressPart_II" %>

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
            $('#pnlDetail').hide();
            $.ajax({
                type: "POST",
                url: "PondProgressPart_II.aspx/GetMonthName",
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
            if (monthKey > 0) {
                $('#pnlDetail').show();

                $.ajax({
                    type: "POST",
                    url: "PondProgressPart_II.aspx/GetFirstPondTotal",
                    data: '{MonthId : ' + monthKey + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        var data = $.parseJSON(r.d);

                        $('#nm_Scheme_nos').val(data[0].TotalPattNos);
                        $('#nm_Scheme_hect').val(data[0].TotalPattaArea);
                    }
                });

                $('#nm_FCMale_nos').val(0.00);
                $('#nm_FCMale_hect').val(0.00);
                $('#nm_FCFemale_nos').val(0.00);
                $('#nm_FCFemale_hect').val(0.00);

                $('#nm_FshGov_nos').val(0.00);
                $('#nm_FshGov_hect').val(0.00);

                $('#nm_SCMale_nos').val(0.00);
                $('#nm_SCMale_hect').val(0.00);
                $('#nm_SCFemale_nos').val(0.00);
                $('#nm_SCFemale_hect').val(0.00);

                $('#nm_STMale_nos').val(0.00);
                $('#nm_STMale_hect').val(0.00);
                $('#nm_STFemale_nos').val(0.00);
                $('#nm_STFemale_hect').val(0.00);

                $('#nm_OBCMale_nos').val(0.00);
                $('#nm_OBCMale_hect').val(0.00);
                $('#nm_OBCFemale_nos').val(0.00);
                $('#nm_OBCFemale_hect').val(0.00);

                $('#nm_MusMale_nos').val(0.00);
                $('#nm_MusMale_hect').val(0.00);
                $('#nm_MusFemale_nos').val(0.00);
                $('#nm_MusFemale_hect').val(0.00);

                $('#nm_GenMale_nos').val(0.00);
                $('#nm_GenMale_hect').val(0.00);
                $('#nm_GenFemale_nos').val(0.00);
                $('#nm_GenFemale_hect').val(0.00);

                $('#nm_total_nos').val(0.00);
                $('#nm_total_hect').val(0.00);
            }
            else {
                alert('Please Select Month');
            }
        }

        function onNosChange() {

            var FCMale_nos = parseFloat($('#nm_FCMale_nos').val());
            var FCFemale_nos = parseFloat($('#nm_FCFemale_nos').val());

            var FshGov_nos = parseFloat($('#nm_FshGov_nos').val());

            var SCMale_nos = parseFloat($('#nm_SCMale_nos').val());
            var SCFemale_nos = parseFloat($('#nm_SCFemale_nos').val());

            var STMale_nos = parseFloat($('#nm_STMale_nos').val());
            var STFemale_nos = parseFloat($('#nm_STFemale_nos').val());
            
            var OBCMale_nos = parseFloat($('#nm_OBCMale_nos').val());
            var OBCFemale_nos = parseFloat($('#nm_OBCFemale_nos').val());

            var MusMale_nos = parseFloat($('#nm_MusMale_nos').val()); 
            var MusFemale_nos = parseFloat($('#nm_MusFemale_nos').val());

            var GenMale_nos = parseFloat($('#nm_GenMale_nos').val());
            var GenFemale_nos = parseFloat($('#nm_GenFemale_nos').val());

            $('#nm_total_nos').val(
                    (
                       FCMale_nos+FCFemale_nos+FshGov_nos+SCMale_nos+SCFemale_nos+STMale_nos+STFemale_nos+OBCMale_nos+OBCFemale_nos+MusMale_nos+MusFemale_nos+GenMale_nos+GenFemale_nos
                    ).toFixed(2)
                );
        }

         function onAreaChange() {

            var FCMale_Area = parseFloat($('#nm_FCMale_hect').val());
            var FCFemale_Area = parseFloat($('#nm_FCFemale_hect').val());

            var FshGov_Area = parseFloat($('#nm_FshGov_hect').val());

            var SCMale_Area = parseFloat($('#nm_SCMale_hect').val());
            var SCFemale_Area = parseFloat($('#nm_SCFemale_hect').val());

            var STMale_Area = parseFloat($('#nm_STMale_hect').val());
            var STFemale_Area = parseFloat($('#nm_STFemale_hect').val());
            
            var OBCMale_Area = parseFloat($('#nm_OBCMale_hect').val());
            var OBCFemale_Area = parseFloat($('#nm_OBCFemale_hect').val());

            var MusMale_Area = parseFloat($('#nm_MusMale_hect').val()); 
            var MusFemale_Area = parseFloat($('#nm_MusFemale_hect').val());

            var GenMale_Area = parseFloat($('#nm_GenMale_hect').val());
            var GenFemale_Area = parseFloat($('#nm_GenFemale_hect').val());

            $('#nm_total_hect').val(
                    (
                       FCMale_Area+FCFemale_Area+FshGov_Area+SCMale_Area+SCFemale_Area+STMale_Area+STFemale_Area+OBCMale_Area+OBCFemale_Area+MusMale_Area+MusFemale_Area+GenMale_Area+GenFemale_Area
                    ).toFixed(2)
                );
        }
    </script>
     <%--For Insert/Update Record --%>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnSubmit").click(function () {

                var objMst = {};
                var MonthId = $('#ddlMonthName').val();

                if (MonthId > 0) {

                    objMst.MonthKey = MonthId;

                    objMst.SchPattaNos = parseFloat($('#nm_Scheme_nos').val());
                    objMst.SchPattaArea = parseFloat($('#nm_Scheme_hect').val());

                    objMst.FCMaleNos = parseFloat($('#nm_FCMale_nos').val());
                    objMst.FCMaleArea = parseFloat($('#nm_FCMale_hect').val());
                    objMst.FCFemaleNos = parseFloat($('#nm_FCFemale_nos').val());
                    objMst.FCFemaleArea = parseFloat($('#nm_FCFemale_hect').val());

                    objMst.FGovtNos = parseFloat($('#nm_FshGov_nos').val());
                    objMst.FGovtArea = parseFloat($('#nm_FshGov_hect').val());

                    objMst.SCMaleNos = parseFloat($('#nm_SCMale_nos').val());
                    objMst.SCMaleArea = parseFloat($('#nm_SCMale_hect').val());
                    objMst.SCFemaleNos = parseFloat($('#nm_SCFemale_nos').val());
                    objMst.SCFemaleArea = parseFloat($('#nm_SCFemale_hect').val());

                    objMst.STMaleNos = parseFloat($('#nm_STMale_nos').val());
                    objMst.STMaleArea = parseFloat($('#nm_STMale_hect').val());
                    objMst.STFemaleNos = parseFloat($('#nm_STFemale_nos').val());
                    objMst.STFemaleArea = parseFloat($('#nm_STFemale_hect').val());

                    objMst.OBCMaleNos = parseFloat($('#nm_OBCMale_nos').val());
                    objMst.OBCMaleArea = parseFloat($('#nm_OBCMale_hect').val());
                    objMst.OBCFemaleNos = parseFloat($('#nm_OBCFemale_nos').val());
                    objMst.OBCFemaleArea = parseFloat($('#nm_OBCFemale_hect').val());

                    objMst.MusMaleNos = parseFloat($('#nm_MusMale_nos').val()); 
                    objMst.MusMaleArea = parseFloat($('#nm_MusMale_hect').val()); 
                    objMst.MusFemaleNos = parseFloat($('#nm_MusFemale_nos').val());
                    objMst.MusFemaleArea = parseFloat($('#nm_MusFemale_hect').val());

                    objMst.GenMaleNos = parseFloat($('#nm_GenMale_nos').val());
                    objMst.GenMaleArea = parseFloat($('#nm_GenMale_hect').val());
                    objMst.GenFemaleNos = parseFloat($('#nm_GenFemale_nos').val());
                    objMst.GenFemaleArea = parseFloat($('#nm_GenFemale_hect').val());

                    $.ajax({
                        type: "POST",
                        url: "PondProgressPart_II.aspx/Create",
                        data: '{objPondProgressMaster: ' + JSON.stringify(objMst) + '}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            var r = $.parseJSON(response.d);
                            if (r.StatusCode == "200") {
                                alert(r.Msg);
                                window.location.href = "PondProgressPart_II.aspx";
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
                    alert('Please Select Required Selection.');
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
            <h3><i class="fa fa-home"></i>ग्राम सभा के तालाबों के पट्टों की सूचना - प्रपत्र - II</h3>
            <div class="breadcrumb-wrapper">
                <%-- <span class="label">You are here:</span>--%>
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">होम </a></li>
                    <li class="active">ग्राम सभा के तालाबों के पट्टों की सूचना - प्रपत्र - II</li>
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
                                <h3 class="panel-title"><strong>ग्राम सभा के तालाबों के पट्टों की सूचना - प्रपत्र - II</strong></h3>
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

                                    <div class="col-lg-2">
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
                                                            <label>अब तक हुये कुल पट्टे</label>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right"  step="0.01" min="0.00" id="nm_Scheme_nos" readonly/>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right"  step="0.01" min="0.00" id="nm_Scheme_hect" readonly/>
                                                        </td>
                                                    </tr>
                                                     <tr>
                                                        <td>
                                                            <label>2 (अ).</label>
                                                        </td>
                                                        <td>
                                                            <label>मछुआ समुदाय (पुरूष)</label>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right"  step="0.01" min="0.00" id="nm_FCMale_nos" onchange="onNosChange();"/>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right"  step="0.01" min="0.00" id="nm_FCMale_hect" onchange="onAreaChange();"/>
                                                        </td>
                                                    </tr>
                                                     <tr>
                                                        <td>
                                                            <label>2 (ब).</label>
                                                        </td>
                                                        <td>
                                                            <label>मछुआ समुदाय (महिला)</label>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right" step="0.01" min="0.00" id="nm_FCFemale_nos" onchange="onNosChange();"/>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right"  step="0.01" min="0.00" id="nm_FCFemale_hect" onchange="onAreaChange();"/>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <label>3.</label>
                                                        </td>
                                                        <td>
                                                            <label>मत्स्य जीवी सहकारी समिति</label>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right"  step="0.01" min="0.00" id="nm_FshGov_nos" onchange="onNosChange();"/>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right"  step="0.01" min="0.00" id="nm_FshGov_hect" onchange="onAreaChange();"/>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <label>4 (अ).</label>
                                                        </td>
                                                        <td>
                                                            <label>अनुसूचित जाति (पुरूष)</label>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right"  step="0.01" min="0.00" id="nm_SCMale_nos" onchange="onNosChange();"/>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right"  step="0.01" min="0.00" id="nm_SCMale_hect" onchange="onAreaChange();"/>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <label>4 (ब).</label>
                                                        </td>
                                                        <td>
                                                            <label>अनुसूचित जाति (महिला)</label>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control disabled" value="0.00" style="text-align: right" step="0.01" min="0.01" id="nm_SCFemale_nos" onchange="onNosChange();"/>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control disabled" value="0.00" style="text-align: right"  step="0.01" min="0.01" id="nm_SCFemale_hect" onchange="onAreaChange();"/>
                                                        </td>
                                                    </tr>
                                                   <tr>
                                                        <td>
                                                            <label>5 (अ).</label>
                                                        </td>
                                                        <td>
                                                            <label>अनुसूचित जनजाति (पुरूष)</label>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right" step="0.01" min="0.00" id="nm_STMale_nos" onchange="onNosChange();"/>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right" step="0.01" min="0.00" id="nm_STMale_hect" onchange="onAreaChange();"/>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <label>5 (ब).</label>
                                                        </td>
                                                        <td>
                                                            <label>अनुसूचित जनजाति (महिला)</label>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right" step="0.01" min="0.00" id="nm_STFemale_nos" onchange="onNosChange();"/>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right" step="0.01" min="0.00" id="nm_STFemale_hect" onchange="onAreaChange();"/>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <label>6 (अ).</label>
                                                        </td>
                                                        <td>
                                                            <label>पिछड़ी जाति (पुरूष)</label>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right" step="0.01" min="0.00" id="nm_OBCMale_nos" onchange="onNosChange();"/>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right"  step="0.01" min="0.00" id="nm_OBCMale_hect" onchange="onAreaChange();"/>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <label>6 (ब).</label>
                                                        </td>
                                                        <td>
                                                            <label>पिछड़ी जाति (महिला)</label>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control " value="0.00" style="text-align: right" step="0.01" min="0.00" id="nm_OBCFemale_nos" onchange="onNosChange();"/>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right" step="0.01" min="0.00" id="nm_OBCFemale_hect" onchange="onAreaChange();"/>
                                                        </td>
                                                    </tr>
                                                     <tr>
                                                        <td>
                                                            <label>7 (अ).</label>
                                                        </td>
                                                        <td>
                                                            <label>मुस्लिम जाति (पुरूष)</label>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right" step="0.01" min="0.00" id="nm_MusMale_nos" onchange="onNosChange();"/>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right" step="0.01" min="0.00" id="nm_MusMale_hect" onchange="onAreaChange();"/>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <label>7 (ब).</label>
                                                        </td>
                                                        <td>
                                                            <label>मुस्लिम जाति (महिला)</label>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right" step="0.01" min="0.00" id="nm_MusFemale_nos" onchange="onNosChange();"/>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right" step="0.01" min="0.00" id="nm_MusFemale_hect" onchange="onAreaChange();"/>
                                                        </td>
                                                    </tr>
                                                      <tr>
                                                        <td>
                                                            <label>8 (अ).</label>
                                                        </td>
                                                        <td>
                                                            <label>सामान्य जाति (पुरूष)</label>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right" step="0.01" min="0.00" id="nm_GenMale_nos" onchange="onNosChange();"/>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right" step="0.01" min="0.00" id="nm_GenMale_hect" onchange="onAreaChange();"/>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <label>8 (ब).</label>
                                                        </td>
                                                        <td>
                                                            <label>सामान्य जाति (महिला)</label>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right"  step="0.01" min="0.00" id="nm_GenFemale_nos" onchange="onNosChange();"/>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right" step="0.01" min="0.00" id="nm_GenFemale_hect" onchange="onAreaChange();"/>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                                <tfoot>
                                                    <tr>
                                                        <td colspan="2" style="text-align: right; font-weight:bold" >
                                                            कुल योग
                                                        </td>
                                                        <td>
                                                             <input type="number" class="form-control" value="0.00" style="text-align: right"  step="0.01" min="0.00" id="nm_total_nos" readonly />
                                                        </td>
                                                        <td>
                                                             <input type="number" class="form-control" value="0.00" style="text-align: right"  step="0.01" min="0.00" id="nm_total_hect" readonly />
                                                        </td>
                                                    </tr>
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

