using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

public partial class District_frm_BillVerificationList : System.Web.UI.Page
{
    public static Int64 UserKey;
    public static string UserName;
    public static int DistrictKey;
    public static string FinYear;
    protected void Page_Load(object sender, EventArgs e)
    {
        UserKey = Convert.ToInt64(Session["UserKey"]);
        UserName = Session["UserName"].ToString();
        DistrictKey = Convert.ToInt32(Session["DistrictKey"]);
        FinYear = Session["FinancialYear"].ToString();

        lblFinYear.Text = FinYear;
        lblLoginType.Text = UserName;
    }



    [WebMethod]
    public static string GetIsForwardInstallment()
    {
        try
        {
            string jsondata = "";
            DBLayer db = new DBLayer();
            jsondata = JsonConvert.SerializeObject(db.GetDBT_ForwardedStatusByDistrict(FinYear, DistrictKey));
            return jsondata;
        }

        catch (Exception ex)
        {
            return null;
        }
    }
}