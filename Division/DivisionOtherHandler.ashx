<%@ WebHandler Language="C#" Class="DivisionOtherHandler" %>

using System;
using System.Web;
using System.Collections.Specialized;
using System.Collections.Generic;
using System.Data;

public class DivisionOtherHandler : IHttpHandler
{

    GlobalFunctions objGlobal = new GlobalFunctions();
    DBLayer db = new DBLayer();
    public void ProcessRequest(HttpContext context)
    {
        try
        {

            Int64 key1 = Convert.ToInt64((String.IsNullOrEmpty(context.Request.Form["Key1"])) ? "0" : context.Request.Form["Key1"]);

            Int32 UKey1 = Convert.ToInt32(context.Request.Form["UKey1"]);
            HttpFileCollection files = context.Request.Files;
            string newfileName = "";
            string fname = "";
            if (key1 > 0 && files.Count > 0)
            {
                if (files.Count > 0)
                    for (int i = 0; i < files.Count; i++)
                    {

                        HttpPostedFile file = files[i];
                        newfileName = objGlobal.GetUniqueFilename(DBLayer.DIVISONOuploadOtherdoc, file.FileName);
                        fname = context.Server.MapPath("~/" + DBLayer.DIVISONOuploadOtherdoc + "/" + newfileName);
                        file.SaveAs(fname);
                    }

                context.Response.ContentType = "text/plain";

                if (db.InsertDIVISONOtherStatus(key1, newfileName, UKey1))
                {
                    context.Response.Write("Status Updated Successfully!");
                }
                else
                {
                    for (int i = 0; i < files.Count; i++)
                    {
                        if (files[i].FileName != "" && System.IO.File.Exists(context.Server.MapPath("~/" + DBLayer.DIVISONOuploadOtherdoc + "/" + files[i].FileName)))
                            System.IO.File.Delete(context.Server.MapPath("~/" + DBLayer.DIVISONOuploadOtherdoc + "/") + files[i].FileName);
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