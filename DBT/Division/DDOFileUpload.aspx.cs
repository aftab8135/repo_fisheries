using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Division_DDOFileUpload : System.Web.UI.Page
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

        if (!IsPostBack)
        {           
            lblMessage.Text = "";
        }
    }

    protected void btnUploadFile_Click(object sender, EventArgs e)
    {
        if (fuGeneratedFile.HasFile)
        {
            string fileName = fuGeneratedFile.PostedFile.FileName;
            List<DBT_GeneratedFileDetail> lst = new List<DBT_GeneratedFileDetail>();
            using (StreamReader sr = new StreamReader(fuGeneratedFile.PostedFile.InputStream))
            {
                string line;
                while ((line = sr.ReadLine()) != null)
                {
                    string[] strGeneratedText = line.Split(',');
                    if (line != "")
                    {
                        lst.Add(new DBT_GeneratedFileDetail
                        {
                            ApplicantName = strGeneratedText[0].ToString(),
                            TransactionNo = strGeneratedText[1].ToString(),
                            IFSCCode = strGeneratedText[2].ToString(),
                            BankName = strGeneratedText[3].ToString(),
                            BranchName = strGeneratedText[4].ToString(),
                            AccountNo = strGeneratedText[5].ToString(),
                            MobileNo = strGeneratedText[6].ToString(),
                            RegistrationNo = strGeneratedText[7].ToString(),
                            CreatedBy = UserKey


                        });
                    }

                }

                string xmlGeneratedFile = GlobalFunctions.ConvertToXMLFormat<DBT_GeneratedFileDetail>(ref lst);
                DBLayer db = new DBLayer();
               int kk= db.InsertFileData(xmlGeneratedFile);
               if (kk > 0)
               {
                   lblMessage.Text = "File Uploaded Successfully.";
               }
               else {
                   lblMessage.Text = "Somthing went wrong.";
               }
                
            }
        }
    }
}