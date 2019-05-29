<%@ WebHandler Language="C#" Class="UploadHandler" %>

using System;
using System.Web;
using System.Transactions;
using System.Collections.Specialized;
using System.Collections.Generic;

public class UploadHandler : IHttpHandler {

    GlobalFunctions objGlobal = new GlobalFunctions();
    public void ProcessRequest (HttpContext context) {
        using (var txscope = new TransactionScope(TransactionScopeOption.RequiresNew))
        {
            try
            {
                if (context.Request.Files.Count > 0)
                {
                    string RefNo = context.Request.Form["RefNo"].ToString();
                    string filePath = context.Request.Form["filePath"].ToString();
                    
                    NameValueCollection arr = context.Request.Form;
                    HttpFileCollection files = context.Request.Files;
                    
                    string newfileName = "";
                    string fname = "";
                    if (RefNo != "" && files.Count > 0)
                    {
                        List<CommonUploadFile> lstDoc = new List<CommonUploadFile>();
                        for (int i = 0; i < files.Count; i++)
                        {

                            HttpPostedFile file = files[i];
                         
                            string unqFileName = GlobalFunctions.GetUniqueFileName(file.FileName);
                            newfileName = RefNo + "_" + objGlobal.GetUniqueFilename(filePath, unqFileName);
                            fname = context.Server.MapPath("~/" + filePath + '/' + newfileName);
                            file.SaveAs(fname);

                            CommonUploadFile objDoc = new CommonUploadFile();
                            objDoc.FileId = Convert.ToInt32(arr[i +2]);
                            objDoc.FileName = file.FileName;
                            objDoc.FilePath = newfileName;
                            objDoc.FileSpec = arr[i + 2];
                            objDoc.RefNo = RefNo;
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
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}