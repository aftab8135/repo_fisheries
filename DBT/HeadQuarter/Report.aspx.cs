using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

public partial class HeadQuarter_Report : System.Web.UI.Page
{
    public static Int64 UserKey;
    public static string UserName;
    public static string FinYear;
    protected void Page_Load(object sender, EventArgs e)
    {
        UserKey = Convert.ToInt64(Session["UserKey"]);
        UserName = Session["UserName"].ToString();
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
            jsondata = JsonConvert.SerializeObject(db.GetDBT_ForwardedListByMandal(FinYear, SchemeKey, ProgressKey, InsKey));
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

    [WebMethod]
    public static string FinalSubmit(string appNos)
    {
        try
        {
            List<DBT_InsDistributionDetail> lst = new List<DBT_InsDistributionDetail>();
            foreach (string strNo in appNos.Split(','))
            {
                DBT_InsDistributionDetail obj = new DBT_InsDistributionDetail();
                obj.DetailKey = Convert.ToInt64(strNo);
                obj.ApprovedBy = UserKey;
                lst.Add(obj);
            }

            int rowAffected =Convert.ToInt32(new DBLayer().UpdateStatusByHO(lst));
            if (rowAffected > 0)
            {
                return "{\"StatusCode\":\"200\", \"Msg\":\"सभी सत्यापित कियें गयें।\"}";
            }
            else
            {
                return "{\"StatusCode\":\"500\", \"Msg\":\"सत्यापित नहीं हुयें।\"}";
            }

        }
        catch (Exception ex)
        {
            return "{\"StatusCode\":\"404\", \"Msg\":\"कृपया पुनः प्रयास करें।\"}";
            throw;
        }
    }
}