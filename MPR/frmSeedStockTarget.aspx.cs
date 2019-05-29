using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

public partial class MPR_frmSeedProductionTarget : System.Web.UI.Page
{
   
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lblFinYear.Text = Session["FinancialYear"].ToString(); ;
        }
    }

    [WebMethod]
    public static List<ListItem> GetSeedObject()
    {
        try
        {
            return new DBLayer().GetSeedObject();
        }
        catch (Exception)
        {

            return null;
        }
    }


    [WebMethod]
    public static string GetSeedYearlyTarget(int SDObjectKey)
    {
        try
        {
            string jsondata = "";
            DBLayer db = new DBLayer();
            jsondata = JsonConvert.SerializeObject(db.GetSeedYearlyTarget_dt(HttpContext.Current.Session["FinancialYear"].ToString(), SDObjectKey));
            return jsondata;
        }

        catch (Exception ex)
        {
            return null;
        }
    }


    [WebMethod]
    public static string Create(List<SeedDistributionTarget> lstMsrTarget)
    {
        try
        {
            int rowAffected = 0;

            foreach (var item in lstMsrTarget)
            {
                SeedDistributionTarget objRecord = new SeedDistributionTarget();
                objRecord.FinYear = HttpContext.Current.Session["FinancialYear"].ToString();
                objRecord.CreatedBy = Convert.ToInt32(HttpContext.Current.Session["UserKey"]);
                objRecord.DistrictKey = item.DistrictKey;
                objRecord.NigamSeedTarget = item.NigamSeedTarget;
                objRecord.NijiSeedTarget = item.NijiSeedTarget;
                objRecord.OtherSeedTarget = item.OtherSeedTarget;
                objRecord.RearingUnitSeedTarget = item.RearingUnitSeedTarget;
                objRecord.VibhagiyaSeedTarget = item.VibhagiyaSeedTarget;
                objRecord.PangesiusSeedTarget = item.PangesiusSeedTarget;
                objRecord.SDObjectKey = item.SDObjectKey;
                objRecord.IsActive = true;

                rowAffected = rowAffected + new DBLayer().CreateSeedDistributionTarget(objRecord);
            }

            //  int rowAffected = new DBLayer().CreateSeedDistributionTarget(objRecord);
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