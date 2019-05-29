using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

public partial class Administrator_wfUser : System.Web.UI.Page
{
    private static Int64 intUser = 0;
    public static DataTable dtUserDetail = new DataTable();

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
            dtUserDetail = objDBLayer.GetDeptUserForSU();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "error alert", "alert('Error Occured! Try again later..')", true);
        }
    }

    [WebMethod]
    public static List<ListItem> GetDistricts()
    {
        try
        {
            return new DBLayer().PopulateDistrict(0);
        }
        catch (Exception)
        {

            return null;
        }
    }

    [WebMethod]
    public static List<ListItem> GetLoginType()
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.GetDeptLoginType();
        }
        catch (Exception ex)
        {
            return null;
        }
    }

    [WebMethod]
    public static string EditUserDetail(Int64 UserKey)
    {
        try
        {
            string jsondata = "";
            DBLayer db = new DBLayer();
            jsondata = JsonConvert.SerializeObject(db.GetDeptUserForSU(UserKey));
            return jsondata;
        }

        catch (Exception ex)
        {
            return null;
        }
    }

    [WebMethod]
    public static int CreateUser(UserMaster objUserMaster, int isUpdate)
    {
        Int32 rowAffected = 0;
        try
        {
            if (objUserMaster.UserType == 0)
            {
                rowAffected = -1;
            }
            if (objUserMaster.Name == "")
            {
                rowAffected = -1; 
            }
            if (objUserMaster.Gender == "")
            {
                rowAffected = -1;
            }
            if (rowAffected == 0)
            {
                if (isUpdate == 0)
                {
                    string userid = objUserMaster.Name.Trim().ToUpper().Replace(" ", "").Substring(0, 4).ToUpper()+ GetRandom(4, 0, 9);
                    string pass = objUserMaster.Name.Trim().ToUpper().Replace(" ", "").Substring(0, 4).ToUpper() + "@1234"; 
                    
                    DBLayer objDBLayer = new DBLayer();
                    objUserMaster.UserName = userid;
                    objUserMaster.Password = pass;
                    objUserMaster.CreatedBy = intUser;
                    rowAffected = objDBLayer.UpdateDeptUser(objUserMaster, false);
                    if (rowAffected > 0)
                    {
                        string sms = "Dear " + objUserMaster.Name.Trim().ToUpper() + ", You have Successfully Registered for Online Fishries Department. User ID: " + userid + " and Password: " + pass + ". Kindly login and complete your profile.";
                    }
                         
                }
                else
                {
                    DBLayer objDBLayer = new DBLayer();
                    objUserMaster.LastModifiedBy = intUser;
                    rowAffected = objDBLayer.UpdateDeptUser(objUserMaster, true);
                }

            }
            return rowAffected;

        }
        catch (Exception ex)
        {
            return -1;
        }
    }

    private static string GetRandom(int digit, int min, int max)
    {
        string str = "";

        Random rnd = new Random();
        for (int i = 0; i < digit; i++)
        {
            str += rnd.Next(min, max).ToString();
        }

        return str;
    }

    [WebMethod]
    public static void DeleteUser(Int64 ID)
    {
        try
        {
            DBLayer db = new DBLayer();
            db.DeleteUser(ID);

        }
        catch (Exception)
        {
            throw;
        }
    }

    [WebMethod]
    public static void DeleteRole(Int64 ID)
    {
        try
        {
            DBLayer db = new DBLayer();
            db.DeleteRole(ID);

        }
        catch (Exception)
        {
            throw;
        }
    }
}