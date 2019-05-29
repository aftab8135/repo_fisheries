<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DivisionMaster.master" AutoEventWireup="true" CodeFile="DBTGenerateFile.aspx.cs" Inherits="DBT_DBTGenerateFile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="<%=ResolveUrl("~/js/jquery-2.1.1.min.js") %>"></script>
    <style>
        .panel-heading {
            background-color: #f9f9f9 !important;
        }

        .panel-title {
            line-height: 44px !important;
        }

        .nav-tabs > li.active > a, .nav-tabs > li.active > a:focus, .nav-tabs > li.active > a:hover {
            background-color: #c5c5c5 !important;
        }

        .panel-body-DBT {
            padding: 0px !important;
            border-radius: 0px !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="content-container">
        <!--Page Title-->
        <!--------------------------------------------------------->
        <div class="pageheader hidden-xs">
            <h3><i class="fa fa-home"></i>DBT File Generate </h3>
            <div class="breadcrumb-wrapper">
                <%--  <span class="label">You are here:</span>--%>
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">होम </a></li>
                    <li class="active">DBT File Generate </li>
                </ol>
            </div>
        </div>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <!--End page title-->
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
                                <h3 class="panel-title">ट्रेज़री बिल का विवरण </h3>
                            </div>
                            <!--No Label Form-->
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <table class="table table-bordered table-responsive" id="tblDBTStatus">
                                            <colgroup>
                                                <col width="15%" />
                                                <col width="35%" />
                                                <col width="15%" />
                                                <col width="35%" />
                                            </colgroup>

                                            <tbody>
                                                <tr>
                                                    <td><strong>योजना कोड</strong> </td>
                                                    <td>
                                                        <label id="lblSchemeCode" runat="server"></label>
                                                    </td>
                                                    <td><strong>योजना का नाम</strong></td>
                                                    <td>
                                                        <label id="lblSchemeName" runat="server"></label>
                                                    </td>

                                                </tr>
                                                <tr>
                                                    <td><strong>ट्रेज़री बिल संख्या</strong> </td>
                                                    <td>
                                                        <label id="lblTreasuryBillNo" runat="server"></label>
                                                    </td>
                                                    <td><strong>ट्रेज़री बिल दिनांक</strong></td>
                                                    <td>
                                                        <label id="lblTreasuryBillDate" runat="server"></label>
                                                    </td>

                                                </tr>
                                                <tr>
                                                    <td><strong>धनराशि (रु०) </strong></td>
                                                    <td>
                                                        <label id="lblBillAmout" runat="server"></label>
                                                    </td>
                                                    <td><strong>कुल लाभार्थी</strong></td>
                                                    <td>
                                                        <label id="lblTotalApplicant" runat="server"></label>
                                                    </td>

                                                </tr>
                                            </tbody>
                                        </table>
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
                                <h3 class="panel-title">
                                    <input type="radio" name="rbBoth" id="rbBoth" title="Both" value="Both" />&nbsp;Both (<strong>सचेत रहें :</strong> बिना आवश्यक दस्तावेजों को रिकॉर्ड में रखें हुए व जांचें हुए कोई भी बिल न आगे बढ़ाएं और न ही भुगतान करें)</h3>
                            </div>
                            <!--No Label Form-->
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div id="frmDBT">
                                        <!--Default Tabs (Left Aligned)-->
                                        <!--===================================================-->
                                        <div class="tab-base">
                                            <!--Nav Tabs-->
                                            <ul class="nav nav-tabs" id="scheme" role="tablist">
                                                <li class="nav-item active">
                                                    <a class="nav-link active" id="add-tab" data-toggle="tab" href="#tab-add-scheme" 
                                                        role="tab" aria-controls="home" aria-selected="true"><strong>Generate Beneficiary File</strong></a>
                                                </li>
                                                <li class="nav-item">
                                                    <a class="nav-link" id="profile-tab" data-toggle="tab" href="#tab-list-scheme" 
                                                        role="tab" aria-controls="profile" aria-selected="false"><strong>Print Treasury Bill</strong></a>
                                                </li>
                                                   <li class="nav-item">
                                                    <a class="nav-link" id="GenerateNew-TransactionFile" data-toggle="tab" href="#tab-list-scheme" 
                                                        role="tab" aria-controls="profile" aria-selected="false"><strong>Generate New Transaction File</strong></a>
                                                </li>
                                            </ul>
                                            <!--Tabs Content-->
                                            <div class="tab-content">
                                                <div id="tab-add-scheme" class="tab-pane fade active in">
                                                    <div id="page-content1">
                                                        <div class="row">

                                                            <div class="panel">
                                                                <div class="panel-body panel-body-DBT">
                                                                    <asp:Repeater ID="rptDBTGenerateFile" runat="server">
                                                                        <HeaderTemplate>
                                                                            <table class="table table-bordered table-responsive" id="tblGenerateTreasuryBill">
                                                                                <colgroup>
                                                                                    <col width="6%" />
                                                                                    <col width="10%" />
                                                                                    <col width="10%" />
                                                                                    <col width="12%" />
                                                                                    <col width="11%" />
                                                                                    <col width="10%" />
                                                                                    <col width="10%" />
                                                                                    <col width="10%" />
                                                                                    <col width="10%" />
                                                                                    <col width="11%" />
                                                                                </colgroup>
                                                                                <thead>
                                                                                    <tr>
                                                                                        <th style="text-align: center">क्रम स०</th>
                                                                                        <th>जनपद</th>
                                                                                        <th>ट्रांजेक्संन स०</th>
                                                                                        <th>लाभार्थी का नाम</th>
                                                                                        <th>बैंक का नाम</th>
                                                                                        <th>IFSC कोड</th>
                                                                                        <th>शाखा का नाम</th>
                                                                                        <th>खाता संख्या</th>
                                                                                        <th>मोबाइल न०</th>
                                                                                        <th>कृषक पंजीकरण स०</th>
                                                                                    </tr>
                                                                                </thead>
                                                                                <tbody>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <tr>
                                                                                <td style="text-align: center"> <%# Container.ItemIndex+1 %></td>
                                                                                 <td> <asp:Label ID="lblDistrictName" runat="server" Text='<%# Eval("DistrictName") %>' /></td>
                                                                                 <td> <asp:Label ID="lblTransactionNo" runat="server" Text='<%# Eval("TransactionNo") %>' /></td>
                                                                                 <td> <asp:Label ID="lblApplicantName" runat="server" Text='<%# Eval("ApplicantName") %>' /></td>
                                                                                 <td> <asp:Label ID="lblBankName" runat="server" Text='<%# Eval("BankName") %>' /></td>
                                                                                 <td> <asp:Label ID="lblIFSCCode" runat="server" Text='<%# Eval("IFSCCode") %>' /></td>
                                                                                 <td> <asp:Label ID="lblBranchName" runat="server" Text='<%# Eval("BranchName") %>' /></td>
                                                                                 <td> <asp:Label ID="lblAccountNo" runat="server" Text='<%# Eval("AccountNo") %>' /></td>
                                                                                 <td> <asp:Label ID="lblMobileNo" runat="server" Text='<%# Eval("MobileNo") %>' /></td>
                                                                                 <td> <asp:Label ID="lblRegistrationNo" runat="server" Text='<%# Eval("RegistrationNo") %>' /></td>
                                                                            </tr>
                                                                        </ItemTemplate>
                                                                        <FooterTemplate>
                                                                            </tbody>
                                                                            <tfoot>
                                                                            </tfoot>
                                                                            </table>
                                                                        </FooterTemplate>
                                                                    </asp:Repeater>


                                                                </div>
                                                                <div class="panel-footer">
                                                                    <div class="row">
                                                                        <div class="col-sm-6">
                                                                          <%--  <button id="btnGenerateFile" class="btn btn-success" type="submit">Generate New File</button>--%>
                                                                            <asp:Button ID="btnGenerateFile" runat="server" CssClass="btn btn-success" Text="Generate New File" OnClick="btnGenerateFile_Click" />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="tab-list-scheme" class="tab-pane fade">
                                                    <div id="page-content2">
                                                        <div class="row">
                                                            <!-- Row selection (single row) -->
                                                            <!--===================================================-->
                                                            <div class="panel">
                                                                <div class="panel-body panel-body-DBT">
                                                                    <asp:Repeater ID="rptPrintBill" runat="server">
                                                                        <HeaderTemplate>
                                                                            <table class="table table-bordered table-responsive" id="tblPrintTreasuryBill">
                                                                                <colgroup>
                                                                                    <col width="6%" />
                                                                                    <col width="10%" />
                                                                                    <col width="10%" />
                                                                                    <col width="12%" />
                                                                                    <col width="11%" />
                                                                                    <col width="10%" />
                                                                                    <col width="10%" />
                                                                                    <col width="10%" />
                                                                                    <col width="10%" />
                                                                                    <col width="11%" />
                                                                                </colgroup>
                                                                                <thead>
                                                                                    <tr>
                                                                                        <th style="text-align: center">क्रम स०</th>
                                                                                        <th>जनपद</th>
                                                                                        <th>ट्रांजेक्संन स०</th>
                                                                                        <th>लाभार्थी का नाम</th>
                                                                                        <th>बैंक का नाम</th>
                                                                                        <th>IFSC कोड</th>
                                                                                        <th>शाखा का नाम</th>
                                                                                        <th>खाता संख्या</th>
                                                                                        <th>मोबाइल न०</th>
                                                                                        <th>कृषक पंजीकरण स०</th>
                                                                                    </tr>
                                                                                </thead>
                                                                                <tbody>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <tr>
                                                                                <td style="text-align: center"> <%# Container.ItemIndex+1 %></td>
                                                                                 <td> <%#DataBinder.Eval(Container.DataItem, "DistrictName")%></td>
                                                                                 <td> <%#DataBinder.Eval(Container.DataItem, "TransactionNo")%></td>
                                                                                 <td> <%#DataBinder.Eval(Container.DataItem, "ApplicantName")%></td>
                                                                                 <td> <%#DataBinder.Eval(Container.DataItem, "BankName")%></td>
                                                                                 <td> <%#DataBinder.Eval(Container.DataItem, "IFSCCode")%></td>
                                                                                 <td> <%#DataBinder.Eval(Container.DataItem, "BranchName")%></td>
                                                                                 <td> <%#DataBinder.Eval(Container.DataItem, "AccountNo")%></td>
                                                                                 <td> <%#DataBinder.Eval(Container.DataItem, "MobileNo")%></td>
                                                                                 <td> <%#DataBinder.Eval(Container.DataItem, "RegistrationNo")%></td>
                                                                            </tr>
                                                                        </ItemTemplate>
                                                                        <FooterTemplate>
                                                                            </tbody>
                                                                            <tfoot>
                                                                            </tfoot>
                                                                            </table>
                                                                        </FooterTemplate>
                                                                    </asp:Repeater>
                                                                </div>
                                                            </div>
                                                            <!--===================================================-->
                                                            <!-- End  -->
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>

                                        </div>

                                    </div>
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

