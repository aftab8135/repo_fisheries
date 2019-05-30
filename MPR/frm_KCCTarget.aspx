<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/HOMaster.master" AutoEventWireup="true" CodeFile="frm_KCCTarget.aspx.cs" Inherits="MPR_frm_KCCTarget" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .panel-heading {
            background-color: #f9f9f9 !important;
        }

        .panel-title {
            line-height: 44px !important;
        }
    </style>
    <script src="<%=ResolveUrl("~/js/jquery-2.1.1.min.js") %>"></script>
    <script type="text/javascript">
        $(document).ready(function () {
           
            $('#tblIsForwarded thead').empty();
            var row = '<tr><th style="text-align: center; vertical-align: top">क्रम स०</th>';
            row = row + '<th style="text-align: left; vertical-align: top">जनपद</th>';
            row = row + '<th style="text-align: center; vertical-align: top">वार्षिक लक्ष्य</th>';
            row = row + '</tr>'

            $('#tblIsForwarded thead').append(row);
            $('#tblIsForwarded tbody').empty();
            $.ajax({
                type: "POST",
                url: "frm_KCCTarget.aspx/GetKCCYearlyTarget",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var mst = $.parseJSON(data.d);
                    var id = 1;
                    $.each(mst, function (index, value) {
                        var row = '<tr><td style="text-align: center"><b>' + id + '</b></td>';
                        row = row + '<td style="text-align:left">' + value.DistrictName + '<input id="tbl_hd_' + id + '" type="hidden" value="' + value.DistrictKey + '"/> </td>'
                        row = row + '<td><input type="text" class="form-control" value="' + value.KCCTarget + '" style="text-align:right" step="0.00" id="tbl_KCCTarget_' + id + '"/></td>'
                        row = row + '</tr>'

                        id += 1;
                        $('#tblIsForwarded tbody').append(row);
                    });
                },
                error: function () {
                    alert("Error while retrieving data.");
                }
            });

        });

    </script>
   
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnSubmit").click(function () {
                event.preventDefault();
                var objKCCTargets = new Array();
                $("#tblIsForwarded tbody tr").each(function () {
                    var row = $(this);
                    var objKCCTarget = {};

                    objKCCTarget.DistrictKey = row.find("td").eq(1).find('input[type="hidden"]').val();
                    objKCCTarget.KCCTarget = row.find("td").eq(2).find('input[type="text"]').val()
                  
                    objKCCTargets.push(objKCCTarget);

                });
                $.ajax({
                    type: "POST",
                    url: "frm_KCCTarget.aspx/Create",
                    data: '{lstKCCTarget: ' + JSON.stringify(objKCCTargets) + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        var r = $.parseJSON(response.d);
                        if (r.StatusCode == "200") {
                            alert(r.Msg);
                            window.location.href = "frm_KCCTarget.aspx";
                        }
                        else {
                            alert(r.Msg);
                        }
                    },
                    error: function (err) {
                        alert(err.statusText)
                    }
                });
            });
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div id="content-container">
        <!--Page Title-->
        <!--------------------------------------------------------->
        <div class="pageheader hidden-xs">
            <h3><i class="fa fa-home"></i>किसान क्रेडिट कार्ड योजना का वार्षिक लक्ष्य </h3>
            <div class="breadcrumb-wrapper">
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">होम </a></li>
                    <li class="active">किसान क्रेडिट कार्ड योजना का वार्षिक लक्ष्य </li>
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
                                <h3 class="panel-title"><strong>किसान क्रेडिट कार्ड योजना का वार्षिक लक्ष्य</strong></h3>
                            </div>
                            <!--No Label Form-->
                            <div class="panel-body" style="margin-top: -15px">
                                <h3 style="float: left">जनपद :
                                    <asp:Label ID="lblLoginType" runat="server" Text="Head Office, Lucknow"></asp:Label></h3>
                                <h3 style="float: right">वित्तीय वर्ष  :
                                     <asp:Label ID="lblFinYear" runat="server" Text="2018-2019"></asp:Label>
                                </h3>
                            </div>
                        </div>
                    </div>
                </div>

                

                <div class="row" id="pnlDetail">
                    <div class="col-lg-12">
                        <div class="panel">
                            <!--No Label Form-->
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="table-responsive">
                                            <table class="table table-bordered table-responsive" id="tblIsForwarded">
                                                <colgroup>
                                                    <col width="5%" />
                                                    <col width="80%" />
                                                    <col width="15%" />
                                                  
                                                </colgroup>
                                                <thead>
                                                </thead>
                                                <tbody>
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

