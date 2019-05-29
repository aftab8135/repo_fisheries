<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ApplicantMaster.Master" EnableEventValidation="false" AutoEventWireup="true" CodeFile="ApplicantScheme.aspx.cs" Inherits="Applicant_ApplicantScheme" %>

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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="content-container">

        <div class="pageheader hidden-xs">
            <h3><i class="fa fa-home"></i>Scheme List </h3>
            <div class="breadcrumb-wrapper">
                <span class="label">You are here:</span>
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">Applicant </a></li>
                    <li class="active">Scheme </li>
                </ol>
            </div>
        </div>
        <div id="page-content">
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel">
                        <div class="panel-heading">
                            <h3 class="panel-title"><strong>Online Scheme Details</strong></h3>
                        </div>
                        <div class="panel-body">
                            <asp:Repeater ID="rptScheme" OnItemCommand="rptScheme_ItemCommand" runat="server">
                                <HeaderTemplate>

                                    <table id="sample_1" class="table table-bordered table-hover">
                                        <colgroup>
                                            <col width="5%" />
                                            <col width="40%" />
                                            <col width="35%" />
                                            <col width="10%" />
                                            <col width="10%" />
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th class="text-center">S.No.</th>
                                                <th>Scheme Name</th>
                                                <th>Description</th>
                                                <th>Guidelines</th>
                                                <th class="text-center">Action</th>
                                            </tr>
                                        </thead>

                                        <tbody>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td class="text-center">
                                            <%# Container.ItemIndex+1 %>
                                        </td>
                                        <td>
                                            <%# DataBinder.Eval(Container.DataItem,"SchemeName") %>
                                        </td>
                                        <td>
                                            <%# DataBinder.Eval(Container.DataItem,"Description") %>
                                        </td>
                                        <td class="text-center">
                                            <%# DataBinder.Eval(Container.DataItem,"GuidelinesUrl").ToString()==""?"Not Available":"<a href='../" + DBLayer.SchemeGuidlineDirectory + "/" + DataBinder.Eval(Container.DataItem,"GuidelinesUrl")+"' target='_blank' class='btn btn-xs btn-primary'>View Guidelines</a>" %>
                                        </td>
                                        <td class="text-center">
                                            <asp:Button Text="Apply Online" runat="server" CommandArgument='<%# Eval("SchemeKey") %>' CssClass="btn btn-xs btn-info"
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

        </div>
    </div>
</asp:Content>
