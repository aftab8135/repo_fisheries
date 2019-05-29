<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintApplicantForm.aspx.cs" Inherits="DVIO_PrintApplicantForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <link rel="shortcut icon" href="../img/favicon.ico" />
    <!--STYLESHEET-->
    <!--=================================================-->
    <!--Roboto Slab Font [ OPTIONAL ] -->
    <link href="http://fonts.googleapis.com/css?family=Roboto+Slab:400,300,100,700" rel="stylesheet" />
    <link href="http://fonts.googleapis.com/css?family=Roboto:500,400italic,100,700italic,300,700,500italic,400" rel="stylesheet" />
    <!--Bootstrap Stylesheet [ REQUIRED ]-->
  
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <!--Jasmine Stylesheet [ REQUIRED ]-->
    <link href="../css/style.css" rel="stylesheet" />
    <!--Font Awesome [ OPTIONAL ]-->
    <link href="../plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
    <!--Switchery [ OPTIONAL ]-->
    <link href="../plugins/switchery/switchery.min.css" rel="stylesheet" />
    <!--Bootstrap Select [ OPTIONAL ]-->
    <link href="../plugins/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />
    <!--Bootstrap Validator [ OPTIONAL ]-->
    <link href="../plugins/bootstrap-validator/bootstrapValidator.min.css" rel="stylesheet" />
    <!--jVector Map [ OPTIONAL ]-->
    <link href="../plugins/jvectormap/jquery-jvectormap.css" rel="stylesheet" />
    <!--Morris.js [ OPTIONAL ]-->
    <link href="../plugins/morris-js/morris.min.css" rel="stylesheet" />
    <!--Bootstrap Table [ OPTIONAL ]-->
    <link href="../plugins/datatables/media/css/dataTables.bootstrap.css" rel="stylesheet" />
    <link href="../plugins/datatables/extensions/Responsive/css/dataTables.responsive.css" rel="stylesheet" />
    <!--Demo [ DEMONSTRATION ]-->
    <link href="../css/demo/jquery-steps.min.css" rel="stylesheet" />
     <!--Chosen [ OPTIONAL ]-->
        <link href="../plugins/chosen/chosen.min.css" rel="stylesheet" />
    <!--Demo [ DEMONSTRATION ]-->
    <link href="../css/demo/jasmine.css" rel="stylesheet" />
    <!--SCRIPT-->
    <!--=================================================-->
    <!--Page Load Progress Bar [ OPTIONAL ]-->
    <link href="../plugins/pace/pace.min.css" rel="stylesheet" />
    <script src="../plugins/pace/pace.min.js"></script>

     <link href="<%=ResolveUrl("~/plugins/bootstrap-modal/css/bootstrap-modal-bs3patch.css") %>"
        rel="stylesheet" type="text/css" />
    
    <link href="<%=ResolveUrl("~/plugins/bootstrap-modal/css/bootstrap-modal.css") %>"
        rel="stylesheet" type="text/css" /> 
     <script src="../js/bootstrap.min.js"></script>

      
</head>
<body onload="javascript:window.print();">
    <form id="form1" runat="server">
     <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-gray">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title">
                        Applicant Data View ( <asp:Label ID="lblschname2" runat="server"></asp:Label> )</h4>
                </div>
                <div class="modal-body" style="padding-bottom: 0px;">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="panel panel-lightPink no-padding">
                                <div class="panel-body">
                                    <div class="form-horizontal" id="form">
                                        <div class="panel-body">
                                      
                                            <div class="col-md-11">
                                                
                                                <div class="row">
                                        
                                              <table class="table table-hover text-black">
                                                  
                                <tbody>

                                    <tr>
                                        <td class="col-xs-2">
                                            <strong>Application ID</strong>
                                        </td>
                                        <td class="col-xs-4">
                                                    <asp:Label id="txtaadharno"  CssClass="control-lable" runat="server"></asp:Label>
                                              
                                        </td>
                                        <td class="col-xs-2">
                                            <strong>Applicant Name</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="txtName" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        </tr>
                                  
                                     <tr>
                                        <td class="col-xs-2">
                                            <strong>State</strong>
                                        </td>
                                        <td class="col-xs-4">
                                             <asp:Label runat="server" CssClass="control-lable" ID="lblState">Uttar Pradesh</asp:Label>
                                        </td>
                                        <td class="col-xs-2">
                                            <strong>   Date of Birth</strong>
                                        </td>
                                        <td class="col-xs-4">
                                           
                                                                    <asp:Label runat="server" ID="txtDOB" CssClass="control-lable"
                                                                        data-date-format="dd/mm/yyyy" data-date-viewmode="years"></asp:Label>
                                        </td>
                                        </tr>
                                     <tr>
                                        <td class="col-xs-2">
                                            <strong>  District</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="ddlDistrict" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        <td class="col-xs-2">
                                            <strong>Social Category</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="ddlSocialCat" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        </tr>
                                     <tr>
                                        <td class="col-xs-2">
                                            <strong>  Gender</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="ddlGender" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        <td class="col-xs-2">
                                            <strong> Special Category</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="ddlSpecialCat" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        </tr>
                                     <tr>
                                        <td class="col-xs-2">
                                            <strong>  Communication House No</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="txtCommunicationHouseNo" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        <td class="col-xs-2">
                                            <strong> Village/Mohalla</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="txtUnitVillage" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        </tr>
                                      <tr>
                                        <td class="col-xs-2">
                                            <strong>  Post Office</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="txtCommunicationPO" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        <td class="col-xs-2">
                                            <strong> Block Name</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="txtUnitVikasKhand" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        </tr>
                                    
                                     <tr>
                                        <td class="col-xs-2">
                                            <strong>  District</strong>
                                        </td>
                                        <td class="col-xs-4">
                                               <asp:HiddenField runat="server" ID="hidUnitDistrict" />
                                                             
                                            <asp:Label ID="txtUnitDistrict" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        <td class="col-xs-2">
                                            <strong> Pin</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="txtUnitPinCode" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        </tr>
                                     <tr>
                                        <td class="col-xs-2">
                                            <strong>  Mobile No</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="txtMobileNo1" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        <td class="col-xs-2">
                                            <strong> Email</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="txtEMail" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        </tr>
                                        </tbody>
                                                  </table>
                                  
                                         
                                                    </div>
                                              
                                              
                                         
                                               
                                                <div class="row">
                                                 <div  class="list-group-item list-group-item-warning" style="padding-top: 4px;
                                                        height: 30px; padding-bottom: 4px; font-size: 1.2em;">
                                                   <%--  <div class="col-md-12 bg-orange-active rounded-corners text-bold" >--%>
                                                        Particular of project&nbsp;
                                                   <%-- </div>--%>
                                                     </div>
                                                </div>
                                                <br />
                                               
                                                <div class="row">
                                                       <div class="modal-body" style="padding-bottom: 0px;">
                                              <table class="table table-hover text-black">
                                            
                                <tbody>

                                    <tr>
                                        <td class="col-xs-2">
                                            <strong> Scheme Name</strong>
                                        </td>
                                        <td colspan="3" class="col-xs-8">
                                                    <asp:Label id="txtActivityName"  CssClass="control-lable" runat="server"></asp:Label>
                                              
                                        </td>
                                       
                                        </tr>
                                    <tr>
                                        <td class="col-xs-2">
                                            <strong> Details Proposed Work</strong>
                                        </td>
                                        <td colspan="3" class="col-xs-8">
                                                    <asp:Label id="txtProductDescription"  CssClass="control-lable" runat="server"></asp:Label>
                                              
                                        </td>
                                       
                                        </tr>
                                       <tr>
                                        <td class="col-xs-2">
                                            <strong> Total Land</strong>
                                        </td>
                                        <td  class="col-xs-4">
                                                    <asp:Label id="txttotalLand"  CssClass="control-lable" runat="server"></asp:Label>
                                              
                                        </td>
                                        <td class="col-xs-2">
                                            <strong>Total Water Area</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="txtTotalwaterarea" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        </tr>
                                            <tr>
                                        <td class="col-xs-2">
                                            <strong> Plot No</strong>
                                        </td>
                                        <td  class="col-xs-4">
                                                    <asp:Label id="txtplotno"  CssClass="control-lable" runat="server"></asp:Label>
                                              
                                        </td>
                                        <td class="col-xs-2">
                                            <strong>Project Cost</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="txtProjectcost" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        </tr>
                                            <tr>
                                        <td class="col-xs-2">
                                            <strong> Beneficary Share</strong>
                                        </td>
                                        <td  class="col-xs-4">
                                                    <asp:Label id="txtBeneficary"  CssClass="control-lable" runat="server"></asp:Label>
                                              
                                        </td>
                                        <td class="col-xs-2">
                                            <strong>Total Subsidary</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="txtSubsidary" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        </tr>
                                            <tr>
                                        <td class="col-xs-2">
                                            <strong> Central Share</strong>
                                        </td>
                                        <td  class="col-xs-4">
                                                    <asp:Label id="txtcentralshare"  CssClass="control-lable" runat="server"></asp:Label>
                                              
                                        </td>
                                        <td class="col-xs-2">
                                            <strong>State Share</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="txtstateshare" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        </tr>
                                      <tr>
                                        <td class="col-xs-2">
                                            <strong> Applicant Experience</strong>
                                        </td>
                                        <td colspan="3" class="col-xs-8">
                                                    <asp:Label id="txtApplicantExperience"  CssClass="control-lable" runat="server"></asp:Label>
                                              
                                        </td>
                                       
                                        </tr>
                                    <tr>
                                        <td class="col-xs-2">
                                            <strong> Details Economics</strong>
                                        </td>
                                        <td colspan="3" class="col-xs-8">
                                                    <asp:Label id="txtdetailEconomics"  CssClass="control-lable" runat="server"></asp:Label>
                                              
                                        </td>
                                       
                                        </tr>
                                    </tbody>
                                                  </table>

                                                  
                                                </div>
                                                    </div>
                                           
                                            
                                                 
                                              
                                           
                                         
                                                <br />
                                                <div class="row">
                                                     <div  class="list-group-item list-group-item-warning" style="padding-top: 4px;
                                                        height: 30px; padding-bottom: 4px; font-size: 1.2em;">
                                                        Bank Detail&nbsp;
                                                    </div>
                                                </div>
                                                <br />
                                                
                                             
                                               
                                                <div class="row">
                                                       <div class="modal-body" style="padding-bottom: 0px;">
                                              <table class="table table-hover text-black">
                                                
                                <tbody>

                                    <tr>
                                        <td class="col-xs-2">
                                            <strong> Financing Bank</strong>
                                        </td>
                                        <td colspan="3" class="col-xs-8">
                                                    <asp:Label id="ddlFirstFinancingBank"  CssClass="control-lable" runat="server"></asp:Label>
                                              
                                        </td>
                                       
                                        </tr>
                                    <tr>
                                        <td class="col-xs-2">
                                            <strong>  IFS/Bank Code</strong>
                                        </td>
                                        <td  class="col-xs-4">
                                                    <asp:Label id="txtFirstFinancingIFSCCode"  CssClass="control-lable" runat="server"></asp:Label>
                                              <asp:HiddenField runat="server" ID="hidBranch" />
                                        </td>
                                         <td class="col-xs-2">
                                            <strong>  Branch Name</strong>
                                        </td>
                                        <td  class="col-xs-4">
                                                    <asp:Label id="txtFirstFinancingBranchName"  CssClass="control-lable" runat="server"></asp:Label>
                                              <asp:HiddenField runat="server" ID="HiddenField1" />
                                        </td>
                                        </tr>

                                    <tr>
                                        <td class="col-xs-2">
                                            <strong> Address</strong>
                                        </td>
                                        <td colspan="3" class="col-xs-8">
                                                    <asp:Label id="txtFirstFinancingAddress"  CssClass="control-lable" runat="server"></asp:Label>
                                              
                                        </td>
                                       
                                        </tr>
                                  
                                        <tr>
                                        <td class="col-xs-2">
                                            <strong> District</strong>
                                        </td>
                                        <td colspan="3" class="col-xs-8">
                                                    <asp:Label id="txtFirstFinancingDistrict"  CssClass="control-lable" runat="server"></asp:Label>
                                              
                                        </td>
                                       
                                        </tr>
                                    
                                    </tbody>
                                                  </table>
                                                           </div>
                                                    </div>
                                                
                                           
                                             
                                              

                                                <br />
                                                
                                               

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
    </form>
</body>
</html>
