using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

public partial class Administrator_BudgetBooking : System.Web.UI.Page
{
    private static Int64 intUser = 0;
    public static int DistrictKey;
    public static DataTable dtDetail = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        DistrictKey = Convert.ToInt32(Session["DistrictKey"]);
        intUser = Convert.ToInt64(Session["UserKey"]);
        LoadDetail();
    }

    public void LoadDetail()
    {
        try
        {
            DBLayer objDBLayer = new DBLayer();
            dtDetail = objDBLayer.GetAllBud_DeptBooking();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "error alert", "alert('Error Occured! Try again later..')", true);
        }
    }

    [WebMethod]
    public static List<ListItem> GetFinancialYear()
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.PopulateFinancialYear();
        }
        catch (Exception ex)
        {

            return null;
        }

    }

    [WebMethod]
    public static List<ListItem> GetBudgetType()
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.PopulateCommonMaster("BudgetType");
        }
        catch (Exception ex)
        {

            return null;
        }

    }

    [WebMethod]
    public static List<ListItem> GetBank()
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.PopulateBank(DistrictKey);
        }
        catch (Exception ex)
        {

            return null;
        }

    }
    [WebMethod]
    public static List<ListItem> GetPaymentType()
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.PopulateCommonMaster("PaymentType");
        }
        catch (Exception ex)
        {

            return null;
        }

    }

    [WebMethod]
    public static List<ListItem> GetAccountType()
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.PopulateCommonMaster("AccountType");
        }
        catch (Exception ex)
        {

            return null;
        }

    }

    [WebMethod]
    public static List<ListItem> GetFundSource()
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.PopulateCommonMaster("FundSource");
        }
        catch (Exception ex)
        {

            return null;
        }

    }

    [WebMethod]
    public static List<ListItem> GetSchemes()
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.GetSchemesForSelect();
        }
        catch (Exception ex)
        {

            return null;
        }

    }

    [WebMethod]
    public static List<ListItem> GetDeptObject()
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.PopulateObjectMaster();
        }
        catch (Exception ex)
        {

            return null;
        }

    }

    [WebMethod]
    public static List<ListItem> GetHead()
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.PopulateBudgetHead();
        }
        catch (Exception ex)
        {

            return null;
        }

    }

    [WebMethod]
    public static string Create(Bud_DeptBooking objBud_DeptBooking)
    {
        string resultMsg = "";
        try
        {
            DBLayer objDBLayer = new DBLayer();
            if (objBud_DeptBooking.BookingKey == 0) //Insert
            {
                objBud_DeptBooking.CreatedBy = intUser;
                bool rowAffected = objDBLayer.CreateBudgetDeptBooking(objBud_DeptBooking, false);
                if (rowAffected)
                    resultMsg = "Recored Saved Successfully";
            }
            else //update
            {
                objBud_DeptBooking.LastModifiedBy = intUser;
                bool rowAffected = objDBLayer.CreateBudgetDeptBooking(objBud_DeptBooking, true);
                if (rowAffected)
                    resultMsg = "Recored Updated Successfully";
            }

        }
        catch (Exception ex)
        {
            resultMsg = "Something Went Wrong.";

        }
        return resultMsg;
    }

    [WebMethod]
    public static string Edit(Int64 intBookingKey)
    {
        try
        {
            string jsondata = "";
            DBLayer db = new DBLayer();
            jsondata = JsonConvert.SerializeObject(db.GetAllBud_DeptBooking(intBookingKey));
            return jsondata;
        }

        catch (Exception ex)
        {
            return null;
        }
    }

    [WebMethod]
    public static void Delete(Int64 intBookingKey)
    {
        try
        {
            DBLayer db = new DBLayer();
            db.DeleteBud_DeptBooking(intBookingKey);
        }
        catch (Exception)
        {
            throw;
        }
    }

   
}