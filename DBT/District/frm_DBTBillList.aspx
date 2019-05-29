<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DistrictMaster.master" AutoEventWireup="true" CodeFile="frm_DBTBillList.aspx.cs" Inherits="District_frm_DBTBillList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
            <form id="frmRegistration" action="#" class="form-horizontal">

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
                                <h3 class="panel-title">योजनावार डी० बी० टी० बिल की सूची  </h3>
                            </div>
                            <!--No Label Form-->
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="table-responsive">
                                            <table class="table table-bordered">
                                                <colgroup>
                                                    <col width="5%" />
                                                    <col width="15%" />
                                                    <col width="24%" />
                                                    <col width="12%" />
                                                    <col width="10%" />
                                                    <col width="20%" />
                                                    <col width="14%" />

                                                </colgroup>
                                                <thead>
                                                    <tr>
                                                        <th style="text-align: center">क्रम स०</th>
                                                        <th>डी० बी० टी० नंबर</th>
                                                        <th>योजना का नाम</th>
                                                        <th>ट्रेज़री बिल संख्या</th>
                                                        <th>ट्रेज़री बिल दिनांक</th>
                                                        <th>कुल लाभार्थी</th>
                                                        <th class="text-right">धनराशि (रु०)</th>

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
                                                        <td class="text-right">00.00</td>

                                                    </tr>

                                                </tbody>
                                                <tfoot>
                                                    <tr>
                                                        <td colspan="6" class="text-right"><strong>कुल</strong></td>
                                                        <td class="text-right"><strong>00.00</strong></td>

                                                    </tr>
                                                </tfoot>
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


            </form>
        </div>
    </div>
</asp:Content>

