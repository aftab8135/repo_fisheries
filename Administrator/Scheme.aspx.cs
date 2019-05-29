using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;


public partial class Administrator_Scheme : System.Web.UI.Page
{
    public static DataTable DocTypes = new DataTable();
    public static DataTable dtSchemeDetail = new DataTable();

    public static int intAction = 0;

    private static Int64 intUser = 0;

    private string errorMsgs = "";
    GlobalFunctions objGlobal = new GlobalFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        intUser = Convert.ToInt64(Session["UserKey"]);
        if (!IsPostBack)
        {
            hfGuidelineDoc.Value = "";
            if (hfSchemeKey.Value.Trim() != "")
            {
                if (File.Exists(Server.MapPath("~/" + DBLayer.SchemeGuidlineDirectory + "/" + "<FileName>")))
                {
                    hfGuidelineDoc.Value = "";
                }
                else
                {

                }
            }
            GetLoadDocument();
            LoadDetail();
        }

    }

    [WebMethod]
    public static List<ListItem> GetSchemesType()
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.GetAllSchemeType();
        }
        catch (Exception ex)
        {

            return null;
        }
    }

    public void LoadDetail()
    {
        try
        {
            DBLayer objDBLayer = new DBLayer();
            dtSchemeDetail = objDBLayer.GetAllScheme();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "error alert", "alert('Error Occured! Try again later..')", true);
        }
    }

    public void GetLoadDocument()
    {
        try
        {
            DBLayer objDBLayer = new DBLayer();
            DocTypes = objDBLayer.GetDocumentType();

            ddlDocument.DataSource = DocTypes;
            ddlDocument.DataTextField = "DocumentName";
            ddlDocument.DataValueField = "DocumentID";

            ddlDocument.DataBind();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "error alert", "alert('Error Occured! Try again later..')", true);
        }
    }

    protected void ClearControl()
    {
        try
        {
            txtSchemeCode.Text = "";
            txtSchemeName.Text = "";
            txtDescription.Text = "";
            txtEndDate.Text = "";
            txtStartDate.Text = "";

            ddlDocument.SelectedIndex = -1;

            GetLoadDocument();

        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "error alert", "alert('Error Occured! Try again later..')", true);
        }
    }

    [WebMethod]
    public static string EditScheme(Int64 SchemeKey)
    {
        try
        {
            string jsondata = "";
            DBLayer db = new DBLayer();
            jsondata = JsonConvert.SerializeObject(db.GetAllScheme(SchemeKey));
            return jsondata;
        }

        catch (Exception ex)
        {
            return null;
        }
    }

    [WebMethod]
    public static void DeleteScheme(Int64 SchemeKey)
    {
        try
        {
            DBLayer db = new DBLayer();
            db.DeleteScheme(SchemeKey);

        }
        catch (Exception)
        {
            throw;
        }
    }

    [WebMethod]
    public static void DeActiveScheme(Int64 SchemeKey)
    {
        try
        {
            DBLayer db = new DBLayer();
            SchemeMaster objSchemeMaster = new SchemeMaster();
            objSchemeMaster.SchemeKey = SchemeKey;
            objSchemeMaster.LastModifiedBy = intUser;
            db.DeActiveScheme(objSchemeMaster);

        }
        catch (Exception)
        {
            throw;
        }
    }
    protected bool CheckDate(String date)
    {
        try
        {
           return GeneralClass.IsDateTime(GeneralClass.GetDateForUI(date));
        }
        catch
        {
            return false;
        }
    }
    protected bool CheckRequired()
    {

        bool ishasError = false;
        if (txtSchemeCode.Text.Trim() == "")
        {
            errorMsgs = errorMsgs + "Please Fill Scheme Code.";
            ishasError = true;
        }
        if (txtSchemeName.Text.Trim() == "")
        {
            errorMsgs =errorMsgs + "Please Fill Scheme Name.";
            ishasError = true;
        }
        if (txtDescription.Text.Trim() == "")
        {
            errorMsgs = errorMsgs + "Please Fill Description.";
            ishasError = true;
        }
        
        //if (!CheckDate(txtStartDate.Text))
        //{
        //    errorMsgs = errorMsgs + "Please Input Correct Start Date";
        //    ishasError = true;
        //}
        //if (!CheckDate(txtEndDate.Text))
        //{
        //    errorMsgs = errorMsgs + "Please Input Correct End File.";
        //    ishasError = true;
        //}
        //if (!CheckDate(txtStartDate.Text) && !CheckDate(txtEndDate.Text))
        //{
        //    if (DateTime.Parse(txtStartDate.Text) > DateTime.Parse(txtEndDate.Text))
        //    {
        //        errorMsgs = errorMsgs + "Invalid Effective Date Range.";
        //        ishasError = true;
        //    }
        //}


        int lstSelectCount = 0;
        foreach (ListItem listItem in ddlDocument.Items)
        {
            if (listItem.Selected)
            {
                lstSelectCount++;
            }
        }
        if (lstSelectCount == 0)
        {
            errorMsgs = errorMsgs + "Please Choose Document.";
            ishasError = true;
        }

        return ishasError;
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (intUser == 0) { return; }
            if (CheckRequired())
            {
                ScriptManager.RegisterStartupScript(this, typeof(Page), "Warning!", "alert('" + errorMsgs + "');", true);
            }
            else
            {
                SchemeMaster objSchemeMaster = new SchemeMaster();
                if (hfSchemeKey.Value != "")
                {
                    objSchemeMaster.SchemeKey = Convert.ToInt64(hfSchemeKey.Value);             
                }
                else
                    objSchemeMaster.IsActive = true;

                objSchemeMaster.SchemeCode = txtSchemeCode.Text;
                objSchemeMaster.SchemeName = txtSchemeName.Text;
                objSchemeMaster.Description = txtDescription.Text;
                objSchemeMaster.SchemeTypeKey = Convert.ToInt64(hfSchemeTypeKey.Value);
                objSchemeMaster.FY_Year = "";
                objSchemeMaster.Start_date = txtStartDate.Text;
                objSchemeMaster.End_Date = txtEndDate.Text;
                

                List<SchemeDocument> objDocuments = new List<SchemeDocument>();

                foreach (ListItem listItem in ddlDocument.Items)
                {
                    if (listItem.Selected)
                    {
                        objDocuments.Add(new SchemeDocument()
                        {
                            DocumentId = int.Parse((listItem.Value))
                        });
                    }
                }

                objSchemeMaster.Documents = objDocuments;

                string attachmentfile = "";
                if (hfGuidelineDoc.Value == "")
                {
                    if (!string.IsNullOrEmpty(fuGuidlines.PostedFile.FileName))
                    {
                        attachmentfile = GlobalFunctions.GetUniqueFileName(fuGuidlines.PostedFile.FileName);
                        GlobalFunctions.UploadFile(fuGuidlines, DBLayer.SchemeGuidlineDirectory, attachmentfile);
                    }
                }
                else
                {
                    attachmentfile = hfGuidelineDoc.Value;
                }

                objSchemeMaster.GuidelinesUrl = attachmentfile;

                DBLayer objDBLayer = new DBLayer();
                if (objSchemeMaster.SchemeKey == 0) //Insert
                {
                    objSchemeMaster.CreatedBy = intUser;
                    Int32 rowAffected = objDBLayer.UpdateScheme(objSchemeMaster, false);
                    if (rowAffected > 0)
                    {
                        ClearControl();
                        //Saved Successfully.
                        LoadDetail();

                        ScriptManager.RegisterStartupScript(this, typeof(Page), "success alert", "alert('Record Saved Successfully.');window.location.href = '../Administrator/Scheme.aspx';", true);

                    }
                }
                else //update
                {
                    objSchemeMaster.LastModifiedBy = intUser;
                    Int32 rowAffected = objDBLayer.UpdateScheme(objSchemeMaster, true);
                    if (rowAffected > 0)
                    {
                        ClearControl();
                        LoadDetail();

                        ScriptManager.RegisterStartupScript(this, typeof(Page), "success alert", "alert('Record Updated Successfully.');window.location.href = '../Administrator/Scheme.aspx';", true);

                    }
                }

            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, typeof(Page), "error alert", "alert('Something Went Wrong!');", true);
        }
    }
}