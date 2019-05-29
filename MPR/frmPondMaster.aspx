<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DistrictMaster.master" AutoEventWireup="true" CodeFile="frmPondMaster.aspx.cs" Inherits="MPR_frmPondMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div id="content-container">
        <asp:HiddenField ID="hidDistrictKey" runat="server" />

        <!--Page Title-->
        <!--------------------------------------------------------->
        <div class="pageheader hidden-xs">
            <h3><i class="fa fa-home"></i>नीलाम जलाशयों का मास्टर </h3>
            <div class="breadcrumb-wrapper">
                <%-- <span class="label">You are here:</span>--%>
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">होम </a></li>
                    <li class="active">नीलाम जलाशयों का मास्टर </li>
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
                                <h3 class="panel-title"><strong>नीलाम जलाशयों का मास्टर</strong></h3>
                            </div>
                            <!--No Label Form-->
                            <div class="panel-body" style="margin-top: -15px">
                                <h3 style="float: left">जनपद :
                                    <asp:Label ID="lblLoginType" runat="server" Text="कानपुर नगर"></asp:Label></h3>
                                <h3 style="float: right">वित्तीय वर्ष  :
                                     <asp:Label ID="lblFinYear" runat="server" Text="2018-2019"></asp:Label>
                                </h3>
                            </div>
                        </div>
                    </div>
                </div>

               

                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel" id="pnlDetail">
                            <!--No Label Form-->
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="table-responsive">
                                            <table class="table table-bordered table-responsive" id="tblPondMaster">
                                                <colgroup>
                                                    <col width="5%" />
                                                    <col width="15%" />
                                                    <col width="10%" />
                                                    <col width="10%" />
                                                    <col width="10%" />
                                                    <col width="10%" />
                                                    <col width="10%" />
                                                    <col width="10%" />
                                                    <col width="10%" />
                                                    <col width="10%" />
                                                </colgroup>
                                                <thead>
                                                    <tr>
                                                        <th rowspan="2" style="text-align:center">क्रम स०</th>
                                                        <th rowspan="2">जो जलाशय नीलाम किये गए हैं उनका नाम</th>                                                    
                                                        <th rowspan="2">श्रेणी</th>
                                                        <th rowspan="2">नीलाम किये गए जलाशय का क्षेत्रफल (हे०)</th>
                                                        <th rowspan="2">नीलाम होने वाले जलाशय का न्यूनतम मूल्य</th>
                                                        <th colspan="2" style="text-align:center">नीलाम अवधि</th>
                                                        <th rowspan="2">नीलम के प्रथम वर्ष का मूल्य</th>
                                                        <th rowspan="2">जलाशय नीलाम की कुल ठेका अवधि की वास्तविक आय/ नीलाम की धनराशी</th>
                                                        <th rowspan="2">जमा जमानत धनराशी</th>
                                                    </tr>
                                                    <tr>
                                                        <th style="text-align:center">कब से </th>
                                                        <th style="text-align:center">कब तक</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td  style="text-align:center">
                                                             1.
                                                        </td>
                                                        <td>
                                                            <label name="pondname" class="label-control"></label>
                                                        </td>
                                                       <td>
                                                            <select name="pondgrade" class="form-control">
                                                                <option value="1">एक</option>
                                                                 <option value="2">दो</option>
                                                                 <option value="3">तीन</option>
                                                                 <option value="4">चार</option>
                                                                 <option value="5">पांच</option>
                                                            </select>
                                                        </td>
                                                        <td>
                                                            <input type="text" name="pondarea" class="form-control" value="0.0" style="text-align:right"/>  
                                                        </td>
                                                        <td>
                                                              <input type="text" name="pondminvalue" class="form-control" value="0.0" style="text-align:right"/>  
                                                        </td>
                                                        <td>
                                                              <input type="text" name="fromdate" class="form-control" placeholder="dd/mm/yyyy" data-mask="99/99/9999" />  
                                                           
                                                        </td>
                                                          <td>
                                                              <input type="text" name="todate" class="form-control" placeholder="dd/mm/yyyy" data-mask="99/99/9999" />  
                                                        </td>
                                                        <td>
                                                                <input type="text" name="firstyearamt" class="form-control" value="0.0" style="text-align:right"/>  
                                                        </td>
                                                        <td>
                                                                <input type="text" name="totalautionamt" class="form-control" value="0.0" style="text-align:right"/>  
                                                        </td>
                                                         <td>
                                                                <input type="text" name="securitymoney" class="form-control" value="0.0" style="text-align:right"/>  
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="text-align:center">
                                                             2.
                                                        </td>
                                                        <td>
                                                            <label name="pondname" class="label-control"></label>
                                                        </td>
                                                       <td>
                                                            <select name="pondgrade" class="form-control">
                                                                <option value="1">एक</option>
                                                                 <option value="2">दो</option>
                                                                 <option value="3">तीन</option>
                                                                 <option value="4">चार</option>
                                                                 <option value="5">पांच</option>
                                                            </select>
                                                        </td>
                                                        <td>
                                                            <input type="text" name="pondarea" class="form-control" value="0.0" style="text-align:right"/>  
                                                        </td>
                                                        <td>
                                                              <input type="text" name="pondminvalue" class="form-control" value="0.0" style="text-align:right"/>  
                                                        </td>
                                                        <td>
                                                              <input type="text" name="fromdate" class="form-control" placeholder="dd/mm/yyyy" data-mask="99/99/9999" />  
                                                        </td>
                                                          <td>
                                                              <input type="text" name="todate" class="form-control" placeholder="dd/mm/yyyy" data-mask="99/99/9999" />  
                                                        </td>
                                                        <td>
                                                                <input type="text" name="firstyearamt" class="form-control" value="0.0" style="text-align:right"/>  
                                                        </td>
                                                        <td>
                                                                <input type="text" name="totalautionamt" class="form-control" value="0.0" style="text-align:right"/>  
                                                        </td>
                                                         <td>
                                                                <input type="text" name="securitymoney" class="form-control" value="0.0" style="text-align:right"/>  
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="text-align:center">
                                                             3.
                                                        </td>
                                                        <td>
                                                            <label id="pondname" class="label-control"></label>
                                                        </td>
                                                       <td>
                                                            <select id="pondgrade" class="form-control">
                                                                <option value="1">एक</option>
                                                                 <option value="2">दो</option>
                                                                 <option value="3">तीन</option>
                                                                 <option value="4">चार</option>
                                                                 <option value="5">पांच</option>
                                                            </select>
                                                        </td>
                                                        <td>
                                                            <input type="text" id="pondarea" class="form-control" value="0.0" style="text-align:right"/>  
                                                        </td>
                                                        <td>
                                                              <input type="text" id="pondminvalue" class="form-control" value="0.0" style="text-align:right"/>  
                                                        </td>
                                                        <td>
                                                              <input type="text" id="fromdate" class="form-control" placeholder="dd/mm/yyyy" data-mask="99/99/9999" />  
                                                        </td>
                                                          <td>
                                                              <input type="text" id="todate" class="form-control" placeholder="dd/mm/yyyy" data-mask="99/99/9999" />  
                                                        </td>
                                                        <td>
                                                                <input type="text" id="firstyearamt" class="form-control" value="0.0" style="text-align:right"/>  
                                                        </td>
                                                        <td>
                                                                <input type="text" id="totalautionamt" class="form-control" value="0.0" style="text-align:right"/>  
                                                        </td>
                                                         <td>
                                                                <input type="text" id="securitymoney" class="form-control" value="0.0" style="text-align:right"/>  
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="text-align:center">
                                                             4.
                                                        </td>
                                                        <td>
                                                            <label name="pondname" class="label-control"></label>
                                                        </td>
                                                       <td>
                                                            <select name="pondgrade" class="form-control">
                                                                <option value="1">एक</option>
                                                                 <option value="2">दो</option>
                                                                 <option value="3">तीन</option>
                                                                 <option value="4">चार</option>
                                                                 <option value="5">पांच</option>
                                                            </select>
                                                        </td>
                                                        <td>
                                                            <input type="text" name="pondarea" class="form-control" value="0.0" style="text-align:right"/>  
                                                        </td>
                                                        <td>
                                                              <input type="text" name="pondminvalue" class="form-control" value="0.0" style="text-align:right"/>  
                                                        </td>
                                                        <td>
                                                              <input type="text" name="fromdate" class="form-control" placeholder="dd/mm/yyyy" data-mask="99/99/9999" />  
                                                        </td>
                                                          <td>
                                                              <input type="text" name="todate" class="form-control" placeholder="dd/mm/yyyy" data-mask="99/99/9999" />  
                                                        </td>
                                                        <td>
                                                                <input type="text" name="firstyearamt" class="form-control" value="0.0" style="text-align:right"/>  
                                                        </td>
                                                        <td>
                                                                <input type="text" name="totalautionamt" class="form-control" value="0.0" style="text-align:right"/>  
                                                        </td>
                                                         <td>
                                                                <input type="text" name="securitymoney" class="form-control" value="0.0" style="text-align:right"/>  
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="text-align:center">
                                                            5.
                                                        </td>
                                                        <td>
                                                            <label name="pondname" class="label-control"></label>
                                                        </td>
                                                       <td>
                                                            <select name="pondgrade" class="form-control">
                                                                <option value="1">एक</option>
                                                                 <option value="2">दो</option>
                                                                 <option value="3">तीन</option>
                                                                 <option value="4">चार</option>
                                                                 <option value="5">पांच</option>
                                                            </select>
                                                        </td>
                                                        <td>
                                                            <input type="text" name="pondarea" class="form-control" value="0.0" style="text-align:right"/>  
                                                        </td>
                                                        <td>
                                                              <input type="text" name="pondminvalue" class="form-control" value="0.0" style="text-align:right"/>  
                                                        </td>
                                                        <td>
                                                              <input type="text" name="fromdate" class="form-control" placeholder="dd/mm/yyyy" data-mask="99/99/9999" />  
                                                        </td>
                                                          <td>
                                                              <input type="text" name="todate" class="form-control" placeholder="dd/mm/yyyy" data-mask="99/99/9999" />  
                                                        </td>
                                                        <td>
                                                                <input type="text" name="firstyearamt" class="form-control" value="0.0" style="text-align:right"/>  
                                                        </td>
                                                        <td>
                                                                <input type="text" name="totalautionamt" class="form-control" value="0.0" style="text-align:right"/>  
                                                        </td>
                                                         <td>
                                                                <input type="text" name="securitymoney" class="form-control" value="0.0" style="text-align:right"/>  
                                                        </td>
                                                    </tr>
                                                </tbody>
                                               
                                            </table>

                                        </div>

                                    </div>
                                </div>

                            </div>

                            <div class="panel-footer">
                                <button class="btn btn-info" type="submit" id="btnSubmit">सुरक्षित करें</button>
                                &nbsp;&nbsp;&nbsp;
                                 <button class="btn btn-warning" type="button">निरस्त करें</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

