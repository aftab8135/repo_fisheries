using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

public partial class Applicant_GrievanceStatus : System.Web.UI.Page
{
    public static DataSet TableData = new DataSet();
    public static int intRegKey = 1;
    public static string strRow = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        intRegKey = Convert.ToInt32(Session["ApplicantKey"]);
        if (!IsPostBack)
        {
            string cond = string.Empty;
            DBLayer db = new DBLayer();
            cond = "Where [RegistrationKey]=" + Convert.ToInt32(intRegKey);
            TableData = db.GetComplainByKey(cond);

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
        string cond = "Where [RegistrationKey]=" + intRegKey.ToString();

        try
        {
            if (fromDate != "" && toDate != "")
            {
                cond = cond + " AND  CAST(CONVERT(varchar, ComplainDate, 101) AS DATETIME) BETWEEN  CAST(CONVERT(varchar, '" + GeneralClass.GetDateForDB2(fromDate) + "', 101) AS DATETIME) AND  CAST(CONVERT(varchar, '" + GeneralClass.GetDateForDB2(toDate) + "', 101) AS DATETIME)";

            }

            if (status > 0)
            {
                cond = cond + " AND CurrentStatus=" + status + "";
            }

            if (tokenno != "")
            {
                cond = cond + " AND ComplainTokenNo='" + tokenno + "'";
            }

            //  TableData = db.GetComplainByKey(cond);
            TableData = db.GetComplainByKey(cond);
            return JsonConvert.SerializeObject(TableData.Tables[0]);
        }
        catch (Exception ex)
        {
            
            ex.ToString();
            return null;
        }
    }
}