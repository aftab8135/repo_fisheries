using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

public partial class Department_GrievanceStatus : System.Web.UI.Page
{
    public static DataSet TableData = new DataSet();
    public static string strRow = "";

    public static int utype;
    public static int seckey;
    public static int desigkey;
    public static int officerkey;

    protected void Page_PreInit(object sender, EventArgs e)
    {
        //if (Session["OfficerKey"] == null)
        //{
        //    Response.Redirect("../Secure/Login/frm_Login.aspx?Key=2");
        //}

        utype = Convert.ToInt32(Session["UserType"]);
        seckey = Convert.ToInt32(Session["SectionKey"]);
        desigkey = Convert.ToInt32(Session["DesignationKey"]);
        officerkey = Convert.ToInt32(Session["OfficerKey"]);

    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
           
            string cond = string.Empty;
            DBLayer db = new DBLayer();
            if (utype == 2 && officerkey == 45)
            {
                cond = "Where 1=1";
                TableData = db.ReadAllComplainCEO(cond);
            }
            else
            {
                cond = "Where CF.[FromOfficerKey]=" + officerkey.ToString();
                TableData = db.ReadAllComplainByCond(cond);
            }   

        }
    }


    [WebMethod]
    public static List<ListItem> PopulateComplainStatus()
    {
        List<ListItem> Details = new List<ListItem>();
        DBLayer dbl = new DBLayer();
        Details = dbl.PopulateComplainStatusAll();

        return Details;
    }

    [WebMethod]
    public static string GetAllComplainData(string fromDate, string toDate, int status, string tokenno)
    {
        DBLayer db = new DBLayer();
        string cond = string.Empty;
        try
        {
            if (utype == 2 && officerkey == 45)
            {
                cond = "Where 1=1";

            }
            else
            {
                cond = "Where CF.FromOfficerKey=" + officerkey;
            }

            if (fromDate != "" && toDate != "")
            {
                cond = cond + " AND  CAST(CONVERT(varchar, C.ComplainDate, 101) AS DATETIME) BETWEEN  CAST(CONVERT(varchar, '" + GeneralClass.GetDateForDB2(fromDate) + "', 101) AS DATETIME) AND  CAST(CONVERT(varchar, '" + GeneralClass.GetDateForDB2(toDate) + "', 101) AS DATETIME)";

            }


            if (tokenno != "")
            {
                cond = cond + " AND C.ComplainTokenNo='" + tokenno + "'";
            }

            if (utype == 2 && officerkey == 45)
            {
                if (status > 0)
                {
                    if (status == 4 || status == 5 || status == 2)
                    {
                        cond = cond + " AND C.CurrentStatus=" + status + "";
                    }
                    else
                    {
                        cond = cond + " AND CF.Status=" + status + "";
                    }
                }
                TableData = db.ReadAllComplainCEO(cond);
            }
            else
            {
                if (status > 0)
                {
                    cond = cond + " AND CF.Status=" + status + "";
                }

                TableData = db.ReadAllComplainByCond(cond);
            }
          
            return JsonConvert.SerializeObject(TableData.Tables[0]);
        }

        catch (Exception)
        {
            throw;
        }
    }
}