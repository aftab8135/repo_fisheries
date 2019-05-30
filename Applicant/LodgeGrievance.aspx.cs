using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Applicant_LodgeGrievance : System.Web.UI.Page
{
    private static Int64 intUser = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        intUser = Convert.ToInt64(Session["ApplicantKey"]);
    }

    [WebMethod]
    public static List<ListItem> PopulateComplainSource()
    {
        List<ListItem> Details = new List<ListItem>();
        DBLayer dbl = new DBLayer();
        Details = dbl.PopulateComplainSource();

        return Details;
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
    public static List<ListItem> PopulateComplainSubType(int ComplainTypeKey)
    {
        List<ListItem> Details = new List<ListItem>();
        DBLayer dbl = new DBLayer();
        Details = dbl.PopulateComplainSubType(ComplainTypeKey);

        return Details;
    }

    private void complainSMS_Email(string complainerName, string complainNo, string emaild, string mobileNo)
    {
        if (chkSMS.Checked)
        {
            if (mobileNo != "" && mobileNo.Length == 10)
            {
                GlobalFunctions.SendSMSN("Dear " + CultureInfo.CurrentCulture.TextInfo.ToTitleCase(complainerName.ToLower()) + ", Your Grievance Has been Registered Successfully.  Grievance No: " + complainNo + " You can track your status on http://www.fisheriesmis.data-center.co.in/", mobileNo);
            }
        }
        if (chkEmail.Checked)
        {
            if (emaild != "")
            {
                string body = "";
                body += "*******This is an automated message. Please do not reply*******<br/><br/>";
                body += "<b> Dear Applicant,<br/><br/><span style='color:#0094ff'>Mr. /Mrs. " + CultureInfo.CurrentCulture.TextInfo.ToTitleCase(complainerName.ToLower()) + "</span>,</b><br/><br/>";

                body += "Your Grievance has been registered successfully. Please Note down Your Grievance Number <span style='color:red'> <b>" + complainNo + "</span></b><br/>  for Future communication with Fisheries Department.<br/>";
                body += "<br/>You can track your grievance status on  <span style='color:blue'><b> http://www.fisheriesmis.data-center.co.in/ </b></span>.<br/><br/>";
                body += "With Regards,<br/><br/> <b>GIDA, Gorakhpur </b> <br/>( Uttar Pradesh )";
                body += "<br/>";
                body += "<br/>";

                GlobalFunctions.SendMail(emaild, body, "Fisheries Grievances Registration intimation");
            }
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        //ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "", "ShowLoader();", true);
        if (hidComplainSource.Value.ToString() == "" || hidComplainType.Value.ToString() == "" || hidComplainSubType.Value.ToString() == "")
        {
            return;
        }

        int cs = Convert.ToInt32(hidComplainSource.Value.ToString());
        int ct = Convert.ToInt32(hidComplainType.Value.ToString());
        int cst = Convert.ToInt32(hidComplainSubType.Value.ToString());

        if (cs == 0 || ct == 0 || cst == 0 || txtDetail.Text.Trim() == "")
            return;

        DBLayer db = new DBLayer();
        string attachmentfile = "";
        //int regKey = intUser;
        int regKey = Convert.ToInt32(Session["ApplicantKey"]);

        try
        {
            if (!string.IsNullOrEmpty(fuAttachment.PostedFile.FileName))
            {
                attachmentfile = GlobalFunctions.GetUniqueFileName(fuAttachment.PostedFile.FileName);
                GlobalFunctions.UploadFile(fuAttachment, DBLayer.LodgeGrievanceDirectory, attachmentfile);
            }
            string notifyby = "";
            if (chkEmail.Checked)
            {
                notifyby = "Email";
            }
            if (chkSMS.Checked)
            {
                if (notifyby == "")
                {
                    notifyby = "SMS";
                }
                else
                {
                    notifyby = notifyby + "/SMS";
                }
            }

            int complainstatus = 1;
            string tokenno = db.GenerateTokenNo();
            int kk = db.CreateComplain(cs, ct, cst, txtDetail.Text, attachmentfile, tokenno, notifyby, regKey, regKey, true, complainstatus, 1, "");
            if (kk == 0)
            {
                return;
            }
            else
            {

                DataSet ds = new DataSet();

                ds = db.GetCandidateDetail(regKey);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    //complainSMS_Email(ds.Tables[0].Rows[0]["FullName"].ToString(), tokenno, ds.Tables[0].Rows[0]["EmailId"].ToString(), ds.Tables[0].Rows[0]["MobileNo"].ToString());
                }

                txtDetail.Text = "";
                chkEmail.Checked = false;
                chkSMS.Checked = true;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Record saved sucessfully');window.location ='PrintReceipt.aspx?ckey="+kk+"&type=S';", true);
            }
        }
        catch (Exception ex)
        {
            ex.ToString();
        }
    }
}