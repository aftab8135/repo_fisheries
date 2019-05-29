<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DistrictMaster.master" AutoEventWireup="true" CodeFile="GetAwasYogna.aspx.cs" Inherits="District_GetAwasYogna" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(function () {
            $('#sample_1').on('click', 'a[name=lnkEdit]', function (e) {
                var id = $(this).attr('data-key');
                $.ajax({
                    type: "POST",
                    url: "ActivityMaster.aspx/getDetail",
                    data: '{ "key":"' + id + '"}',
                    contentType: "application/json",
                    dataType: "json",
                    success: function (response) {
                        $("#txtActivity").val(response.d['ActivityName']);
                        $("#hidActivityKey").val(id);
                        $("html, body").animate({ scrollTop: 0 }, 900);
                    },
                    error: function (err) {
                        jsalert('Error', err.statusText, 'btn-red');
                    }
                });
            });
        });
    </script>
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
        <div class="form-horizontal" id="registrationForm">
            <div class="row">
                <div class="col-lg-12">
                    <!--Default Tabs (Left Aligned)-->
                    <!--===================================================-->
                    <div class="tab-base">
                        <!--Nav Tabs-->
                        <ul class="nav nav-tabs" id="myTab" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" id="home-tab" data-toggle="tab" href="#demo-lft-tab-1" role="tab" aria-controls="home" aria-selected="true">Add Alotee</a>

                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="profile-tab" data-toggle="tab" href="#demo-lft-tab-2" role="tab" aria-controls="profile" aria-selected="false">List Alotee</a>

                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="messages-tab" data-toggle="tab" href="#demo-lft-tab-3" role="tab" aria-controls="messages" aria-selected="false">Update First Installment</a>

                            </li>
                            <li class="nav-item">

                                <a class="nav-link" id="Installment-tab" data-toggle="tab" href="#demo-lft-tab-4" role="tab" aria-controls="Installment" aria-selected="false">Update Second Installment</a>


                            </li>
                        </ul>
                        <!--Tabs Content-->
                        <div class="tab-content">
                            <div id="demo-lft-tab-1" class="tab-pane fade active in">
                                <div id="page-content1">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="panel">
                                                <div class="panel-heading">
                                                    <h3 class="panel-title">
                                                        <span class="col-md-10">Add New Alotee</span>

                                                    </h3>
                                                </div>
                                                <!--No Label Form-->
                                                <!--===================================================-->

                                                <div class="panel-body mar-top">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">Mondal Name </label>
                                                        <div class="col-md-8">
                                                            <!-- Default choosen -->
                                                            <!--===================================================-->

                                                            <asp:Label ID="ddlMandel" runat="server" Visible="false">

                                                            </asp:Label>

                                                            <asp:Label ID="MandalName" runat="server" class="control-label col-md-3"></asp:Label>



                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">District Name </label>
                                                        <div class="col-md-8">

                                                            <asp:Label ID="ddlDistrict" runat="server" Visible="false"></asp:Label>
                                                            <asp:Label ID="DistName" runat="server" class="control-label col-md-3"></asp:Label>


                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">Vikas Khand Name </label>
                                                        <div class="col-md-8">
                                                            <asp:DropDownList ID="ddlBlock" required runat="server" CssClass="form-control selectpicker" data-live-search="true">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">Village Name </label>
                                                        <div class="col-md-8">

                                                            <asp:TextBox runat="server" required ID="txtVillagename" class="form-control" placeholder="Village Name here.."></asp:TextBox>


                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">Applicant Name </label>
                                                        <div class="col-md-8">
                                                            <!-- Default choosen -->
                                                            <asp:TextBox runat="server" ID="txtapplicant" required class="form-control" placeholder="Applicant Name here.."></asp:TextBox>

                                                            <!--===================================================-->
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">Gender </label>
                                                        <div class="col-md-7">


                                                            <asp:RadioButton ID="rad1" Text="Male" GroupName="gen1" runat="server" />
                                                            <asp:RadioButton ID="rad2" Text="Female" GroupName="gen1" runat="server" />
                                                            <asp:RadioButton ID="rad3" Text="Transgender" runat="server" GroupName="gen1" />

                                                        </div>
                                                    </div>


                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">Applicant Date Of Birth </label>
                                                        <div class="col-md-8">
                                                            <!-- Default choosen -->
                                                            <asp:TextBox runat="server" ID="txtDOB" CssClass="demo-dp-component" data-date-format="dd/MMM/yyyy" data-date-viewmode="years">  </asp:TextBox>
                                                        </div>
                                                    </div>



                                                    <div class="form-group">


                                                        <label class="control-label col-md-3">Applicant Address </label>
                                                        <div class="col-md-8">

                                                            <asp:TextBox runat="server" ID="txtaddress" TextMode="MultiLine" Rows="3" class="form-control" placeholder="Applicant Address">
                                                         
                                                            </asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">Aadhar No </label>
                                                        <div class="col-md-8">
                                                            <!-- Default choosen -->
                                                            <asp:TextBox runat="server" ID="txtAadhar" class="form-control" placeholder="Aadhar No here.."></asp:TextBox>

                                                            <!--===================================================-->
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">Mobile No </label>
                                                        <div class="col-md-8">
                                                            <!-- Default choosen -->
                                                            <asp:TextBox runat="server" ID="txtmobile" class="form-control" placeholder="Mobile here.."></asp:TextBox>

                                                            <!--===================================================-->
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">Scheme Name </label>
                                                        <div class="col-md-8">
                                                            <!-- Default choosen -->
                                                            <asp:DropDownList ID="ddlScheme" runat="server" required class="form-control selectpicker" data-live-search="true">
                                                            </asp:DropDownList>
                                                            <!--===================================================-->
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">Fund Alloted </label>
                                                        <div class="col-md-8">
                                                            <!-- Default choosen -->
                                                            <asp:TextBox runat="server" ID="txtfundallotment" class="form-control" placeholder="Total fund here.."></asp:TextBox>

                                                            <!--===================================================-->
                                                        </div>
                                                    </div>
                                                    <div class="panel-footer">
                                                        <div class="form-group">
                                                            <div class="col-xs-9 col-xs-offset-3">
                                                                <asp:Button ID="Button1" class="btn btn-info btn-lg" runat="server" Text="Submit" OnClick="Button1_Click" />
                                                                <button onclick="login()" class="btn btn-warning btn-lg">Cancel</button>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!--===================================================-->
                                                    <!--End No Label Form-->
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <div id="demo-lft-tab-2" class="tab-pane fade">
                                <div id="page-content2">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="panel">

                                                <div class="panel-body">
                                                    <!-- Inline Form  -->
                                                    <!--===================================================-->

                                                    <div class="col-md-2">
                                                        <div class="form-group">
                                                            <label class="control-label">From Date</label>
                                                            <asp:TextBox ID="demomskfromdate" placeholder="dd/mm/yyyy" data-mask="99/99/9999" class="form-control" runat="server"></asp:TextBox>

                                                        </div>
                                                    </div>
                                                    <div class="col-md-2">
                                                        <div class="form-group">
                                                            <label class="control-label">To Date</label>
                                                            <asp:TextBox ID="demomsktodate" placeholder="dd/mm/yyyy" data-mask="99/99/9999" class="form-control" runat="server"></asp:TextBox>

                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group">
                                                            <label class="control-label">Grievance Status</label>
                                                            <select class="form-control selectpicker col-lg-10" data-live-search="true">
                                                                <option>All Status</option>
                                                                <option>Approved</option>
                                                                <option>Disapproved</option>
                                                                <option>Forwarded</option>
                                                                <option>Open</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group">
                                                            <label class="control-label">Grievance No</label>
                                                            <input type="text" class="form-control" placeholder="Grievance No" />
                                                        </div>
                                                    </div>
                                                    <div class="col-md-2">
                                                        <div class="form-group mar-top-30">
                                                            <button class="btn btn-info" type="submit">Search</button>
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

                                                    <asp:Repeater ID="rptlog" OnItemCommand="rptlog_ItemCommand" runat="server">
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
                                    <!--===================================================-->
                                    <!--End page content-->
                                </div>
                            </div>
                            <div id="demo-lft-tab-3" class="tab-pane fade btn-active-default">
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
                                                            <asp:ListItem Text="January" Value="1"></asp:ListItem>
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
                                                        <asp:Button ID="Button2" class="btn btn-info" OnClientClick="search();" OnClick="Button2_Click" runat="server" Text="Search" />

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

                                                <asp:Repeater ID="Repeater1" OnItemCommand="Repeater1_ItemCommand" runat="server">
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
                                                                    <th>First Installment</th>
                                                                    <th>Remark</th>
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
                                                                <asp:TextBox ID="txtfirstinstallment" runat="server"></asp:TextBox>
                                                            </td>

                                                            <td class="text-center">
                                                                <asp:TextBox ID="txtremark" runat="server"></asp:TextBox>
                                                            </td>

                                                            <td class="text-center">
                                                                <asp:Button Text="Edit" runat="server" CommandArgument='<%# Eval("AlottmentKey") %>' CommandName="Update" UseSubmitBehavior="false" />


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


                            <div id="demo-lft-tab-4" class="tab-pane fade btn-active-default">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="panel">

                                            <div class="panel-body">
                                                <!-- Inline Form  -->
                                                <!--===================================================-->

                                                <div class="col-md-2">
                                                    <div class="form-group">
                                                        <label class="control-label">For Month</label>
                                                        <asp:DropDownList ID="ddlformonthsec" runat="server" CssClass="form-control selectpicker" data-live-search="true">
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
                                                        <asp:DropDownList ID="ddlforyearsec" runat="server" CssClass="form-control selectpicker" data-live-search="true">
                                                            <asp:ListItem Text="2017"></asp:ListItem>
                                                            <asp:ListItem Text="2018"></asp:ListItem>
                                                            <asp:ListItem Text="2019"></asp:ListItem>
                                                            <asp:ListItem Text="2020"></asp:ListItem>

                                                        </asp:DropDownList>
                                                    </div>
                                                </div>


                                                <div class="col-md-2">
                                                    <div class="form-group mar-top-30">
                                                        <asp:Button ID="Button3" class="btn btn-info" OnClientClick="search();" OnClick="Button3_Click" runat="server" Text="Search" />

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

                                                <asp:Repeater ID="Repeater2" OnItemCommand="Repeater2_ItemCommand" runat="server">
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
                                                                    <th data-hide="phone, tablet">First Installment(Lakh)</th>
                                                                    <th>Second Installment</th>
                                                                    <th>Remark</th>
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
                                                                <%# DataBinder.Eval(Container.DataItem,"FirstInstallment") %>
                                                            </td>
                                                            <td class="text-center">
                                                                <asp:TextBox ID="txtsecondinstallment" runat="server"></asp:TextBox>
                                                            </td>

                                                            <td class="text-center">
                                                                <asp:TextBox ID="txtremark2" runat="server"></asp:TextBox>
                                                            </td>

                                                            <td class="text-center">
                                                                <asp:Button Text="Edit" runat="server" CommandArgument='<%# Eval("AlottmentKey") %>' CommandName="Update" UseSubmitBehavior="false" />


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
                    </div>
                </div>
            </div>

        </div>
    </div>

    <script src="../js/jquery-2.1.1.min.js"></script>
    <script type="text/javascript">
        $(function search() {
            $('#myTab a[href="#messages"]').tab('show')
        })
    </script>
    <script src="../js/demo/form-validation.js"></script>



</asp:Content>

