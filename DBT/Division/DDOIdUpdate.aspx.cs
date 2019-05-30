using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Division_DDOIdUpdate : System.Web.UI.Page
{
    public static Int64 UserKey;
    public static string UserName;
    public static int DivisionKey;
    public static string FinYear;
    protected void Page_Load(object sender, EventArgs e)
    {
        UserKey = Convert.ToInt64(Session["UserKey"]);
        UserName = Session["UserName"].ToString();
        DivisionKey = Convert.ToInt32(Session["DivisionKey"]);
        FinYear = Session["FinancialYear"].ToString();

        lblFinYear.Text = FinYear;
        lblLoginType.Text = UserName;
    }

    [WebMethod]
    public static string MappedBeneficiaryId(String RegistrationNo, String BeneficiaryId)
    {
        string strMsg = "";
        try
        {
            DBLayer objDBLayer = new DBLayer();

            int kk = objDBLayer.MappedBeneficiaryID(RegistrationNo, BeneficiaryId, UserKey);
            if (kk == 1)
            {
                strMsg = "बेनेफिसिअरी आई. डी. सत्यापित हो गयी है|";
            }
            else
            {
                strMsg = "पंजीकरण संख्या उपलब्ध नहीं है|";
            }

            return strMsg;
        }
        catch (Exception ex)
        {
            return strMsg = "";
        }

    }
}