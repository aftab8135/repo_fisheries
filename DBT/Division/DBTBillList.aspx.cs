using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Division_DBTBillList : System.Web.UI.Page
{
    public static Int64 UserKey;
    public static string UserName;
    public static int DivisionKey;
    public static string FinYear;
    protected void Page_Load(object sender, EventArgs e)
    {
        UserKey = Convert.ToInt64(Session["UserKey"]);
        UserName = Session["UserName"].ToString();
        DivisionKey = Convert.ToInt32(Session["DivisionKey"]);
        FinYear = Session["FinancialYear"].ToString();


        lblFinYear.Text = FinYear;
        lblLoginType.Text = UserName;

    }


    [WebMethod]
    public static string GetDBT_BillList()
    {
        try
        {
            string jsondata = "";
            DBLayer db = new DBLayer();
            jsondata = JsonConvert.SerializeObject(db.GetDBT_BillList(DivisionKey));
            return jsondata;
        }

        catch (Exception ex)
        {
            return null;
        }
    }

    [WebMethod]
    public static string Update_DBTTokenNo(String TokenNo, String DBTDate, Int64 billforwardingkey)
    {
        string strMsg = "";
        try
        {
            DBLayer objDBLayer = new DBLayer();
            int kk = objDBLayer.Update_DBTToken(TokenNo, DBTDate, UserKey, billforwardingkey);
            if (kk > 0)
            {
                strMsg = "टोकन संख्या सत्यापित हो गयी है|";
            }
            else
            {
                strMsg = "टोकन संख्या सत्यापित नहीं हुई है|";
            }

            return strMsg;
        }
        catch (Exception ex)
        {
            return strMsg = "";
        }

    }

}