<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/HOMaster.master" AutoEventWireup="true" CodeFile="DocumentVerificationReport.aspx.cs" Inherits="HeadQuarter_DocumentVerificationReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .panel-heading {
            background-color: #f9f9f9 !important;
        }

        .panel-title {
            line-height: 44px !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="content-container">
        <!--Page Title-->
        <!--------------------------------------------------------->
        <div class="pageheader hidden-xs">
            <h3><i class="fa fa-home"></i>डॉक्यूमेंट वेरिफिकेशन रिपोर्ट </h3>
            <div class="breadcrumb-wrapper">
                <%-- <span class="label">You are here:</span>--%>
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">होम </a></li>
                    <li class="active">डॉक्यूमेंट वेरिफिकेशन रिपोर्ट</li>
                </ol>
            </div>
        </div>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <!--End page title-->

        <div id="page-content">
            <form id="frmRegistration" action="#" class="form-horizontal">

                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel">
                            <div class="panel-heading">
                                <h3 class="panel-title"><strong>डी० बी० टी० हेतु अनुदान वितरण गेटवे </strong></h3>
                            </div>
                            <!--No Label Form-->
                            <div class="panel-body" style="margin-top: -15px">
                                <h3 style="float: left"><%=UserName%></h3>
                                <h3 style="float: right">वित्तीय वर्ष  : <%=FinancialYear%></h3>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel">
                            <div class="panel-heading">
                                <h3 class="panel-title">चयन करें  </h3>
                            </div>
                            <!--No Label Form-->
                            <div class="panel-body">
                                <!-- Inline Form  -->
                                <!--===================================================-->
                                <div class="row mar-top">
                                    <div class="col-lg-4">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="col-lg-3 control-label">योजना का चयन </label>
                                                <div class="col-lg-8">
                                                    <select class="form-control selectpicker" data-live-search="true">
                                                        <option selected="selected" value="-1">चयन करें </option>
                                                        <option value="1">अतिरिक्त जलक्षेत्र आच्छदित कर मत्स्य उत्पादन में वृद्धि</option>
                                                        <option value="2">फिश सीड रियरिंग यूनिट की स्थापना</option>
                                                        <option value="3">रिसर्कुलेटरी कल्चर सिस्टम में पंगेशियस पालन</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>
                                    <div class="col-lg-3">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="col-lg-3 control-label">Type</label>
                                                <div class="col-lg-8">
                                                    <select class="form-control selectpicker" data-live-search="true">
                                                        <option selected="selected" value="0">चयन करें </option>
                                                        <option value="1">निर्माण कार्य/सुधार कार्य</option>
                                                        <option value="2">इनपुट</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>
                                    <div class="col-lg-3">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="col-lg-3 control-label">Installment</label>
                                                <div class="col-lg-8">
                                                    <select class="form-control selectpicker" data-live-search="true">
                                                        <option selected="selected" value="0">चयन करें </option>
                                                        <option value="1">पहली किस्त</option>
                                                        <option value="2">दूसरी  किस्त</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>

                                    <div class="col-lg-2">
                                        <fieldset>
                                            <button class="btn btn-warning" type="button">खोजें</button>
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

                            <!--No Label Form-->
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="table-responsive">
                                            <table class="table table-bordered">
                                                <colgroup>
                                                    <col width="5%" />
                                                    <col width="10%" />
                                                    <col width="10%" />
                                                    <col width="10%" />
                                                    <col width="10%" />
                                                    <col width="10%" />
                                                    <col width="10%" />
                                                    <col width="10%" />
                                                    <col width="10%" />
                                                    <col width="10%" />
                                                </colgroup>
                                                <thead>
                                                    <tr>
                                                        <th style="text-align: center">क्रम स०</th>
                                                        <th>जनपद का नाम</th>
                                                        <th>ट्रांजैक्सन न०</th>
                                                        <th>कृषक पंजीकरण स०</th>
                                                        <th>लाभार्थी का नाम</th>
                                                        <th>योजना का नाम</th>
                                                        <th>कार्य कराने के पूर्व के फोटोग्राफ</th>
                                                        <th>60% कार्य के सहित फोटोग्राफ</th>
                                                        <th>60% कार्य पूर्ति का प्रमाणपत्र</th>
                                                        <th class="text-right">अनुदान (रु०)</th>

                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td style="text-align: center">1</td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td class="text-right">00.00</td>

                                                    </tr>
                                                </tbody>
                                                <tfoot>
                                                    <tr>
                                                        <td colspan="9" class="text-right"><strong>कुल</strong></td>
                                                        <td class="text-right"><strong>00.00</strong></td>

                                                    </tr>

                                                </tfoot>
                                            </table>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</asp:Content>
