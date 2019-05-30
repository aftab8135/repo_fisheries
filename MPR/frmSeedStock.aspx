<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DistrictMaster.master" AutoEventWireup="true" CodeFile="frmSeedStock.aspx.cs" Inherits="MPR_frmSeedStock" %>

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
        var objPondAuctMst = {};
        var objPondAuctArr = [];
        $(document).ready(function () {
            $('#pnlDetail').hide();
            $.ajax({
                type: "POST",
                url: "frmSeedStock.aspx/GetMonthName",
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

                }
            });

            $.ajax({
                type: "POST",
                url: "frmSeedStock.aspx/GetSeedObject",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var ddl = $("#ddlSDObject");
                    ddl.append($("<option></option>").val(0).html('मत्स्य बीज संचय का मद चुनें'));
                    $.each(r.d, function () {
                        ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    ddl.selectpicker('refresh');
                }
            });
        });

    </script>
    <script type="text/javascript">
        function getSeedTargetByObject() {
            // SeedStock
            var ddlSDObjectKey = $("#ddlSDObject").val();
            var monthKey = $('#ddlMonthName').val();
            if (ddlSDObjectKey > 0 && monthKey > 0) {
                $.ajax({
                    type: "Post",
                    contentType: "application/json; charset=utf-8",
                    url: "frmSeedStock.aspx/SeedStockObject",
                    data: '{}',
                    dataType: "json",
                    success: function (data) {
                        var mst = $.parseJSON(data.d);
                        $('#tblSeedStock tbody').empty();
                        var srno = 0
                        $.each(mst, function (ind, val) {
                            var row = '<tr>';
                            row=row +'<td style="text-align: center"><strong>'+(srno+1)+'</strong></td>';
                            row=row +'<td style="text-align: left"><input type="hidden" name="txtobject" value='+val.SSSubObjectKey+'>'+val.SSSubObjectName+'</td>';
                            row=row +'<td><input type="number" name="txtArea" class="form-control" value="0.0" style="text-align: right" onchange="calcArea();"/></td>';
                            row = row + '<td><input type="number" name="txtNos" class="form-control" value="0.0" style="text-align: right"  onchange="calcNos();"/></td>';
                            row = row + '</tr>';

                            srno = srno + 1;
                            $('#tblSeedStock tbody').append(row);
                        });

                        $('#pnlDetail').show();
                    }
                });

            }
            else {
                alert('कृपया मान्य प्रविष्टियों का चयन करें।');
            }
        }

        function calcArea() {
            var totalNos = 0;

            $('#tblSeedStock').find('input[name=txtArea]').each(function (ind, val) {
                totalNos = totalNos + parseFloat(val.value);
            });

            $('#totalArea').val(totalNos);

        };
        function calcNos() {
            var totalNos = 0;

            $('#tblSeedStock').find('input[name=txtNos]').each(function (ind, val) {
                totalNos = totalNos + parseFloat(val.value);
            });

            $('#totalNos').val(totalNos);

        };
    </script>

    <%--For Insert/Update Record --%>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnSubmit").click(function () {
                event.preventDefault();
                var MonthId = $('#ddlMonthName').val();
                var sdObjectKey = $('#ddlSDObject').val();
                var sdYearlyTarget = $('#totalYearlyTarget').val();

                if (sdObjectKey > 0 && MonthId > 0 && sdYearlyTarget>0) {
                   
                    var objSeedStockMaster = {};
                    var seedStockDetails = [];

                    objSeedStockMaster.MonthKey = MonthId;
                    objSeedStockMaster.SSObjectKey = sdObjectKey;
                    objSeedStockMaster.YearlyTarget = sdYearlyTarget;

                    $('#tblSeedStock tbody tr').each(function (ind, val) {
                        var objDetail = {};

                        var trow = val;

                        var nos = parseFloat($(trow).find('input[name=txtNos]')[0].value);
                        var area = parseFloat($(trow).find('input[name=txtArea]')[0].value);

                        objDetail.SSObjectSubKey = parseFloat($(trow).find('input[name=txtobject]')[0].value);
                        objDetail.Nos = nos;
                        objDetail.ObjectArea = area;

                        seedStockDetails.push(objDetail);
                    });

                    objSeedStockMaster.SeedStocks = seedStockDetails;

                    $.ajax({
                        type: "POST",
                        url: "frmSeedStock.aspx/Create",
                        data: '{objSeedStockMaster: ' + JSON.stringify(objSeedStockMaster) + '}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            var r = $.parseJSON(response.d);
                            if (r.StatusCode == "200") {
                                alert(r.Msg);
                                window.location.href = "frmSeedStock.aspx";
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
                    alert('कृपया मान्य प्रविष्टियों का चयन करें।');
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
            <h3><i class="fa fa-home"></i>समस्त श्रोतों से मत्स्य बीज संचय </h3>
            <div class="breadcrumb-wrapper">
                <%-- <span class="label">You are here:</span>--%>
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">होम </a></li>
                    <li class="active">समस्त श्रोतों से मत्स्य बीज संचय</li>
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
                                <h3 class="panel-title"><strong>समस्त श्रोतों से मत्स्य बीज संचय की सूचना (लाख में)</strong></h3>
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
                                        <div class="form-group">
                                            <label class="col-lg-4 control-label">मत्स्य बीज संचय का मद </label>
                                            <div class="col-lg-8">
                                                <select class="form-control selectpicker" data-live-search="true" id="ddlSDObject">
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-2">
                                        <button class="btn btn-warning align-right" type="button" onclick="getSeedTargetByObject();">खोजें</button>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel" id="pnlDetail">
                            <!--No Label Form-->
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-lg-5">
                                        <div class="form-group">
                                            <label class="col-lg-4 control-label">वार्षिक लक्ष्य</label>
                                            <div class="col-lg-8">
                                               <input type="number" id="totalYearlyTarget" class="form-control" value="0.0" style="text-align: right" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="table-responsive">
                                            <table class="table table-bordered table-responsive" id="tblSeedStock">
                                                <colgroup>
                                                    <col width="5%" />
                                                    <col width="55%" />
                                                    <col width="20%" />
                                                    <col width="20%" />
                                                </colgroup>
                                                <thead>
                                                    <tr>
                                                        <th style="text-align: center">क्रम स०</th>
                                                        <th>समस्त श्रोतों से मत्स्य बीज संचय</th>
                                                        <th>क्षेत्रफल (हेक्ट0)</th>
                                                        <th>संख्या (लाख में)</th>
                                                    </tr>

                                                </thead>
                                                <tbody>
                                                </tbody>
                                                <tfoot>
                                                    <tr>
                                                        <td colspan="2" style="text-align: right"><strong>कुल योग</strong></td>
                                                        <td>
                                                            <input type="number" id="totalArea" class="form-control" readonly="readonly" value="0.0" style="text-align: right" /></td>
                                                        <td>
                                                            <input type="number" id="totalNos" class="form-control" readonly="readonly" value="0.0" style="text-align: right" /></td>
                                                    </tr>
                                                </tfoot>
                                            </table>

                                        </div>

                                    </div>
                                </div>

                            </div>

                            <div class="panel-footer">
                                <div class="col-lg-offset-10">
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
    </div>
</asp:Content>
