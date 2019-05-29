<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DistrictMaster.master" AutoEventWireup="true" CodeFile="frm_SeedDistribution.aspx.cs" Inherits="frm_SeedDistribution" %>

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
                url: "frm_SeedDistribution.aspx/GetMonthName",
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
                url: "frm_MSRTarget.aspx/GetSeedObject",
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

        function getSeedTargetByObject() {
            // SeedTarget_DistrictWise
            var ddlSDObjectKey = $("#ddlSDObject").val();
            var monthKey = $('#ddlMonthName').val();
            if (ddlSDObjectKey > 0 && monthKey>0) {
                $.ajax({
                    type: "Post",
                    contentType: "application/json; charset=utf-8",
                    url: "frm_SeedDistribution.aspx/SeedTarget_DistrictWise",
                    data: '{SDObjectKey : ' + ddlSDObjectKey + '}',
                    dataType: "json",
                    success: function (data) {
                        var mst = $.parseJSON(data.d);
                    
                        $('#tblSeedDistribution tbody').find('input[name=nigamhaitchry_target]').val(mst[0].NigamSeedTarget)
                        $('#tblSeedDistribution tbody').find('input[name=vibhagiya_target]').val(mst[0].VibhagiyaSeedTarget)
                        $('#tblSeedDistribution tbody').find('input[name=niji_target]').val(mst[0].NijiSeedTarget)
                        $('#tblSeedDistribution tbody').find('input[name=pond_target]').val(mst[0].RearingUnitSeedTarget)
                        $('#tblSeedDistribution tbody').find('input[name=pangasius_target]').val(mst[0].PangesiusSeedTarget)
                        $('#tblSeedDistribution tfoot').find('input[name=totalTarget]').val(mst[0].OtherSeedTarget)

                        $('#pnlDetail').show();
                    }
                });

            }
            else {
                alert('कृपया मान्य प्रविष्टियों का चयन करें।');
            }
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

        function calcPercent(e) {
            var trow = $(e.parentElement.parentElement);
            var tbody = $(e.parentElement.parentElement.parentElement);
            var ttlAval = 0;

            if (e.name == "nigamhaitchry_Avalaibility") {

                var aval = parseFloat(e.value);
                var tgr = parseFloat($(trow).find('input[name=nigamhaitchry_target]').val());
                $(trow).find('input[name=nigamhaitchry_perc]').val((aval * 100 / tgr).toFixed(2));

            } else if (e.name == "vibhagiya_Avalaibility") {

                var aval = parseFloat(e.value);
                var tgr = parseFloat($(trow).find('input[name=vibhagiya_target]').val());
                $(trow).find('input[name=vibhagiya_perc]').val((aval * 100 / tgr).toFixed(2));

            } else if (e.name == "niji_Avalaibility") {

                var aval = parseFloat(e.value);
                var tgr = parseFloat($(trow).find('input[name=niji_target]').val());
                $(trow).find('input[name=niji_perc]').val((aval * 100 / tgr).toFixed(2));

            } else if (e.name == "pond_Avalaibility") {
                var aval = parseFloat(e.value);
                var tgr = parseFloat($(trow).find('input[name=pond_target]').val());
                $(trow).find('input[name=pond_perc]').val((aval * 100 / tgr).toFixed(2));

            } else if (e.name == "pangasius_Avalaibility") {
                var aval = parseFloat(e.value);
                var tgr = parseFloat($(trow).find('input[name=pangasius_target]').val());
                $(trow).find('input[name=pangasius_perc]').val((aval * 100 / tgr).toFixed(2));
            }

            var totalAval = parseFloat($(tbody).find('input[name=nigamhaitchry_Avalaibility]').val());
            totalAval = totalAval + parseFloat($(tbody).find('input[name=vibhagiya_Avalaibility]').val());
            totalAval = totalAval + parseFloat($(tbody).find('input[name=niji_Avalaibility]').val());
            totalAval = totalAval + parseFloat($(tbody).find('input[name=pond_Avalaibility]').val());
            totalAval = totalAval + parseFloat($(tbody).find('input[name=pangasius_Avalaibility]').val());

            var totalTarget = parseFloat($('#tblSeedDistribution tfoot').find('input[name=totalTarget]').val())
            $('#tblSeedDistribution tfoot').find('input[name=totalAvailability]').val((totalAval).toFixed(2))
            $('#tblSeedDistribution tfoot').find('input[name=totalPerc]').val((totalAval * 100 / totalTarget).toFixed(2))
        }
    </script>

    <%--For Insert/Update Record --%>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnSubmit").click(function () {
                event.preventDefault();
                var MonthId = $('#ddlMonthName').val();
                var sdObjectKey = $('#ddlSDObject').val();

                if (sdObjectKey > 0 && MonthId > 0) {
                    var objSeedDistMaster = {};
                    var seedDistDetails = [];

                    objSeedDistMaster.MonthKey = MonthId;
                    objSeedDistMaster.SDObjectKey = sdObjectKey;

                    var objNigam = {};

                    objNigam.SDSubObjectKey = 1;
                    objNigam.Target = parseFloat($('#tblSeedDistribution tbody').find('input[name=nigamhaitchry_target]').val());
                    objNigam.Availed = parseFloat($('#tblSeedDistribution tbody').find('input[name=nigamhaitchry_Avalaibility]').val());;
                    objNigam.Perc = parseFloat($('#tblSeedDistribution tbody').find('input[name=nigamhaitchry_perc]').val());;

                    seedDistDetails.push(objNigam);

                    var objVibhagiya = {};

                    objVibhagiya.SDSubObjectKey = 2;
                    objVibhagiya.Target = parseFloat($('#tblSeedDistribution tbody').find('input[name=vibhagiya_target]').val());
                    objVibhagiya.Availed = parseFloat($('#tblSeedDistribution tbody').find('input[name=vibhagiya_Avalaibility]').val());;
                    objVibhagiya.Perc = parseFloat($('#tblSeedDistribution tbody').find('input[name=vibhagiya_perc]').val());;

                    seedDistDetails.push(objVibhagiya);

                    var objNiji = {};

                    objNiji.SDSubObjectKey = 3;
                    objNiji.Target = parseFloat($('#tblSeedDistribution tbody').find('input[name=niji_target]').val());
                    objNiji.Availed = parseFloat($('#tblSeedDistribution tbody').find('input[name=niji_Avalaibility]').val());;
                    objNiji.Perc = parseFloat($('#tblSeedDistribution tbody').find('input[name=niji_perc]').val());;

                    seedDistDetails.push(objNiji);

                     var objPond = {};

                    objPond.SDSubObjectKey = 4;
                    objPond.Target = parseFloat($('#tblSeedDistribution tbody').find('input[name=pond_target]').val());
                    objPond.Availed = parseFloat($('#tblSeedDistribution tbody').find('input[name=pond_Avalaibility]').val());;
                    objPond.Perc = parseFloat($('#tblSeedDistribution tbody').find('input[name=pond_perc]').val());;

                    seedDistDetails.push(objPond);

                    var objPangasius = {};

                    objPangasius.SDSubObjectKey = 5;
                    objPangasius.Target = parseFloat($('#tblSeedDistribution tbody').find('input[name=pangasius_target]').val());
                    objPangasius.Availed = parseFloat($('#tblSeedDistribution tbody').find('input[name=pangasius_Avalaibility]').val());;
                    objPangasius.Perc = parseFloat($('#tblSeedDistribution tbody').find('input[name=pangasius_perc]').val());;

                    seedDistDetails.push(objPangasius);

                    objSeedDistMaster.DistDetails = seedDistDetails;

                    $.ajax({
                        type: "POST",
                        url: "frm_SeedDistribution.aspx/Create",
                        data: '{objSeedDistributionMaster: ' + JSON.stringify(objSeedDistMaster) + '}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            var r = $.parseJSON(response.d);
                            if (r.StatusCode == "200") {
                                alert(r.Msg);
                                window.location.href = "frm_SeedDistribution.aspx";
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
            <h3><i class="fa fa-home"></i>समस्त श्रोतों से मत्स्य बीज वितरण </h3>
            <div class="breadcrumb-wrapper">
                <%-- <span class="label">You are here:</span>--%>
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">होम </a></li>
                    <li class="active">समस्त श्रोतों से मत्स्य बीज वितरण</li>
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
                                <h3 class="panel-title"><strong>समस्त श्रोतों से मत्स्य बीज वितरण की सूचना (लाख में)</strong></h3>
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
                                            <label class="col-lg-4 control-label">मत्स्य बीज वितरण का मद </label>
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
                        <div class="panel" id="pnlDetail" >
                            <!--No Label Form-->
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="table-responsive">
                                            <table class="table table-bordered table-responsive" id="tblSeedDistribution">
                                                <colgroup>
                                                    <col width="5%" />
                                                    <col width="50%" />
                                                    <col width="15%" />
                                                    <col width="15%" />
                                                    <col width="15%" />
                                                </colgroup>
                                                <thead>
                                                    <tr>
                                                        <th style="text-align: center">क्रम स०</th>
                                                        <th>समस्त श्रोतों से मत्स्य बीज वितरण</th>
                                                        <th>लक्ष्य (लाख में)</th>
                                                        <th>उप्लब्धि (लाख में)</th>
                                                        <th>प्रतिशत</th>
                                                    </tr>

                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td style="text-align: center">1.
                                                        </td>
                                                        <td>
                                                            <label name="seednigam" class="label-control">निगम की हैचरियों से</label>
                                                        </td>

                                                        <td>
                                                            <input type="text" name="nigamhaitchry_target" class="form-control" value="0.0" readonly="readonly" style="text-align: right" />
                                                        </td>
                                                        <td>
                                                            <input type="text" name="nigamhaitchry_Avalaibility" class="form-control" value="0.0" style="text-align: right" onchange="calcPercent(this);"/>
                                                        </td>
                                                        <td>
                                                            <input type="text" name="nigamhaitchry_perc" class="form-control" readonly="readonly" value="0.0" style="text-align: right" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="text-align: center">2.
                                                        </td>
                                                        <td>
                                                            <label name="seedvibhagiya" class="label-control">मत्स्य प्रक्षेत्रों से</label>
                                                        </td>

                                                        <td>
                                                            <input type="text" name="vibhagiya_target" class="form-control" value="0.0" readonly="readonly" style="text-align: right" />
                                                        </td>
                                                        <td>
                                                            <input type="text" name="vibhagiya_Avalaibility" class="form-control" value="0.0" style="text-align: right" onchange="calcPercent(this);"/>
                                                        </td>
                                                        <td>
                                                            <input type="text" name="vibhagiya_perc" class="form-control" readonly="readonly" value="0.0" style="text-align: right" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="text-align: center">3.
                                                        </td>
                                                        <td>
                                                            <label name="seedniji" class="label-control">निजी क्षेत्र की हैचरियां</label>
                                                        </td>

                                                        <td>
                                                            <input type="text" name="niji_target" class="form-control" value="0.0" readonly="readonly" style="text-align: right" />
                                                        </td>
                                                        <td>
                                                            <input type="text" name="niji_Avalaibility" class="form-control" value="0.0" style="text-align: right" onchange="calcPercent(this);"/>
                                                        </td>
                                                        <td>
                                                            <input type="text" name="niji_perc" class="form-control" readonly="readonly" value="0.0" style="text-align: right" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="text-align: center">4.
                                                        </td>
                                                        <td>
                                                            <label name="seedpond" class="label-control">रियरिंग इकाई जो तालाब उत्पादन क्षमता डास्प, नीली क्रांति, आर0 के0 वी0 वाई0 निर्मित से</label>
                                                        </td>

                                                        <td>
                                                            <input type="text" name="pond_target" class="form-control" value="0.0" readonly="readonly" style="text-align: right" />
                                                        </td>
                                                        <td>
                                                            <input type="text" name="pond_Avalaibility" class="form-control" value="0.0" style="text-align: right" onchange="calcPercent(this);"/>
                                                        </td>
                                                        <td>
                                                            <input type="text" name="pond_perc" class="form-control" readonly="readonly" value="0.0" style="text-align: right" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="text-align: center">5.
                                                        </td>
                                                        <td>
                                                            <label class="label-control">पंगेसियस/ अन्य प्रजाति के मत्स्य बीज का वितरण आयात द्वारा </label>
                                                        </td>

                                                        <td>
                                                            <input type="text" name="pangasius_target" class="form-control" value="0.0" readonly="readonly" style="text-align: right" />
                                                        </td>
                                                        <td>
                                                            <input type="text" name="pangasius_Avalaibility" class="form-control" value="0.0" style="text-align: right" onchange="calcPercent(this);"/>
                                                        </td>
                                                        <td>
                                                            <input type="text" name="pangasius_perc" class="form-control" readonly="readonly" value="0.0" style="text-align: right" />
                                                        </td>
                                                    </tr>
                                                </tbody>
                                                <tfoot>
                                                    <tr>
                                                        <td colspan="2" style="text-align: right"><strong>कुल योग</strong></td>
                                                        <td>
                                                            <input type="text" name="totalTarget" class="form-control" readonly="readonly" value="0.0" style="text-align: right" /></td>
                                                        <td>
                                                            <input type="text" name="totalAvailability" class="form-control" readonly="readonly" value="0.0" style="text-align: right"/></td>
                                                        <td>
                                                            <input type="text" name="totalPerc" class="form-control" readonly="readonly" value="0.0" style="text-align: right" /></td>
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

