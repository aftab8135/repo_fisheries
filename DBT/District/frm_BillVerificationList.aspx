<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DistrictMaster.master" AutoEventWireup="true" CodeFile="frm_BillVerificationList.aspx.cs" Inherits="District_frm_BillVerificationList" %>

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
            $('#tblIsForwarded tbody').empty();
            $.ajax({
                type: "Post",
                contentType: "application/json; charset=utf-8",
                url: "frm_BillVerificationList.aspx/GetIsForwardInstallment",
                data: '{}',
                dataType: "json",
                success: function (data) {
                    var mst = $.parseJSON(data.d);
                    var id = 1;
                    var InsTotal = 0;
                    $.each(mst, function (index, value) {
                        var row = '<tr><td style="text-align: center"><b>' + id + '</b> </td>';
                        row = row + '<td>' + value.TransactionKey + '</td>'
                        row = row + '<td>' + value.RegistrationCode + '</td>'
                        row = row + '<td>' + value.FarmerName + '</td>'
                        row = row + '<td>' + value.SchemeName + '</td>'
                        //row = row + '<td>' + value.WorkTypeName + '</td>'
                        //row = row + '<td>' + value.InstallmentNo + '</td>'
                        row = row + '<td style="text-align: right">' + value.InstallmentAmount.toFixed(2) + '</td>'
                        if (value.InsStatus == 28) {
                            row = row + '<td style="text-align: center"><div class="label label-table label-warning">Pending</div></td>';
                        } else if (value.InsStatus == 31) {
                            row = row + '<td style="text-align: center"><div class="label label-table label-primary">Verified</div></td>';
                        } else if (value.InsStatus == 32) {
                            row = row + '<td style="text-align: center"><div class="label label-table label-danger">Disapproved</div></td>';
                        } else if (value.InsStatus == 45) {
                            row = row + '<td style="text-align: center"><div class="label label-table label-success">Approved</div></td>';
                        } else {
                            row = row + '<td></td>';
                        }

                        row = row + '</tr>'

                        InsTotal = parseFloat(InsTotal) + parseFloat(value.InstallmentAmount);

                        id += 1;
                        $('#tblIsForwarded tbody').append(row);
                    });
                    if (id == 1) {
                        var frow = '<tr><td colspan=7 style = "text-align:center"><b>कोई भी सूचना उपलब्ध नहीं हैं।</b></td><tr>';
                        $('#tblIsForwarded tfoot').empty();
                        $('#tblIsForwarded tfoot').append(frow);
                    }
                    else {
                        var frow = '<tr><td colspan=5 style = "text-align:right"><b>कुल योग</b></td><td colspan=1 style="text-align: right"><b>' + InsTotal.toFixed(2) + '</b></td><td></td><tr>';
                        $('#tblIsForwarded tfoot').empty();
                        $('#tblIsForwarded tfoot').append(frow);
                    }
                   
                },

                error: function () {
                    alert("Error while retrieving data of :" + id);
                }
            });
        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="content-container">
        <!--Page Title-->
        <!--------------------------------------------------------->
        <div class="pageheader hidden-xs">
            <h3><i class="fa fa-home"></i>सत्यापन हेतु भेजे गए बिल </h3>
            <div class="breadcrumb-wrapper">
                <%--  <span class="label">You are here:</span>--%>
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">होम </a></li>
                    <li class="active">सत्यापन हेतु भेजे गए बिल </li>
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
                                <h3 style="float: left">जनपद : <asp:Label ID="lblLoginType" runat="server" Text="कानपुर नगर"></asp:Label></h3>
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
                                <h3 class="panel-title">सत्यापन हेतु भेजे गए बिल  </h3>
                            </div>
                            <!--No Label Form-->
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="table-responsive">
                                            <table class="table table-bordered table-responsive" id="tblIsForwarded">
                                                <colgroup>
                                                    <col width="5%" />
                                                    <col width="15%" />
                                                    <col width="15%" />
                                                    <col width="20%" />
                                                    <col width="25%" />
                                                  <%--  <col width="10%" />
                                                    <col width="10%" />--%>
                                                    <col width="10%" />
                                                    <col width="10%" />
                                                </colgroup>
                                                <thead>
                                                    <tr>
                                                        <th style="text-align: center">क्रम स०</th>
                                                        <%--<th style="text-align: center">#</th>--%>
                                                        <%-- <th style="text-align: center">
                                                    <input type="checkbox" id="chkAll"/></th>--%>
                                                        <th>ट्रांजेक्संन स०</th>
                                                        <th>कृषक पंजीकरण स०</th>
                                                        <th>लाभार्थी का नाम</th>
                                                        <th>योजना का प्रकार</th>
                                                      <%--  <th>प्रकार</th>
                                                        <th>किस्त</th>--%>
                                                        <th style = "text-align:right">अनुदान (रु०)</th>
                                                        <th style="text-align: center">#</th>
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
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</asp:Content>

