<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DivisionMaster.master" AutoEventWireup="true" CodeFile="DBTBillList.aspx.cs" Inherits="Division_DBTBillList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .panel-heading {
            background-color: #f9f9f9 !important;
        }

        .panel-title {
            line-height: 44px !important;
        }

        .modal-header {
            background-color: #03a9f4;
            border-radius: 4px 4px 0 0 !important;
            color: #fff;
        }

            .modal-header h5 {
                font-weight: 600;
            }

        .modal-content {
            border-radius: 4px 4px !important;
        }
    </style>
    <script src="<%=ResolveUrl("~/js/jquery-2.1.1.min.js") %>"></script>
    <script type="text/javascript">
        var isValid = false
        $(document).ready(function () {

            $("#btnDBTUpdate").click(function () {
                $('#frmDBTStatus').bootstrapValidator('validate');
            });

            $('#frmDBTStatus').bootstrapValidator({
                framework: 'bootstrap',
                icon: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    TokenNo: {
                        row: '.clsDBTStatus',
                        validators: {
                            notEmpty: {
                                message: 'टोकन संख्या डालें!'
                            }
                        }
                    },
                    DBTDate: {
                        row: '.clsDBTStatus',
                        validators: {
                            notEmpty: {
                                message: 'DBT दिनांक डालें!'
                            },
                            date: {
                                format: 'DD/MM/YYYY',
                                message: 'अमान्य DBT दिनांक। दिनांक प्रारुप "DD/MM/YYYY" हैं।'
                            }
                        }
                    },

                }
            }).on('error.field.bv', function (e, a) {
                $('#btnDBTUpdate').attr("disabled", "disabled");
                isValid = false;
            }).on('error.form.bv', function (e, a) {
                $('#btnDBTUpdate').attr("disabled", "disabled");
                isValid = false;
            }).on('success.field.bv', function () {
                $('#btnDBTUpdate').removeAttr("disabled");
                isValid = true;
            }).on('success.form.bv', function () {
                $('#btnDBTUpdate').removeAttr("disabled");
                isValid = true;
            });
        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#tblBillList tbody').empty();
            $.ajax({
                type: "Post",
                contentType: "application/json; charset=utf-8",
                url: "DBTBillList.aspx/GetDBT_BillList",
                data: '{}',
                dataType: "json",
                success: function (data) {
                    var mst = $.parseJSON(data.d);
                    var id = 1;
                    var TotalBillAmount = 0;
                    $.each(mst, function (index, value) {
                        var row = '<tr><td style="text-align: center"><b>' + id + ' <input type="hidden" value="' + value.BillForwardingKey + '"/></b> </td>';
                        row = row + '<td>' + value.DistrictName + '</td>'
                        row = row + '<td>' + value.SchemeName + '</td>'
                        row = row + '<td style="text-align: center"><a href="DBTGenerateFile.aspx?key=' + value.BillForwardingKey + '"><u>' + value.TreasuryBillNo + '</u></a></td>'
                        row = row + '<td style="text-align: center">' + value.TreasuryBillDate + '</td>'
                        row = row + '<td style="text-align: center">' + value.TotalApplicant + '</td>'
                        row = row + '<td style="text-align: right">' + parseFloat(value.TotalAmount).toFixed(2) + '</td>'
                        row = row + '<td><a href="javascript:void(0)" class="btn btn-danger" data-id="' + value.BillForwardingKey + '" onclick="DBTStatus(this)" data-backdrop="static" data-keyboard="false" >DBT स्टेटस अपडेट करने हेतु क्लिक करें</a></td>'
                        row = row + '</tr>'

                        TotalBillAmount = parseFloat(TotalBillAmount) + parseFloat(value.TotalAmount);

                        id += 1;
                        $('#tblBillList tbody').append(row);
                    });
                    if (id == 1) {
                        var frow = '<tr><td colspan=8 style = "text-align:center"><b>कोई भी सूचना उपलब्ध नहीं हैं।</b></td><tr>';
                        $('#tblBillList tfoot').empty();
                        $('#tblBillList tfoot').append(frow);
                    }
                    else {
                        var frow = '<tr><td colspan=6 style = "text-align:right"><b>कुल योग</b></td><td colspan=1 style="text-align: right"><b>' + TotalBillAmount.toFixed(2) + '</b></td><td></td><tr>';
                        $('#tblBillList tfoot').empty();
                        $('#tblBillList tfoot').append(frow);
                    }

                },

                error: function () {
                    alert("Error while retrieving data of :" + id);

                }
            });


        });

        function DBTStatus(index) {
            var id = $(index).data('id');
            var tbno = $(index).closest('tr').find("td").eq(3).find("a").text();
            var tbdt = $(index).closest('tr').find("td").eq(4).html();
            var tbamt = $(index).closest('tr').find("td").eq(6).html();

            $('#lblTreasuryBillNo').text(tbno);
            $('#lblTreasuryBillAmount').text(tbamt);
            $('#lblTreasuryBillDate').text(tbdt);
            $('#hidBillForwardingKey').val(id);

            $("#DBTStatusModal").modal({
                backdrop: 'static',
                keyboard: false
            });
        }


    </script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#btnDBTUpdate').click(function (event) {

                if (isValid) {
                    var tokenno = $('#txtTokenNo').val();
                    var dbtdate = $('#txtDBTDate').val();
                    var billfkey = $('#hidBillForwardingKey').val();

                    if (isValid) {
                        $.ajax({
                            type: "POST",
                            url: "DBTBillList.aspx/Update_DBTTokenNo",
                            data: '{TokenNo: ' + JSON.stringify(tokenno) + ', DBTDate: ' + JSON.stringify(dbtdate) + ', billforwardingkey: ' + billfkey + '}',
                            dataType: "json",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                var gg = data.d
                                alert(gg);
                                $('#txtTokenNo').val('');
                                $('#txtDBTDate').val('');
                                $('#chkAgreeStatus').attr('checked', false);
                                $('#hidBillForwardingKey').val('');
                                $("#DBTStatusModal").modal('hide');
                                window.location.href = '../../DBT/Division/DBTBillList.aspx';
                            }
                        });
                    }
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
            <h3><i class="fa fa-home"></i>अनुदान हेतु बिल भुगतान गेट वे </h3>
            <div class="breadcrumb-wrapper">
                <%--  <span class="label">You are here:</span>--%>
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">होम </a></li>
                    <li class="active">अनुदान हेतु बिल भुगतान गेट वे </li>
                </ol>
            </div>
        </div>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <!--End page title-->
        <div id="page-content">
            <div id="frmDBTBillList" class="form-horizontal">

                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel">
                            <div class="panel-heading">
                                <h3 class="panel-title"><strong>डी० बी० टी० हेतु अनुदान वितरण गेटवे </strong></h3>
                            </div>
                            <!--No Label Form-->
                            <div class="panel-body" style="margin-top: -15px">
                                <h3 style="float: left">मण्डल :
                                    <asp:Label ID="lblLoginType" runat="server" Text=""></asp:Label></h3>
                                <h3 style="float: right">वित्तीय वर्ष  :
                                     <asp:Label ID="lblFinYear" runat="server" Text=""></asp:Label>
                                </h3>
                            </div>
                        </div>
                    </div>
                </div>


                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel">
                            <div class="panel-heading">
                                <h3 class="panel-title">योजनावार डी० बी० टी० बिल की सूची </h3>
                            </div>
                            <!--No Label Form-->
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="table-responsive">
                                            <table class="table table-bordered" id="tblBillList">
                                                <colgroup>
                                                    <col width="6%" />
                                                    <col width="10%" />
                                                    <col width="25%" />
                                                    <col width="15%" />
                                                    <col width="10%" />
                                                    <col width="8%" />
                                                    <col width="12%" />
                                                    <col width="10%" />
                                                </colgroup>
                                                <thead>
                                                    <tr>
                                                        <th style="text-align: center">क्रम स०</th>
                                                        <th>डी० बी० टी० नंबर</th>
                                                        <th>योजना का नाम</th>
                                                        <th style="text-align: center">ट्रेज़री बिल संख्या</th>
                                                        <th style="text-align: center">ट्रेज़री बिल दिनांक</th>
                                                        <th style="text-align: center">कुल लाभार्थी</th>
                                                        <th class="text-right">धनराशि (रु०)</th>
                                                        <th></th>

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
        <div class="modal fade bd-example-modal-lg form-horizontal" id="DBTStatusModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="myLargeModalLabel">DBT हस्तांतरण का विवरण व प्रमाणीकरण </h5>

                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>

                    </div>
                    <form id="frmDBTStatus">
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-lg-12">
                                    <table class="table table-bordered table-responsive" id="tblDBTStatus">
                                        <colgroup>
                                            <col width="34%" />
                                            <col width="32%" />
                                            <col width="32%" />

                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th>ट्रेज़री बिल संख्या</th>
                                                <th>धनराशी</th>
                                                <th>ट्रेज़री बिल दिनांक</th>

                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <input type="hidden" id="hidBillForwardingKey" />
                                                    <label id="lblTreasuryBillNo"></label>
                                                </td>
                                                <td>
                                                    <label id="lblTreasuryBillAmount"></label>
                                                </td>
                                                <td>
                                                    <label id="lblTreasuryBillDate"></label>
                                                </td>

                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="row">
                                <div class="panel-body">
                                    <div class="col-lg-12">
                                        <div class="col-md-5 clsDBTStatus">
                                            <div class="form-group">
                                                <label class="control-label">टोकन संख्या भरें <span style="color: red; font-size: 12px">(जो ट्रांजेक्शन फाइल जनरेट करते समय भरी गयी है)</span></label>
                                                <input type="text" id="txtTokenNo" name="TokenNo" class="form-control" />
                                            </div>
                                        </div>
                                        <div class="col-md-5 clsDBTStatus pull-right">
                                            <div class="form-group">
                                                <label class="control-label">DBT दिनांक <span style="color: red; font-size: 12px">(वह तिथि जिस दिन कृषक के खाते में DBT किया गया है)</span></label>
                                                <div class="input-group date" id="datePicker">
                                                    <input type="text" class="form-control" name="DBTDate" placeholder="DD/MM/YYYY" data-bv-date="true" id="txtDBTDate" />
                                                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>


                        </div>
                        <div class="modal-footer">
                            <div class="col-md-10 pull-left">
                                <div class="form-group checkbox">
                                    <label>
                                        <input type="checkbox" name="DBTAgreeStatus" value="DBTAgreeStatus" id="chkAgreeStatus" data-bv-choice="true"
                                            data-bv-choice-min="1" data-bv-choice-max="1" data-bv-choice-message=" " />
                                        <span style="font-size: 12px; font-weight: 600">प्रमाणित किया जाता है कि इस ट्रेज़री बिल को जांच कर बिल में शामिल सभी लाभार्तियों के बैंक खातें में DBT उक्त विवरण अनुसार किया गया |
                                        </span>
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-2 pull-right">
                                <button type="button" class="btn btn-warning" id="btnDBTUpdate">DBT सुरक्षित करें</button>
                            </div>


                        </div>
                    </form>
                </div>
            </div>
        </div>

    </div>
    <script src="<%=ResolveUrl("~/plugins/bootstrap-validator/bootstrapValidator.min.js") %>"></script>
    <!--jQuery [ REQUIRED ]-->
    <script src="<%=ResolveUrl("~/js/jquery-2.1.1.min.js") %>"></script>
    <!--Jasmine Admin [ RECOMMENDED ]-->
    <script src="<%=ResolveUrl("~/js/scripts.js") %>"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#datePicker').datepicker({
                format: 'dd/mm/yyyy',
                autoclose: true,
                todayHighlight: true
            })
            //    .on('changeDate', function (e) {
            //    // Revalidate the date field
            //    //$('#frmDBTStatus').data('bootstrapValidator').revalidateField('DBTDate');
            //    $('#frmDBTStatus').bootstrapValidator('revalidateField', $('DBTDate'));
            //});;

       .on('changeDate', function (e) {
           // Revalidate the date when user change it
           $('#frmDBTStatus').bootstrapValidator('revalidateField', 'DBTDate');
           isValid = true;
       });
        });

    </script>
</asp:Content>

