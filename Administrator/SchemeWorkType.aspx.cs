using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

public partial class Administrator_SchemeWorkType : System.Web.UI.Page
{
    public static Int64 intUser=0;
    public static DataTable dtDetail = new DataTable();
    public static DataTable dtMaster = new DataTable();

    protected void Page_Load(object sender, EventArgs e)
    {
        intUser = Convert.ToInt64(Session["UserKey"]);
        LoadDetail();
    }

   
    [WebMethod]
    public static List<ListItem> GetWorkType()
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.GetProgressType();
        }
        catch (Exception ex)
        {

            return null;
        }

    }

    [WebMethod]
    public static List<ListItem> GetSchemes(int schemetypkey)
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.GetSchemesForSelect(schemetypkey);
        }
        catch (Exception ex)
        {

            return null;
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


    private static bool CheckDate(String date)
    {
        try
        {
            return GeneralClass.IsDateTime(GeneralClass.GetDateInMMDDYYYY(date));
        }
        catch
        {
            return false;
        }
    }
    private static string CheckError(SchemeWorkTypeMaster objSchemeWorkType)
    {
        try
        {
            //if (!CheckDate(objSchemeWorkType.EffectiveDate.ToString()))
            //{
            //    return "Invalid Effective Date";
            //}
            if (objSchemeWorkType.SchemeKey == 0)
            {
                return "Invalid Scheme Name";
            }
            if (objSchemeWorkType.WorkTypeKey == 0)
            {
                return "Invalid Progress Type";
            }
            if (objSchemeWorkType.InstNos <= 0)
            {
                return "Invalid Installment Number.";
            }
            if (objSchemeWorkType.InstPercent <= 0 || objSchemeWorkType.InstPercent > 100)
            {
                return "Invalid Total Installment Percent.";
            }
            decimal totalPercent = 0;
            foreach (SchemeWorkTypeDetail objSWDetail in objSchemeWorkType.SchemeWorkTypeDetails)
            {
                if (objSWDetail.InstallmentPercent <= 0 || objSWDetail.InstallmentPercent > 100)
                {
                    return "Invalid Installment Percent.";
                }
                else
                {
                    totalPercent = (totalPercent) + (objSWDetail.InstallmentPercent ?? 0);
                }
            }
            if (totalPercent <= 0 || totalPercent > 100)
            {
                return "Invalid Distributed Installment Percent.";
            }
            return "";
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public void LoadDetail()
    {
        try
        {
            DBLayer objDBLayer = new DBLayer();
            dtMaster = objDBLayer.GetAllSchemeWorkInstallment();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "error alert", "alert('Error Occured! Try again later..')", true);
        }
    }

    [WebMethod]
    public static string EditSchemeWorkType(Int64 intSchemeWorkKey)
    {
        try
        {
            string jsondata = "";
            DBLayer db = new DBLayer();
            jsondata = JsonConvert.SerializeObject(db.GetAllSchemeWorkInstallment(intSchemeWorkKey));
            return jsondata;
        }

        catch (Exception ex)
        {
            return null;
        }
    }

    [WebMethod]
    public static string GetSchemeWorkType(Int64 intSchemeKey)
    {
        try
        {
            string jsondata = "";
            DBLayer db = new DBLayer();
            jsondata = JsonConvert.SerializeObject(db.GetAllSchemeWork(intSchemeKey));
            return jsondata;
        }

        catch (Exception ex)
        {
            return null;
        }
    }

    [WebMethod]
    public static string Submit(SchemeWorkTypeMaster objSchemeWorkType)
    {
        string strMsg = "";
        try
        {
            strMsg = CheckError(objSchemeWorkType);
            if (strMsg == "")
            {
                DBLayer objDBLayer = new DBLayer();
                if ((objSchemeWorkType.SchemeWorkKey == 0))
                {
                    objSchemeWorkType.CreatedBy = intUser;
                    int a = objDBLayer.UpdateSchemeWorkInstallment(objSchemeWorkType, false);
                    if (a > 0)
                        strMsg = "Record Saved Successfully.";
                }
                else if ((objSchemeWorkType.SchemeWorkKey != 0))
                {
                    objSchemeWorkType.LastModifiedBy = intUser;
                    int a = objDBLayer.UpdateSchemeWorkInstallment(objSchemeWorkType, true);
                    if (a > 0)
                        strMsg = "Record Updated Successfully.";
                }
            }
            return strMsg;

        }
        catch (Exception ex)
        {
            return strMsg;
        }
    }

    [WebMethod]
    public static string Delete(Int64 intSchemeWorkKey)
    {
        string strMsg = "";
        try
        {
            if ((intSchemeWorkKey != 0))
            {
                DBLayer objDBLayer = new DBLayer();
                int a = objDBLayer.DeleteSchemeWorkInstallment(intSchemeWorkKey);
                if (a > 0)
                    strMsg = "Record Deleted Successfully.";
                else
                {
                    strMsg = "Record Not Deleted.";
                }
            }
            else
            {
                strMsg = "Record Not Deleted.";
            }
            return strMsg;
        }
        catch (Exception ex)
        {
            return strMsg = "";
        }

    }

    [WebMethod]
    public static string ACTIVE_DEACTIVE(Int64 intSchemeWorkKey)
    {
        string strMsg = "";
        try
        {
            if ((intSchemeWorkKey != 0))
            {
                DBLayer objDBLayer = new DBLayer();
                SchemeWorkTypeMaster objMaster = new SchemeWorkTypeMaster();
                objMaster.SchemeWorkKey = intSchemeWorkKey;
                objMaster.LastModifiedBy = intUser;
                int a = objDBLayer.DeActiveSchemeWorkInstallment(objMaster);
                if (a > 0)
                    strMsg = "Record Updated Successfully.";
                else
                {
                    strMsg = "Record Not Updated.";
                }
            }
            else
            {
                strMsg = "Record Not Updated.";
            }
            return strMsg;
        }
        catch (Exception ex)
        {
            return strMsg = "";
        }

    }
}