using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Secure_Login_ChangePassword : System.Web.UI.Page
{
    public int usertype;
    public int Userkey;

    protected void Page_PreInit(object sender, EventArgs e)
    {
        usertype = Convert.ToInt32(Session["UserType"]);
        if (usertype == 5)
        {
            this.MasterPageFile = "~/MasterPages/DistrictMaster.master";
        }
        else if (usertype == 6)
        {
            this.MasterPageFile = "~/MasterPages/DivisionMaster.master";
        }
        else if (usertype == 4)
        {
            this.MasterPageFile = "~/MasterPages/HOMaster.master";
        }
        else if (usertype == 7)
        {
            this.MasterPageFile = "~/MasterPages/ShasanMaster.master";
        }
        else if (usertype == 1)
        {
            this.MasterPageFile = "~/MasterPages/AdministratorMaster.master";
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        Userkey = Convert.ToInt32(Session["UserKey"]);
    }

    [WebMethod]
    public static int UserChangePassword(string Curr_Password, string New_Password)
    {
        DBLayer db = new DBLayer();
        int ukey = Convert.ToInt32(HttpContext.Current.Session["UserKey"]);
        int k = db.ChangePassword(ukey, Curr_Password, New_Password);
        return k;
    }
}