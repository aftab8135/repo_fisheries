<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ApplicantMaster.Master" AutoEventWireup="true" CodeFile="ApplicantSchemeRegt.aspx.cs" Inherits="Applicant_ApplicantSchemeRegt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="<%=ResolveUrl("~/js/jquery-2.1.1.min.js") %>"></script>
    <!--Demo [ DEMONSTRATION ]-->
    <link href="../css/demo/jquery-steps.min.css" rel="stylesheet" />
    <!--Bootstrap Datepicker [ OPTIONAL ]-->
    <link href="<%=ResolveUrl("~/plugins/bootstrap-datepicker/bootstrap-datepicker.css") %>" rel="stylesheet" />
    <script src="<%=ResolveUrl("~/plugins/bootstrap-datepicker/bootstrap-datepicker.js") %>"></script>

    <script type="text/javascript">
        var isFormValid = true;
        $(document).ready(function () {
            $('#frmAppReg').bootstrapValidator({
                framework: 'bootstrap',
                icon: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    owernership: {
                        row : '.form-group',
                        validators: {
                            notEmpty: {
                                message: 'Invalid Entry !'
                            }
                        }
                    },
                    plotno: {
                        row: '.form-group',
                        validators: {
                            notEmpty: {
                                message: 'Invalid Entry !'
                            }
                        }
                    },
                    pondArea: {
                        row: '.form-group',
                        validators: {
                            notEmpty: {
                                message: 'Invalid Entry !'
                            }
                        }
                    },
                    labourNos: {
                        row: '.form-group',
                        validators: {
                            notEmpty: {
                                message: 'Invalid Entry !'
                            },
                            digits: {
                                message: 'Invalid Entry !'
                            }
                        }

                    },
                    duration: {
                        row: '.form-group',
                        validators: {
                            notEmpty: {
                                message: 'Invalid Entry !'
                            }
                            ,
                            digits: {
                                message: 'Invalid Entry !'
                            }
                        }
                    },
                    expDate: {
                        row: '.form-group',
                        validators: {
                            date: {
                                format: 'DD/MM/YYYY',
                                message: 'Invalid Date Format. Valid Date Format is "DD/MM/YYYY"'
                            }
                        }
                    }
                }
            });
        });
    </script>
    <%--Functions--%>
    <script type="text/javascript">
        function landTypeChange() {
            if ($('#<%=ddlOwnership.ClientID%>').val() == 24) {
                $("#<%=txtLeadDuration.ClientID%>").val('0');
                $("#<%=txtLeadDuration.ClientID%>").attr("disabled", "disabled");
            }
            else {
                $("#<%=txtLeadDuration.ClientID%>").val('0');
                $("#<%=txtLeadDuration.ClientID%>").removeAttr("disabled");
            }
        }
        function calculateSubsidy() {
            var ratePerHect = parseFloat("<%=LandRateInHect%>");
            var totalLand = parseFloat($("#<%=txtPondArea.ClientID%>").val()) + parseFloat($("#<%=txtWaterArea.ClientID%>").val())
            if (totalLand > 0 && ratePerHect > 0) {

                var totalLandCost = parseFloat(totalLand * ratePerHect);
                var totalSubCost = parseFloat((totalLandCost * (100 - parseFloat("<%=BenSharePer%>"))) / 100);

                var centSCost = ((totalSubCost * parseFloat("<%=CenSharePer%>")) / 100).toFixed(2);
                var statSCost = ((totalSubCost * parseFloat("<%=StaSharePer%>")) / 100).toFixed(2);

                var benSCost = (totalLandCost - (parseFloat(centSCost) + parseFloat(statSCost))).toFixed(2);

                $("#<%=txtProjectCost.ClientID%>").val((totalLandCost).toFixed(2));
                $("#<%=txtCentralShare.ClientID%>").val(centSCost);
                $("#<%=txtStateshare.ClientID%>").val(statSCost);
                $("#<%=txtBenShare.ClientID%>").val(benSCost);
                $("#<%=txtTotalSubsidy.ClientID%>").val((parseFloat(centSCost) + parseFloat(statSCost)).toFixed(2));
            }
        }
    </script>
    <%-- Insert Applicant Scheme Registration --%>
    <script type="text/javascript">
        function submitScheme() {
            $('#frmAppReg').bootstrapValidator('validate');
            // if only view application
            if ("<%=AppicationCode%>" != "" && "<%=objForm%>" == "False" && "<%=objAttach%>" == "False") {
                alert("Application Already Registered.");
                event.preventDefault();
            }
            else if ("<%=AppicationCode%>" != "") {
                // if only update appliction detail
                if ("<%=objForm%>" == "True" && "<%=objAttach%>" == "False") {


                    event.preventDefault();

                    var appSchemeReg = {};
                    var appSchemeDocs = [];

                    appSchemeReg.LandOwnership = $('#<%=ddlOwnership.ClientID%>').val();
                    appSchemeReg.PlotNo = $('#<%=txtPlotno.ClientID%>').val();
                    appSchemeReg.LeaseDuration = ($('#<%=txtLeadDuration.ClientID%>').val() != "" ? parseInt($('#<%=txtLeadDuration.ClientID%>').val()) : 0);
                    appSchemeReg.LandArea = parseFloat($('#<%=txtPondArea.ClientID%>').val()).toFixed(2);
                    appSchemeReg.WaterArea = parseFloat($('#<%=txtWaterArea.ClientID%>').val()).toFixed(2);
                    appSchemeReg.TotalArea = (parseFloat(appSchemeReg.LandArea) + parseFloat(appSchemeReg.WaterArea)).toFixed(2);

                    appSchemeReg.ProposedWork = $('#<%=txtPropsed.ClientID%>').val();
                    appSchemeReg.AssistanceReceived = $('#<%=txtAssistanceReceived.ClientID%>').val();
                    appSchemeReg.ProjectCost = $('#<%=txtProjectCost.ClientID%>').val();
                    appSchemeReg.BenShareCost = $('#<%=txtBenShare.ClientID%>').val();
                    appSchemeReg.CenShareCost = $('#<%=txtCentralShare.ClientID%>').val();
                    appSchemeReg.StaShareCost = $('#<%=txtStateshare.ClientID%>').val();
                    appSchemeReg.TotalSubAmount = $('#<%=txtTotalSubsidy.ClientID%>').val();
                    appSchemeReg.ReasonForFinDef = $('#<%=txtReasonForFinDef.ClientID%>').val();
                    appSchemeReg.APTExperience = $('#<%=txtExperience.ClientID%>').val();
                    appSchemeReg.EcoOperation = $('#<%=txtEcoOperation.ClientID%>').val();
                    appSchemeReg.FinancialTieUp = $('#<%=txtFinaciaTieUp.ClientID%>').val();
                    appSchemeReg.EstRecCost = $('#<%=txtEstRecCost.ClientID%>').val();
                    appSchemeReg.ExcOprtDate = $('#<%=txtExpectedDate.ClientID%>').val();
                    appSchemeReg.MarketingTieUp = $('#<%=txtMarketingTieUp.ClientID%>').val();
                    appSchemeReg.LabourSource = $('#<%=txtLabourSource.ClientID%>').val();
                    appSchemeReg.LabourNos = ($('#<%=txtNoofLabour.ClientID%>').val() != "" ? parseInt($('#<%=txtNoofLabour.ClientID%>').val()) : 0);

                    $.ajax({
                        type: "POST",
                        url: "ApplicantSchemeRegt.aspx/Update",
                        data: '{objAPT_SchemeRegistration: ' + JSON.stringify(appSchemeReg) + '}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            var result = $.parseJSON(response.d)
                            if (result.StatusCode = "OK") {
                                alert(result.Msg);
                                window.location.href = "ApplicantDashboard.aspx";
                            }
                            else
                                alert(result.Msg);
                        },
                        error: function (err) {

                            alert(err.statusText)
                        }
                    });

                }
                    // if update application detail and attached documents.
                else if ("<%=objAttach%>" == "True" && "<%=objForm%>" == "False") {
                    if ($('#<%=txtPlotno.ClientID%>').val() != "" && ($('#<%=txtPondArea.ClientID%>').val() != "" || $('#<%=txtWaterArea.ClientID%>').val() != "")) {
                        event.preventDefault();

                        var appSchemeReg = {};
                        var appSchemeDocs = [];

                        var documents = [];
                        var dataFiles = new FormData();
                        var count = 1;

                        dataFiles.append("RegistrationKey", "<%=ApplicantKey%>");
                        dataFiles.append("SchemeKey", "<%=SchemeKey%>");

                        if ($("input[name$=DocFileUpload]").length > 0) {
                            for (var i = 0; i < $("input[name$=DocFileUpload]").length; i++) {
                                fileUpload = $("input[name$=DocFileUpload]").get(i);
                                files = fileUpload.files;
                                if (files.length > 0) {
                                    dataFiles.append(count++, $($("input[name$=docKey]").get(i)).val());
                                    dataFiles.append(files[0].name, files[0]);
                                }
                            }
                            if (count <= $("input[name$=DocFileUpload]").length) {
                                alert('Please Attach All The Required Document.');
                                event.preventDefault();
                                return;
                            }
                        }

                        appSchemeReg.LandOwnership = $('#<%=ddlOwnership.ClientID%>').val();
                        appSchemeReg.PlotNo = $('#<%=txtPlotno.ClientID%>').val();
                        appSchemeReg.LeaseDuration = ($('#<%=txtLeadDuration.ClientID%>').val() != "" ? parseInt($('#<%=txtLeadDuration.ClientID%>').val()) : 0);
                        appSchemeReg.LandArea = parseFloat($('#<%=txtPondArea.ClientID%>').val()).toFixed(2);
                        appSchemeReg.WaterArea = parseFloat($('#<%=txtWaterArea.ClientID%>').val()).toFixed(2);
                        appSchemeReg.TotalArea = (parseFloat(appSchemeReg.LandArea) + parseFloat(appSchemeReg.WaterArea)).toFixed(2);

                        appSchemeReg.ProposedWork = $('#<%=txtPropsed.ClientID%>').val();
                        appSchemeReg.AssistanceReceived = $('#<%=txtAssistanceReceived.ClientID%>').val();
                        appSchemeReg.ProjectCost = $('#<%=txtProjectCost.ClientID%>').val();
                        appSchemeReg.BenShareCost = $('#<%=txtBenShare.ClientID%>').val();
                        appSchemeReg.CenShareCost = $('#<%=txtCentralShare.ClientID%>').val();
                        appSchemeReg.StaShareCost = $('#<%=txtStateshare.ClientID%>').val();
                        appSchemeReg.TotalSubAmount = $('#<%=txtTotalSubsidy.ClientID%>').val();
                        appSchemeReg.ReasonForFinDef = $('#<%=txtReasonForFinDef.ClientID%>').val();
                        appSchemeReg.APTExperience = $('#<%=txtExperience.ClientID%>').val();
                        appSchemeReg.EcoOperation = $('#<%=txtEcoOperation.ClientID%>').val();
                        appSchemeReg.FinancialTieUp = $('#<%=txtFinaciaTieUp.ClientID%>').val();
                        appSchemeReg.EstRecCost = $('#<%=txtEstRecCost.ClientID%>').val();
                        appSchemeReg.ExcOprtDate = $('#<%=txtExpectedDate.ClientID%>').val();
                        appSchemeReg.MarketingTieUp = $('#<%=txtMarketingTieUp.ClientID%>').val();
                        appSchemeReg.LabourSource = $('#<%=txtLabourSource.ClientID%>').val();
                        appSchemeReg.LabourNos = ($('#<%=txtNoofLabour.ClientID%>').val() != "" ? parseInt($('#<%=txtNoofLabour.ClientID%>').val()) : 0);

                        $.ajax({
                            url: "SchemeDocHandler.ashx",
                            type: "POST",
                            //                        async: false,
                            data: dataFiles,
                            contentType: false,
                            processData: false,

                            success: function (data) {
                                if (data == "Error") {
                                    //$('body').Wload('hide', { time: 0 });
                                    alert('Problem in attached document.');
                                    event.preventDefault();
                                }
                                else if (data == "NoFiles") {
                                    // $('body').Wload('hide', { time: 0 });
                                    alert('Please attach required document.');
                                    event.preventDefault();
                                }
                                else if (data != "Error" && data != "NoFiles") {
                                    var docList = $.parseJSON(data);

                                    if (docList.length > 0) {
                                        appSchemeReg.SchemeDocuments = docList;
                                        $.ajax({
                                            type: "POST",
                                            url: "ApplicantSchemeRegt.aspx/Update",
                                            data: '{objAPT_SchemeRegistration: ' + JSON.stringify(appSchemeReg) + '}',
                                            contentType: "application/json; charset=utf-8",
                                            dataType: "json",
                                            success: function (response) {
                                                var result = $.parseJSON(response.d)
                                                if (result.StatusCode = "OK") {
                                                    alert(result.Msg);
                                                    window.location.href = "ApplicantDashboard.aspx";
                                                }
                                                else
                                                    alert(result.Msg);
                                            },
                                            error: function (err) {

                                                // $('body').Wload('hide', { time: 0 });
                                                alert(err.statusText)
                                            }
                                        });
                                    }
                                    else {
                                        //$('body').Wload('hide', { time: 0 });
                                        alert('Please attach required document.');
                                        event.preventDefault();
                                    }
                                } else {
                                    //$('body').Wload('hide', { time: 0 });
                                    alert('Problem in attaching document.');
                                    event.preventDefault();
                                }
                            },
                            error: function (err) {
                                alert(err.statusText);
                            }
                        });
                    }
                }

        }

            else if ("<%=AppicationCode%>" == "") {

                if ($('#<%=txtPlotno.ClientID%>').val() != "" && ($('#<%=txtPondArea.ClientID%>').val() != "" || $('#<%=txtWaterArea.ClientID%>').val() != "")) {
                event.preventDefault();

                var appSchemeReg = {};
                var appSchemeDocs = [];
                var documents = [];
                var dataFiles = new FormData();
                var count = 1;

                dataFiles.append("RegistrationKey", "<%=ApplicantKey%>");
                dataFiles.append("SchemeKey", "<%=SchemeKey%>");

                    if ($("input[name$=DocFileUpload]").length > 0) {
                        for (var i = 0; i < $("input[name$=DocFileUpload]").length; i++) {
                            fileUpload = $("input[name$=DocFileUpload]").get(i);
                            files = fileUpload.files;
                            if (files.length > 0) {
                                dataFiles.append(count++, $($("input[name$=docKey]").get(i)).val());
                                dataFiles.append(files[0].name, files[0]);
                            }
                        }
                        if (count <= $("input[name$=DocFileUpload]").length) {
                            alert('Please Attach All The Required Document.');
                            event.preventDefault();
                        }
                    }
                    appSchemeReg.LandOwnership = $('#<%=ddlOwnership.ClientID%>').val();
                    appSchemeReg.PlotNo = $('#<%=txtPlotno.ClientID%>').val();
                    appSchemeReg.LeaseDuration = ($('#<%=txtLeadDuration.ClientID%>').val() != "" ? parseInt($('#<%=txtLeadDuration.ClientID%>').val()) : 0);
                    appSchemeReg.LandArea = parseFloat($('#<%=txtPondArea.ClientID%>').val()).toFixed(2);
                    appSchemeReg.WaterArea = parseFloat($('#<%=txtWaterArea.ClientID%>').val()).toFixed(2);
                    appSchemeReg.TotalArea = (parseFloat(appSchemeReg.LandArea) + parseFloat(appSchemeReg.WaterArea)).toFixed(2);

                    appSchemeReg.ProposedWork = $('#<%=txtPropsed.ClientID%>').val();
                    appSchemeReg.AssistanceReceived = $('#<%=txtAssistanceReceived.ClientID%>').val();
                    appSchemeReg.ProjectCost = $('#<%=txtProjectCost.ClientID%>').val();
                    appSchemeReg.BenShareCost = $('#<%=txtBenShare.ClientID%>').val();
                    appSchemeReg.CenShareCost = $('#<%=txtCentralShare.ClientID%>').val();
                    appSchemeReg.StaShareCost = $('#<%=txtStateshare.ClientID%>').val();
                    appSchemeReg.TotalSubAmount = $('#<%=txtTotalSubsidy.ClientID%>').val();
                    appSchemeReg.ReasonForFinDef = $('#<%=txtReasonForFinDef.ClientID%>').val();
                    appSchemeReg.APTExperience = $('#<%=txtExperience.ClientID%>').val();
                    appSchemeReg.EcoOperation = $('#<%=txtEcoOperation.ClientID%>').val();
                    appSchemeReg.FinancialTieUp = $('#<%=txtFinaciaTieUp.ClientID%>').val();
                    appSchemeReg.EstRecCost = $('#<%=txtEstRecCost.ClientID%>').val();
                    appSchemeReg.ExcOprtDate = $('#<%=txtExpectedDate.ClientID%>').val();
                    appSchemeReg.MarketingTieUp = $('#<%=txtMarketingTieUp.ClientID%>').val();
                    appSchemeReg.LabourSource = $('#<%=txtLabourSource.ClientID%>').val();
                    appSchemeReg.LabourNos = ($('#<%=txtNoofLabour.ClientID%>').val() != "" ? parseInt($('#<%=txtNoofLabour.ClientID%>').val()) : 0);

                    $.ajax({
                        url: "SchemeDocHandler.ashx",
                        type: "POST",
                        //                        async: false,
                        data: dataFiles,
                        contentType: false,
                        processData: false,

                        success: function (data) {
                            if (data == "Error") {
                                //$('body').Wload('hide', { time: 0 });
                                alert('Problem in attached document.');
                                event.preventDefault();
                            }
                            else if (data == "NoFiles") {
                                //$('body').Wload('hide', { time: 0 });
                                alert('Please attach required document.');
                                event.preventDefault();
                            }
                            else if (data != "Error" && data != "NoFiles") {
                                var docList = $.parseJSON(data);

                                if (docList.length > 0) {
                                    appSchemeReg.SchemeDocuments = docList;
                                    $.ajax({
                                        type: "POST",
                                        url: "ApplicantSchemeRegt.aspx/Create",
                                        data: '{objAPT_SchemeRegistration: ' + JSON.stringify(appSchemeReg) + '}',
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        success: function (response) {
                                            var result = $.parseJSON(response.d)
                                            if (result.StatusCode = "OK") {
                                                alert(result.Msg);
                                                window.location.href = "AcknowledgementReciept.aspx?APCode=" + result.APCode;
                                            }
                                            else
                                                alert(result.Msg);
                                        },
                                        error: function (err) {

                                            //$('body').Wload('hide', { time: 0 });
                                            alert(err.statusText)
                                        }
                                    });
                                }
                                else {
                                    //$('body').Wload('hide', { time: 0 });
                                    alert('Please attach required document.');
                                    event.preventDefault();
                                }
                            } else {
                                //$('body').Wload('hide', { time: 0 });
                                alert('Problem in attaching document.');
                                event.preventDefault();
                            }
                        },
                        error: function (err) {
                            alert(err.statusText);
                        }
                    });
                }
                else {
                    alert('Please Enter Required Fields.');
                    event.preventDefault();
                }
            }
}
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="content-container">
        <!--Page Title-->
        <!--------------------------------------------------------->
        <div class="pageheader hidden-xs">
            <h3><i class="fa fa-home"></i>Online Scheme Registration </h3>
            <div class="breadcrumb-wrapper">
                <span class="label">You are here:</span>
                <ol class="breadcrumb">
                    <li><a href="#">Home </a></li>
                    <li class="active">Scheme </li>
                </ol>
            </div>
        </div>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <!--End page title-->
        <div id="page-content">
            <div class="form-horizontal" id="frmAppReg">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel">
                            <div class="panel-heading">
                                <h3 class="panel-title">
                                    <strong>
                                        <asp:Label ID="lblSchemeName" Text="अतिरिक्त जलक्षेत्र आच्छदित कर मत्स्य उत्पादन में वृद्धि" runat="server"></asp:Label>
                                    </strong>
                                </h3>
                            </div>
                            <!--No Label Form-->
                            <div class="panel-body" style="margin-top: -15px">
                                <div class="form-horizontal form-bordered" id="wizard-validate">
                                    <!-- Wizard Container 1 -->
                                    <div class="wizard-title">Applicant's Basic Information</div>
                                    <div class="wizard-container">
                                        <div class="form-group">
                                            <div class="col-md-12">
                                                <h4 class="text-primary"><i class="fa fa-user"></i>Applicant's Basic Information </h4>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <label>Name of Applicant : </label>
                                                    <asp:TextBox ID="txtApplicantName" runat="server" class="form-control" placeholder="Applicant Name" ReadOnly="true"></asp:TextBox>
                                                </div>
                                                <div class="col-sm-6">
                                                    <label>Father/Husband Name : </label>
                                                    <asp:TextBox ID="txtFatherName" runat="server" class="form-control" placeholder="Father/Husband Name" ReadOnly="true"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <label>Gender : </label>
                                                    <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-control selectpicker" disabled>
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="col-sm-6">
                                                    <label>Caste : </label>
                                                    <asp:DropDownList runat="server" ID="ddlCaste" CssClass="form-control selectpicker" disabled></asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <label>Mobile No : </label>
                                                    <asp:TextBox ID="txtMobile" runat="server" class="form-control" placeholder="Mobile No." ReadOnly="true"></asp:TextBox>
                                                </div>
                                                <div class="col-sm-6">
                                                    <label>Telephone No.  : </label>
                                                    <asp:TextBox ID="txtTelephone" runat="server" class="form-control" placeholder="Phone No." ReadOnly="true"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <label>Aadhar Number : </label>
                                                    <asp:TextBox ID="txtAadhar" runat="server" class="form-control" placeholder="Aadhar No." ReadOnly="true"></asp:TextBox>
                                                </div>
                                                <div class="col-sm-6">
                                                    <label>Postal Address : </label>
                                                    <asp:TextBox ID="txtAddress" runat="server" class="form-control" placeholder="Postal Address" ReadOnly="true"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <label>District : </label>
                                                    <asp:TextBox ID="txtDistrict" runat="server" CssClass="form-control" placeholder="District" ReadOnly="true"></asp:TextBox>
                                                </div>
                                                <div class="col-sm-6">
                                                    <label>Bank Name : </label>
                                                    <asp:TextBox ID="txtBankName" runat="server" CssClass="form-control" placeholder="Bank Name" ReadOnly="true"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">

                                                <div class="col-sm-6">
                                                    <label>Branch : </label>
                                                    <asp:TextBox ID="txtBranch" runat="server" CssClass="form-control selectpicker" ReadOnly="true">
                                                    </asp:TextBox>
                                                </div>
                                                <div class="col-sm-6">
                                                    <label>IFSC Code : </label>
                                                    <asp:TextBox ID="txtIFSC" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <label>Bank Account Number : </label>
                                                    <asp:TextBox ID="txtBankAcNo" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!--/ Wizard Container 1 -->
                                    <!-- Wizard Container 2 -->
                                    <div class="wizard-title">Details of Land/Pond</div>
                                    <div class="wizard-container">
                                        <div class="form-group">
                                            <div class="col-md-12">
                                                <h4 class="semibold text-primary"><i class="fa fa-area-chart"></i>Details of Land/Pond </h4>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <label>Revenue Village / राजस्व ग्राम : <span class="text-danger">*</span> </label>
                                                    <asp:TextBox ID="txtVillagename" runat="server" class="form-control" placeholder="Village Name" ReadOnly="true"></asp:TextBox>

                                                </div>
                                                <div class="col-md-6">
                                                    <label>Post Office / पोस्ट ऑफिस : <span class="text-danger">*</span></label>
                                                    <asp:TextBox ID="txtPostOffice" runat="server" class="form-control" placeholder="Post Office Name" ReadOnly="true"></asp:TextBox>

                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <label>Pin No/पिन नं० :</label>
                                                    <asp:TextBox ID="txtPin" runat="server" class="form-control" ReadOnly="true" />

                                                </div>
                                                <div class="col-md-6">
                                                    <label>Tehsil/तहसील</label>
                                                    <asp:TextBox class="form-control" ID="txtTehsil" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-lg-6">
                                                    <label>Ownership</label>
                                                    <asp:DropDownList ID="ddlOwnership" CssClass="form-control selectpicker" runat="server" onchange="landTypeChange();" name="owernership">
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="col-lg-6">
                                                    <label>Survey/Khasra/ Plot  number/</label>
                                                    <asp:TextBox ID="txtPlotno" class="form-control" runat="server" name="plotno"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-lg-6">
                                                    <label>Duration of lease (Days)</label>
                                                    <asp:TextBox class="form-control" ID="txtLeadDuration" runat="server" type="number" name="duration"></asp:TextBox>
                                                </div>
                                                <div class="col-lg-6">
                                                    <label>Total Land/Pond Area (Hectare)</label>
                                                    <asp:TextBox class="form-control" ID="txtPondArea" runat="server" type="number" min="0" step="0.01" Text="0" onchange="calculateSubsidy();" name="pondArea"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-lg-6">
                                                    <label>
                                                        Total Water Area (Hectare)
                                                    </label>
                                                    <asp:TextBox class="form-control" runat="server" ID="txtWaterArea" type="number" min="0" step="0.01" Text="0" onchange="calculateSubsidy();" name="waterArea"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Wizard Container 3 -->
                                    <div class="wizard-title">Other Information </div>
                                    <div class="wizard-container">
                                        <div class="form-group">
                                            <div class="col-md-12">
                                                <h4 class="semibold text-primary"><i class="fa fa-book"></i>Other Information </h4>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <label>Detail Of The Proposed Civil Work. (Design Details/Engineering Works To Be Certified By The Department of Fisheries.)</label>
                                                    <asp:TextBox ID="txtPropsed" class="form-control" placeholder="Detail Of The Proposed Civil Work. (Design Details/Engineering Works To Be Certified By The Department of Fisheries.)"
                                                        runat="server" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <label>Details Regarding Assistance Received Earlier For The Proposed Activity. (If Any, Carried Out Earlier May Be Mentioned A Long With The Year And Amount Incurred On Such Activity.)</label>
                                                    <asp:TextBox ID="txtAssistanceReceived" runat="server" class="form-control" placeholder="Details Regarding Assistance Received Earlier For The Proposed Activity. (If Any, Carried Out Earlier May Be Mentioned A Long With The Year And Amount Incurred On Such Activity.)"
                                                        TextMode="MultiLine" Rows="2"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <label>Project Cost of Civil Work (Rs.) </label>
                                                    <asp:TextBox ID="txtProjectCost" runat="server" class="form-control" placeholder="00.00" ReadOnly="true" TextMode="Number"></asp:TextBox>
                                                    <%--   <input type="text" id="txtprojectcost" runat="server" class="form-control" placeholder="00.00" />--%>
                                                </div>
                                                <div class="col-md-6">
                                                    <asp:Label ID="lblBenSharePer" runat="server" Text="Beneficiaries 60% Share (Rs.)" />
                                                    <asp:TextBox ID="txtBenShare" runat="server" class="form-control" placeholder="00.00" ReadOnly="true"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <asp:Label ID="lblCenSharePer" runat="server" Text="Central Share 60% of Total Subsidy (Rs.)" />
                                                    <asp:TextBox ID="txtCentralShare" runat="server" class="form-control" placeholder="00.00" ReadOnly="true"></asp:TextBox>
                                                </div>
                                                <div class="col-md-6">
                                                    <asp:Label ID="lblStaSharePer" runat="server" Text="State Share 40% of  Total Subsidy (Rs.)" />
                                                    <asp:TextBox ID="txtStateshare" runat="server" class="form-control" placeholder="00.00" ReadOnly="true"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <label>Total Subsidy Amount (Rs.)</label>
                                                    <asp:TextBox ID="txtTotalSubsidy" runat="server" class="form-control" placeholder="00.00" ReadOnly="true"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <label>Whether The Applicant is in Default Of Payment To Any Financial Institution/State Government For Loan/Assistance Availed Earlier. (If Any, Please Provide The Detail And Reasons For) </label>
                                                    <asp:TextBox ID="txtReasonForFinDef" runat="server" class="form-control" TextMode="MultiLine" Rows="2"
                                                        placeholder="Whether The Applicant is in Default Of Payment To Any Financial Institution/State Government For Loan/Assistance Availed Earlier. (If Any, Please Provide The Detail And Reasons For)"></asp:TextBox>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <label>Experience Of The Applicant In The Field And Details of Training Undergone So Far</label>
                                                    <asp:TextBox ID="txtExperience" runat="server" class="form-control" TextMode="MultiLine" Rows="2"
                                                        placeholder="Experience Of The Applicant In The Field And Details Of Training Undergone So Far"></asp:TextBox>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <label>Details Regarding Economics Of Operation.</label>
                                                    <asp:TextBox ID="txtEcoOperation" runat="server" class="form-control" placeholder="Details Regarding Economics Of Operation." TextMode="MultiLine" Rows="2"></asp:TextBox>

                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <label>Whether Any Financial Tie Up Has Been Made For Availing Bank Loan. (If Any, Provide Details)</label>
                                                    <asp:TextBox ID="txtFinaciaTieUp" runat="server" class="form-control" placeholder="Whether Any Financial Tie Up Has Been Made For Availing Bank Loan. (If Any, Provide Details)" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <label>Estimate Project Cost  Regarding  Recurring Cost. </label>
                                                    <asp:TextBox ID="txtEstRecCost" runat="server" class="form-control" placeholder="00.00" TextMode="Number"></asp:TextBox>
                                                </div>
                                                <div class="col-md-6">
                                                    <label>Expected Data Of Operation Of The Farm And Tentative Schedule Of Activities.</label>
                                                    <div class="input-group date" id="datePicker">
                                                        <asp:TextBox runat="server" ID="txtExpectedDate" CssClass="form-control" placeholder="dd/mm/yyyy" name="expDate"></asp:TextBox>
                                                        <span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <label>Marketing Tie Up</label>
                                                    <asp:TextBox ID="txtMarketingTieUp" Text="" placeholder="Marketing Tie Up" runat="server" class="form-control"></asp:TextBox>
                                                </div>
                                                <div class="col-md-6">
                                                    <label>Source Of Labour</label>
                                                    <asp:TextBox ID="txtLabourSource" runat="server" class="form-control" placeholder="Source of Labour"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <label>Number Of Labour Employed For As Well As Day To Day Operation.</label>
                                                    <asp:TextBox ID="txtNoofLabour" runat="server" class="form-control" placeholder="0" TextMode="Number" min="0" name="labourNos"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Wizard Container 4 -->
                                    <div class="wizard-title">Attachments</div>
                                    <div class="wizard-container">
                                        <div class="form-group">
                                            <div class="col-md-12">
                                                <h4 class="semibold text-primary"><i class="fa fa-paperclip"></i>Attachments</h4>
                                            </div>
                                        </div>
                                        <div class="panel">
                                            <div class="panel-body">
                                                <table class="table table-bordered table-responsive">
                                                    <colgroup>
                                                        <% if (AppicationCode != "")
                                                           {%>
                                                        <col style="width: 5%; text-align: center" />
                                                        <col style="width: 25%" />
                                                        <col style="width: 30%" />
                                                        <col style="width: 30%" />
                                                        <col style="width: 10%; text-align: center" />
                                                        <%} %>
                                                        <%else
                                                           {%>
                                                        <col style="width: 5%; text-align: center" />
                                                        <col style="width: 25%" />
                                                        <col style="width: 40%" />
                                                        <col style="width: 40%" />
                                                        <%} %>
                                                    </colgroup>
                                                    <thead>
                                                        <tr>

                                                            <% if (AppicationCode != "")
                                                               {%>

                                                            <th>Sr. No.</th>
                                                            <th>Document Name</th>
                                                            <th>Document Detail</th>
                                                            <th>Upload Document</th>
                                                            <th>View Document</th>

                                                            <%} %>
                                                            <%else
                                                               {%>

                                                            <th>Sr. No.</th>
                                                            <th>Document Name</th>
                                                            <th>Document Detail</th>
                                                            <th>Upload Document</th>

                                                            <%} %>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <% for (int i = 0; i < DTDocuments.Rows.Count; i++)
                                                           {%>
                                                        <tr>
                                                            <td><%=(i+1) %>.</td>
                                                            <td><%=DTDocuments.Rows[i]["DocumentName"].ToString()%></td>
                                                            <td><%=DTDocuments.Rows[i]["DocumentDetail"].ToString()%></td>
                                                            <td>
                                                                <input type="file" accept="image/jpeg,image/png" id="fu_<%=DTDocuments.Rows[i]["DocumentId"].ToString()%>" class="form-control" name="DocFileUpload" data-id="<%=DTDocuments.Rows[i]["DocumentId"].ToString()%>" <%=(AppicationCode == null || AppicationCode == "" ? "" : (Convert.ToBoolean(DTDocuments.Rows[i]["ObjDoc"]) == false ? "disabled": ""))%> />
                                                                <input type="hidden" id="hd_<%=DTDocuments.Rows[i]["DocumentId"].ToString()%>" name="docKey" value="<%=DTDocuments.Rows[i]["DocumentId"].ToString()%>" />
                                                            </td>
                                                            <% if (AppicationCode != "")
                                                               {%>
                                                            <td style="width: 10%; text-align: center">
                                                                <% if (DTDocuments.Rows[i]["DocFilePath"].ToString() == "")
                                                                   { %>
                                                                            Not Available
                                                                        <%}
                                                                   else
                                                                   { %>
                                                                <a href='<%= "../" + DBLayer.APT_SchemeDocuments + "/" + DTDocuments.Rows[i]["DocFilePath"].ToString()%>'
                                                                    target="_blank" class="btn btn-xs btn-primary">View File</a>
                                                                <%} %>
                                                            </td>
                                                            <% } %>
                                                        </tr>
                                                        <% }%>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Wizard Container 4 -->
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--JAVASCRIPT-->
    <!--=================================================-->
    <!--Form Wizard [ SAMPLE ]-->
    <script src="<%=ResolveUrl("~/js/demo/applicant-scheme-wizard.js")%>"></script>
    <!--Form Wizard [ SAMPLE ]-->
    <script src="<%=ResolveUrl("~/js/demo/applicant-scheme-regt.js")%>"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#datePicker').datepicker({
                format: 'dd/mm/yyyy',
                autoclose: true,
                todayHighlight: true
            }).on('changeDate', function (e) {
                // Revalidate the date field
                $('#frmDBTStatus').data('bootstrapValidator').revalidateField('DBTDate');
            });;
        });

    </script>
</asp:Content>
