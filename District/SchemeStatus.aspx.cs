using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

public partial class District_SchemeStatus : System.Web.UI.Page
{
    DBLayer db = new DBLayer();
    public static Int32 districtkey;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["DistrictKey"] != null)
            districtkey = Convert.ToInt32(Session["DistrictKey"]);
        if (!IsPostBack)
        {
            try
            {
                this.fillCombo();
                this.fillData();
            }
            catch (Exception)
            {

                throw;
            }
        }

    }

    [WebMethod]
    public static List<ListItem> GetSchemesType()
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.GetAllSchemeType();
        }
        catch (Exception ex)
        {

            return null;
        }
    }

    [WebMethod]
    public static List<ListItem> GetSchemes(int key)
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.GetSchemesForSelect(key).ToList();
        }
        catch (Exception ex)
        {

            return null;
        }

    }
    private void fillCombo()
    {
        //ddlSchemeName.DataSource = db.PopulateScheme();
        //ddlSchemeName.DataTextField = "Text";
        //ddlSchemeName.DataValueField = "value";
        //ddlSchemeName.DataBind();
        //  ddlSchemeName.Items.Insert(0, new ListItem { Text = "Select Scheme Name", Value = "" });

        ddlStatus.DataSource = db.PopulateSchemeStatus();
        ddlStatus.DataTextField = "Text";
        ddlStatus.DataValueField = "value";
        ddlStatus.DataBind();
        
        //  ddlStatus.Items.Insert(0, new ListItem { Text = "Select Status", Value = "" });

    }

    private void fillData()
    {
        DataSet ds = db.GET_ApplicationList(districtkey);
        if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            rptApplication.DataSource = ds.Tables[0];
        else
            rptApplication.DataSource = "";
        rptApplication.DataBind();
    }

    [WebMethod]
    public static string GetApplicationBasic(Int64 ApplicatonNo)
    {
        try
        {
            return JsonConvert.SerializeObject(new DBLayer().GetSchemeByApplicatonNo(ApplicatonNo));
        }
        catch (Exception)
        {
            return "{\"Status\":\"404\"}";
            throw;
        }
    } 

    [WebMethod]
    public static string GetApplicationBasicWithDocs(Int64 ApplicatonNo)
    {
        try
        {
            return JsonConvert.SerializeObject(new DBLayer().GetSchemeByApplicatonNoWithDocs(ApplicatonNo));
        }
        catch (Exception)
        {
            return "{\"Status\":\"404\"}";
            throw;
        }
    }

    [WebMethod]
    public static string GetApplicationScheme(Int64 ApplicatonNo)
    {
        try
        {
            return JsonConvert.SerializeObject(new DBLayer().GetSchemeByApplicatonNo(ApplicatonNo));
        }
        catch (Exception)
        {
            return "{\"Status\":\"404\"}";
            throw;
        }
    }

    [WebMethod]
    public static string CreateTakeAction(APT_SchemeActionDetail objAPT_SchemeActionDetail)
    {
        try
        {
            objAPT_SchemeActionDetail.CreatedBy = districtkey;
            objAPT_SchemeActionDetail.ActionBy = "DS";
            int rowAffected = new DBLayer().TakeAction(objAPT_SchemeActionDetail);
            if (rowAffected > 0)
            {
                return "{\"StatusCode\":\"200\", \"Msg\":\"Record Saved Successfully.\"}";
            }
            else
            {
                return "{\"StatusCode\":\"500\", \"Msg\":\"Record Not Saved.\"}";
            }
        }
        catch (Exception ex)
        {
            return "{\"StatusCode\":\"404\", \"Msg\":\"Something Went Wrong.\"}";
            throw;
        }
    }
}