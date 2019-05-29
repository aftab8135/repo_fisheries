using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Administrator_wfRTI : System.Web.UI.Page
{
    private static Int64 intUser = 0;
    public static DataTable dtRTIDetail = new DataTable();
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
            dtRTIDetail = objDBLayer.GetAllRTI();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "error alert", "alert('Error Occured! Try again later..')", true);
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
    public static int CreateRTI(RTIMaster objRTI)
    {
        Int32 rowAffected = 0;
        try
        {
            if (!CheckDate(objRTI.EffectiveDate))
            {
                rowAffected = -1;
            }
            if (objRTI.Amount == 0)
            {
                rowAffected = -1;
            }
            if (rowAffected != -1)
            {
                DBLayer objDBLayer = new DBLayer();
                objRTI.CreatedBy = intUser;
                objRTI.LastModifiedBy = intUser;
                rowAffected = objDBLayer.UpdateRTI(objRTI);
            }
            return rowAffected;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public static void DeleteRTI(Int64 MasterKey)
    {
        try
        {
            DBLayer db = new DBLayer();
            db.DeleteRTI(MasterKey);

        }
        catch (Exception)
        {
            throw;
        }
    }
}