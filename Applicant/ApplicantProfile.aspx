<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ApplicantMaster.Master" AutoEventWireup="true" CodeFile="ApplicantProfile.aspx.cs" EnableEventValidation="false" Inherits="Applicant_ApplicantProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

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
    <script src="../js/jquery-2.1.1.min.js" type="text/javascript"></script>
    <!--Bootstrap Datepicker [ OPTIONAL ]-->
    <link href="../plugins/bootstrap-datepicker/bootstrap-datepicker.css" rel="stylesheet" />
    <script src="../plugins/bootstrap-datepicker/bootstrap-datepicker.js"></script>

    <%-- Define Validation Rule --%>
    <script type="text/javascript">
        var isValid = true;

        $(document).ready(function () {
            $('#ContentPlaceHolder1_txtDOB').datepicker({ autoclose: true });
            $(form).bootstrapValidator({
                framework: 'bootstrap',
                icon: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    ctl00$ContentPlaceHolder1$txtFathername: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'Invalid Entry !'
                            }
                        }
                    },
                    ctl00$ContentPlaceHolder1$ddlGender: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'Invalid Entry !'
                            }
                        }
                    },
                    ctl00$ContentPlaceHolder1$ddlCaste: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'Invalid Entry !'
                            }
                        }
                    },
                    ctl00$ContentPlaceHolder1$txtDOB: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'Invalid Entry !'
                            },
                            date: {
                                format: 'DD/MM/YYYY',
                                message: 'The Date Format is "DD/MM/YYYY".'
                            }
                        }
                    },
                    ctl00$ContentPlaceHolder1$txtAadhar: {
                        row: '.col-xs-4',
                        validators: {
                            stringLength: {
                                min: 12,
                                max: 12,
                                message: 'Aadhar No. must be 12 digit.'
                            },
                            digits: {
                                message: 'Input Only Numeric Value.'
                            }
                        }
                    },
                    ctl00$ContentPlaceHolder1$txtaddress: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'Invalid Entry !'
                            }
                        }
                    },
                    ctl00$ContentPlaceHolder1$ddlDivision: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'Invalid Entry !'
                            }
                        }
                    },
                    ctl00$ContentPlaceHolder1$ddlDistrict: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'Invalid Entry !'
                            }
                        }
                    },
                    ctl00$ContentPlaceHolder1$ddlBlock: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'Invalid Entry !'
                            }
                        }
                    },
                    ctl00$ContentPlaceHolder1$txtTehsilName: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'Invalid Entry !'
                            }
                        }
                    },
                    ctl00$ContentPlaceHolder1$txtVillagename: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'Invalid Entry !'
                            }
                        }
                    },
                    ctl00$ContentPlaceHolder1$txtPostOffice: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'Invalid Entry !'
                            }
                        }
                    },
                    ctl00$ContentPlaceHolder1$txtPinno: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'Invalid Entry !'
                            },
                            stringLength: {
                                min: 6,
                                max: 6,
                                message: 'Pincode must be 6 digit.'
                            },
                            digits: {
                                message: 'Input Only Numeric Value.'
                            }
                        }
                    },
                    ctl00$ContentPlaceHolder1$txtEmail: {
                        row: '.col-xs-4',
                        validators: {
                            emailAddress: {
                                message: 'Invalid Entry !'
                            }
                        }
                    }, ctl00$ContentPlaceHolder1$ddlBank: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'Invalid Entry !'
                            }
                        }
                    },
                    ctl00$ContentPlaceHolder1$ddlBranch: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'Invalid Entry !'
                            }
                        }
                    },
                    ctl00$ContentPlaceHolder1$txtAcno: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'Invalid Entry !'
                            },
                            digits: {
                                message: 'Input Only Numeric Value.'
                            }
                        }
                    },
                    ctl00$ContentPlaceHolder1$txtPostOffice: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'Invalid Entry !'
                            }
                        }
                    },
                }
            }).on('error.form.bv', function () {
                isValid = false;
            }).on('success.field.bv', function () {
                isValid = true;
            });
        });
    </script>
    <script type="text/javascript">
        function GetDistrictByDivision() {
            var ddlDivision = $('#<%=ddlDivision.ClientID%> option:selected').val();
            $("#<%=ddlDistrict.ClientID%>").empty();
            if (ddlDivision > 0) {
                $.ajax({
                    type: "POST",
                    url: "ApplicantProfile.aspx/GetDistrict",
                    data: '{DivisionKey:' + ddlDivision + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        var ddl = $("#<%=ddlDistrict.ClientID%>");
                        ddl.append($("<option selected disabled hidden></option>").val('').html('Select District'));
                        $.each(r.d, function () {
                            ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                        });
                        ddl.selectpicker('refresh');


                    }
                });
                }
                else {
                    $("#<%=ddlDistrict.ClientID%>").append($("<option selected disabled hidden></option>").val('').html('Select District'));
                $("#<%=ddlDistrict.ClientID%>").selectpicker('refresh');
            }
            //Blank Control
            $("#<%=ddlBlock.ClientID%>").empty();
            $("#<%=ddlBlock.ClientID%>").append($("<option selected disabled hidden></option>").val('').html('Select Block'));
            $("#<%=ddlBlock.ClientID%>").selectpicker('refresh');

            $("#<%=ddlBank.ClientID%>").val('');
            $("#<%=ddlBank.ClientID%>").selectpicker('refresh');

            $("#<%=ddlBranch.ClientID%>").empty();
            $("#<%=ddlBranch.ClientID%>").append($("<option selected disabled hidden></option>").val('').html('Select Branch'));
            $("#<%=ddlBranch.ClientID%>").selectpicker('refresh');

            $("#<%=txtTehsilName.ClientID%>").val('');
            $("#<%=txtVillagename.ClientID%>").val('');
            $("#<%=txtPostOffice.ClientID%>").val('');
            $("#<%=txtPinno.ClientID%>").val('');

            $("#<%=txtBranchIFSC.ClientID%>").val('');
            $("#<%=txtBranchAddress.ClientID%>").val('');

        }

        function GetBlockByDistrict() {
            var distId = $('#<%=ddlDistrict.ClientID%>').val();
            $("#<%=ddlBlock.ClientID%>").empty();
            if (!isNaN(distId) && distId != "") {
                // $('body').Wload({ text: ' Loading' });
                $.ajax({
                    type: "POST",
                    url: "ApplicantProfile.aspx/GetDistictBlock",
                    data: '{DistrictID : ' + distId + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        var ddl = $("#<%=ddlBlock.ClientID%>");
                        ddl.append($("<option selected disabled hidden></option>").val('').html('Select Block'));
                        $.each(r.d, function () {
                            ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                        });
                        ddl.selectpicker('refresh');
                        // $('body').Wload('hide', { time: 0 });
                    }
                });
                }
                else {
                    $("#<%=ddlBlock.ClientID%>").append($("<option selected disabled hidden></option>").val('').html('Select Block'));
                $("#<%=ddlBlock.ClientID%>").selectpicker('refresh');
            }

            $("#<%=txtVillagename.ClientID%>").val('');
            $("#<%=txtPostOffice.ClientID%>").val('');
            $("#<%=txtPinno.ClientID%>").val('');

        }

        function GetBranch() {
            var bankID = $('#<%=ddlBank.ClientID%>').val();
            var distId = $('#<%=ddlDistrict.ClientID%>').val();
            $("#<%=ddlBranch.ClientID%>").empty();
            if (!isNaN(bankID) && bankID != "" && distId) {
                //$('body').Wload({ text: ' Loading' });
                $.ajax({
                    type: "POST",
                    url: "ApplicantProfile.aspx/GetBranchByBankID",
                    data: '{BankID : ' + bankID + ', DistrinctKey:' + distId + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        var ddl = $("#<%=ddlBranch.ClientID%>");
                        ddl.append($("<option selected disabled hidden></option>").val('').html('Select Branch'));
                        $.each(r.d, function () {
                            ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                        });
                        ddl.selectpicker('refresh');
                        //$('body').Wload('hide', { time: 0 });
                    }
                });
                }
                else {
                    $("#<%=ddlBranch.ClientID%>").append($("<option selected disabled hidden></option>").val('').html('Select Branch'));
                    $("#<%=ddlBranch.ClientID%>").selectpicker('refresh');
            }
            $("#<%=txtBranchIFSC.ClientID%>").val('');
            $("#<%=txtBranchAddress.ClientID%>").val('');
        }

        function GetBranchDetail() {
            var BankDetailId = $('#<%=ddlBranch.ClientID%>').val();
            $("#<%=txtBranchIFSC.ClientID%>").val('');
            $("#<%=txtBranchAddress.ClientID%>").val('');

            if (!isNaN(BankDetailId) && BankDetailId != "") {
                //$('body').Wload({ text: ' Loading' });
                $.ajax({
                    type: "POST",
                    url: "ApplicantProfile.aspx/GetBranchDetail",
                    data: '{BankDetailId : ' + BankDetailId + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        var data = $.parseJSON(r.d);
                        $.each(data, function (index, value) {
                            $("#<%=txtBranchIFSC.ClientID%>").val(value.IFSCode);
                            $("#<%=txtBranchAddress.ClientID%>").val(value.Address);
                        });
                    }
                });
            }
            else {
                $("#<%=txtBranchIFSC.ClientID%>").val('');
                $("#<%=txtBranchAddress.ClientID%>").val('');
            }
        }
    </script>
    <%-- Save Record --%>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#btnSubmit').click(function () {
                if ($('#<%=txtFathername.ClientID%>').val().toString().trim() == "") {
                    isValid = false;
                }
                if (isValid) {
                    var objApplicant = {};

                    objApplicant.FatherName = $('#<%=txtFathername.ClientID%>').val();
                    objApplicant.DOB = $('#<%=txtDOB.ClientID%>').val();
                    objApplicant.Gender = $('#<%=ddlGender.ClientID%>').val();
                    objApplicant.Caste = $('#<%=ddlCaste.ClientID%>').val();
                    objApplicant.RevenueVillage = $('#<%=txtVillagename.ClientID%>').val();
                    objApplicant.PostOffice = $('#<%=txtPostOffice.ClientID%>').val();
                    objApplicant.PinNo = $('#<%=txtPinno.ClientID%>').val();
                    objApplicant.DistrictNo = $('#<%=ddlDistrict.ClientID%>').val();
                    objApplicant.BlockNo = $('#<%=ddlBlock.ClientID%>').val();
                    objApplicant.TehsilNo = 0;
                    objApplicant.PostallAddress = $('#<%=txtaddress.ClientID%>').val();
                    objApplicant.MobileNo = $('#<%=txtmobile.ClientID%>').val();
                    objApplicant.UserBankName = $('#<%=ddlBank.ClientID%>').val();
                    objApplicant.UserBankShakha = $('#<%=ddlBranch.ClientID%>').val();
                    objApplicant.UserBankIFSC = $('#<%=txtBranchIFSC.ClientID%>').val();
                    objApplicant.UserAcNo = $('#<%=txtAcno.ClientID%>').val();
                    objApplicant.EmailID = $('#<%=txtEmail.ClientID%>').val();
                    objApplicant.Phone_no = $('#<%=txtPhone.ClientID%>').val();
                    objApplicant.TehsilName = $('#<%=txtTehsilName.ClientID%>').val();
                    event.preventDefault();
                    $.ajax({
                        type: "POST",
                        url: "ApplicantProfile.aspx/UpdateProfile",
                        data: '{objApplicant: ' + JSON.stringify(objApplicant) + '}',
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            var result = $.parseJSON(data.d)
                            if (result.Status="OK") {
                                alert(result.Msg);
                                window.location.href = "ApplicantProfile.aspx";
                            }
                            else
                                alert(result.Msg);
                        },
                        error: function(e) {
                            event.preventDefault();
                        }
                    });
                }
            });
        });
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="content-container">
        <asp:HiddenField ID="hidDistrict" runat="server" Value="0"></asp:HiddenField>
        <asp:HiddenField ID="hidTehsil" runat="server" Value="0"></asp:HiddenField>
        <asp:HiddenField ID="HiddenFielddistid" runat="server" Value="0"></asp:HiddenField>
        <asp:HiddenField ID="HiddenFieldblockid" runat="server" Value="0"></asp:HiddenField>
        <asp:HiddenField ID="HiddenFieldbranchid" runat="server" Value="0"></asp:HiddenField>
        <asp:HiddenField ID="HiddenRegistrationKey" runat="server" Value="0"></asp:HiddenField>

        <div class="pageheader hidden-xs">
            <h3><i class="fa fa-home"></i>Applicant Profile </h3>
            <div class="breadcrumb-wrapper">
                <span class="label">You are here:</span>
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">Home </a></li>
                    <li class="active">Applicant Profile </li>
                </ol>
            </div>
        </div>
        <div id="page-content">
            <div class="form-horizontal">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel">
                            <div class="panel-heading">
                                <h3 class="panel-title"><strong>Basic Details</strong></h3>
                            </div>
                            <div class="panel-body">
                                <div class="row mar-top">
                                    <div class="col-lg-6">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="control-label col-md-4">Applicant Name </label>
                                                <div class="col-md-6">
                                                    <asp:TextBox runat="server" ID="txtName" CssClass="form-control" ReadOnly="true" placeholder="Applicant Name"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-4">Gender </label>
                                                <div class="col-md-6">
                                                    <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-control selectpicker" required>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                             <div class="form-group">
                                                <label class="control-label col-md-4">Caste </label>
                                                <div class="col-md-6">
                                                    <asp:DropDownList runat="server" ID="ddlCaste" required CssClass="form-control selectpicker"></asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-4">Aadhar No </label>
                                                <div class="col-md-6">
                                                    <asp:TextBox runat="server" ID="txtAadhar" required CssClass="form-control" placeholder="Aadhar No."></asp:TextBox>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="control-label col-md-4">Telephone No </label>
                                                <div class="col-md-6">
                                                    <asp:TextBox runat="server" ID="txtPhone" CssClass="form-control" placeholder="Telephone No.">                                                  
                                                    </asp:TextBox>
                                                </div>
                                            </div>

                                        </fieldset>
                                    </div>

                                    <div class="col-lg-6">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="control-label col-md-4">Father/Husband Name </label>
                                                <div class="col-md-6">
                                                    <asp:TextBox runat="server" ID="txtFathername" CssClass="form-control" required placeholder="Father/Husband Name">
                                                    </asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-4">Date Of Birth </label>
                                                <div class="col-md-6">
                                                    <div class="input-group date">
                                                        <asp:TextBox runat="server" ID="txtDOB" CssClass="form-control"></asp:TextBox>
                                                        <span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
                                                    </div>
                                                    <%--<div class="demo-dp-txtinput">
                                                        <asp:TextBox runat="server" ID="txtDOB" CssClass="form-control" placeholder="dd/mm/yyyy" data-date-format='dd/mm/yyyy'
                                                         data-bv-date="true" data-bv-date-format="DD/MM/YYYY" data-bv-date-message="Date of Birth Not Valid." required>
                                                        </asp:TextBox>
                                                    </div>--%>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-4">Mobile No </label>
                                                <div class="col-md-6">
                                                    <asp:TextBox runat="server" ReadOnly="true" ID="txtmobile" CssClass="form-control" placeholder="Mobile here.."></asp:TextBox>
                                                    <%-- <asp:Button ID="Button2" class="btn btn-info btn-xs" runat="server" Text="Change Mobile No." Style="margin-top:5px" />--%>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-4">Email Id </label>
                                                <div class="col-md-6">
                                                    <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" placeholder="Email Id">                                                
                                                    </asp:TextBox>
                                                </div>
                                            </div>

                                        </fieldset>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel">
                            <div class="panel-heading">
                                <h3 class="panel-title"><strong>Address Details</strong></h3>
                            </div>
                            <div class="panel-body">
                                <div class="row mar-top">
                                    <div class="col-lg-6">
                                        <fieldset>

                                            <div class="form-group">
                                                <label class="control-label col-md-4">Address </label>
                                                <div class="col-md-6">
                                                    <asp:TextBox runat="server" ID="txtaddress" TextMode="MultiLine" Rows="3" required CssClass="form-control"
                                                        placeholder="Applicant Address">                                                         
                                                    </asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-4">Division</label>
                                                <div class="col-md-6">
                                                    <asp:DropDownList ID="ddlDivision" runat="server" required onchange="GetDistrictByDivision()" CssClass="form-control selectpicker"
                                                        data-live-search="true">
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-4">District </label>
                                                <div class="col-md-6">
                                                    <asp:DropDownList ID="ddlDistrict" onchange="GetBlockByDistrict()" required runat="server" CssClass="form-control selectpicker" data-live-search="true">
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-4">Block</label>
                                                <div class="col-md-6">
                                                    <asp:DropDownList ID="ddlBlock" runat="server" onchange="getvikasname()" required CssClass="form-control selectpicker" data-live-search="true">
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>

                                    <div class="col-lg-6">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="control-label col-md-4">Tehsil Name</label>
                                                <div class="col-md-6">
                                                    <asp:TextBox runat="server" ID="txtTehsilName" required CssClass="form-control" placeholder="Tehsil Name">                                                  
                                                    </asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-4">Village Name </label>
                                                <div class="col-md-6">
                                                    <asp:TextBox runat="server" ID="txtVillagename" required CssClass="form-control" placeholder="Village Name"></asp:TextBox>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="control-label col-md-4">Post Office </label>
                                                <div class="col-md-6">
                                                    <asp:TextBox runat="server" ID="txtPostOffice"  CssClass="form-control" placeholder="Post Office" required>
                                                    </asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-4">Pin Code </label>
                                                <div class="col-md-6">
                                                    <asp:TextBox runat="server" ID="txtPinno" CssClass="form-control" placeholder="Pin Code">
                                                    </asp:TextBox>
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel">
                            <div class="panel-heading">
                                <h3 class="panel-title"><strong>Bank Details</strong></h3>
                            </div>
                            <div class="panel-body">
                                <div class="row mar-top">
                                    <div class="col-lg-6">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="control-label col-md-4">Bank Name </label>
                                                <div class="col-md-6">
                                                    <asp:DropDownList ID="ddlBank" runat="server" onchange="GetBranch()" CssClass="form-control selectpicker"
                                                        data-live-search="true">
                                                    </asp:DropDownList>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="control-label col-md-4">Branch Address </label>
                                                <div class="col-md-6">
                                                    <asp:TextBox runat="server" ID="txtBranchAddress" ReadOnly CssClass="form-control" placeholder="Branch Address">                                                       
                                                    </asp:TextBox>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="control-label col-md-4">Account No </label>
                                                <div class="col-md-6">
                                                    <asp:TextBox runat="server" ID="txtAcno" required CssClass="form-control" placeholder="Account No">                                                     
                                                    </asp:TextBox>
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>

                                    <div class="col-lg-6">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="control-label col-md-4">Branch Name </label>
                                                <div class="col-md-6">
                                                    <asp:DropDownList ID="ddlBranch" required runat="server" onchange="GetBranchDetail()" CssClass="form-control selectpicker"
                                                        data-live-search="true">
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-md-4">IFSC Code </label>
                                                <div class="col-md-6">
                                                    <asp:TextBox runat="server" ID="txtBranchIFSC" ReadOnly CssClass="form-control" placeholder="IFSC Code">                                                     
                                                    </asp:TextBox>
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>
                                </div>


                            </div>

                            <div class="panel-footer">
                                <button id="btnSubmit" class="btn btn-info pull-right" type="submit">Submit</button>
                                <button type="reset" class="btn btn-warning btn-lg">Cancel</button>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            $('.input-group.date').datepicker({
                format: "dd/mm/yyyy",
                keyboardNavigation: false,
                todayHighlight: true, autoclose: true,
            });
        });
    </script>
</asp:Content>

