<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ApplicantMaster.Master" AutoEventWireup="true" CodeFile="ApplicantDashboard.aspx.cs" Inherits="Applicant_ApplicantDashboard" %>

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
        <div class="pageheader hidden-xs">
            <h3><i class="fa fa-home"></i>Applicant Dashboard </h3>
            <div class="breadcrumb-wrapper">
                <span class="label">You are here:</span>
                <ol class="breadcrumb">
                    <li><a href="ApplicantDashboard.aspx">Applicant </a></li>
                    <li class="active">Dashboard </li>
                </ol>
            </div>
        </div>
        <div id="page-content">
            <div class="row" id="schemedetails" runat="server">
                <div class="col-lg-12">
                    <div class="panel">
                        <div class="panel-heading">
                            <h3 class="panel-title"><strong>Applied Scheme Detail</strong> </h3>
                        </div>
                        <div class="panel-body">
                            <asp:Repeater ID="rptlog" OnItemDataBound="rptlog_ItemDataBound" runat="server" OnItemCommand="rptlog_ItemCommand">
                                <HeaderTemplate>
                                    <table id="sample_1" class="table table-bordered table-hover toggle-circle" data-page-size="7">
                                        <colgroup>
                                            <col style="width: 5%" />
                                            <col style="width: 10%" />
                                            <col style="width: 35%" />
                                            <col style="width: 10%" />
                                            <col style="width: 10%" />
                                            <col style="width: 20%" />
                                            <col style="width: 10%" />
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th class="text-center">Sr No.</th>
                                                <asp:HiddenField ID="applictionidno" runat="server" />
                                                <th>Application Code</th>
                                                <th class="text-left" data-hide="phone, tablet">Scheme Name</th>
                                                <th class="text-left" data-hide="phone, tablet">Applied Date</th>
                                                <th class="text-left" data-hide="phone, tablet">Status</th>
                                                <th class="text-left" data-hide="phone, tablet">Remarks</th>
                                                <th class="text-center eq-min-width" data-sort-ignore="true">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td class="text-center">
                                            <%# Container.ItemIndex+1 %>
                                        </td>
                                        <td class="text-left">
                                            <%# DataBinder.Eval(Container.DataItem,"ApplicationCode") %>
                                        </td>
                                        <td class="text-left">
                                            <%# DataBinder.Eval(Container.DataItem,"SchemeName") %>
                                        </td>
                                        <td class="text-left">
                                            <%# DataBinder.Eval(Container.DataItem,"AppliedDate") %>
                                        </td>
                                        <td class="text-left">
                                            <span class="label <%#DataBinder.Eval(Container.DataItem, "CssClass")%>"> <%#DataBinder.Eval(Container.DataItem, "CurStatus")%></span>
                                        </td>
                                        <td class="text-left">
                                            <%# DataBinder.Eval(Container.DataItem,"Remarks") %>
                                        </td>
                                        <td class="text-center"> 
                                            <asp:Button Text="View Application" runat="server" CommandArgument='<%# Eval("ApplicationNo") %>' CssClass="btn btn-xs btn-primary"
                                                CommandName="Update" UseSubmitBehavior="false" />

                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    </tbody>
                           </table>
                                </FooterTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row" id="NotificationDetails" runat="server">
                <div class="col-md-12">
                    <div class="panel">
                        <div class="panel-heading">

                            <h3 class="panel-title"><strong>Important Notification </strong></h3>
                        </div>
                        <div class="panel-body">
                            <asp:Repeater ID="Repeater3" runat="server">
                                <HeaderTemplate>

                                    <table id="sample_1" class="table table-bordered table-hover toggle-circle" data-page-size="7">
                                        <thead>
                                            <tr>
                                                <th class="text-center">Sr No   
                                                </th>
                                                <th data-sort-initial="true" data-toggle="true">Name</th>
                                                <th>Mobile</th>
                                                <th data-hide="phone, tablet">Address</th>

                                                <th data-hide="phone, tablet">DOB</th>
                                                <th data-hide="phone, tablet">Ammount Allotee(Lakh)</th>
                                                <th data-hide="phone, tablet">Status</th>
                                                <th data-sort-ignore="true" class="min-width">Action</th>
                                            </tr>
                                        </thead>

                                        <tbody>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>

                                        <td class="text-center">
                                            <%# Container.ItemIndex+1 %>
                                        </td>
                                        <td class="text-center">
                                            <%# DataBinder.Eval(Container.DataItem,"ApplicantName") %>
                                        </td>
                                        <td class="text-center">
                                            <%# DataBinder.Eval(Container.DataItem,"ApplicantMobileno") %>
                                        </td>
                                        <td class="text-center">
                                            <%# DataBinder.Eval(Container.DataItem,"ApplicantAddress") %>
                                        </td>

                                        <td class="text-center">
                                            <%# DataBinder.Eval(Container.DataItem,"DOB") %>
                                        </td>
                                        <td class="text-center">
                                            <%# DataBinder.Eval(Container.DataItem,"fundallotbydept") %>
                                        </td>
                                        <td class="text-center">
                                            <%# DataBinder.Eval(Container.DataItem,"status") %>
                                        </td>

                                        <td class="text-center">
                                            <asp:Button Text="Edit" runat="server" CommandArgument='<%# Eval("AlottmentKey") %>' CommandName="Edit" UseSubmitBehavior="false" />
                                        </td>
                                    </tr>


                                </ItemTemplate>

                                <FooterTemplate>
                                    </tbody>
                           </table>
                                </FooterTemplate>

                            </asp:Repeater>
                        </div>
                    </div>
                </div>


            </div>
        </div>
    </div>
</asp:Content>

