<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DistrictMaster.master" AutoEventWireup="true" CodeFile="frmPondDetails.aspx.cs" Inherits="MPR_frmPondDetails" %>

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
                url: "frmPondDetails.aspx/GetMonthName",
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
        });
        
    </script>
    <script type="text/javascript">

        function getMSR_ForMonth() {
            var monthKey = $('#ddlMonthName').val();
            if (monthKey > 0) {
                $.ajax({
                    type: "Post",
                    contentType: "application/json; charset=utf-8",
                    url: "frmPondDetails.aspx/GetPondAuctionList",
                    data: '{MonthId: ' + monthKey + '}',
                    dataType: "json",
                    success: function (data) {
                        var mst = $.parseJSON(data.d);
                        var id = 1;
                        var ttlTotal = 0;
                        $('#tblPondMaster tbody').empty();
                        $.each(mst, function (index, value) {
                            $('#pnlDetail').show();
                            var objPondAuctDetail = {};

                            objPondAuctDetail.PondAuctionKey = value.PondAuctionKey;
                            objPondAuctDetail.PondId = value.PondKey;

                            objPondAuctDetail.PayableAmount = 0;
                            objPondAuctDetail.DepositAmount = value.DepositAmount;

                            objPondAuctDetail.TotalAmount = value.DepositAmount;
                            objPondAuctDetail.Remark = "";
                            objPondAuctDetail.LastYearPayableAmount = value.LastYearPayableAmount;

                            objPondAuctDetail.LastYearDepositAmount = value.LastYearDepositAmount;

                            objPondAuctArr.push(objPondAuctDetail);

                            var row = '<tr><td style="text-align: center"><b>' + id + '</b><input id="tbl_hd_' + id + '" type="hidden" value="' + value.PondKey + ' id="tbl_nm_pond_' + id + '"/> </td>';
                            row = row + '<td><label name="pondname" class="label-control">' + value.PondName + '</label></td>'
                            row = row + '<td><input type="text" name="lastyearpayable" class="form-control" readonly="readonly" value="' + parseFloat(value.LastYearPayableAmount).toFixed(2) + '" style="text-align: right" id="tbl_nm_lpa_' + id + '" /></td>'
                            row = row + '<td><input type="text" name="lastyeardeposit" class="form-control" readonly="readonly" value="' + parseFloat(value.LastYearDepositAmount).toFixed(2) + '" style="text-align: right" id="tbl_nm_lda_' + id + '" /></td>'
                            row = row + '<td><input type="number" name="monthdeposit" class="form-control" step="0.01" min="0.00" value="0.0" style="text-align: right" onchange="onNM_RecAmt(this);" id="tbl_nm_rec_' + id + '" /></td>'
                            row = row + '<td><input type="text" name="monthpayable" class="form-control" readonly="readonly" value="' + parseFloat(value.DepositAmount).toFixed(2) + '" style="text-align: right" id="tbl_nm_dep_' + id + '" /></td>'
                            row = row + '<td><input type="text" name="totalamount" class="form-control" readonly="readonly" value="' + parseFloat(value.DepositAmount).toFixed(2) + '" style="text-align: right" id="tbl_nm_tot_' + id + '" />'
                            row = row + '<td><input type="text" name="remarks" class="form-control" value="--" /></td>'
                            row = row + '</tr>'

                            ttlTotal = parseFloat(ttlTotal) + parseFloat(value.DepositAmount);

                            id += 1;
                            $('#tblPondMaster tbody').append(row);
                        });
                        //if (r.StatusCode == "200") {
                        //    alert(r.Msg);
                        //    return;
                        //}
                        //else if (r.StatusCode == "208") {
                        //    alert(r.Msg);
                        //    return;
                        //}
                        //else {
                            
                            //if (id == 1) {
                            //    var frow = '<tr><td colspan=8 style = "text-align:center"><b>कोई भी सूचना उपलब्ध नहीं हैं।</b></td><tr>';
                        //    $('#tblPondMaster tfoot').empty();
                        //    $('#tblPondMaster tfoot').append(frow);
                            //} else {
                            //    var frow = '<tr><td colspan=4 style = "text-align:right"><b>कुल योग</b></td>';
                            //    frow = frow + ' <td style="text-align: right"><input type="number" class="form-control disabled" value="' + ttlYear.toFixed(2) + '" readonly style="text-align:right"/></td>';
                            //    frow = frow + ' <td style="text-align: right"><input type="number" class="form-control disabled" value="' + ttlPrev.toFixed(2) + '" readonly style="text-align:right"/></td>';
                            //    frow = frow + ' <td style="text-align: right"><input type="number" class="form-control disabled" value="' + ttlCur.toFixed(2) + '" readonly style="text-align:right"/></td>';
                            //    frow = frow + ' <td style="text-align: right"><input type="number" class="form-control disabled" value="' + ttlTotal.toFixed(2) + '" readonly style="text-align:right"/></td>';
                            //    frow = frow + '<tr>';
                        //    $('#tblPondMaster tfoot').empty();
                        //    $('#tblPondMaster tfoot').append(frow);
                            //}
                        },
                        error: function () {
                        alert("Error while retrieving data.");
                    }
                });
            }
        }

        function onMonthChange() {

            objMstArr = [];
            $('#tblPondMaster tbody').empty();
            $('#tblPondMaster tfoot').empty();
            var frow = '<tr><td colspan=8 style = "text-align:center"><b>कोई भी सूचना उपलब्ध नहीं हैं।</b></td><tr>';
            $('#tblPondMaster tfoot').append(frow);
        }

        function onNM_RecAmt(contr) {
            var recAmt = $('#' + contr.id).val();
            var splIds = contr.id.split('_');
            var cId = splIds[splIds.length - 1];

            var prevAmt = $('#tbl_nm_dep_' + cId).val();
            var pondid = $('#tbl_nm_pond_' + cId).val();

            var obj = objPondAuctArr.filter(function (m) { return m.PondKey == pondid })[0];
            obj.DepositAmount = parseFloat(recAmt);
            obj.TotalAmount = parseFloat(prevAmt) + parseFloat(recAmt);

            $('#tbl_nm_tot_' + cId).val(obj.TotalAmount.toFixed(2));

            //setTotalAmount();
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
            $('#tblPondMaster tfoot').empty();
            $('#tblPondMaster tfoot').append(frow);
        }

    </script>

    <%--For Insert/Update Record --%>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnSubmit").click(function () {
                var MonthId = $('#ddlMonthName').val();
                if (objPondAuctArr.length > 0 && MonthId > 0) {
                    
                    objPondAuctMst.MonthKey = MonthId;
                    objPondAuctMst.Auctions = objPondAuctArr;
                    $.ajax({
                        type: "POST",
                        url: "frmPondDetails.aspx/Create",
                        data: '{objPondAuctionMaster: ' + JSON.stringify(objPondAuctMst) + '}',
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
            <h3><i class="fa fa-home"></i>नीलाम जलाशयों का विवरण </h3>
            <div class="breadcrumb-wrapper">
                <%-- <span class="label">You are here:</span>--%>
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">होम </a></li>
                    <li class="active">नीलाम जलाशयों का विवरण </li>
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
                                <h3 class="panel-title"><strong>नीलाम जलाशयों का विवरण</strong></h3>
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
                                                    <select class="form-control selectpicker" id="ddlMonthName" onchange="onMonthChange();">
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
                                            <table class="table table-bordered table-responsive" id="tblPondMaster">
                                                <colgroup>
                                                    <col width="5%" />
                                                    <col width="15%" />
                                                    <%-- <col width="10%" />
                                                    <col width="10%" />--%>
                                                    <col width="12%" />
                                                    <col width="12%" />
                                                    <col width="12%" />
                                                    <col width="12%" />
                                                    <col width="12%" />
                                                    <col width="20%" />
                                                </colgroup>
                                                <thead>
                                                    <tr>
                                                        <th style="text-align: center">क्रम स०</th>
                                                        <th>जो जलाशय नीलाम किये गए हैं उनका नाम</th>
                                                        <%-- <th >नीलाम किये गए जलाशय का क्षेत्रफल (हे०)</th>
                                                        <th >नीलाम होने वाले जलाशय का न्यूनतम मूल्य</th>--%>
                                                        <th>विगत वर्ष तक देय धनराशी</th>
                                                        <th>विगत वर्ष तक जमा धनराशी</th>
                                                        <th>इस वर्ष के माह तक देय कुल धनराशी</th>
                                                        <th>इस वर्ष के माह तक जमा हुई कुल धनराशी</th>
                                                        <th>कुल योग</th>
                                                        <th>अन्तर का विवरण</th>
                                                    </tr>

                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td style="text-align: center">1.
                                                        </td>
                                                        <td>
                                                            <label name="pondname" class="label-control"></label>
                                                        </td>

                                                        <td>
                                                            
                                                        </td>
                                                        <td>
                                                            <input type="text" name="lastyeardeposit" class="form-control" readonly="readonly" value="0.0" style="text-align: right" />
                                                        </td>
                                                        <td>
                                                            <input type="text" name="monthpayable" class="form-control" value="0.0" style="text-align: right" />
                                                        </td>
                                                        <td>
                                                            <input type="text" name="monthdeposit" class="form-control" value="0.0" style="text-align: right" />
                                                        </td>
                                                        <td>
                                                            <input type="text" name="totalamount" class="form-control" readonly="readonly" value="0.0" style="text-align: right" />
                                                        </td>
                                                        <td>
                                                            <input type="text" name="remarks" class="form-control" value="--" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="text-align: center">2.
                                                        </td>
                                                        <td>
                                                            <label name="pondname" class="label-control"></label>
                                                        </td>

                                                        <td>
                                                            <input type="text" name="lastyearpayable" class="form-control" readonly="readonly" value="0.0" />
                                                        </td>
                                                        <td>
                                                            <input type="text" name="lastyeardeposit" class="form-control" readonly="readonly" value="0.0" style="text-align: right" />
                                                        </td>
                                                        <td>
                                                            <input type="text" name="monthpayable" class="form-control" value="0.0" style="text-align: right" />
                                                        </td>
                                                        <td>
                                                            <input type="text" name="monthdeposit" class="form-control" value="0.0" style="text-align: right" />
                                                        </td>
                                                        <td>
                                                            <input type="text" name="totalamount" class="form-control" readonly="readonly" value="0.0" style="text-align: right" />
                                                        </td>
                                                        <td>
                                                            <input type="text" name="remarks" class="form-control" value="--" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="text-align: center">3.
                                                        </td>
                                                        <td>
                                                            <label name="pondname" class="label-control"></label>
                                                        </td>

                                                        <td>
                                                            <input type="text" name="lastyearpayable" class="form-control" readonly="readonly" value="0.0" />
                                                        </td>
                                                        <td>
                                                            <input type="text" name="lastyeardeposit" class="form-control" readonly="readonly" value="0.0" style="text-align: right" />
                                                        </td>
                                                        <td>
                                                            <input type="text" name="monthpayable" class="form-control" value="0.0" style="text-align: right" />
                                                        </td>
                                                        <td>
                                                            <input type="text" name="monthdeposit" class="form-control" value="0.0" style="text-align: right" />
                                                        </td>
                                                        <td>
                                                            <input type="text" name="totalamount" class="form-control" readonly="readonly" value="0.0" style="text-align: right" />
                                                        </td>
                                                        <td>
                                                            <input type="text" name="remarks" class="form-control" value="--" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="text-align: center">4.
                                                        </td>
                                                        <td>
                                                            <label name="pondname" class="label-control"></label>
                                                        </td>

                                                        <td>
                                                            <input type="text" name="lastyearpayable" class="form-control" readonly="readonly" value="0.0" />
                                                        </td>
                                                        <td>
                                                            <input type="text" name="lastyeardeposit" class="form-control" readonly="readonly" value="0.0" style="text-align: right" />
                                                        </td>
                                                        <td>
                                                            <input type="text" name="monthpayable" class="form-control" value="0.0" style="text-align: right" />
                                                        </td>
                                                        <td>
                                                            <input type="text" name="monthdeposit" class="form-control" value="0.0" style="text-align: right" />
                                                        </td>
                                                        <td>
                                                            <input type="text" name="totalamount" class="form-control" readonly="readonly" value="0.0" style="text-align: right" />
                                                        </td>
                                                        <td>
                                                            <input type="text" name="remarks" class="form-control" value="--" />
                                                        </td>
                                                    </tr>

                                                </tbody>

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

