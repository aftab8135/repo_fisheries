using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FisheriesMIS.MasterPages
{
    public partial class ApplicantMaster : System.Web.UI.MasterPage
    {
        protected void Page_PreInit(object sender, EventArgs e)
        {
            if (Session["ApplicantKey"] == null)
            {
                Response.Redirect("~/Default.aspx");
            }
        }
    }
}