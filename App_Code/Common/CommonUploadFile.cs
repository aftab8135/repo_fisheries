using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for CommonUploadFile
/// </summary>
public class CommonUploadFile
{
	public CommonUploadFile()
	{
		
	}
    public Int64 FileId { get; set; }
    public string RefNo { get; set; }
    public string FileName { get; set; }
    public string FilePath { get; set; }
    public string FileSpec { get; set; }
}