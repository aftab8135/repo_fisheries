<%@ WebHandler Language="C#" Class="FileUploadHandler" %>

using System;
using System.Web;
using System.Transactions;
using System.Collections.Specialized;
using System.Collections.Generic;

public class FileUploadHandler : IHttpHandler
{

    GlobalFunctions objGlobal = new GlobalFunctions();
    DBLayer db = new DBLayer();
    public void ProcessRequest(HttpContext context)
    {
        using (var txscope = new TransactionScope(TransactionScopeOption.RequiresNew))
        {
            try
            {
                if (context.Request.Files.Count > 0)
                {
                    string RegCode = context.Request.Form["RegCode"].ToString();
                    NameValueCollection arr = context.Request.Form;
                    HttpFileCollection files = context.Request.Files;
                    string newfileName = "";
                    string fname = "";
                    if (RegCode != "" && files.Count > 0)
                    {
                        List<DBT_DocumentDetail> lstDoc = new List<DBT_DocumentDetail>();
                        for (int i = 0; i < files.Count; i++)
                        {

                            string a = arr[i + 1];
                            HttpPostedFile file = files[i];
                            string unqFileName = GlobalFunctions.GetUniqueFileName(file.FileName);
                            newfileName = RegCode + "_" + objGlobal.GetUniqueFilename(DBLayer.DBT_InstDistribution, unqFileName);
                            fname = context.Server.MapPath("~/" + DBLayer.DBT_InstDistribution + '/' + newfileName);
                            file.SaveAs(fname);

                            DBT_DocumentDetail objDoc = new DBT_DocumentDetail();
                            objDoc.DocumentKey = Convert.ToInt32(arr[i + 1]);
                            objDoc.DocumentFileName = file.FileName;
                            objDoc.DocumentPath = newfileName;
                            lstDoc.Add(objDoc);
                        }

                        string strDocs = Newtonsoft.Json.JsonConvert.SerializeObject(lstDoc);
                        
                        txscope.Complete();
                        context.Response.Write(strDocs);
                    }
                    else
                    {
                        
                        txscope.Dispose();
                        context.Response.Write("NoFiles");
                    }
                }
                else
                {
                    txscope.Dispose();
                    context.Response.Write("NoFiles");
                }
            }
            catch(Exception ex)
            {
                txscope.Dispose();
                context.Response.Write("Error");
            }
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