using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for APT_SchemeDocuments
/// </summary>
public class APT_SchemeDocuments
{
    public Int64 DocumentDetailKey { get; set; }

    public Int64? DocumentKey { get; set; }

    public Int64? RegistrationKey { get; set; }

    public Int64 ApplicationKey { get; set; }

    public string DocFileName { get; set; }

    public string DocFilePath { get; set; }

}