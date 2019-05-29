using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

public partial class Administrator_ComplainType : System.Web.UI.Page
{
    public static DataTable dtCompalinType = new DataTable();
    private static Int64 intUser = 0;
    protected void Page_Load(object sender, EventArgs e)
    
    {
        intUser = Convert.ToInt64(Session["UserKey"]);
        GetAllData();
    }

    [WebMethod]
    public static string SaveComplainType(ComplainTypeMaster objComplainTypeMaster)
    {

        string jsondata = "";
        DBLayer db = new DBLayer();
        if (objComplainTypeMaster.ComplainTypeKey == 0)
        {
            objComplainTypeMaster.IsActive = true;
            objComplainTypeMaster.CreatedBy = intUser;
            if (db.CreateComplainTypeMaster(objComplainTypeMaster))
            {
                jsondata = JsonConvert.SerializeObject("insert");
            }
        }
        else
        {
            objComplainTypeMaster.LastModifiedBy = intUser;
            string ss = db.UpdateComplainSourse(objComplainTypeMaster);
            if (ss == "Exist")
            {
                jsondata = JsonConvert.SerializeObject("Exist");
            }
            else
            {
                jsondata = JsonConvert.SerializeObject("update");
            }
        }

        return jsondata;
    }

    public void GetAllData()
    {
        DBLayer db = new DBLayer();
        dtCompalinType = db.GetAllComplainType();
    }

    [WebMethod]
    public static void DeleteComplainType(int ComplainTypeKey)
    {
        try
        {
            DBLayer db = new DBLayer();
            db.DeleteComplainType(ComplainTypeKey);

        }
        catch (Exception)
        {
            throw;
        }
    }

    [WebMethod]
    public static string EditComplainType(int ComplainTypeKey)
    {
        string jsondata = "";
        DBLayer db = new DBLayer();
        dtCompalinType = db.GetAllComplainTypeByKey(ComplainTypeKey);
        jsondata = JsonConvert.SerializeObject(dtCompalinType);
        return jsondata;
    }

    [WebMethod]
    public static string ActivateComplainType(int ComplainTypeKey)
    {
        string jsondata = "";
        DBLayer db = new DBLayer();
        ComplainTypeMaster objMaster = new ComplainTypeMaster();
        dtCompalinType = db.GetAllComplainTypeByKey(ComplainTypeKey);
        if (Convert.ToBoolean(dtCompalinType.Rows[0]["IsActive"]) == true)
        {
            objMaster.IsActive = false;
            jsondata = JsonConvert.SerializeObject("deactivate");
        }
        else
        {
            objMaster.IsActive = true;
            jsondata = JsonConvert.SerializeObject("activate");
        }
        objMaster.ComplainTypeKey = Convert.ToInt16(ComplainTypeKey);
        objMaster.LastModifiedBy = intUser;
        db.ActiveDeactive(objMaster);


        return jsondata;
    }
}