using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

public partial class Administrator_ComplainSubType : System.Web.UI.Page
{
    private static Int64 intUser = 0;
    public static DataTable dtSubType = new DataTable();
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
            dtSubType = objDBLayer.GetAllComplainSubType();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "error alert", "alert('Error Occured! Try again later..')", true);
        }
    }

    [WebMethod]
    public static List<ListItem> PopulateComplainType()
    {
        List<ListItem> Details = new List<ListItem>();
        DBLayer dbl = new DBLayer();
        Details = dbl.PopulateComplainType();

        return Details;

    }

    [WebMethod]
    public static int CreateSubType(ComplainSubType objComplainSubType)
    {
        Int32 rowAffected = 0;
        try
        {
            if (objComplainSubType.SubTypeName.Trim() == "")
            {
                rowAffected = -1;
            }
            if (objComplainSubType.ComplainTypeKey == 0)
            {
                rowAffected = -1;
            }
            if (objComplainSubType.DesignationKey == 0)
            {
                rowAffected = -1;
            }
            if (objComplainSubType.SectionKey == 0)
            {
                rowAffected = -1;
            }
            if (objComplainSubType.TimeFrame == 0)
            {
                rowAffected = -1;
            }
            if (rowAffected != -1)
            {
                DBLayer objDBLayer = new DBLayer();
                if (objComplainSubType.SubTypeKey == 0) //Insert
                {
                    objComplainSubType.CreatedBy = intUser;
                    rowAffected = Convert.ToInt16(objDBLayer.CreateComplainSubType(objComplainSubType, false));
                }
                else //update
                {
                    objComplainSubType.LastModifiedBy = intUser;
                    rowAffected = Convert.ToInt16(objDBLayer.CreateComplainSubType(objComplainSubType, true));
                }
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
        return rowAffected;
    }

    [WebMethod]
    public static List<ListItem> BindDesignation()
    {
        List<ListItem> Details = new List<ListItem>();
        DBLayer dbl = new DBLayer();
        Details = dbl.PopulateDesignation();
        return Details;
    }

    [WebMethod]
    public static List<ListItem> BindSection()
    {
        List<ListItem> Details = new List<ListItem>();
        DBLayer dbl = new DBLayer();
        Details = dbl.PopulateSection();
        return Details;
    }

    [WebMethod]
    public static void DeleteComplainType(int SubTypeKey)
    {
        try
        {
            DBLayer db = new DBLayer();
            db.DeleteComplainSubType(SubTypeKey);

        }
        catch (Exception)
        {
            throw;
        }
    }

    [WebMethod]
    public static string EditComplainType(int SubTypeKey)
    {
        string jsondata = "";
        DBLayer db = new DBLayer();
        dtSubType = db.GetAllComplainSubType(SubTypeKey);
        jsondata = JsonConvert.SerializeObject(dtSubType);
        return jsondata;
    }

}