<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DistrictMaster.master" AutoEventWireup="true" CodeFile="GetApplcantReport.aspx.cs" Inherits="District_GetApplcantReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <div id="content-container">
           <div class="pageheader hidden-xs">
                  <h3><i class="fa fa-home"></i> Machua Awas Yojana </h3>
                    <div class="breadcrumb-wrapper">
                      <span class="label">You are here:</span>
                         <ol class="breadcrumb">
                            <li> <a href="Dashboard.aspx"> Home </a> </li>
                            <li class="active"> Machua Awas Yojana </li>
                         </ol>
                    </div>
                </div>
    <ul class="nav nav-tabs" id="myTab" role="tablist">
  <li class="nav-item">
    <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">Homme</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">Profile</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" id="messages-tab" data-toggle="tab" href="#messages" role="tab" aria-controls="messages" aria-selected="false">Messages</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" id="settings-tab" data-toggle="tab" href="#settings" role="tab" aria-controls="settings" aria-selected="false">Settings</a>
  </li>
</ul>

<div class="tab-content">
  <div class="tab-pane active" id="home" role="tabpanel" aria-labelledby="home-tab">
      <div>
       
      Sanjay Serivastava

          <div class="row">
                <div class="col-md-12">
                    <div class="panel">
                      
                        <div class="panel-body">
                            <!-- Inline Form  -->
                            <!--===================================================-->
                           
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <label class="control-label">For Month</label>
                                      <asp:DropDownList id="DropDownList1" runat="server" CssClass="form-control selectpicker" data-live-search="true" >
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
                                       <asp:DropDownList id="DropDownList2" runat="server" CssClass="form-control selectpicker" data-live-search="true">
                                              <asp:ListItem Text="2017"></asp:ListItem>
                                              <asp:ListItem Text="2018"></asp:ListItem>
                                              <asp:ListItem Text="2019"></asp:ListItem>
                                              <asp:ListItem Text="2020"></asp:ListItem>

                                              </asp:DropDownList>
                                    </div>
                                </div>
                              
                              
                                <div class="col-md-2">
                                    <div class="form-group mar-top-30">
                                        <asp:Button ID="Button1" class="btn btn-info"  OnClick="Button3_Click" runat="server" Text="Search" />
                                      
                                    </div>
                                </div>


                           
                            <!--===================================================-->
                            <!-- End Inline Form  -->
                        </div>
                    </div>
                </div>

            </div>
          </div>
  </div>
  <div class="tab-pane" id="profile" role="tabpanel" aria-labelledby="profile-tab">...</div>
  <div class="tab-pane" id="messages" role="tabpanel" aria-labelledby="messages-tab">...</div>
  <div class="tab-pane" id="settings" role="tabpanel" aria-labelledby="settings-tab"> 
      <div class="row">
                <div class="col-md-12">
                    <div class="panel">
                      
                        <div class="panel-body">
                            <!-- Inline Form  -->
                            <!--===================================================-->
                           
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <label class="control-label">For Month</label>
                                      <asp:DropDownList id="ddlformonth" runat="server" CssClass="form-control selectpicker" data-live-search="true" >
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
                                       <asp:DropDownList id="ddlforyear" runat="server" CssClass="form-control selectpicker" data-live-search="true">
                                              <asp:ListItem Text="2017"></asp:ListItem>
                                              <asp:ListItem Text="2018"></asp:ListItem>
                                              <asp:ListItem Text="2019"></asp:ListItem>
                                              <asp:ListItem Text="2020"></asp:ListItem>

                                              </asp:DropDownList>
                                    </div>
                                </div>
                              
                              
                                <div class="col-md-2">
                                    <div class="form-group mar-top-30">
                                        <asp:Button ID="Button3" class="btn btn-info" OnClientClick="Search();"  OnClick="Button3_Click" runat="server" Text="Search" />
                                      
                                    </div>
                                </div>


                           
                            <!--===================================================-->
                            <!-- End Inline Form  -->
                        </div>
                    </div>
                </div>

            </div></div>
</div>
            
          </div>
    <script src="../js/jquery-2.1.1.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
<script>
    $(function Search (){
        $('#myTab li:last-child a').tab('show')
    })
</script>
</asp:Content>

