using System;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using DBLibrary;
using System.Collections.Generic;
using System.Configuration;
using System.Web.UI.WebControls;

public partial class DBLayer
{
    public static string SchemeGuidlineDirectory = ConfigurationManager.AppSettings["SchemeGuidlineDirectory"].ToString();
    public static string LodgeGrievanceDirectory = ConfigurationManager.AppSettings["LodgeGrievanceDirectory"].ToString();
    public static string DBT_InstDistribution = ConfigurationManager.AppSettings["DBT_InstDistribution"].ToString();
    public static string applicantuploaddoc = ConfigurationManager.AppSettings["applicantuploaddoc"].ToString();
    public static string DIVISONuploaddoc = ConfigurationManager.AppSettings["DIVISONuploaddoc"].ToString();
    public static string DVIOuploadOtherdoc = ConfigurationManager.AppSettings["DVIOuploadOtherdoc"].ToString();
    public static string DVIOuploaddoc = ConfigurationManager.AppSettings["DVIOuploaddoc"].ToString();
    public static string DIVISONOuploadOtherdoc = ConfigurationManager.AppSettings["DIVISONuploadOtherdoc"].ToString();
    public static string Constr = ConfigurationManager.ConnectionStrings["ConnectionStr"].ConnectionString;
    public static string DBT_GeneratedFile = ConfigurationManager.AppSettings["DBT_GeneratedFile"].ToString();
    public static string APT_SchemeDocuments = ConfigurationManager.AppSettings["APT_SchemeDocuments"].ToString();
    public static string APT_SchemeDocumentsDepartment = ConfigurationManager.AppSettings["APT_SchemeDocumentsDepartment"].ToString();

    #region Business Logic For - Common


    public List<ListItem> PopulateComplainSource()
    {
        List<ListItem> lst = new List<ListItem>();
        using (var con = new SqlConnection(Constr))
        {
            const string query = "SELECT [ComplainSourcekey],[ComplainSourceName] FROM [ComplainSource] where IsActive=1 order by ComplainSourcekey";
            SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, query);
            using (sdr)
            {
                while (sdr.Read())
                {
                    lst.Add(new ListItem
                    {
                        Value = sdr["ComplainSourcekey"].ToString(),
                        Text = sdr["ComplainSourceName"].ToString()
                    });
                }
            }
        }
        return lst;
    }

    public List<ListItem> PopulateComplainType()
    {
        List<ListItem> lst = new List<ListItem>();
        using (var con = new SqlConnection(Constr))
        {
            const string query = "SELECT [ComplainTypeKey],[ComplainName] FROM [ComplainTypeMaster] where IsActive=1 order by ComplainName";
            SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, query);
            using (sdr)
            {
                while (sdr.Read())
                {
                    lst.Add(new ListItem
                    {
                        Value = sdr["ComplainTypeKey"].ToString(),
                        Text = sdr["ComplainName"].ToString()
                    });
                }
            }
        }
        return lst;
    }

    public List<ListItem> PopulateComplainSubType()
    {
        List<ListItem> lst = new List<ListItem>();
        using (var con = new SqlConnection(Constr))
        {
            string query = "SELECT [SubTypeKey],[SubTypeName] FROM [ComplainSubType] where IsActive=1 order by SubTypeName";
            SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, query);
            using (sdr)
            {
                while (sdr.Read())
                {
                    lst.Add(new ListItem
                    {
                        Value = sdr["SubTypeKey"].ToString(),
                        Text = sdr["SubTypeName"].ToString()
                    });
                }
            }
        }
        return lst;
    }

    public List<ListItem> PopulateComplainSubType(int compkey)
    {
        List<ListItem> lst = new List<ListItem>();
        using (var con = new SqlConnection(Constr))
        {
            string query = "SELECT [SubTypeKey],[SubTypeName] FROM [ComplainSubType] where ComplainTypeKey=" + compkey + " and IsActive=1 order by SubTypeName";
            SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, query);
            using (sdr)
            {
                while (sdr.Read())
                {
                    lst.Add(new ListItem
                    {
                        Value = sdr["SubTypeKey"].ToString(),
                        Text = sdr["SubTypeName"].ToString()
                    });
                }
            }
        }
        return lst;
    }

    public List<ListItem> PopulateDesignation()
    {
        List<ListItem> lst = new List<ListItem>();
        using (var con = new SqlConnection(Constr))
        {
            const string query = "SELECT [Designationkey],[DesignationName],[DesignationCode] FROM [Designation_Master] where IsActive=1 order by DesignationName";
            SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, query);
            using (sdr)
            {
                while (sdr.Read())
                {
                    lst.Add(new ListItem
                    {
                        Value = sdr["Designationkey"].ToString(),
                        Text = sdr["DesignationName"].ToString()
                    });
                }
            }
        }
        return lst;
    }

    public List<ListItem> PopulateSection()
    {
        List<ListItem> lst = new List<ListItem>();
        using (var con = new SqlConnection(Constr))
        {
            const string query = "SELECT [SectionKey] ,[SectionName] ,[SectionCode] FROM [Section_Master] where IsActive=1 order by SectionName";
            SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, query);
            using (sdr)
            {
                while (sdr.Read())
                {
                    lst.Add(new ListItem
                    {
                        Value = sdr["SectionKey"].ToString(),
                        Text = sdr["SectionName"].ToString()
                    });
                }
            }
        }
        return lst;
    }

    public List<ListItem> PopulateOfficer(int sectionkey)
    {
        List<ListItem> lst = new List<ListItem>();
        using (var con = new SqlConnection(Constr))
        {
            string query = "select OfficerKey,OfficerName+' ('+D.DesignationCode+')' OfficerWithDesignation from Officer_Master O Inner Join Designation_Master D On O.DesignationKey=D.Designationkey  where O.IsActive=1 AND O.SectionKey=" + sectionkey + " Order by OfficerName";
            SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, query);
            using (sdr)
            {
                while (sdr.Read())
                {
                    lst.Add(new ListItem
                    {
                        Value = sdr["OfficerKey"].ToString(),
                        Text = sdr["OfficerWithDesignation"].ToString()
                    });
                }
            }
        }
        return lst;
    }

    public string GenerateTokenNo()
    {
        string tkno = string.Empty;
        string dt = DateTime.UtcNow.Date.AddMinutes(330).ToString("yyyy/MM/dd");
        dt = dt.Replace("/", "").Replace("-", "");
        DBLayer dbl = new DBLayer();
        string str = dbl.GetMaxComplainNo();
        tkno = dt + str;
        return tkno;

    }

    public string GenerateRegistrationNo()
    {
        string regNo = string.Empty;
        string dt = DateTime.UtcNow.Date.AddMinutes(330).ToString("yyyy/MM/dd");
        dt = dt.Replace("/", "");
        // string str = "select ISNULL(Max(Registrationkey)+1,1) from [CandidateRegistration]";
        DBLayer dbl = new DBLayer();
        string str = dbl.GetMaxRegNo();
        //  object obj = SqlHelper.ExecuteScalar(Constr, CommandType.Text, str);
        regNo = dt + str;
        return regNo;

    }

    public List<ListItem> PopulateOfficerMaster(int desigkey, int seckey)
    {
        List<ListItem> lst = new List<ListItem>();
        using (var con = new SqlConnection(Constr))
        {
            string query = "SELECT [OfficerKey] ,[OfficerName] FROM [Officer_Master] where IsActive=1 AND DesignationKey=" + desigkey + " AND SectionKey=" + seckey + " order by OfficerName";
            SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, query);
            using (sdr)
            {
                while (sdr.Read())
                {
                    lst.Add(new ListItem
                    {
                        Value = sdr["OfficerKey"].ToString(),
                        Text = sdr["OfficerName"].ToString()
                    });
                }
            }
        }
        return lst;
    }

    public List<ListItem> PopulateComplainStatus()
    {
        List<ListItem> lst = new List<ListItem>();
        using (var con = new SqlConnection(Constr))
        {
            const string query = "SELECT [TBKey],[FieldText] FROM [dbo].[ApplicationStatus] where IsActive=1 And FieldType='Status' order by FieldText";
            SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, query);
            using (sdr)
            {
                while (sdr.Read())
                {
                    lst.Add(new ListItem
                    {
                        Value = sdr["TBKey"].ToString(),
                        Text = sdr["FieldText"].ToString()
                    });
                }
            }
        }
        lst.Insert(0, new ListItem("Select", ""));

        return lst;
    }

    public List<ListItem> PopulateComplainStatusAll()
    {
        List<ListItem> lst = new List<ListItem>();
        using (var con = new SqlConnection(Constr))
        {
            const string query = "SELECT [TBKey],[FieldText] FROM [dbo].[ApplicationStatus] where IsActive=1 And FieldType='Status' order by FieldText";
            SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, query);
            using (sdr)
            {
                while (sdr.Read())
                {
                    lst.Add(new ListItem
                    {
                        Value = sdr["TBKey"].ToString(),
                        Text = sdr["FieldText"].ToString()
                    });
                }
            }
        }
        lst.Insert(0, new ListItem("All", ""));

        return lst;
    }

    public List<ListItem> PopulateApplicationStatus(string ftype)
    {
        List<ListItem> lst = new List<ListItem>();
        using (var con = new SqlConnection(Constr))
        {
            string query = "SELECT [TBKey],[FieldText] FROM [dbo].[ApplicationStatus] where IsActive=1 And FieldType='" + ftype + "' order by FieldText";
            SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, query);
            using (sdr)
            {
                while (sdr.Read())
                {
                    lst.Add(new ListItem
                    {
                        Value = sdr["TBKey"].ToString(),
                        Text = sdr["FieldText"].ToString()
                    });
                }
            }
        }
        lst.Insert(0, new ListItem("Select", ""));

        return lst;
    }

    public List<ListItem> PopulateApplicationStatusAll(string ftype)
    {
        List<ListItem> lst = new List<ListItem>();
        using (var con = new SqlConnection(Constr))
        {
            string query = "SELECT [TBKey],[FieldText] FROM [dbo].[ApplicationStatus] where IsActive=1 And FieldType='" + ftype + "' order by FieldText";
            SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, query);
            using (sdr)
            {
                while (sdr.Read())
                {
                    lst.Add(new ListItem
                    {
                        Value = sdr["TBKey"].ToString(),
                        Text = sdr["FieldText"].ToString()
                    });
                }
            }
        }
        lst.Insert(0, new ListItem("All", ""));

        return lst;
    }

    //public List<ListItem> PopulateUserType2()
    //{
    //    List<ListItem> lst = new List<ListItem>();
    //    Array utype = Enum.GetValues(typeof(UserType));
    //    foreach (UserType cs in utype)
    //    {
    //        lst.Add(new ListItem(cs.ToString().Replace('_', ' '), ((Int32)cs).ToString()));
    //    }
    //    //  lst.Insert(0, new ListItem("Select", ""));

    //    return lst;
    //}



    public DataSet GetDataTbl()
    {

        using (SqlConnection con = new SqlConnection(Constr))
        {
            string str = "SELECT     User_Master.Name,user_master.UserName, RoleMaster.RoleName, District.EnglishName, User_Master.IsActive FROM User_Master INNER JOIN District ON User_Master.DistrictKey = District.DistrictKey INNER JOIn RoleMaster ON User_Master.UserType = RoleMaster.id";
            using (SqlCommand cmd = new SqlCommand(str))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    using (DataSet dt = new DataSet())
                    {
                        sda.Fill(dt);
                        return dt;
                    }
                }
            }
        }
    }

    public DataTable GetData()
    {

        using (SqlConnection con = new SqlConnection(Constr))
        {
            string str = "SELECT     User_Master.Name,user_master.UserName, RoleMaster.RoleName, District.EnglishName, User_Master.IsActive FROM User_Master INNER JOIN District ON User_Master.DistrictKey = District.DistrictKey INNER JOIn RoleMaster ON User_Master.UserType = RoleMaster.id";
            using (SqlCommand cmd = new SqlCommand(str))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    using (DataTable dt = new DataTable())
                    {
                        sda.Fill(dt);
                        return dt;
                    }
                }
            }
        }
    }

    public List<ListItem> PopulateTehsil(Int32 DistrictKey)
    {
        List<ListItem> lst = new List<ListItem>();
        using (var con = new SqlConnection(Constr))
        {
            string query = null;

            query = "SELECT [TahsilKey], [Name] FROM [dbo].[Tahsil_Master] where IsActive=1 AND DistrictKey='" + DistrictKey + "' order by Name";

            SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, query);
            using (sdr)
            {
                while (sdr.Read())
                {
                    lst.Add(new ListItem
                    {
                        Value = sdr["TahsilKey"].ToString(),
                        Text = sdr["Name"].ToString()
                    });
                }
            }
            lst.Insert(0, new ListItem
            {
                Value = "",
                Text = "Select"
            });
        }
        return lst;
    }

   

    public List<ListItem> PopulateBlockDistrictwise(Int32 Districtkey)
    {
        List<ListItem> lst = new List<ListItem>();
        using (var con = new SqlConnection(Constr))
        {
            string query = "SELECT [BlockKey] ,[EnglishName] from Block where DistrictKey='" + Districtkey + "' order by EnglishName";
            SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, query);
            using (sdr)
            {
                while (sdr.Read())
                {
                    lst.Add(new ListItem
                    {
                        Value = sdr["BlockKey"].ToString(),
                        Text = sdr["EnglishName"].ToString()
                    });
                }
            }
        }
        return lst;
    }
    public List<ListItem> PopulateBranch(Int32 bankkey, Int32 districtKey)
    {
        List<ListItem> lst = new List<ListItem>();
        using (var con = new SqlConnection(Constr))
        {
            //  string query = "SELECT [BankdetailKey] ,[BranchName] from bankdetail where BankKey=" + bankkey + " " + (districtKey == 0 ? "":" and DistrictKey = " + districtKey + "") + " order by BranchName ";

            string query = "SELECT  bd.BankdetailKey ,bd.BranchName  from bankdetail bd " +
                           " INNER JOIN dbo.Bank_Master bm ON bd.bankkey = bm.BankKey " +
                           " where districtKey = "+ districtKey + " AND bd.BankKey="+ bankkey +" AND bd.IsActive = 1 " +
                           " ORDER BY bm.BankName, bd.BranchName";

            SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, query);
            using (sdr)
            {
                while (sdr.Read())
                {
                    lst.Add(new ListItem
                    {
                        Value = sdr["BankdetailKey"].ToString(),
                        Text = sdr["BranchName"].ToString()

                    });
                }
            }
        }
        //   lst.Insert(0, new ListItem("Select", ""));

        return lst;
    }

    public string GetIFSCode(Int32 bankdetailKey)
    {
        string ifsccode = string.Empty;
        using (var con = new SqlConnection(Constr))
        {
            string query = "SELECT [IFSCode] from bankdetail where BankdetailKey=" + bankdetailKey + "";
            object obj = SqlHelper.ExecuteScalar(Constr, CommandType.Text, query);
            if (obj != DBNull.Value && obj != null)
            {
                ifsccode = obj.ToString();
            }

        }
        return ifsccode;
    }

    public List<ListItem> PopulateDistrictMondalwise(Int32 Modelkey)
    {
        List<ListItem> lst = new List<ListItem>();
        using (var con = new SqlConnection(Constr))
        {
            string query = "SELECT [DistrictKey] ,[EnglishName] from District where divisionkey='" + Modelkey + "' order by EnglishName";
            SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, query);
            using (sdr)
            {
                while (sdr.Read())
                {
                    lst.Add(new ListItem
                    {
                        Value = sdr["DistrictKey"].ToString(),
                        Text = sdr["EnglishName"].ToString()
                    });
                }
            }
        }
        return lst;
    }
    public List<ListItem> PopulateDistrict(Int32 StateKey = 0)
    {
        List<ListItem> lst = new List<ListItem>();
        using (var con = new SqlConnection(Constr))
        {
            string query = "SELECT [DistrictKey] ,[EnglishName] from District where IsActive = 1 " + (StateKey != 0 ? " And StateKey = " + StateKey + "" : "") + " order by EnglishName ";
            SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, query);
            using (sdr)
            {
                while (sdr.Read())
                {
                    lst.Add(new ListItem
                    {
                        Value = sdr["DistrictKey"].ToString(),
                        Text = sdr["EnglishName"].ToString()
                    });
                }
            }
        }
        //   lst.Insert(0, new ListItem("Select", ""));

        return lst;
    }

    public List<ListItem> PopulateDistrictName()
    {
        List<ListItem> lst = new List<ListItem>();
        using (var con = new SqlConnection(Constr))
        {
            string query = "SELECT [DistrictKey] ,[EnglishName] from District  order by EnglishName ";
            SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, query);
            using (sdr)
            {
                while (sdr.Read())
                {
                    lst.Add(new ListItem
                    {
                        Value = sdr["DistrictKey"].ToString(),
                        Text = sdr["EnglishName"].ToString()
                    });
                }
            }
        }
        //   lst.Insert(0, new ListItem("Select", ""));

        return lst;
    }


    public List<ListItem> PopulateBank()
    {
        List<ListItem> lst = new List<ListItem>();
        using (var con = new SqlConnection(Constr))
        {
            // string query = "SELECT [Bankname] ,[Bankkey] from Bank_Master order by Bankname";
            string query = " SELECT bd.BankKey, bm.BankName from bankdetail bd " +
                            " INNER JOIN dbo.Bank_Master bm ON bd.bankkey = bm.BankKey " +
                            " where bd.IsActive = 1 " +
                            " ORDER BY bm.BankName";
            SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, query);
            using (sdr)
            {
                while (sdr.Read())
                {
                    lst.Add(new ListItem
                    {
                        Value = sdr["BankKey"].ToString(),
                        Text = sdr["BankName"].ToString()
                    });
                }
            }
        }
        //   lst.Insert(0, new ListItem("Select", ""));

        return lst;
    }



    public List<ListItem> PopulateBank(Int32 districtKey)
    {
        List<ListItem> lst = new List<ListItem>();
        using (var con = new SqlConnection(Constr))
        {
           // string query = "SELECT [Bankname] ,[Bankkey] from Bank_Master order by Bankname";
           string query= " SELECT Distinct bd.BankKey, bm.BankName from bankdetail bd " +
                           " INNER JOIN dbo.Bank_Master bm ON bd.bankkey = bm.BankKey " +
                           " where districtKey = " + districtKey + " AND bd.IsActive = 1 " +
                           " ORDER BY bm.BankName"; 
            SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, query);
            using (sdr)
            {
                while (sdr.Read())
                {
                    lst.Add(new ListItem
                    {
                        Value = sdr["BankKey"].ToString(),
                        Text = sdr["BankName"].ToString()
                    });
                }
            }
        }
        //   lst.Insert(0, new ListItem("Select", ""));

        return lst;
    }

    public List<ListItem> PopulateScheme(Int32 StateKey)
    {
        List<ListItem> lst = new List<ListItem>();
        using (var con = new SqlConnection(Constr))
        {
            string query = "SELECT [Schemekey] ,[SchemeName] from SchemeMaster order by Schemekey";
            SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, query);
            using (sdr)
            {
                while (sdr.Read())
                {
                    lst.Add(new ListItem
                    {
                        Value = sdr["Schemekey"].ToString(),
                        Text = sdr["SchemeName"].ToString()
                    });
                }
            }
        }
        //   lst.Insert(0, new ListItem("Select", ""));

        return lst;
    }

    public List<ListItem> PopulateMandal(Int32 StateKey = 0, bool InHindi = false)
    {
        List<ListItem> lst = new List<ListItem>();
        using (var con = new SqlConnection(Constr))
        {
            string query = "SELECT [DivisionKey] ,[DivisionEnglish], [DivisionHindi] from Division Where IsActive= 1 order by DivisionEnglish ";
            SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, query);
            if (InHindi)
            {
                using (sdr)
                {
                    while (sdr.Read())
                    {
                        lst.Add(new ListItem
                        {
                            Value = sdr["DivisionKey"].ToString(),
                            Text = sdr["DivisionHindi"].ToString()
                        });
                    }
                }
            }
            else
            {
                using (sdr)
                {
                    while (sdr.Read())
                    {
                        lst.Add(new ListItem
                        {
                            Value = sdr["DivisionKey"].ToString(),
                            Text = sdr["DivisionEnglish"].ToString()
                        });
                    }
                }
            }

        }
        //   lst.Insert(0, new ListItem("Select", ""));

        return lst;
    }

    public List<ListItem> PopulateRole()
    {
        List<ListItem> lst = new List<ListItem>();
        using (var con = new SqlConnection(Constr))
        {
            string query = "SELECT [id] ,[RoleName] from RoleMaster where isactive=1 order by id";
            SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, query);
            using (sdr)
            {
                while (sdr.Read())
                {
                    lst.Add(new ListItem
                    {
                        Value = sdr["id"].ToString(),
                        Text = sdr["RoleName"].ToString()
                    });
                }
            }
        }
        //   lst.Insert(0, new ListItem("Select", ""));

        return lst;
    }

    public void FillDocument(ref DropDownList ddl)
    {
        foreach (int enumVal in Enum.GetValues(typeof(AttachedDocument)))
        {
            ddl.Items.Add(new ListItem { Text = Enum.GetName(typeof(AttachedDocument), enumVal).ToString().Replace("_", " "), Value = enumVal.ToString() });
        }
        ddl.Items.Insert(0, new ListItem { Text = "Select", Value = "" });
    }

    public void FillApplicationMode(ref DropDownList ddl)
    {
        foreach (int enumVal in Enum.GetValues(typeof(ApplicationMode)))
        {
            ddl.Items.Add(new ListItem { Text = Enum.GetName(typeof(ApplicationMode), enumVal).ToString().Replace("_", " "), Value = enumVal.ToString() });
        }
        ddl.Items.Insert(0, new ListItem { Text = "Select", Value = "" });

    }

    public void FillApplicationModeAll(ref DropDownList ddl)
    {
        foreach (int enumVal in Enum.GetValues(typeof(ApplicationMode)))
        {
            ddl.Items.Add(new ListItem { Text = Enum.GetName(typeof(ApplicationMode), enumVal).ToString().Replace("_", " "), Value = enumVal.ToString() });
        }
        ddl.Items.Insert(0, new ListItem { Text = "All", Value = "" });

    }

    public void FillIDProofType(ref DropDownList ddl)
    {
        foreach (int enumVal in Enum.GetValues(typeof(IDProofType)))
        {
            ddl.Items.Add(new ListItem { Text = Enum.GetName(typeof(IDProofType), enumVal).ToString().Replace("_", " "), Value = enumVal.ToString() });
        }
        ddl.Items.Insert(0, new ListItem { Text = "Select", Value = "" });
    }

    public void FillIDProofType(ref RadioButtonList rbl)
    {
        foreach (int enumVal in Enum.GetValues(typeof(IDProofType)))
        {
            rbl.Items.Add(new ListItem { Text = Enum.GetName(typeof(IDProofType), enumVal).ToString().Replace("_", " "), Value = enumVal.ToString() });
        }
        // rbl.Items.Insert(0, new ListItem { Text = "Select", Value = "" });
    }

    public void FillAddressProofType(ref DropDownList ddl)
    {
        foreach (int enumVal in Enum.GetValues(typeof(AddressProofType)))
        {
            ddl.Items.Add(new ListItem { Text = Enum.GetName(typeof(AddressProofType), enumVal).ToString().Replace("_", " "), Value = enumVal.ToString() });
        }
        ddl.Items.Insert(0, new ListItem { Text = "Select", Value = "" });
    }

    public void FillAddressProofType(ref RadioButtonList rbl)
    {
        foreach (int enumVal in Enum.GetValues(typeof(AddressProofType)))
        {
            rbl.Items.Add(new ListItem { Text = Enum.GetName(typeof(AddressProofType), enumVal).ToString().Replace("_", " "), Value = enumVal.ToString() });
        }
        // ddl.Items.Insert(0, new ListItem { Text = "Select", Value = "" });
    }


    #endregion

    #region Common Utility Functions


    // Eliminate special ecape character.
    private string Unquote(string strVal)
    {
        if (strVal == null) return "";
        return strVal.Replace("'", "''");
    }

    // Get Integer value from object.
    private char GetChar(object objVal)
    {
        char charValue;
        if (objVal == null) return '\0';
        if (objVal is DBNull) return '\0';
        if (objVal is char) return (char)objVal;
        char.TryParse(objVal.ToString(), out charValue);
        return charValue;
    }

    // Get Integer value from object.
    private int GetInteger(object objVal)
    {
        int intValue = 0;
        if (objVal == null) return 0;
        if (objVal is DBNull) return 0;
        if (objVal is int) return (int)objVal;
        int.TryParse(objVal.ToString(), out intValue);
        return intValue;
    }

    // Get Integer value from object.
    private Int64 GetInt64(object objVal)
    {
        Int64 intValue = 0;
        if (objVal == null) return 0;
        if (objVal is DBNull) return 0;
        if (objVal is Int64) return (Int64)objVal;
        Int64.TryParse(objVal.ToString(), out intValue);
        return intValue;
    }

    // Get Integer value from object.
    private Int16 GetInt16(object objVal)
    {
        Int16 intValue = 0;
        if (objVal == null) return 0;
        if (objVal is DBNull) return 0;
        if (objVal is Int16) return (Int16)objVal;
        Int16.TryParse(objVal.ToString(), out intValue);
        return intValue;
    }

    // Get int value from object.
    private int GetInt32(object objVal)
    {
        int intValue = 0;
        if (objVal == null) return 0;
        if (objVal is DBNull) return 0;
        if (objVal is int) return (int)objVal;
        int.TryParse(objVal.ToString(), out intValue);
        return intValue;
    }

    // Get Date type value from object.
    private DateTime GetDate(object objVal)
    {
        if (objVal == null) return Convert.ToDateTime(null);
        if (objVal is DBNull) return Convert.ToDateTime(null);
        if (objVal is string && string.IsNullOrEmpty(objVal.ToString())) return Convert.ToDateTime(null);
        return Convert.ToDateTime(objVal);
    }

    private bool GetBoolean(object objVal)
    {
        if (objVal is DBNull) return false;
        if (objVal == null) return false;
        return Convert.ToBoolean(objVal);
    }

    // Converts the item into its decimal value.
    private decimal GetDecimal(object objVal)
    {
        decimal decobjVal = 0M;
        if (objVal == null) return decobjVal;
        if (objVal is DBNull) return decobjVal;
        if (objVal is float) return Convert.ToDecimal(objVal);
        if (objVal is double) return Convert.ToDecimal(objVal);
        decimal.TryParse(objVal.ToString(), out decobjVal);
        return decobjVal;
    }

    // Converts the item into its floating point value.
    private double GetDouble(object objVal)
    {
        double result = 0;
        if (objVal == null) return 0;
        if (objVal is DBNull) return 0;
        string strObjVal = objVal.ToString();
        strObjVal = strObjVal.Replace("&pound;", "");
        strObjVal = strObjVal.Replace(",", "");
        double.TryParse(strObjVal, out result);
        return result;
    }
    // Converts the item into its floating point value.
    private float GetFloat(object objVal)
    {
        float result = 0;
        if (objVal == null) return 0;
        if (objVal is DBNull) return 0;
        string strObjVal = objVal.ToString();
        strObjVal = strObjVal.Replace("&pound;", "");
        strObjVal = strObjVal.Replace(",", "");
        float.TryParse(strObjVal, out result);
        return result;
    }
    // Converts the item into its byte value.
    private byte GetByte(object objVal)
    {
        byte result;
        if (objVal is DBNull) return 0;
        if (objVal == null) return 0;
        byte.TryParse(objVal.ToString(), out result);
        return result;
    }

    //Shahma
    public static string getFinYr(DateTime dt)
    {
        string Finyr = "";
        if (dt.Month >= 4)
            Finyr = dt.Year.ToString() + "-" + dt.AddYears(1).Year.ToString();
        else
            Finyr = dt.AddYears(-1).Year.ToString() + "-" + dt.Year.ToString();
        return Finyr;
    }
    #endregion

    public DataSet GetVillageName()
    {
        DataSet ds = new DataSet();
        string str = "select VillageId, VillageName from  Village_Master where IsActive=1";
        ds = SqlHelper.ExecuteDataset(Constr, CommandType.Text, str);
        return ds;

    }

    public List<ListItem> Populate_BudgetHead(Int16 headtype)
    {
        List<ListItem> lst = new List<ListItem>();
        using (var con = new SqlConnection(Constr))
        {
            string query = "select [FHeadKey] ,[FHeadName] from [dbo].[FinanceHead_Master] where IsActive=1 AND FHeadType=" + headtype + " order by FHeadName";
            SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, query);
            using (sdr)
            {
                while (sdr.Read())
                {
                    lst.Add(new ListItem
                    {
                        Value = sdr["FHeadKey"].ToString(),
                        Text = sdr["FHeadName"].ToString()
                    });
                }
            }
            lst.Insert(0, new ListItem
            {
                Value = "",
                Text = "Select"
            });
        }
        return lst;
    }

    public List<ListItem> PopulateVillageBlockwise(Int32 BlockKey)
    {
        List<ListItem> lst = new List<ListItem>();
        using (var con = new SqlConnection(Constr))
        {
            string query = "SELECT [VillageKey] ,[EnglishName] from Village where BlockKey='" + BlockKey + "' AND IsActive=1 order by EnglishName";
            SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, query);
            using (sdr)
            {
                while (sdr.Read())
                {
                    lst.Add(new ListItem
                    {
                        Value = sdr["VillageKey"].ToString(),
                        Text = sdr["EnglishName"].ToString()
                    });
                }
            }
        }
        return lst;
    }

    #region Database Backup Utility

    public void DatabaseBackup(string dbName, string dbBackupDirectory, string backupFileName)
    {
        SqlParameter[] paramList = new SqlParameter[3];

        paramList[0] = new SqlParameter("@DBName", dbName);
        paramList[1] = new SqlParameter("@DirectoryName", dbBackupDirectory);
        paramList[2] = new SqlParameter("@DBBackupFileName", backupFileName);

        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "DBBackup_DBLayer", paramList);
    }

    #endregion

    #region Business Logic For - Common_Master
    public List<ListItem> PopulateCommonMaster(string strRecordType, bool isHindi = false, bool withKey = true)
    {
        List<ListItem> lst = new List<ListItem>();
        using (var con = new SqlConnection(Constr))
        {
            if (isHindi)
            {
                SqlParameter[] param = new SqlParameter[]{
                    new SqlParameter("@RecordType",strRecordType),
                    new SqlParameter("@QueryType","SelectByRecordType")
                };
                SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "CommonMaster_DBLayer", param);
                if (withKey)
                {
                    using (sdr)
                    {
                        while (sdr.Read())
                        {
                            lst.Add(new ListItem
                            {
                                Value = sdr["MasterKey"].ToString(),
                                Text = sdr["ParticularHindi"].ToString()
                            });
                        }
                    }
                }
                else
                {
                    using (sdr)
                    {
                        while (sdr.Read())
                        {
                            lst.Add(new ListItem
                            {
                                Value = sdr["ParticularHindi"].ToString(),
                                Text = sdr["ParticularHindi"].ToString()
                            });
                        }
                    }
                }
            }
            else
            {
                SqlParameter[] param = new SqlParameter[]{
                    new SqlParameter("@RecordType",strRecordType),
                    new SqlParameter("@QueryType","SelectByRecordType")
                };
                SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "CommonMaster_DBLayer", param);
                if (withKey)
                {
                    using (sdr)
                    {
                        while (sdr.Read())
                        {
                            lst.Add(new ListItem
                            {
                                Value = sdr["MasterKey"].ToString(),
                                Text = sdr["ParticularEnglish"].ToString()
                            });
                        }
                    }
                }
                else
                {
                    using (sdr)
                    {
                        while (sdr.Read())
                        {
                            lst.Add(new ListItem
                            {
                                Value = sdr["ParticularEnglish"].ToString(),
                                Text = sdr["ParticularEnglish"].ToString()
                            });
                        }
                    }
                }

            }

        }
        return lst;
    }
    #endregion

    #region "Bussiness Logic For - Applicant Panel"
    public DataSet getschemename(int SchemeKey)
    {
        DataSet ds = new DataSet();

        string strSQL = "select * from SchemeMaster  where SchemeKey  =" + SchemeKey + " ";
        ds = SqlHelper.ExecuteDataset(Constr, CommandType.Text, strSQL);
        return ds;
    }

    public DataSet GetApplicantSchemetabBykey(int Regkey)
    {
        DataSet ds = new DataSet();

        string strSQL = "select * from ApplicantSchemeRegistration  where ApplicantSchemeRegistration.Registrationkey  =" + Regkey + " ";
        ds = SqlHelper.ExecuteDataset(Constr, CommandType.Text, strSQL);
        return ds;
    }
    public DataSet GetApplicantDetailBykey(Int64 Regkey)
    {
        DataSet ds = new DataSet();
        string strSQL = "SELECT * from dbo.ApplicantRegistration where Registrationkey=" + Regkey + "";
        ds = SqlHelper.ExecuteDataset(Constr, CommandType.Text, strSQL);
        return ds;
    }

    public DataSet GetApplicantSchemeDetailBykey(int Regkey)
    {
        DataSet ds = new DataSet();

        string strSQL = "SELECT     ApplicantRegistration.Name, ApplicantRegistration.aadharNo, ApplicantRegistration.MobileNo, ApplicantProfile.FatherName, ApplicantProfile.Gender, ApplicantProfile.RevenueVillage,  " +
                      " ApplicantProfile.UserBankName, ApplicantProfile.UserBankShakha, ApplicantProfile.UserBankIFSC, ApplicantProfile.UserAcNo, ApplicantProfile.Phone_No, ApplicantProfile.* " +
                       " FROM         ApplicantRegistration INNER JOIN " +
                       " ApplicantProfile ON ApplicantRegistration.Registrationkey = ApplicantProfile.RegistrationKey  where ApplicantRegistration.Registrationkey  =" + Regkey + " ";
        ds = SqlHelper.ExecuteDataset(Constr, CommandType.Text, strSQL);
        return ds;
    }

    public List<ListItem> PopulateSchemeStatus()
    {
        List<ListItem> lst = new List<ListItem>();
        using (var con = new SqlConnection(Constr))
        {
            const string query = "SELECT MasterKey as StatusKey, ParticularEnglish as StatusText from CommonMaster where RecordType='SchemeStatus' AND IsActive=1 order by ParticularEnglish";
            SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, query);
            using (sdr)
            {
                while (sdr.Read())
                {
                    lst.Add(new ListItem
                    {
                        Value = sdr["StatusKey"].ToString(),
                        Text = sdr["StatusText"].ToString()
                    });
                }
            }
            lst.Insert(0, new ListItem
            {
                Value = "",
                Text = "Select"
            });
            
        }
        return lst;
    }
    public List<ListItem> PopulateScheme()
    {
        List<ListItem> lst = new List<ListItem>();
        using (var con = new SqlConnection(Constr))
        {
            const string query = "SELECT [SchemeKey],[SchemeName],[SchemeCode] FROM [dbo].[SchemeMaster] where IsActive=1 order by SchemeName";
            SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, query);
            using (sdr)
            {
                while (sdr.Read())
                {
                    lst.Add(new ListItem
                    {
                        Value = sdr["SchemeKey"].ToString(),
                        Text = sdr["SchemeName"].ToString()
                    });
                }
            }
            lst.Insert(0, new ListItem
            {
                Value = "",
                Text = "Select"
            });
        }
        return lst;
    }
    #endregion
}