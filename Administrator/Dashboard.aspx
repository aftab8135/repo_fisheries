<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AdministratorMaster.master" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Administrator_Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="content-container">
        <!--Page Title-->
        <!--------------------------------------------------------->
        <div class="pageheader hidden-xs">
            <h3><i class="fa fa-home"></i>Dashboard  </h3>
            <div class="breadcrumb-wrapper">
                <%--  <span class="label">You are here:</span>--%>
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">Home </a></li>
                    <li class="active">Dashboard  </li>
                </ol>
            </div>
        </div>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <!--End page title-->
        <div id="page-content">
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel">

                        <!--No Label Form-->
                        <div class="panel-body">
                            <div style="text-align: center; height: 360px; padding-top: 60px">
                                <img src="../../img/Uttar-Pradesh-govt.png" />
                                <h1>Fisheries Department</h1>
                                <h3>Government of Uttar Pradesh</h3>
                                

                            </div>
                        </div>
                    </div>
                </div>
            </div>


        </div>

    </div>
</asp:Content>

