using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

public partial class Division_frmDocumentVerification : System.Web.UI.Page
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

    [WebMethod]
    public static List<ListItem> GetWorkType(int schemeID)
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.GetProgressTypeByScheme(schemeID);
        }
        catch (Exception ex)
        {

            return null;
        }

    }

    [WebMethod]
    public static List<ListItem> GetWorkIntallment(int schemeID, int workTypeID)
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.GetWorkIntallmentByWorkType(schemeID, workTypeID);
        }
        catch (Exception ex)
        {

            return null;
        }

    }

    [WebMethod]
    public static string GetForwardInstallment(Int64 SchemeKey, Int64 ProgressKey, Int64 InsKey)
    {
        try
        {
            string jsondata = "";
            DBLayer db = new DBLayer();
            jsondata = JsonConvert.SerializeObject(db.GetDBT_ForwardedListByDivision(FinYear, DivisionKey, SchemeKey, ProgressKey, InsKey));
            return jsondata;
        }

        catch (Exception ex)
        {
            return null;
        }
    }

    [WebMethod]
    public static string ApproveDocument(Int64 DetailID, int IsApporved)
    {
        string strMsg = "";
        try
        {
            if ((DetailID != 0))
            {
                DBLayer objDBLayer = new DBLayer();
                DBT_InsDistributionDetail objInsDetail = new DBT_InsDistributionDetail();
                objInsDetail.DetailKey = DetailID;
                objInsDetail.VerifiedBy = UserKey;
                objInsDetail.IsDocVerify = true;


                string a = objDBLayer.UpdateStatusByMandal(objInsDetail, (IsApporved == 0 ? false : true));
                if (IsApporved == 1)
                {
                    if (a != "")
                        strMsg = "सत्यापित किया गया।";
                    else
                    {
                        strMsg = "सत्यापित नहीं हुआ।";
                    }
                }
                else
                {
                    if (a != "")
                        strMsg = "निरस्त किया गया।";
                    else
                    {
                        strMsg = "निरस्त नहीं हुआ।";
                    }
                }

            }
            else
            {
                strMsg = "कृपया पुनः प्रयास करें।";
            }
            return strMsg;
        }
        catch (Exception ex)
        {
            return strMsg = "";
        }

    }
}