using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

public partial class Administrator_ObjectMaster : System.Web.UI.Page
{
    public static DataTable dtObjectMaster = new DataTable();
    private static Int64 intUser = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        intUser = Convert.ToInt64(Session["UserKey"]);
        GetAllData();
    }

    [WebMethod]
    public static string Save(ObjectMaster objObjectMaster)
    {

        string jsondata = "";
        DBLayer db = new DBLayer();
        if ((objObjectMaster.ObjectEnglishName.Trim() =="" && objObjectMaster.ObjectHindiName.Trim() =="")|| objObjectMaster.ObjectCode.Trim() == "")
        {
            return "Invalid Entries.";
        }
        if (objObjectMaster.ObjectKey == 0)
        {
            objObjectMaster.IsActive = true;
            objObjectMaster.CreatedBy = intUser;

            if (db.CreateObjectMaster(objObjectMaster))
            {
                return "Record Inserted Successfully.";
            }
        }
        else
        {
            objObjectMaster.LastModifiedBy = intUser;
            string ss = db.UpdateObjectMaster(objObjectMaster);
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
        dtObjectMaster = db.GetAllObjectMaster();
    }

    [WebMethod]
    public static void Delete(int ObjectKey)
    {
        try
        {
            DBLayer db = new DBLayer();
            db.DeleteObjectMaster(ObjectKey);

        }
        catch (Exception)
        {
            throw;
        }
    }

    [WebMethod]
    public static string Edit(int ObjectKey)
    {
        string jsondata = "";
        DBLayer db = new DBLayer();
        dtObjectMaster = db.GetAllObjectMasterByKey(ObjectKey);
        jsondata = JsonConvert.SerializeObject(dtObjectMaster);
        return jsondata;
    }

    [WebMethod]
    public static string DeActive(int ObjectKey)
    {
        string jsondata = "";
        DBLayer db = new DBLayer();
        ObjectMaster objMaster = new ObjectMaster();
        objMaster.ObjectKey = ObjectKey;
        objMaster.LastModifiedBy = intUser;
        db.ActiveDeactiveObjectMaster(objMaster);
        return jsondata;
    }
}