<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DistrictMaster.master" AutoEventWireup="true" CodeFile="WebReportViewer.aspx.cs"
    Inherits="Report_WebReportViewer" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="content-container">
        <div id="page-content">
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel" style="margin-top: 44px">
                        <div class="panel-body">
                            <center>
                                <CR:CrystalReportViewer ID="CRViewer" runat="server" AutoDataBind="true" Visible="true" BestFitPage="True" ToolPanelView="None" />
                           </center>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>