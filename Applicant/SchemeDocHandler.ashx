<%@ WebHandler Language="C#" Class="SchemeDocHandler" %>

using System;
using System.Web;
using System.Collections.Specialized;
using System.Collections.Generic;
using System.Transactions;
using System.Data;

public class SchemeDocHandler : IHttpHandler
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
                    string RegistrationKey = context.Request.Form["RegistrationKey"].ToString();
                    string SchemeKey = context.Request.Form["SchemeKey"].ToString();
                    
                    NameValueCollection arr = context.Request.Form;
                    HttpFileCollection files = context.Request.Files;
                    
                    string newfileName = "";
                    string fname = "";

                    if (RegistrationKey != "" && SchemeKey != "" && files.Count > 0)
                    {
                        List<APT_SchemeDocuments> lstDoc = new List<APT_SchemeDocuments>();
                        for (int i = 0; i < files.Count; i++)
                        {

                            string a = arr[i + 1];
                            HttpPostedFile file = files[i];
                            string unqFileName = GlobalFunctions.GetUniqueFileName(file.FileName);
                            newfileName = RegistrationKey + "_" + SchemeKey + "_" + objGlobal.GetUniqueFilename(DBLayer.APT_SchemeDocuments, unqFileName);
                            fname = context.Server.MapPath("~/" + DBLayer.APT_SchemeDocuments + '/' + newfileName);
                            file.SaveAs(fname);

                            APT_SchemeDocuments objDoc = new APT_SchemeDocuments();
                            objDoc.RegistrationKey = Convert.ToInt64(RegistrationKey);
                            objDoc.DocumentKey = Convert.ToInt32(arr[(i + 2)]);
                            objDoc.DocFileName = file.FileName;
                            objDoc.DocFilePath = newfileName;
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
            catch (Exception ex)
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