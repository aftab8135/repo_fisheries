using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Services;
using System.Web.Script.Services;
using System.Web.Script.Serialization;


public partial class Division_StatusUpdate : System.Web.UI.Page
{
    DBLayer db = new DBLayer();

    #region Events

    protected void Page_PreInit(object sender, EventArgs e)
    {

    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                this.fillData();
                this.fillCombo();
            }
            catch (Exception ex)
            {
                ex.ToString();
            }
        }
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        DateTime dt = GetDate(txtFromdate.Text);
        DateTime dt1 = GetDate(txtTodate.Text);
        //DateTime dt=Get
        int shkey;
        if (ddlScheme.SelectedValue != "")
            shkey = Convert.ToInt16(ddlScheme.SelectedValue);
        else
            shkey = 0;
        int stkey;
        if (ddlstatus.SelectedValue != "")
            stkey = Convert.ToInt16(ddlstatus.SelectedValue);
        else stkey = 0;
        fillDataSearch(shkey, stkey, dt, dt1);
    }
    #endregion
    #region Functions

    private DateTime GetDate(object objVal)
    {
        if (objVal == null) return Convert.ToDateTime(null);
        if (objVal is DBNull) return Convert.ToDateTime(null);
        if (objVal is string && string.IsNullOrEmpty(objVal.ToString())) return Convert.ToDateTime(null);
        return Convert.ToDateTime(objVal);
    }

    private void fillDataSearch(int schemevalue, int statuskey, DateTime fromdate, DateTime todate)
    {

        DataSet ds = db.GET_ApplicationList_DIVIOSONSearh(Convert.ToInt16(3), Convert.ToInt16(schemevalue), Convert.ToInt16(statuskey), fromdate, todate);

        if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            rptApplication.DataSource = ds.Tables[0];
        else
            rptApplication.DataSource = "";
        rptApplication.DataBind();
    }
    private void fillData()
    {
        //DataSet ds = db.GET_ApplicationList_DVIO(Convert.ToInt16(Session["DistrictKey"]));
        DataSet ds = db.GET_ApplicationList_DIVISON(Convert.ToInt16(3));

        if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            rptApplication.DataSource = ds.Tables[0];
        else
            rptApplication.DataSource = "";
        rptApplication.DataBind();
    }

    private void fillCombo()
    {
      
        ddlScheme.DataSource = db.PopulateScheme();
        ddlScheme.DataTextField = "Text";
        ddlScheme.DataValueField = "value";
        ddlScheme.DataBind();
        ddlScheme.Items.Insert(0, new ListItem { Text = "Select Scheme Name", Value = "" });
        ddlstatus.DataSource = db.PopulateSchemeStatus();
        ddlstatus.DataTextField = "Text";
        ddlstatus.DataValueField = "value";
        ddlstatus.DataBind();
        ddlstatus.Items.Insert(0, new ListItem { Text = "Select Status", Value = "" });
    }

    #endregion



    [WebMethod]
    public static List<ApplicationStatus_Master> getCurrentStatus(Int32 q)
    {
        DBLayer db = new DBLayer();
        List<ApplicationStatus_Master> lstApplicationStatus = new List<ApplicationStatus_Master>();
        ApplicantSchemeRegistration objDetail = new ApplicantSchemeRegistration();
        objDetail.ApplicationNo = q;
        db.ReadApplication(objDetail);
        if (objDetail != null && objDetail.ApplicationNo > 0)
        {
            lstApplicationStatus = db.ReadAllApplicationStatusDvision(true, objDetail.ApplicationStatus, "DLSC");
        }

        return lstApplicationStatus;
    }


    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string SaveCheckStatus(ApplicantSchemeRegistration objStatusDetail)
    {
        DBLayer DB = new DBLayer();
        var jsondata = new Dictionary<string, string>();
        var jsSerializer = new JavaScriptSerializer();

        try
        {
            Int64 StatusDetailKey = 0;

            StatusDetailKey = DB.updatecheckstatus(objStatusDetail.ApplicationNo, objStatusDetail.District_Flag);
            if (StatusDetailKey > 0)
            {

                string key = HttpUtility.UrlEncode(GeneralClass.Encrypt(StatusDetailKey.ToString()));

                jsondata = new Dictionary<string, string>
                    {
                        { "Success", "1"},
                        { "Keyencry",  key },
                         { "Key",  StatusDetailKey.ToString() },
                         { "Message", "Document View and Check Successfully."}
                    };

            }
            else
            {
                jsondata = new Dictionary<string, string>
                    {
                        { "Success", "0"},
                        { "Key", "0"},
                        { "Message", "Error!Please try again later."}
                    };
            }
            //}
            return jsSerializer.Serialize(jsondata);
        }
        catch (Exception ex)
        {
            jsondata = new Dictionary<string, string>
            {
                { "Success", "0"},
                { "Key", "0"},
                { "Message", ex.Message}
            };
            return jsSerializer.Serialize(jsondata);
        }
    }


    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string SaveCurrentStatus(StatusDetail objStatusDetail)
    {
        DBLayer DB = new DBLayer();
        var jsondata = new Dictionary<string, string>();
        var jsSerializer = new JavaScriptSerializer();

        try
        {
            Int64 StatusDetailKey = 0;
            if (objStatusDetail.DocReceiveDate.Year == 1)
                StatusDetailKey = DB.CreateStatusDetail(objStatusDetail.ApplicationNo, objStatusDetail.StatusKey, objStatusDetail.Remark, Convert.ToInt32(HttpContext.Current.Session["UserKey"]));
            else
                StatusDetailKey = DB.CreateStatusDetail(objStatusDetail.ApplicationNo, objStatusDetail.StatusKey, objStatusDetail.Remark, Convert.ToInt32(HttpContext.Current.Session["UserKey"]), objStatusDetail.DocReceiveDate);
            if (StatusDetailKey > 0)
            {
                ApplicationStatus_Master objStatus = new ApplicationStatus_Master();
                objStatus.StatusKey = objStatusDetail.StatusKey;
                DB.ReadStatusMaster(objStatus);
                if (objStatus != null && objStatus.StatusKey > 0)
                {
                    ApplicantSchemeRegistration objApplication = new ApplicantSchemeRegistration();
                    objApplication.ApplicationNo = objStatusDetail.ApplicationNo;
                    DB.ReadApplication(objApplication);
                    if (objApplication != null && objApplication.ApplicationNo > 0)
                    {
                        string sms = "Dear " + objApplication.Name.Trim() + ", Your Application " + objApplication.ApplicationNo + " has been " + objStatus.CurrentStatusText.Trim() + " as on " + DateTime.Now.ToString("dd/MMM/yyyy") + ". For Details check status under status tab.";
                        GeneralClass.SendSMS(objApplication.MobileNo, sms);
                    }
                }
                string key = HttpUtility.UrlEncode(GeneralClass.Encrypt(StatusDetailKey.ToString()));

                jsondata = new Dictionary<string, string>
                    {
                        { "Success", "1"},
                        { "Keyencry",  key },
                         { "Key",  StatusDetailKey.ToString() },
                         { "Message", "Status Updated Successfully."}
                    };

            }
            else
            {
                jsondata = new Dictionary<string, string>
                    {
                        { "Success", "0"},
                        { "Key", "0"},
                        { "Message", "Error!Please try again later."}
                    };
            }
            //}
            return jsSerializer.Serialize(jsondata);
        }
        catch (Exception ex)
        {
            jsondata = new Dictionary<string, string>
            {
                { "Success", "0"},
                { "Key", "0"},
                { "Message", ex.Message}
            };
            return jsSerializer.Serialize(jsondata);
        }
    }


    [WebMethod]
    public static List<InteractionDetail> getInteractionDetail(Int32 q)
    {
        DBLayer db = new DBLayer();
        List<InteractionDetail> lstInteractionDetail = db.ReadAllInteractionDetail(q);
        return lstInteractionDetail;
    }
    [WebMethod]
    public static List<Applicantdocumentdetails> getDocumentDetail(Int32 q)
    {
        DBLayer db = new DBLayer();
        Applicantdocumentdetails objDocuments = new Applicantdocumentdetails();
        objDocuments.ApplicationKey = q;
        List<Applicantdocumentdetails> lstDoc = db.Read(objDocuments);
        ApplicantSchemeRegistration objApplicant = new ApplicantSchemeRegistration();
        objApplicant.ApplicationNo = q;
        db.ReadApplication(objApplicant);

        return lstDoc;
    }
    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string SaveInteraction(InteractionDetail objInteractionDetail)
    {
        DBLayer DB = new DBLayer();
        var jsondata = new Dictionary<string, string>();
        var jsSerializer = new JavaScriptSerializer();

        try
        {
            Int64 InteractionKey = DB.CreateInteractionDetail(objInteractionDetail.ApplicationNo, objInteractionDetail.InteractionMode, objInteractionDetail.OfficerName, objInteractionDetail.Designation, objInteractionDetail.InteractionDate, objInteractionDetail.InteractionTime, objInteractionDetail.InteractionRemark, Convert.ToInt32(HttpContext.Current.Session["UserKey"]));
            if (InteractionKey > 0)
            {
                ApplicantSchemeRegistration objApplication = new ApplicantSchemeRegistration();
                objApplication.ApplicationNo = objInteractionDetail.ApplicationNo;
                DB.ReadApplication(objApplication);
                if (objApplication != null && objApplication.ApplicationNo > 0)
                {
                    string sms = "Dear " + objApplication.Name.Trim() + ", Interaction is submitted by DVIO. Please Check Details On Your Login Under Status.";
                    GeneralClass.SendSMS(objApplication.MobileNo, sms);
                }
                string key = HttpUtility.UrlEncode(GeneralClass.Encrypt(InteractionKey.ToString()));

                jsondata = new Dictionary<string, string>
                    {
                        { "Success", "1"},
                        { "Keyencry",  key },
                         { "Key",  InteractionKey.ToString() },
                         { "Message", "Interaction Detail Saved Successfully."}
                    };

            }
            else
            {
                jsondata = new Dictionary<string, string>
                    {
                        { "Success", "0"},
                        { "Key", "0"},
                        { "Message", "Error!Please try again later."}
                    };
            }
            //}
            return jsSerializer.Serialize(jsondata);
        }
        catch (Exception ex)
        {
            jsondata = new Dictionary<string, string>
            {
                { "Success", "0"},
                { "Key", "0"},
                { "Message", ex.Message}
            };
            return jsSerializer.Serialize(jsondata);
        }
    }

    [WebMethod]
    public static ApplicantSchemeRegistration getApplicationDetail(int q)
    {
        DBLayer db = new DBLayer();
        ApplicantSchemeRegistration objApplicant = new ApplicantSchemeRegistration();
        objApplicant.ApplicationNo = q;
        db.ReadApplication(objApplicant);
        return objApplicant;
    }

}