<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/DistrictMaster.master" AutoEventWireup="true" CodeFile="StatusUpdate.aspx.cs" Inherits="District_StatusUpdate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="<%=ResolveUrl("~/plugins/bootstrap-modal/css/bootstrap-modal-bs3patch.css") %>" rel="stylesheet" type="text/css" />
    <link href="<%=ResolveUrl("~/plugins/bootstrap-modal/css/bootstrap-modal.css") %>" rel="stylesheet" type="text/css" />
    <script src="../js/bootstrap.min.js"></script>
    <script type="text/javascript">
        function viewremark(obj) {

            if ($('#<%=chkDeclaration1.ClientID%>').is(':checked')) {
                $('#<%=remarkviewdoc.ClientID %>').attr('disabled', true);
            }
            else {
                $('#<%=remarkviewdoc.ClientID %>').attr('disabled', false);
            }
        }

        function funCalled(obj) {

            if ($('#<%=chkDeclaration.ClientID %>').is(':checked')) {
                     $('#<%=txtRemarkdetails.ClientID %>').attr('disabled', true);
                 }
                 else {
                     $('#<%=txtRemarkdetails.ClientID %>').attr('disabled', false);
                 }

             }

             function setApplicationData(obj) {
                 jQuery.noConflict();
                 var row = $(obj).parent('div').parent('td').parent('tr');

                 var readonly = true
                 if (readonly) {
                     $.ajax({
                         type: "POST",
                         url: "StatusUpdate.aspx/getApplicationDetail",
                         data: '{q:"' + $(obj).attr('data-key') + '"}',
                         contentType: "application/json; charset=utf-8",
                         dataType: "json",
                         success: function (response) {
                             $('#<%=txtaadharno.ClientID %>').text(response.d['ApplicationNo']);

                             $('#<%=txtName.ClientID %>').text(response.d['Name']);
                             if (response.d['Gender'] == 1) {
                                 $('#<%=ddlGender.ClientID %>').text("Male");
                           }
                           else if (response.d['Gender'] == 2) {
                               $('#<%=ddlGender.ClientID %>').text("Female");
                           }
                           else {
                               $('#<%=ddlGender.ClientID %>').text("TransGender");
                           }

                             if (response.d['Category'] == 1) {
                                 $('#<%=ddlSpecialCat.ClientID %>').text("General");
                           }
                           else if (response.d['Category'] == 2) {
                               $('#<%=ddlSpecialCat.ClientID %>').text("SC");
                           }
                           else if (response.d['Category'] == 3) {
                               $('#<%=ddlSpecialCat.ClientID %>').text("ST");
                           }
                           else {
                               $('#<%=ddlSpecialCat.ClientID %>').text("OBC");
                           }

                             $('#<%=ddlDistrict.ClientID %>').text(response.d['EnglishName']);
                             $('#tblOffice').find('tr').find('input[type=radio]').prop("checked", false);
                             $('#tblOffice').find('tr').find('input[id=' + response.d['OfficeKey'] + ']').prop("checked", true);


                             var date = new Date(parseInt(response.d['DOB'].substr(6)));
                             $('#<%=txtDOB.ClientID %>').text(date.getDate() + '/' + ((date.getMonth() + 1) < 10 ? '0' + (date.getMonth() + 1) : (date.getMonth() + 1)) + '/' + date.getFullYear()).trigger('change').attr('disabled', true);


                           if (response.d['District_Flag'] > 0) {
                               $('#<%=chkDeclaration.ClientID %>').attr('disabled', true);
                        }
                        else {
                            $('#<%=chkDeclaration.ClientID %>').attr('disabled', false);
                        }
                             if (response.d['ApplicationStatus'] > 2) {
                                 $('#<%=chkDeclaration.ClientID %>').attr('disabled', true);
                               $('#<%=txtRemarkdetails.ClientID %>').attr('disabled', true);

                           }
                           else {
                               $('#<%=chkDeclaration.ClientID %>').attr('disabled', false);
                               $('#<%=txtRemarkdetails.ClientID %>').attr('disabled', false);
                           }
                             $('#<%=txtCommunicationHouseNo.ClientID %>').text(response.d['PostallAddress']).attr('disabled', true);
                             $('#<%=txtCommunicationPO.ClientID %>').text(response.d['PostOffice']).attr('disabled', true);

                             $('#<%=txtUnitVikasKhand.ClientID %>').text(response.d['BlockName']).attr('disabled', true);

                             $('#<%=txtUnitVillage.ClientID %>').text(response.d['Revenue_Village']).attr('disabled', true);

                             $('#<%=txtUnitPinCode.ClientID %>').text(response.d['PinNo']).attr('disabled', true);
                             $('#<%=txtUnitDistrict.ClientID %>').text(response.d['EnglishName']).attr('disabled', true);

                             $('#<%=txtMobileNo1.ClientID %>').text(response.d['MobileNo']).attr('disabled', true);
                             $('#<%=txtEMail.ClientID %>').text(response.d['EmailID']).attr('disabled', true);

                             $('#<%=lblschname2.ClientID %>').text(response.d['SchemeName']).attr('disabled', true);
                             $('#<%=txtActivityName.ClientID %>').text(response.d['SchemeName']).attr('disabled', true);
                             $('#<%=txtProductDescription.ClientID %>').text(response.d['detailsproposedwork']).attr('disabled', true);
                             $('#<%=txtplotno.ClientID %>').text(response.d['PlotNo']).attr('disabled', true);
                             $('#<%=txtProjectcost.ClientID %>').text(response.d['Project_cost']).attr('disabled', true);
                             $('#<%=txttotalLand.ClientID %>').text(response.d['totalland']).attr('disabled', true);
                             $('#<%=txtTotalwaterarea.ClientID %>').text(response.d['totalwaterarea']).attr('disabled', true);
                             $('#<%=txtBeneficary.ClientID %>').text(response.d['Beneficiaries_share']).attr('disabled', true);
                             $('#<%=txtSubsidary.ClientID %>').text(response.d['Total_Subsidy_Amount']).attr('disabled', true);
                             $('#<%=txtcentralshare.ClientID %>').text(response.d['Central_share']).attr('disabled', true);
                             $('#<%=txtstateshare.ClientID %>').text(response.d['State_share']).attr('disabled', true);
                             $('#<%=txtcentralshare.ClientID %>').text(response.d['Central_share']).attr('disabled', true);
                             $('#<%=txtstateshare.ClientID %>').text(response.d['State_share']).attr('disabled', true);
                             $('#<%=txtApplicantExperience.ClientID %>').text(response.d['Applicant_Experience']).attr('disabled', true);
                             $('#<%=txtdetailEconomics.ClientID %>').text(response.d['Details_economics']).attr('disabled', true);

                             $('#<%=ddlFirstFinancingBank.ClientID %>').text(response.d['BankName'])
                             $('#<%=txtFirstFinancingIFSCCode.ClientID %>').text(response.d['UserBankIFSC']);
                             $('#<%=txtFirstFinancingBranchName.ClientID %>').text(response.d['BranchName']);
                             $('#<%=txtFirstFinancingAddress.ClientID %>').text(response.d['Address']);
                             $('#<%=txtFirstFinancingDistrict.ClientID %>').text(response.d['EnglishName']);
                             $('#<%=hidBranch.ClientID %>').text(response.d['FirstFinancingBankDetailKey']);

                             $('#btnCopyAddr').hide();
                             $('#btnIndustryType').hide();
                             $('#btnIFSSearch').hide();
                             $('#btnAppUpdate').hide();
                             $('#divApplicationUpdatePopup').modal('show');
                         },
                         error: function (err) {
                             alert(err.statusText)
                         }

                     });
                 } else {
                     $.ajax({
                         type: "POST",
                         url: "StatusUpdate.aspx/getApplicationDetail",
                         data: '{q:"' + $(obj).attr('data-key') + '"}',
                         contentType: "application/json; charset=utf-8",
                         dataType: "json",
                         success: function (response) {


                             $('#<%=txtName.ClientID %>').val($(row).find('td:eq(2)').text().trim()).attr('disabled', false);
                           $('#<%=ddlGender.ClientID %>').val(response.d['Gender']).attr('disabled', false);

                           $('#<%=ddlDistrict.ClientID %>').val(response.d['DistrictNo']).trigger('change').attr('disabled', false);
                           $('#tblOffice').find('tr').find('input[type=radio]').prop("checked", false);
                           $('#tblOffice').find('tr').find('input[id=' + response.d['OfficeKey'] + ']').prop("checked", true);

                           var date = new Date(parseInt(response.d['DOB'].substr(6)));
                           $('#<%=txtDOB.ClientID %>').val(date.getDate() + '/' + ((date.getMonth() + 1) < 10 ? '0' + (date.getMonth() + 1) : (date.getMonth() + 1)) + '/' + date.getFullYear()).trigger('change').attr('disabled', false);
                        $('#<%=ddlSocialCat.ClientID %>').val(response.d['SocialCategory']).attr('disabled', false);
                           $('#<%=ddlSpecialCat.ClientID %>').val(response.d['SpecialCategory']).attr('disabled', false);

                           $('#<%=txtCommunicationHouseNo.ClientID %>').val(response.d['CommunicationHouseNo']).attr('disabled', false);

                           $('#<%=txtCommunicationPO.ClientID %>').val(response.d['CommunicationPO']).attr('disabled', false);

                           $('#<%=txtUnitVillage.ClientID %>').val(response.d['UnitVillage']).attr('disabled', false);

                           $('#<%=txtUnitVikasKhand.ClientID %>').val(response.d['UnitVikasKhand']).attr('disabled', false);
                           $('#<%=txtUnitPinCode.ClientID %>').val(response.d['UnitPinCode']).attr('disabled', false);

                           $('#<%=txtMobileNo1.ClientID %>').val(response.d['MobileNo1']).attr('disabled', false);

                           $('#<%=txtEMail.ClientID %>').val(response.d['EMail']).attr('disabled', false);
                           $('#<%=lblschname2.ClientID %>').text(response.d['SchemeName']).attr('disabled', true);

                           $('#<%=txtActivityName.ClientID %>').val(response.d['SchemeName']).attr('disabled', true);
                           $('#<%=txtProductDescription.ClientID %>').val(response.d['ProductDescription']).attr('disabled', false);

                           $('#<%=ddlFirstFinancingBank.ClientID %>').val(response.d['UserBankName']).attr('disabled', false);

                           $('#<%=txtFirstFinancingIFSCCode.ClientID %>').val(response.d['UserBankIFSC']);
                           $('#<%=txtFirstFinancingBranchName.ClientID %>').val(response.d['FirstFinancingBranchName']);
                           $('#<%=txtFirstFinancingAddress.ClientID %>').val(response.d['BranchName']);
                           $('#<%=txtFirstFinancingDistrict.ClientID %>').val(response.d['EnglishName']);
                           $('#<%=hidBranch.ClientID %>').val(response.d['FirstFinancingBankDetailKey']);

                           $('#btnCopyAddr').show();
                           $('#btnIndustryType').show();
                           $('#btnIFSSearch').show();
                           $('#btnAppUpdate').show();
                       },
                       error: function (err) {
                           alert(err.statusText)
                       }

                   });
               }
           }
    </script>
    <script type="text/javascript">

        //*************************************************************************************//
        function IntSubmit() {

            if (!confirm('Do you want to update Interaction Detail?')) {
                return false;
            }
            var rblMode = $('#<%=rblMode.ClientID %>').find(":checked").val();
            var txtIntOfficerName = $('#txtIntOfficerName').val();
            var txtIntDesignation = $('#txtIntDesignation').val();
            var txtIntDate = $('#txtIntDate').val();
            var txtIntTime = $('#txtIntTime').val();
            var txtIntDetail = $('#txtIntDetail').val();

            // var appno = $('#<%=lblApplicationNo.ClientID %>').val();
            var appno = $('#<%=lblApplicationNo.ClientID %>').text();

            if ((rblMode == null || rblMode.length <= 0) || txtIntOfficerName.length <= 0 || txtIntDesignation.length <= 0 || txtIntTime.length <= 0) {
                alert('Enter all required fields.');
                return;
            }
            var InteractionDetail = {};
            InteractionDetail.ApplicationNo = appno;
            InteractionDetail.InteractionMode = rblMode;
            InteractionDetail.OfficerName = txtIntOfficerName;
            InteractionDetail.Designation = txtIntDesignation;
            InteractionDetail.InteractionDate = txtIntDate;
            InteractionDetail.InteractionTime = txtIntTime;
            InteractionDetail.InteractionRemark = txtIntDetail;
            $.ajax({
                type: "POST",
                url: "StatusUpdate.aspx/SaveInteraction",
                data: '{objInteractionDetail: ' + JSON.stringify(InteractionDetail) + '}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    data = JSON.parse(response.d);
                    if (data['Success'] == '1' && parseInt(data['Key']) > 0) {
                        alert(data['Message'])
                        fillInteractionDetail(InteractionDetail.ApplicationNo);
                        $('#<%=rblMode.ClientID %>').removeAttr('checked');
                          $('#txtIntOfficerName').val('');
                          $('#txtIntDesignation').val('');
                          $('#txtIntDate').val('');
                          $('#txtIntTime').val('');
                          $('#txtIntDetail').val('');
                      } else {
                          alert(data['Message'])
                      }
                  },
                  error: function (err) {
                      alert(err.statusText)
                  }

              });
          }

          function ShowStatusUpdate(obj) {
              jQuery.noConflict();
              var row = $(obj).parent('div').parent('td').parent('tr');
              $('#txtStatusAgencyRemark').val('');

              $.ajax({
                  type: "POST",
                  url: "StatusUpdate.aspx/getApplicationDetail",
                  data: '{q:"' + $(obj).attr('data-key') + '"}',
                  contentType: "application/json; charset=utf-8",
                  dataType: "json",
                  success: function (response) {
                      var cxx = response.d['District_Flag']


                      if (cxx == 1) {
                          $('#<%=verifyform.ClientID %>').text("Verify Application");
                      }
                      else if (cxx == 2) {
                          $('#<%=verifyform.ClientID %>').text("Verify Application");
                          $('#<%=verifydoc.ClientID %>').text("Verify Attachment");
                      }
                      else {
                          $('#<%=verifyform.ClientID %>').text(" Not Verify Application");
                          $('#<%=verifydoc.ClientID %>').text("Not Verify Attachment");
                      }
                  }
              });

          $('#<%=lblStatusApplicationNo.ClientID %>').text($(row).find('td:eq(1)').text());
              $('#<%=lblStatusApplicantName.ClientID %>').text($(row).find('td:eq(2)').text());
              $('#<%=lblschname1.ClientID %>').text($(row).find('td:eq(3)').text());
              $('#<%=lblStatusSubmissionDate.ClientID %>').text($(row).find('td:eq(4)').text());
              $('#<%=lblStatusAadhaar.ClientID %>').text($(row).find('input[id=hidAadhar]').val());
              $('#<%=lblStatusEmail.ClientID %>').text($(row).find('input[id=hidEMail]').val());
              $('#<%=lblStatusMobile.ClientID %>').text($(row).find('input[id=hidMobile]').val());
              fillCurrentStatus($(obj).attr('data-key'));

              $('#divStatusUpdatePopup').modal('show');
          }

          function viewdocs(obj) {

              jQuery.noConflict();
              var row = $(obj).parent('div').parent('td').parent('tr');

              $('#<%=Applicationdocid.ClientID %>').text($(row).find('td:eq(1)').text());

              var appno1 = $(obj).attr('data-key');
              alert(appno1);

              $.ajax({
                  type: "POST",
                  url: "StatusUpdate.aspx/getApplicationDetail",
                  data: '{q:"' + $(obj).attr('data-key') + '"}',
                  contentType: "application/json; charset=utf-8",
                  dataType: "json",
                  success: function (response) {
                      var cxx = response.d['District_Flag']
                      alert(cxx);

                      if (cxx > 1) {
                          $('#<%=chkDeclaration1.ClientID %>').attr('disabled', true);
                      }
                      else {
                          $('#<%=chkDeclaration1.ClientID %>').attr('disabled', false);
                      }
                      var cxy = response.d["ApplicationStatus"]
                      if (cxy > 2) {
                          $('#<%=chkDeclaration1.ClientID %>').attr('disabled', true);
                          $('#<%=remarkviewdoc.ClientID %>').attr("disabled", true);
                      }
                      else {
                          $('#<%=chkDeclaration1.ClientID %>').attr('disabled', false);
                          $('#<%=remarkviewdoc.ClientID %>').attr("disabled", false);
                      }
                      $('#<%=lblScheme3.ClientID %>').text(response.d["SchemeName"]);
                  }
              });

              var readonly = true;
              appno = appno1;
              $('#tblDoc tbody tr').remove();
              $.ajax({
                  type: "POST",
                  url: "StatusUpdate.aspx/getDocumentDetail",
                  data: '{q:"' + appno + '"}',
                  contentType: "application/json; charset=utf-8",
                  dataType: "json",
                  success: function (r) {
                      if (r.d.length > 0) {
                          var row = '';
                          if (readonly) {
                              $('#tblDoc thead th:eq(2)').hide();
                              $('#btnDocUpdate').hide();
                              //row = ' <thead><tr><th style="align:Left">Document Type</th><th style="align:Left">Document Name</th><th style="align:Left">View</th></tr> </thead>';
                              //$("#tblDoc th").append(row);
                              for (var i = 0; i < r.d.length; i++) {
                                  row = '<tr><td class="text-center"><label id="lbldocname">' + r.d[i].documentname + '</label></td><td class="text-center"><label id="lblDocTitle">' + r.d[i].FileName + '</label></td><td class="text-center"><a data-placement="top" href="../<%=DBLayer.applicantuploaddoc %>/' + r.d[i].FileName + '" data-original-title="Click to view document" class="btn btn-primary tooltips btn-xs ' + ((r.d[i].FileName.length > 0) ? '' : 'hidden') + '" target="_blank"><i class="glyphicon glyphicon-upload"></i><span>View</span></a></td></tr>';
                                  $('#<%= remarkviewid.ClientID %>').text(r.d[i].ApplicationKey)
                                  $("#tblDoc tbody").append(row);

                              }
                          } else {
                              $('#tblDoc thead th:eq(2)').show();
                              $('#btnDocUpdate').show();
                              for (var i = 0; i < r.d.length; i++) {

                                  row = '<tr><td><label id="lblDocTitle">' + r.d[i].DocumentTitle + '</label></td><td><a data-placement="top" href="../<%=DBLayer.applicantuploaddoc %>/' + r.d[i].FileName + '" data-original-title="Click to view document" class="btn btn-primary tooltips btn-xs ' + ((r.d[i].FileName.length > 0) ? '' : 'hidden') + '" target="_blank"><i class="glyphicon glyphicon-upload"></i><span>View</span></a></td><td><input type="file" id="DocFileUpload" class="file-input" /><input type="hidden" id="doc" value=' + r.d[i].DocumentKey + ' /></td></tr>';

                                  $("#tblDoc tbody").append(row);
                              }

                          }
                      }
                  }
              });
              $('#divDocUpdatePopup').attr('data-key', $(this).attr('data-key')).modal('show');
          }

          function UpdateRejectionwithremark() {
              if (!confirm('Do you want to update Application Attachment Status?')) {
                  return false;
              }
              else {

                  var x = $('#<%= remarkviewid.ClientID %>').text();
                      var rem = $('#<%= remarkviewdoc.ClientID %>').text();
                      var chk1 = "";
                      if (!($('#<%=chkDeclaration1.ClientID %>').is(':checked'))) {
                      chk1 = 1;

                      if (rem == "") {
                          alert("Please fill remark");
                          return;
                      }
                      else {
                          var StatusDetail = {};
                          StatusDetail.ApplicationNo = x
                          StatusDetail.StatusKey = '16';
                          StatusDetail.Remark = rem;

                          $.ajax({
                              type: "POST",
                              url: "StatusUpdate.aspx/SaveCurrentStatus",
                              data: '{objStatusDetail: ' + JSON.stringify(StatusDetail) + '}',
                              contentType: "application/json; charset=utf-8",
                              dataType: "json",
                              success: function (response) {
                                  data = JSON.parse(response.d);
                                  if (data['Success'] == '1') {
                                      alert(data['Message'])
                                      window.location.href = "StatusUpdate.aspx";
                                  } else {
                                      alert(data['Message']);

                                  }
                              },
                              error: function (err) {
                                  alert(err.statusText)
                              }
                          });
                      }
                  }
                  else {
                      chk1 = 2;
                      var ApplicantSchemeRegistration = {};

                      ApplicantSchemeRegistration.ApplicationNo = x
                      ApplicantSchemeRegistration.District_Flag = '1';

                      $.ajax({
                          type: "POST",
                          url: "StatusUpdate.aspx/SavecheckStatus",
                          data: '{objStatusDetail: ' + JSON.stringify(ApplicantSchemeRegistration) + '}',
                          contentType: "application/json; charset=utf-8",
                          dataType: "json",
                          success: function (response) {
                              data = JSON.parse(response.d);
                              if (data['Success'] == '1') {
                                  alert(data['Message'])
                                  window.location.href = "StatusUpdate.aspx";
                              } else {
                                  alert(data['Message']);

                              }
                          },
                          error: function (err) {
                              alert(err.statusText)
                          }
                      });
                  }
              }
          }

          function UpdateStatus() {
              if (!confirm('Do you want to update Application Status?')) {
                  return false;
              }
              var xx = $('#<%= verifyform.ClientID %>').text();

             var yy = $('#<%= verifydoc.ClientID %>').text();
             if (xx == "Not Verify") {
                 alert('Kindly verify application');
                 return false;
             }
             if (yy == "Not Verify") {
                 alert('Kindly verify Document Attachment');
                 return false;
             }

             var rblstatus = $('input[name=rblstatus]:checked').val();
             var txtStatusAgencyRemark = $('#txtStatusAgencyRemark').val();
             //                var txtExpectedResolvingDate = $('#txtExpectedResolvingDate').val();
             if ((rblstatus == null || rblstatus.length <= 0) || txtStatusAgencyRemark.length <= 0) {
                 alert('Enter all required fields.');
                 return;
             }
             var tempExpectedResolvingDate = $('#txtExpectedResolvingDate').val().split('/');

             if (rblstatus == '13' && (tempExpectedResolvingDate == null || tempExpectedResolvingDate.length < 3)) {
                 alert('Select Expected Date to Resubmit Application.');
                 return;
             }
             txtExpectedResolvingDate = tempExpectedResolvingDate[1] + '/' + tempExpectedResolvingDate[0] + '/' + tempExpectedResolvingDate[2];
             var StatusDetail = {};
             var appno = $('#<%=lblStatusApplicationNo.ClientID %>').text();
              StatusDetail.ApplicationNo = appno
              StatusDetail.StatusKey = rblstatus;
              StatusDetail.Remark = txtStatusAgencyRemark;
              if (rblstatus == '13')
                  StatusDetail.DocReceiveDate = txtExpectedResolvingDate;
              else
                  StatusDetail.DocReceiveDate = '01/01/0001';
              <%-- StatusDetail.ApplicationNo = $('#<%=lblStatusApplicationNo.ClientID %>').text();--%>

             $.ajax({
                 type: "POST",
                 url: "StatusUpdate.aspx/SaveCurrentStatus",
                 data: '{objStatusDetail: ' + JSON.stringify(StatusDetail) + '}',
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: function (response) {
                     data = JSON.parse(response.d);
                     if (data['Success'] == '1') {
                         alert(data['Message'])
                         window.location.href = "StatusUpdate.aspx";
                     } else {
                         alert(data['Message']);

                     }
                 },
                 error: function (err) {
                     alert(err.statusText)
                 }
             });
             if (rblstatus == '3') {

                 var fileUpload1 = "";
                 var files1 = "";
                 var count1 = 1;
                 var data1 = new FormData();
                 data1.append("Key1", appno);
                 data1.append("UKey1", '1');
                 if ($("#fuDoc1").length > 0) {
                     fileUpload1 = $("#fuDoc1");
                     files1 = fileUpload1.get(0).files;
                     if (files1.length > 0) {
                         data1.append(files1[0].name, files1[0]);

                     } else {

                         return false;
                     }
                 }
                 $.ajax({
                     url: "DVIOOtherHandler.ashx",
                     type: "POST",
                     data: data1,
                     contentType: false,
                     processData: false,

                     success: function (data1) {
                         alert(data1);
                         if (data1 == 'Sattus Updated Successfully!') {
                             window.location.href = "StatusUpdate.aspx";
                         }
                     },
                     error: function (err) {
                         alert(err.statusText);
                     }
                 });

                 var fileUpload = "";
                 var files = "";
                 var count = 1;
                 var data = new FormData();
                 data.append("Key", appno);
                 data.append("UKey", '1');
                 if ($("#fuDoc").length > 0) {
                     fileUpload = $("#fuDoc");
                     files = fileUpload.get(0).files;
                     if (files.length > 0) {
                         data.append(files[0].name, files[0]);
                     } else {
                         alert('No Document Found');
                         return false;
                     }
                 }
                 $.ajax({
                     url: "DVIOHandler.ashx",
                     type: "POST",
                     data: data,
                     contentType: false,
                     processData: false,

                     success: function (data) {
                         alert(data);
                         if (data == 'Status Updated Successfully!') {
                             window.location.href = "StatusUpdate.aspx";
                         }
                     },
                     error: function (err) {
                         alert(err.statusText);
                     }
                 });
             }
         }

         function SetInteractionData(obj) {
             jQuery.noConflict();
             var row = $(obj).parent('div').parent('td').parent('tr');

             $('#<%=rblMode.ClientID %>').removeAttr('checked');
              $('#txtIntOfficerName').val('');
              $('#txtIntDesignation').val('');
              $('#txtIntDate').val('');
              $('#txtIntTime').val('');
              $('#txtIntDetail').val('');

              $('#<%=lblApplicationNo.ClientID %>').text($(row).find('td:eq(1)').text());
              $('#<%=lblApplicantName.ClientID %>').text($(row).find('td:eq(2)').text());
              $('#<%=lblScheme4.ClientID %>').text($(row).find('td:eq(3)').text());
              $('#<%=lblCategory.ClientID %>').text($(row).find('td:eq(4)').text());
              $('#<%=lblAadhaar.ClientID %>').text($(row).find('input[id=hidAadhar]').val());
              $('#<%=lblEmail.ClientID %>').text($(row).find('input[id=hidEMail]').val());
              $('#<%=lblMobile.ClientID %>').text($(row).find('input[id=hidMobile]').val());

              fillInteractionDetail($(row).find('td:eq(1)').text());
              $('#responsive').modal('show');
          }

          function fillInteractionDetail(q) {
              var tbl = $('#tblInteractionDetail');
              $(tbl).find('tbody').empty();
              $.ajax({
                  type: "POST",
                  url: "StatusUpdate.aspx/getInteractionDetail",
                  data: '{q:"' + q + '"}',
                  contentType: "application/json; charset=utf-8",
                  dataType: "json",
                  success: function (r) {
                      if (r.d.length > 0) {
                          var row = '';
                          for (var i = 0; i < r.d.length; i++) {
                              row = row + ('<tr><td>' + (i + 1) + '</td><td>' + r.d[i].InteractionModeText + '</td><td>' + r.d[i].OfficerName + '</td><td>' + r.d[i].Designation + '</td><td>' + (r.d[i].InteractionDate + ' ' + r.d[i].InteractionTime) + '</td><td>' + r.d[i].InteractionRemark + '</td></tr>');
                          }
                          $(tbl).find('tbody').append(row);
                      }
                  }
              });
          }

          function fillCurrentStatus(q) {
              var divstatus = $('#divstatus');
              $(divstatus).html('');
              $.ajax({
                  type: "POST",
                  url: "StatusUpdate.aspx/getCurrentStatus",
                  data: '{q:"' + q + '"}',
                  contentType: "application/json; charset=utf-8",
                  dataType: "json",
                  success: function (r) {
                      if (r.d.length > 0) {
                          var row = '';
                          for (var i = 0; i < r.d.length; i++) {
                              row = row + ('<label class="text-black padding-5"><input type="radio" name="rblstatus" value="' + r.d[i].StatusKey + '"/> </label>' + r.d[i].StatusText);
                          }
                          $(divstatus).append(row);
                      }
                  }
              });
              $.ajax({
                  type: "POST",
                  url: "StatusUpdate.aspx/getCurrentFlag",
                  data: '{q:"' + q + '"}',
                  contentType: "application/json; charset=utf-8",
                  dataType: "json",
                  success: function (r) {
                      if (r.d.length > 0) {
                          var row = '';
                          alert(r.d[0].District_Flag)
                          if (r.d[0].District_Flag == 1) {
                              $('#<%= verifyform.ClientID %>').text("Already Verify");

                          }
                          else if (r.d[0].District_Flag == 2) {
                              $('#<%= verifyform.ClientID %>').text("Already Verify");
                              $('#<%= verifydoc.ClientID %>').text("Already Verify");
                          }
                          else {
                              $('#<%= verifyform.ClientID %>').text("Not Verify");
                              $('#<%= verifydoc.ClientID %>').text("Not Verify");
                          }
                     }

                  }
              });

      }
      function printform() {
          var x = $('#<%= txtaadharno.ClientID %>').text();
    alert(x);
    var win = window.open('PrintApplicantForm.aspx?appno=' + x, '_blank');
    win.focus();
}

function Updatestatusapplicant() {
    if (!confirm('Do you want to update Or Verify Application View?')) {
        return false;
    }

    else {
        var x = $('#<%= txtaadharno.ClientID %>').text();
                  var chk1 = "";
                  if (!($('#<%=chkDeclaration.ClientID %>').is(':checked'))) {
                      chk1 = 1;
                      var rem = $('#<%= txtRemarkdetails.ClientID %>').val();

                      if (rem == "") {
                          alert("Please fill remark");
                          return;
                      }
                      else {
                          var StatusDetail = {};
                          StatusDetail.ApplicationNo = x
                          StatusDetail.StatusKey = '15';
                          StatusDetail.Remark = rem;

                          $.ajax({
                              type: "POST",
                              url: "StatusUpdate.aspx/SaveCurrentStatus",
                              data: '{objStatusDetail: ' + JSON.stringify(StatusDetail) + '}',
                              contentType: "application/json; charset=utf-8",
                              dataType: "json",
                              success: function (response) {
                                  data = JSON.parse(response.d);
                                  if (data['Success'] == '1') {
                                      alert(data['Message'])
                                      window.location.href = "StatusUpdate.aspx";
                                  } else {
                                      alert(data['Message']);

                                  }
                              },
                              error: function (err) {
                                  alert(err.statusText)
                              }
                          });
                      }
                  }
                  else {
                      chk1 = 2;
                      var ApplicantSchemeRegistration = {};

                      ApplicantSchemeRegistration.ApplicationNo = x
                      ApplicantSchemeRegistration.District_Flag = '1';

                      $.ajax({
                          type: "POST",
                          url: "StatusUpdate.aspx/SavecheckStatus",
                          data: '{objStatusDetail: ' + JSON.stringify(ApplicantSchemeRegistration) + '}',
                          contentType: "application/json; charset=utf-8",
                          dataType: "json",
                          success: function (response) {
                              data = JSON.parse(response.d);
                              if (data['Success'] == '1') {
                                  alert(data['Message'])
                                  window.location.href = "StatusUpdate.aspx";
                              } else {
                                  alert(data['Message']);

                              }
                          },
                          error: function (err) {
                              alert(err.statusText)
                          }
                      });
                  }
              }

          }

          //**************************************END : APPLICATION UPDATE *****************************************//
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="boxed">
        <!--CONTENT CONTAINER-->
        <!--===================================================-->
        <div id="content-container">
            <!--Page Title-->
            <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
            <div class="pageheader hidden-xs">
                <h3><i class="fa fa-home"></i>Online Scheme Status Pannel </h3>
                <div class="breadcrumb-wrapper">
                    <span class="label">You are here:</span>
                    <ol class="breadcrumb">
                        <li><a href="#">Home </a></li>
                        <li class="active">Scheme </li>
                    </ol>
                </div>
            </div>
            <br />
            <br />
            <!-- end: TOOLBAR -->
            <!-- end: PAGE HEADER -->
            <!-- start: BREADCRUMB -->
            <div class="row">
                <div class="space30">
                </div>
            </div>
            <!-- end: BREADCRUMB -->
            <!-- start: PAGE CONTENT -->
            <div class="row">
                <div class="col-md-12">
                    <div class="panel">

                        <div class="panel-body">
                            <!-- Inline Form  -->
                            <!--===================================================-->

                            <table class="table table-bordered text-black">
                                <tbody>
                                    <tr>
                                        <td class="col-xs-2">
                                            <strong>Scheme Name</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:DropDownList ID="ddlScheme" runat="server" CssClass="form-control selectpicker" data-live-search="true" Width="295px">
                                            </asp:DropDownList>
                                        </td>
                                        <td class="col-xs-2">
                                            <strong>Status</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:DropDownList ID="ddlstatus" runat="server" CssClass="form-control selectpicker" data-live-search="true">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-2">
                                            <strong>From Date </strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:TextBox ID="txtFromdate" Type="date" CssClass="input-group-sm date" runat="server"></asp:TextBox>

                                        </td>
                                        <td class="col-xs-2">
                                            <strong>To Date</strong>
                                        </td>
                                        <td class="col-xs-4">

                                            <asp:TextBox ID="txtTodate" Type="date" CssClass="input-group-sm date" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" class="col-xs-12" style="text-align: center;">
                                            <asp:Button ID="Button2" class="btn btn-info" OnClientClick="search();" runat="server" Text="Search" OnClick="Button2_Click" />
                                        </td>

                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <!--===================================================-->
                        <!-- End Inline Form  -->
                    </div>

                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="row">
                        <div class="col-md-12">
                            <!-- start: DYNAMIC TABLE PANEL -->
                            <div class="panel panel-white">
                                <div class="panel-body">
                                    <asp:Repeater runat="server" ID="rptApplication">
                                        <HeaderTemplate>
                                            <table class="table table-striped table-bordered table-hover table-full-width text-black"
                                                id="sample_1">
                                                <thead>
                                                    <tr class="info">
                                                        <th style="width: 5%;" class="text-center">S.No.
                                                        </th>
                                                        <th style="width: 10%" class="text-center">Application ID
                                                        </th>
                                                        <th style="width: 15%" class="text-center">Name
                                                        </th>
                                                        <th style="width: 15%" class="text-center">Scheme Name
                                                        </th>
                                                        <th style="width: 8%" class="text-center">Submission Date
                                                        </th>
                                                        <th style="width: 9%" class="text-center">Online Application
                                                        </th>
                                                        <th style="width: 8%" class="text-center">Interaction Detail
                                                        </th>
                                                        <th style="width: 9%" class="text-center">Update Date
                                                        </th>
                                                        <th style="width: 10%" class="text-center">Current Status /<br />
                                                            Application Status
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <td style="width: 5%" class="text-center">
                                                    <%# Container.ItemIndex+1 %>
                                                </td>
                                                <td style="width: 10%" class="text-center">
                                                    <%-- <input type="hidden" value='<%# ((SocialCategory)Convert.ToInt16(DataBinder.Eval(Container.DataItem,"SocialCategory"))).ToString().Replace("_"," ") %>'
                                                    id="hidCategory" />--%>
                                                    <input type="hidden" value='<%# DataBinder.Eval(Container.DataItem,"AadharNo") %>' id="hidAadhar" />
                                                    <input type="hidden" value='<%# DataBinder.Eval(Container.DataItem,"EmailID") %>' id="hidEMail" />
                                                    <input type="hidden" value='<%# DataBinder.Eval(Container.DataItem,"MobileNo") %>' id="hidMobile">

                                                    <%# DataBinder.Eval(Container.DataItem,"ApplicationNo") %>
                                                </td>
                                                <td style="width: 10%" class="text-center">
                                                    <%# DataBinder.Eval(Container.DataItem,"Name") %>
                                                </td>
                                                <td style="width: 8%" class="text-center">
                                                    <%# DataBinder.Eval(Container.DataItem,"SchemeName") %>
                                                </td>
                                                <td style="width: 8%" class="text-center">
                                                    <%# GeneralClass.GetDateForUI(DataBinder.Eval(Container.DataItem,"CreatedOn")) %>
                                                </td>

                                                <td style="width: 15%" class="text-center">
                                                    <a id="lnkAppView" name="lnkAppView" href="javascript:void(0)" data-toggle="modal" onclick='setApplicationData(this);'
                                                        data-key='<%# DataBinder.Eval(Container.DataItem,"ApplicationNo") %>' class="btn-info ">View Form</a>

                                                    <%--&nbsp;|&nbsp;<a name="lnkAppUpdate" href="javascript:void(0)" data-toggle="modal"
                                                        data-key='<%# DataBinder.Eval(Container.DataItem,"ApplicationKey") %>' class="btn-xs btn-green">Edit
                                                    </a>Form--%>
                                          &nbsp; &nbsp; &nbsp; 
                                                <a id="lnkDocView" name="lnkDocView" href="javascript:void(0)" onclick='viewdocs(this);' data-toggle="modal"
                                                    data-key='<%# DataBinder.Eval(Container.DataItem,"ApplicationNo") %>' class="btn-info ">View Docs</a>
                                                    <%--&nbsp;|&nbsp;<a name="lnkDocUpdate" href="javascript:void(0)" data-toggle="modal"
                                                        data-key='<%# DataBinder.Eval(Container.DataItem,"ApplicationKey") %>' class="btn-xs btn-green">Edit
                                                    </a>&nbsp;&nbsp;Docs.--%>
                                                </td>
                                                <td style="width: 5%" class="text-center">
                                                    <div class='<%# ((String.IsNullOrEmpty(DataBinder.Eval(Container.DataItem, "LevelFrom").ToString()) && String.IsNullOrEmpty(DataBinder.Eval(Container.DataItem, "LevelTo").ToString())) || (DataBinder.Eval(Container.DataItem, "LevelFrom").ToString()=="DVIO" && DataBinder.Eval(Container.DataItem, "LevelTo").ToString()=="DVIO") || (String.IsNullOrEmpty(DataBinder.Eval(Container.DataItem, "LevelFrom").ToString()) && DataBinder.Eval(Container.DataItem, "LevelTo").ToString()=="DVIO"))?"":"hidden"%>'>
                                                        <a name="lnkInteractionPopup" onclick="SetInteractionData(this);" href="javascript:void(0)" data-toggle="modal"
                                                            data-key='<%# DataBinder.Eval(Container.DataItem,"ApplicationNo") %>'
                                                            class="btn-info">Update </a>
                                                    </div>
                                                </td>
                                                <td style="width: 10%" class="text-center">
                                                    <%# DataBinder.Eval(Container.DataItem, "createdon")%>
                                                    <a href="javascript:void(0)" class="btn-info" onclick="openAck('<%# HttpUtility.UrlEncode(GeneralClass.Encrypt(DataBinder.Eval(Container.DataItem,"ApplicationNo").ToString())) %>')">Acknowledgment Letter</a>
                                                </td>
                                                <td style="width: 5%" align="center">
                                                    <%# DataBinder.Eval(Container.DataItem, "CurrentStatusText")%>
                                                    <div class='<%# ((String.IsNullOrEmpty(DataBinder.Eval(Container.DataItem, "LevelFrom").ToString()) && String.IsNullOrEmpty(DataBinder.Eval(Container.DataItem, "LevelTo").ToString())) || (DataBinder.Eval(Container.DataItem, "LevelFrom").ToString()=="DVIO" && DataBinder.Eval(Container.DataItem, "LevelTo").ToString()=="DVIO") || (String.IsNullOrEmpty(DataBinder.Eval(Container.DataItem, "LevelFrom").ToString()) && DataBinder.Eval(Container.DataItem, "LevelTo").ToString()=="DVIO"))?"":"hidden"%>'>
                                                        /<a href='javascript:void(0)' onclick='ShowStatusUpdate(this);' data-toggle='modal'
                                                            data-key='<%# DataBinder.Eval(Container.DataItem,"ApplicationNo") %>' class='btn-info'>
                                                        Update </a>
                                                    </div>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </tbody> </table>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                            <!-- end: DYNAMIC TABLE PANEL -->
                        </div>
                    </div>
                    <%-- </form>--%>
                </div>
            </div>
        </div>
    </div>
    <!-- start: Interaction Popup -->
    <div id="responsive" class="modal extended-modal fade no-display" tabindex="-1" data-width="950">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-green">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;</button>
                    <h4 class="modal-title">Interaction with Applicant (
                            <asp:Label ID="lblScheme4" runat="server"></asp:Label>
                        )</h4>
                </div>
                <div class="modal-body" style="padding-bottom: 0px;">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="list-group-item list-group-item-warning">
                                <strong>About Applicant</strong>
                            </div>
                            <table class="table table-bordered text-black">
                                <tbody>
                                    <tr>
                                        <td class="col-xs-2">
                                            <strong>Application ID</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="lblApplicationNo" runat="server" class="control-lable">
                                            </asp:Label>
                                        </td>
                                        <td class="col-xs-2">
                                            <strong>Applicant Name</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="lblApplicantName" class="control-lable" runat="server"></asp:Label>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-2">
                                            <strong>Aadhaar No. </strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="lblAadhaar" runat="server" class="control-lable">
                                            </asp:Label>
                                        </td>
                                        <td class="col-xs-2">
                                            <strong>Category</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="lblCategory" runat="server" class="control-lable">
                                            </asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-2">
                                            <strong>Mobile No. </strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="lblMobile" runat="server" class="control-lable">
                                            </asp:Label>
                                        </td>
                                        <td class="col-xs-2">
                                            <strong>Email ID</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="lblEmail" runat="server" class="control-lable">
                                            </asp:Label>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="panel panel-lightPink no-padding">
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-md-2">
                                            <strong>Interaction Mode:<span class="symbol required"></span></strong>
                                        </div>
                                        <div class="col-md-10">
                                            <asp:RadioButtonList runat="server" ID="rblMode" RepeatLayout="Table" ForeColor="Black"
                                                Font-Bold="true" CssClass="text-bold text-black" Width="100%" RepeatDirection="Horizontal">
                                            </asp:RadioButtonList>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            &nbsp;
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-2">
                                        <strong>Nodal Officer Name:<span class="symbol required"></span></strong>
                                    </div>
                                    <div class="col-md-4">
                                        <input class="form-control" type="text" id="txtIntOfficerName" />
                                    </div>
                                    <div class="col-md-2">
                                        <strong>Designation:<span class="symbol required"></span></strong>
                                    </div>
                                    <div class="col-md-4">
                                        <input class="form-control" type="text" id="txtIntDesignation" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        &nbsp;
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-2">
                                        <strong>Interaction Date Time :<span class="symbol required"></span></strong>
                                    </div>
                                    <div class="col-md-10">
                                        <div class="col-md-3 input-group pull-left">
                                            <input type="text" data-date-format="dd-mm-yyyy" placeholder="DD-MMM-yyyy" data-date-viewmode="years" id="txtIntDate"
                                                class="form-control date-picker" />
                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                        </div>
                                        <div class="col-md-1">
                                        </div>
                                        <div class="col-md-3 pull-left input-group input-append bootstrap-timepicker">
                                            <input type="text" class="form-control time-picker" id="txtIntTime" />
                                            <span class="input-group-addon add-on"><i class="fa fa-clock-o"></i></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        &nbsp;
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-2">
                                        <strong>Interaction Detail :<span class="symbol required"></span></strong>
                                    </div>
                                    <div class="col-md-10">
                                        <textarea class="form-control" id="txtIntDetail"></textarea>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer" style="padding: 5px;">
                                <button type="button" data-dismiss="modal" class="btn btn-dark-beige">
                                    Close
                                </button>
                                <button type="button" onclick="IntSubmit();" class="btn btn-dark-azure" id="btnIntSubmit">
                                    Submit
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer no-padding">
                <div class="text-center">
                    <h5 class="text-bold text-black">INTERACTION WITH APPLICANT</h5>
                </div>
                <div>
                    <table class="table table-bordered text-black text-left" id="tblInteractionDetail">
                        <thead>
                            <tr class="active">
                                <th class="text-center">SNo.
                                </th>
                                <th class="text-center">Interaction Mode
                                </th>
                                <th class="text-center">Nodal Officer Name
                                </th>
                                <th class="text-center">Designation
                                </th>
                                <th class="text-center">Interaction Date and Time
                                </th>
                                <th class="text-center">Interaction Detail
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <!-- end: Interacion Popup -->
    <!-- start: Status Update Popup -->
    <div id="divStatusUpdatePopup" class="modal extended-modal fade no-display" tabindex="-1"
        data-width="950">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-green">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title">Applicant Current Status Update by District (
                            <asp:Label ID="lblschname1" runat="server"></asp:Label>
                        )</h4>
                </div>
                <div class="modal-body" style="padding-bottom: 0px;">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="list-group-item list-group-item-warning">
                                <strong>About Applicant</strong>
                            </div>
                            <table class="table table-bordered text-black">
                                <tbody>
                                    <tr>
                                        <td class="col-xs-2">
                                            <strong>Application ID</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="lblStatusApplicationNo" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        <td class="col-xs-2">
                                            <strong>Applicant Name</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="lblStatusApplicantName" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-2">
                                            <strong>Aadhaar No. </strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="lblStatusAadhaar" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        <td class="col-xs-2">
                                            <strong>Online Submission Date</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="lblStatusSubmissionDate" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-2">
                                            <strong>Mobile No. </strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="lblStatusMobile" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        <td class="col-xs-2">
                                            <strong>Email ID</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="lblStatusEmail" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-2">
                                            <strong>Verify Application Form </strong>
                                        </td>
                                        <td class="col-xs-4">

                                            <asp:Label ID="verifyform" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                        <td class="col-xs-2">
                                            <strong>Verify Document</strong>
                                        </td>
                                        <td class="col-xs-4">
                                            <asp:Label ID="verifydoc" runat="server" CssClass="control-lable"></asp:Label>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="panel panel-lightPink no-padding">
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-md-3">
                                            <strong>Select Current Status:<span class="symbol required"></span></strong>
                                        </div>
                                        <div class="col-md-9" id="divstatus">
                                            <%--   <asp:RadioButtonList runat="server" ID="rblApplicationStatus" RepeatLayout="Table" ForeColor="Black"
                                                Font-Bold="true" CssClass="text-bold text-black" Width="100%" RepeatDirection="Horizontal">
                                            </asp:RadioButtonList>--%>
                                        </div>
                                    </div>
                                    <br />

                                    <div class="row" id="divIntResolvingDate" style="display: none">
                                        <div class="col-md-3">
                                            <strong>Expected Date to Resubmit:<span class="symbol required"></span></strong>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="input-group">
                                                <input type="text" class="form-control date-picker required" id="txtExpectedResolvingDate"
                                                    data-date-format="dd/mm/yyyy" data-date-viewmode="years" />
                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <b>Attach Survey Report </b><b style="color: #FF0000">*</b>
                                            <input type="file" class="form-control" id="fuDoc" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <b>Attach Other File</b>
                                            <input type="file" class="form-control" id="fuDoc1" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            &nbsp;
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-3">
                                            <strong>Remarks :<span class="symbol required"></span></strong>
                                        </div>
                                        <div class="col-md-9">
                                            <textarea class="form-control" id="txtStatusAgencyRemark"></textarea>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" data-dismiss="modal" class="btn btn-dark-beige">
                                        Close
                                    </button>
                                    <button type="button" class="btn btn-dark-azure" onclick="UpdateStatus();" id="btnUpdateStatus">
                                        Save Record
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- end: Status Update Popup -->
    <!-- start: Application Update Popup -->
    <div id="divApplicationUpdatePopup" class="modal extended-modal fade no-display"
        tabindex="-1" data-width="1200">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-gray">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title">Applicant Data View (
                            <asp:Label ID="lblschname2" runat="server"></asp:Label>
                        )</h4>
                </div>
                <div class="modal-body" style="padding-bottom: 0px;">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="panel panel-lightPink no-padding">
                                <div class="panel-body">
                                    <div class="form-horizontal" id="form">
                                        <div class="panel-body">
                                            <%-- <div class="row">
                                                <div class="panel-heading">
                                                    <h4 class="panel-title">
                                                        <span class="text-bold pull-left">CMEGP ONLINE APPLICATION </span><span class="text-bold pull-right panel-yellow">
                                                            <asp:Label runat="server" ID="lblApplicationKey"></asp:Label>
                                                        </span>
                                                    </h4>
                                                    <hr />
                                                </div>
                                            </div>--%>
                                            <div class="col-md-11">

                                                <div class="row">

                                                    <table class="table table-hover text-black">

                                                        <tbody>

                                                            <tr>
                                                                <td class="col-xs-2">
                                                                    <strong>Application ID</strong>
                                                                </td>
                                                                <td class="col-xs-4">
                                                                    <asp:Label ID="txtaadharno" CssClass="control-lable" runat="server"></asp:Label>

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
                                                                    <strong>Date of Birth</strong>
                                                                </td>
                                                                <td class="col-xs-4">

                                                                    <asp:Label runat="server" ID="txtDOB" CssClass="control-lable"
                                                                        data-date-format="dd/mm/yyyy" data-date-viewmode="years"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="col-xs-2">
                                                                    <strong>District</strong>
                                                                </td>
                                                                <td class="col-xs-4">
                                                                    <asp:Label ID="ddlDistrict" runat="server" CssClass="control-lable">kdlfjdklfjdslfk</asp:Label>
                                                                </td>
                                                                <td class="col-xs-2">
                                                                    <strong>Social Category</strong>
                                                                </td>
                                                                <td class="col-xs-4">
                                                                    <asp:Label ID="ddlSocialCat" runat="server" CssClass="control-lable">sdfkjdsklfjsdf</asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="col-xs-2">
                                                                    <strong>Gender</strong>
                                                                </td>
                                                                <td class="col-xs-4">
                                                                    <asp:Label ID="ddlGender" runat="server" CssClass="control-lable"></asp:Label>
                                                                </td>
                                                                <td class="col-xs-2">
                                                                    <strong>Special Category</strong>
                                                                </td>
                                                                <td class="col-xs-4">
                                                                    <asp:Label ID="ddlSpecialCat" runat="server" CssClass="control-lable"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="col-xs-2">
                                                                    <strong>Communication House No</strong>
                                                                </td>
                                                                <td class="col-xs-4">
                                                                    <asp:Label ID="txtCommunicationHouseNo" runat="server" CssClass="control-lable"></asp:Label>
                                                                </td>
                                                                <td class="col-xs-2">
                                                                    <strong>Village/Mohalla</strong>
                                                                </td>
                                                                <td class="col-xs-4">
                                                                    <asp:Label ID="txtUnitVillage" runat="server" CssClass="control-lable"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="col-xs-2">
                                                                    <strong>Post Office</strong>
                                                                </td>
                                                                <td class="col-xs-4">
                                                                    <asp:Label ID="txtCommunicationPO" runat="server" CssClass="control-lable"></asp:Label>
                                                                </td>
                                                                <td class="col-xs-2">
                                                                    <strong>Bloack Name</strong>
                                                                </td>
                                                                <td class="col-xs-4">
                                                                    <asp:Label ID="txtUnitVikasKhand" runat="server" CssClass="control-lable"></asp:Label>
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td class="col-xs-2">
                                                                    <strong>District</strong>
                                                                </td>
                                                                <td class="col-xs-4">
                                                                    <asp:HiddenField runat="server" ID="hidUnitDistrict" />

                                                                    <asp:Label ID="txtUnitDistrict" runat="server" CssClass="control-lable"></asp:Label>
                                                                </td>
                                                                <td class="col-xs-2">
                                                                    <strong>Pin</strong>
                                                                </td>
                                                                <td class="col-xs-4">
                                                                    <asp:Label ID="txtUnitPinCode" runat="server" CssClass="control-lable"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="col-xs-2">
                                                                    <strong>Mobile No</strong>
                                                                </td>
                                                                <td class="col-xs-4">
                                                                    <asp:Label ID="txtMobileNo1" runat="server" CssClass="control-lable"></asp:Label>
                                                                </td>
                                                                <td class="col-xs-2">
                                                                    <strong>Email</strong>
                                                                </td>
                                                                <td class="col-xs-4">
                                                                    <asp:Label ID="txtEMail" runat="server" CssClass="control-lable"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>


                                                </div>




                                                <div class="row">
                                                    <div class="list-group-item list-group-item-warning" style="padding-top: 4px; height: 30px; padding-bottom: 4px; font-size: 1.2em;">
                                                        Particular of project&nbsp;
                                                    </div>
                                                </div>
                                                <br />

                                                <div class="row">
                                                    <div class="modal-body" style="padding-bottom: 0px;">
                                                        <table class="table table-hover text-black">

                                                            <tbody>

                                                                <tr>
                                                                    <td class="col-xs-2">
                                                                        <strong>Scheme Name</strong>
                                                                    </td>
                                                                    <td colspan="3" class="col-xs-8">
                                                                        <asp:Label ID="txtActivityName" CssClass="control-lable" runat="server"></asp:Label>

                                                                    </td>

                                                                </tr>
                                                                <tr>
                                                                    <td class="col-xs-2">
                                                                        <strong>Details Proposed Work</strong>
                                                                    </td>
                                                                    <td colspan="3" class="col-xs-8">
                                                                        <asp:Label ID="txtProductDescription" CssClass="control-lable" runat="server"></asp:Label>

                                                                    </td>

                                                                </tr>
                                                                <tr>
                                                                    <td class="col-xs-2">
                                                                        <strong>Total Land</strong>
                                                                    </td>
                                                                    <td class="col-xs-4">
                                                                        <asp:Label ID="txttotalLand" CssClass="control-lable" runat="server"></asp:Label>

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
                                                                        <strong>Plot No</strong>
                                                                    </td>
                                                                    <td class="col-xs-4">
                                                                        <asp:Label ID="txtplotno" CssClass="control-lable" runat="server"></asp:Label>

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
                                                                        <strong>Beneficary Share</strong>
                                                                    </td>
                                                                    <td class="col-xs-4">
                                                                        <asp:Label ID="txtBeneficary" CssClass="control-lable" runat="server"></asp:Label>

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
                                                                        <strong>Central Share</strong>
                                                                    </td>
                                                                    <td class="col-xs-4">
                                                                        <asp:Label ID="txtcentralshare" CssClass="control-lable" runat="server"></asp:Label>

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
                                                                        <strong>Applicant Experience</strong>
                                                                    </td>
                                                                    <td colspan="3" class="col-xs-8">
                                                                        <asp:Label ID="txtApplicantExperience" CssClass="control-lable" runat="server"></asp:Label>

                                                                    </td>

                                                                </tr>
                                                                <tr>
                                                                    <td class="col-xs-2">
                                                                        <strong>Details Economics</strong>
                                                                    </td>
                                                                    <td colspan="3" class="col-xs-8">
                                                                        <asp:Label ID="txtdetailEconomics" CssClass="control-lable" runat="server"></asp:Label>

                                                                    </td>

                                                                </tr>
                                                            </tbody>
                                                        </table>


                                                    </div>
                                                </div>

                                                <br />
                                                <div class="row">
                                                    <div class="list-group-item list-group-item-warning" style="padding-top: 4px; height: 30px; padding-bottom: 4px; font-size: 1.2em;">
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
                                                                        <strong>Financing Bank</strong>
                                                                    </td>
                                                                    <td colspan="3" class="col-xs-8">
                                                                        <asp:Label ID="ddlFirstFinancingBank" CssClass="control-lable" runat="server"></asp:Label>

                                                                    </td>

                                                                </tr>
                                                                <tr>
                                                                    <td class="col-xs-2">
                                                                        <strong>IFS/Bank Code</strong>
                                                                    </td>
                                                                    <td class="col-xs-4">
                                                                        <asp:Label ID="txtFirstFinancingIFSCCode" CssClass="control-lable" runat="server"></asp:Label>
                                                                        <asp:HiddenField runat="server" ID="hidBranch" />
                                                                    </td>
                                                                    <td class="col-xs-2">
                                                                        <strong>Branch Name</strong>
                                                                    </td>
                                                                    <td class="col-xs-4">
                                                                        <asp:Label ID="txtFirstFinancingBranchName" CssClass="control-lable" runat="server"></asp:Label>
                                                                        <asp:HiddenField runat="server" ID="HiddenField1" />
                                                                    </td>
                                                                </tr>

                                                                <tr>
                                                                    <td class="col-xs-2">
                                                                        <strong>Address</strong>
                                                                    </td>
                                                                    <td colspan="3" class="col-xs-8">
                                                                        <asp:Label ID="txtFirstFinancingAddress" CssClass="control-lable" runat="server"></asp:Label>

                                                                    </td>

                                                                </tr>

                                                                <tr>
                                                                    <td class="col-xs-2">
                                                                        <strong>District</strong>
                                                                    </td>
                                                                    <td colspan="3" class="col-xs-8">
                                                                        <asp:Label ID="txtFirstFinancingDistrict" CssClass="control-lable" runat="server"></asp:Label>

                                                                    </td>

                                                                </tr>

                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>





                                                <br />

                                                <div class="row">
                                                    <div class="list-group-item list-group-item-warning" style="padding-top: 4px; height: 30px; padding-bottom: 4px; font-size: 1.2em;">
                                                        &nbsp;
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label text-black">
                                                        </label>
                                                        <div class="col-sm-8">


                                                            <!-- Inline Icon Radios Buttons -->
                                                            <!--===================================================-->

                                                            <asp:CheckBox runat="server" ID="chkDeclaration" onclick="javascript:funCalled(this)" Text="&nbsp; I am verify that all the information is correct."
                                                                CssClass="form-control blue-border required" />




                                                        </div>
                                                    </div>
                                                </div>
                                                <br />
                                                <div class="row">
                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label text-black">
                                                            Remark<span class="symbol required"></span>
                                                        </label>
                                                        <div class="col-sm-8">

                                                            <asp:TextBox ID="txtRemarkdetails" placeholder="Remark Require If reject" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-control blue-border required"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <asp:Button ID="Button4" class="btn btn-dark-azure" runat="server" Text="Print Application Form" OnClientClick="printform();" />
                                            <asp:Button ID="btnApplicantUpdate" class="btn btn-dark-azure" runat="server" Text="Update Status" OnClientClick="Updatestatusapplicant();" />
                                            <button type="button" data-dismiss="modal" class="btn btn-dark-beige">
                                                Close
                                            </button>

                                            <button type="button" class="btn btn-dark-azure" id="btnAppUpdate">
                                                Update Applicant Data
                                            </button>
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
    <!-- end: Application Update Popup -->
    <!-- start: Bank Branches Popup -->
    <div id="divBranchpopup" class="modal extended-modal fade no-display" tabindex="-1"
        data-width="950">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-green">
                    <button type="button" id="btnBranchpopupclose" class="close" data-dismiss="modal"
                        aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title">Search Financing Branches 
                    </h4>
                </div>
                <div class="modal-body" style="padding-bottom: 0px;">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="list-group-item list-group-item-warning">
                                <strong>Financing Branches List of
                                    <label id="lblBankName" class="text-black text-bold">
                                    </label>
                                    in
                                    <label id="lblDist" class="text-black text-bold">
                                    </label>
                                    District </strong>
                            </div>
                            <table class="table table-striped table-bordered table-hover table-full-width text-black"
                                width="100%" id="tblBranch">
                                <thead>
                                    <tr class="active">
                                        <th width="5%">SNo.
                                        </th>
                                        <th width="10%"></th>
                                        <th width="20%">City
                                        </th>
                                        <th width="15%">IFS Code
                                        </th>
                                        <th width="20%">Branch Name
                                        </th>
                                        <th width="30%">Address
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- end: Bank Branches Popup -->
    <!-- start: Doc Update Popup -->
    <div id="divDocUpdatePopup" class="modal extended-modal fade no-display" tabindex="-1" data-width="950">

        <div class="modal-content">
            <div class="modal-header bg-green">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title">Applicant Document Update by Agency (
                        <asp:Label ID="lblScheme3" runat="server"></asp:Label>
                    )</h4>
            </div>
            <div class="modal-body" style="padding-bottom: 0px;">
                <div class="row">
                    <div class="col-md-12">
                        <div class="panel panel-lightPink no-padding">
                            <div class="panel-body">
                                <div class="form-horizontal">
                                    <div class="panel-body">
                                        <table id="tblDoc" class="table table-border">
                                            <thead>
                                                <tr>
                                                    <th class="text-center">Document Type
                                                    </th>
                                                    <th class="text-center">Document Name
                                                    </th>

                                                    <th class="text-center">View
                                                    </th>

                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <%--  <label id="lblDocTitle">
                                                            </label>--%>
                                                    </td>
                                                    <td>
                                                        <%-- <a data-placement="top" data-original-title="Click to view document" class='btn btn-primary tooltips btn-xs'
                                                                target='_blank'><i class='glyphicon glyphicon-upload'></i><span>View</span></a>--%>
                                                    </td>
                                                    <td></td>
                                                </tr>
                                            </tbody>
                                        </table>

                                        <asp:Label ID="Applicationdocid" runat="server"></asp:Label>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">

                                            <asp:Label ID="Label1" runat="server" Text="Application No :" Font-Bold="True" ForeColor="#3333FF"></asp:Label>
                                            <asp:Label ID="remarkviewid" Font-Bold="True" ForeColor="#3333FF" runat="server" Text=""></asp:Label>
                                        </div>
                                        <div class="row">

                                            <label class="col-sm-2 control-label text-black">
                                            </label>
                                            <div class="col-sm-12">


                                                <!-- Inline Icon Radios Buttons -->
                                                <!--===================================================-->

                                                <asp:CheckBox runat="server" ID="chkDeclaration1" Text="&nbsp; I am verify that all the document is correct ." onclick="javascript:viewremark(this)" CssClass="form-control blue-border required" />




                                            </div>

                                        </div>
                                        <div id="remarkdoc" class="row">
                                            <div class="col-md-12">


                                                <asp:TextBox ID="remarkviewdoc" Placeholder="Remark Require If reject" runat="server" Width="100%" TextMode="MultiLine" Rows="2"></asp:TextBox>


                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <asp:Button ID="button3" OnClientClick="UpdateRejectionwithremark();" Text="Update Remark" class="btn btn-active-pink" runat="server" />
                                            <button type="button" data-dismiss="modal" class="btn btn-dark-beige">
                                                Close
                                            </button>
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
    <!-- end: Doc Update Popup -->
    <!-- start: ACTIVITY Popup -->
    <div id="ActivityPopup" class="modal extended-modal fade no-display" tabindex="-1"
        data-width="750">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-green">
                    <button type="button" id="Button1" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title">Search Industry / Activity Name
                    </h4>
                </div>
                <div class="modal-body" style="padding-bottom: 0px;">
                    <div class="row">
                        <div class="col-md-12">
                            <table class="table table-striped table-bordered table-hover table-full-width text-black"
                                width="100%" id="tblActivity">
                                <thead>
                                    <tr class="active">
                                        <th>SNo.
                                        </th>
                                        <th></th>
                                        <th>Industry / Activity Name
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="<%=ResolveUrl("~/js/jquery-2.1.1.min.js") %>"></script>
    <!--Jasmine Admin [ RECOMMENDED ]-->
    <script src="<%=ResolveUrl("~/js/scripts.js") %>"></script>
    <script type="text/javascript">
        $(document).ready(function () {

            $('#demo-dp-component .input-group.date').datepicker({
                autoclose: true,
                format: "dd/mm/yyyy",
                todayHighlight: true
            });

        });
    </script>
</asp:Content>


