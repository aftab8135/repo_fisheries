<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DistrictMaster.master" AutoEventWireup="true" CodeFile="frm_DocumentUpdate.aspx.cs" Inherits="District_frm_DocumentUpdate" %>

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
            <h3><i class="fa fa-home"></i>अपडेट डॉक्यूमेंट  </h3>
            <div class="breadcrumb-wrapper">
                <%--   <span class="label">You are here:</span>--%>
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">होम </a></li>
                    <li class="active">अपडेट डॉक्यूमेंट  </li>
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
                            <h3 class="panel-title"><strong>अपडेट डॉक्यूमेंट </strong></h3>
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

            <div id="frmRegistration" class="form-horizontal">

                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel">
                            <div class="panel-heading">
                                <h3 class="panel-title"><strong>डी० बी० टी० हेतु अनुदान वितरण गेटवे </strong></h3>
                            </div>
                            <!--No Label Form-->
                            <div class="panel-body" style="margin-top: -15px">
                                <h3 style="float: left"><%=UserName %></h3>
                                <h3 style="float: right">वित्तीय वर्ष  : <%=FinYear%></h3>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel">
                            <div class="panel-heading">
                                <h3 class="panel-title">अपडेट डॉक्यूमेंट </h3>
                            </div>
                            <!--No Label Form-->
                            <div class="panel-body">
                                <!-- Inline Form  -->
                                <!--===================================================-->
                                <div class="row mar-top">
                                    <div class="col-lg-6">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="col-lg-3 control-label">पंजीकरण संख्या</label>
                                                <div class="col-lg-9">
                                                    <input type="text" class="form-control" name="farmername1" placeholder="पंजीकरण संख्या भरें..." />
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>
                                    <div class="col-lg-2">
                                        <button class="btn btn-warning" type="button">खोजें</button>
                                    </div>

                                </div>
                            </div>

                        </div>
                    </div>
                </div>



            </div>
        </div>

    </div>
</asp:Content>

