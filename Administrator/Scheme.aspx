<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AdministratorMaster.master" AutoEventWireup="true" CodeFile="Scheme.aspx.cs" Inherits="Administrator_Scheme" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../js/jquery-2.1.1.min.js" type="text/javascript"></script>
    <%-- Define Validation Rule --%>
    <script type="text/javascript">
        var isValid = false;
        $(document).ready(function () {
            $('#<%=addscheme.ClientID%>').bootstrapValidator({
                framework: 'bootstrap',
                icon: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    ddlSchemeNameType: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'The Scheme Type is required.'
                            }
                        }
                    },
                    ctl00$ContentPlaceHolder1$txtSchemeCode: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'The Scheme Code is required.'
                            }
                        }
                    },
                    ctl00$ContentPlaceHolder1$txtSchemeName: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'The Scheme Name is required.'
                            }
                        }
                    },
                    ctl00$ContentPlaceHolder1$txtDescription: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'The Description Type is required'
                            }
                        }
                    },
                    ctl00$ContentPlaceHolder1$ddlDocument: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'The Document is required'
                            }
                        }
                    },
                    ctl00$ContentPlaceHolder1$fuGuidlines: {
                        row: '.col-xs-4',
                        validators: {
                            file: {
                                extension: 'pdf',
                                type: 'application/pdf',
                                message: 'Please select pdf file.'
                            }
                        }
                    }
                }
            }).on('success.field.bv', function () {
                isValid = true;
            });
        });
    </script>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#datepicker").datepicker({ autoclose: true });
            if ($('#<%=hfGuidelineDoc.ClientID%>').val() != "") {
                $("#lnkGuidlines").prop("href", "<%= "../" + DBLayer.SchemeGuidlineDirectory + "/"%>" + filePath);
                //$("#<%=fuGuidlines.ClientID%>").prop('required',false);​​​​​
                $("#lnkGuidlines").show();
            }
            else {
                //$("#<%=fuGuidlines.ClientID%>").prop('required',true);​​​​​
                $("#lnkGuidlines").hide();
            }

            $.ajax({
                type: "POST",
                url: "Scheme.aspx/GetLoadDocument",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var ddl = $("[id*=ddlDocument]");
                    ddl.empty().append('<option selected="selected" value="">Select</option>');
                    $.each(r.d, function () {
                        ddl.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                }
            });
        });


        $(document).on("click", ".editButton", function () {
            $("#add-tab").trigger('click');
            $("#tab-add-scheme").addClass("tab-pane fade active in")
            $("#tab-list-scheme").removeClass("tab-pane fade active in")

            $("#tab-list-scheme").prop("aria-selected", "true")
            $("#tab-list-scheme").prop("aria-expanded", "false")

            $("#pnlSchemeDetail").hide();
            var filePath = null;
            var id = $(this).attr("data-id");
            $("#<%=hfSchemeKey.ClientID%>").val(id);
            $.ajax({
                type: "Post",
                contentType: "application/json; charset=utf-8",
                url: "Scheme.aspx/EditScheme",
                data: '{SchemeKey: ' + id + '}',
                dataType: "json",
                success: function (data) {

                    var documentid = [];
                    var SchemeDetail = $.parseJSON(data.d);

                    $.each(SchemeDetail, function (index, value) {
                        $("#ddlSchemeNameType").val(value.SchemeTypeKey);
                        $("#ddlSchemeNameType").selectpicker('refresh');

                        $('#<%=txtSchemeCode.ClientID%>').val(value.SchemeCode);
                        $('#<%=txtSchemeName.ClientID%>').val(value.SchemeName);
                        $('#<%=txtDescription.ClientID%>').val(value.Description);
                        $('#<%=txtStartDate.ClientID%>').val(value.Start_Date);
                        $('#<%=txtEndDate.ClientID%>').val(value.End_Date);
                        $('#<%=hfGuidelineDoc.ClientID%>').val(value.GuidelinesUrl);
                        $("#<%=hfSchemeTypeKey.ClientID%>").val(value.SchemeTypeKey);

                        filePath = value.GuidelinesUrl;

                        documentid.push(value.DocumentID);
                    });
                    if (filePath != "" && filePath != null) {
                        $("#lnkGuidlines").prop("href", "<%= "../" + DBLayer.SchemeGuidlineDirectory + "/"%>" + filePath);
                        //$('#ContentPlaceHolder1_fuGuidlines').removeAttr('required');
                        $("#lnkGuidlines").show();
                    }

                    $("#<%=btnSubmit.ClientID%>").val('Update');


                    $("#<%=ddlDocument.ClientID%> option").each(function () {
                        $(this).prop('selected', false);
                    });
                    $("#<%=ddlDocument.ClientID%>").selectpicker('refresh');

                    $.each(documentid, function (index, value) {
                        $("#<%=ddlDocument.ClientID%> option").each(function () {
                            if ($(this).val() == value)
                                $(this).prop('selected', true);
                        });
                    });

                    $("#<%=ddlDocument.ClientID%>").selectpicker('refresh');

                },
                error: function () {
                    alert("Error while retrieving data of :" + id);
                }
            });
        });

        $(document).ready(function () {
            $("#profile-tab").click(function () {
                $("#pnlSchemeDetail").show();
            });
        });

        $(document).ready(function () {
            $("#add-tab").click(function () {
                $("#pnlSchemeDetail").hide();
            });
        });

        $(document).on("click", ".deleteButton", function () {
            var id = $(this).attr("data-id");

            if (confirm("Are you sure want to delete this record?")) {
                $.ajax({
                    type: "Post",
                    contentType: "application/json; charset=utf-8",
                    url: "Scheme.aspx/DeleteScheme",
                    data: '{SchemeKey: ' + id + '}',
                    dataType: "json",
                    success: function () {
                        alert("Scheme deleted successfully");
                        window.location.reload();
                    },
                    error: function (data) {
                        alert("Error while deleting data.");
                    }
                });
            }
            return false;
        });

        $(document).on("click", ".activeButton", function () {
            var id = $(this).attr("data-id");

            if (confirm("Are you sure to active/deactive this record?")) {
                $.ajax({
                    type: "Post",
                    contentType: "application/json; charset=utf-8",
                    url: "Scheme.aspx/DeActiveScheme",
                    data: '{SchemeKey: ' + id + '}',
                    dataType: "json",
                    success: function () {
                        alert("Scheme Updated successfully");
                        window.location.reload();
                    },
                    error: function (data) {
                        alert("Error while updated data.");
                    }
                });
            }
            return false;
        });

    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#ddlSchemeName').prop('disabled', false);
            //Load Scheme Type on Page Load
            $.ajax({
                type: "POST",
                url: "Scheme.aspx/GetSchemesType",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var ddlType = $("#ddlSchemeNameType");
                    ddlType.empty();
                    ddlType.append($("<option selected disabled hidden></option>").val('').html('चयन करें'));
                    $.each(r.d, function () {
                        ddlType.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    ddlType.selectpicker('refresh');
                }
            });
        });

        function GetSchemeType()
        {
            var schemetypekey = $('#ddlSchemeNameType option:selected').val();
            $('#ContentPlaceHolder1_hfSchemeTypeKey').val(schemetypekey);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div id="content-container">
        <!--Page Title-->
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <div class="pageheader hidden-xs">
            <h3><i class="fa fa-home"></i>Scheme </h3>
            <div class="breadcrumb-wrapper">
                <span class="label">You are here:</span>
                <ol class="breadcrumb">
                    <li><a href="#">Home </a></li>
                    <li class="active">Add Scheme </li>
                </ol>
            </div>
        </div>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <!--End page title-->
        <!--Page content-->
        <!--===================================================-->
        <form runat="server" class="form-horizontal" id="addscheme">
            <asp:HiddenField ID="hfGuidelineDoc" runat="server" />
            <asp:HiddenField ID="hfSchemeKey" runat="server" />
            <asp:HiddenField ID="hfSchemeTypeKey" runat="server" />

            <div id="page-content">
                <div class="row">
                    <div class="col-lg-12">
                        <!--Default Tabs (Left Aligned)-->
                        <!--===================================================-->
                        <div class="tab-base">
                            <!--Nav Tabs-->
                            <ul class="nav nav-tabs" id="scheme" role="tablist">
                                <li class="nav-item active">
                                    <a class="nav-link" id="profile-tab" data-toggle="tab" href="#tab-list-scheme" role="tab" aria-controls="profile" aria-selected="false">List Schemes</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="add-tab" data-toggle="tab" href="#tab-add-scheme" role="tab" aria-controls="home" aria-selected="true">Add Scheme</a>
                                </li>

                            </ul>
                            <!--Tabs Content-->
                            <div class="tab-content">
                                <div id="tab-list-scheme" class="tab-pane fade  active in">
                                        <div class="row">
                                            <!-- Row selection (single row) -->
                                            <!--===================================================-->
                                            <div class="col-lg-12">
                                                <div class="panel" id="pnlSchemeDetail">
                                                    <div class="panel-heading">
                                                        <h3 class="panel-title">Scheme <strong>Details</strong></h3>
                                                    </div>
                                                    <div class="panel-body">
                                                        <table id="demo-dt-selection" class="table table-striped table-bordered">
                                                            <colgroup>
                                                                <col width="5%" />
                                                                <col width="18%" />
                                                                <col width="11%" />
                                                                <col width="25%" />
                                                                <col  width="8%" />
                                                                <col  width="10%" />
                                                                <col  width="10%" />
                                                                <col  width="5%" />
                                                                <col  width="8%" />

                                                            </colgroup>
                                                            <thead>
                                                                <tr>
                                                                    <th class="min-desktop" style="text-align: center">S.No.</th>
                                                                    <th class="min-desktop">Scheme Type</th>
                                                                    <th class="min-desktop" style="text-align: center">Scheme Code</th>
                                                                    <th class="min-desktop">Scheme Name</th>
                                                                    <th class="min-desktop">Guidlines</th>
                                                                    <th class="min-desktop">Effective Date</th>
                                                                    <th class="min-desktop">Document</th>
                                                                    <th class="min-desktop">Status</th>
                                                                    <th class="min-desktop" style="text-align: center">Action</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <% for (var data = 0; data < dtSchemeDetail.Rows.Count; data++)
                                                                    { %>
                                                                <tr>
                                                                    <td style="text-align: center"><%= data + 1 %>. </td>
                                                                    <td><%=dtSchemeDetail.Rows[data]["SchemeTypeHindi"].ToString()%></td>
                                                                    <td style="text-align: center"><%=dtSchemeDetail.Rows[data]["SchemeCode"].ToString()%></td>
                                                                    <td><%=dtSchemeDetail.Rows[data]["SchemeName"].ToString()%></td>
                                                                    <td style="text-align: center">

                                                                        <% if (dtSchemeDetail.Rows[data]["DocPath"].ToString() == "")
                                                                            { %>
                                                                            Not Available
                                                                        <%}
                                                                            else
                                                                            { %>
                                                                        <a href='<%= "../" + DBLayer.SchemeGuidlineDirectory + "/" + dtSchemeDetail.Rows[data]["DocPath"].ToString()%>'
                                                                            target="_blank" class="btn btn-xs btn-primary">View File</a>
                                                                        <%} %>
                                                                    </td>

                                                                    <td ><%=dtSchemeDetail.Rows[data]["Start_Date"].ToString()%> <b>To</b> <%=dtSchemeDetail.Rows[data]["End_Date"].ToString()%></td>
                                                                    <td ><%=dtSchemeDetail.Rows[data]["Documents"].ToString()%></td>
                                                                    <td style="text-align: center">
                                                                        <%if (Convert.ToBoolean(dtSchemeDetail.Rows[data]["IsActive"]))
                                                                            {
                                                                        %>
                                                                        <span class="btn  btn-xs btn-success activeButton" data-id="<%=dtSchemeDetail.Rows[data]["SchemeKey"] %>" style="width: 70px">Active</span>
                                                                        <%     
                                                                            }
                                                                            else
                                                                            {
                                                                        %>
                                                                        <span class="btn btn-xs btn-warning activeButton" data-id="<%=dtSchemeDetail.Rows[data]["SchemeKey"] %>">Disable</span>
                                                                        <% 
                                                                            }
                                                                        %>
                                                                    </td>
                                                                    <td style="text-align: center" >
                                                                        <div class="btn-group btn-group-xs">
                                                                            <a href="#" class="btn btn-info btn-icon icon-xs fa fa-edit editButton" data-id="<%=dtSchemeDetail.Rows[data]["SchemeKey"] %>"
                                                                                data-placement="top" data-original-title="Edit"></a>
                                                                            <a href="#" class="btn btn-danger btn-icon icon-xs fa fa-trash deleteButton" data-id="<%=dtSchemeDetail.Rows[data]["SchemeKey"] %>"
                                                                                data-placement="top" data-original-title="Remove"></a>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <%}%>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--===================================================-->
                                            <!-- End Row selection (single row) -->
                                        </div>
                                </div>
                                <div id="tab-add-scheme" class="tab-pane fade">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <div class="panel">
                                                    <div class="panel-heading">
                                                        <h3 class="panel-title">
                                                            <span class="col-md-10">Add New Scheme</span>
                                                        </h3>
                                                    </div>
                                                    <div class="panel-body mar-top">
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3" for="txtSchemeCode">Scheme Type *</label>
                                                            <div class="col-md-7">
                                                                <select class="form-control selectpicker" data-live-search="true" id="ddlSchemeNameType" required onchange="GetSchemeType()"></select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3" for="txtSchemeCode">Scheme Code *</label>
                                                            <div class="col-md-7">
                                                                <asp:TextBox runat="server" ID="txtSchemeCode" class="form-control" placeholder="Scheme Code" name="txtSchemeCode" required />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3" for="txtSchemeName">Scheme Name *</label>
                                                            <div class="col-md-7">
                                                                <asp:TextBox runat="server" ID="txtSchemeName" class="form-control" placeholder="Scheme Name" name="txtSchemeName" required />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3" for="txtDescription">Scheme Description *</label>
                                                            <div class="col-md-7">
                                                                <asp:TextBox runat="server" TextMode="multiline" ID="txtDescription" class="form-control" Rows="4" placeholder="Scheme Description" name="txtDescription" required></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3" for="fuGuidlines">Scheme Guidlines *</label>
                                                            <div class="col-md-5">
                                                                <asp:FileUpload ID="fuGuidlines" runat="server" class="form-control" name="fuGuidlines" />
                                                            </div>
                                                            <div class="col-md-2">
                                                                <a href='#' target="_blank" class="btn btn-xs btn-primary" style="float: right" id="lnkGuidlines">View File</a>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3" for="txtStartDate">Effective Date *</label>
                                                            <div class="col-md-7">
                                                                <!--Bootstrap Datepicker : Range-->
                                                                <!--===================================================-->
                                                                <div id="demo-dp-range" data-date-format="dd/mm/yyyy">
                                                                    <div class="input-daterange input-group" id="datepicker" data-date-format="dd/mm/yyyy">
                                                                        <asp:TextBox runat="server" ID="txtStartDate" class="form-control" name="start" data-date-format="dd/mm/yyyy" placeholder="dd/mm/yyyy" data-bv-date="true" data-bv-date-format="DD/MM/YYYY" />
                                                                        <span class="input-group-addon">To </span>
                                                                        <asp:TextBox runat="server" ID="txtEndDate" class="form-control" name="end" data-date-format="dd/mm/yyyy" placeholder="dd/mm/yyyy" data-bv-date="true" data-bv-date-format="DD/MM/YYYY" />
                                                                    </div>
                                                                </div>

                                                                <!--===================================================-->
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3" for="ddlDocument">Choose Document *</label>
                                                            <div class="col-md-7">
                                                                <!-- Bootstrap Select with Multiple Selects -->
                                                                <!--===================================================-->
                                                                <asp:ListBox ID="ddlDocument" runat="server"
                                                                    class="form-control selectpicker" SelectionMode="Multiple" title="Choose one of the following..." name="ddlDocument" required></asp:ListBox>
                                                                <!--===================================================-->
                                                            </div>
                                                        </div>
                                                        <%--  <div class="form-group">
                                                            <label class="control-label col-md-3" for="chkIsActive">Is Active?</label>
                                                            <div class="col-md-7">
                                                                <div class="box-inline mar-rgt">
                                                                    <!--Switchery : Checked by default-->
                                                                    <!--===================================================-->
                                                                    <asp:CheckBox runat="server" ID="chkIsActive" type="checkbox" Checked />
                                                                    <!--===================================================-->
                                                                </div>
                                                            </div>
                                                        </div>--%>
                                                    </div>
                                                    <div class="panel-footer">
                                                        <div class="row">
                                                            <div class="col-sm-7 col-sm-offset-3">
                                                                <asp:Button runat="server" ID="btnSubmit" class="btn btn-info btn-lg" Text="Submit" OnClick="btnSubmit_Click" type="submit"></asp:Button>
                                                                <a href="../Administrator/Scheme.aspx" class="btn btn-warning btn-lg" id="btnCancel">Cancel</a>
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
            </div>

        </form>
    </div>

    <!--jQuery [ REQUIRED ]-->

    <script src="../plugins/bootstrap-validator/bootstrapValidator.min.js"></script>
    <script src="../js/demo/form-validation.js"></script>
    <!--DataTables Sample [ SAMPLE ]-->
    <script src="../js/demo/tables-datatables.js"></script>
    <!-- JavaScript -->
    <script src="//cdn.jsdelivr.net/npm/alertifyjs@1.11.2/build/alertify.min.js"></script>
</asp:Content>

