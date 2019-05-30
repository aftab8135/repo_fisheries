<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DivisionMaster.master" AutoEventWireup="true" CodeFile="BillForwarding.aspx.cs" Inherits="Division_BillForwarding" %>


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
            <h3><i class="fa fa-home"></i>आगे भेजे गयी रिपोर्ट </h3>
            <div class="breadcrumb-wrapper">
                <%--  <span class="label">You are here:</span>--%>
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">होम </a></li>
                    <li class="active">आगे भेजे गयी रिपोर्ट </li>
                </ol>
            </div>
        </div>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <!--End page title-->
        <div id="page-content">
            <div id="frmRegistration"  class="form-horizontal">

                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel">
                            <div class="panel-heading">
                                <h3 class="panel-title"><strong>डी० बी० टी० हेतु अनुदान वितरण गेटवे </strong></h3>
                            </div>
                            <!--No Label Form-->
                            <div class="panel-body" style="margin-top: -15px">
                              <h3 style="float: left">मण्डल : <asp:Label ID="lblLoginType" runat="server" Text="कानपुर"></asp:Label></h3>
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
                                <h3 class="panel-title">आगे भेजे गयी रिपोर्ट</h3>
                            </div>
                            <!--No Label Form-->
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="table-responsive">
                                            <table class="table table-bordered">
                                                <colgroup>
                                                    <col width="5%" />
                                                    <col width="7%" />
                                                    <col width="7%" />
                                                    <col width="7%" />
                                                    <col width="8%" />
                                                    <col width="8%" />
                                                    <col width="9%" />
                                                    <col width="5%" />
                                                    <col width="8%" />
                                                    <col width="8%" />
                                                    <col width="7%" />
                                                    <col width="7%" />
                                                    <col width="8%" />
                                                    <col width="6%" />

                                                </colgroup>
                                                <thead>
                                                    <tr>
                                                        <th style="text-align: center">क्रम स०</th>
                                                        <th>जनपद</th>
                                                        <th>Recipient</th>
                                                        <th>बिल संख्या</th>
                                                        <th>ट्रांजैक्सन न०</th>
                                                        <th>पंजीकरण स०</th>
                                                        <th>लाभार्थी का नाम</th>
                                                        <th>मात्रा</th>
                                                        <th>वस्तु का नाम</th>
                                                        <th class="text-right">अनुदान (रु०)</th>
                                                        <th>कृषक अंश</th>
                                                        <th>रसीद संख्या</th>
                                                        <th>रसीद दिनाँक</th>
                                                        <th>लंबित दिन</th>

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
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                    </tr>

                                                </tbody>
                                                <%--  <tfoot>
                                                     <tr>
                                                         <td colspan="6" class="text-right"><strong>कुल</strong></td>
                                                         <td class="text-right"><strong>00.00</strong></td>
                                                         <td></td>
                                                     </tr>

                                                </tfoot>--%>
                                            </table>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <%--  <div class="panel-footer">
                                <button class="btn btn-info" type="submit">सुरक्षित करें</button>
                                &nbsp;&nbsp;&nbsp;
                                 <button class="btn btn-warning" type="button">निरस्त करें</button>
                            </div>--%>
                        </div>


                    </div>
                </div>


            </div>
        </div>

    </div>
</asp:Content>