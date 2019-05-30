<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DistrictMaster.master" AutoEventWireup="true" CodeFile="frm_AdarshGramYojna.aspx.cs" Inherits="District_frm_AdarshGramYojna" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="<%=ResolveUrl("~/js/jquery-2.1.1.min.js") %>"></script>
    <style>
        .panel-heading {
            background-color: #f9f9f9 !important;
        }

        .panel-title {
            line-height: 44px !important;
        }
    </style>
    <script type="text/javascript">

        $(document).ready(function () {
            $('#pnlDetail').show();
            $.ajax({
                type: "POST",
                url: "frm_AdarshGramYojna.aspx/GetMonthName",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var ddlType = $("#ddlMonthName");
                    ddlType.empty();
                    ddlType.append($("<option selected disabled hidden></option>").val('').html('चयन करें'));
                    $.each(r.d, function () {
                        ddlType.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    ddlType.selectpicker('refresh');
                }
            });
        });
    </script>
 
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div id="content-container">
        <asp:HiddenField ID="hidDistrictKey" runat="server" />
        <!--Page Title-->
        <!--------------------------------------------------------->
        <div class="pageheader hidden-xs">
            <h3><i class="fa fa-home"></i>सांसद आदर्श ग्राम योजना अन्तर्गत चयनित ग्रामों की कार्य की सूचना </h3>
            <div class="breadcrumb-wrapper">
                <%-- <span class="label">You are here:</span>--%>
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">होम </a></li>
                    <li class="active">सांसद आदर्श ग्राम योजना अन्तर्गत चयनित ग्रामों की कार्य की सूचना</li>
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
                                <h3 class="panel-title"><strong>सांसद आदर्श ग्राम योजना अन्तर्गत चयनित ग्रामों की कार्य की सूचना</strong></h3>
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
                        <div class="panel">             
                            <!--No Label Form-->
                            <div class="panel-body">
                                <!-- Inline Form  -->
                                <!--===================================================-->
                                <div class="row mar-top">

                                    <div class="col-lg-4">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="col-lg-4 control-label">माह का नाम </label>
                                                <div class="col-lg-8">
                                                    <select class="form-control selectpicker" id="ddlMonthName">
                                                    </select>
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>  
                                    <div class="col-lg-4">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="col-lg-4 control-label">वर्ष </label>
                                                <div class="col-lg-8">
                                                     <input type="text" class="form-control" value=""   id="txtYear" />
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>                                  
                                    <div class="col-lg-2" hidden>
                                        <button class="btn btn-warning align-right" type="button" onclick="showProgress();">खोजें</button>
                                    </div>

                                </div>
                            </div>

                        </div>
                    </div>
                </div>
                 <div class="row">
                    <div class="col-lg-12">
                        <div class="panel">             
                            <!--No Label Form-->
                            <div class="panel-body">
                                <!-- Inline Form  -->
                                <!--===================================================-->
                                <div class="row mar-top">

                                    <div class="col-lg-4">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="col-lg-4 control-label">सांसद का नाम </label>
                                                <div class="col-lg-8">
                                                     <input type="text" class="form-control" value=""   id="txtSansadName" />
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>       
                                     
                                     <div class="col-lg-4">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="col-lg-4 control-label">चयनित ग्राम का नाम </label>
                                                <div class="col-lg-8">
                                                     <input type="text" class="form-control" value=""   id="txtSelectedVillage" />
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>                             
                                    <div class="col-lg-4">
                                        <fieldset>
                                            <div class="form-group">
                                                <label class="col-lg-4 control-label">कार्य योजना </label>
                                                <div class="col-lg-8">
                                                     <input type="text" class="form-control" value=""   id="txtWorkScheme" />
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>   
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel" id="pnlDetail">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="table-responsive">
                                            <table class="table tabel-responsive table-bordered">
                                                <colgroup>
                                                    <col style="text-align: center; width: 5%" />
                                                    <col style="text-align: center; width: 45%" />
                                                    <col style="text-align: right; width: 25%" />
                                                    <col style="text-align: right; width: 25%" />
                                                </colgroup>
                                                <thead>
                                                    <tr>
                                                        <th style="text-align: center; width: 5%">क्र0सं0
                                                        </th>
                                                        <th>विवरण
                                                        </th>
                                                        <th style="text-align: right; width: 25%">संख्या
                                                        </th>
                                                        <th style="text-align: right; width: 25%">क्षेत्रफल (हे0)
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td style="text-align: center; width: 5%">
                                                            <label>1.</label>
                                                        </td>
                                                        <td>
                                                            <label>ग्राम में उपलब्ध आवंटन योग्य तालाब</label>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right"  step="0.01" min="0.00" id="nm_pond_nos" />
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right"  step="0.01" min="0.00" id="nm_pond_hect"/>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="text-align: center; width: 5%">
                                                            <label>2.</label>
                                                        </td>
                                                        <td>
                                                            <label>पूर्व में आवंटित तालाब</label>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right"  step="0.01" min="0.00" id="nm_Past_nos" />
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right"  step="0.01" min="0.00" id="nm_Past_hect"/>
                                                        </td>
                                                    </tr>
                                                     <tr>
                                                        <td style="text-align: center; width: 5%">
                                                            <label>3.</label>
                                                        </td>
                                                        <td>
                                                            <label>तालाब आवंटन का लक्ष्य</label>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right"  step="0.01" min="0.00" id="nm_Curr_nos" "/>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right"  step="0.01" min="0.00" id="nm_Curr_hect" ;"/>
                                                        </td>
                                                    </tr>
                                                     <tr>
                                                        <td style="text-align: center; width: 5%">
                                                            <label>4.</label>
                                                        </td>
                                                        <td>
                                                            <label>मत्स्य पालन से आच्छादित कुल तालाब</label>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right" step="0.01" min="0.00" id="nm_abort_nos""/>
                                                        </td>
                                                        <td>
                                                            <input type="number" class="form-control" value="0.00" style="text-align: right"  step="0.01" min="0.00" id="nm_abort_hect""/>
                                                        </td>
                                                    </tr>
                                                   
                                                </tbody>
                                                <tfoot>
                                                 
                                                </tfoot>
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
