<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AdministratorMaster.master" AutoEventWireup="true" CodeFile="SchemeWorkType.aspx.cs" Inherits="Administrator_SchemeWorkType" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../js/jquery-2.1.1.min.js" type="text/javascript"></script>
    <%-- Define Validation Rule --%>
    <script type="text/javascript">
        var isValid = false;

        $(document).ready(function () {
            $('#schemeworktype').bootstrapValidator({
                framework: 'bootstrap',
                icon: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    txtEffectiveDate: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'The Effective Date is required.'
                            },
                            date: {
                                format: 'DD/MM/YYYY',
                                message: 'The Effective Date is not valid. Date Format is "DD/MM/YYYY".'
                            }
                        }
                    },
                    ddlSchemeName: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'The Scheme Name is required.'
                            }
                        }
                    },
                    ddlProgressType: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'The Progress Type is required'
                            }
                        }
                    },
                    txtInstPercent: {
                        row: '.col-xs-4',
                        validators: {
                            inclusive: true,
                            notEmpty: {
                                message: 'The Installment is required and can\'t be empty'
                            },
                            between: {
                                min: 1,
                                max: 100,
                                message: 'Please enter a percent between 1 and 100'
                            },
                            numeric: {
                                message: 'The value is not a number'
                            }
                        }
                    },
                    txtInstNos: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'The number is required and can\'t be empty'
                            },
                            numeric: {
                                message: 'The value is not a number'
                            },
                            greaterThan: {
                                inclusive: true,
                                //If true, the input value must be greater than or equal to the comparison one.
                                //If false, the input value must be greater than the comparison one
                                value: 1,
                                message: 'Please enter a value must be greater than 1'
                            }
                        }
                    }
                }
            }).on('success.field.bv', function (e, data) {
                isValid = true;
                var totPer = $('#hdTInstPercent').val();
                var insPer = $('#txtInstPercent').val();
                if (parseFloat(insPer) > 0) {
                    if ((parseFloat(totPer) + parseFloat(insPer) <= 100)) {
                        isValid = true;
                    }
                    else {
                        isValid = false;
                        $('#txtInstPercent').val('');
                        alert('Please Enter Installment % between 1 to ' + (100 - totPer) + ' ')

                    }
                }
                if ($('#btnSubmit').text() == "Update") {
                    if (e.target.id == "ddlSchemeName") {
                        isValid = true;
                    }
                    else if (e.target.id == "ddlProgressType") {
                        isValid = true;
                    }
                    else if (e.target.id == "txtEffectiveDate") {
                        isValid = true;
                    }
                }

                else
                    isValid = true;


            });
        });
    </script>
    <%-- For Get Data --%>
    <script type="text/javascript">
        $(document).ready(function () {

            $("#pnlInstallment").hide(1000);

            $("#ddlSchemeName").prop('disabled', false);
            $("#ddlProgressType").prop('disabled', false);

            $('#btnCancel').click(function () {
                window.location.reload();
            });


            $.ajax({
                type: "POST",
                url: "SchemeWorkType.aspx/GetWorkType",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {

                    var ddl = $("[id*=ddlProgressType]");
                    ddl.append($("<option selected disabled hidden></option>").val('').html('Select Progress Type'));
                    $.each(r.d, function () {
                        ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    ddl.selectpicker('refresh');
                }
            });

            $(document).on("click", ".editButton", function () {

                $("#add-tab").trigger('click');
                $("#tab-add-scheme").addClass("tab-pane fade active in")
                $("#tab-list-scheme").removeClass("tab-pane fade active in")

                $("#tab-list-scheme").prop("aria-selected", "true")
                $("#tab-list-scheme").prop("aria-expanded", "false")

                $("#pnlSchemeDetail").hide();

                var id = $(this).attr("data-id");

                $("#SchemeWorkKey").val(id);

                $.ajax({
                    type: "Post",
                    contentType: "application/json; charset=utf-8",
                    url: "SchemeWorkType.aspx/EditSchemeWorkType",
                    data: '{intSchemeWorkKey: ' + id + '}',
                    dataType: "json",
                    success: function (data) {

                        var mst = $.parseJSON(data.d);
                        var schemeid = 0;
                        var progress = 0;
                        $("#pnlInstallment").show(1000);
                        $("#tblInstallment tbody").empty();
                        $.each(mst, function (index, value) {
                            $('#txtEffectiveDate').val(value.EffectiveDate);
                            $('#txtInstPercent').val(value.InstPercent);
                            $('#txtInstNos').val(value.InstNos);

                            schemeid = value.SchemeKey;
                            progress = value.WorkTypeKey;

                            $('#ddlSchemeNameType').val(value.SchemeTypekey);
                            $("#ddlSchemeNameType").prop('disabled', true);
                            $("#ddlSchemeNameType").selectpicker('refresh');

                            var row = '<tr><td class="col-md-3" style="text-align: center"><b>' + value.InstallmentNo + '</b> </td>';
                            row = row + '<td class="col-md-3" style="text-align: center"><input type="text" class="form-control" placeholder="00.00" name="ins_' + value.InstallmentNo + '" id=ins_' + value.InstallmentNo + ' value="' + value.InstallmentPercent + '" required/></td>'
                            row = row + '</tr>'

                            $('#tblInstallment tbody').append(row);
                        });

                        GetSchemeType(schemeid);

                        //$("#ddlSchemeName option").each(function () {
                        //    if ($(this).val() == schemeid)
                        //        $(this).prop('selected', true);
                        //    else
                        //        $(this).prop('selected', false);
                        //});
                       
                      //  $("#ddlSchemeName").selectpicker('refresh');

                        $("#ddlSchemeName").prop('disabled', true);

                        $("#ddlProgressType option").each(function () {
                            if ($(this).val() == progress)
                                $(this).prop('selected', true);
                            else
                                $(this).prop('selected', false);
                        });
                        $("#ddlProgressType").prop('disabled', true);
                        $("#ddlProgressType").selectpicker('refresh');

                        getSchemeWork();
                        $("#btnSubmit").text('Update');
                        $("#btnSubmit").prop('disabled', true);
                    },

                    error: function () {
                        alert("Error while retrieving data of :" + id);
                    }
                });
            });
        });

    </script>
    <%--For Control Event--%>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#txtEffectiveDate').datepicker({ autoclose: true });
            $("#pnlInstallment").hide();
            $("#pnlSchemeWorks").hide();
            $("#profile-tab").click(function () {
                $("#pnlSchemeDetail").show();
            });

            $("#add-tab").click(function () {
                $("#pnlSchemeDetail").hide();
            });
        });

        function changeInstallment() {
            var noIns = $('#txtInstNos').val();
            var perIns = 100;
            var insPer = (perIns / noIns).toFixed(2);
            var insPerTolal = 0;

            if (noIns > 0 && perIns > 0 && perIns <= 100) {
                $("#pnlInstallment").show(1000);
                $("#tblInstallment tbody").empty();
                for (var i = 0; i < noIns; i++) {
                    var row = '<tr><td class="col-md-3" style="text-align: center"><b>' + (i + 1) + '</b></td>';
                    row = row + '<td class="col-md-3" style="text-align: center"><input type="text" class="form-control" placeholder="00.00" name="ins_' + (i + 1) + '" id=ins_' + (i + 1) + ' value="' + (i < noIns - 1 ? insPer : (perIns - insPerTolal).toFixed(2)) + '" required /></td>'
                    row = row + '</tr>'
                    insPerTolal = (parseFloat(insPerTolal) + parseFloat(insPer)).toFixed(2);
                    $('#tblInstallment tbody').append(row);
                }
            }
            else {
                $("#pnlInstallment").hide(1000);
                $("#tblInstallment tbody").empty();
            }
        }

        function getSchemeWork() {
            var shemeKey = $('#ddlSchemeName').val();
            if (shemeKey > 0) {
                $.ajax({
                    type: "POST",
                    url: "SchemeWorkType.aspx/GetSchemeWorkType",
                    data: '{intSchemeKey : ' + shemeKey + ' }',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        var schemeWork = $.parseJSON(data.d);
                        var i = 0;
                        var totalper = 0;
                        var totalnos = 0;
                        var worktype = [];

                        $("#tblSchemeWorkDetail").append(colgrp);
                        $("#tblSchemeWorkDetail tbody").empty();
                        $.each(schemeWork, function (index, value) {
                            var row = '<tr><td style="text-align: center"><b>' + (i + 1) + '</b> </td>';
                            row = row + '<td>' + value.EffectiveDate + '</td>';
                            row = row + '<td>' + value.ProgressTypeName + '</td>';
                            row = row + '<td>' + value.InstPercent + '</td>';
                            row = row + '<td>' + value.InstNos + '</td>';
                            if (value.IsActive == 1)
                                row = row + '<td><span class="label label-xs label-table label-success">Active</span></td>';
                            else
                                row = row + '<td><span class="label label-xs label-table label-dark">Disable</span></td>';
                            row = row + '</tr>'

                            $('#tblSchemeWorkDetail tbody').append(row);

                            totalper += parseFloat(value.InstPercent);
                            totalnos += parseFloat(value.InstNos);

                            worktype.push(value.WorkTypeKey);

                            i = i + 1;
                        });

                        worktype.map(function (v) {
                            $("#ddlProgressType option").each(function () {
                                if ($(this).val() == v)
                                    $(this).prop('disabled', true);
                            });
                        })
                        $("#ddlProgressType").selectpicker('refresh');

                        if (totalper > 0) {
                            $('#hdTInstPercent').val(totalper);
                            $('#tblSchemeWorkDetail tfoot').empty();
                            row = '<tr><td colspan="3"><b>Total</b></td><td>' + totalper + '</td><td>' + totalnos + '</td><td></td><tr>';
                            $('#tblSchemeWorkDetail tfoot').append(row);

                            $('#txtInstPercent').attr('max', totalper);
                            $('#txtInstPercent').attr('data-bv-between-message', 'Please enter a percent between 1 and ' + (totalper == 0 ? 100 : (100 - totalper)) + '');

                        }
                        if (i > 0)
                            $("#pnlSchemeWorks").show(1000);
                        else
                            $("#pnlSchemeWorks").hide();

                    }
                });
            }
            else {
                $("#pnlSchemeWorks").hide();
                $("#tblSchemeWorkDetail tbody").empty();
            }
        }

    </script>

    <%-- Insert/Update/Delete Operation --%>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnSubmit").click(function () {
                if ($('#tblInstallment tr').length > 0) {
                    var totalPer = 0;
                    for (var i = 0; i < $('#tblInstallment tr').length; i++) {
                        totalPer = parseFloat(totalPer) + parseFloat($("#ins_" + (i + 1) + "").val());
                    }
                    if (parseFloat(totalPer) > 100) {

                        alert('Please Enter Correct Installment Slabe');
                        isValid = false;
                    }
                }
                if (isValid) {
                    if ($('#txtEffectiveDate').val() != "" && $('#ddlSchemeName').val() != "" && $('#ddlProgressType').val() != "" && $('#txtInstPercent').val() != "" && $('#txtInstNos').val() != "") {

                        var SchemeWorkType = {};

                        var mstKey = parseInt($('#SchemeWorkKey').val());

                        SchemeWorkType.EffectiveDate = $('#txtEffectiveDate').val();
                        SchemeWorkType.SchemeKey = $('#ddlSchemeName').val();

                        SchemeWorkType.WorkTypeKey = $('#ddlProgressType').val();

                        SchemeWorkType.InstPercent = $('#txtInstPercent').val();
                        SchemeWorkType.InstNos = $('#txtInstNos').val();
                        SchemeWorkType.IsActive = true;

                        SchemeWorkType.SchemeWorkKey = mstKey;

                        objSchemeWorkTypeDetails = [];

                        for (var i = 0; i < $('#tblInstallment tr').length - 1; i++) {
                            var SchemeWorkTypeDetail = {};
                            SchemeWorkTypeDetail.InstallmentNo = (i + 1);
                            SchemeWorkTypeDetail.InstallmentPercent = $("#ins_" + (i + 1) + "").val();
                            objSchemeWorkTypeDetails.push(SchemeWorkTypeDetail);
                        }

                        SchemeWorkType.SchemeWorkTypeDetails = objSchemeWorkTypeDetails;

                        $.ajax({
                            type: "POST",
                            url: "SchemeWorkType.aspx/Submit",
                            data: '{objSchemeWorkType: ' + JSON.stringify(SchemeWorkType) + '}',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (response) {
                                data = (response.d);
                                if (data != "") {
                                    alert(data)
                                }
                                else {
                                    alert("Something Went Wrong.")
                                }
                            },
                            error: function (err) {
                                alert(err)
                            }
                        });

                    }
                }
            });

            $(document).on("click", ".deleteButton", function () {
                var id = $(this).attr("data-id");

                if (confirm("Are you sure want to delete this record?")) {
                    $.ajax({
                        type: "Post",
                        contentType: "application/json; charset=utf-8",
                        url: "SchemeWorkType.aspx/Delete",
                        data: '{intSchemeWorkKey: ' + id + '}',
                        dataType: "json",
                        success: function (response) {
                            data = (response.d);
                            if (data != "") {
                                alert(data)
                                window.location.reload();
                            }
                            else {
                                alert("Something Went Wrong.")
                            }
                        }
                    });
                }
                return false;
            });

            $(document).on("click", ".activeButton", function () {
                var id = $(this).attr("data-id");

                if (confirm("Are you sure want to active/deactive this record?")) {
                    $.ajax({
                        type: "Post",
                        contentType: "application/json; charset=utf-8",
                        url: "SchemeWorkType.aspx/ACTIVE_DEACTIVE",
                        data: '{intSchemeWorkKey: ' + id + '}',
                        dataType: "json",
                        success: function (response) {
                            data = (response.d);
                            if (data != "") {
                                alert(data)
                                window.location.reload();
                            }
                            else {
                                alert("Something Went Wrong.")
                            }
                        }
                    });
                }
                return false;
            });
        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#ddlSchemeName').prop('disabled', false);
            //Load Scheme Type on Page Load
            $.ajax({
                type: "POST",
                url: "SchemeWorkType.aspx/GetSchemesType",
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

        function GetSchemeType(schemekey) {
            var schemetypekey = $('#ddlSchemeNameType option:selected').val();
            $('#ContentPlaceHolder1_hfSchemeTypeKey').val(schemetypekey);
            if (schemetypekey > 0) {
                $.ajax({
                    type: "POST",
                    url: "SchemeWorkType.aspx/GetSchemes",
                    data: '{schemetypkey: ' + schemetypekey + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        var ddl = $('#ddlSchemeName');
                        ddl.empty();
                        $.each(r.d, function () {
                            if (this['Value'] == schemekey) {
                                ddl.append($("<option selected></option>").val(this['Value']).html(this['Text']));
                            }
                            else {
                                ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                            }
                        });

                        ddl.selectpicker('refresh');
                    }
                });
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="content-container">
        <!--Page Title-->
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <div class="pageheader hidden-xs">
            <h3><i class="fa fa-home"></i>Scheme Progress Installment </h3>
            <div class="breadcrumb-wrapper">
                <span class="label">You are here:</span>
                <ol class="breadcrumb">
                    <li><a href="#">Home </a></li>
                    <li class="active">Scheme Progress Installment </li>
                </ol>
            </div>
        </div>


        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <!--End page title-->
        <form class="form-horizontal" id="schemeworktype">
            <input type="hidden" id="SchemeWorkKey" name="SchemeWorkKey" value="0" />
            <div id="page-content">
                <div class="row">
                    <div class="col-lg-12">
                        <!--Default Tabs (Left Aligned)-->
                        <!--===================================================-->
                        <div class="tab-base">
                            <!--Nav Tabs-->
                            <ul class="nav nav-tabs" id="scheme" role="tablist">
                                <li class="nav-item active">
                                    <a class="nav-link active" id="profile-tab" data-toggle="tab" href="#tab-list-scheme" role="tab" aria-controls="profile" aria-selected="false">Scheme Progress Installment Detail</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="add-tab" data-toggle="tab" href="#tab-add-scheme" role="tab" aria-controls="home" aria-selected="true">Add Scheme Progress Installment</a>
                                </li>

                            </ul>
                            <!--Tabs Content-->
                            <div class="tab-content">
                                <div id="tab-add-scheme" class="tab-pane fade">
                                    <div id="page-content1">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <div class="panel">
                                                    <div class="panel-heading">
                                                        <h3 class="panel-title">
                                                            <span class="col-md-10">Add Scheme Progress Installment </span>
                                                        </h3>
                                                    </div>
                                                    <div class="panel-body mar-top">
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3" for="txtEffectiveDate">Effective Date *</label>
                                                            <div class="col-md-7">
                                                                <input type="text" class="form-control" name="txtEffectiveDate" id="txtEffectiveDate"
                                                                    placeholder="dd/mm/yyyy" data-date-format='dd/mm/yyyy'
                                                                    data-mask="99/99/9999"
                                                                    data-bv-date="true"
                                                                    data-bv-date-format="DD/MM/YYYY"
                                                                    data-bv-date-message="The Effective Date is not valid" readonly />
                                                            </div>
                                                        </div>
                                                        <div class="form-group" style="margin-bottom: 0;">
                                                            <label class="control-label col-md-3" for="txtSchemeCode">Schemes Type *</label>
                                                            <div class="col-md-7">
                                                                <select class="form-control selectpicker" data-live-search="true" id="ddlSchemeNameType" required onchange="GetSchemeType(0)"></select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group" style="margin-bottom: 0;">
                                                            <label class="control-label col-md-3" for="ddlSchemeName">Scheme Name *</label>
                                                            <div class="col-md-7">
                                                                <select class="form-control selectpicker" data-placeholder="Choose a Category..." title="Choose Scheme..." name="ddlSchemeName" id="ddlSchemeName" data-live-search="true" onchange="getSchemeWork();" required>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group" style="margin-bottom: 0;" id="pnlSchemeWorks">
                                                            <div class="col-md-3">
                                                            </div>
                                                            <div class="col-md-7">
                                                                    <table class="table table-striped  table-bordered" id="tblSchemeWorkDetail">
                                                                        <colgroup>
                                                                            <col style="width: 5%" />
                                                                            <col style="width: 10%" />
                                                                            <col style="width: 45%" />
                                                                            <col style="width: 10%" />
                                                                            <col style="width: 10%" />
                                                                            <col style="width: 10%" />
                                                                            <col style="width: 10%" />
                                                                        </colgroup>
                                                                        <thead>
                                                                            <tr>
                                                                                <th class="min-desktop">Sr.No.</th>
                                                                                <th class="min-desktop">Effective Date</th>
                                                                                <th class="min-desktop">Progress Type</th>
                                                                                <th class="min-desktop">Total Installment (%)</th>
                                                                                <th class="min-desktop">No of Installment</th>
                                                                                <th class="min-desktop">Status</th>
                                                                                <th class="min-desktop">Action</th>
                                                                            </tr>

                                                                        </thead>
                                                                        <tbody>
                                                                        </tbody>
                                                                        <tfoot>
                                                                        </tfoot>
                                                                    </table>
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label class="control-label col-md-3" for="ddlProgressType">Progress Type *</label>
                                                            <div class="col-md-7">
                                                                <!-- Bootstrap Select with Multiple Selects -->
                                                                <!--===================================================-->
                                                                <select class="form-control selectpicker" name="ddlProgressType" id="ddlProgressType" required>
                                                                </select>
                                                                <!--===================================================-->
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3" for="txtInstPercent">Installment (in %) *</label>
                                                            <div class="col-md-7">
                                                                <input type="text" id="txtInstPercent" class="form-control" placeholder="00.00" name="txtInstPercent" data-bv-field="numeric" required />
                                                            </div>
                                                            <input type="hidden" id="hdTInstPercent" value="0" />
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3" for="txtInstNos">No of Installment *</label>
                                                            <div class="col-md-7">
                                                                <input type="number" id="txtInstNos" class="form-control" name="txtInstNos" onchange="changeInstallment();" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group" id="pnlInstallment">
                                                            <div class="col-md-3">
                                                            </div>
                                                            <div class="col-md-7">
                                                                <div class="alert alert-primary" role="alert" style="margin-bottom: 0;">
                                                                    Installment Percent Detail
                                                                </div>
                                                                <div class="table-responsive">
                                                                    <table class="table table-striped  table-bordered" id="tblInstallment">
                                                                        <thead>
                                                                            <tr>
                                                                                <th style="width: 15%; text-align: center">No of Installment</th>
                                                                                <th style="width: 85%">Installment (%)</th>
                                                                            </tr>
                                                                        </thead>
                                                                        <tbody>
                                                                        </tbody>
                                                                    </table>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="panel-footer">
                                                        <div class="row">
                                                            <div class="col-sm-7 col-sm-offset-3">
                                                                <button id="btnSubmit" class="btn btn-info btn-lg" type="submit">Submit</button>
                                                                <button id="btnCancel" class="btn btn-warning btn-lg" type="reset">Cancel</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-6">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="tab-list-scheme" class="tab-pane fade active in">
                                    <div id="page-content2">
                                        <div class="row">
                                            <!-- Row selection (single row) -->
                                            <!--===================================================-->
                                            <div class="panel" id="pnlSchemeDetail">
                                                <div class="panel-heading">
                                                    <h3 class="panel-title">Scheme Progress Installment <strong>Details</strong></h3>
                                                </div>
                                                <div class="panel-body">
                                                    <table id="demo-dt-selection" class="table table-striped table-bordered">
                                                        <thead>
                                                            <tr>
                                                                <th class="min-desktop" style="width: 5%; text-align: center">S.No.</th>
                                                                <th class="min-desktop" style="width: 8%">Effective Date</th>
                                                                <th class="min-desktop" style="width: 15%">Scheme Type Name</th>
                                                                <th class="min-desktop" style="width: 30%">Scheme Name</th>
                                                                <th class="min-desktop" style="width: 10%">Progress Type</th>
                                                                <th class="min-desktop" style="width: 8%; text-align: center">Installment (%)</th>
                                                                <th class="min-desktop" style="width: 8%; text-align: center">No of Installment</th>
                                                                <th class="min-desktop" style="width: 8%; text-align: center">Status</th>
                                                                <th class="min-desktop" style="width: 8%; text-align: center">Action</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <% for (var data = 0; data < dtMaster.Rows.Count; data++)
                                                               { %>
                                                            <tr>
                                                                <td style="width: 5%; text-align: center"><%= data + 1 %>. </td>
                                                                <td style="width: 8%"><%=dtMaster.Rows[data]["EffectiveDate"].ToString()%></td>
                                                                <td style="width: 15%"><%=dtMaster.Rows[data]["SchemeTypeName"].ToString()%></td>
                                                                <td style="width: 30%"><%=dtMaster.Rows[data]["SchemeName"].ToString()%></td>
                                                                <td style="width: 10%"><%=dtMaster.Rows[data]["ProgressTypeName"].ToString()%></td>
                                                                <td style="width: 8%; text-align: center"><%=dtMaster.Rows[data]["InstPercent"].ToString()%></td>
                                                                <td style="width: 8%; text-align: center"><%=dtMaster.Rows[data]["InstNos"].ToString()%></td>
                                                                <td style="width: 8%; text-align: center">
                                                                    <%if (Convert.ToBoolean(dtMaster.Rows[data]["IsActive"]))
                                                                      {
                                                                    %>
                                                                    <span class="btn btn-xs btn-success activeButton" data-id="<%=dtMaster.Rows[data]["SchemeWorkKey"] %>" style="width: 70px">Active</span>
                                                                    <%     
                                                                      }
                                                                      else
                                                                      {
                                                                    %>
                                                                    <span class="btn btn-xs btn-warning activeButton" data-id="<%=dtMaster.Rows[data]["SchemeWorkKey"] %>">Disable</span>
                                                                    <% 
                                                                      }
                                                                    %>
                                                                </td>

                                                                <td style="width: 8%; text-align: center">
                                                                    <div class="btn-group btn-group-xs">
                                                                        <a href="#" class="btn icon-xs btn-info btn-icon icon-xs fa fa-edit editButton" data-id="<%=dtMaster.Rows[data]["SchemeWorkKey"] %>"
                                                                            data-placement="top" data-original-title="Edit"></a>
                                                                        <a href="#" class="btn icon-xs btn-danger btn-icon icon-xs fa fa-trash deleteButton" data-id="<%=dtMaster.Rows[data]["SchemeWorkKey"] %>"
                                                                            data-placement="top" data-original-title="Remove"></a>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <%}%>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                            <!--===================================================-->
                                            <!-- End Row selection (single row) -->
                                        </div>
                                    </div>

                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <script src="../plugins/bootstrap-validator/bootstrapValidator.min.js"></script>
    <script src="../js/demo/form-validation.js"></script>
    <!--DataTables Sample [ SAMPLE ]-->
    <script src="../js/demo/tables-datatables.js"></script>
    <!--Form Component [ SAMPLE ]-->
    <!--Bootstrap Datepicker [ OPTIONAL ]-->
    <script src="../plugins/bootstrap-datepicker/bootstrap-datepicker.js"></script>
    <!--Form Component [ SAMPLE ]-->
    <script src="../js/demo/form-component.js"></script>
</asp:Content>

