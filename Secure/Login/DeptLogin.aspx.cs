using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Services;
using System.Web.Security;

public partial class Secure_Login_DeptLogin : System.Web.UI.Page
{
    protected void Page_Init(object sender, EventArgs e)
    {
        Session.Clear();
        Session.Abandon();

        Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
       
    }

    [WebMethod]
    public static List<ListItem> GetLoginType()
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.GetDeptLoginTypebyKey();
        }
        catch (Exception ex)
        {
            return null;
        }
    }

    [System.Web.Services.WebMethod]
    public static string[] UserLogins(FisheriesMIS.App_Code.UserMaster objUserMaster)
    {
        

        DBLayer db = new DBLayer();
        //   int k = db.UserExistDept(txtuername.Text, objUserMaster.Password);

        int k = db.UserExistDept(objUserMaster.UserName, objUserMaster.Password);
        if (k == 0)
        {
            string description = "Invalid" + "," + "0";
            string[] a = description.Split(',');
            return a;
        }
        else if (k == 2)
        {
            string description = "NotActive" + "," + "0";
            string[] a = description.Split(',');
            return a;
        }
        else
        {

            Secure_Login_DeptLogin sl = new Secure_Login_DeptLogin();

            string[] a = sl.getUserDetail(objUserMaster.UserName, objUserMaster.Password);
            return a;
        }
    }


    public string[] getUserDetail(string uname, string pwd)
    {

        DBLayer db = new DBLayer();
        DataTable dt = new DataTable();
        dt = db.GetDeptUserMaster(uname, pwd);
        string[] User ={};
        if (dt.Rows.Count < 1)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Error occured!!.!!')", true);         
        }
        else
        {
            Session["UserType"] = dt.Rows[0]["UserType"].ToString();
            Session["UserKey"] = dt.Rows[0]["UserKey"].ToString();
            Session["UserName"] = dt.Rows[0]["UserName"].ToString();
            Session["OfficerKey"] = dt.Rows[0]["OfficeKey"].ToString();
            Session["Uname"] = dt.Rows[0]["Name"].ToString();
            Session["DistrictKey"] = dt.Rows[0]["DistrictKey"].ToString();
       
            string strUser = dt.Rows[0]["UserType"].ToString();
              User  = strUser.Split(',');
        }
        return User;
    }


    protected void btnHome_Click(object sender, EventArgs e)
    {
        Response.Redirect("../../Default.aspx");
    }
}