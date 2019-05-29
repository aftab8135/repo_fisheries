<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DistrictMaster.master" AutoEventWireup="true" CodeFile="KCC_ProgressDetail.aspx.cs" Inherits="MPR_KCC_ProgressDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .panel-heading {
            background-color: #f9f9f9 !important;
        }

        .panel-title {
            line-height: 44px !important;
        }
    </style>
      <!--Bootstrap Validator [ OPTIONAL ]-->
    <link href="<%=ResolveUrl("~/plugins/bootstrap-validator/bootstrapValidator.min.css") %>" rel="stylesheet" />
    <script src="<%=ResolveUrl("~/js/jquery-2.1.1.min.js") %>"></script>
    <%-- For Load Data --%>
    <script type="text/javascript">
        $(document).ready(function () {
            $.ajax({
                type: "POST",
                url: "KCC_ProgressDetail.aspx/GetMonthName",
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
                    ddlType.selectpicker('refresh');
                }
            });

            var objKCC_Target = {};
            $.ajax({
                type: "POST",
                url: "KCC_ProgressDetail.aspx/GetYearTarget",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    objKCC_Target = r.d;
                    $('#txtKCCTarget').val(objKCC_Target.KCCTarget);                 
                }
            });

            var objKCC_PastMonth = {};
            $.ajax({
                type: "POST",
                url: "KCC_ProgressDetail.aspx/GetPastMonthProgress",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    objKCC_PastMonth = r.d;
                    $('#hidPastMonthTotalCard').val(objKCC_PastMonth.PastMonthTotalCard);
                    $('#hidPastMonthTotalAmount').val(parseFloat(objKCC_PastMonth.PastMonthTotalAmount).toFixed(2));
                }
            });
        });

    </script>
     <script type="text/javascript">
         $(document).ready(function () {
             $("#btnSubmit").click(function () {
                 var MonthId = $('#ddlMonthName').val();
                 var YearTarget = $('#txtKCCTarget').val();
                 if (MonthId > 0 && YearTarget != "") {
                     var objKCCMonthlyProgress = {};
                     objKCCMonthlyProgress.MonthKey = parseInt(MonthId);
                     objKCCMonthlyProgress.TotalTarget = parseInt(YearTarget);
                     objKCCMonthlyProgress.CurrentMonthTotalCard = parseInt($('#txtCardTotal').val());
                     objKCCMonthlyProgress.CurrentMonthTotalAmount = parseFloat($('#txtCardAmount').val());

                     objKCCMonthlyProgress.PastMonthTotalCard = parseInt($('#hidPastMonthTotalCard').val());
                     objKCCMonthlyProgress.PastMonthTotalAmount = parseFloat($('#hidPastMonthTotalAmount').val());

                     $.ajax({
                         type: "POST",
                         url: "KCC_ProgressDetail.aspx/Create",
                         data: '{objRecord:' + JSON.stringify(objKCCMonthlyProgress) + '}',
                         contentType: "application/json; charset=utf-8",
                         dataType: "json",
                         success: function (data) {
                             var r = $.parseJSON(data.d);
                             if (r.StatusCode == "200") {
                                 alert(r.Msg);
                                 window.location.href = "KCC_ProgressDetail.aspx";
                             }
                             else {
                                 alert(r.Msg);
                             }
                         },
                         error: function (e) {
                             alert('Something went wrong');
                         }
                     });
                 }
                 else {
                     alert('Please Select month or fill yearly target first.');
                     event.preventDefault();
                 }
             });
         });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="content-container">
        <%--  <asp:HiddenField ID="hidYearTargetKey" Value="" runat="server" />--%>
         <input type="hidden" id="hidPastMonthTotalCard" value="" />
          <input type="hidden" id="hidPastMonthTotalAmount" value="" />
        <!--Page Title-->
        <!--------------------------------------------------------->
        <div class="pageheader hidden-xs">
            <h3><i class="fa fa-home"></i>किसान क्रेडिट कार्ड योजना की प्रगति</h3>
            <div class="breadcrumb-wrapper">
                <%--  <span class="label">You are here:</span>--%>
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">होम </a></li>
                    <li class="active">किसान क्रेडिट कार्ड योजना की प्रगति</li>
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
                                <h3 class="panel-title"><strong>किसान क्रेडिट कार्ड योजना की प्रगति</strong></h3>
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

                            <div class="panel-body" style="margin-top: -15px">
                                <div class="row mar-top">
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="ddlMonthName">माह का नाम</label>
                                            <div class="col-lg-6">
                                                <select class="form-control selectpicker" data-live-search="true" id="ddlMonthName"></select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="txtKCCTarget">वार्षिक लक्ष्य</label>
                                            <div class="col-lg-6">
                                                <input type="text"  id="txtKCCTarget" value="0" class="form-control" readonly="readonly" />
                                            </div>
                                        </div>
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
                                <h3 class="panel-title">माह में निर्गत कार्ड </h3>
                            </div>
                            <div class="panel-body" style="margin-top: -15px">
                                <div class="row mar-top">
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="CardTotal">संख्या</label>
                                            <div class="col-lg-6">
                                                <input type="text"  id="txtCardTotal" value="0" class="form-control right" style="text-align: right" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="control-label col-lg-4" for="CardAmount">धनराशी (लाख रु० में)</label>
                                            <div class="col-lg-6">
                                                <input type="text"  id="txtCardAmount" value="0.00" class="form-control right" style="text-align: right" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                              
                            </div>
                            <div class="panel-footer">
                                <div class="col-lg-offset-2">
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
        <!--===================================================-->
        <!--End page content-->
    </div>

      <!--Jasmine Admin [ RECOMMENDED ]-->
    <script src="<%=ResolveUrl("~/js/scripts.js") %>"></script>
    <script src="<%=ResolveUrl("~/plugins/bootstrap-validator/bootstrapValidator.min.js") %>"></script>

</asp:Content>

