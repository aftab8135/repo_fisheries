<%@ Page Title="Print Acknowledgement Reciept" Language="C#" MasterPageFile="~/MasterPages/ApplicantMaster.Master" AutoEventWireup="true" CodeFile="AcknowledgementReciept.aspx.cs" Inherits="Applicant_AcknowledgementReciept" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../js/jquery-2.1.1.min.js" type="text/javascript"></script>
    <script type="text/javascript">
    </script>
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
    <style>
        table {
            width: 100%;
            border: solid #000 !important;
            border-width: 1px 0 0 1px !important;
        }

        th, td {
            border: solid #000 !important;
            border-width: 0 1px 1px 0 !important;
            padding-left:5px

        }
    </style>
    <div id="content-container">
        <div class="pageheader hidden-xs">
            <h3><i class="fa fa-home"></i>Acknowledgement Reciept </h3>
            <div class="breadcrumb-wrapper">
                <span class="label">You are here:</span>
                <ol class="breadcrumb">
                    <li><a href="#">Home </a></li>
                    <li class="active">Acknowledgement Reciept </li>
                </ol>
            </div>
        </div>

        <div class="form-horizontal" id="divScheme">
            <div id="page-content">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel">
                            <div class="panel-body form-horizontal" id="pnlReceipt">
                                <style type="text/css">
                                    @media print {
                                        * {
                                            -webkit-print-color-adjust: exact;
                                            color: black;
                                            background: white;
                                        }

                                        .logocenter {
                                            text-align: center;
                                        }

                                        table {
                                            width: 100%;
                                            border: solid #000 !important;
                                            border-width: 1px 0 0 1px !important;
                                        }

                                        th, td {
                                            border: solid #000 !important;
                                            border-width: 0 1px 1px 0 !important;
                                             padding-left:5px
                                        }
                                    }
                                </style>
    <div class="row">
        <div class="col-md-12">
            <div class="center logocenter">
                <img alt="" src="../img/Uttar-Pradesh-govt.png" class="img-circle" />
                <h4>Fisheries Department</h4>
                <h3>Government Of Uttar Pradesh </h3>
                <h2>Acknowledgement Reciept </h2>
            </div>
        </div>
    </div>
    <div class="col-md-6 col-md-offset-3">
        <div class="row">
            <div class="center-block">
                <table width="100%">
                    <colgroup>
                        <col width="25%" />
                        <col width="75%" />
                    </colgroup>
                    <tr>
                        <td style="padding: 10px; text-align: right;">Application No :</td>
                        <td><asp:Label runat="server" id="lblApplicationNo"></asp:Label></td>
                    </tr>
                    <tr>
                        <td style="padding: 10px; text-align: right;">Applicant Name :  </td>
                        <td><asp:Label runat="server" id="lblAppName"></asp:Label></td>
                    </tr>
                    <tr>
                        <td style="padding: 10px; text-align: right;">Father Name :  </td>
                        <td><asp:Label runat="server" id="lblFName"></asp:Label></td>
                    </tr>
                    <tr>
                        <td style="padding: 10px; text-align: right;">Mobile No. :  </td>
                        <td><asp:Label runat="server" id="lblMobileNo"></asp:Label></td>
                    </tr>
                    <tr>
                        <td style="padding: 10px; text-align: right;">Scheme Name :  </td>
                        <td><asp:Label runat="server" id="lblSchemeName"></asp:Label></td>
                    </tr>
                    <tr>
                        <td style="padding: 10px; text-align: right;">Applied Date :  </td>
                        <td><asp:Label runat="server" id="lblAppDate"></asp:Label></td>
                    </tr>

                </table>

            </div>
        </div>
    </div>
    </div>
                            <div class="row" style="margin-top: 10px; padding-bottom: 20px;">
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

