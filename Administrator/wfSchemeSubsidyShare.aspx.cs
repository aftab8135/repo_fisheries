using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

public partial class Administrator_wfSchemeSubsidyShare : System.Web.UI.Page
{
    private static Int64 intUser = 0;
    public static DataTable dtSchemes = new DataTable();
    public static DataTable dtSchemeShare = new DataTable();
    public static int intAction = 0;

    GlobalFunctions objGlobal = new GlobalFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        intUser = Convert.ToInt64(Session["UserKey"]);
        LoadDetail();

    }

    public void LoadDetail()
    {
        try
        {
            DBLayer objDBLayer = new DBLayer();
            dtSchemeShare = objDBLayer.GetAllSchemeShare();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "error alert", "alert('Error Occured! Try again later..')", true);
        }
    }

    [WebMethod]
    public static List<ListItem> GetReserveCategory()
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.PopulateCommonMaster("Category");
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


    [WebMethod]
    public static string EditSchemeShare(Int64 ShemeShareKey)
    {
        try
        {
            string jsondata = "";
            DBLayer db = new DBLayer();
            jsondata = JsonConvert.SerializeObject(db.GetAllSchemeShare(ShemeShareKey));
            return jsondata;
        }

        catch (Exception ex)
        {
            return null;
        }
    }

    [WebMethod]
    public static void DeleteSchemeShare(Int64 ShemeShareKey)
    {
        try
        {
            DBLayer db = new DBLayer();
            db.DeleteSchemeShare(ShemeShareKey);

        }
        catch (Exception)
        {
           // throw;
        }
    }

    protected static bool CheckDate(String date)
    {
        try
        {
            DateTime dt = DateTime.Parse(date);
            return true;
        }
        catch
        {
            return false;
        }
    }

    [WebMethod]
    public static int CreateScheme(BeneficiaryMaster objBeneficiaryScheme)
    {
        Int32 rowAffected = 0;
        try
        {
            //if (!CheckDate(objBeneficiaryScheme.EffectiveDate))
            //{
            //    rowAffected = -1;
            //}
            if (objBeneficiaryScheme.BeneficiarySchemes.Count == 0)
            {
                rowAffected = -1;
            }
            if (objBeneficiaryScheme.Category == 0 && objBeneficiaryScheme.IsWomen == false)
            {
                rowAffected = -1;
            }
            if ((objBeneficiaryScheme.CShare + objBeneficiaryScheme.SShare) != 100)
            {
                rowAffected = -1;
            }
            if (rowAffected != -1)
            {
                DBLayer objDBLayer = new DBLayer();
                if (objBeneficiaryScheme.MasterId == 0) //Insert
                {
                    objBeneficiaryScheme.IsActive = true;
                    objBeneficiaryScheme.CreatedBy = intUser;
                    rowAffected = objDBLayer.UpdateSchemeShare(objBeneficiaryScheme, false);
                }
                else //update
                {
                    objBeneficiaryScheme.ModifiedBy = intUser;
                    rowAffected = objDBLayer.UpdateSchemeShare(objBeneficiaryScheme, true);
                }
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
        return rowAffected;
    }


}