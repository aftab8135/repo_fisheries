<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DistrictMaster.master" AutoEventWireup="true" CodeFile="DistrictWiseAwasReport.aspx.cs" Inherits="District_DistrictWiseAwasReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="content-container">

        <div class="pageheader hidden-xs">
            <h3><i class="fa fa-home"></i>Machua Awas Yojana </h3>
            <div class="breadcrumb-wrapper">
                <span class="label">You are here:</span>
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">Home </a></li>
                    <li class="active">Machua Awas Yojana </li>
                </ol>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="panel">

                    <div class="panel-body">
                        <!-- Inline Form  -->
                        <!--===================================================-->

                        <div class="col-md-2">
                            <div class="form-group">
                                <label class="control-label">For Month</label>
                                <asp:DropDownList ID="ddlformonth" runat="server" CssClass="form-control selectpicker" data-live-search="true">
                                    <asp:ListItem Text="Junuary" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="February" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="March" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="April" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="May" Value="5"></asp:ListItem>
                                    <asp:ListItem Text="June" Value="6"></asp:ListItem>
                                    <asp:ListItem Text="July" Value="7"></asp:ListItem>
                                    <asp:ListItem Text="August" Value="8"></asp:ListItem>
                                    <asp:ListItem Text="September" Value="9"></asp:ListItem>
                                    <asp:ListItem Text="October" Value="10"></asp:ListItem>
                                    <asp:ListItem Text="November" Value="11"></asp:ListItem>
                                    <asp:ListItem Text="December" Value="13"></asp:ListItem>
                                </asp:DropDownList>

                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label class="control-label">For Year</label>
                                <asp:DropDownList ID="ddlforyear" runat="server" CssClass="form-control selectpicker" data-live-search="true">
                                    <asp:ListItem Text="2017"></asp:ListItem>
                                    <asp:ListItem Text="2018"></asp:ListItem>
                                    <asp:ListItem Text="2019"></asp:ListItem>
                                    <asp:ListItem Text="2020"></asp:ListItem>

                                </asp:DropDownList>
                            </div>
                        </div>


                        <div class="col-md-2">
                            <div class="form-group mar-top-30">
                                <asp:Button ID="Button3" class="btn btn-info" OnClick="Button3_Click" runat="server" Text="Search" />

                            </div>
                        </div>



                        <!--===================================================-->
                        <!-- End Inline Form  -->
                    </div>
                </div>
            </div>

        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="panel">
                    <div class="panel-heading">

                        <h3 class="panel-title">Search Result</h3>
                    </div>
                    <div class="panel-body">

                        <asp:Repeater ID="Repeater1" runat="server">
                            <HeaderTemplate>

                                <table id="sample_1" class="table table-bordered table-hover toggle-circle" data-page-size="7">
                                    <thead>
                                        <tr>
                                            <th class="text-center">Sr No   
                                            </th>
                                            <th data-sort-initial="true" data-toggle="true">District Name</th>
                                            <th>Allotment</th>
                                            <th>Target</th>
                                            <th data-hide="phone, tablet">Completed</th>

                                            <th data-hide="phone, tablet">Uncompleted</th>
                                            <th data-hide="phone, tablet">Unstarted</th>
                                            <th data-hide="phone, tablet">Fund allotment</th>
                                            <th>First Installment</th>
                                            <th>Second Installment</th>
                                            <th data-sort-ignore="true" class="min-width">Total Expence</th>
                                            <th data-sort-ignore="true" class="min-width">Remaining Amount</th>
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
                                        <%# DataBinder.Eval(Container.DataItem,"EnglishName") %>
                                    </td>
                                    <td class="text-center">
                                        <%# DataBinder.Eval(Container.DataItem,"Alottment") %>
                                    </td>
                                    <td class="text-center">
                                        <%# DataBinder.Eval(Container.DataItem,"target_no") %>
                                    </td>

                                    <td class="text-center">
                                        <%# DataBinder.Eval(Container.DataItem,"completed") %>
                                    </td>
                                    <td class="text-center">
                                        <%# DataBinder.Eval(Container.DataItem,"Uncompleted") %>
                                    </td>
                                    <td class="text-center">
                                        <%# DataBinder.Eval(Container.DataItem,"Unstarted") %>
                                    </td>
                                    <td class="text-center">
                                        <%# DataBinder.Eval(Container.DataItem,"fundallotbydept") %>
                                    </td>
                                    <td class="text-center">
                                        <%# DataBinder.Eval(Container.DataItem,"FirstInstallment") %>
                                    </td>
                                    <td class="text-center">
                                        <%# DataBinder.Eval(Container.DataItem,"SecondInstallment") %>
                                    </td>
                                    <td class="text-center">
                                        <%# DataBinder.Eval(Container.DataItem,"installment") %>
                                    </td>
                                    <td class="text-center">
                                        <%# DataBinder.Eval(Container.DataItem,"remailinstallment") %>
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
</asp:Content>


