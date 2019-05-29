using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

public partial class HO_SchemeStatus : System.Web.UI.Page
{
    DBLayer db = new DBLayer();
    public static Int64 UserKey;
    public static string FinYear = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserKey"] != null)
        {
            UserKey = Convert.ToInt64(Session["UserKey"]);
            FinYear = Session["FinancialYear"].ToString();
        }
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
        ddlStatus.DataSource = db.PopulateSchemeStatus();
        ddlStatus.DataTextField = "Text";
        ddlStatus.DataValueField = "value";
        ddlStatus.DataBind();

    }

    private void fillData()
    {
        DataTable dt = db.GET_ApplicationForHO(FinYear);
        if (dt.Rows.Count > 0)
        {
            rptApplication.DataSource = dt;
            rptApplication.DataBind();
        }
       
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
    public static string FinalSubmit(string appNos)
    {
        try
        {
            List<APT_SchemeActionDetail> lst = new List<APT_SchemeActionDetail>();
            foreach (string strNo in appNos.Split(','))
            {
                APT_SchemeActionDetail objSch = new APT_SchemeActionDetail();
                objSch.ApplicationNo = Convert.ToInt64(strNo);
                objSch.CreatedBy = UserKey;
                lst.Add(objSch);
            }
            
            int rowAffected = new DBLayer().TakeAction(lst);
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