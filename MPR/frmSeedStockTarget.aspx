<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/HOMaster.master" AutoEventWireup="true" CodeFile="frmSeedStockTarget.aspx.cs" Inherits="MPR_frmSeedProductionTarget" %>

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
        var objMstArr = [];
        $(document).ready(function () {
            $('#pnlDetail').hide();

            $.ajax({
                type: "POST",
                url: "frmSeedProductionTarget.aspx/GetSeedObject",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var ddl = $("#ddlSDObject");
                    ddl.append($("<option></option>").val(0).html('मत्स्य बीज वितरण का मद चुनें'));
                    $.each(r.d, function () {
                        ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    ddl.selectpicker('refresh');
                }
            });

        });

    </script>
    <script type="text/javascript">
        function SeedDistribution() {
            var ddl = $('#ddlSDObject option:selected').val()
            if (ddl > 0) {
                $('#pnlDetail').show();
                $('#tblIsForwarded thead').empty();

                var row = '<tr><th rowspan="2" style="text-align: center; vertical-align: top">क्रम स०</th>';
                row = row + '<th rowspan="2" style="text-align: left; vertical-align: top">जनपद</th>';

                if (ddl == 1)
                    row = row + '<th colspan="6" style="text-align: center; vertical-align: top">फाई वितरण लक्ष्य</th>';
                else
                    row = row + '<th colspan="6" style="text-align: center; vertical-align: top">फिंगरलिंग वितरण लक्ष्य</th>';

                row = row + '</tr>'

                row = row + '<tr><th style="text-align: center; vertical-align: top">निगम की हैचरियों से </th>'
                row = row + '<th style="text-align: center; vertical-align: top">विभागीय प्रक्षेत्रों से</th>'
                row = row + '<th style="text-align: center; vertical-align: top">निजी क्षेत्र की हैचरियां</th>'

                row = row + '<th style="text-align: center; vertical-align: top">रियरिंग इकाई जो तालाब उत्पादन क्षमता डास्प, नीली क्रांति, आर0 के0 वी0 वाई0 निर्मित से</th>'
                row = row + '<th style="text-align: center; vertical-align: top">पंगेसियस/ अन्य प्रजाति के मत्स्य बीज का वितरण आयात द्वारा</th>'

                if (ddl == 1)
                    row = row + '<th style="text-align: center; vertical-align: top">कुल फाई वितरण के लक्ष्य का योग</th>'
                else
                    row = row + '<th style="text-align: center; vertical-align: top">कुल फिंगरलिंग वितरण के लक्ष्य का योग</th>'
                row = row + '</tr>'

                $('#tblIsForwarded thead').append(row);
                $('#tblIsForwarded tbody').empty();
                objMstArr = [];
                $.ajax({
                    type: "Post",
                    contentType: "application/json; charset=utf-8",
                    url: "frmSeedProductionTarget.aspx/GetSeedYearlyTarget",
                    data: '{SDObjectKey:' + $('#ddlSDObject').val() + '}',
                    dataType: "json",
                    success: function (data) {
                        var mst = $.parseJSON(data.d);
                        var id = 1;
                        var totseed = "";
                        $.each(mst, function (index, value) {

                            var row = '<tr><td style="text-align: center"><b>' + id + '</b></td>';
                            row = row + '<td style="text-align:left">' + value.DistrictName + '<input id="tbl_hd_' + id + '" type="hidden" value="' + value.DistrictKey + '"/> </td>'

                            row = row + '<td><input type="text" class="form-control" value="' + value.NigamSeedTarget + '" style="text-align:right" step="0.00" id="tbl_NigamSeedTarget_' + id + '" onchange="getDistrictTotal(this);"/></td>'
                            row = row + '<td><input type="text" class="form-control" value="' + value.VibhagiyaSeedTarget + '" style="text-align:right" step="0.00" id="tbl_VibhagiyaSeedTarget_' + id + '" onchange="getDistrictTotal(this);"/></td>'
                            row = row + '<td><input type="text" class="form-control" value="' + value.NijiSeedTarget + '" style="text-align:right" step="0.01" min="0.00" id="tbl_NijiSeedTarget_' + id + '" onchange="getDistrictTotal(this);"/></td>'
                            row = row + '<td><input type="text" class="form-control" value="' + value.RearingUnitSeedTarget + '" style="text-align:right" step="0.00" id="tbl_RearingUnitSeedTarget_' + id + '" onchange="getDistrictTotal(this);"/></td>'
                            row = row + '<td><input type="text" class="form-control" value="' + value.PangesiusSeedTarget + '"  style="text-align:right" step="0.00" id="tbl_PangesiusSeedTarget_' + id + '" onchange="getDistrictTotal(this);"/></td>'

                            totseed = parseFloat(value.NigamSeedTarget + value.VibhagiyaSeedTarget + value.NijiSeedTarget + value.RearingUnitSeedTarget + value.PangesiusSeedTarget).toFixed(2);
                            row = row + '<td><input type="text" class="form-control" value="' + totseed + '"  style="text-align:right" step="0.00" id="tbl_OtherSeedTarget_' + id + '"  readonly="reaonly"/></td>'
                            row = row + '</tr>'

                            id += 1;
                            $('#tblIsForwarded tbody').append(row);
                        });

                    },

                    error: function () {
                        alert("Error while retrieving data.");
                    }
                });
            }
            else {
                alert('मत्स्य बीज वितरण का मद चुनें');
                $('#pnlDetail').hide();
            }


        }
        function getDistrictTotal(e) {
            var trow = $(e.parentElement.parentElement).find('input[type=text]');
            var totalSeed = 0.0;
            $(trow).each(function (ind, val) {
                if (trow.length - 1 > ind) {
                    totalSeed = parseFloat(totalSeed) + parseFloat(trow[ind].value);
                }

            });
            trow[trow.length - 1].value = totalSeed.toFixed(2);

        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnSubmit").click(function () {
                event.preventDefault();
                var objMsrTargets = new Array();
                $("#tblIsForwarded tbody tr").each(function () {
                    var row = $(this);
                    var objMsrTarget = {};

                    objMsrTarget.DistrictKey = row.find("td").eq(1).find('input[type="hidden"]').val();
                    objMsrTarget.NigamSeedTarget = row.find("td").eq(2).find('input[type="text"]').val()
                    objMsrTarget.VibhagiyaSeedTarget = row.find("td").eq(3).find('input[type="text"]').val()
                    objMsrTarget.NijiSeedTarget = row.find("td").eq(4).find('input[type="text"]').val()
                    objMsrTarget.RearingUnitSeedTarget = row.find("td").eq(5).find('input[type="text"]').val();
                    objMsrTarget.PangesiusSeedTarget = row.find("td").eq(6).find('input[type="text"]').val()
                    objMsrTarget.OtherSeedTarget = row.find("td").eq(7).find('input[type="text"]').val()
                    objMsrTarget.SDObjectKey = $('#ddlSDObject').val();
                    objMsrTargets.push(objMsrTarget);

                });
                $.ajax({
                    type: "POST",
                    url: "frmSeedProductionTarget.aspx/Create",
                    data: '{lstMsrTarget: ' + JSON.stringify(objMsrTargets) + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        var r = $.parseJSON(response.d);
                        if (r.StatusCode == "200") {
                            alert(r.Msg);
                            window.location.href = "frmSeedProductionTarget.aspx";
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
            <h3><i class="fa fa-home"></i>मत्स्य बीज वितरण का वार्षिक लक्ष्य </h3>
            <div class="breadcrumb-wrapper">
                <%-- <span class="label">You are here:</span>--%>
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">होम </a></li>
                    <li class="active">मत्स्य बीज वितरण का वार्षिक लक्ष्य </li>
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
                                <h3 class="panel-title"><strong>मत्स्य बीज वितरण का वार्षिक लक्ष्य</strong></h3>
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

                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel">
                            <!--No Label Form-->
                            <div class="panel-body">
                                <!-- Inline Form  -->
                                <!--===================================================-->
                                <div class="row mar-top">
                                    <div class="col-lg-6">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="col-lg-4 control-label">मत्स्य बीज वितरण का मद </label>
                                                <div class="col-lg-8">
                                                    <select class="form-control selectpicker" data-live-search="true" id="ddlSDObject">
                                                    </select>
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>
                                    <div class="col-lg-2">
                                        <button class="btn btn-warning align-right" type="button" onclick="SeedDistribution()">खोजें</button>
                                    </div>

                                </div>
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
                                                    <col width="17%" />
                                                    <col width="13%" />
                                                    <col width="13%" />
                                                    <col width="13%" />
                                                    <col width="13%" />
                                                    <col width="13%" />
                                                    <col width="13%" />
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

