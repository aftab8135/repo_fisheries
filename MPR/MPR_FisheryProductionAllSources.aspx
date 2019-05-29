<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DistrictMaster.master" AutoEventWireup="true" CodeFile="MPR_FisheryProductionAllSources.aspx.cs" Inherits="MPR_FisheryProductionAllSources" %>

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
            //Load Scheme Type on Page Load
            $.ajax({
                type: "POST",
                url: "MPR_FisheryProductionAllSources.aspx/GetMPR_ProductionHead",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var ddlType = $("#ddlCategoryName");
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
                url: "MPR_FisheryProductionAllSources.aspx/GetMonthName",
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
        function getMSR_ForMonth() {
            var cateKey = $('#ddlCategoryName').val();
            var monthKey = $('#ddlMonthName').val();
            if (cateKey > 0 && monthKey > 0) {

                var CategoryKey = $('#ddlCategoryName').val();;
                var MonthId = $('#ddlMonthName').val();
                if (CategoryKey > 0 && MonthId > 0) {
                    $.ajax({
                        type: "POST",
                        url: "MPR_FisheryProductionAllSources.aspx/IsExist",
                        data: '{MonthId: ' + $('#ddlMonthName option:selected').val() + ', CategoryID :' + $('#ddlCategoryName option:selected').val() + ' }',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            var r = $.parseJSON(response.d);
                            if (r.StatusCode == "200") {
                                alert(r.Msg);
                                return;
                            }
                            else {
                                
                                $('#pnlDetail').show();
                                $('#tblfishProduction tbody').empty();
                                objMstArr = [];
                                $.ajax({
                                    type: "Post",
                                    contentType: "application/json; charset=utf-8",
                                    url: "MPR_FisheryProductionAllSources.aspx/GetFisheryProduction",
                                    data: '{CateKey: ' + cateKey + '}',
                                    dataType: "json",
                                    success: function (data) {
                                        var mst = $.parseJSON(data.d);
                                        var id = 1;                                 
                                        $.each(mst, function (index, value) {

                                            var ttlArea = 0.0;
                                            var ttlProd = 0.0;

                                            var objMst_FishProd = {};
                                            objMst_FishProd.ContID = id;
                                            objMst_FishProd.FishProdSubHeadKey = value.FishProdSubHeadKey;
                                            objMst_FishProd.ProductionSubHeadName = value.ProductionSubHeadName;
                                            objMst_FishProd.TotalArea = parseFloat(0);
                                            objMst_FishProd.TotalProduction = parseFloat(0);
                                            objMstArr.push(objMst_FishProd);


                                            var row = '<tr><td style="text-align: center"><b>' + id + '</b><input id="tbl_hd_' + id + '" type="hidden" value="' + value.FishProdSubHeadKey + '"/> </td>';
                                            row = row + '<td>' + value.ProductionSubHeadName + '</td>'
                                            if (value.ProductionSubHeadName == "कुल उत्पादन संर्बधन" || value.ProductionSubHeadName == "कुल उत्पादन जलाशय") {
                                                row = row + '<td><input type="number" class="form-control" value="0.00" style="text-align:right" step="0.01" min="0.00" id="tbl_nm_area_' + id + '"  readonly /></td>'
                                                row = row + '<td><input type="number" class="form-control" value="0.00" style="text-align:right" step="0.01" min="0.00" id="tbl_nm_production_' + id + '"  readonly/></td>'
                                            }
                                            else {
                                                row = row + '<td><input type="number" class="form-control" value="0.00" style="text-align:right" step="0.01" min="0.00" id="tbl_nm_area_' + id + '" /></td>'
                                                row = row + '<td><input type="number" class="form-control" value="0.00" style="text-align:right" step="0.01" min="0.00" id="tbl_nm_production_' + id + '"/></td>'
                                            }
                                            row = row + '</tr>'

                                          
                                            ttlArea = parseFloat(ttlArea) + parseFloat(0);
                                            ttlProd = parseFloat(ttlProd) + parseFloat(0);
                                          
                                            id += 1;
                                            $('#tblfishProduction tbody').append(row);
                                        });

                                        if (id == 1) {
                                           var frow = '<tr><td colspan=4 style = "text-align:center"><b>कोई भी सूचना उपलब्ध नहीं हैं।</b></td><tr>';
                                            $('#tblfishProduction tfoot').empty();
                                            $('#tblfishProduction tfoot').append(frow);
                                        } else {
                                            var frow = '<tr><td colspan=2 style = "text-align:right"><b>कुल योग</b></td>';
                                            frow = frow + ' <td style="text-align: right"><input type="number" class="form-control" value="' + ttlArea.toFixed(2) + '" readonly style="text-align:right"/></td>';
                                            frow = frow + ' <td style="text-align: right"><input type="number" class="form-control" value="' + ttlProd.toFixed(2) + '" readonly style="text-align:right"/></td>';
                                          
                                            frow = frow + '<tr>';
                                            $('#tblfishProduction tfoot').empty();
                                            $('#tblfishProduction tfoot').append(frow);
                                        }
                                    },

                                    error: function () {
                                        alert("Error while retrieving data.");
                                    }
                                });

                            }
                        },
                        error: function (err) {
                            alert(err.statusText)
                        }
                    });
                }
                
            }
        }

        function onCategoryChange() {
           
            objMstArr = [];
            $('#tblfishProduction tbody').empty();
            $('#tblfishProduction tfoot').empty();
            var frow = '<tr><td colspan=4 style = "text-align:center"><b>कोई भी सूचना उपलब्ध नहीं हैं। </b></td><tr>';
            $('#tblfishProduction tfoot').append(frow);
        }


        //function onNM_RecAmtTarget(contr) {
        //    var ttlYear = 0;
        //    var ttlPrev = 0;
        //    var ttlCur = 0;

        //    var yearlytarget = $('#' + contr.id).val();
          
        //    $.each(objMstArr, function (index, value) {

        //        ttlYear = parseFloat(ttlYear) + parseFloat(value.yearlytarget);
        //        alert(ttlYear);
        //    });
           
        //    var frow = '<tr><td colspan=2 style = "text-align:right"><b>कुल योग</b></td>';
         
        //    frow = frow + ' <td style="text-align: right"><input type="number" class="form-control" value="' + ttlYear + '" readonly style="text-align:right"/></td>';
        //    alert(frow);
        //    frow = frow + ' <td style="text-align: right"><input type="number" class="form-control" value="' + 0 + '" readonly style="text-align:right"/></td>';
        //    frow = frow + ' <td style="text-align: right"><input type="number" class="form-control" value="' + 0 + '" readonly style="text-align:right"/></td>';

        //    frow = frow + '<tr>';
          
        //    $('#tblIsForwarded tfoot').empty();
        //    $('#tblIsForwarded tfoot').append(frow);
        //}

        //function setTotalAmount() {
           
        //    var ttlYear = 0;
        //    var ttlPrev = 0;
        //    var ttlCur = 0;
        //    var ttlTotal = 0;

        //    $.each(objMstArr, function (index, value) {
            
        //        ttlYear = parseFloat(ttlYear) + parseFloat(value.YearlyTarget);
        //        ttlPrev = parseFloat(ttlPrev) + parseFloat(value.TotalArea);
        //        ttlCur = parseFloat(ttlCur) + parseFloat(value.TotalProduction);
               
        //    });
          
        //    var frow = '<tr><td colspan=2 style = "text-align:right"><b>कुल योग</b></td>';
        //    frow = frow + ' <td style="text-align: right"><input type="number" class="form-control" value="' + ttlYear.toFixed(2) + '" readonly style="text-align:right"/></td>';
        //    frow = frow + ' <td style="text-align: right"><input type="number" class="form-control" value="' + ttlPrev.toFixed(2) + '" readonly style="text-align:right"/></td>';
        //    frow = frow + ' <td style="text-align: right"><input type="number" class="form-control" value="' + ttlCur.toFixed(2) + '" readonly style="text-align:right"/></td>';
           
        //    frow = frow + '<tr>';
        //    $('#tblIsForwarded tfoot').empty();
        //    $('#tblIsForwarded tfoot').append(frow);
        //}

        //function onMonthChange() {
        //    $.ajax({
        //        type: "POST",
        //        url: "MPR_FisheryProductionAllSources.aspx/IsExist",
        //        data: '{MonthId: ' + $('#ddlMonthName option:selected').val() + ', CategoryID :' + $('#ddlCategoryName option:selected').val() + ' }',
        //        contentType: "application/json; charset=utf-8",
        //        dataType: "json",
        //        success: function (response) {
        //            var r = $.parseJSON(data.d);
        //            if (r.StatusCode == "202") {
        //                alert(r.Msg);
        //                objMsrMst.CategoryKey = $('#ddlCategoryName option:selected').val('');;
        //                objMsrMst.MonthId = $('#ddlMonthName option:selected').val('');
        //                onCategoryChange();
        //            }
        //            else {
        //                alert(r.Msg);
        //            }
        //        },
        //        error: function (err) {
        //            alert(err.statusText)
        //        }
        //    });
        //}

    </script>

    <%--For Insert/Update Record --%>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnSubmit").click(function () {
           
                var CategoryKey = $('#ddlCategoryName').val();;
                var MonthId = $('#ddlMonthName').val();
                var YearlyTarget = $('#yearly_target').val();

                if (objMstArr.length > 0 && CategoryKey > 0 && MonthId > 0) {
                    var objMsrMst = {};
                    var objMsrDets = [];

                    objMsrMst.FishProdHeadKey = $('#ddlCategoryName').val();;
                    objMsrMst.MonthId = $('#ddlMonthName').val();
                    objMsrMst.YearlyTaget = $('#yearly_target').val();

                    $("#tblfishProduction tbody tr").each(function () {
                        var row = $(this);
                        var objFishProd = {};

                        objFishProd.FishProdSubHeadKey = row.find("td").eq(0).find('input[type="hidden"]').val();
                        objFishProd.TotalArea = row.find("td").eq(2).find('input[type="number"]').val()
                        objFishProd.TotalProduction = row.find("td").eq(3).find('input[type="number"]').val()

                        objMsrDets.push(objFishProd);
                    });

                    objMsrMst.FishProdDetails = objMsrDets;

                    $.ajax({
                        type: "POST",
                        url: "MPR_FisheryProductionAllSources.aspx/Create",
                        data: '{objFP: ' + JSON.stringify(objMsrMst) + '}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            var r = $.parseJSON(response.d);
                            if (r.StatusCode == "200") {
                                alert(r.Msg);
                              //  window.location.href = "MPR_FisheryProductionAllSources.aspx";
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
            <h3><i class="fa fa-home"></i>समस्त श्रोतों से अनुमानित मत्स्य उत्पादन (टन) </h3>
            <div class="breadcrumb-wrapper">
                <%-- <span class="label">You are here:</span>--%>
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">होम </a></li>
                    <li class="active">समस्त श्रोतों से अनुमानित मत्स्य उत्पादन </li>
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
                                <h3 class="panel-title"><strong>समस्त श्रोतों से अनुमानित मत्स्य उत्पादन</strong></h3>
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
                                    
                                    <div class="col-lg-3">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="col-lg-4 control-label">माह का नाम </label>
                                                <div class="col-lg-8">
                                                    <select class="form-control selectpicker" id="ddlMonthName" ">
                                                    </select>
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>
                                    <div class="col-lg-4">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="col-lg-4 control-label">मद का नाम </label>
                                                <div class="col-lg-8">
                                                    <select class="form-control selectpicker" data-live-search ="true" id="ddlCategoryName">
                                                    </select>
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>
                                       <div class="col-lg-3">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="col-lg-4 control-label">वार्षिक लक्ष्य </label>
                                                <div class="col-lg-8">
                                                   <input type="text" id="yearly_target" name="yearly_target"  class="form-control" />
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>
                                    <div class="col-lg-2">
                                        <button class="btn btn-warning align-right" type="button" onclick="getMSR_ForMonth();">खोजें</button>
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
                                    <div class="col-lg-12">
                                        <div class="table-responsive">
                                            <table class="table table-bordered table-responsive" id="tblfishProduction">
                                                <colgroup>
                                                    <col width="6%" />
                                                    <col width="64%" />                                                 
                                                    <col width="15%" />
                                                    <col width="15%" />
                                                </colgroup>
                                                <thead>
                                                    <tr>
                                                        <th style="text-align: center">क्रम स०</th>
                                                        <th style="text-align: center">उप मद का नाम</th>
                                                        <th style="text-align:right">क्षेत्रफल (हेक्ट)</th>
                                                        <th style="text-align:right">उत्पादन</th>
                                                       
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                   
                                                </tbody>
                                                <tfoot>                                                
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