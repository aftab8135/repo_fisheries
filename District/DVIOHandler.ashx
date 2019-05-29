<%@ WebHandler Language="C#" Class="DVIOHandler" %>

using System;
using System.Web;
using System.Collections.Specialized;
using System.Collections.Generic;
using System.Data;
//using System.Transactions;
public class DVIOHandler : IHttpHandler
{
    GlobalFunctions objGlobal = new GlobalFunctions();
    DBLayer db = new DBLayer();
    public void ProcessRequest(HttpContext context)
    {
        try
        {
           
            Int64 key = Convert.ToInt64((String.IsNullOrEmpty(context.Request.Form["Key"])) ? "0" : context.Request.Form["Key"]);
           
            Int32 UKey = Convert.ToInt32(context.Request.Form["UKey"]);
            HttpFileCollection files = context.Request.Files;
            string newfileName = "";
            string fname = "";
            if (key > 0 && files.Count > 0)
            {
                if (files.Count > 0)
                    for (int i = 0; i < files.Count; i++)
                    {

                        HttpPostedFile file = files[i];
                        newfileName = objGlobal.GetUniqueFilename(DBLayer.DVIOuploaddoc, file.FileName);
                        fname = context.Server.MapPath("~/" + DBLayer.DVIOuploaddoc + "/" + newfileName);
                        file.SaveAs(fname);
                    }

                context.Response.ContentType = "text/plain";
                
                if (db.InsertDVIOStatus(key, newfileName, UKey))
                {
                    context.Response.Write("Status Updated Successfully!");
                }
                else
                {
                    for (int i = 0; i < files.Count; i++)
                    {
                        if (files[i].FileName != "" && System.IO.File.Exists(context.Server.MapPath("~/" + DBLayer.DVIOuploaddoc + "/" + files[i].FileName)))
                            System.IO.File.Delete(context.Server.MapPath("~/" + DBLayer.DVIOuploaddoc + "/") + files[i].FileName);
                    }
                    context.Response.Write("Error Occured, Please try again later!");
                }
            }
            else
            {
                context.Response.ContentType = "text/plain";
                context.Response.Write("Error Occured, No Document Found!");
            }
           
        }
        catch (Exception ex)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write("Error Occured, Please try again later!" + ex.Message);
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}