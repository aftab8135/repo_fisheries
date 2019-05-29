using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Administrator_wfRole : System.Web.UI.Page
{
    private static Int64 intUser = 0;
    public static DataTable dtRoleDetail = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        intUser = Convert.ToInt64(Session["UserKey"]);
        LoadDetail();
    }
    public void LoadDetail()
    {
        try
        {
            DBLayer objDBLayer = new DBLayer();
            dtRoleDetail = objDBLayer.GetAllRole();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "error alert", "alert('Error Occured! Try again later..')", true);
        }
    }

    [WebMethod]
    public static int CreateRole(RoleMaster objRole)
    {
        Int32 rowAffected = 0;
        try
        {
            
            if (objRole.RoleName == "" )
            {
                rowAffected = -1;
            }
            if (rowAffected != -1)
            {
                if (objRole.ID == 0)
                {
                    DBLayer objDBLayer = new DBLayer();
                    objRole.IsActive = true;
                    objRole.CreatedBy = intUser;
                    rowAffected = objDBLayer.UpdateRole(objRole, false);
                }
                else
                {
                    DBLayer objDBLayer = new DBLayer();
                    objRole.CreatedBy = intUser;
                    rowAffected = objDBLayer.UpdateRole(objRole, true); 
                }
               
            }
            return rowAffected;

        }
        catch (Exception ex)
        {
            return -1;
        }
    }

    [WebMethod]
    public static int DeleteRole(Int64 ID)
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.DeleteRole(ID);

        }
        catch (Exception)
        {
            return -1;
        }
    } 
    
    [WebMethod]
    public static int ActivateRole(Int64 ID)
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.ActivateRole(ID);

        }
        catch (Exception)
        {
            return -1;
        }
    }
}
