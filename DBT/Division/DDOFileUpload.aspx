<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DivisionMaster.master" UnobtrusiveValidationMode="None" AutoEventWireup="true" CodeFile="DDOFileUpload.aspx.cs" Inherits="Division_DDOFileUpload" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .panel-heading {
            background-color: #f9f9f9 !important;
        }

        .panel-title {
            line-height: 44px !important;
        }
        .clsValidate {
            margin-top:8px;
            color:#ff0000;
            position:absolute;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div id="content-container">
        <!--Page Title-->
        <!--------------------------------------------------------->
        <div class="pageheader hidden-xs">
            <h3><i class="fa fa-home"></i>डी० डी० ओ पोटल र्फाइल अपलोड </h3>
            <div class="breadcrumb-wrapper">
                <%--  <span class="label">You are here:</span>--%>
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">होम </a></li>
                    <li class="active">डी० डी० ओ पोटल र्फाइल अपलोड </li>
                </ol>
            </div>
        </div>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <!--End page title-->
        <div id="page-content">
            <div id="frmFileUpload"  class="form-horizontal">

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
                                <h3 class="panel-title">डी० डी० ओ पोटल र्फाइल अपलोड  </h3>
                            </div>
                            <!--No Label Form-->
                            <div class="panel-body">
                                <!-- Inline Form  -->
                                <!--===================================================-->
                                <div class="row mar-top">
                                    <div class="col-lg-6">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="col-lg-3 control-label">र्फाइल का चयन</label>
                                                <div class="col-lg-9">
                                                    <asp:FileUpload ID="fuGeneratedFile" runat="server" CssClass="form-control" />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Select text file." ValidationGroup="GENTEXT"
                                                        ControlToValidate="fuGeneratedFile" SetFocusOnError="true"  CssClass="clsValidate" ></asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator7"
                                                        runat="server" ControlToValidate="fuGeneratedFile"
                                                        ErrorMessage="Only .txt formats are allowed." 
                                                        ValidationExpression="([a-zA-Z0-9\s_\\.\-:])+(.txt)$"
                                                        ValidationGroup="GENTEXT" SetFocusOnError="true"  CssClass="clsValidate" ></asp:RegularExpressionValidator>
                                                </div>
                                               
                                            </div>
                                        </fieldset>
                                    </div>

                                    <div class="col-lg-2">
                                        <fieldset>
                                            <asp:Button ID="btnUploadFile" runat="server" Text="सुरक्षित करें" CssClass="btn btn-warning" 
                                                OnClick="btnUploadFile_Click" ValidationGroup="GENTEXT" />
                                        </fieldset>
                                    </div>
                                     
                                    <div class="col-lg-2">
                                        <fieldset>
                                            <asp:Label ID="lblMessage" runat="server" ForeColor="Green"></asp:Label>
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
</asp:Content>

