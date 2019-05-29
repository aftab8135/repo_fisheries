using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Script.Services;
using System.Web.Script.Serialization;
using System.Data.SqlClient;
using System.Data;

public partial class District_GetAwasYogna : System.Web.UI.Page
{
    DBLayer db = new DBLayer();
    Int16 dist = 0;
    Int16 no = 0;
    String Title = "";
    String type = "";
    System.Data.DataSet ds = new System.Data.DataSet();
    System.Data.DataTable dt = new System.Data.DataTable();
    DateTime dtfrm = Convert.ToDateTime("01/01/0001");
    DateTime dtto = Convert.ToDateTime("01/01/0001");
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            Awayojana objdetails = new Awayojana();
            objdetails.DistrictKey = Convert.ToInt16(Session["DistrictKey"].ToString());
            ds = db.getmandal(objdetails.DistrictKey);
            ddlMandel.Text = ds.Tables[0].Rows[0]["divisionKey"].ToString();
            MandalName.Text = ds.Tables[0].Rows[0]["DivisionEnglish"].ToString();
            ddlDistrict.Text = ds.Tables[0].Rows[0]["DistrictKey"].ToString();
            DistName.Text = ds.Tables[0].Rows[0]["EnglishName"].ToString();

            ddlScheme.DataSource = db.PopulateScheme(1);
            ddlScheme.DataTextField = "Text";
            ddlScheme.DataValueField = "Value";
            ddlScheme.DataBind();
            ddlScheme.Items.Insert(0, new ListItem { Text = "Select Scheme Name", Value = "" });



            string data = string.Empty;

            Int32 var = 0;


            var = Convert.ToInt32(ddlDistrict.Text);

            ddlBlock.DataSource = db.PopulateDistrictMondalwise(var);

            ddlBlock.DataTextField = "Text";
            ddlBlock.DataValueField = "Value";
            ddlBlock.DataBind();
            ddlBlock.Items.Insert(0, new ListItem { Text = "Select Vikas Khand", Value = "" });



            getdetailsgrid();
        }
    }


    protected void rptlog_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            if (e.Item.ItemIndex == 0)
            {
                string str = e.Item.ItemIndex.ToString();
            }

            Int16 xx = Convert.ToInt16(e.CommandArgument.ToString());
            Awayojana objDetail = new Awayojana();
            objDetail.AlottmentKey = xx;
            db.Read(objDetail);
            txtapplicant.Text = objDetail.ApplicantName;
            txtVillagename.Text = objDetail.VillageName;
            txtDOB.Text = Convert.ToString(objDetail.DOB);
            txtfundallotment.Text = objDetail.fundallotbydept.ToString();
            txtmobile.Text = objDetail.ApplicantMobileno;
            txtAadhar.Text = objDetail.ApplicantAadhar;
            txtaddress.Text = objDetail.ApplicantAddress;
            ddlBlock.SelectedValue = objDetail.BlockKey.ToString();


        }
    }


    protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "Update")
        {
            if (e.Item.ItemIndex == 0)
            {
                string str = e.Item.ItemIndex.ToString();
            }

            Int16 xx = Convert.ToInt16(e.CommandArgument.ToString());
            Awayojana objDetail = new Awayojana();
            objDetail.AlottmentKey = xx;
            db.Read(objDetail);
            objDetail.first_for_month = String.Format("{0:MMMM}", DateTime.Now);
            objDetail.First_for_year = String.Format("{0:yyyy}", DateTime.Now);

            //      RepeaterItem item = box.NamingContainer as RepeaterItem;
            TextBox box = e.Item.FindControl("txtremark") as TextBox;



            objDetail.first_remarks = box.Text;
            TextBox firstins = e.Item.FindControl("txtfirstinstallment") as TextBox;
            //RepeaterItem item1 = firstins.NamingContainer as RepeaterItem;
            //firstins = item1.FindControl("txtfirstinstallment") as TextBox;
            objDetail.FirstInstallment = Convert.ToInt32(firstins.Text);


            DataSet ds = new DataSet();
            ds = db.getapplicantkey(xx);
            objDetail.ApplicantKey = Convert.ToInt16(ds.Tables[0].Rows[0][0].ToString());
            objDetail.CreateBy = Convert.ToInt16(Session["UserKey"].ToString());
            objDetail.LastModifiedBy = Convert.ToInt16(Session["UserKey"].ToString());
            db.AwasYojanaDetailsRead(objDetail);







            Int64 kk = 0;

            kk = db.UpdateAwasYojanafirstinstallmentupdate(objDetail.AlottmentKey, objDetail.FirstInstallment, "Uncompleted", objDetail.LastModifiedBy);


            kk = db.CreateAwasYojanaInstallment(xx, objDetail.ApplicantKey, objDetail.first_for_month, objDetail.First_for_year, objDetail.first_remarks, true, objDetail.CreateBy);


            if (kk == 0)
            {

                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record update Successfully .!!')", true);


            }
            else
            {




                ClientScript.RegisterStartupScript(this.GetType(), "Error", "<script language='javascript'>alert('Error occured!!');</script>");
                //ClientScript.RegisterStartupScript(this.GetType(), "Error", "<script language='javascript'>bootbox.alert('You have been registered successfully. Your user name and password sent to your registered emial id/mobile no.!!', function () {window.location.href = 'Login.aspx';});</script>");


            }



        }
    }


    protected void Repeater2_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "Update")
        {
            if (e.Item.ItemIndex == 0)
            {
                string str = e.Item.ItemIndex.ToString();
            }

            Int16 xx = Convert.ToInt16(e.CommandArgument.ToString());
            Awayojana objDetail = new Awayojana();
            objDetail.AlottmentKey = xx;
            db.Read(objDetail);
            objDetail.second_for_month = String.Format("{0:MMMM}", DateTime.Now);
            objDetail.second_for_year = String.Format("{0:yyyy}", DateTime.Now);

            //      RepeaterItem item = box.NamingContainer as RepeaterItem;
            TextBox box = e.Item.FindControl("txtremark2") as TextBox;



            objDetail.second_remarks = box.Text;
            TextBox secondins = e.Item.FindControl("txtsecondinstallment") as TextBox;
            //RepeaterItem item1 = firstins.NamingContainer as RepeaterItem;
            //firstins = item1.FindControl("txtfirstinstallment") as TextBox;
            objDetail.SecondInstallment = Convert.ToInt32(secondins.Text);


            DataSet ds = new DataSet();
            ds = db.getapplicantkey(xx);
            objDetail.ApplicantKey = Convert.ToInt16(ds.Tables[0].Rows[0][0].ToString());
            objDetail.CreateBy = Convert.ToInt16(Session["UserKey"].ToString());
            objDetail.LastModifiedBy = Convert.ToInt16(Session["UserKey"].ToString());
            db.AwasYojanaDetailsRead(objDetail);







            Int64 kk = 0;

            kk = db.UpdateAwasYojanasecondinstallmentupdate(objDetail.AlottmentKey, objDetail.FirstInstallment, "Completed", objDetail.LastModifiedBy);


            kk = db.UpdateAwasYojanaInstallment(xx, objDetail.ApplicantKey, objDetail.second_for_month, objDetail.second_for_year, objDetail.second_remarks, objDetail.CreateBy);


            if (kk == 0)
            {

                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record update Successfully .!!')", true);


            }
            else
            {




                ClientScript.RegisterStartupScript(this.GetType(), "Error", "<script language='javascript'>alert('Error occured!!');</script>");
                //ClientScript.RegisterStartupScript(this.GetType(), "Error", "<script language='javascript'>bootbox.alert('You have been registered successfully. Your user name and password sent to your registered emial id/mobile no.!!', function () {window.location.href = 'Login.aspx';});</script>");


            }



        }
    }

    public void getsecondinstallment(string for_month, string for_year)
    {

        try
        {






            ds = db.GET_secondinstallmen_Detail(Convert.ToInt16(HttpContext.Current.Session["UserKey"]), for_month, for_year);





            if (ds != null)
            {
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        Repeater2.DataSource = ds.Tables[0];
                        Repeater2.DataBind();
                    }
                }
            }





        }

        catch (Exception ex)
        {

        }

    }
    public void getfstinstallment(string for_month, string for_year)
    {

        try
        {






            ds = db.GET_firstinstallmen_Detail(Convert.ToInt16(HttpContext.Current.Session["UserKey"]), for_month, for_year);





            if (ds != null)
            {
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        Repeater1.DataSource = ds.Tables[0];
                        Repeater1.DataBind();
                    }
                }
            }





        }

        catch (Exception ex)
        {

        }

    }
    public void getdetailsgrid()
    {
        ds = null;
        rptlog.DataSource = ds;
        rptlog.DataBind();
        try
        {
            if (!Page.IsPostBack)
            {






                ds = db.GET_AwaYogna_Detail(Convert.ToInt16(HttpContext.Current.Session["UserKey"]));





                if (ds != null)
                {
                    if (ds.Tables.Count > 0)
                    {
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            rptlog.DataSource = ds.Tables[0];
                            rptlog.DataBind();
                        }
                    }
                }



            }

        }

        catch (Exception ex)
        {

        }

    }
    // [WebMethod]
    //  [ScriptMethod(ResponseFormat = ResponseFormat.Json)]

    //public static string getdistrict(string mondalid)
    //{

    //    DataSet ds = new DataSet();
    //    DBLayer db = new DBLayer();
    //    string data = string.Empty;

    //    Int32 var=0;

    //    if (mondalid != "0")
    //    {
    //        var = Convert.ToInt32( mondalid);
    //    }

    //    ds = db.PopulateDistrictMondalwise(var);

    //    List<MondalwiseDitrict> lst = new List<MondalwiseDitrict>();
    //    for (int i = 0; i <= ds.Tables[0].Rows.Count - 1; i++)
    //    {
    //        MondalwiseDitrict obj = new MondalwiseDitrict();
    //        obj.districtkey = Convert.ToInt32(ds.Tables[0].Rows[i]["districtkey"]);
    //        obj.EnglishName = ds.Tables[0].Rows[i]["EnglishName"].ToString();
    //        obj.TotalCount = Convert.ToInt32(ds.Tables[0].Rows[i]["pendingcount"]);

    //        lst.Add(obj);
    //    }

    //    JavaScriptSerializer serializer = new JavaScriptSerializer();
    //    data = serializer.Serialize(lst);

    //    return data;
    //}

    #region WebMethods

    [WebMethod]
    public static Awayojana getDetail(string key)
    {
        DBLayer db = new DBLayer();
        Int16 id = Convert.ToInt16(GeneralClass.Decrypt(HttpUtility.UrlDecode(key)));
        Awayojana objDetail = new Awayojana();
        objDetail.AlottmentKey = id;
        db.Read(objDetail);
        return objDetail;
    }
    #endregion
    public class MondalwiseDitrict
    {

        public Int32 districtkey { get; set; }
        public string EnglishName { get; set; }
        public Int32 TotalCount { get; set; }

    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        //demotab3.Visible = true;
        //demotab3.Focus();

        getfstinstallment(ddlformonth.SelectedItem.Text, ddlforyear.SelectedItem.Text);

    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        //demotab3.Visible = true;
        //demotab3.Focus();

        getsecondinstallment(ddlformonthsec.SelectedItem.Text, ddlforyearsec.SelectedItem.Text);

    }

    protected void Button1_Click(object sender, EventArgs e)
    {

        if (Button1.Text == "Submit")
        {

            try
            {
                long kk = 0;

                Awayojana objApplicant = new Awayojana();
                objApplicant.MandalKey = Convert.ToInt16(ddlMandel.Text);
                objApplicant.DistrictKey = Convert.ToInt16(ddlDistrict.Text);
                objApplicant.BlockKey = Convert.ToInt16(ddlBlock.SelectedItem.Value);
                objApplicant.VillageName = txtVillagename.Text;
                objApplicant.ApplicantName = txtapplicant.Text;
                objApplicant.ApplicantKey = 0;
                objApplicant.CreateBy = Convert.ToInt16(Session["UserKey"].ToString());
                string gen;
                if (rad1.Checked)
                    gen = "Male";
                else if (rad2.Checked)
                    gen = "Female";
                else
                    gen = "TranGender";
                objApplicant.Gender = gen;
                objApplicant.DOB = Convert.ToDateTime(txtDOB.Text);
                objApplicant.ApplicantAddress = txtaddress.Text;
                objApplicant.ApplicantAadhar = txtAadhar.Text;
                objApplicant.ApplicantMobileno = txtmobile.Text;
                objApplicant.SchemeID = Convert.ToInt16(ddlScheme.SelectedItem.Value);
                objApplicant.fundallotbydept = Convert.ToInt32(txtfundallotment.Text);
                objApplicant.for_month = String.Format("{0:MMMM}", DateTime.Now);
                objApplicant.For_year = String.Format("{0:yyyy}", DateTime.Now);

                db.AwasYojanaDetailsRead(objApplicant);
                if (objApplicant != null && objApplicant.ApplicantKey > 0)
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record already exist!!')", true);
                    return;
                }

                kk = db.CreateAwasYojanaDetails(Convert.ToInt16(ddlMandel.Text), Convert.ToInt16(ddlDistrict.Text), Convert.ToInt16(ddlBlock.SelectedValue), txtVillagename.Text, 0, txtapplicant.Text, gen, Convert.ToDateTime(txtDOB.Text), txtaddress.Text, txtmobile.Text, txtAadhar.Text, Convert.ToInt16(ddlScheme.SelectedValue), Convert.ToInt32(txtfundallotment.Text), objApplicant.for_month, objApplicant.For_year, true, objApplicant.CreateBy);


                if (kk == 0)
                {
                    getdetailsgrid();
                    clearData();
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record Inserted Successfully .!!')", true);


                }
                else
                {


                    clearData();

                    ClientScript.RegisterStartupScript(this.GetType(), "Error", "<script language='javascript'>alert('Error occured!!');</script>");
                    //ClientScript.RegisterStartupScript(this.GetType(), "Error", "<script language='javascript'>bootbox.alert('You have been registered successfully. Your user name and password sent to your registered emial id/mobile no.!!', function () {window.location.href = 'Login.aspx';});</script>");


                }
            }
            catch (Exception ex)
            {
                ex.ToString();

                //ClientScript.RegisterStartupScript(this.GetType(), "Error", "<script language='javascript'>bootbox.alert('You have been registered successfully. Your user name and password sent to your registered emial id/mobile no.!!', function () {window.location.href = 'Login.aspx';});</script>");

                ClientScript.RegisterStartupScript(this.GetType(), "Error", "<script language='javascript'>alert('Error occured!!');</script>");
            }
        }

        else if (Button1.Text == "Edit")
        {
            try
            {
                long kk = 0;

                Awayojana objApplicant = new Awayojana();
                objApplicant.MandalKey = Convert.ToInt16(ddlMandel.Text);
                objApplicant.DistrictKey = Convert.ToInt16(ddlDistrict.Text);
                objApplicant.BlockKey = Convert.ToInt16(ddlBlock.SelectedItem.Value);
                objApplicant.VillageName = txtVillagename.Text;
                objApplicant.ApplicantName = txtapplicant.Text;
                objApplicant.ApplicantKey = 0;
                objApplicant.LastModifiedBy = Convert.ToInt16(Session["UserKey"].ToString());
                string gen;
                if (rad1.Checked)
                    gen = "Male";
                else if (rad2.Checked)
                    gen = "Female";
                else
                    gen = "TranGender";
                objApplicant.Gender = gen;
                objApplicant.DOB = Convert.ToDateTime(txtDOB.Text);
                objApplicant.ApplicantAddress = txtaddress.Text;
                objApplicant.ApplicantAadhar = txtAadhar.Text;
                objApplicant.ApplicantMobileno = txtmobile.Text;
                objApplicant.SchemeID = Convert.ToInt16(ddlScheme.SelectedItem.Value);
                objApplicant.fundallotbydept = Convert.ToInt32(txtfundallotment.Text);
                objApplicant.for_month = String.Format("{0:MMMM}", DateTime.Now);
                objApplicant.For_year = String.Format("{0:yyyy}", DateTime.Now);
                Int16 allotmentkey = objApplicant.AlottmentKey;


                kk = db.UpdateAwasYojanaDetails(allotmentkey, Convert.ToInt16(ddlMandel.Text), Convert.ToInt16(ddlDistrict.Text), Convert.ToInt16(ddlBlock.SelectedValue), txtVillagename.Text, 0, txtapplicant.Text, gen, Convert.ToDateTime(txtDOB.Text), txtaddress.Text, txtmobile.Text, txtAadhar.Text, Convert.ToInt16(ddlScheme.SelectedValue), Convert.ToInt32(txtfundallotment.Text), objApplicant.for_month, objApplicant.For_year, true, objApplicant.LastModifiedBy);





                if (kk == 0)
                {
                    getdetailsgrid();
                    clearData();
                    Button1.Text = "Submit";
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record Updated Successfully .!!')", true);


                }
                else
                {


                    clearData();

                    ClientScript.RegisterStartupScript(this.GetType(), "Error", "<script language='javascript'>alert('Error occured!!');</script>");
                    //ClientScript.RegisterStartupScript(this.GetType(), "Error", "<script language='javascript'>bootbox.alert('You have been registered successfully. Your user name and password sent to your registered emial id/mobile no.!!', function () {window.location.href = 'Login.aspx';});</script>");


                }

            }
            catch (Exception ex)
            {
                ex.ToString();

                //ClientScript.RegisterStartupScript(this.GetType(), "Error", "<script language='javascript'>bootbox.alert('You have been registered successfully. Your user name and password sent to your registered emial id/mobile no.!!', function () {window.location.href = 'Login.aspx';});</script>");

                ClientScript.RegisterStartupScript(this.GetType(), "Error", "<script language='javascript'>alert('Error occured!!');</script>");
            }
        }
    }

    public void clearData()
    {

        ddlBlock.Items.Clear();
        ddlScheme.SelectedIndex = 0;
        txtAadhar.Text = "";
        txtapplicant.Text = "";
        txtDOB.Text = "";
        txtfundallotment.Text = "";
        txtmobile.Text = "";
        rad1.Checked = false; rad2.Checked = false; rad3.Checked = false;
        txtVillagename.Text = "";
        txtaddress.Text = "";
    }


}