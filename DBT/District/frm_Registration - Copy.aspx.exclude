<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DistrictMaster.master" AutoEventWireup="true" EnableEventValidation="false" CodeFile="frm_Registration - Copy.aspx.cs" Inherits="District_frm_Registration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
        .btn-labeled:not(.btn-block):not(.form-icon) {
            padding-bottom: 7px !important;
            padding-top: 8px !important;
        }
    </style>
    <!--Bootstrap Validator [ OPTIONAL ]-->
    <link href="<%=ResolveUrl("~/plugins/bootstrap-validator/bootstrapValidator.min.css") %>" rel="stylesheet" />
    <script src="<%=ResolveUrl("~/js/jquery-2.1.1.min.js") %>"></script>
    <%-- Define Validation Rule --%>
    <script type="text/javascript">
        var isValid = false;
        var unitType = [];

        $(document).ready(function () {
            $('#frmDBTDistrict').bootstrapValidator({
                framework: 'bootstrap',
                icon: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    txtRegistrationDate: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'अमान्य पंजीकरण दिनांक।'
                            },
                            date: {
                                format: 'DD/MM/YYYY',
                                message: 'अमान्य पंजीकरण दिनांक। दिनांक प्रारुप "DD/MM/YYYY" हैं।'
                            }
                        }
                    },
                    ctl00$ContentPlaceHolder1$txtFarmerFirstName: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'अमान्य प्रविष्टि ।'
                            }
                        }
                    },
                    ctl00$ContentPlaceHolder1$txtFarmerLastName: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'अमान्य प्रविष्टि ।'
                            }
                        }
                    },
                    ctl00$ContentPlaceHolder1$txtFatherFirstName: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'अमान्य प्रविष्टि ।'
                            }
                        }
                    },
                    ctl00$ContentPlaceHolder1$txtFatherLastName: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'अमान्य प्रविष्टि ।'
                            }
                        }
                    },
                    ctl00$ContentPlaceHolder1$ddlDistrictName: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'अमान्य प्रविष्टि ।'
                            }
                        }
                    },
                    //ctl00$ContentPlaceHolder1$ddlBlockName: {
                    //    row: '.col-xs-4',
                    //    validators: {
                    //        notEmpty: {
                    //            message: 'अमान्य प्रविष्टि ।'
                    //        }
                    //    }
                    //},
                    //ctl00$ContentPlaceHolder1$ddlVillageName: {
                    //    row: '.col-xs-4',
                    //    validators: {
                    //        notEmpty: {
                    //            message: 'अमान्य प्रविष्टि ।'
                    //        }
                    //    }
                    //},
                    ctl00$ContentPlaceHolder1$txtMobileNo: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'अमान्य प्रविष्टि ।'
                            },
                            stringLength: {
                                min: 10,
                                max: 10,
                                message: 'मोबाइल नं0 10 अक्षर का होना चाहिए।'
                            },
                            digits: {
                                message: 'अमान्य प्रविष्टि ।'
                            }
                        }
                    },
                    ctl00$ContentPlaceHolder1$txtAadharNo: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'अमान्य प्रविष्टि ।'
                            },
                            stringLength: {
                                min: 12,
                                max: 12,
                                message: 'आधार नं0 12 अक्षर का होना चाहिए।'
                            }
                            , digits: {
                                message: 'अमान्य प्रविष्टि ।'
                            }
                        }
                    },
                    ctl00$ContentPlaceHolder1$txtEmailId: {
                        row: '.col-xs-4',
                        validators: {
                            emailAddress: {
                                message: 'अमान्य प्रविष्टि ।'
                            }
                        }
                    }
                    ,
                    ctl00$ContentPlaceHolder1$ddlCaste: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'अमान्य प्रविष्टि ।'
                            }
                        }
                    },
                    ctl00$ContentPlaceHolder1$ddlGender: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'अमान्य प्रविष्टि ।'
                            }
                        }
                    },
                    ctl00$ContentPlaceHolder1$ddlBankName: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'अमान्य प्रविष्टि ।'
                            }
                        }
                    },
                    ctl00$ContentPlaceHolder1$ddlBankBranch: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'अमान्य प्रविष्टि ।'
                            }
                        }
                    },
                    ctl00$ContentPlaceHolder1$txtAccountNo: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'अमान्य प्रविष्टि ।'
                            }, digits: {
                                message: 'अमान्य प्रविष्टि ।'
                            }
                        }
                    }
                    ,
                    farmername3: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'अमान्य प्रविष्टि ।'
                            }
                        }
                    }

                }
            }).on('error.field.bv', function () {
                isValid = false;
            }).on('success.field.bv', function () {
                isValid = true;
            });
        });
    </script>
    <%-- For Load Control  --%>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#txtRegistrationDate').datepicker({ autoclose: true });
            $('#btnCancel').click(function () {
                window.location.reload();
            });
            $.ajax({
                type: "POST",
                url: "frm_Registration.aspx/GetSchemesType",
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


            $.ajax({
                type: "POST",
                url: "frm_Registration.aspx/GetBank",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var ddl = $("#<%=ddlBankName.ClientID%>");
                    ddl.append($("<option selected disabled hidden></option>").val('').html('चयन करें'));
                    $.each(r.d, function () {
                        ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    ddl.selectpicker('refresh');
                }
            });

            $.ajax({
                type: "POST",
                url: "frm_Registration.aspx/GetCategory",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var ddl = $("#<%=ddlCaste.ClientID%>");
                    ddl.append($("<option selected disabled hidden></option>").val('').html('चयन करें'));
                    $.each(r.d, function () {
                        ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    ddl.selectpicker('refresh');
                }
            });

            $.ajax({
                type: "POST",
                url: "frm_Registration.aspx/GetGender",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var ddl = $("#<%=ddlGender.ClientID%>");
                    ddl.append($("<option selected disabled hidden></option>").val('').html('चयन करें'));
                    $.each(r.d, function () {
                        ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    ddl.selectpicker('refresh');
                }
            });

            $.ajax({
                type: "POST",
                url: "frm_Registration.aspx/GetLandType",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {

                    var ddl = $("#<%=ddlLandType.ClientID%>");
                    ddl.append($("<option selected disabled hidden></option>").val('').html('चयन करें'));
                    $.each(r.d, function () {
                        ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    ddl.selectpicker('refresh');
                }
            });

            $.ajax({
                type: "POST",
                url: "frm_Registration.aspx/GetUnitType",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var ddl = $("#<%=ddlUnitType.ClientID%>");
                    $.each(r.d, function () {
                        var unit = {};
                        unit.Text = this['Text'];
                        unit.Value = this['Value'];
                        unitType.push(unit);
                        ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    ddl.selectpicker('refresh');
                }
            });

            $.ajax({
                type: "POST",
                url: "frm_Registration.aspx/GetDistrict",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var ddl = $("#<%=ddlDistrictName.ClientID%>");
                    ddl.prop('disabled', true);
                    ddl.append($("<option selected disabled hidden></option>").val('').html('चयन करें'));
                    $.each(r.d, function () {
                        ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    $('#<%=ddlDistrictName.ClientID%> option:selected').val(<%=DistrictKey%>);
                    ddl.selectpicker('refresh');

                    $("#<%=ddlDistrictName.ClientID%> option").each(function () {
                        if ($(this).val().toString() == '<%=DistrictKey%>')
                            $(this).prop('selected', true);
                        else {
                            $(this).prop('selected', false);

                        }
                    });

                    $("#<%=ddlDistrictName.ClientID%>").selectpicker('refresh');

                    $("#<%=ddlDistrictName.ClientID%>").change();

                }
            });


        });

    </script>

    <%-- For Control Event --%>
    <script type="text/javascript">
        function clearTextBox() {
            $('#<%=txtAadharNo.ClientID%>').val('');
            $('#<%=txtAccountNo.ClientID%>').val('');
            $('#<%=txtArea.ClientID%>').val('');
            $('#<%=txtEmailId.ClientID%>').val('');
            $('#<%=txtFarmerFirstName.ClientID%>').val('');
            $('#<%=txtFarmerLastName.ClientID%>').val('');
            $('#<%=txtFarmerMiddleName.ClientID%>').val('');

            $('#<%=txtFatherFirstName.ClientID%>').val('');
            $('#<%=txtFatherLastName.ClientID%>').val('');
            $('#<%=txtFatherMiddleName.ClientID%>').val('');
            $('#<%=txtGataKhatauniNo.ClientID%>').val('');
            $('#<%=txtIFSCCode.ClientID%>').val('');
            $('#<%=txtMobileNo.ClientID%>').val('');

            $('#txtRegCod').val('');
        }

        function getSchemeName() {
            var schemetypeId = $("#ddlSchemeNameType").val();
            $("#<%=ddlSchemeName.ClientID%>").empty();
            if (schemetypeId > 0) {
                $.ajax({
                    type: "POST",
                    url: "frm_Registration.aspx/GetSchemes",
                    data: '{key : ' + schemetypeId + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        var ddl = $("#<%=ddlSchemeName.ClientID%>");
                        ddl.append($("<option selected disabled hidden></option>").val('').html('चयन करें'));
                        $.each(r.d, function () {
                            ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                        });
                        ddl.selectpicker('refresh');
                    }
                });
                }
            }

            function loadBlockByDistrict() {
                var distId = $('#<%=ddlDistrictName.ClientID%>').val();
                $("#<%=ddlBlockName.ClientID%>").empty();
                $("#<%=ddlVillageName.ClientID%>").empty();
                if (!isNaN(distId) && distId != "") {
                    $.ajax({
                        type: "POST",
                        url: "frm_Registration.aspx/GetDistictBlock",
                        data: '{DistrictID : ' + distId + '}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (r) {
                            var ddl = $("#<%=ddlBlockName.ClientID%>");
                            ddl.append($("<option selected disabled hidden></option>").val('').html('चयन करें'));
                            $.each(r.d, function () {
                                ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                            });
                            ddl.selectpicker('refresh');
                        }
                    });
                    }
                }

                function loadVillageBlock() {
                    var blockId = $('#<%=ddlBlockName.ClientID%>').val();
                    $("#<%=ddlVillageName.ClientID%>").empty();
                    if (!isNaN(blockId) && blockId != "") {
                        $.ajax({
                            type: "POST",
                            url: "frm_Registration.aspx/GetBlockVillage",
                            data: '{BlockID : ' + blockId + '}',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (r) {
                                var ddl = $("#<%=ddlVillageName.ClientID%>");
                            ddl.append($("<option selected disabled hidden></option>").val('').html('चयन करें'));
                            $.each(r.d, function () {
                                ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                            });
                            ddl.selectpicker('refresh');
                        }
                    });
                    }
                }

                function loadBankBranch(e) {
                    var bankID = $('#<%=ddlBankName.ClientID%>').val();
                    $("#<%=ddlBankBranch.ClientID%>").empty();
                    if (!isNaN(bankID) && bankID != "") {
                        $.ajax({
                            type: "POST",
                            url: "frm_Registration.aspx/GetBranchByBankID",
                            data: '{BankID : ' + bankID + '}',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (r) {
                                var ddl = $("#<%=ddlBankBranch.ClientID%>");
                                ddl.append($("<option selected disabled hidden></option>").val('').html('चयन करें'));
                                $.each(r.d, function () {
                                    ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                                });
                                ddl.selectpicker('refresh');
                            }
                        });
                        }
                    }


                    function setifsCode() {
                        var branchId = $('#<%=ddlBankBranch.ClientID%>').val();
                        if (!isNaN(branchId) && branchId != "") {
                            $.ajax({
                                type: "POST",
                                url: "frm_Registration.aspx/GetBranchIFSCCode",
                                data: '{detID : ' + branchId + '}',
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (r) {
                                    $('#<%=txtIFSCCode.ClientID%>').val(r.d);
                                }
                            });
                            }
                        }

                        function landTypeChange() {
                            if (($('#<%=ddlSchemeName.ClientID%>').val() > 0) && ($('#<%=ddlLandType.ClientID%>').val() > 0)) {
                                $('#divKhatauniDetails').show();
                                if ($('#<%=ddlLandType.ClientID%> option:selected').text() == 'पट्टा') {
                                    //$('#rbKhatauniNo').prop('checked', false);
                                    //  $('#rbKhatauniNo').prop('disabled', true);
                                    //  $('#rbGataNo').prop('checked', true);
                                    // $('#rbGataNo').prop('disabled', false);
                                    $('.clsKhatauniNo').removeClass('active');
                                    $('.clsGataNo').addClass('active');

                                    $('#lblGhata').text('घाटा संख्या');
                                    $('#<%=txtGataKhatauniNo.ClientID%>').prop('placeholder', 'घाटा संख्या');
                                }
                                else {
                                    // $('#rbKhatauniNo').prop("checked", true);
                                    // $('#rbKhatauniNo').prop("disabled", false);
                                    //  $('#rbGataNo').prop("checked", false);
                                    // $('#rbGataNo').prop("disabled", true);
                                    $('.clsGataNo').removeClass('active');
                                    $('.clsKhatauniNo').addClass('active');

                                    $('#lblGhata').text('खतौनी संख्या');
                                    $('#<%=txtGataKhatauniNo.ClientID%>').prop('placeholder', 'खतौनी संख्या');
                                }
                            }
                            else {
                                $('#divKhatauniDetails').hide();
                            }
                        }

                        function addLand() {
                            event.preventDefault();
                            var ghataNo = $('#<%=txtGataKhatauniNo.ClientID%>').val();
                            var area = $('#<%=txtArea.ClientID%>').val();
                            var unitVal = $('#<%=ddlUnitType.ClientID%>').val();
                            var srno = parseInt($('#tblLand tr').length);

                            if (ghataNo.toString().trim() == "") {
                                alert('अमान्य खसरा/घाटा संख्या।');
                            }
                            else if (!isNaN(parseFloat(area)) <= 0) {
                                alert('अमान्य क्षेत्रफल।');
                            }

                            else if (ghataNo.toString().trim() != "" && !isNaN(area) && !isNaN(unitVal)) {
                                var unitName = unitType.filter(function (i) {
                                    return i.Value === unitVal;
                                });

                                var row = "<tr><td style='text-align: center'>" + srno + "</td>";
                                row = row + '<td>' + (($('#<%=ddlLandType.ClientID%>').val() == 23) ? "घाटा संख्या" : "खतौनी संख्या") + ' - ' + ghataNo + '</td>';
                                row = row + '<td>' + area + '</td>';
                                row = row + '<td>' + unitType.filter(function (el) {
                                    return el.Value == unitVal
                                })[0].Text; +'</td>';
                                row = row + '<td><button class="btn btn-danger fa fa-trash deleteLand" data-id=' + srno + '></button></td></tr>';
                                $('#tblLand tbody').append(row);

                                $('#<%=txtGataKhatauniNo.ClientID%>').val('');
                                $('#<%=txtArea.ClientID%>').val('');
                            }
                }
                function onRegistrationDateChange() {
                    var appDate = $('#txtRegistrationDate').val();

                    if (appDate != "") {
                        $('#divSchemeDetails').show();
                        $('#divNewRegistration').show();

                        $("#txtRegistrationDate").datepicker("destroy");
                        $("#txtRegistrationDate").prop('readonly', true);

                    }
                }
                $(document).ready(function () {
                    $(document).on("click", ".deleteLand", function () {
                        var id = $(this).attr("data-id");
                        if (!isNaN(id)) {
                            var id = $(this).attr("data-id");
                            $("#tblLand tbody tr").find('td button[data-id="' + id + '"]').each(function () {
                                $(this).parents("tr").remove();
                            });
                        }
                    });
                    // Find and remove selected table rows

                    //$(".deleteLand").click(function () {
                    //    var id = $(this).attr("data-id");
                    //    $("table tbody").find('button[data-id="' + id + '"]').each(function () {
                    //        $(this).parents("tr").remove();
                    //    });
                    //});
                });
    </script>

    <%--For Insert/Update Record --%>
    <script type="text/javascript">
        $(document).ready(function () {
            clearTextBox();
            $("#btnSubmit").click(function () {
                var regCode = $('#hdRegCod').val();
                if (
                        (
                            $('#txtRegistrationDate').val() == "" || $('#<%=txtFarmerFirstName.ClientID%>').val() == "" || $('#<%=txtFarmerLastName.ClientID%>').val() == ""
                            || $('#<%=txtFatherFirstName.ClientID%>').val() == "" || $('#<%=txtFatherLastName.ClientID%>').val() == ""
                            || $('#<%=ddlDistrictName.ClientID%>').val() == null || $('#<%=ddlBlockName.ClientID%>').val() == null || $('#<%=ddlVillageName.ClientID%>').val() == null
                            || $('#<%=txtMobileNo.ClientID%>').val() == "" || $('#<%=txtAadharNo.ClientID%>').val() == "" || $('#<%=ddlCaste.ClientID%>').val() == null
                            || $('#<%=ddlGender.ClientID%>').val() == null || $('#<%=ddlBankName.ClientID%>').val() == null || $('#<%=ddlBankBranch.ClientID%>').val() == null || $('#<%=txtAccountNo.ClientID%>').val() == ""

                        ) && (regCode == "")
                    ) {
                    //event.preventDefault();
                    alert('कृपया मान्य विवरण को भरें।');
                }
                else if ($('#tblLand tbody tr').length == 0 && regCode != "") {
                    event.preventDefault();
                    alert('कृपया स्कीम और भूमि का विवरण दें।');
                }
                else {
                    if (isValid) {

                        var appReg = {};
                        var appArrScheme = [];

                        var appSchemeLand = [];

                        if (regCode == "") {
                            appReg.RegistrationCode = "";
                            appReg.RegistrationDate = $('#txtRegistrationDate').val();
                            appReg.FinancialYear = $('#<%=lblFinYear.ClientID%>').text();

                            appReg.AFirstName = $('#<%=txtFarmerFirstName.ClientID%>').val();
                            appReg.ASecondName = $('#<%=txtFarmerMiddleName.ClientID%>').val();
                            appReg.ALastName = $('#<%=txtFarmerLastName.ClientID%>').val();

                            appReg.FFirstName = $('#<%=txtFatherFirstName.ClientID%>').val();
                            appReg.FSecondName = $('#<%=txtFatherMiddleName.ClientID%>').val();
                            appReg.FLastName = $('#<%=txtFatherLastName.ClientID%>').val();

                            appReg.DistrictKey = $('#<%=ddlDistrictName.ClientID%>').val();
                            appReg.BlockKey = $('#<%=ddlBlockName.ClientID%>').val();
                            appReg.VillageKey = $('#<%=ddlVillageName.ClientID%>').val();

                            appReg.MobileNo = $('#<%=txtMobileNo.ClientID%>').val();
                            appReg.AadharNo = $('#<%=txtAadharNo.ClientID%>').val();
                            appReg.EmailId = $('#<%=txtEmailId.ClientID%>').val();

                            appReg.Category = $('#<%=ddlCaste.ClientID%>').val();
                            appReg.Gender = $('#<%=ddlGender.ClientID%>').val();
                            appReg.Minority = ($('#<%=ddlMinority.ClientID%>').val() == 0 ? 'false' : 'true');

                            appReg.BankKey = $('#<%=ddlBankName.ClientID%>').val();;
                            appReg.BranchKey = $('#<%=ddlBankBranch.ClientID%>').val();;
                            appReg.AccountNo = $('#<%=txtAccountNo.ClientID%>').val();;
                            appReg.IFSCCode = $('#<%=txtIFSCCode.ClientID%>').val();;
                        } else {
                            appReg.RegistrationCode = regCode;
                        }
                        var appScheme = {};

                        appScheme.SchemeKey = $('#<%=ddlSchemeName.ClientID%>').val();
                        appScheme.LandType = $('#<%=ddlLandType.ClientID%>').val();

                        $('#tblLand tbody').find('tr').each(function (i, el) {
                            var $tds = $(this).find('td');
                            var shemeLand = {};

                            shemeLand.IsKhatauni = (($(this).find('td').eq(1).text().toString().split('-')[0].toString().trim()) != "घाटा संख्या" ? 'true' : 'false');
                            shemeLand.KhatauniNo = $(this).find('td').eq(1).text().toString().split('-')[1].toString().trim();
                            shemeLand.Area = $(this).find('td').eq(2).text();
                            var unitText = $(this).find('td').eq(3).text().toString().trim();
                            shemeLand.UnitID = unitType.filter(function (el) {
                                return el.Text.toString().trim() == unitText;
                            })[0].Value;

                            appSchemeLand.push(shemeLand);
                        });

                        if (appScheme.SchemeKey != null && appScheme.LandType != null && appSchemeLand.length > 0) {
                            appScheme.Lands = appSchemeLand;
                            appArrScheme.push(appScheme);
                            appReg.Schemes = appArrScheme;
                        }

                        $.ajax({
                            type: "POST",
                            url: "frm_Registration.aspx/Create",
                            data: '{objApplicantRegistration: ' + JSON.stringify(appReg) + '}',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (response) {
                                data = (response.d);
                                if (data != "") {
                                    alert(data);
                                    clearTextBox();
                                }
                                else {
                                    alert('Something Went Wrong.')
                                }
                            },
                            error: function (err) {
                                alert(err.statusText)
                            }
                        });

                    }
                    else {
                        event.preventDefault();
                    }
                }

            });
        });
    </script>

    <%-- Find Applicant By Code --%>
    <script type="text/javascript">
        function getApplicantDetail() {
            //event.preventDefault();
            var regCode = $('#txtRegCod').val();
            if (regCode.toString().trim() != "") {
                $.ajax({
                    type: "Post",
                    contentType: "application/json; charset=utf-8",
                    url: "frm_Registration.aspx/GetRegApplicantByCode",
                    data: '{RegCode: "' + regCode + '"}',
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            $('#tblFarmer tbody').empty();
                            $('#tblLandDet tbody').empty();
                            $('#tblBankDet tbody').empty();
                            $('#hdRegCod').val(regCode);
                            var applicantReg = $.parseJSON(data.d);
                            var formarRow = "";
                            var bankRow = "";

                            var totolArea = 0;
                            var sr = 1;

                            $.each(applicantReg, function (index, value) {

                                farmerRow = "<tr><td>" + value.RegistrationDate + "</td> <td>" + value.FarmerName + "</td> <td>" + value.FatherName + "</td> <td>" + value.VillageName + "</td> <td>" + value.MobileNo + "</td>  <td>" + value.CasteName + "</td> </tr>";
                                bankRow = "<tr><td>" + value.BankName + "</td> <td>" + value.BankBranch + "</td> <td>" + value.AccountNo + "</td> <td>" + value.IFSCCode + "</td> </tr>";

                                var landRow = "<tr><td class='text-center'>" + sr + "</td> <td>" + value.Khatauni + "</td> <td style='text-align:right'>" + value.Area + "</td> <td>" + value.Unit + "</td> </tr>";
                                $('#tblLandDet tbody').append(landRow);

                                totolArea = parseFloat(totolArea) + parseFloat(value.Area)

                                sr = sr + 1;

                            });

                            var landFoot = "<tr><td colspan = 2 class='text-right'><b>कुल योग</b></td> <td style='text-align:right'><b>" + totolArea + "</b></td> <td></td> </tr>";
                            $('#tblLandDet tfoot').append(landFoot);

                            $('#tblFarmer tbody').append(farmerRow);
                            $('#tblBankDet tbody').append(bankRow);

                            $('#divFarmerDetailsExist').show();
                            $('#divLandDetailsExist').show();
                            $('#divSchemeDetails').show();
                            $('#divBankDetailsExist').show();

                            $('#txtRegCod').prop('readonly', true);
                            $('#btnSearch').prop('disabled', true);

                        } else {
                            alert('पंजीकरण संख्या का विवरण मौजूद नहीं हैं।');
                        }
                    },
                    error: function () {
                        alert("Error while retrieving data of :" + regCode);
                    }
                });
            }
            else {
                alert('कृपया पंजीकरण संख्या डालें।');
            }
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {

            $('#divRegistrationDate').hide();
            $('#divSchemeDetails').hide();
            $('#divExistRegistration').hide();
            $('#divNewRegistration').hide();
            $('#divKhatauniDetails').hide();

            $("input[name$='ico-w-label']").click(function () {
                var rbYesNo = $(this).val();
                if (rbYesNo == 1) {
                    $('#txtRegCod').prop('readonly', false);
                    $('#txtRegCod').val('');
                    $('#txtRegCod').val('');
                    $('#divRegistrationDate').hide();
                    $('#divExistRegistration').show();
                    $('#divNewRegistration').hide();

                    $('#divFarmerDetailsExist').hide();
                    $('#divLandDetailsExist').hide();
                    $('#divSchemeDetails').hide();
                    $('#divBankDetailsExist').hide();
                }
                else {
                    $('#divExistRegistration').hide();
                    $('#divRegistrationDate').show();
                    $('#divSchemeDetails').hide();
                    $("#txtRegistrationDate").datepicker({ autoclose: true });
                    $("#txtRegistrationDate").val('');

                    $("#txtRegistrationDate").prop('readonly', false);
                    $('#txtRegCod').val('');
                    $('#hdRegCod').val('');
                }
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="content-container">
        <!--Page Title-->
        <!--------------------------------------------------------->
        <div class="pageheader hidden-xs">
            <h3><i class="fa fa-home"></i>पंजीकरण करे </h3>
            <div class="breadcrumb-wrapper">
                <%--  <span class="label">You are here:</span>--%>
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">होम </a></li>
                    <li class="active">पंजीकरण करे </li>
                </ol>
            </div>
        </div>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <!--End page title-->
        <!--Page content-->
        <!--===================================================-->
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
                                <h3 style="float: left">
                                    <h3 style="float: left">जनपद :
                                        <asp:Label ID="lblLoginType" runat="server" Text="कानपुर नगर"></asp:Label></h3>
                                </h3>
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
                                <h3 class="panel-title">क्या लाभार्थी द्वारा मत्स्य विभाग की वेब साइट पर पंजीकरण किया गया है ? </h3>
                            </div>
                            <!--No Label Form-->
                            <div class="panel-body">
                                <!-- Inline Form  -->
                                <!--===================================================-->
                                <div class="col-md-8">
                                    <div class="radio">
                                        <!-- Inline Icon Radios Buttons -->
                                        <label class="form-radio form-icon form-text">
                                            <input type="radio" name="ico-w-label" value="1" />
                                            हाँ 
                                        </label>
                                        <label class="form-radio form-icon form-text">
                                            <input type="radio" name="ico-w-label" value="2" />
                                            नहीं
                                        </label>
                                    </div>
                                </div>

                                <!--===================================================-->
                                <!-- End Inline Form  -->
                            </div>

                        </div>
                    </div>
                </div>
                <div class="row" id="divRegistrationDate">
                    <div class="col-lg-12">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="panel">
                                    <div class="panel-body">
                                        <div class="row mar-top">
                                            <div class="col-lg-4">
                                                <fieldset>
                                                    <div class="form-group">
                                                        <label class="control-label col-md-4" for="txtRegistrationDate">पंजीकरण दिनांक *</label>
                                                        <div class="col-md-8">
                                                            <input type="text" class="form-control" name="txtRegistrationDate" placeholder="dd/mm/yyyy" data-date-format='dd/mm/yyyy' data-mask="99/99/9999" id="txtRegistrationDate"
                                                                data-bv-date="true"
                                                                data-bv-date-format="DD/MM/YYYY"
                                                                data-bv-date-message="पंजीकरण दिनांक अमान्य हैं।" onchange="onRegistrationDateChange();" />
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>

                        </div>
                    </div>

                </div>

                <div class="row" id="divExistRegistration">
                    <div class="col-lg-12">
                        <div class="row" id="divRegistrationExist">
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
                                            <div class="col-lg-4">
                                                <fieldset>
                                                    <div class="form-group">
                                                        <label class="col-lg-4 control-label">पंजीकरण संख्या </label>
                                                        <div class="col-lg-8">
                                                            <input type="text" class="form-control" name="farmername3" placeholder="पंजीकरण संख्या" id="txtRegCod" />
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
                        <div class="row" id="divFarmerDetailsExist">
                            <div class="col-lg-12">
                                <div class="panel">
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
                                                            <col width="8%" />
                                                            <col width="22%" />
                                                            <col width="20%" />
                                                            <col width="25%" />
                                                            <col width="8%" />
                                                            <col width="7%" />
                                                        </colgroup>
                                                        <thead>
                                                            <tr>
                                                                <th>पंजीकरण दिनांक</th>
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
                    </div>

                    <div class="col-lg-12">
                        <div class="row" id="divLandDetailsExist">
                            <div class="col-lg-12">
                                <div class="panel">
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
                    </div>

                    <div class="col-lg-12">
                        <div class="row" id="divBankDetailsExist">
                            <div class="col-lg-12">
                                <div class="panel">
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

                                        <!-- End Inline Form  -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


                </div>
                <div class="row" id="divNewRegistration">
                    <div class="col-lg-12">
                        <div class="row" id="divFarmerDetails">
                            <div class="col-lg-12">
                                <div class="panel">
                                    <div class="panel-heading">
                                        <h3 class="panel-title">कृषक का विवरण </h3>
                                    </div>
                                    <!--No Label Form-->

                                    <div class="panel-body">
                                        <!--IDENTICAL VALIDATOR-->
                                        <!--===================================================-->

                                        <div class="row mar-top">
                                            <div class="col-lg-4">
                                                <fieldset>
                                                    <div class="form-group">
                                                        <label class="col-lg-3 control-label">कृषक का नाम *</label>
                                                        <div class="col-lg-7">
                                                            <asp:TextBox ID="txtFarmerFirstName" runat="server" placeholder="(प्रथम नाम)" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </div>

                                            <div class="col-lg-4">
                                                <fieldset>
                                                    <div class="form-group">
                                                        <label class="col-lg-3 control-label">(मध्य नाम)</label>
                                                        <div class="col-lg-7">
                                                            <asp:TextBox ID="txtFarmerMiddleName" runat="server" placeholder="(मध्य नाम)" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </div>

                                            <div class="col-lg-4">
                                                <fieldset>
                                                    <div class="form-group">
                                                        <label class="col-lg-3 control-label">(अंतिम नाम) * </label>
                                                        <div class="col-lg-7">
                                                            <asp:TextBox ID="txtFarmerLastName" runat="server" placeholder="(अंतिम नाम)" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </div>

                                        </div>
                                        <div class="row">
                                            <div class="col-lg-4">
                                                <fieldset>
                                                    <div class="form-group">
                                                        <label class="col-lg-3 control-label">पिता/पति का नाम *</label>
                                                        <div class="col-lg-7">
                                                            <asp:TextBox ID="txtFatherFirstName" runat="server" placeholder="(प्रथम नाम)" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </div>
                                            <div class="col-lg-4">
                                                <fieldset>
                                                    <div class="form-group">
                                                        <label class="col-lg-3 control-label">(मध्य नाम)</label>
                                                        <div class="col-lg-7">
                                                            <asp:TextBox ID="txtFatherMiddleName" runat="server" placeholder="(मध्य नाम)" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </div>
                                            <div class="col-lg-4">
                                                <fieldset>
                                                    <div class="form-group">
                                                        <label class="col-lg-3 control-label">(अंतिम नाम) *</label>
                                                        <div class="col-lg-7">
                                                            <asp:TextBox ID="txtFatherLastName" runat="server" placeholder="(अंतिम नाम)" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-lg-4">
                                                <fieldset>
                                                    <div class="form-group">
                                                        <label class="col-lg-3 control-label">जनपद का नाम </label>
                                                        <div class="col-lg-7">
                                                            <asp:DropDownList ID="ddlDistrictName" CssClass="form-control selectpicker" runat="server" data-live-search="true" onchange="loadBlockByDistrict(this);">
                                                            </asp:DropDownList>

                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </div>
                                            <div class="col-lg-4">
                                                <fieldset>
                                                    <div class="form-group">
                                                        <label class="col-lg-3 control-label">ब्लॉक का नाम</label>
                                                        <div class="col-lg-7">
                                                            <asp:DropDownList ID="ddlBlockName" CssClass="form-control selectpicker" runat="server" data-live-search="true" onchange="loadVillageBlock();">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </div>
                                            <div class="col-lg-4">
                                                <fieldset>
                                                    <div class="form-group">
                                                        <label class="col-lg-3 control-label">गाँव का नाम </label>
                                                        <div class="col-lg-7">
                                                            <div class="input-group mar-btm">
                                                                <asp:DropDownList ID="ddlVillageName" CssClass="form-control selectpicker" runat="server" data-live-search="true">
                                                                </asp:DropDownList>
                                                                <span class="input-group-btn">
                                                                    <a class="btn btn-danger btn-labeled" data-toggle="modal" data-target="#exampleModal"><i class="fa fa-plus"></i></a>

                                                                </span>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </fieldset>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-lg-4">
                                                <fieldset>
                                                    <div class="form-group">
                                                        <label class="col-lg-3 control-label">मोबाइल नंबर *</label>
                                                        <div class="col-lg-7">
                                                            <asp:TextBox ID="txtMobileNo" runat="server" placeholder="मोबाइल नंबर" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </div>
                                            <div class="col-lg-4">
                                                <fieldset>
                                                    <div class="form-group">
                                                        <label class="col-lg-3 control-label">आधार नंबर *</label>
                                                        <div class="col-lg-7">
                                                            <asp:TextBox ID="txtAadharNo" runat="server" placeholder="आधार नंबर" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </div>
                                            <div class="col-lg-4">
                                                <fieldset>
                                                    <div class="form-group">
                                                        <label class="col-lg-3 control-label">ईमेल आई० डी०</label>
                                                        <div class="col-lg-7">
                                                            <asp:TextBox ID="txtEmailId" runat="server" placeholder="ईमेल आई० डी०" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-lg-4">
                                                <fieldset>
                                                    <div class="form-group">
                                                        <label class="col-lg-3 control-label">जाति *</label>
                                                        <div class="col-lg-7">
                                                            <asp:DropDownList ID="ddlCaste" CssClass="form-control selectpicker" runat="server">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </div>
                                            <div class="col-lg-4">
                                                <fieldset>
                                                    <div class="form-group">
                                                        <label class="col-lg-3 control-label">लिंग *</label>
                                                        <div class="col-lg-7">
                                                            <asp:DropDownList ID="ddlGender" CssClass="form-control selectpicker" runat="server">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </div>
                                            <div class="col-lg-4">
                                                <fieldset>
                                                    <div class="form-group">
                                                        <label class="col-lg-3 control-label">अल्पसंख्यक समुदाय</label>
                                                        <div class="col-lg-7">
                                                            <asp:DropDownList ID="ddlMinority" CssClass="form-control selectpicker" runat="server">
                                                                <asp:ListItem Text="हाँ" Value="1"></asp:ListItem>
                                                                <asp:ListItem Text="नहीं" Value="0" Selected="True"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </div>

                                        <!--===================================================-->
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="col-lg-12">
                        <div class="row" id="divBankDetails">
                            <div class="col-lg-12">
                                <div class="panel">
                                    <div class="panel-heading">
                                        <h3 class="panel-title">बैंक का विवरण </h3>
                                    </div>
                                    <!--No Label Form-->
                                    <div class="panel-body">
                                        <!-- Inline Form  -->
                                        <!--===================================================-->
                                        <div class="row mar-top">
                                            <div class="col-lg-6">
                                                <fieldset>
                                                    <div class="form-group">
                                                        <label class="col-lg-3 control-label">बैंक का नाम *</label>
                                                        <div class="col-lg-7">
                                                            <asp:DropDownList ID="ddlBankName" CssClass="form-control selectpicker" runat="server" data-live-search="true" onchange="loadBankBranch();">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </div>

                                            <div class="col-lg-6">
                                                <fieldset>
                                                    <div class="form-group">
                                                        <label class="col-lg-3 control-label">बैंक की शाखा *</label>
                                                        <div class="col-lg-7">
                                                            <asp:DropDownList ID="ddlBankBranch" CssClass="form-control selectpicker" runat="server" data-live-search="true" onchange="setifsCode();">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <fieldset>
                                                    <div class="form-group">
                                                        <label class="col-lg-3 control-label">IFSC कोड</label>
                                                        <div class="col-lg-7">
                                                            <asp:TextBox ID="txtIFSCCode" runat="server" placeholder="IFSC कोड" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </div>
                                            <div class="col-lg-6">
                                                <fieldset>
                                                    <div class="form-group">
                                                        <label class="col-lg-3 control-label">खाता संख्या *</label>
                                                        <div class="col-lg-7">
                                                            <asp:TextBox ID="txtAccountNo" runat="server" placeholder="खाता संख्या" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </div>
                                        <!--===================================================-->
                                        <!-- End Inline Form  -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12">
                        <div class="row" id="divSchemeDetails">
                            <div class="col-lg-12">
                                <div class="panel">
                                    <div class="panel-heading">
                                        <h3 class="panel-title">मत्स्य विभाग की योजनाओ के लिये  </h3>
                                    </div>
                                    <!--No Label Form-->
                                    <div class="panel-body">
                                        <!-- Inline Form  -->
                                        <!--===================================================-->
                                        <div class="row mar-top">
                                            <div class="col-lg-4">
                                                <fieldset>
                                                    <div class="form-group">
                                                        <label class="col-lg-3 control-label">योजना का प्रकार </label>
                                                        <div class="col-lg-9">
                                                            <select class="form-control selectpicker" data-live-search="true" id="ddlSchemeNameType" onchange="getSchemeName();">
                                                            </select>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </div>
                                            <div class="col-lg-4">
                                                <fieldset>
                                                    <div class="form-group">
                                                        <label class="col-lg-3 control-label">योजना का चयन</label>
                                                        <div class="col-lg-8">
                                                            <asp:DropDownList ID="ddlSchemeName" CssClass="form-control selectpicker" runat="server" data-live-search="true" onchange="landTypeChange();">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </div>

                                            <div class="col-lg-4">
                                                <fieldset>
                                                    <div class="form-group">
                                                        <label class="col-lg-3 control-label">भूमि / तालाब का प्रकार</label>
                                                        <div class="col-lg-8">
                                                            <asp:DropDownList ID="ddlLandType" CssClass="form-control selectpicker" runat="server" onchange="landTypeChange();">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="panel-body" style="padding-left: 60px; padding-right: 60px; margin-top: -25px; margin-bottom: 15px" id="divKhatauniDetails">
                                        <div class="row" style="background-color: #f9f9f9; padding: 25px 0 0 0">

                                            <div class="col-lg-3">
                                                <fieldset>
                                                    <div class="form-group">
                                                        <div class="col-lg-12">
                                                            <div class="radio" style="margin: -8px 0 0 12px;">
                                                                <!-- Inline Icon Radios Buttons -->
                                                                <!--===================================================-->
                                                                <label class="form-radio form-icon btn btn-default form-text clsKhatauniNo">
                                                                    <input type="radio" name="btn-ex-label" checked id="rbKhatauniNo" disabled />
                                                                    खतौनी संख्या
                                                                </label>
                                                                &nbsp;&nbsp;
                                                    <label class="form-radio form-icon btn btn-default form-text clsGataNo">
                                                        <input type="radio" name="btn-ex-label" id="rbGataNo" disabled />
                                                        घाटा संख्या
                                                    </label>

                                                                <!--===================================================-->
                                                            </div>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </div>

                                            <div class="col-lg-3">
                                                <fieldset>
                                                    <div class="form-group">
                                                        <label class="col-lg-5 control-label" id="lblGhata">घाटा संख्या</label>
                                                        <div class="col-lg-7">
                                                            <asp:TextBox ID="txtGataKhatauniNo" runat="server" placeholder="घाटा/खतौनी संख्या" CssClass="form-control" type="number" min="1" step="1"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </div>

                                            <div class="col-lg-2">
                                                <fieldset>
                                                    <div class="form-group">
                                                        <label class="col-lg-4 control-label">क्षेत्रफल</label>
                                                        <div class="col-lg-8">
                                                            <asp:TextBox ID="txtArea" runat="server" placeholder="क्षेत्रफल" CssClass="form-control" type="number" min="0" step="0.01"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </div>
                                            <div class="col-lg-2">
                                                <fieldset>
                                                    <div class="form-group">
                                                        <label class="col-lg-4 control-label">यूनिट</label>
                                                        <div class="col-lg-8">
                                                            <asp:DropDownList ID="ddlUnitType" CssClass="form-control selectpicker" runat="server">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </div>
                                            <div class="col-lg-2">
                                                <a href="#" class="btn btn-warning" id="btnaddland" onclick="addLand();">जोड़ें</a>
                                            </div>
                                        </div>

                                        <div class="row" style="background-color: #f9f9f9">
                                            <div class="col-lg-12">
                                                <div class="table-responsive">
                                                    <table class="table table-bordered" id="tblLand">
                                                        <colgroup>
                                                            <col width="6%" />
                                                            <col width="49%" />
                                                            <col width="20%" />
                                                            <col width="20%" />
                                                            <col width="5%" />
                                                        </colgroup>
                                                        <thead>
                                                            <tr>
                                                                <th style="text-align: center">क्रम स०</th>
                                                                <th>खतौनी/घाटा संख्या</th>
                                                                <th>क्षेत्रफल</th>
                                                                <th>यूनिट</th>

                                                                <th></th>
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
                                        <button id="btnSubmit" type="submit" class="btn btn-info">सुरक्षित करें</button>
                                        &nbsp;&nbsp;&nbsp;
                                <button id="btnCancel" type="reset" class="btn btn-warning">निरस्त करें</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--===================================================-->
        <!--End page content-->

        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">नया गाँव जोड़े</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                         <div class="row">
                                <div class="panel-body">
                                    <div class="col-lg-12">
                                            <div class="form-group">
                                                <label class="control-label">गाँव का नाम </label>
                                                <input type="text" id="txtNewVillageName" name="NewVillageName" class="form-control" />
                                            </div>
                                  </div>
                                </div>
                            </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">निरस्त करें</button>
                        <button type="button" class="btn btn-primary">सुरक्षित करें</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--Jasmine Admin [ RECOMMENDED ]-->
    <script src="<%=ResolveUrl("~/js/scripts.js") %>"></script>
    <script src="<%=ResolveUrl("~/plugins/bootstrap-validator/bootstrapValidator.min.js") %>"></script>

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
