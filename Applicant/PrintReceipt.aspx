<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ApplicantMaster.Master" AutoEventWireup="true" CodeFile="PrintReceipt.aspx.cs" Inherits="Applicant_PrintReceipt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../js/jquery-2.1.1.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        function CallPrint(strid) {
            var prtContent = document.getElementById(strid);
            var WinPrint = window.open('', '', 'letf=0,top=0,width=1000,height=1000,toolbar=0,scrollbars=0,status=0');
            var innerHtmlText = prtContent.innerHTML;
            for (; innerHtmlText.indexOf('DISPLAY: none;') >= 0 || innerHtmlText.indexOf('DISPLAY: none') >= 0;) {
                innerHtmlText = innerHtmlText.replace('DISPLAY: none;', '').replace('DISPLAY: none', '');
            }
            WinPrint.document.write(innerHtmlText);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="content-container">
        <!--Page Title-->
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <div class="pageheader hidden-xs">
            <h3><i class="fa fa-home"></i>Grievance Receipt</h3>
            <div class="breadcrumb-wrapper">
                <span class="label">You are here:</span>
                <ol class="breadcrumb">
                    <li><a href="#">Home </a></li>
                    <li class="active">Grievance Receipt </li>
                </ol>
            </div>
        </div>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <!--End page title-->
        <div class="form-horizontal" id="complainsource">
            <div id="page-content">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel">
                            <div class="panel-heading">
                                <h3 class="panel-title">
                                    <span class="col-md-12">Grievance Receipt</span>
                                </h3>
                            </div>
                            <div class="panel-body form-horizontal" id="pnlReceipt">
                                <style type="text/css">
                                    @media print {
                                        * {
                                            -webkit-print-color-adjust: exact;
                                        }

                                        .logocenter {
                                            text-align: center;
                                        }
                                    }
                                </style>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="center logocenter">
                                            <img alt="" src="../img/Uttar-Pradesh-govt.png" class="img-circle" />
                                            <h4>Fisheries Department</h4>
                                            <h3>Government Of Uttar Pradesh </h3>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-3">
                                    </div>
                                    <div class="col-md-6">
                                        <div class="row">
                                            <div class="center-block" style="border: 1px solid #000000">
                                                <table style="width: 100%; background-color: #fff; color: #000; border: 1px solid #ccc; padding: 10px">
                                                    <tr>
                                                        <td style="padding: 10px; text-align: right;">Grievance No :
                                                            <strong>
                                                                <%=ds.Tables[0].Rows[0]["ComplainTokenNo"]%></strong> <span style="margin-left: 5px"></span>
                                                        </td>
                                                        <td>Dated:
                                                            <%=ds.Tables[0].Rows[0]["ComplainDate"]%></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="padding: 10px; text-align: right;">Applicant Name :  
                                                        </td>
                                                        <td><%=ds.Tables[0].Rows[0]["FullName"]%></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="padding: 10px; text-align: right;">Applicant Mobile No. :  
                                                        </td>
                                                        <td><%=ds.Tables[0].Rows[0]["ComplainerMobileNo"]%></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="padding: 10px; text-align: right;">Grievance Type :  
                                                        </td>
                                                        <td><%=ds.Tables[0].Rows[0]["ComplainType"]%></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="padding: 10px; text-align: right;">Grievance Sub Type : 
                                                        </td>
                                                        <td><%=ds.Tables[0].Rows[0]["ComplainSubType"]%></td>
                                                    </tr>
                                                    <% if (ds.Tables[0].Rows[0]["ApplicationMode"].ToString() == "2")
                                                       {%>
                                                    <tr>
                                                        <td style="padding: 10px; text-align: right;">Letter Ref. No : 
                                                        </td>
                                                        <td><%=ds.Tables[0].Rows[0]["LetterRefNo"]%></td>

                                                    </tr>
                                                    <tr>
                                                        <td style="padding: 10px; text-align: right;">Letter Date : 
                                                        </td>
                                                        <td><%=ds.Tables[0].Rows[0]["LetterDate"]%></td>

                                                    </tr>
                                                    <tr>
                                                        <td style="width: 5%">&nbsp;
                                                        </td>
                                                        <td style="width: 15%; padding: 4px; text-align: left">Recieving Date
                                                        </td>
                                                        <td style="width: 70%; padding: 4px; margin-top: 5px; text-align: left">
                                                            <%= ds.Tables[0].Rows[0]["ReceivingDate"]%>
                                                        </td>
                                                    </tr>
                                                    <%} %>
                                                    <tr>
                                                        <td style="padding: 10px; text-align: right;">Grievance Mode : 
                                                        </td>
                                                        <td><%= ds.Tables[0].Rows[0]["ApplicationMode"].ToString() == "1" ? "Online" : "Offline" %></td>
                                                    </tr>
                                                </table>

                                            </div>
                                        </div>

                                    </div>
                                </div>
                                <div class="col-md-3">
                                </div>
                            </div>
                            <div class="row" style="margin-top: 10px; padding-bottom:20px;">
                                <div style="text-align: center">
                                    <a class="btn btn-primary btn-labeled fa fa-print" onclick="javascript:CallPrint('pnlReceipt');">Print Receipt</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
