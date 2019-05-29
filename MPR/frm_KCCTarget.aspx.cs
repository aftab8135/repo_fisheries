using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MPR_frm_KCCTarget : System.Web.UI.Page
{
    public static string FinYear = "";
    private static Int32 UserKey = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            FinYear = Session["FinancialYear"].ToString();
            UserKey = Convert.ToInt32(Session["UserKey"]);
            lblFinYear.Text = FinYear;
        }
    }


    [WebMethod]
    public static string GetKCCYearlyTarget()
    {
        try
        {
            string jsondata = "";
            DBLayer db = new DBLayer();
            jsondata = JsonConvert.SerializeObject(db.GetKCCYearlyTarget_dt(FinYear));
            return jsondata;
        }

        catch (Exception ex)
        {
            return null;
        }
    }


    [WebMethod]
    public static string Create(List<KCC_Target> lstKCCTarget)
    {
        try
        {
            int rowAffected = 0;
        
            foreach (var item in lstKCCTarget)
            {
                KCC_Target objRecord = new KCC_Target();
                objRecord.FinYear = HttpContext.Current.Session["FinancialYear"].ToString(); 
                objRecord.CreatedBy = UserKey;
                objRecord.DistrictKey = item.DistrictKey;
                objRecord.KCCTarget = item.KCCTarget;

                rowAffected = rowAffected + new DBLayer().CreateKCC_Target(objRecord); 
            }

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