﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

public partial class District_frm_Report : System.Web.UI.Page
{
    public static Int64 UserKey;
    public static string UserName;
    public static int DistrictKey;
    public static string FinYear;
    protected void Page_Load(object sender, EventArgs e)
    {
        UserKey = Convert.ToInt64(Session["UserKey"]);
        UserName = Session["UserName"].ToString();
        DistrictKey = Convert.ToInt32(Session["DistrictKey"]);
        FinYear = Session["FinancialYear"].ToString();

        lblFinYear.Text = FinYear;
        lblLoginType.Text = UserName;
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

    [WebMethod]
    public static List<ListItem> GetSchemes(int key)
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.GetSchemesForSelect(key).ToList();
        }
        catch (Exception ex)
        {

            return null;
        }

    }

    [WebMethod]
    public static List<ListItem> GetWorkType(int schemeID)
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.GetProgressTypeByScheme(schemeID);
        }
        catch (Exception ex)
        {

            return null;
        }

    }

    [WebMethod]
    public static List<ListItem> GetWorkIntallment(int schemeID, int workTypeID)
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.GetWorkIntallmentByWorkType(schemeID, workTypeID);
        }
        catch (Exception ex)
        {

            return null;
        }

    }

    [WebMethod]
    public static string GetForwardInstallment(Int64 SchemeKey, Int64 ProgressKey, Int64 InsKey)
    {
        try
        {
            string jsondata = "";
            DBLayer db = new DBLayer();
            jsondata = JsonConvert.SerializeObject(db.GetDBT_ForwardedListByDistrict(FinYear, DistrictKey, SchemeKey, ProgressKey, InsKey));
            return jsondata;
        }

        catch (Exception ex)
        {
            return null;
        }
    }
}