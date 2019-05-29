<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DivisionMaster.master" AutoEventWireup="true" CodeFile="frmDocumentVerification.aspx.cs" Inherits="Division_frmDocumentVerification" %>

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
            
            $.ajax({
                type: "POST",
                url: "frmDocumentVerification.aspx/GetSchemesType",
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
                    url: "frmDocumentVerification.aspx/GetSchemes",
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
                    url: "frmDocumentVerification.aspx/GetWorkType",
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
                    url: "frmDocumentVerification.aspx/GetWorkIntallment",
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
            alert('k');
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

                if (insKey == 1 || insKey == 4) {
                    $('#pnlDetail').show();
                    $('#tblFirst').show();
                    $('#tblSecond').hide();
                    $('#tblThird').hide();

                    $('#tblFirst tbody').empty();

                    $.ajax({
                        type: "Post",
                        contentType: "application/json; charset=utf-8",
                        url: "frmDocumentVerification.aspx/GetForwardInstallment",
                        data: '{SchemeKey: ' + schemeKey + ', ProgressKey : ' + progressKey + ', InsKey : ' + insKey + '}',
                        dataType: "json",
                        success: function (data) {
                            var mst = $.parseJSON(data.d);
                            var id = 1;
                            var InsTotal = 0;
                            $.each(mst, function (index, value) {
                                var row = '<tr><td style="text-align: center"><b>' + id + '</b> </td>';
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

                                row = row + '<td style="text-align: center"> <div class="btn-group btn-group-xs">'
                                row = row + '<a href="#" class="btn btn-xs btn-primary btn-icon icon-lg fa fa-check approved" data-id="' + value.DetailKey + '" data-placement="top" data-original-title="सत्यापित करें"></a>'
                                row = row + '<a href="#" class="btn btn-xs btn-danger btn-icon icon-lg fa fa-times  disapproved" data-id="' + value.DetailKey + '" data-placement="top" data-original-title="निरस्त करें"></a> '
                                row = row + '</div></td>'

                                row = row + '</tr>'

                                InsTotal = parseFloat(InsTotal) + parseFloat(value.InstallmentAmount);

                                id += 1;
                                $('#tblFirst tbody').append(row);
                            });
                            if (id == 1) {
                                var frow = '<tr><td colspan=11 style = "text-align:center"><b>कोई भी सूचना उपलब्ध नहीं हैं।</b></td><tr>';
                                $('#tblFirst tfoot').empty();
                                $('#tblFirst tfoot').append(frow);
                            } else {
                                var frow = '<tr><td colspan=9 style = "text-align:right"><b>कुल योग</b></td><td style="text-align: right"><b>' + InsTotal.toFixed(2) + '</b></td><td></td><tr>';
                                $('#tblFirst tfoot').empty();
                                $('#tblFirst tfoot').append(frow);
                            }
                        },

                        error: function () {
                            alert("Error while retrieving data of :" + id);
                        }
                    });
                }
                else if (insKey == 2 || insKey == 5) {
                    $('#pnlDetail').show();
                    $('#tblFirst').hide();
                    $('#tblSecond').show();
                    $('#tblThird').hide();

                    $('#tblSecond tbody').empty();

                    $.ajax({
                        type: "Post",
                        contentType: "application/json; charset=utf-8",
                        url: "frmDocumentVerification.aspx/GetForwardInstallment",
                        data: '{SchemeKey: ' + schemeKey + ', ProgressKey : ' + progressKey + ', InsKey : ' + insKey + '}',
                        dataType: "json",
                        success: function (data) {
                            var mst = $.parseJSON(data.d);
                            var id = 1;
                            var InsTotal = 0;
                            $.each(mst, function (index, value) {
                                var row = '<tr><td style="text-align: center"><b>' + id + '</b> </td>';
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

                                row = row + '<td style="text-align: center"> <div class="btn-group btn-group-xs">'
                                row = row + '<a href="#" class="btn btn-xs btn-primary btn-icon icon-lg fa fa-check approved" data-id="' + value.DetailKey + '" data-placement="top" data-original-title="सत्यापित करें"></a>'
                                row = row + '<a href="#" class="btn btn-xs btn-danger btn-icon icon-lg fa fa-times  disapproved" data-id="' + value.DetailKey + '" data-placement="top" data-original-title="निरस्त करें"></a> '
                                row = row + '</div></td>'

                                row = row + '</tr>'

                                InsTotal = parseFloat(InsTotal) + parseFloat(value.InstallmentAmount);

                                id += 1;
                                $('#tblSecond tbody').append(row);
                            });
                            if (id == 1) {
                                var frow = '<tr><td colspan=10 style = "text-align:center"><b>कोई भी सूचना उपलब्ध नहीं हैं।</b></td><tr>';
                                $('#tblSecond tfoot').empty();
                                $('#tblSecond tfoot').append(frow);
                            } else {
                                var frow = '<tr><td colspan=8 style = "text-align:right"><b>कुल योग</b></td><td style="text-align: right"><b>' + InsTotal.toFixed(2) + '</b></td><td></td><tr>';
                                $('#tblSecond tfoot').empty();
                                $('#tblSecond tfoot').append(frow);
                            }
                        },

                        error: function () {
                            alert("Error while retrieving data of :" + id);
                        }
                    });

                }
                else if (insKey == 3 || insKey == 6) {
                    $('#pnlDetail').show();
                    $('#tblFirst').hide();
                    $('#tblSecond').hide();
                    $('#tblThird').show();

                    $('#tblThird tbody').empty();

                    $.ajax({
                        type: "Post",
                        contentType: "application/json; charset=utf-8",
                        url: "frmDocumentVerification.aspx/GetForwardInstallment",
                        data: '{SchemeKey: ' + schemeKey + ', ProgressKey : ' + progressKey + ', InsKey : ' + insKey + '}',
                        dataType: "json",
                        success: function (data) {
                            var mst = $.parseJSON(data.d);
                            var id = 1;
                            var InsTotal = 0;
                            $.each(mst, function (index, value) {
                                var row = '<tr><td style="text-align: center"><b>' + id + '</b> </td>';
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
                                    row = row + '<td style="text-align: center"">Not Available</td>'
                                } else {
                                    row = row + '<td style="text-align: center"><a href="<%= "../../" + DBLayer.DBT_InstDistribution + "/"%>' + value.Appli_Photo + '" target="_blank" class="btn btn-xs btn-primary">View File</a></td>'
                                }
                                if (value.Dist_Cert == '') {
                                    row = row + '<td style="text-align: center"">Not Available</td>'
                                } else {
                                    row = row + '<td style="text-align: center"><a href="<%= "../../" + DBLayer.DBT_InstDistribution + "/"%>' + value.Dist_Cert + '" target="_blank" class="btn btn-xs btn-primary">View File</a></td>'
                                }
                                row = row + '<td style="text-align: right">' + value.InstallmentAmount.toFixed(2) + '</td>'

                                row = row + '<td style="text-align: center"> <div class="btn-group btn-group-xs">'
                                row = row + '<a href="#" class="btn btn-xs btn-primary btn-icon icon-lg fa fa-check approved" data-id="' + value.DetailKey + '" data-placement="top" data-original-title="सत्यापित करें"></a>'
                                row = row + '<a href="#" class="btn btn-xs btn-danger btn-icon icon-lg fa fa-times  disapproved" data-id="' + value.DetailKey + '" data-placement="top" data-original-title="निरस्त करें"></a> '

                                row = row + '</div></td>'
                                row = row + '</tr>'

                                InsTotal = parseFloat(InsTotal) + parseFloat(value.InstallmentAmount);

                                id += 1;
                                $('#tblThird tbody').append(row);
                            });
                            if (id == 1) {
                                var frow = '<tr><td colspan=12 style = "text-align:center"><b>कोई भी सूचना उपलब्ध नहीं हैं।</b></td><tr>';
                                $('#tblThird tfoot').empty();
                                $('#tblThird tfoot').append(frow);
                            } else {
                                var frow = '<tr><td colspan=10 style = "text-align:right"><b>कुल योग</b></td><td style="text-align: right"><b>' + InsTotal.toFixed(2) + '</b></td><td></td><tr>';
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

    <%-- Update Document Status --%>
    <script type="text/javascript">
        $(document).ready(function () {
            $(document).on("click", ".approved", function () {
                var id = $(this).attr("data-id");

                if (confirm("क्या आप सत्यापित करना चाहते हैं?")) {
                    $.ajax({
                        type: "Post",
                        contentType: "application/json; charset=utf-8",
                        url: "frmDocumentVerification.aspx/ApproveDocument",
                        data: '{DetailID: ' + id + ', IsApporved : 1}',
                        dataType: "json",
                        success: function (response) {
                            data = (response.d);
                            if (data != "") {
                                alert(data)
                                window.location.reload();
                            }
                            else {
                                alert("कृपया पुनः प्रयास करें।")
                            }
                        }
                    });
                }
                return false;
            });

            $(document).on("click", ".disapproved", function () {
                var id = $(this).attr("data-id");

                if (confirm("क्या आप निरस्त करना चाहते हैं?")) {
                    $.ajax({
                        type: "Post",
                        contentType: "application/json; charset=utf-8",
                        url: "frmDocumentVerification.aspx/ApproveDocument",
                        data: '{DetailID: ' + id + ', IsApporved : 0}',
                        dataType: "json",
                        success: function (response) {
                            data = (response.d);
                            if (data != "") {
                                alert(data)
                                window.location.reload();
                            }
                            else {
                                alert("कृपया पुनः प्रयास करें।")
                            }
                        }
                    });
                }
                return false;
            });

        });


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
            <div id="frmRegistration"  class="form-horizontal">

                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel">
                            <div class="panel-heading">
                                <h3 class="panel-title"><strong>डी० बी० टी० हेतु अनुदान वितरण गेटवे </strong></h3>
                            </div>
                            <!--No Label Form-->
                            <div class="panel-body" style="margin-top: -15px">
                                <h3 style="float: left">मण्डल :
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
                                                    <col width="8%" />
                                                    <col width="10%" />
                                                    <col width="10%" />
                                                    <col width="10%" />
                                                    <col width="10%" />
                                                    <col width="9%" />
                                                    <col width="9%" />
                                                    <col width="9%" />
                                                    <col width="7%" />
                                                    <col width="8%" />
                                                </colgroup>
                                                <thead>
                                                    <tr>
                                                        <th style="text-align: center">क्रम स०</th>
                                                        <th>जनपद का नाम</th>
                                                        <th>ट्रांजैक्सन न०</th>
                                                        <th>कृषक पंजीकरण स०</th>
                                                        <th>लाभार्थी का नाम</th>
                                                        <th>योजना का नाम</th>
                                                        <th>कार्य कराने के पूर्व के फोटोग्राफ</th>
                                                        <th>60% कार्य के सहित फोटोग्राफ</th>
                                                        <th>60% कार्य पूर्ति का प्रमाणपत्र</th>
                                                        <th class="text-right">अनुदान (रु०)</th>
                                                        <th class="text-center">#</th>
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
                                                    <col width="8%" />
                                                    <col width="10%" />
                                                    <col width="10%" />
                                                    <col width="12%" />
                                                    <col width="15%" />
                                                    <col width="8%" />
                                                    <col width="8%" />
                                                    <col width="8%" />
                                                    <col width="8%" />
                                                </colgroup>
                                                <thead>
                                                    <tr>
                                                        <th style="text-align: center">क्रम स०</th>
                                                        <th>जनपद का नाम</th>
                                                        <th>ट्रांजैक्सन न०</th>
                                                        <th>कृषक पंजीकरण स०</th>
                                                        <th>लाभार्थी का नाम</th>
                                                        <th>योजना का नाम</th>
                                                        <th>100% कार्य पूर्ण के फोटोग्राफ निर्माणकार्य की ऍम. वी.</th>
                                                        <th>100% कार्यपूर्ति के प्रमाणपत्र</th>
                                                        <th class="text-right">अनुदान (रु०)</th>
                                                        <th class="text-center">#</th>
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
                                                    <col width="8%" />
                                                    <col width="10%" />
                                                    <col width="10%" />
                                                    <col width="10%" />
                                                    <col width="8%" />
                                                    <col width="8%" />
                                                    <col width="7%" />
                                                    <col width="7%" />
                                                    <col width="7%" />
                                                    <col width="7%" />
                                                    <col width="8%" />
                                                </colgroup>
                                                <thead>
                                                    <tr>
                                                        <th style="text-align: center">क्रम स०</th>
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
                                                        <th class="text-center">#</th>
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
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

