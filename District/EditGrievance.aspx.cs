using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class District_EditGrievance : System.Web.UI.Page
{
    public static DataSet TableData = new DataSet();
    public static DataSet TableData2 = new DataSet();
    public static Int32 ckey;
    public static Int32 fromOfficerKey;

    public static int utype;
    public static int seckey;
    public static int desigkey;
    protected void Page_Load(object sender, EventArgs e)
    {

        DBLayer db = new DBLayer();
        int ckey = Convert.ToInt32(Request.QueryString.Get("cKey"));
        fromOfficerKey = Convert.ToInt32(Session["OfficerKey"].ToString());
        //int ckey = 1;
        //fromOfficerKey = 45;
        if (ckey == 0)
            Response.Redirect("GrievanceStatus.aspx");
        else
        {
            TableData = db.ReadComplainDetail(ckey);
            TableData2 = db.ReadForwardedComplain(ckey, 1);
        }

        if (!Page.IsPostBack)
        {
            try
            {
                if (db.CheckForApproval(fromOfficerKey))
                {
                    ddlStatus.DataSource = db.PopulateComplainStatus().Where(c => c.Value != "1");
                    ddlStatus.DataTextField = "Text";
                    ddlStatus.DataValueField = "Value";
                    ddlStatus.DataBind();
                }
                else
                {
                    ddlStatus.DataSource = db.PopulateComplainStatus().Where(c => c.Value != "1" && c.Value != "4" && c.Value != "5");
                    ddlStatus.DataTextField = "Text";
                    ddlStatus.DataValueField = "Value";
                    ddlStatus.DataBind();
                }


                TableData = db.ReadComplainDetail(ckey);
                TableData2 = db.ReadForwardedComplain(ckey, 2);
            }
            catch (Exception)
            {

                throw;
            }

        }
    }


    [WebMethod]
    public static List<ListItem> GetSection()
    {
        List<ListItem> lstSection = new List<ListItem>();
        DBLayer db = new DBLayer();
        lstSection = db.PopulateSection();
        return lstSection;
    }

    [WebMethod]
    public static List<ListItem> GetOfficerDesignation(int seckey)
    {
        List<ListItem> lst = new List<ListItem>();
        DBLayer db = new DBLayer();
        lst = db.PopulateOfficer(seckey).Where(o => o.Value != fromOfficerKey.ToString()).ToList();
        return lst;
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        DBLayer db = new DBLayer();
        string attachmentfile = "";
        try
        {
            if (!string.IsNullOrEmpty(flAttachmentfile.PostedFile.FileName))
            {
                attachmentfile = GlobalFunctions.GetUniqueFileName(flAttachmentfile.PostedFile.FileName);
                GlobalFunctions.UploadFile(flAttachmentfile,DBLayer.LodgeGrievanceDirectory, attachmentfile);
            }
            int tosectionkey = 0;
            int toofficerkey = 0;
            if (Convert.ToInt32(ddlStatus.SelectedValue) == 2)
            {
                tosectionkey = (hidSection.Value == "" ? seckey : Convert.ToInt32(hidSection.Value));
                toofficerkey = (hidOfficerWithDesig.Value == "" ? Convert.ToInt32(Session["OfficerKey"]) : Convert.ToInt32(hidOfficerWithDesig.Value));
            }
            else
            {
               tosectionkey = 0;
               toofficerkey = 0;
            }
            

            if (db.CreateforwardComplain(ckey, tosectionkey, toofficerkey, Convert.ToInt32(ddlStatus.SelectedValue), fromOfficerKey, attachmentfile, txtRemark.Text, fromOfficerKey, fromOfficerKey))
            {
                txtRemark.Text = "";
                ddlStatus.SelectedValue = "";
                TableData2 = db.ReadForwardedComplain(ckey, 2);

                ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "", "alert('Record Saved Successfully.');", true);

            }
        }
        catch (Exception)
        {
            throw;
        }
    }
}