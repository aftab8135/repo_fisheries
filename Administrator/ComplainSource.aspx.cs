using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

public partial class Administrator_ComplainSource : System.Web.UI.Page
{
    public static DataTable dtCompalinSource = new DataTable();
    private static Int64 intUser = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        intUser = Convert.ToInt64(Session["UserKey"]);
        GetAllData();
    }

    [WebMethod]
    public static string SaveComplainSourse(ComplainSource objSourceMaster)
    {

        string jsondata = "";
        DBLayer db = new DBLayer();
        if (objSourceMaster.ComplainSourceKey == 0)
        {
            objSourceMaster.IsActive = true;
            objSourceMaster.CreatedBy = intUser;
            if (db.CreateComplainSourseMaster(objSourceMaster))
            {
                jsondata = JsonConvert.SerializeObject("insert");
            }
        }
        else
        {
            objSourceMaster.LastModifiedBy = intUser;
            string ss = db.UpdateComplainSourse(objSourceMaster);
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
        dtCompalinSource = db.GetAllComplainSourse();
    }

    [WebMethod]
    public static void DeleteComplainSource(int Sourcekey)
    {
        try
        {
            DBLayer db = new DBLayer();
            db.DeleteComplainSourse(Sourcekey);

        }
        catch (Exception)
        {
            throw;
        }
    }

    [WebMethod]
    public static string EditComplainSource(int Sourcekey)
    {
        string jsondata = "";
        DBLayer db = new DBLayer();
        dtCompalinSource = db.GetAllComplainSourseByKey(Sourcekey);
        jsondata = JsonConvert.SerializeObject(dtCompalinSource);
        return jsondata;
    }

    [WebMethod]
    public static string ActivateComplainSource(int Sourcekey)
    {
        string jsondata = "";
        DBLayer db = new DBLayer();
        ComplainSource objMaster = new ComplainSource();
        dtCompalinSource = db.GetAllComplainSourseByKey(Sourcekey);
        if (Convert.ToBoolean(dtCompalinSource.Rows[0]["IsActive"]) == true)
        {
            objMaster.IsActive = false;
            jsondata = JsonConvert.SerializeObject("deactivate");
        }
        else
        {
            objMaster.IsActive = true;
            jsondata = JsonConvert.SerializeObject("activate");
        }
        objMaster.ComplainSourceKey = Convert.ToInt16(Sourcekey);
        objMaster.LastModifiedBy = intUser;
        db.ActiveDeactiveComplainSourse(objMaster);


        return jsondata;
    }
}