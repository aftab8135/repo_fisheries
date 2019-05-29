<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/HOMaster.master" AutoEventWireup="true" CodeFile="BudgetBooking.aspx.cs" Inherits="Administrator_BudgetBooking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../js/jquery-2.1.1.min.js" type="text/javascript"></script>
    <%-- Define Validation Rule --%>
    <script type="text/javascript">
        var isValid = false;
        $(document).ready(function () {
            $('#bookingBudget').bootstrapValidator({
                framework: 'bootstrap',
                icon: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    ddlBudType: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'The Budget Type is required.'
                            }
                        }
                    },
                    ddlFinYear: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'The Financial Year is required.'
                            }
                        }
                    },
                    ddlAccType: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'The Account Type is required.'
                            }
                        }
                    },
                    ddlFundSource: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'The Fund Source is required.'
                            }
                        }
                    },
                    ddlObjectName: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'The Object Name is required.'
                            }
                        }
                    },
                    txtGONo: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'The GO is required.'
                            }
                        }
                    },
                    txtGODate: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'The GO Date is required.'
                            }
                        }
                    },
                    txtAmount: {
                        row: '.col-xs-4',
                        validators: {
                            inclusive: true,
                            notEmpty: {
                                message: 'The Amount is required and can\'t be empty'
                            },
                            greaterThan: {
                                inclusive: true,
                                value: 1,
                                message: 'The Amount can not zero.'
                            },
                            numeric: {
                                message: 'Invalid Entry.'
                            }
                        }
                    },
                    ddlBankName: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'The Bank Name is required.'
                            }
                        }
                    },
                    ddlPayType: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'The Payment Type is required.'
                            }
                        }
                    },
                    txtChequeNo: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'The Cheque No is required.'
                            }
                        }
                    },
                    txtChequeDate: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'The Cheque Date is required.'
                            }
                        }
                    }
                }
            }).on('success.field.bv', function (e, data) {
                isValid = true;
            });
        });
    </script>
    <%-- For Get Data --%>
    <script type="text/javascript">
        $(document).ready(function () {

            $('#txtGODate').datepicker({ autoclose: true });
            $('#txtChequeDate').datepicker({ autoclose: true });

            $('#btnCancel').click(function () {
                window.location.reload();
            });

            $.ajax({
                type: "POST",
                url: "BudgetBooking.aspx/GetFinancialYear",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {

                    var ddl = $("[id*=ddlFinYear]");
                    ddl.append($("<option selected disabled hidden></option>").val('').html('Select Financial Year'));
                    $.each(r.d, function () {
                        ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    ddl.selectpicker('refresh');
                }
            });

            $.ajax({
                type: "POST",
                url: "BudgetBooking.aspx/GetBudgetType",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {

                    var ddl = $("[id*=ddlBudType]");
                    ddl.append($("<option selected disabled hidden></option>").val('').html('Select Budget Type'));
                    $.each(r.d, function () {
                        ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    ddl.selectpicker('refresh');
                }
            });
            $.ajax({
                type: "POST",
                url: "BudgetBooking.aspx/GetAccountType",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {

                    var ddl = $("[id*=ddlAccType]");
                    ddl.append($("<option selected disabled hidden></option>").val('').html('Select Account Type'));
                    $.each(r.d, function () {
                        ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    ddl.selectpicker('refresh');
                }
            });

            $.ajax({
                type: "POST",
                url: "BudgetBooking.aspx/GetFundSource",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var ddl = $("[id*=ddlFundSource]");
                    ddl.append($("<option selected disabled hidden></option>").val('').html('Select Fund Souce'));
                    $.each(r.d, function () {
                        ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    ddl.selectpicker('refresh');
                }
            });

            $.ajax({
                type: "POST",
                url: "BudgetBooking.aspx/GetSchemes",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {

                    var ddl = $("[id*=ddlSchemeName]");
                    $.each(r.d, function () {
                        ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    ddl.selectpicker('refresh');
                }
            });

            $.ajax({
                type: "POST",
                url: "BudgetBooking.aspx/GetDeptObject",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {

                    var ddl = $("[id*=ddlObjectName]");
                    $.each(r.d, function () {
                        ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    ddl.selectpicker('refresh');
                }
            });

            $.ajax({
                type: "POST",
                url: "BudgetBooking.aspx/GetHead",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {

                    var ddl = $("[id*=ddlHeadName]");
                    ddl.append($("<option selected disabled hidden></option>").val('').html('Select Head'));
                    $.each(r.d, function () {
                        ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    ddl.selectpicker('refresh');
                }
            });

            $.ajax({
                type: "POST",
                url: "BudgetBooking.aspx/GetBank",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {

                    var ddl = $("[id*=ddlBankName]");
                    $.each(r.d, function () {
                        ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    ddl.selectpicker('refresh');
                }
            });

            $.ajax({
                type: "POST",
                url: "BudgetBooking.aspx/GetPaymentType",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {

                    var ddl = $("[id*=ddlPayType]");
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

                var id = $(this).attr("data-id");

                $("#bookingid").val(id);

                $.ajax({
                    type: "Post",
                    contentType: "application/json; charset=utf-8",
                    url: "BudgetBooking.aspx/Edit",
                    data: '{intBookingKey: ' + id + '}',
                    dataType: "json",
                    success: function (data) {

                        var mst = $.parseJSON(data.d);

                        var finYear = '';
                        var budType = 0;
                        var accType = 0;
                        var fundSource = 0;
                        var headName = 0;
                        var schemeName = 0;
                        var objectName = 0;
                        var bankName = 0;
                        var payType = 0;

                        $.each(mst, function (index, value) {

                            //$('#txtGrantCode').val(value.GrandCode);

                            $('#txtGONo').val(value.GONo);
                            $('#txtGODate').val(value.GODate);
                            $('#txtAmount').val(value.BAmount);

                            $('#txtChequeNo').val(value.RefNo);
                            $('#txtChequeDate').val(value.RefDate);
                            $('#txtRemark').val(value.Remark);

                            finYear = value.FinancialYear;
                            budType = value.BudgetType;
                            accType = value.AccountType;
                            fundSource = value.SourceKey;
                            headName = value.HeadNameKey;
                            schemeName = value.SchemeKey;
                            objectName = value.ObjectKey;
                            bankName = value.BankKey;
                            payType = value.PaymentType;

                        });

                        $("#ddlFinYear option").each(function () {
                            if ($(this).val() == finYear)
                                $(this).prop('selected', true);
                            else
                                $(this).prop('selected', false);
                        });
                        $("#ddlFinYear").selectpicker('refresh');

                         $("#ddlBudType option").each(function () {
                            if ($(this).val() == budType)
                                $(this).prop('selected', true);
                            else
                                $(this).prop('selected', false);
                        });
                        $("#ddlBudType").selectpicker('refresh');

                         $("#ddlFundSource option").each(function () {
                            if ($(this).val() == fundSource)
                                $(this).prop('selected', true);
                            else
                                $(this).prop('selected', false);
                        });
                        $("#ddlFundSource").selectpicker('refresh');

                         $("#ddlAccType option").each(function () {
                            if ($(this).val() == accType)
                                $(this).prop('selected', true);
                            else
                                $(this).prop('selected', false);
                        });
                        $("#ddlAccType").selectpicker('refresh');

                         $("#ddlHeadName option").each(function () {
                            if ($(this).val() == headName)
                                $(this).prop('selected', true);
                            else
                                $(this).prop('selected', false);
                        });
                        $("#ddlHeadName").selectpicker('refresh');

                         $("#ddlSchemeName option").each(function () {
                            if ($(this).val() == schemeName)
                                $(this).prop('selected', true);
                            else
                                $(this).prop('selected', false);
                        });
                        $("#ddlSchemeName").selectpicker('refresh');

                         $("#ddlObjectName option").each(function () {
                            if ($(this).val() == objectName)
                                $(this).prop('selected', true);
                            else
                                $(this).prop('selected', false);
                        });
                        $("#ddlObjectName").selectpicker('refresh');

                         $("#ddlBankName option").each(function () {
                            if ($(this).val() == bankName)
                                $(this).prop('selected', true);
                            else
                                $(this).prop('selected', false);
                        });
                        $("#ddlBankName").selectpicker('refresh');

                         $("#ddlPayType option").each(function () {
                            if ($(this).val() == payType)
                                $(this).prop('selected', true);
                            else
                                $(this).prop('selected', false);
                        });
                        $("#ddlPayType").selectpicker('refresh');


                    },

                    error: function () {
                        alert("Error while retrieving data of :" + id);
                    }
                });

                $('#btnSubmit').text('Update');
            });
        });

    </script>
    <%--For Control Event--%>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#profile-tab").click(function () {
                $("#pnlSchemeDetail").show();
            });

            $("#add-tab").click(function () {
                $("#pnlSchemeDetail").hide();
            });
        });

        function onPayTypeChange() {
            var payType = $('#ddlPayType').val();
            if (payType == 12) {
                $('[for="txtChequeNo"]').text('Cheque No.');
                $('[for="txtChequeDate"]').text('Cheque Date');
            }
            else {
                $('[for="txtChequeNo"]').text('Ref. No.');
                $('[for="txtChequeDate"]').text('Ref. Date');
            }
        }

    </script>

    <%-- Insert/Update/Delete Operation --%>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnSubmit").click(function () {
                if (isValid) {

                    var bookingBudget = {};
                    var BookingKey = parseInt($('#bookingid').val());

                    bookingBudget.FinancialYear = $('#ddlFinYear').val();
                    bookingBudget.BudgetType = $('#ddlBudType').val();
                    bookingBudget.GrandCode = $('#txtGrantCode').val();
                    bookingBudget.SourceKey = $('#ddlFundSource').val();
                    bookingBudget.AccountType = $('#ddlAccType').val();

                    if ($('#ddlHeadName').val() != null) {
                        if ($('#ddlHeadName').val() != "")
                            bookingBudget.HeadNameKey = $('#ddlHeadName').val();
                    }
                    if ($('#ddlSchemeName').val() != null) {
                        if ($('#ddlSchemeName').val() != "")
                            bookingBudget.SchemeKey = $('#ddlSchemeName').val();
                    }

                    bookingBudget.ObjectKey = $('#ddlObjectName').val();

                    bookingBudget.GONo = $('#txtGONo').val();
                    bookingBudget.GODate = $('#txtGODate').val();

                    bookingBudget.BAmount = $('#txtAmount').val();

                    bookingBudget.BankKey = $('#ddlBankName').val();
                    bookingBudget.PaymentType = $('#ddlPayType').val();
                    bookingBudget.RefNo = $('#txtChequeNo').val();
                    bookingBudget.RefDate = $('#txtChequeDate').val();

                    if ($('#txtRemark').val().trim() != "") {
                        bookingBudget.Remark = ($('#txtRemark').val().trim());
                    }


                    bookingBudget.BookingKey = BookingKey;


                    $.ajax({
                        type: "POST",
                        url: "BudgetBooking.aspx/Create",
                        data: '{objBud_DeptBooking: ' + JSON.stringify(bookingBudget) + '}',
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
            });

            $(document).on("click", ".deleteButton", function () {
                var id = $(this).attr("data-id");

                if (confirm("Are you sure?")) {
                    $.ajax({
                        type: "Post",
                        contentType: "application/json; charset=utf-8",
                        url: "BudgetBooking.aspx/Delete",
                        data: '{intBookingKey: ' + id + '}',
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="content-container">
        <!--Page Title-->
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <div class="pageheader hidden-xs">
            <h3><i class="fa fa-home"></i>Booking of Budget </h3>
            <div class="breadcrumb-wrapper">
                <span class="label">You are here:</span>
                <ol class="breadcrumb">
                    <li><a href="#">Home </a></li>
                    <li class="active">Booking of Budget </li>
                </ol>

            </div>
        </div>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <!--End page title-->
        <form class="form-horizontal" id="bookingBudget">
            <input type="hidden" id="bookingid" name="bookingid" value="0" />
            <div id="page-content">
                <div class="row">
                    <div class="col-lg-12">
                        <!--Default Tabs (Left Aligned)-->
                        <!--===================================================-->
                        <div class="tab-base">
                            <!--Nav Tabs-->
                            <ul class="nav nav-tabs" id="scheme" role="tablist">
                                 <li class="nav-item active">
                                    <a class="nav-link active" id="profile-tab" data-toggle="tab" href="#tab-list-scheme" role="tab"
                                        aria-controls="profile" aria-selected="false">Booking of Budget Detail</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="add-tab" data-toggle="tab" href="#tab-add-scheme"
                                        role="tab" aria-controls="home" aria-selected="true">Add Booking of Budget</a>
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
                                                            <span class="col-md-10">Add Booking of Budget </span>
                                                        </h3>
                                                    </div>
                                                    <div class="panel-body mar-top">
                                                        <div class="row">
                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label class="control-label col-md-4" for="txtGrantCode">
                                                                        Grant
                                                                        Code</label>
                                                                    <div class="col-md-8">
                                                                        <input type="text" value="0017" class="form-control selectpicker"
                                                                            name="txtGrantCode" id="txtGrantCode"
                                                                            readonly />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label class="control-label col-md-4" for="ddlFinYear">
                                                                        Financial
                                                                        Year *</label>
                                                                    <div class="col-md-8">
                                                                        <select class="form-control selectpicker" name="ddlFinYear"
                                                                            id="ddlFinYear" required>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label class="control-label col-md-4" for="ddlBudType">
                                                                        Budget
                                                                        Type *</label>
                                                                    <div class="col-md-8">
                                                                        <select class="form-control selectpicker" name="ddlBudType"
                                                                            id="ddlBudType" required>
                                                                        </select>
                                                                    </div>
                                                                </div>

                                                            </div>
                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label class="control-label col-md-4" for="ddlAccType">
                                                                        Account
                                                                        Type *</label>
                                                                    <div class="col-md-8">
                                                                        <select class="form-control selectpicker" name="ddlAccType"
                                                                            id="ddlAccType" required>
                                                                        </select>
                                                                    </div>
                                                                </div>

                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label class="control-label col-md-4" for="ddlFundSource">
                                                                        Fund
                                                                        Source *</label>
                                                                    <div class="col-md-8">
                                                                        <select class="form-control selectpicker" name="ddlFundSource"
                                                                            id="ddlFundSource" required>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label class="control-label col-md-4" for="ddlHeadName">
                                                                        Head
                                                                        Name</label>
                                                                    <div class="col-md-8">
                                                                        <select class="form-control selectpicker" name="ddlHeadName"
                                                                            id="ddlHeadName">
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label class="control-label col-md-4" for="ddlSchemeName">
                                                                        Scheme
                                                                        Name
                                                                    </label>
                                                                    <div class="col-md-8">
                                                                        <select class="form-control selectpicker"
                                                                            data-live-search="true" data-placeholder="Choose a Scheme..."
                                                                            title="Choose a Scheme..." name="ddlSchemeName"
                                                                            id="ddlSchemeName">
                                                                        </select>
                                                                    </div>
                                                                </div>

                                                            </div>
                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label class="control-label col-md-4" for="ddlObjectName">
                                                                        Object
                                                                        Name *</label>
                                                                    <div class="col-md-8">
                                                                        <select class="form-control selectpicker"
                                                                            data-live-search="true" data-placeholder="Choose a Object..."
                                                                            title="Choose a Object..." name="ddlObjectName"
                                                                            id="ddlObjectName" required>
                                                                        </select>
                                                                    </div>
                                                                </div>

                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label class="control-label col-md-4" for="txtGONo">
                                                                        GO
                                                                        No *
                                                                    </label>
                                                                    <div class="col-md-8">
                                                                        <input type="text" class="form-control" name="txtGONo"
                                                                            id="txtGONo" required />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label class="control-label col-md-4" for="txtGODate">
                                                                        GO
                                                                        Date *
                                                                    </label>
                                                                    <div class="col-md-8">
                                                                        <input type="text" class="form-control" name="txtGODate"
                                                                            data-date-format='dd/mm/yyyy' placeholder="dd/mm/yyyy"
                                                                            data-bv-date="true" data-bv-date-format="DD/MM/YYYY"
                                                                            data-bv-date-message="The GO Date is not valid"
                                                                            id="txtGODate" required />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label class="control-label col-md-4" for="txtAmount">
                                                                        Amount
                                                                        *
                                                                    </label>
                                                                    <div class="col-md-8">
                                                                        <input type="text" class="form-control" name="txtAmount"
                                                                            id="txtAmount" required />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-6">
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label class="control-label col-md-4" for="ddlBankName">
                                                                        Bank
                                                                        Name *
                                                                    </label>
                                                                    <div class="col-md-8">
                                                                        <select class="form-control selectpicker" name="ddlBankName"
                                                                            data-live-search="true" data-placeholder="Choose a Bank..."
                                                                            title="Choose a Bank..." id="ddlBankName"
                                                                            required>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label class="control-label col-md-4"
                                                                        for="ddlPayType">
                                                                        Payment Type *
                                                                    </label>
                                                                    <div class="col-md-8">
                                                                        <select class="form-control selectpicker" name="ddlPayType"
                                                                            id="ddlPayType" onchange="onPayTypeChange();"
                                                                            required>
                                                                        </select>
                                                                    </div>
                                                                </div>

                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label class="control-label col-md-4" for="txtChequeNo">
                                                                        Cheque No *
                                                                    </label>
                                                                    <div class="col-md-8">
                                                                        <input type="text" class="form-control" name="txtChequeNo"
                                                                            id="txtChequeNo" required />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label class="control-label col-md-4" for="txtChequeDate">
                                                                        Cheque Date *
                                                                    </label>
                                                                    <div class="col-md-8">
                                                                        <input type="text" class="form-control" name="txtChequeDate"
                                                                            id="txtChequeDate" data-date-format='dd/mm/yyyy'
                                                                            placeholder="dd/mm/yyyy" data-bv-date="true"
                                                                            data-bv-date-format="DD/MM/YYYY"
                                                                            data-bv-date-message="The GO Date is not valid" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="form-group">
                                                                    <label class="control-label col-md-2" for="txtRemark">
                                                                        Remark
                                                                    </label>
                                                                    <div class="col-md-10">
                                                                        <textarea class="form-control" name="txtRemark"
                                                                            rows="4" id="txtRemark">
                                                                        </textarea>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="panel-footer">
                                                        <div class="row">
                                                            <div class="col-sm-7 col-sm-offset-3">
                                                                <button id="btnSubmit" class="btn btn-info btn-lg" type="submit">Submit</button>
                                                                <button class="btn btn-warning btn-lg" id="btnCancel"
                                                                    type="reset">
                                                                    Cancel</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="tab-list-scheme" class="tab-pane fade  active in">
                                    <div id="page-content2">
                                        <div class="row">
                                            <!-- Row selection (single row) -->
                                            <!--===================================================-->
                                            <div class="panel" id="pnlSchemeDetail">
                                                <div class="panel-heading">
                                                    <h3 class="panel-title">Budget Booking <strong>Details</strong></h3>
                                                </div>
                                                <div class="panel-body">
                                                        <table id="demo-dt-selection" class="table table-striped table-bordered">
                                                            <thead>
                                                                <tr>
                                                                    <th class="min-desktop" style="width: 5%; text-align: center">S.No.</th>
                                                                    <th class="min-desktop" style="width: 5%;">Financial Year</th>
                                                                    <th class="min-desktop" style="width: 5%;">Budget Type</th>
                                                                    <th class="min-desktop" style="width: 5%;">Fund
                                                                    Source</th>
                                                                    <th class="min-desktop" style="width: 5%;">Head Name</th>
                                                                    <th class="min-desktop" style="width: 15%;">Scheme
                                                                    Name</th>
                                                                    <th class="min-desktop" style="width: 15%;">Object
                                                                    Name</th>
                                                                    <th class="min-desktop" style="width: 10%;">GO No</th>
                                                                    <th class="min-desktop" style="width: 10%;">GO
                                                                    Date</th>
                                                                    <th class="min-desktop" style="width: 10%;">Sanction Amount
                                                                    </th>
                                                                    <th class="min-desktop" style="width: 5%;">Payment Type</th>
                                                                    <th class="min-desktop" style="width: 5%;">Cheque No</th>
                                                                    <th class="min-desktop" style="width: 5%;">Cheque
                                                                    Date</th>
                                                                    <th class="min-desktop" style="width: 10%; text-align: center;">Action</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <% for (var data = 0; data < dtDetail.Rows.Count; data++)
                                                                   { %>
                                                                <tr>
                                                                    <td style="width: 5%; text-align: center">
                                                                        <%= data + 1 %>. </td>
                                                                    <td style="width: 5%;">
                                                                        <%=dtDetail.Rows[data]["FinancialYear"].ToString()%>
                                                                    </td>
                                                                    <td style="width: 5%;">
                                                                        <%=dtDetail.Rows[data]["BudgetType"].ToString()%>
                                                                    </td>
                                                                    <td style="width: 5%;">
                                                                        <%=dtDetail.Rows[data]["FundSource"].ToString()%>
                                                                    </td>
                                                                    <td style="width: 5%;">
                                                                        <%=dtDetail.Rows[data]["HeadName"].ToString()%>
                                                                    </td>

                                                                    <td style="width: 10%;">
                                                                        <%=dtDetail.Rows[data]["SchemeName"].ToString()%>
                                                                    </td>
                                                                    <td style="width: 10%;">
                                                                        <%=dtDetail.Rows[data]["ObjectName"].ToString()%>
                                                                    </td>
                                                                    <td style="width: 10%;">
                                                                        <%=dtDetail.Rows[data]["GONo"].ToString()%>
                                                                    </td>
                                                                    <td style="width: 10%;">
                                                                        <%=dtDetail.Rows[data]["GODate"].ToString()%>
                                                                    </td>
                                                                    <td style="width: 10%;">
                                                                        <%=dtDetail.Rows[data]["BAmount"].ToString()%>
                                                                    </td>
                                                                    <td style="width: 5%;">
                                                                        <%=dtDetail.Rows[data]["PaymentType"].ToString()%>
                                                                    </td>
                                                                    <td style="width: 5%;">
                                                                        <%=dtDetail.Rows[data]["RefNo"].ToString()%>
                                                                    </td>
                                                                    <td style="width: 5%;">
                                                                        <%=dtDetail.Rows[data]["RefDate"].ToString()%>
                                                                    </td>
                                                                    <td style="width: 10%; text-align: center;">
                                                                        <div class="btn-group btn-group-xs">
                                                                            <a href="#" class="btn btn-info btn-icon icon-lg fa fa-edit editButton"
                                                                                data-id="<%=dtDetail.Rows[data]["BookingKey"]
                                                                        %>"
                                                                                data-placement="top"
                                                                                data-original-title="Edit"></a>
                                                                            <a href="#" class="btn btn-danger btn-icon icon-lg fa fa-trash deleteButton"
                                                                                data-id="<%=dtDetail.Rows[data]["BookingKey"]
                                                                        %>"
                                                                                data-placement="top"
                                                                                data-original-title="Remove"></a>
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
