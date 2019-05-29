<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DistrictMaster.master" AutoEventWireup="true" CodeFile="frm_BillForwarding.aspx.cs" Inherits="District_frm_BillForwarding" %>

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
        $(document).ready(function () {
            $('#ddlSchemeName').prop('disabled', false);
            $('#pnlDetail').hide();
            //Load Scheme Type on Page Load
            $.ajax({
                type: "POST",
                url: "frm_BillForwarding.aspx/GetSchemesType",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var ddlType = $("#ddlSchemeNameType");
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
        function getSchemeName() {
            var schemetypeId = $("#ddlSchemeNameType").val();
            $("#ddlSchemeName").empty();
            if (schemetypeId > 0) {
                $.ajax({
                    type: "POST",
                    url: "frm_BillForwarding.aspx/GetSchemes",
                    data: '{key : ' + schemetypeId + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        var ddl = $("#ddlSchemeName");
                        ddl.append($("<option selected disabled hidden></option>").val('').html('चयन करें'));
                        $.each(r.d, function () {
                            ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                        });
                        ddl.selectpicker('refresh');
                    }
                });
            }
        }

        function getIsForwarded() {
            var schemeKey = $('#ddlSchemeName').val();
            if (schemeKey > 0) {
                $('#pnlDetail').show();
                $('#tblIsForwarded tbody').empty();
                $.ajax({
                    type: "Post",
                    contentType: "application/json; charset=utf-8",
                    url: "frm_BillForwarding.aspx/GetIsForwardInstallment",
                    data: '{SchemeKey: ' + schemeKey + '}',
                    dataType: "json",
                    success: function (data) {
                        var mst = $.parseJSON(data.d);
                        var id = 1;
                        var InsTotal = 0;
                        $.each(mst, function (index, value) {
                            var row = '<tr><td style="text-align: center"><b>' + id + '</b><input type="hidden" value="' + value.RegistrationKey + '"/> </td>';
                            row = row + '<td style="text-align:center" ><input type="checkbox" id="' + value.DetailKey + '"/></td>'
                            row = row + '<td>' + value.TransactionKey + '</td>'
                            row = row + '<td>' + value.RegistrationCode + '</td>'
                            row = row + '<td>' + value.FarmerName + '</td>'
                            //row = row + '<td>' + value.WorkTypeName + '</td>'
                            //row = row + '<td>' + value.InstallmentNo + '</td>'
                            row = row + '<td style="text-align: right">' + value.InstallmentAmount.toFixed(2) + '</td>'
                            row = row + '</tr>'

                            InsTotal = parseFloat(InsTotal) + parseFloat(value.InstallmentAmount);

                            id += 1;
                            $('#tblIsForwarded tbody').append(row);
                        });
                        if (id == 1) {
                            var frow = '<tr><td colspan=6 style = "text-align:center"><b>कोई भी सूचना उपलब्ध नहीं हैं।</b></td><tr>';
                            $('#tblIsForwarded tfoot').empty();
                            $('#tblIsForwarded tfoot').append(frow);
                        } else {
                            var frow = '<tr><td colspan=5 style = "text-align:right"><b>कुल योग</b></td><td style="text-align: right"><b>' + InsTotal.toFixed(2) + '</b></td><tr>';
                            $('#tblIsForwarded tfoot').empty();
                            $('#tblIsForwarded tfoot').append(frow);
                        }
                    },

                    error: function () {
                        alert("Error while retrieving data of :" + id);
                    }
                });
            }
        }

    </script>

    <%--For Insert/Update Record --%>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnSubmit").click(function () {
                var appInsMst = {};
                var appInsDets = [];
                var TotalBilled = 0;
                var ap = 0;
                var hdDistrictkey = $('#ContentPlaceHolder1_hidDistrictKey').val();
                $('#tblIsForwarded tbody').find('tr').each(function (i, el) {
                    var tds = $(this).find('td');
                    var tno = $(this).find("td").eq(2).html();
                    var rno = $(this).find("td").eq(3).html();
                    var apname = $(this).find("td").eq(4).html();
                    var tb = $(this).find("td").eq(5).html();
                    var regkey = $(this).find("td").eq(0).find('input[type=hidden]').val();

                    var appInsDet = {};
                    var chk = tds[i + 1].children[0];
                    if (chk.checked == true) {
                        TotalBilled = TotalBilled + tb;
                        appInsDet.DetailKey = chk.id;
                        appInsDet.TotalBilledAmount = tb;
                        appInsDet.RegistrationNo = rno;
                        appInsDet.TransactionKey = tno;
                        appInsDet.RegistrationKey = regkey;
                        appInsDet.ApplicantName = apname;
                        appInsDet.BillAmount = tb;
                        appInsDets.push(appInsDet);
                        ap = ap + 1;
                    }
                });

                if (appInsDets.length > 0 && $('#ddlSchemeName').val() > 0) {
                    appInsMst.Installments = appInsDets;
                    appInsMst.TotalBilledAmount = TotalBilled;
                    appInsMst.SchemeKey = $('#ddlSchemeName').val();
                    appInsMst.DistrictKey = hdDistrictkey;
                    appInsMst.TotalApplicant = ap;

                    $.ajax({
                        type: "POST",
                        url: "frm_BillForwarding.aspx/BillForward",
                        data: '{objDBT_InsDistributionMaster: ' + JSON.stringify(appInsMst) + '}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            data = (response.d);
                            if (data != "") {
                                alert(data);
                                clearTextBox();
                            }
                            else
                                alert('Something Went Wrong.')
                        },
                        error: function (err) {
                            alert(err.statusText)
                        }
                    });
                }
                else {
                    event.preventDefault();
                    alert('Please select installment for forward.');
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
            <h3><i class="fa fa-home"></i>बिल आगे बढ़ाए  </h3>
            <div class="breadcrumb-wrapper">
                <%-- <span class="label">You are here:</span>--%>
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">होम </a></li>
                    <li class="active">बिल आगे बढ़ाए  </li>
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
                                <h3 class="panel-title"><strong>डी० बी० टी० हेतु अनुदान वितरण गेटवे </strong></h3>
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
                            <div class="panel-heading">
                                <h3 class="panel-title">योजना का चयन करें  </h3>
                            </div>
                            <!--No Label Form-->
                            <div class="panel-body">
                                <!-- Inline Form  -->
                                <!--===================================================-->
                                <div class="row mar-top">
                                    <div class="col-lg-5">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="col-lg-4 control-label">योजना का प्रकार </label>
                                                <div class="col-lg-8">
                                                    <select class="form-control selectpicker" data-live-search="true" id="ddlSchemeNameType" onchange="getSchemeName();">
                                                    </select>
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>
                                    <div class="col-lg-5">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="col-lg-4 control-label">योजना का चयन</label>
                                                <div class="col-lg-8">
                                                    <select class="form-control selectpicker" data-live-search="true" id="ddlSchemeName">
                                                    </select>
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>
                                    <div class="col-lg-2">
                                        <button class="btn btn-warning align-right" type="button" onclick="getIsForwarded();">खोजें</button>
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
                                                    <col width="5%" />
                                                    <col width="20%" />
                                                    <col width="20%" />
                                                    <col width="35%" />
                                                    <col width="15%" />

                                                </colgroup>
                                                <thead>
                                                    <tr>
                                                        <th style="text-align: center">क्रम स०</th>
                                                        <th style="text-align: center">#</th>
                                                        <th>ट्रांजेक्संन स०</th>
                                                        <th>कृषक पंजीकरण स०</th>
                                                        <th>लाभार्थी का नाम</th>
                                                        <th style="text-align: right">अनुदान (रु०)</th>
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

