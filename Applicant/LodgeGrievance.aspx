<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ApplicantMaster.Master" EnableEventValidation="false" AutoEventWireup="true" CodeFile="LodgeGrievance.aspx.cs" Inherits="Applicant_LodgeGrievance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script src="../js/jquery-2.1.1.min.js" type="text/javascript"></script>
       <script type="text/javascript">
           $(document).ready(function () {
               $("form[id$='form']").bootstrapValidator({
                   framework: 'bootstrap',
                   icon: {
                       valid: 'glyphicon glyphicon-ok',
                       invalid: 'glyphicon glyphicon-remove',
                       validating: 'glyphicon glyphicon-refresh'
                   },
                   fields: {
                       ddlGrievanceSource: {
                           row: '.col-xs-4',
                           validators: {
                               notEmpty: {
                                   message: 'The Grievance Source is required.'
                               }
                           }
                       },
                       ddlGrievanceType: {
                           row: '.col-xs-4',
                           validators: {
                               notEmpty: {
                                   message: 'The Grievance Type is required'
                               }
                           }
                       },
                       ddlGrievanceSubType: {
                           row: '.col-xs-4',
                           validators: {
                               notEmpty: {
                                   message: 'The Grievance Sub Type is required'
                               }
                           }
                       },
                       txtDetail: {
                           row: '.col-xs-4',
                           validators: {
                               notEmpty: {
                                   message: 'The Section is required'
                               }
                           }
                       }
                   }
               });
           });
       </script>

     <%-- For Get Data --%>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#<%=ddlGrievanceSubType.ClientID%>").prop("disabled", true);
            $("#<%=txtDetail.ClientID%>").prop("disabled", true);
            $("#<%=fuAttachment.ClientID%>").prop("disabled", true);
            $("#<%=chkSMS.ClientID%>").prop("disabled", true);
            $("#<%=chkEmail.ClientID%>").prop("disabled", true);

            $('#btnCancel').click(function () {
                window.location.reload();
            });

            $.ajax({
                type: "POST",
                url: "LodgeGrievance.aspx/PopulateComplainSource",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var ddl = $("[id*=ddlGrievanceSource]");
                    $.each(r.d, function () {
                        ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    ddl.selectpicker('refresh');
                }
            });

            $.ajax({
                type: "POST",
                url: "LodgeGrievance.aspx/PopulateComplainType",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",

                success: function (r) {

                    var ddl = $("[id*=ddlGrievanceType]");
                    ddl.prepend("<option value='' selected disabled hidden> Select GrievanceType </option>").val('');
                    $.each(r.d, function () {
                        ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    ddl.selectpicker('refresh');
                }
            });
        });

        function populateSubType() {
            var compType = parseInt($("#<%=ddlGrievanceType.ClientID%>").val());
            var source = parseInt($("#<%=ddlGrievanceSource.ClientID%>").val());
            if (compType > 0) {
                $("#<%=hidComplainSource.ClientID%>").val(source);
                $("#<%=hidComplainType.ClientID%>").val(compType);
               

                $("#<%=ddlGrievanceSubType.ClientID%>").prop("disabled", false);
                $("#<%=txtDetail.ClientID%>").prop("disabled", false);
                $("#<%=fuAttachment.ClientID%>").prop("disabled", false);
                $("#<%=chkSMS.ClientID%>").prop("disabled", false);
                $("#<%=chkEmail.ClientID%>").prop("disabled", false);

                $.ajax({
                    type: "POST",
                    url: "LodgeGrievance.aspx/PopulateComplainSubType",
                    data: '{ComplainTypeKey:' + compType + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (r) {
                        var ddl = $("#<%=ddlGrievanceSubType.ClientID%>");
                        $("#<%=ddlGrievanceSubType.ClientID%> option").remove();
                        ddl.prepend("<option value='' selected disabled hidden> Select GrievanceType </option>");
                        $.each(r.d, function () {
                            ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                        });
                        ddl.selectpicker('refresh');

                    }
                });
            }

        }

        function changeSubType() {
            var subType = parseInt($("#<%=ddlGrievanceSubType.ClientID%>").val());
            $("#<%=hidComplainSubType.ClientID%>").val(subType);
        }

    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div id="content-container">
        <!--Page Title-->
        <!--------------------------------------------------------->
        <div class="pageheader hidden-xs">
            <h3><i class="fa fa-home"></i>Lodge Grievance </h3>
            <div class="breadcrumb-wrapper">
                <span class="label">You are here:</span>
                <ol class="breadcrumb">
                    <li><a href="Dashboard.aspx">Home </a></li>
                    <li class="active">Lodge Grievance </li>
                </ol>
            </div>
        </div>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <!--End page title-->

        <!--Page content-->
        <!--===================================================-->
        <div id="page-content">
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel">
                        <div class="panel-heading">
                            <h3 class="panel-title">
                                <span class="col-md-10">Add New Grievance</span>
                                <span class="col-md-2">
                                    <a href="GrievanceStatus.aspx"><span class="text-primary">View Grievance Status</span> </a>
                                </span>
                            </h3>
                        </div>
                        <!--No Label Form-->
                        <!--===================================================-->
                        <div class="form-horizontal" id="registrationForm">
                            <div class="panel-body mar-top">
                                <div class="form-group">
                                    <label class="control-label col-md-3" for="ddlGrievanceSource">Grievance Source </label>
                                    <div class="col-md-8">
                                        <!-- Default choosen -->
                                        <!--===================================================-->
                                        <asp:HiddenField ID="hidComplainSource" runat="server" />
                                        <asp:DropDownList runat="server" id="ddlGrievanceSource" class="form-control selectpicker" data-live-search="true" name="ddlGrievanceSource">
                                        </asp:DropDownList>
                                        <!--===================================================-->
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3" for="ddlGrievanceType">Grievance Type </label>
                                    <div class="col-md-8">
                                        <!-- Default choosen -->
                                        <!--===================================================-->
                                        <asp:HiddenField ID="hidComplainType" runat="server" />
                                        <asp:DropDownList runat="server"  class="form-control selectpicker" data-live-search="true" id="ddlGrievanceType" name="ddlGrievanceType" onchange="populateSubType()">
                                        </asp:DropDownList>
                                        <!--===================================================-->
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3" for="ddlGrievanceSubType">Grievance Sub Type </label>
                                    <div class="col-md-8">
                                        <!-- Default choosen -->
                                        <!--===================================================-->
                                         <asp:HiddenField ID="hidComplainSubType" runat="server" />
                                        <asp:DropDownList runat="server"  class="form-control selectpicker" data-live-search="true" id="ddlGrievanceSubType" name="ddlGrievanceSubType" onchange="changeSubType()">
                                        </asp:DropDownList>
                                        <!--===================================================-->
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-3 control-label" for="txtDetail"">Grievance Detail</label>
                                    <div class="col-md-8">
                                        <asp:TextBox runat="server" id="txtDetail" TextMode="MultiLine" rows="9" class="form-control" placeholder="Your grievance here.." name="txtDetail"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-3 control-label" for="fuAttachment">Attachment (Optional)</label>
                                    <div class="col-md-8">
                                        <asp:HiddenField ID="hfAttachmentPath" runat="server" />
                                        <asp:FileUpload runat="server" class="form-control" id="fuAttachment"/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-md-3 control-label" for="demo-textarea-input">Notify Status By</label>
                                    <div class="col-md-3">
                                       <asp:CheckBox CssClass="btn btn-default form-text" runat="server" id="chkSMS" Checked="true" Text=" SMS"/>
                                       <asp:CheckBox runat="server" id="chkEmail" CssClass="form-icon btn btn-default form-text" Text=" EMAIL"/>
                                    </div>
                                </div>
                            </div>
                            <div class="panel-footer">
                                <div class="form-group">
                                    <div class="col-xs-9 col-xs-offset-3">
                                        <asp:Button runat="server" ID="btnSave" class="btn btn-info btn-lg mar-rgt" Text="Submit" OnClick="btnSave_Click" />

                                        <button class="btn btn-warning btn-lg">Cancel</button>
                                    </div>
                                </div>
                            </div>
                            <%-- <div class="panel-footer text-right">
                                              <button class="btn btn-warning">Cancel</button>
                                            <button class="btn btn-info">Submit</button>
                                        </div>--%>
                        </div>
                        <!--===================================================-->
                        <!--End No Label Form-->
                    </div>
                </div>

            </div>

        </div>
        <!--===================================================-->
        <!--End page content-->
    </div>
</asp:Content>


