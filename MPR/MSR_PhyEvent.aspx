<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DistrictMaster.master" AutoEventWireup="true" CodeFile="MSR_PhyEvent.aspx.cs" Inherits="District_MSR_PhyEvent" %>

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
                url: "MSR_PhyEvent.aspx/GetMSR_Category",
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
                url: "MSR_PhyEvent.aspx/GetMonthName",
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
                        url: "MSR_PhyEvent.aspx/IsExist",
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
                                $('#tblIsForwarded tbody').empty();
                                objMstArr = [];
                                $.ajax({
                                    type: "Post",
                                    contentType: "application/json; charset=utf-8",
                                    url: "MSR_PhyEvent.aspx/GetPhyEventDetail",
                                    data: '{CateKey: ' + cateKey + '}',
                                    dataType: "json",
                                    success: function (data) {
                                        var mst = $.parseJSON(data.d);
                                        var id = 1;
                                        var ttlYear = 0;
                                        var ttlPrev = 0;
                                        var ttlCur = 0;
                                        var ttlTotal = 0;

                                        $.each(mst, function (index, value) {

                                            var objMst_PhyEvent = {};
                                            objMst_PhyEvent.ContID = id;
                                            objMst_PhyEvent.CSRelKey = value.CSRelKey;

                                            objMst_PhyEvent.SubCategoryKey = value.SubCategoryKey;
                                            objMst_PhyEvent.UnitKey = value.UnitKey;
                                            objMst_PhyEvent.Grade = value.Grade;

                                            objMst_PhyEvent.SubHindiName = value.SubHindiName;
                                            objMst_PhyEvent.Target = parseFloat(value.Target);
                                            objMst_PhyEvent.PrevAmount = parseFloat(value.PrevAmount);
                                            objMst_PhyEvent.CurAmount = parseFloat(0);
                                            objMst_PhyEvent.TotalAmount = parseFloat(value.PrevAmount);
                                            objMstArr.push(objMst_PhyEvent);

                                            var row = '<tr><td style="text-align: center"><b>' + id + '</b><input id="tbl_hd_' + id + '" type="hidden" value="' + value.CSRelKey + '"/> </td>';
                                            row = row + '<td>' + value.SubHindiName + '</td>'
                                            row = row + '<td>' + value.UnitName + '</td>'
                                            row = row + '<td>' + value.Grade + '</td>'
                                            row = row + '<td><input type="number" class="form-control disabled" value="' + parseFloat(value.Target).toFixed(2) + '" readonly style="text-align:right" step="0.00" id="tbl_nm_target_' + id + '"/></td>'
                                            row = row + '<td><input type="number" class="form-control disabled" value="' + parseFloat(value.PrevAmount).toFixed(2) + '" readonly style="text-align:right" step="0.00" id="tbl_nm_prev_' + id + '"/></td>'
                                            row = row + '<td><input type="number" class="form-control disabled" value="0.00" style="text-align:right" step="0.01" min="0.00" id="tbl_nm_rec_' + id + '" onchange="onNM_RecAmt(this);"/></td>'
                                            row = row + '<td><input type="number" class="form-control disabled" value="' + parseFloat(value.PrevAmount).toFixed(2) + '" readonly style="text-align:right" step="0.00" id="tbl_nm_total_' + id + '"/></td>'
                                            row = row + '</tr>'

                                            ttlYear = parseFloat(ttlYear) + parseFloat(value.Target);
                                            ttlPrev = parseFloat(ttlPrev) + parseFloat(value.PrevAmount);
                                            ttlCur = parseFloat(ttlCur) + parseFloat(0);
                                            ttlTotal = parseFloat(ttlPrev) + parseFloat(value.PrevAmount);

                                            id += 1;
                                            $('#tblIsForwarded tbody').append(row);
                                        });
                                        if (id == 1) {
                                            var frow = '<tr><td colspan=8 style = "text-align:center"><b>कोई भी सूचना उपलब्ध नहीं हैं।</b></td><tr>';
                                            $('#tblIsForwarded tfoot').empty();
                                            $('#tblIsForwarded tfoot').append(frow);
                                        } else {
                                            var frow = '<tr><td colspan=4 style = "text-align:right"><b>कुल योग</b></td>';
                                            frow = frow + ' <td style="text-align: right"><input type="number" class="form-control disabled" value="' + ttlYear.toFixed(2) + '" readonly style="text-align:right"/></td>';
                                            frow = frow + ' <td style="text-align: right"><input type="number" class="form-control disabled" value="' + ttlPrev.toFixed(2) + '" readonly style="text-align:right"/></td>';
                                            frow = frow + ' <td style="text-align: right"><input type="number" class="form-control disabled" value="' + ttlCur.toFixed(2) + '" readonly style="text-align:right"/></td>';
                                            frow = frow + ' <td style="text-align: right"><input type="number" class="form-control disabled" value="' + ttlTotal.toFixed(2) + '" readonly style="text-align:right"/></td>';
                                            frow = frow + '<tr>';
                                            $('#tblIsForwarded tfoot').empty();
                                            $('#tblIsForwarded tfoot').append(frow);
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
            $('#tblIsForwarded tbody').empty();
            $('#tblIsForwarded tfoot').empty();
            var frow = '<tr><td colspan=8 style = "text-align:center"><b>कोई भी सूचना उपलब्ध नहीं हैं।</b></td><tr>';
            $('#tblIsForwarded tfoot').append(frow);
        }

        function onNM_RecAmt(contr) {
            var recAmt = $('#' + contr.id).val();
            var splIds = contr.id.split('_');
            var cId = splIds[splIds.length - 1];

            var prevAmt = $('#tbl_nm_prev_' + cId).val();

            var obj = objMstArr.filter(function(m){return m.ContID == cId})[0];
            obj.CurAmount = parseFloat(recAmt);
            obj.TotalAmount = parseFloat(prevAmt) + parseFloat(recAmt);

            $('#tbl_nm_total_' + cId).val(obj.TotalAmount.toFixed(2));

            setTotalAmount();
        }

        function setTotalAmount() {
            var ttlYear = 0;
            var ttlPrev = 0;
            var ttlCur = 0;
            var ttlTotal = 0;

            $.each(objMstArr, function (index, value) {
                ttlYear = parseFloat(ttlYear) + parseFloat(value.Target);
                ttlPrev = parseFloat(ttlPrev) + parseFloat(value.PrevAmount);
                ttlCur = parseFloat(ttlCur) + parseFloat(value.CurAmount);
                ttlTotal = parseFloat(ttlTotal) + parseFloat(value.TotalAmount);
            });

            var frow = '<tr><td colspan=4 style = "text-align:right"><b>कुल योग</b></td>';
            frow = frow + ' <td style="text-align: right"><input type="number" class="form-control disabled" value="' + ttlYear.toFixed(2) + '" readonly style="text-align:right"/></td>';
            frow = frow + ' <td style="text-align: right"><input type="number" class="form-control disabled" value="' + ttlPrev.toFixed(2) + '" readonly style="text-align:right"/></td>';
            frow = frow + ' <td style="text-align: right"><input type="number" class="form-control disabled" value="' + ttlCur.toFixed(2) + '" readonly style="text-align:right"/></td>';
            frow = frow + ' <td style="text-align: right"><input type="number" class="form-control disabled" value="' + ttlTotal.toFixed(2) + '" readonly style="text-align:right"/></td>';
            frow = frow + '<tr>';
            $('#tblIsForwarded tfoot').empty();
            $('#tblIsForwarded tfoot').append(frow);
        }

        function onMonthChange() {
            $.ajax({
                type: "POST",
                url: "MSR_PhyEvent.aspx/IsExist",
                data: '{MonthId: ' + $('#ddlMonthName option:selected').val() + ', CategoryID :' + $('#ddlCategoryName option:selected').val() + ' }',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var r = $.parseJSON(data.d);
                    if (r.StatusCode == "202") {
                        alert(r.Msg);
                        objMsrMst.CategoryKey = $('#ddlCategoryName option:selected').val('');;
                        objMsrMst.MonthId = $('#ddlMonthName option:selected').val('');
                        onCategoryChange();
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

    </script>

    <%--For Insert/Update Record --%>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnSubmit").click(function () {
                var objPhyList = [];
                var CategoryKey = $('#ddlCategoryName').val();;
                var MonthId = $('#ddlMonthName').val();
                if (objMstArr.length > 0 && CategoryKey > 0 && MonthId > 0) {
                    var objMsrMst = {};
                    var objMsrDets = [];

                    objMsrMst.CategoryKey = $('#ddlCategoryName').val();;
                    objMsrMst.MonthId = $('#ddlMonthName').val();

                    $.each(objMstArr, function (index, value) {
                        var objPhyEvent = {};
                        objPhyEvent.SubCategoryKey = value.SubCategoryKey;
                        objPhyEvent.UnitKey = value.UnitKey;
                        objPhyEvent.Grade = value.Grade;
                        objPhyEvent.YearlyTarget = parseFloat(value.Target);
                        objPhyEvent.PrevAmount = parseFloat(value.PrevAmount);
                        objPhyEvent.RecAmount = parseFloat(value.CurAmount);
                        objPhyEvent.TotalAmount = parseFloat(value.TotalAmount);

                        objMsrDets.push(objPhyEvent);
                    });

                    objMsrMst.EventDts = objMsrDets;
                    $.ajax({
                        type: "POST",
                        url: "MSR_PhyEvent.aspx/Create",
                        data: '{objMSR_PhyEventMst: ' + JSON.stringify(objMsrMst) + '}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            var r = $.parseJSON(response.d);
                            if (r.StatusCode == "200") {
                                alert(r.Msg);
                                window.location.href = "MSR_PhyEvent.aspx";
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
            <h3><i class="fa fa-home"></i>मत्स्य भौतिक कार्यक्रम सांख्यकीय </h3>
            <div class="breadcrumb-wrapper">
                <%-- <span class="label">You are here:</span>--%>
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">होम </a></li>
                    <li class="active">मत्स्य भौतिक कार्यक्रम सांख्यकीय </li>
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
                                <h3 class="panel-title"><strong>मत्स्य भौतिक कार्यक्रम सांख्यकीय</strong></h3>
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
                                                    <select class="form-control selectpicker" id="ddlMonthName" ">
                                                    </select>
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>
                                    <div class="col-lg-5">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="col-lg-4 control-label">मद का नाम </label>
                                                <div class="col-lg-8">
                                                    <select class="form-control selectpicker" data-live-search ="true" id="ddlCategoryName" onchange="onCategoryChange();">
                                                    </select>
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
                                            <table class="table table-bordered table-responsive" id="tblIsForwarded">
                                                <colgroup>
                                                    <col width="5%" />
                                                    <col width="32%" />
                                                    <col width="10%" />
                                                    <col width="5%" />
                                                    <col width="12%" />
                                                    <col width="12%" />
                                                    <col width="12%" />
                                                    <col width="12%" />
                                                </colgroup>
                                                <thead>
                                                    <tr>
                                                        <th style="text-align: center">क्रम स०</th>
                                                        <th style="text-align: center">उप मद का नाम</th>
                                                        <th>इकाई</th>
                                                        <th>श्रेणी</th>
                                                        <th style="text-align:right">वार्षिक लक्ष्य</th>
                                                        <th style="text-align:right">गत माह तक</th>
                                                        <th style="text-align:right">माह में</th>
                                                        <th style="text-align:right">प्रगति योग</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                             1.
                                                        </td>
                                                        <td>
                                                             विभागीय मत्स्य प्रक्षेत्रों से
                                                        </td>
                                                       <td>
                                                             लाख
                                                        </td>
                                                        <td>
                                                             
                                                        </td>
                                                        <td>
                                                             <input type="number" class="form-control disabled" value="5.0" readonly style="text-align:right"/>
                                                        </td>
                                                        <td>
                                                             <input type="number" class="form-control disabled" value="5.0" readonly style="text-align:right"/>
                                                        </td>
                                                        <td>
                                                             <input type="number" class="form-control" value="5.0" style="text-align:right"/>
                                                        </td>
                                                        <td>
                                                             <input type="number" class="form-control disabled" value="5.0" readonly style="text-align:right"/>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                                <tfoot>
                                                    <tr>
                                                         
                                                        <td colspan="4" style="text-align:right">
                                                             योग
                                                        </td>
                                                        <td>
                                                             <input type="number" class="form-control disabled" value="5.0" readonly style="text-align:right"/>
                                                        </td>
                                                        <td>
                                                             <input type="number" class="form-control disabled" value="5.0" readonly style="text-align:right"/>
                                                        </td>
                                                        <td>
                                                             <input type="number" class="form-control" style="text-align:right" value="5.0"/>
                                                        </td>
                                                        <td>
                                                             <input type="number" class="form-control disabled" value="5.0" readonly style="text-align:right"/>
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