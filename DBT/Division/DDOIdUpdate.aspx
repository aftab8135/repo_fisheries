<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DivisionMaster.master" AutoEventWireup="true" CodeFile="DDOIdUpdate.aspx.cs" Inherits="Division_DDOIdUpdate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script src="../../js/jquery-2.1.1.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        var isValid = false
        $(document).ready(function () {
            $('#frmBeneficiary').bootstrapValidator({
                framework: 'bootstrap',
                icon: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    RegistrationNo: {
                        row: '.col-lg-4',
                        validators: {
                            notEmpty: {
                                message: 'पंजीकरण संख्या डालें!'
                            }
                        }
                    },
                    BeneficiaryId: {
                        row: '.col-lg-4',
                        validators: {
                            notEmpty: {
                                message: 'बेनेफिसिअरी आई. डी. डालें!'
                            }
                        }
                    }
                }
            }).on('success.field.bv', function (e, data) {
                isValid = true;
            });
        });
    </script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#btnMappedbeneficiaryId').click(function (event) {
                if (isValid) {
                    var regno = $('#txtRegistrationNo').val();
                    var beneficiaryId = $('#txtBeneficiaryId').val();
                    if (isValid) {
                        $.ajax({
                            type: "POST",
                            url: "DDOIdUpdate.aspx/MappedBeneficiaryId",
                            data: '{RegistrationNo: ' + regno + ',BeneficiaryId: ' + beneficiaryId + '}',
                            dataType: "json",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                var gg = data.d
                                alert(gg);
                            }
                        });
                    }
                }
            });
        });
    </script>

    <style>
        .panel-heading {
            background-color: #f9f9f9 !important;
        }

        .panel-title {
            line-height: 44px !important;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="content-container">
        <!--Page Title-->
        <!--------------------------------------------------------->
        <div class="pageheader hidden-xs">
            <h3><i class="fa fa-home"></i>डी० डी० ओ० पोर्टल आई डी अपडेट </h3>
            <div class="breadcrumb-wrapper">
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">होम </a></li>
                    <li class="active">डी० डी० ओ० पोर्टल आई डी अपडेट </li>
                </ol>
            </div>
        </div>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <!--End page title-->
        <div id="page-content">
            <div id="frmBeneficiary" class="form-horizontal">

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
                                <h3 class="panel-title">डी० डी० ओ० पोर्टल आई डी अपडेट </h3>
                            </div>
                            <!--No Label Form-->
                            <div class="panel-body">
                                <!-- Inline Form  -->
                                <!--===================================================-->
                                <div class="row mar-top">
                                    <div class="col-lg-4">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="col-lg-4 control-label">पंजीकरण संख्या </label>
                                                <div class="col-lg-8">
                                                    <input type="text" class="form-control" name="RegistrationNo" id="txtRegistrationNo" placeholder="पंजीकरण संख्या" />
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>
                                    <div class="col-lg-4">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="col-lg-5 control-label">
                                                    बेनेफिसिअरी आई. डी
                                                    <br />
                                                    <span style="font-size: 12px; color: red">(डी.डी.ओ. पोर्टल के अनुसार) </span>
                                                </label>

                                                <div class="col-lg-7">
                                                    <input type="text" class="form-control" name="BeneficiaryId" id="txtBeneficiaryId" placeholder="बेनेफिसिअरी आई. डी." />

                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>

                                    <div class="col-lg-2">
                                        <fieldset>
                                            <button class="btn btn-warning" type="submit" id="btnMappedbeneficiaryId">सुरक्षित करें </button>
                                        </fieldset>
                                    </div>

                                </div>
                            </div>

                        </div>
                    </div>
                </div>


            </div>
        </div>
    </div>

    <script src="../../plugins/bootstrap-validator/bootstrapValidator.min.js"></script>
    <script src="../../js/demo/form-validation.js"></script>

</asp:Content>

