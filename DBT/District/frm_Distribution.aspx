<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DistrictMaster.master" AutoEventWireup="true" CodeFile="frm_Distribution.aspx.cs" Inherits="District_frm_Distribution" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="<%=ResolveUrl("~/js/jquery-2.1.1.min.js") %>"></script>

    <%-- Define Validation Rule --%>
    <script type="text/javascript">
        var isValid = true;
        var unitType = [];
        var nosDoc = 0;
        //$(document).ready(function () {
        //    $('#documentModal').bootstrapValidator({
        //        framework: 'bootstrap',
        //        icon: {
        //            valid: 'glyphicon glyphicon-ok',
        //            invalid: 'glyphicon glyphicon-remove',
        //            validating: 'glyphicon glyphicon-refresh'
        //        },
        //        fields: {
        //                           }
        //    }).on('success.field.bv', function () {
        //        isValid = true;
        //    }).on('error.field.bv', function () {
        //        isValid = false;
        //    });
        //})

        $(document).ready(function () {
            $('#frmDBTDistrict').bootstrapValidator({
                framework: 'bootstrap',
                icon: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                }
            }).on('error.field.bv', function () {
                isValid = false;
            }).on('success.field.bv', function () {
                isValid = true;
            });

             $.ajax({
                type: "POST",
                url: "frm_Distribution.aspx/GetRegCode",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var ddl = $("#<%=ddlRegCode.ClientID%>").empty();
                    ddl.append($("<option selected disabled hidden></option>").val('').html('चयन करें'));
                    $.each(r.d, function () {
                        ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    ddl.selectpicker('refresh');
                }
            });
        });
    </script>

    <%-- Find Applicant By Code --%>
    <script type="text/javascript">
        
        function getApplicantDetail() {
            event.preventDefault();
            var regCode = $('#<%=ddlRegCode.ClientID%> option:selected').val();
            if (regCode > 0) {
                $.ajax({
                    type: "Post",
                    contentType: "application/json; charset=utf-8",
                    url: "frm_Distribution.aspx/GetRegApplicantByCode",
                    data: '{regkey: "' + regCode + '"}',
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            $('#pnlFarmerDetail').show();
                            $('#pnlBankDetail').show();
                            $('#pnlInstallmentDetail').show();
                            $('#pnlLandDetail').show();

                            $('#tblFarmer tbody').empty();
                            $('#tblLandDet tbody').empty();
                            $('#tblBankDet tbody').empty();

                           

                            var applicantReg = $.parseJSON(data.d);
                            var formarRow = "";
                            var bankRow = "";
                            var sr = 1;
                            var totolArea = 0;

                            $.each(applicantReg, function (index, value) {

                                farmerRow = "<tr><td>" + value.FarmerName + "</td> <td>" + value.FatherName + "</td> <td>" + value.VillageName + "</td> <td>" + value.MobileNo + "</td>  <td>" + value.CasteName + "</td> </tr>";
                                bankRow = "<tr><td>" + value.BankName + "</td> <td>" + value.BankBranch + "</td> <td>" + value.IFSCCode + "</td> <td>" + value.AccountNo + "</td> </tr>";

                                var landRow = "<tr><td class='text-center'>" + sr + "</td> <td>" + value.Khatauni + "</td> <td style='text-align: right'>" + value.Area + "</td> <td>" + value.Unit + "</td> </tr>";
                                $('#tblLandDet tbody').append(landRow);

                                $('#hdRegKey').val(value.RegistrationKey);

                                $('#hdRegCod').val(value.RegistrationCode);

                                totolArea = parseFloat(totolArea) + parseFloat(value.Area)

                                sr = sr + 1;

                            });

                            var landFoot = "<tr><td colspan = 2 class='text-right'><b>कुल योग</b></td> <td style='text-align:right'><b>" + totolArea + "</b></td> <td></td> </tr>";
                            $('#tblLandDet tfoot').append(landFoot);


                            $('#tblFarmer tbody').append(farmerRow);
                            $('#tblBankDet tbody').append(bankRow);

                            $('#pnlRegistrationDate').show();
                            $('#divFarmerDetailsExist').show();
                            $('#divLandDetailsExist').show();
                            $('#divSchemeDetails').show();
                            $('#divBankDetailsExist').show();

                        //    $('#hdRegCod').prop('readonly', true);
                          //  $('#btnSearch').prop('disabled', true);

                            getSchemebyRegCode();
                        } else {
                            alert('पंजीकरण संख्या का विवरण मौजूद नहीं है।');
                        }
                    },
                    error: function () {
                        alert("Error while retrieving data of :" + id);
                    }
                });
            }
            else {
                alert('कृपया पंजीकरण संख्या डालें।');
            }
        }
    </script>

    <%-- For Control Event --%>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#pnlRegistrationDate').hide();
            $('#pnlFarmerDetail').hide();
            $('#pnlBankDetail').hide();
            $('#pnlInstallmentDetail').hide();
            $('#pnlLandDetail').hide();
           // $('#hdRegCod').prop('readonly', false);
            $('#btnDocClose').hide();
            $('#btnCancel').click(function () {
                window.location.reload();
            });
        });

        function getSchemebyRegCode() {
            var regCode = $('#hdRegCod').val();
            if (regCode.toString().trim() != "") {
                $.ajax({
                    type: "POST",
                    url: "frm_Distribution.aspx/GetSchemes",
                    data: '{RegCode:' + regCode + '}',
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
            var regCode = $('#hdRegCod').val();
            $("[id*=ddlProgressType]").empty();
            if (schemeId > 0) {
                $.ajax({
                    type: "POST",
                    url: "frm_Distribution.aspx/GetWorkType",
                    data: '{schemeID : ' + schemeId + ', RegCode:' + regCode + '}',
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
            var regCode = $('#hdRegCod').val();
            $("[id*=ddlWorkInstallment]").empty();
            if (schemeId > 0) {
                $.ajax({
                    type: "POST",
                    url: "frm_Distribution.aspx/GetWorkIntallment",
                    data: '{schemeID : ' + schemeId + ', workTypeID : ' + workTypeId + ', RegCode:' + regCode + '}',
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

        function getWorkInstallmentAmount() {
            var schemeId = $("#ddlSchemeName").val();
            var workTypeId = $("#ddlProgressType").val();
            var regCode = $('#hdRegCod').val();
            var workIns = $('#ddlWorkInstallment').val();

            if (schemeId > 0 && workTypeId > 0 && regCode != "" && workIns > 0) {
                $.ajax({
                    type: "Post",
                    contentType: "application/json; charset=utf-8",
                    url: "frm_Distribution.aspx/GetWorkIntallmentAmount",
                    data: '{schemeID : ' + schemeId + ', workTypeID : ' + workTypeId + ', RegCode:' + regCode + ', insId:' + workIns + '}',
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var workInsAmount = $.parseJSON(data.d);
                            $.each(workInsAmount, function (index, value) {
                                $('#txtProjectCost').val(value.LandAmount);
                                $('#txtBenCost').val(value.BenLandAmount);
                                $('#txtSubsCost').val(value.SubsLandAmount);
                                $('#txtInstAmount').val(value.InsSlabeAmount);
                            });
                        }
                    },
                    error: function () {
                        $('#documentModal').modal('hide');
                        alert("Error while retrieving data of :" + id);
                    }
                });
            }
        }

        function getDocumentByWorkInstallment() {
            var WorkTypeId = $("#ddlProgressType").val();
            var InsDetailKey = $('#ddlWorkInstallment').val();
            var regCode = $('#hdRegCod').val();
            if (WorkTypeId > 0 && InsDetailKey > 0 && regCode.toString().trim() != "") {
                $('#pnlUploadFiles').empty();
                nosDoc = 0;
                $.ajax({
                    type: "Post",
                    contentType: "application/json; charset=utf-8",
                    url: "frm_Distribution.aspx/GetDocumentByWorkInstallment",
                    data: '{WorkTypeID : ' + WorkTypeId + ', InsDetailKey : ' + InsDetailKey + '}',
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var workDocument = $.parseJSON(data.d);
                            $.each(workDocument, function (index, value) {

                                var fudiv = '<div class="form-group">'
                                fudiv = fudiv + '<label for="demo-vs-errinput" class="control-label">'
                                fudiv = fudiv + '' + value.DocumentName + '</label>'
                                fudiv = fudiv + '<label class="pull-right colorCss">Allowed Only Pdf/jpg/png/jpeg File, Max Size 1 MB</label>'
                                fudiv = fudiv + '<input type="file" accept="application/pdf,image/jpeg,image/png" id="hd_' + value.DocumentKey + '" class="form-control" name="DocFileUpload""/>'
                                fudiv = fudiv + '<input type="hidden" id="hd_' + value.DocumentKey + '" name="docKey" value="' + value.DocumentKey + '" />'
                                fudiv = fudiv + '</div>'

                                //var fudiv = '<div class="row"> <div class="form-group">';
                                //fudiv = fudiv + '<label class="col-sm-4 control-label" style="text-align:left"> ' + value.DocumentName + ' </label>';
                                //fudiv = fudiv + '<div class="col-sm-8">';
                                //fudiv = fudiv + '<input type="file" class="form-control" type="file" accept="application/pdf,image/jpeg,image/png" id="fu_' + value.DocumentKey + '" name="DocFileUpload"';
                                //fudiv = fudiv + ' /><input type="hidden" id="hd_' + value.DocumentKey + '" name="docKey" value="' + value.DocumentKey + '" />'
                                //fudiv = fudiv + '</div></div></div>'
                                
                                $('#pnlUploadFiles').append(fudiv);

                            });

                        }
                        $('#ancDocument').click();
                    },
                    error: function () {
                        $('#documentModal').modal('hide');
                        alert("Error while retrieving data of :" + id);
                    }
                });
            }
        }
    </script>

    <%--For Insert/Update Record --%>
    <script type="text/javascript">
        $(document).ready(function () {
            var documents = [];
            var dataFiles = new FormData();
            $("#btnDocSave").click(function () {
                var regCode = $('#hdRegCod').val();
                if ($('#ddlSchemeName').val() != null && $('#ddlProgressType').val() != null && $('#ddlWorkInstallment').val() != null && $('#hdRegCod').val() != "") {
                    var count = 1;
                    dataFiles.append("RegCode", regCode);
                    if ($("input[name$=DocFileUpload]").length > 0) {
                        for (var i = 0; i < $("input[name$=DocFileUpload]").length; i++) {
                            fileUpload = $("input[name$=DocFileUpload]").get(i);
                            files = fileUpload.files;
                            if (files.length > 0) {
                                dataFiles.append(count++, $($("input[name$=docKey]").get(i)).val());
                                dataFiles.append(files[0].name, files[0]);
                            }
                        }
                        if (count > $("input[name$=DocFileUpload]").length) {
                            $("#btnDocClose").click();
                        }
                        else {
                            alert('कृपया आवश्यक दस्तावेज को संलग्न करें।');
                            event.preventDefault();
                        }
                    }                    
                }
                else {
                    alert('कृपया आवश्यक प्रविष्टियों का चयन करें।');
                    event.preventDefault();
                }
            });

            $("#btnSubmit").click(function () {
                var regCode = $('#hdRegKey').val();
                if ($('#ddlSchemeName').val() == null || $('#ddlProgressType').val() == null || $('#ddlWorkInstallment').val() == null || $('#txtInstAmount').val() == null || regCode == 0) {
                    alert('Please Fill Primary Entries.');
                    event.preventDefault();
                }
                else if ($('#ddlSchemeName').val() != null && $('#ddlProgressType').val() != null && $('#ddlWorkInstallment').val() != null && $('#txtInstAmount').val() != null && regCode != 0) {
                    if (isValid) {
                        $('body').Wload({ text: ' Loading' });
                        event.preventDefault();
                        var appInsMst = {};
                        var appInsDets = [];
                        var appInsDet = {};
                        var appDocs = [];

                        appInsMst.RegistrationKey = regCode;
                        appInsMst.SchemeKey = $('#ddlSchemeName').val();
                        appInsMst.ProjectCost = $('#txtProjectCost').val();
                        appInsMst.BenCost = $('#txtBenCost').val();
                        appInsMst.SubCost = $('#txtSubsCost').val();
                        appInsMst.FinYear = $('#<%=lblFinYear.ClientID%>').text();


                        appInsDet.WorkTypeKey = $('#ddlProgressType').val();
                        appInsDet.InstallmentKey = $('#ddlWorkInstallment').val();
                        appInsDet.InstallmentAmount = $('#txtInstAmount').val();

                        appInsDets.push(appInsDet);

                        appInsMst.Installments = appInsDets;

                        $.ajax({
                            url: "FileUploadHandler.ashx",
                            type: "POST",
                            //async: false,
                            data: dataFiles,
                            contentType: false,
                            processData: false,

                            success: function (data) {
                                if (data == "Error") {
                                    alert('संलग्न दस्तावेजों में त्रुटि।');
                                    event.preventDefault();
                                }
                                else if (data == "NoFiles") {
                                    alert('कृपया आवश्यक दस्तावेज को संलग्न करें।');
                                    event.preventDefault();
                                }
                                else if (data != "Error" && data != "NoFiles") {
                                    var docList = $.parseJSON(data);
                                    if (docList.length > 0) {
                                        appInsMst.InsDocuments = docList;
                                        $.ajax({
                                            type: "POST",
                                            url: "frm_Distribution.aspx/Create",
                                            data: '{objDBT_InsDistributionMaster: ' + JSON.stringify(appInsMst) + '}',
                                            contentType: "application/json; charset=utf-8",
                                            dataType: "json",
                                            success: function (response) {
                                                data = (response.d);
                                                if (data != "") {
                                                    alert(data);
                                                    window.location.href = "frm_Distribution.aspx";
                                                }
                                                else {
                                                    alert('कृपया पुनः प्रयास करें।')
                                                    event.preventDefault();
                                                }
                                            },
                                            error: function (err) {
                                                alert(err.statusText)
                                            }
                                        });
                                    }
                                    else {
                                        alert('कृपया आवश्यक दस्तावेज को संलग्न करें।');
                                        event.preventDefault();
                                    }
                                } else {
                                    alert('दस्तावेजों के संलग्न में अज्ञात त्रुटि प्राप्त । ');
                                    event.preventDefault();
                                }
                            },
                            error: function (err) {
                                alert(err.statusText);
                            }
                        });

                    }
                    else {
                        alert('कृपया पुनः प्रयास करें।')
                        event.preventDefault();
                    }
                }
                else {
                    event.preventDefault();
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

        .colorCss {
            color: red;
            font-size: 12px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="content-container">
        <!--Page Title-->
        <!--------------------------------------------------------->
        <div class="pageheader hidden-xs">
            <h3><i class="fa fa-home"></i>नया वितरण </h3>
            <div class="breadcrumb-wrapper">
                <%--  <span class="label">You are here:</span>--%>
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">होम </a></li>
                    <li class="active">नया वितरण </li>
                </ol>
            </div>
        </div>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <!--End page title-->

        <div id="page-content">


            <div class="row">
                <div class="col-lg-12">
                    <div class="panel">
                        <div class="panel-heading">
                            <h3 class="panel-title"><strong>डी० बी० टी० हेतु अनुदान वितरण गेटवे </strong></h3>
                        </div>
                        <!--No Label Form-->
                        <div class="panel-body" style="margin-top: -15px">
                            <h3 style="float: left">जनपद :
                                <asp:Label ID="lblLoginType" runat="server" Text="कानपुर नगर"></asp:Label></h3>
                            <h3 style="float: right">वित्तीय वर्ष  :
                                     <asp:Label ID="lblFinYear" runat="server" Text="2018-2019"></asp:Label>

                            </h3>

                            <%--<div class="form-group">
                                <label class="col-sm-6 control-label">100% कार्य पूर्ण के फोटोग्राफ निर्माणकार्य की ऍम. वी. </label>
                                <div class="col-sm-6">
                                    <input type="file" class="form-control" id="fu_4" name="DocFileUpload" data-bv-file="true" data-bv-file-extension="pdf" data-bv-file-message="अमान्य संलग्न।" data-bv-file-type="application/pdf">
                                    <input type="hidden" id="hd_4" name="docKey" value="4">
                                </div>
                            </div>--%>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-12">
                    <div class="panel">
                        <%--  <div class="panel-heading">
                                <h3 class="panel-title"> </h3>
                            </div>--%>
                        <!--No Label Form-->
                        <div class="panel-body">
                            <!-- Inline Form  -->
                            <!--===================================================-->
                            <div class="row mar-top">
                                <div class="col-lg-6">
                                    <fieldset>
                                        <div class="form-group">
                                            <label class="col-lg-3 control-label">पंजीकरण संख्या </label>
                                            <div class="col-lg-9">
                                                <%--<input type="text" class="form-control" name="farmername3" placeholder="पंजीकरण संख्या" id="hdRegCod" />--%>
                                                  <asp:DropDownList ID="ddlRegCode" CssClass="form-control selectpicker" runat="server" data-live-search="true">
                                                  </asp:DropDownList>
                                                <input type="hidden" id="hdRegKey" value="" />
                                                <input type="hidden" id="hdRegCod" value="" />
                                            </div>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-lg-2">
                                    <fieldset>
                                        <button class="btn btn-warning" type="button" onclick="getApplicantDetail();" id="btnSearch">खोजें </button>
                                    </fieldset>
                                </div>

                            </div>
                        </div>

                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-12">
                    <div class="panel" id="pnlFarmerDetail">
                        <div class="panel-heading">
                            <h3 class="panel-title">कृषक का विवरण </h3>
                        </div>
                        <!--No Label Form-->

                        <div class="panel-body">
                            <!--IDENTICAL VALIDATOR-->
                            <!--===================================================-->

                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="table-responsive">
                                        <table class="table table-bordered" id="tblFarmer">
                                            <colgroup>

                                                <col width="25%" />
                                                <col width="20%" />
                                                <col width="25%" />
                                                <col width="10%" />
                                                <col width="10%" />
                                            </colgroup>
                                            <thead>
                                                <tr>
                                                    <th>कृषक का नाम</th>
                                                    <th>पिता का नाम</th>
                                                    <th>गाँव का नाम</th>
                                                    <th>मोबाइल न०</th>
                                                    <th>जाति</th>

                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <!--===================================================-->
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-12">
                    <div class="panel" id="pnlLandDetail">
                        <div class="panel-heading">
                            <h3 class="panel-title">तालाब का विवरण </h3>
                        </div>
                        <!--No Label Form-->

                        <div class="panel-body">
                            <!--IDENTICAL VALIDATOR-->
                            <!--===================================================-->

                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="table-responsive">
                                        <table class="table table-bordered" id="tblLandDet">
                                            <colgroup>
                                                <col width="5%" />
                                                <col width="55%" />
                                                <col width="20%" />
                                                <col width="20%" />
                                            </colgroup>
                                            <thead>
                                                <tr>
                                                    <th style="text-align: center">क्रम स०</th>
                                                    <th>खतौनी/घाटा संख्या</th>
                                                    <th style='text-align: right'>क्षेत्रफल</th>
                                                    <th>यूनिट</th>
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

                            <!--===================================================-->
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-12">
                    <div class="panel" id="pnlBankDetail">
                        <div class="panel-heading">
                            <h3 class="panel-title">बैंक का विवरण </h3>
                        </div>
                        <!--No Label Form-->
                        <div class="panel-body">
                            <!-- Inline Form  -->
                            <!--===================================================-->
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="table-responsive">
                                        <table class="table table-bordered" id="tblBankDet">
                                            <colgroup>

                                                <col width="30%" />
                                                <col width="30%" />
                                                <col width="25%" />
                                                <col width="15%" />

                                            </colgroup>
                                            <thead>
                                                <tr>
                                                    <th>बैंक का नाम</th>
                                                    <th>बैंक की शाखा</th>
                                                    <th>खाता संख्या</th>
                                                    <th>IFSC कोड</th>

                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-12">
                    <div class="panel" id="pnlInstallmentDetail">
                        <div class="panel-heading">
                            <h3 class="panel-title">अनुदानित वस्तु  </h3>
                        </div>
                        <!--No Label Form-->
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="">
                                        <table class="table table-bordered table-responsive">
                                            <colgroup>
                                                <col width="5%" />
                                                <col width="25%" />
                                                <col width="10%" />
                                                <col width="12%" />
                                                <col width="12%" />
                                                <col width="10%" />
                                                <col width="10%" />
                                                <col width="10%" />
                                                <%--<col width="6%" />--%>
                                            </colgroup>
                                            <thead>
                                                <tr>
                                                    <th style="text-align: center">क्रम स०</th>
                                                    <th>योजना का नाम</th>
                                                    <th>Type</th>
                                                    <th>Installment</th>
                                                    <th>इकाई लागत (लाख/प्रति हेक्टेयर/प्रति यूनिट</th>
                                                    <th>इकाई लागत का 60 प्रतिशत -लाख/प्रति हेक्टेयर/प्रति यूनिट</th>
                                                    <th>अनुदान धनराशि अधिकतम इकाई लागत का 40 प्रतिशत -लाख/प्रति हेक्टेयर/प्रति यूनिट</th>
                                                    <th>अनुदान धनराशि का वितरण लाख/प्रति हेक्टेयर/प्रति यूनिट</th>
                                                    <%--<th></th>--%>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td style="text-align: center">1</td>
                                                    <td>
                                                        <select class="form-control selectpicker" data-live-search="true" id="ddlSchemeName" onchange="getworkTypeBySheme();">
                                                        </select>

                                                    </td>
                                                    <td>
                                                        <select class="form-control selectpicker" data-live-search="true" id="ddlProgressType" onchange="getworkInstallByID();">
                                                        </select>
                                                    </td>
                                                    <td>
                                                        <select class="form-control" data-live-search="true" id="ddlWorkInstallment" onchange="getWorkInstallmentAmount();getDocumentByWorkInstallment();">
                                                        </select>

                                                    </td>
                                                    <td>
                                                        <input type="text" class="form-control" name="txtProjectCost" placeholder="0" readonly="readonly" id="txtProjectCost" style="text-align: right" /></td>
                                                    <td>
                                                        <input type="text" class="form-control" name="txtBenCost" placeholder="0" readonly="readonly" id="txtBenCost" style="text-align: right" /></td>
                                                    <td>
                                                        <input type="text" class="form-control" name="txtSubsCost" placeholder="0" readonly="readonly" id="txtSubsCost" style="text-align: right" /></td>
                                                    <td>
                                                        <input type="text" class="form-control" name="txtInstAmount" placeholder="0" readonly="readonly" id="txtInstAmount" style="text-align: right" /></td>
                                                    <%--<td>
                                                        <%--<button class="btn btn-warning">जोड़ें</button>--%>
                                                    <%--</td>--%>
                                                </tr>


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
                        <a href="#" id="ancDocument" class="btn btn-primary" data-toggle="modal" data-target="#documentModal" data-backdrop="static" data-keyboard="false" style="display: none"></a>
                    </div>


                </div>
            </div>

            <!-- Modal -->
            <div class="modal fade bd-example-modal-lg form-horizontal" id="documentModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="myLargeModalLabel">विवरण भरें</h5>

                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <hr />
                            <h5 class="modal-title colorCss">सभी सूचना भरना जरूरी है</h5>
                        </div>

                        <div class="modal-body">

                            <div class="panel-body" id="pnlUploadFiles">
                                <div class="form-group">
                                    <label for="demo-vs-errinput" class="control-label">
                                        100% कार्य पूर्ण के फोटोग्राफ निर्माणकार्य की ऍम. वी.</label>
                                    <label class="pull-right colorCss">Allowed Only Pdf/jpg/png/jpeg File, Max Size 1 MB</label>
                                    <input type="file" id="demo-vs-definput" class="form-control" />
                                </div>
                                <div class="form-group">
                                    <label for="demo-vs-errinput" class="control-label">100% कार्यपूर्ति के प्रमाणपत्र</label>
                                    <label class="pull-right colorCss">Allowed Only Pdf/jpg/png/jpeg File, Max Size 1 MB</label>
                                    <input type="file" id="demo-vs-definput" class="form-control" />
                                </div>
                                <div class="form-group">
                                    <label for="demo-vs-errinput" class="control-label">100% कार्यपूर्ति के प्रमाणपत्र</label>
                                    <label class="pull-right colorCss">Allowed Only Pdf/jpg/png/jpeg File, Max Size 1 MB</label>
                                    <input type="file" id="demo-vs-definput" class="form-control" />
                                </div>

                            </div>

                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal" id="btnDocClose">निरस्त करें</button>
                            <button type="button" class="btn btn-primary" id="btnDocSave">सुरक्षित करें</button>
                        </div>
                    </div>
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
            $('#demo-dp-component .input-group.date').datepicker({
                autoclose: true,
                format: "dd/mm/yyyy",
                todayHighlight: true
            });

        });
    </script>
</asp:Content>

