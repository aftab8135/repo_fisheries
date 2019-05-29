using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

public partial class Administrator_FinancialYear : System.Web.UI.Page
{
    public static DataTable dtFinancialYear = new DataTable();
    private static Int64 intUser = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        intUser = Convert.ToInt64(Session["UserKey"]);
        GetAllData();
    }

    [WebMethod]
    public static string Save(FinYearMaster objFinYearMaster)
    {

        string jsondata = "";
        DBLayer db = new DBLayer();
        if (objFinYearMaster.FinYear.Trim() == "" )
        {
            return "Invalid Entries.";
        }
        if (objFinYearMaster.FinYearKey == 0)
        {
            objFinYearMaster.IsActive = true;
            objFinYearMaster.CreatedBy = intUser;

            if (db.CreateFinYearMaster(objFinYearMaster))
            {
                return "Record Inserted Successfully.";
            }
        }
        else
        {
            objFinYearMaster.LastModifiedBy = intUser;
            string ss = db.UpdateFinYear(objFinYearMaster);
            if (ss == "Exist")
            {
                return "Record Already Exist.";
            }
            else
            {
                return "Record Updated Successfully.";
            }
        }

        return jsondata;
    }

    public void GetAllData()
    {
        DBLayer db = new DBLayer();
        dtFinancialYear = db.GetAllFinYear();
    }

    [WebMethod]
    public static void Delete(int FinYearKey)
    {
        try
        {
            DBLayer db = new DBLayer();
            db.DeleteFinYear(FinYearKey);

        }
        catch (Exception)
        {
            throw;
        }
    }

    [WebMethod]
    public static string Edit(int FinYearKey)
    {
        string jsondata = "";
        DBLayer db = new DBLayer();
        dtFinancialYear = db.GetAllFinYearKey(FinYearKey);
        jsondata = JsonConvert.SerializeObject(dtFinancialYear);
        return jsondata;
    }

    [WebMethod]
    public static string DeActive(int FinYearKey)
    {
        string jsondata = "";
        DBLayer db = new DBLayer();
        FinYearMaster objFinYear = new FinYearMaster();
        objFinYear.FinYearKey = FinYearKey;
        objFinYear.LastModifiedBy = intUser;
        db.DeActiveFinYear(objFinYear);
        return jsondata;
    }
}