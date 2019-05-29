using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class District_frm_AdarshGramYojna : System.Web.UI.Page
{
    private static Int32 DistrictKey = 0;
    private static Int32 DivisionKey = 0;
    private static string FinYear = "";
    private static Int64 UserKey = 0;
    private static string UserName = "";


    protected void Page_Load(object sender, EventArgs e)
    {
        UserKey = Convert.ToInt32(Session["UserKey"]);
        DistrictKey = Convert.ToInt32(Session["DistrictKey"]);
        FinYear = Session["FinancialYear"].ToString();
        UserName = Session["UserName"].ToString();

        lblFinYear.Text = FinYear;
        lblLoginType.Text = UserName;
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
    public static string Create(PondProgressFirstMaster objPondProgressFirstMaster)
    {
        try
        {
            objPondProgressFirstMaster.DistrictKey = DistrictKey;
            objPondProgressFirstMaster.DivisionKey = DivisionKey;
            objPondProgressFirstMaster.FinYear = FinYear;
            objPondProgressFirstMaster.CreatedBy = UserKey;

            int rowAffected = new DBLayer().CreatePondProgress(objPondProgressFirstMaster);
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