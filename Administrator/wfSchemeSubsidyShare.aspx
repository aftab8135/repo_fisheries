<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AdministratorMaster.master" AutoEventWireup="true" CodeFile="wfSchemeSubsidyShare.aspx.cs" Inherits="Administrator_wfSchemeSubsidyShare" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../js/jquery-2.1.1.min.js" type="text/javascript"></script>
    <script src="../plugins/switchery/switchery.min.css"></script>
    <%-- Define Validation Rule --%>
    <script type="text/javascript">
        var isValid = false;
        $(document).ready(function () {
            new Switchery(document.getElementById('chkIsWomen'), { size: 'small' });
            $('.form-horizontal').bootstrapValidator({
                framework: 'bootstrap',
                icon: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    dtpEffectiveDate: {
                        row: '.col-xs-4',
                        validators: {

                            date: {
                                format: 'DD/MM/YYYY',
                                message: 'The Effectic Date is not a valid.'
                            }
                        }
                    },
                    ddlSchemes: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'The Scheme Name is required.'
                            }
                        }
                    },
                    txtBShare: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'The Share is required'
                            }
                        }
                    },
                    txtCShare: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'The Central Share is required'
                            }
                        }
                    }
                }
            }).on('success.field.bv', function () {
                isValid = true;
            });
        });
    </script>
    <%-- For Get Data --%>
    <script type="text/javascript">
        $(document).ready(function () {


            $.ajax({
                type: "POST",
                url: "wfSchemeSubsidyShare.aspx/GetReserveCategory",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    //alert(r.d);
                    var ddlCategory = $("[id*=ddlCategory]");
                    ddlCategory.append($("<option selected disabled hidden></option>").val("").html("Select Category"));
                    $.each(r.d, function () {
                        //   alert(this['Value']);
                        ddlCategory.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    ddlCategory.selectpicker('refresh');
                }

            });


            $(document).on("click", ".editButton", function () {
                $("#add-tab").trigger('click');
                $("#tab-add-scheme").addClass("tab-pane fade active in")
                $("#tab-list-scheme").removeClass("tab-pane fade active in")

                $("#tab-list-scheme").prop("aria-selected", "true")
                $("#tab-list-scheme").prop("aria-expanded", "false")

                $("#pnlSchemeDetail").hide();

                var id = $(this).attr("data-id");
                $("#shareKey").val(id);

                $.ajax({
                    type: "Post",
                    contentType: "application/json; charset=utf-8",
                    url: "wfSchemeSubsidyShare.aspx/EditSchemeShare",
                    data: '{ShemeShareKey: ' + id + '}',
                    dataType: "json",
                    success: function (data) {
                        var SchemeDetail = $.parseJSON(data.d);
                        var categorylist = [];
                        var category = null;
                        var schemes = [];
                        $.each(SchemeDetail, function (index, value) {
                            $('#dtpEffectiveDate').val(value.EffectiveDate);
                            $('#chkIsWomen').prop("checked", value.IsWomen);

                            $('#ddlSchemeNameType').val(value.SchemeTypeKey);
                            $("#ddlSchemeNameType").selectpicker('refresh');

                            category = value.Category;

                            schemes.push(value.SchemeKey);

                            $('#txtBShare').val(value.BShare);
                            $('#txtCShare').val(value.CShare);
                            $('#txtSShare').val(value.SShare);

                            $('#chkIsActive').prop("checked", value.IsActive);
                        });

                        GetSchemeType(schemes);

                        //$("#ddlCategory option").each(function () {
                        //    category.text = $(this).text();
                        //    category.val = $(this).val();
                        //    categorylist.push(category);
                        //});     

                        $("#ddlCategory option").each(function () {
                            if ($(this).val() == category)
                                $(this).prop('selected', true);
                            else
                                $(this).prop('selected', false);
                        });

                        $("#ddlCategory").selectpicker('refresh');

                        //$("#ddlSchemes option").each(function () {
                        //    $(this).prop('selected', false);
                        //});
                        //$("#ddlSchemes").selectpicker('refresh');

                        //$.each(schemes, function (index, value) {
                        //    $("#ddlSchemes option").each(function () {
                        //        if ($(this).val() == value)
                        //            $(this).prop('selected', true);
                        //    });
                        //});



                        $("#btnSubmit").text('Update');
                        isValid = true;
                    },

                    error: function () {
                        alert("Error while retrieving data of :" + id);
                    }
                });
            });
        });
    </script>
    <%--For Control Event--%>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#dtpEffectiveDate').datepicker({ autoclose: true });
            $("#btnCancel").click(function () {
                window.location.href = "wfSchemeSubsidyShare.aspx";
            });

            $("#profile-tab").click(function () {
                $("#pnlSchemeDetail").show();
            });

            $("#add-tab").click(function () {
                $("#pnlSchemeDetail").hide();
            });


            //$('#txtBShare').change(function () {
            //    var bshare = 0;
            //    var sshare = 0;
            //    var cshare = 0;

            //    if ($('#txtBShare').val() != "") {
            //        bshare = $('#txtBShare').val();
            //    }
            //    if ($('#txtCShare').val() != "") {
            //        cshare = $('#txtCShare').val();
            //    }

            //    var sshare = 100 - bshare - cshare;

            //    if (sshare != 0) {
            //        $('#txtSShare').val(sshare);
            //    }

            //});

            $('#txtCShare').change(function () {
                var bshare = 0;
                var sshare = 0;
                var cshare = 0;

                if ($('#txtBShare').val() != "") {
                    bshare = $('#txtBShare').val();
                }
                if ($('#txtCShare').val() != "") {
                    cshare = $('#txtCShare').val();
                }

                var sshare = 100 - cshare;

                if (sshare != 0) {
                    $('#txtSShare').val(sshare.toFixed(2));
                }

            });

            $("#chkIsWomen").change(function () {
                var el = $("#ddlCategory");
                if (el) {
                    if (this.checked) {
                        $("#ddlCategory").prop("disabled", true);
                        $("#ddlCategory").selectpicker('refresh');
                    }
                    else {
                        $("#ddlCategory").prop("disabled", false);
                        $("#ddlCategory").selectpicker('refresh');
                    }

                }
            });
        });

    </script>

    <%-- Insert/Update/Delete Operation --%>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnSubmit").click(function () {
                if (isValid) {
                    var BeneficiaryMst = {};
                    var dateString = $('#dtpEffectiveDate').val();

                    var mstKey = parseInt($('#shareKey').val());

                    BeneficiaryMst.EffectiveDate = $('#dtpEffectiveDate').val();
                    if ($('#chkIsWomen').prop("checked") == true) {
                        BeneficiaryMst.IsWomen = true;
                        BeneficiaryMst.Category = 0;
                    }
                    else {
                        BeneficiaryMst.Category = $('#ddlCategory').val();
                        BeneficiaryMst.IsWomen = false;
                    }

                    if ($('#chkIsActive').prop("checked") == true) {
                        BeneficiaryMst.IsActive = true;
                    }
                    else {

                        BeneficiaryMst.IsActive = false;
                    }

                    BeneficiaryMst.BShare = (isNaN(parseFloat($('#txtBShare').val())) ? 0 : parseFloat($('#txtBShare').val()));
                    BeneficiaryMst.CShare = (isNaN(parseFloat($('#txtCShare').val())) ? 0 : parseFloat($('#txtCShare').val()));
                    BeneficiaryMst.SShare = (isNaN(parseFloat($('#txtSShare').val())) ? 0 : parseFloat($('#txtSShare').val()));

                    var selectedValues = $('#ddlSchemes').val();

                    schemelist = [];

                    $.each(selectedValues, function (key, value) {
                        var scheme = {};
                        scheme.SchemeKey = value;
                        schemelist.push(scheme);
                    });

                    BeneficiaryMst.BeneficiarySchemes = schemelist;

                    BeneficiaryMst.MasterId = mstKey

                    $.ajax({
                        type: "POST",
                        url: "wfSchemeSubsidyShare.aspx/CreateScheme",
                        data: '{objBeneficiaryScheme: ' + JSON.stringify(BeneficiaryMst) + '}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            data = (response.d);
                            //data = JSON.parse(response.d);
                            //if (data['Success'] == '1' && parseInt(data['Key']) > 0) {
                            if (data > 0) {
                                if (mstKey == 0) {
                                    alert('Record Saved Successfully.')
                                } else
                                    alert('Record Updated Successfully.')
                                window.location.reload();
                            } else if (data == -1) {
                                alert('Please Correct Invalid Entries.')
                            }
                            else
                                alert('Something Went Wrong.')
                        },
                        error: function (err) {
                            alert(err.statusText)
                        }
                    });
                }

            });

            $(document).on("click", ".deleteButton", function () {
                var id = $(this).attr("data-id");

                if (confirm("Are you sure want to delete this record?")) {
                    $.ajax({
                        type: "Post",
                        contentType: "application/json; charset=utf-8",
                        url: "wfSchemeSubsidyShare.aspx/DeleteSchemeShare",
                        data: '{ShemeShareKey: ' + id + '}',
                        dataType: "json",
                        success: function () {
                            alert("Scheme Share deleted successfully");
                            window.location.reload();
                        },
                        error: function (data) {
                            alert("Error while deleting data.");
                        }
                    });
                }
                return false;
            });
        });

    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#ddlSchemeName').prop('disabled', false);
            //Load Scheme Type on Page Load
            $.ajax({
                type: "POST",
                url: "wfSchemeSubsidyShare.aspx/GetSchemesType",
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

        function GetSchemeType(schemes) {
            var schemetypekey = $('#ddlSchemeNameType option:selected').val();
            $('#ContentPlaceHolder1_hfSchemeTypeKey').val(schemetypekey);
            if (schemetypekey > 0) {
                $.ajax({
                    type: "POST",
                    url: "wfSchemeSubsidyShare.aspx/GetSchemes",
                    data: '{schemetypkey: ' + schemetypekey + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        var ddlSchemes = $("#ddlSchemes").empty();
                        $.each(r.d, function () {
                            ddlSchemes.append($("<option></option>").val(this['Value']).html(this['Text']));
                        });
                        ddlSchemes.selectpicker('refresh');

                        $.each(schemes, function (index, value) {
                            $("#ddlSchemes option").each(function () {
                                if ($(this).val() == value)
                                    $(this).prop('selected', true);
                            });
                        });
                        $("#ddlSchemes").selectpicker('refresh');
                    }
                });
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="content-container">
        <!--Page Title-->
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <div class="pageheader hidden-xs">
            <h3><i class="fa fa-home"></i>Scheme Share </h3>
            <div class="breadcrumb-wrapper">
                <span class="label">You are here:</span>
                <ol class="breadcrumb">
                    <li><a href="#">Home </a></li>
                    <li class="active">Add Scheme Share </li>
                </ol>
            </div>
        </div>
        <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
        <!--End page title-->
        <form runat="server" class="form-horizontal" id="addscheme">
            <input type="hidden" id="shareKey" name="shareKey" value="0" />
            <div id="page-content">
                <div class="row">
                    <div class="col-lg-12">
                        <!--Default Tabs (Left Aligned)-->
                        <!--===================================================-->
                        <div class="tab-base">
                            <!--Nav Tabs-->
                            <ul class="nav nav-tabs" id="scheme" role="tablist">
                                <li class="nav-item active">
                                    <a class="nav-link active" id="profile-tab" data-toggle="tab" href="#tab-list-scheme" role="tab" aria-controls="profile" aria-selected="false">Scheme Share Detail</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="add-tab" data-toggle="tab" href="#tab-add-scheme" role="tab" aria-controls="home" aria-selected="true">Add Scheme Share</a>
                                </li>

                            </ul>
                            <!--Tabs Content-->
                            <div class="tab-content">
                                <div id="tab-add-scheme" class="tab-pane fade">
                                    <div id="page-content1">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <div class="panel">
                                                    <div class="panel-heading">
                                                        <h3 class="panel-title">
                                                            <span class="col-md-10">Add Scheme Beneficiary Share </span>
                                                        </h3>
                                                    </div>
                                                    <div class="panel-body mar-top">
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3" for="dtpEffectiveDate">Effective Date *</label>
                                                            <div class="col-md-7">
                                                                <input type="text" id="dtpEffectiveDate" placeholder="dd/mm/yyyy" data-date-format='dd/mm/yyyy' data-mask="99/99/9999" class="form-control" name="dtpEffectiveDate" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3" for="txtSchemeCode">Schemes Type *</label>
                                                            <div class="col-md-7">
                                                                <select class="form-control selectpicker" data-live-search="true" id="ddlSchemeNameType" required onchange="GetSchemeType(0)"></select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3" for="ddlSchemes">Schemes Name *</label>
                                                            <div class="col-md-7">
                                                                <!-- Bootstrap Select with Multiple Selects -->
                                                                <!--===================================================-->
                                                                <select class="form-control selectpicker" multiple title="Choose Schemes..." id="ddlSchemes" name="ddlSchemes">
                                                                </select>
                                                                <!--===================================================-->
                                                            </div>
                                                        </div>
                                                        <h4 class="text-thin">Beneficiary Share Detail</h4>
                                                        <hr />
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3" for="chkIsWomen">Women</label>
                                                            <div class="col-md-7">
                                                                <input id="chkIsWomen" type="checkbox" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3" for="ddlCategory">Category </label>
                                                            <div class="col-md-7">
                                                                <select class="form-control selectpicker" id="ddlCategory">
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3" for="txtBShare">Share (in%) *</label>
                                                            <div class="col-md-7">
                                                                <input type="text" id="txtBShare" class="form-control" placeholder="00.00" name="bshare" data-mask="99.99" />
                                                            </div>
                                                        </div>

                                                        <h4 class="text-thin">Subsidy Share Detail</h4>
                                                        <hr />
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3" for="txtCShare">Central Share (in%) *</label>
                                                            <div class="col-md-7">
                                                                <input type="text" id="txtCShare" class="form-control" placeholder="00.00" name="cshare" data-mask="99.99" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3" for="txtSShare">State Share (in%) </label>
                                                            <div class="col-md-7">
                                                                <input type="text" id="txtSShare" class="form-control" placeholder="00.00" name="sshare" readonly />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="panel-footer">
                                                        <div class="row">
                                                            <div class="col-sm-7 col-sm-offset-3">
                                                                <button id="btnSubmit" class="btn btn-info btn-lg" type="submit">Submit</button>
                                                                <button class="btn btn-warning btn-lg" id="btnCancel" type="reset">Cancel</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="tab-list-scheme" class="tab-pane fade  active in">
                                    <div id="page-content2">
                                        <div class="row">
                                            <!-- Row selection (single row) -->
                                            <!--===================================================-->
                                            <div class="panel" id="pnlSchemeDetail">
                                                <div class="panel-heading">
                                                    <h3 class="panel-title">Scheme Share <strong>Details</strong></h3>
                                                </div>
                                                <div class="panel-body">
                                                        <table id="demo-dt-selection" class="table table-striped table-bordered">
                                                            <thead>
                                                                <tr>
                                                                    <th class="min-desktop" style="width: 5%; text-align: center">S.No.</th>
                                                                    <th class="min-desktop" style="width: 8%;">Effective Date</th>
                                                                    <th class="min-desktop" style="width: 15%;">Schemes Type</th>
                                                                    <th class="min-desktop" style="width: 20%;">Schemes Name</th>
                                                                    <th class="min-desktop" style="width: 6%;">Is Women</th>
                                                                    <th class="min-desktop" style="width: 8%;">Category</th>
                                                                    <th class="min-desktop" style="width: 8%;">Beneficiary Share (in%)</th>
                                                                    <th class="min-desktop" style="width: 8%;">Central Share (in%)</th>
                                                                    <th class="min-desktop" style="width: 8%;">State Share (in%)</th>
                                                                    <th class="min-desktop" style="width: 6%;">Status</th>
                                                                    <th class="min-desktop" style="width: 8%; text-align: center">Action</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <% for (var data = 0; data < dtSchemeShare.Rows.Count; data++)
                                                                   { %>
                                                                <tr>
                                                                    <td style="width: 5%; text-align: center"><%= data + 1 %>. </td>
                                                                    <td style="width: 8%;"><%=dtSchemeShare.Rows[data]["EffectiveDate"].ToString()%></td>
                                                                    <td style="width: 15%;"><%=dtSchemeShare.Rows[data]["SchemeTypeName"].ToString()%></td>
                                                                    <td style="width: 20%;"><%=dtSchemeShare.Rows[data]["Schemes"].ToString()%></td>
                                                                    <td style="width: 6%;"><%=dtSchemeShare.Rows[data]["IsWomen"].ToString()%></td>
                                                                    <td style="width: 8%;"><%=dtSchemeShare.Rows[data]["Category"].ToString()%></td>
                                                                    <td style="width: 8%;"><%=dtSchemeShare.Rows[data]["BShare"].ToString()%></td>
                                                                    <td style="width: 8%;"><%=dtSchemeShare.Rows[data]["CShare"].ToString()%></td>
                                                                    <td style="width: 8%;"><%=dtSchemeShare.Rows[data]["SShare"].ToString()%></td>
                                                                    <td style="width: 6%;">
                                                                        <%if (Convert.ToBoolean(dtSchemeShare.Rows[data]["IsActive"]))
                                                                          {
                                                                        %>
                                                                        <span class="label label-xs label-table label-success">Active</span>
                                                                        <%     
                                                                      }
                                                                          else
                                                                          {
                                                                        %>
                                                                        <span class="label label-xs label-table label-dark">Disable</span>
                                                                        <% 
                                                                      }
                                                                        %>
                                                                    </td>
                                                                    <td style="width: 8%; text-align: center">
                                                                        <div class="btn-group btn-group-xs">
                                                                            <a href="#" class="btn btn-info btn-icon icon-xs fa fa-edit editButton" data-id="<%=dtSchemeShare.Rows[data]["MasterId"] %>"
                                                                                data-placement="top" data-original-title="Edit"></a>
                                                                            <a href="#" class="btn btn-danger btn-icon icon-xs fa fa-trash deleteButton" data-id="<%=dtSchemeShare.Rows[data]["MasterId"] %>"
                                                                                data-placement="top" data-original-title="Remove"></a>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <%}%>
                                                            </tbody>
                                                        </table>
                                                </div>
                                            </div>
                                            <!--===================================================-->
                                            <!-- End Row selection (single row) -->
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
    <script src="../plugins/bootstrap-validator/bootstrapValidator.min.js"></script>
    <script src="../js/demo/form-validation.js"></script>
    <!--DataTables Sample [ SAMPLE ]-->
    <script src="../js/demo/tables-datatables.js"></script>
    <!--Form Component [ SAMPLE ]-->
    <!--Bootstrap Datepicker [ OPTIONAL ]-->
    <script src="../plugins/bootstrap-datepicker/bootstrap-datepicker.js"></script>
    <!--Form Component [ SAMPLE ]-->
    <script src="../js/demo/form-component.js"></script>
    <script src="../plugins/switchery/switchery.min.js"></script>
</asp:Content>

