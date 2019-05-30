<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/HOMaster.master" AutoEventWireup="true" CodeFile="Report.aspx.cs" Inherits="HeadQuarter_Report" %>

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
            $("#pnlDetail").hide();
            //Load Scheme Type on Page Load
            $.ajax({
                type: "POST",
                url: "Report.aspx/GetSchemesType",
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
        function getSchemeName() {
            var schemetypeId = $("#ddlSchemeNameType").val();
            $("#ddlSchemeName").empty();
            if (schemetypeId > 0) {
                $.ajax({
                    type: "POST",
                    url: "Report.aspx/GetSchemes",
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
        function getworkTypeBySheme() {
            var schemeId = $("#ddlSchemeName").val();
            $("[id*=ddlProgressType]").empty();
            if (schemeId > 0) {
                $.ajax({
                    type: "POST",
                    url: "Report.aspx/GetWorkType",
                    data: '{schemeID : ' + schemeId + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        var ddl = $("[id*=ddlProgressType]");
                        ddl.append($("<option selected disabled hidden></option>").val('').html('चयन करें'));
                        $.each(r.d, function () {
                            ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                        });
                        ddl.selectpicker('refresh');
                    }
                });
            }
        }

        function getworkInstallByID() {
            var schemeId = $("#ddlSchemeName").val();
            var workTypeId = $("#ddlProgressType").val();
            $("[id*=ddlWorkInstallment]").empty();
            if (schemeId > 0) {
                $.ajax({
                    type: "POST",
                    url: "Report.aspx/GetWorkIntallment",
                    data: '{schemeID : ' + schemeId + ', workTypeID : ' + workTypeId + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {

                        var ddl = $("[id*=ddlWorkInstallment]");
                        ddl.append($("<option selected disabled hidden></option>").val('').html('चयन करें'));
                        $.each(r.d, function () {
                            ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                        });
                        ddl.selectpicker('refresh');
                    }
                });
            }
        }

        function getAllForwardedByDivision() {
            var schemeKey = $('#ddlSchemeName').val();
            var progressKey = $('#ddlProgressType').val();
            var insKey = $('#ddlWorkInstallment').val();

            $('#pnlDetail').hide();
            $('#tblFirst').hide();
            $('#tblSecond').hide();
            $('#tblThird').hide();

            $('#tblFirst tbody').empty();
            $('#tblSecond tbody').empty();
            $('#tblThird tbody').empty();

            if (schemeKey > 0 && progressKey > 0 && insKey > 0) {
                //This to be change according work type and Installment Key in DB.

                if (progressKey == 1) {
                    $('#pnlDetail').show();
                    $('#tblFirst').show();
                    $('#tblSecond').hide();
                    $('#tblThird').hide();

                    $('#tblFirst tbody').empty();

                    $.ajax({
                        type: "Post",
                        contentType: "application/json; charset=utf-8",
                        url: "Report.aspx/GetForwardInstallment",
                        data: '{SchemeKey: ' + schemeKey + ', ProgressKey : ' + progressKey + ', InsKey : ' + insKey + '}',
                        dataType: "json",
                        success: function (data) {
                            var mst = $.parseJSON(data.d);
                            var id = 1;
                            var InsTotal = 0;
                            $.each(mst, function (index, value) {
                                var row = '<tr><td style="text-align: center"><b>' + id + '</b> </td>';
                                if (value.InsStatus == 31) {
                                    row = row + '<td style="text-align: center"><input type="checkbox" class="chkbox" value="' + value.DetailKey + '" /></td>'
                                } else if (value.InsStatus == 45) {
                                    row = row + '<td style="text-align: center"><input type="checkbox" class="" value="' + value.DetailKey + '" disabled /></td>'
                                }
                                row = row + '<td>' + value.DivisionName + '</td>'
                                row = row + '<td>' + value.DistrictName + '</td>'
                                row = row + '<td>' + value.TransactionKey + '</td>'
                                row = row + '<td>' + value.RegistrationCode + '</td>'
                                row = row + '<td>' + value.FarmerName + '</td>'
                                row = row + '<td>' + value.SchemeName + '</td>'
                                if (value.BeforePhoto == '') {
                                    row = row + '<td style="text-align: center"">Not Available</td>'
                                } else {
                                    row = row + '<td style="text-align: center"><a href="<%= "../../" + DBLayer.DBT_InstDistribution + "/"%>' + value.BeforePhoto + '" target="_blank" class="btn btn-xs btn-primary">View File</a></td>'
                                }
                                if (value.AfterPhoto == '') {
                                    row = row + '<td style="text-align: center"">Not Available</td>'
                                } else {
                                    row = row + '<td style="text-align: center"><a href="<%= "../../" + DBLayer.DBT_InstDistribution + "/"%>' + value.AfterPhoto + '" target="_blank" class="btn btn-xs btn-primary">View File</a></td>'
                                }
                                if (value.CompCert == '') {
                                    row = row + '<td style="text-align: center"">Not Available</td>'
                                } else {
                                    row = row + '<td style="text-align: center"><a href="<%= "../../" + DBLayer.DBT_InstDistribution + "/"%>' + value.CompCert + '" target="_blank" class="btn btn-xs btn-primary">View File</a></td>'
                                }
                                row = row + '<td style="text-align: right">' + value.InstallmentAmount.toFixed(2) + '</td>'
                                if (value.InsStatus == 31) {
                                    row = row + '<td style="text-align: center""><span class="label label-primary">Verified</span></td>'
                                } else if (value.InsStatus == 45) {
                                    row = row + '<td style="text-align: center""><span class="label label-success">Approved</span></td>'
                                }
                                row = row + '</tr>'

                                InsTotal = parseFloat(InsTotal) + parseFloat(value.InstallmentAmount);

                                id += 1;
                                $('#tblFirst tbody').append(row);
                            });
                            if (id == 1) {
                                var frow = '<tr><td colspan=13 style = "text-align:center"><b>कोई भी सूचना उपलब्ध नहीं हैं।</b></td><tr>';
                                $('#tblFirst tfoot').empty();
                                $('#tblFirst tfoot').append(frow);
                            } else {
                                var frow = '<tr><td colspan=11 style = "text-align:right"><b>कुल योग</b></td><td style="text-align: right"><b>' + InsTotal.toFixed(2) + '</b></td><td></td><tr>';
                                $('#tblFirst tfoot').empty();
                                $('#tblFirst tfoot').append(frow);
                            }
                        },

                        error: function () {
                            alert("Error while retrieving data of :" + id);
                        }
                    });



                }
                else if (progressKey == 2) {
                    $('#pnlDetail').show();
                    $('#tblFirst').hide();
                    $('#tblSecond').show();
                    $('#tblThird').hide();

                    $('#tblSecond tbody').empty();

                    $.ajax({
                        type: "Post",
                        contentType: "application/json; charset=utf-8",
                        url: "Report.aspx/GetForwardInstallment",
                        data: '{SchemeKey: ' + schemeKey + ', ProgressKey : ' + progressKey + ', InsKey : ' + insKey + '}',
                        dataType: "json",
                        success: function (data) {
                            var mst = $.parseJSON(data.d);
                            var id = 1;
                            var InsTotal = 0;
                            $.each(mst, function (index, value) {
                                var row = '<tr><td style="text-align: center"><b>' + id + '</b> </td>';
                                if (value.InsStatus == 31) {
                                    row = row + '<td style="text-align: center"><input type="checkbox" class="chkbox" value="' + value.DetailKey + '" /></td>'
                                } else if (value.InsStatus == 45) {
                                    row = row + '<td style="text-align: center"><input type="checkbox" class="" value="' + value.DetailKey + '" disabled /></td>'
                                }
                                row = row + '<td>' + value.DivisionName + '</td>'
                                row = row + '<td>' + value.DistrictName + '</td>'
                                row = row + '<td>' + value.TransactionKey + '</td>'
                                row = row + '<td>' + value.RegistrationCode + '</td>'
                                row = row + '<td>' + value.FarmerName + '</td>'
                                row = row + '<td>' + value.SchemeName + '</td>'
                                if (value.Hund_AfterPhoto == '') {
                                    row = row + '<td style="text-align: center"">Not Available</td>'
                                } else {
                                    row = row + '<td style="text-align: center"><a href="<%= "../../" + DBLayer.DBT_InstDistribution + "/"%>' + value.Hund_AfterPhoto + '" target="_blank" class="btn btn-xs btn-primary">View File</a></td>'
                                }
                                if (value.Hund_CompCert == '') {
                                    row = row + '<td style="text-align: center"">Not Available</td>'
                                } else {
                                    row = row + '<td style="text-align: center"><a href="<%= "../../" + DBLayer.DBT_InstDistribution + "/"%>' + value.Hund_CompCert + '" target="_blank" class="btn btn-xs btn-primary">View File</a></td>'
                                }
                                row = row + '<td style="text-align: right">' + value.InstallmentAmount.toFixed(2) + '</td>'
                                if (value.InsStatus == 31) {
                                    row = row + '<td style="text-align: center""><span class="label label-primary">Verified</span></td>'
                                } else if (value.InsStatus == 45) {
                                    row = row + '<td style="text-align: center""><span class="label label-success">Approved</span></td>'
                                }
                                row = row + '</tr>'

                                InsTotal = parseFloat(InsTotal) + parseFloat(value.InstallmentAmount);

                                id += 1;
                                $('#tblSecond tbody').append(row);
                            });
                            if (id == 1) {
                                var frow = '<tr><td colspan=12 style = "text-align:center"><b>कोई भी सूचना उपलब्ध नहीं हैं।</b></td><tr>';
                                $('#tblSecond tfoot').empty();
                                $('#tblSecond tfoot').append(frow);
                            } else {
                                var frow = '<tr><td colspan=10 style = "text-align:right"><b>कुल योग</b></td><td style="text-align: right"><b>' + InsTotal.toFixed(2) + '</b></td><td></td><tr>';
                                $('#tblSecond tfoot').empty();
                                $('#tblSecond tfoot').append(frow);
                            }
                        },

                        error: function () {
                            alert("Error while retrieving data of :" + id);
                        }
                    });

                }
                else if (progressKey == 3) {
                    $('#pnlDetail').show();
                    $('#tblFirst').hide();
                    $('#tblSecond').hide();
                    $('#tblThird').show();

                    $('#tblThird tbody').empty();

                    $.ajax({
                        type: "Post",
                        contentType: "application/json; charset=utf-8",
                        url: "Report.aspx/GetForwardInstallment",
                        data: '{SchemeKey: ' + schemeKey + ', ProgressKey : ' + progressKey + ', InsKey : ' + insKey + '}',
                        dataType: "json",
                        success: function (data) {
                            var mst = $.parseJSON(data.d);
                            var id = 1;
                            var InsTotal = 0;
                            $.each(mst, function (index, value) {
                                var row = '<tr><td style="text-align: center"><b>' + id + '</b> </td>';
                                if (value.InsStatus == 31) {
                                    row = row + '<td style="text-align: center"><input type="checkbox" class="chkbox" value="' + value.DetailKey + '" /></td>'
                                } else if (value.InsStatus == 45) {
                                    row = row + '<td style="text-align: center"><input type="checkbox" class="" value="' + value.DetailKey + '" disabled /></td>'
                                }

                                row = row + '<td>' + value.DivisionName + '</td>'
                                row = row + '<td>' + value.DistrictName + '</td>'
                                row = row + '<td>' + value.TransactionKey + '</td>'
                                row = row + '<td>' + value.RegistrationCode + '</td>'
                                row = row + '<td>' + value.FarmerName + '</td>'
                                row = row + '<td>' + value.SchemeName + '</td>'
                                if (value.Seed_Receipt == '') {
                                    row = row + '<td style="text-align: center"">Not Available</td>'
                                } else {
                                    row = row + '<td style="text-align: center"><a href="<%= "../../" + DBLayer.DBT_InstDistribution + "/"%>' + value.Seed_Receipt + '" target="_blank" class="btn btn-xs btn-primary">View File</a></td>'
                                }
                                if (value.Seed_Accumulation == '') {
                                    row = row + '<td style="text-align: center"">Not Available</td>'
                                } else {
                                    row = row + '<td style="text-align: center"><a href="<%= "../../" + DBLayer.DBT_InstDistribution + "/"%>' + value.Seed_Accumulation + '" target="_blank" class="btn btn-xs btn-primary">View File</a></td>'
                                }
                                if (value.Appli_Photo == '') {
                                    row = row + '<td style="text-align: center">Not Available</td>'
                                } else {
                                    row = row + '<td style="text-align: center"><a href="<%= "../../" + DBLayer.DBT_InstDistribution + "/"%>' + value.Appli_Photo + '" target="_blank" class="btn btn-xs btn-primary">View File</a></td>'
                                }
                                if (value.Dist_Cert == '') {
                                    row = row + '<td style="text-align: center"">Not Available</td>'
                                } else {
                                    row = row + '<td style="text-align: center"><a href="<%= "../../" + DBLayer.DBT_InstDistribution + "/"%>' + value.Dist_Cert + '" target="_blank" class="btn btn-xs btn-primary">View File</a></td>'
                                }
                                row = row + '<td style="text-align: right">' + value.InstallmentAmount.toFixed(2) + '</td>'

                                if (value.InsStatus == 31) {
                                    row = row + '<td style="text-align: center"><span class="label label-primary">Verified</span></td>'
                                } else if (value.InsStatus == 45) {
                                    row = row + '<td style="text-align: center"><span class="label label-success">Approved</span></td>'
                                }
                                row = row + '</tr>'

                                InsTotal = parseFloat(InsTotal) + parseFloat(value.InstallmentAmount);

                                id += 1;
                                $('#tblThird tbody').append(row);
                            });
                            if (id == 1) {
                                var frow = '<tr><td colspan=14 style = "text-align:center"><b>कोई भी सूचना उपलब्ध नहीं हैं।</b></td><tr>';
                                $('#tblThird tfoot').empty();
                                $('#tblThird tfoot').append(frow);
                            } else {
                                var frow = '<tr><td colspan=12 style = "text-align:right"><b>कुल योग</b></td><td style="text-align: right"><b>' + InsTotal.toFixed(2) + '</b></td><td></td><tr>';
                                $('#tblThird tfoot').empty();
                                $('#tblThird tfoot').append(frow);
                            }
                        },

                        error: function () {
                            alert("Error while retrieving data of :" + id);
                        }
                    });



                }
    }
    else {
        event.preventDefault();
        alert("कृपया मान्य प्रवष्टिया का चयन करें।");
    }
}

    </script>
    <%-- Update Status --%>
    <script type="text/javascript">
        function OnSubmit() {
            var appNos = [];
            var totalAmount = 0;
            var totalApp = 0;

            event.preventDefault();
            $(".chkbox:checked").each(function () {
                var appNo = $(this).val();

                appNos.push(appNo);

            });

            if (appNos.length > 0) {
                var strappNos = "";
                $.each(appNos, function (ind, val) {
                    if (strappNos != "") {
                        strappNos = strappNos + "," + val;
                    } else {
                        strappNos = val;
                    }
                });

                $.ajax({
                    type: "POST",
                    url: "Report.aspx/FinalSubmit",
                    data: '{appNos : ' + JSON.stringify(strappNos) + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        var data = $.parseJSON(r.d);
                        if (data.StatusCode) {
                            alert(data.Msg);
                            location.href = "Report.aspx";
                        }
                    },
                    error: function (e) {

                    }
                });
            }
            else {
                alert('कृपया लाभार्थियों का चयन करें।');
            }
        }


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="content-container">
        <!--Page Title-->
        <!--------------------------------------------------------->
        <div class="pageheader hidden-xs">
            <h3><i class="fa fa-home"></i>डॉक्यूमेंट वेरिफिकेशन </h3>
            <div class="breadcrumb-wrapper">
                <%-- <span class="label">You are here:</span>--%>
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">होम </a></li>
                    <li class="active">डॉक्यूमेंट वेरिफिकेशन</li>
                </ol>
            </div>
        </div>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <!--End page title-->

        <div id="page-content">
            <form id="frmRegistration" action="#" class="form-horizontal">

                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel">
                            <div class="panel-heading">
                                <h3 class="panel-title"><strong>डी० बी० टी० हेतु अनुदान वितरण गेटवे </strong></h3>
                            </div>
                            <!--No Label Form-->
                            <div class="panel-body" style="margin-top: -15px">
                                <h3 style="float: left">
                                    <asp:Label ID="lblLoginType" runat="server" Text="कानपुर"></asp:Label></h3>
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
                                <h3 class="panel-title">चयन करें  </h3>
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
                                                <label class="col-lg-4 control-label">योजना का चयन </label>
                                                <div class="col-lg-8">
                                                    <select class="form-control selectpicker" data-live-search="true" id="ddlSchemeName" onchange="getworkTypeBySheme();">
                                                    </select>
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>
                                </div>

                                <div class="row mar-top">
                                    <div class="col-lg-5">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="col-lg-4 control-label">प्रकार</label>
                                                <div class="col-lg-8">
                                                    <select class="form-control selectpicker" data-live-search="true" id="ddlProgressType" onchange="getworkInstallByID();">
                                                    </select>
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>
                                    <div class="col-lg-5">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="col-lg-4 control-label">किस्त</label>
                                                <div class="col-lg-8">
                                                    <select class="form-control selectpicker" data-live-search="true" id="ddlWorkInstallment">
                                                    </select>
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>
                                    <div class="col-lg-2">

                                        <fieldset>
                                            <button class="btn btn-warning" type="button" onclick="getAllForwardedByDivision();">खोजें</button>
                                        </fieldset>
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
                                            <%-- Table --%>
                                            <table class="table table-bordered" id="tblFirst">
                                                <colgroup>
                                                    <col width="5%" />
                                                    <col width="5%" />
                                                    <col width="8%" />
                                                    <col width="8%" />
                                                    <col width="8%" />
                                                    <col width="8%" />
                                                    <col width="8%" />
                                                    <col width="10%" />
                                                    <col width="8%" />
                                                    <col width="8%" />
                                                    <col width="8%" />
                                                    <col width="8%" />
                                                    <col width="8%" />
                                                </colgroup>
                                                <thead>
                                                    <tr>
                                                        <th style="text-align: center">क्रम स०</th>
                                                        <th style="text-align: center">#</th>
                                                        <th>मण्डल का नाम</th>
                                                        <th>जनपद का नाम</th>
                                                        <th>ट्रांजैक्सन न०</th>
                                                        <th>कृषक पंजीकरण स०</th>
                                                        <th>लाभार्थी का नाम</th>
                                                        <th>योजना का नाम</th>
                                                        <th>कार्य कराने के पूर्व के फोटोग्राफ</th>
                                                        <th>60% कार्य के सहित फोटोग्राफ</th>
                                                        <th>60% कार्य पूर्ति का प्रमाणपत्र</th>
                                                        <th class="text-right">अनुदान (रु०)</th>
                                                        <th style="text-align: center">#</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td style="text-align: center">1</td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td class="text-right">00.00</td>

                                                    </tr>
                                                </tbody>
                                                <tfoot>
                                                    <tr>
                                                        <td colspan="9" class="text-right"><strong>कुल</strong></td>
                                                        <td class="text-right"><strong>00.00</strong></td>

                                                    </tr>

                                                </tfoot>
                                            </table>

                                            <table class="table table-bordered" id="tblSecond">
                                                <colgroup>
                                                    <col width="5%" />
                                                    <col width="5%" />
                                                    <col width="8%" />
                                                    <col width="8%" />
                                                    <col width="10%" />
                                                    <col width="10%" />
                                                    <col width="10%" />
                                                    <col width="12%" />
                                                    <col width="8%" />
                                                    <col width="8%" />
                                                    <col width="8%" />
                                                    <col width="8%" />
                                                </colgroup>
                                                <thead>
                                                    <tr>
                                                        <th style="text-align: center">क्रम स०</th>
                                                        <th style="text-align: center">#</th>
                                                        <th>मण्डल का नाम</th>
                                                        <th>जनपद का नाम</th>
                                                        <th>ट्रांजैक्सन न०</th>
                                                        <th>कृषक पंजीकरण स०</th>
                                                        <th>लाभार्थी का नाम</th>
                                                        <th>योजना का नाम</th>
                                                        <th>100% कार्य पूर्ण के फोटोग्राफ निर्माणकार्य की ऍम. वी.</th>
                                                        <th>100% कार्यपूर्ति के प्रमाणपत्र</th>
                                                        <th class="text-right">अनुदान (रु०)</th>
                                                        <th style="text-align: center">#</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td style="text-align: center">1</td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td class="text-right">00.00</td>

                                                    </tr>
                                                </tbody>
                                                <tfoot>
                                                    <tr>
                                                        <td colspan="8" class="text-right"><strong>कुल</strong></td>
                                                        <td class="text-right"><strong>00.00</strong></td>

                                                    </tr>

                                                </tfoot>
                                            </table>

                                            <table class="table table-bordered" id="tblThird">
                                                <colgroup>
                                                    <col width="5%" />
                                                    <col width="5%" />
                                                    <col width="8%" />
                                                    <col width="8%" />
                                                    <col width="8%" />
                                                    <col width="8%" />
                                                    <col width="8%" />
                                                    <col width="8%" />
                                                    <col width="7%" />
                                                    <col width="7%" />
                                                    <col width="7%" />
                                                    <col width="7%" />
                                                    <col width="7%" />
                                                    <col width="7%" />
                                                </colgroup>
                                                <thead>
                                                    <tr>
                                                        <th style="text-align: center">क्रम स०</th>
                                                        <th>#</th>
                                                        <th>मण्डल का नाम</th>
                                                        <th>जनपद का नाम</th>
                                                        <th>ट्रांजैक्सन न०</th>
                                                        <th>कृषक पंजीकरण स०</th>
                                                        <th>लाभार्थी का नाम</th>
                                                        <th>योजना का नाम</th>
                                                        <th>मत्स्य बीज क्रय रसीद</th>
                                                        <th>मत्स्य बीज संचय के फोटोग्राफ</th>
                                                        <th>मत्स्य आहार के साथ लाभार्थी के फोटोग्राफ</th>
                                                        <th>जनपदीय अधिकारी की सत्यापन रिपोर्ट</th>
                                                        <th class="text-right">अनुदान (रु०)</th>
                                                        <th style="text-align: center">#</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td style="text-align: center">1</td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td class="text-right">00.00</td>

                                                    </tr>
                                                </tbody>
                                                <tfoot>
                                                    <tr>
                                                        <td colspan="10" class="text-right"><strong>कुल</strong></td>
                                                        <td class="text-right"><strong>00.00</strong></td>

                                                    </tr>

                                                </tfoot>
                                            </table>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div class="panel-footer">
                                <button class="btn btn-info" type="button" id="btnSubmit" onclick="OnSubmit()">सुरक्षित करें</button>
                                &nbsp;&nbsp;&nbsp;
                                 <button class="btn btn-warning" type="button">निरस्त करें</button>
                            </div>

                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</asp:Content>
