using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MPR_frmDeptGradePondNistarn : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblFinYear.Text = Session["FinancialYear"].ToString(); ;
        lblLoginType.Text = Session["UserName"].ToString();
    }

    [WebMethod]
    public static List<ListItem> GetMonthName()
    {
        try
        {
            return new DBLayer().PopulateMonthName();
        }
        catch (Exception)
        {

            return null;
        }
    }

    [WebMethod]
    public static string Create(PondGrdNistarnProgMaster objPondGrdNistarnProgMaster)
    {
        try
        {
            objPondGrdNistarnProgMaster.FinYear = HttpContext.Current.Session["FinancialYear"].ToString(); ;
            objPondGrdNistarnProgMaster.DistrictKey = Convert.ToInt32(HttpContext.Current.Session["DistrictKey"]);
            objPondGrdNistarnProgMaster.CreatedBy = Convert.ToInt32(HttpContext.Current.Session["UserKey"]);
            objPondGrdNistarnProgMaster.IsActive = true;

            int rowAffected = new DBLayer().CreatePondGrdNistarnProg(objPondGrdNistarnProgMaster);
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