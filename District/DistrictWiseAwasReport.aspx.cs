using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class District_DistrictWiseAwasReport : System.Web.UI.Page
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

    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        getDistrictwiserpt(ddlformonth.SelectedItem.Text, ddlforyear.SelectedItem.Text);
    }

    public void getDistrictwiserpt(string for_month, string for_year)
    {

        try
        {






            ds = db.GET_rptAwasYogna_Detail( for_month,for_year);





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
}