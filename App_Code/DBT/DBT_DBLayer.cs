using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using DBLibrary;

public partial class DBLayer
{
    #region DBT_District Panel

    #region DBT_ApplicantRegistration
    public string CreateDBTApplicantRegistration(DBT_ApplicantRegistration objDBT_ApplicantRegistration)
    {
        try
        {
            object obj = null;
            string result = "";
            if (objDBT_ApplicantRegistration.RegistrationCode == "")
            {
                if (objDBT_ApplicantRegistration.Schemes != null)
                {
                    List<DBT_ApplicantSchemeMaster> lstschemes = new List<DBT_ApplicantSchemeMaster>();
                    List<DBT_ApplicantSchemeDetail> lstschemesLand = new List<DBT_ApplicantSchemeDetail>();

                    foreach (DBT_ApplicantSchemeMaster schemesMst in objDBT_ApplicantRegistration.Schemes)
                    {
                        lstschemes.Add(schemesMst);
                        if (schemesMst.Lands != null)
                        {
                            foreach (DBT_ApplicantSchemeDetail objSchemeLand in schemesMst.Lands)
                            {
                                lstschemesLand.Add(objSchemeLand);
                            }
                        }
                    }

                    if (lstschemes.Count > 0 && lstschemesLand.Count > 0)
                    {
                        string xmlSchemes = GlobalFunctions.ConvertToXMLFormat<DBT_ApplicantSchemeMaster>(ref lstschemes);
                        string xmlSchemeLand = GlobalFunctions.ConvertToXMLFormat<DBT_ApplicantSchemeDetail>(ref lstschemesLand);

                        SqlParameter[] objParam = new SqlParameter[] { 
                            new SqlParameter("@RegistrationDate",GeneralClass.GetDateForDB(objDBT_ApplicantRegistration.RegistrationDate)),
                            new SqlParameter("@AadharNo",objDBT_ApplicantRegistration.AadharNo),
                            new SqlParameter("@AFirstName",objDBT_ApplicantRegistration.AFirstName),
                            new SqlParameter("@ALastName",objDBT_ApplicantRegistration.ALastName),
                            new SqlParameter("@ASecondName",objDBT_ApplicantRegistration.ASecondName),
                            new SqlParameter("@AccountNo",objDBT_ApplicantRegistration.AccountNo),
                            new SqlParameter("@BankKey",objDBT_ApplicantRegistration.BankKey),
                            new SqlParameter("@BlockKey",objDBT_ApplicantRegistration.BlockKey),
                            new SqlParameter("@BranchKey",objDBT_ApplicantRegistration.BranchKey),
                            new SqlParameter("@Category",objDBT_ApplicantRegistration.Category),
                            new SqlParameter("@CreatedBy",objDBT_ApplicantRegistration.CreatedBy),
                            new SqlParameter("@DistrictKey",objDBT_ApplicantRegistration.DistrictKey),
                            new SqlParameter("@EmailId",objDBT_ApplicantRegistration.EmailId),
                            new SqlParameter("@FFirstName",objDBT_ApplicantRegistration.FFirstName),
                            new SqlParameter("@FinancialYear",objDBT_ApplicantRegistration.FinancialYear),
                            new SqlParameter("@FLastName",objDBT_ApplicantRegistration.FLastName),
                            new SqlParameter("@FSecondName",objDBT_ApplicantRegistration.FSecondName),
                            new SqlParameter("@Gender",objDBT_ApplicantRegistration.Gender),
                            new SqlParameter("@IFSCCode",objDBT_ApplicantRegistration.IFSCCode),

                            new SqlParameter("@Minority",objDBT_ApplicantRegistration.Minority),
                            new SqlParameter("@MobileNo",objDBT_ApplicantRegistration.MobileNo),               
                            new SqlParameter("@VillageKey",objDBT_ApplicantRegistration.VillageKey),

                            new SqlParameter("@DateofBirth",GeneralClass.GetDateForDB(objDBT_ApplicantRegistration.DateofBirth)),
                            new SqlParameter("@VoterIdCard",objDBT_ApplicantRegistration.VoterIdCard),
                            new SqlParameter("@KisanCreditCard",objDBT_ApplicantRegistration.kisanCreditCard),

                            new SqlParameter("@SchemeXML",xmlSchemes),
                            new SqlParameter("@LandXML",xmlSchemeLand),

                            new SqlParameter("@QueryType","INSERT")
                        };
                        obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "DBT_ApplicantRegistration_DBLayer", objParam);
                    }
                    else
                    {
                        result = "";
                    }
                }
                else
                {
                    SqlParameter[] objParam = new SqlParameter[] {  
                            new SqlParameter("@RegistrationDate",GeneralClass.GetDateForDB(objDBT_ApplicantRegistration.RegistrationDate)),
                            new SqlParameter("@AadharNo",objDBT_ApplicantRegistration.AadharNo),
                            new SqlParameter("@AFirstName",objDBT_ApplicantRegistration.AFirstName),
                            new SqlParameter("@ALastName",objDBT_ApplicantRegistration.ALastName),
                            new SqlParameter("@ASecondName",objDBT_ApplicantRegistration.ASecondName),
                            new SqlParameter("@AccountNo",objDBT_ApplicantRegistration.AccountNo),
                            new SqlParameter("@BankKey",objDBT_ApplicantRegistration.BankKey),
                            new SqlParameter("@BlockKey",objDBT_ApplicantRegistration.BlockKey),
                            new SqlParameter("@BranchKey",objDBT_ApplicantRegistration.BranchKey),
                            new SqlParameter("@Category",objDBT_ApplicantRegistration.Category),
                            new SqlParameter("@CreatedBy",objDBT_ApplicantRegistration.CreatedBy),
                            new SqlParameter("@DistrictKey",objDBT_ApplicantRegistration.DistrictKey),
                            new SqlParameter("@EmailId",objDBT_ApplicantRegistration.EmailId),
                            new SqlParameter("@FFirstName",objDBT_ApplicantRegistration.FFirstName),
                            new SqlParameter("@FinancialYear",objDBT_ApplicantRegistration.FinancialYear),
                            new SqlParameter("@FLastName",objDBT_ApplicantRegistration.FLastName),
                            new SqlParameter("@FSecondName",objDBT_ApplicantRegistration.FSecondName),
                            new SqlParameter("@Gender",objDBT_ApplicantRegistration.Gender),
                            new SqlParameter("@IFSCCode",objDBT_ApplicantRegistration.IFSCCode),

                            new SqlParameter("@Minority",objDBT_ApplicantRegistration.Minority),
                            new SqlParameter("@MobileNo",objDBT_ApplicantRegistration.MobileNo),
                            new SqlParameter("@VillageKey",objDBT_ApplicantRegistration.VillageKey),

                            new SqlParameter("@DateofBirth",GeneralClass.GetDateForDB(objDBT_ApplicantRegistration.DateofBirth)),
                            new SqlParameter("@VoterIdCard",objDBT_ApplicantRegistration.VoterIdCard),
                            new SqlParameter("@KisanCreditCard",objDBT_ApplicantRegistration.kisanCreditCard),

                            new SqlParameter("@QueryType","INSERT")
                        };
                    obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "DBT_ApplicantRegistration_DBLayer", objParam);
                }

                if (obj != null && obj != DBNull.Value)
                    result = obj.ToString();
                else
                    result = "";
            }
            else
            {
                result = "";
            }

            return result;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public string CreateDBTApplicantDistribution(DBT_InsDistributionMaster objDBT_InsDistributionMaster)
    {
        try
        {
            object obj = null;
            string result = "";
            if (objDBT_InsDistributionMaster.RegistrationKey > 0)
            {
                if (objDBT_InsDistributionMaster.SchemeKey > 0)
                {
                    if (objDBT_InsDistributionMaster.Installments.Count > 0 && objDBT_InsDistributionMaster.InsDocuments.Count > 0)
                    {
                        string xmlSchemes = GlobalFunctions.ConvertToXMLFormat<DBT_InsDistributionDetail>(ref objDBT_InsDistributionMaster.Installments);
                        string xmlDocs = GlobalFunctions.ConvertToXMLFormat<DBT_DocumentDetail>(ref objDBT_InsDistributionMaster.InsDocuments);
                        SqlParameter[] objParam = new SqlParameter[] { 
                            new SqlParameter("@RegistrationKey",objDBT_InsDistributionMaster.RegistrationKey),
                            new SqlParameter("@FinYear",objDBT_InsDistributionMaster.FinYear),
                            new SqlParameter("@BenCost",objDBT_InsDistributionMaster.BenCost),
                            new SqlParameter("@ProjectCost",objDBT_InsDistributionMaster.ProjectCost),
                            new SqlParameter("@SchemeKey",objDBT_InsDistributionMaster.SchemeKey),
                            new SqlParameter("@SubCost",objDBT_InsDistributionMaster.SubCost),

                            new SqlParameter("@InsXml",xmlSchemes),
                            new SqlParameter("@InsDocsXml",xmlDocs),

                            new SqlParameter("@CreatedBy",objDBT_InsDistributionMaster.CreatedBy),
                            new SqlParameter("@QueryType","INSERT")
                        };
                        obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "DBT_InsDistribution_DBLayer", objParam);
                    }
                    else
                    {
                        result = "";
                    }

                }

                if (obj != null && obj != DBNull.Value)
                    result = obj.ToString();
                else
                    result = "";
            }
            else
            {
                result = "";
            }

            return result;
        }
        catch (Exception ex)
        {
            foreach (DBT_DocumentDetail objDoc in objDBT_InsDistributionMaster.InsDocuments)
            {
                try
                {
                    if (objDoc.DocumentPath != "" && System.IO.File.Exists(HttpContext.Current.Server.MapPath("~/" + DBLayer.DBT_InstDistribution + '/' + objDoc.DocumentPath)))
                        System.IO.File.Delete(HttpContext.Current.Server.MapPath("~/" + DBLayer.DBT_InstDistribution + "/") + objDoc.DocumentPath);
                }
                catch (Exception exx)
                {
                    throw exx;
                }
            }
            throw ex;

        }
    }

    public string UpdateForwardBillByDBT(DBT_InsDistributionMaster objDBT_InsDistributionMaster)
    {
        try
        {
            object obj = null;
            string result = "";
            if (objDBT_InsDistributionMaster.Installments.Count > 0)
            {
                string xmlIns = GlobalFunctions.ConvertToXMLFormat<DBT_InsDistributionDetail>(ref objDBT_InsDistributionMaster.Installments);

                SqlParameter[] objParam = new SqlParameter[] { 
                            new SqlParameter("@SchemeKey",objDBT_InsDistributionMaster.SchemeKey),
                            new SqlParameter("@DistrictKey",objDBT_InsDistributionMaster.DistrictKey),
                            new SqlParameter("@TotalBilledAmount",objDBT_InsDistributionMaster.TotalBilledAmount),
                            new SqlParameter("@TotalApplicant",objDBT_InsDistributionMaster.TotalApplicant),
                            new SqlParameter("@CreatedBy", objDBT_InsDistributionMaster.CreatedBy),
                            new SqlParameter("@InsXml",xmlIns),
                            new SqlParameter("@QueryType","UPDATE_IS_FORWORD")
                        };
                obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "DBT_InsDistribution_DBLayer", objParam);

                if (obj != null && obj != DBNull.Value)
                    result = obj.ToString();
                else
                    result = "";
            }
            else
            {
                result = "";
            }

            return result;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public string UpdateDBTApplicant(DBT_ApplicantRegistration objDBT_ApplicantRegistration)
    {
        try
        {
            object obj = null;
            string result = "";
            if (objDBT_ApplicantRegistration.RegistrationCode != "")
            {
                if (objDBT_ApplicantRegistration.Schemes != null)
                {
                    List<DBT_ApplicantSchemeMaster> lstschemes = new List<DBT_ApplicantSchemeMaster>();
                    List<DBT_ApplicantSchemeDetail> lstschemesLand = new List<DBT_ApplicantSchemeDetail>();

                    foreach (DBT_ApplicantSchemeMaster schemesMst in objDBT_ApplicantRegistration.Schemes)
                    {
                        lstschemes.Add(schemesMst);
                        if (schemesMst.Lands != null)
                        {
                            foreach (DBT_ApplicantSchemeDetail objSchemeLand in schemesMst.Lands)
                            {
                                lstschemesLand.Add(objSchemeLand);
                            }
                        }
                    }

                    if (lstschemes.Count > 0 && lstschemesLand.Count > 0)
                    {
                        string xmlSchemes = GlobalFunctions.ConvertToXMLFormat<DBT_ApplicantSchemeMaster>(ref lstschemes);
                        string xmlSchemeLand = GlobalFunctions.ConvertToXMLFormat<DBT_ApplicantSchemeDetail>(ref lstschemesLand);

                        SqlParameter[] objParam = new SqlParameter[] { 
                            new SqlParameter("@RegistrationCode",objDBT_ApplicantRegistration.RegistrationCode),

                            new SqlParameter("@SchemeXML",xmlSchemes),
                            new SqlParameter("@LandXML",xmlSchemeLand),

                            new SqlParameter("@QueryType","INSERT_SCHEME_EXIST_APPLICANT")
                        };
                        obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "DBT_ApplicantRegistration_DBLayer", objParam);
                    }
                    else
                    {
                        result = "";
                    }

                }
                if (obj != null && obj != DBNull.Value)
                    result = obj.ToString();
                else
                    result = "";
            }
            else
            {
                result = "";
            }

            return result;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public DataTable GetDBT_ApplicantByRegCode(string RegCode, int DistrictKey)
    {
        DataTable dtReg = new DataTable();
        try
        {
            if (RegCode != "")
            {
                SqlParameter[] objParam = new SqlParameter[] { 
                    new SqlParameter("@DistrictKey",DistrictKey),
                    new SqlParameter("@RegistrationCode",RegCode),
                    new SqlParameter("@QueryType","SELECT_BY_CODE_DISTRICT_KEY")
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "DBT_ApplicantRegistration_DBLayer", objParam);
                dtReg.Load(dr);
            }
            return dtReg;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public DataTable GetDBT_ApplicantByRegCode(int RegKey)
    {
        DataTable dtReg = new DataTable();
        try
        {
            if (RegKey>0)
            {
                SqlParameter[] objParam = new SqlParameter[] {
                    new SqlParameter("@RegistrationKey",RegKey),
                    new SqlParameter("@QueryType","SELECT_BY_REG_KEY")
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "DBT_ApplicantRegistration_DBLayer", objParam);
                dtReg.Load(dr);
            }
            return dtReg;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public DataTable GetDBT_IsForwardedByDistrict(string FinYear, int DistrictKey, Int64 SchemeKey)
    {
        DataTable dtReg = new DataTable();
        try
        {
            if (FinYear != "" && DistrictKey > 0)
            {
                SqlParameter[] objParam = new SqlParameter[] { 
                    new SqlParameter("@FinYear",FinYear),
                    new SqlParameter("@DistrictKey",DistrictKey),
                    new SqlParameter("@SchemeKey",SchemeKey),
                    new SqlParameter("@QueryType","Get_BillForward_By_District")
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "DBT_InsDistribution_DBLayer", objParam);
                dtReg.Load(dr);
            }
            return dtReg;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public DataTable GetDBT_ForwardedStatusByDistrict(string FinYear, int DistrictKey)
    {
        DataTable dtReg = new DataTable();
        try
        {
            if (FinYear != "" && DistrictKey > 0)
            {
                SqlParameter[] objParam = new SqlParameter[] { 
                    new SqlParameter("@FinYear",FinYear),
                    new SqlParameter("@DistrictKey",DistrictKey),
                    new SqlParameter("@QueryType","Get_ForwardedBill_Status_By_District")
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "DBT_InsDistribution_DBLayer", objParam);
                dtReg.Load(dr);
            }
            return dtReg;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public DataTable GetDBT_ForwardedListByDistrict(string FinYear, int DistrictKey, Int64 SchemeKey, Int64 ProgressKey, Int64 InsKey)
    {
        DataTable dtReg = new DataTable();
        try
        {
            if (FinYear != "" && DistrictKey > 0)
            {
                SqlParameter[] objParam = new SqlParameter[] { 
                    new SqlParameter("@FinYear",FinYear),
                    new SqlParameter("@DistrictKey",DistrictKey),
                    new SqlParameter("@SchemeKey",SchemeKey),
                    new SqlParameter("@WorkTypeKey",ProgressKey),
                    new SqlParameter("@InstallmentKey",InsKey),
                    new SqlParameter("@QueryType","Get_ForwardedList_By_District")
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "DBT_InsDistribution_DBLayer", objParam);
                dtReg.Load(dr);
            }
            return dtReg;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public List<ListItem> GetSchemesByRegCode(string RegCode)
    {
        List<ListItem> lst = new List<ListItem>();
        try
        {
            if (RegCode != "")
            {
                SqlParameter[] objParam = new SqlParameter[] { 
                     new SqlParameter("@RegistrationCode",RegCode),
                     new SqlParameter("@QueryType","Get_Scheme_By_RegCode")
                };

                SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "DBT_ApplicantRegistration_DBLayer", objParam);
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
                return lst;
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
        return lst;
    }

    public List<ListItem> GetProgressTypeByRegCode(int schemeid, string regCode)
    {
        try
        {
            List<ListItem> lst = new List<ListItem>();
            using (var con = new SqlConnection(Constr))
            {
                SqlDataReader sdr;
                if (schemeid > 0 && regCode != "")
                {
                    SqlParameter[] param = new SqlParameter[] { 
                         new SqlParameter("@QueryType","Get_WorkType_By_RegCode_SchemeKey")
                        ,new SqlParameter("@RegistrationCode",regCode)
                        ,new SqlParameter("@SchemeKey",schemeid)
                    };
                    sdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "DBT_ApplicantRegistration_DBLayer", param);
                }
                else
                {
                    const string query = "Select WorkTypeKey, WorkTypeName From [dbo].[DBT_WorkTypeMaster] Where ISNULL(IsActive,1) = 1 Order By WorkTypeKey";
                    sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, query);
                }

                using (sdr)
                {
                    while (sdr.Read())
                    {
                        lst.Add(new ListItem
                        {
                            Value = sdr["WorkTypeKey"].ToString(),
                            Text = sdr["WorkTypeName"].ToString()
                        });
                    }
                }
            }
            return lst;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public List<ListItem> GetWorkIntallmentByRegCode(int schemeid, int WorkTypeID, string regCode)
    {
        try
        {
            List<ListItem> lst = new List<ListItem>();
            using (var con = new SqlConnection(Constr))
            {
                SqlDataReader sdr;
                if (schemeid > 0 && WorkTypeID > 0 && regCode != "")
                {
                    SqlParameter[] param = new SqlParameter[] { 
                         new SqlParameter("@QueryType","GET_WorkInsatment_RegCode_SchemeKey_WorkType")
                        ,new SqlParameter("@SchemeKey",schemeid)
                        ,new SqlParameter("@RegistrationCode",regCode)
                        ,new SqlParameter("@WorkTypeKey",WorkTypeID)
                    };
                    sdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "DBT_ApplicantRegistration_DBLayer", param);
                    using (sdr)
                    {
                        while (sdr.Read())
                        {
                            lst.Add(new ListItem
                            {
                                Value = sdr["DetailKey"].ToString(),
                                Text = sdr["InstallmentNo"].ToString()
                            });
                        }
                    }
                }
            }
            return lst;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public DataTable GetWorkIntallmentAmount(int schemeid, int WorkTypeID, string regCode, int InsSlabe)
    {
        DataTable dt = new DataTable();
        try
        {
            using (var con = new SqlConnection(Constr))
            {
                SqlDataReader sdr;
                if (schemeid > 0 && WorkTypeID > 0 && regCode != "")
                {
                    SqlParameter[] param = new SqlParameter[] { 
                         new SqlParameter("@SchemeKey",schemeid)
                        ,new SqlParameter("@RegistrationCode",regCode)
                        ,new SqlParameter("@WorkTypeKey",WorkTypeID)
                        ,new SqlParameter("@InsSlabe",InsSlabe)
                    };
                    sdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "Get_DBT_AppInsatallmentAmount", param);
                    dt.Load(sdr);
                }
            }
            return dt;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public DataTable GetDocumentByWorkInstallment(int WorkTypeKey, Int64 InsDetailKey)
    {
        DataTable dt = new DataTable();
        try
        {
            using (var con = new SqlConnection(Constr))
            {
                SqlDataReader sdr;
                if (WorkTypeKey > 0 && InsDetailKey > 0)
                {
                    SqlParameter[] param = new SqlParameter[] { 
                         new SqlParameter("@WorkTypeKey",WorkTypeKey)
                        ,new SqlParameter("@InsDetailKey",InsDetailKey)
                        ,new SqlParameter("@QueryType","GET_Installment_Document")
                    };
                    sdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "DBT_SchemeWorkTypeMaster_DBLayer", param);
                    dt.Load(sdr);
                }
            }
            return dt;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public List<ListItem> Get_RegistrationCodeList(int districtkey, string financialyear)
    {
        List<ListItem> lst = new List<ListItem>();
        try
        {
            using (var con = new SqlConnection(Constr))
            {
                SqlDataReader sdr;
                SqlParameter[] param = new SqlParameter[] {
                         new SqlParameter("@DistrictKey",districtkey),
                         new SqlParameter("@FinancialYear",financialyear)

                    };
                sdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "Get_RegistrationCodeList", param);
                using (sdr)
                {
                    while (sdr.Read())
                    {
                        lst.Add(new ListItem
                        {
                            Value = sdr["RegistrationKey"].ToString(),
                            Text = sdr["RegistrationCodeName"].ToString()
                        });
                    }
                }

                return lst;
            }
           
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public string GetRegCode(int Regkey)
    {
        string regcode = "";
        string str = "SELECT dar.RegistrationCode FROM dbo.DBT_ApplicantRegistration dar WHERE dar.RegistrationKey=" + Regkey + "";
        regcode = SqlHelper.ExecuteScalar(Constr, CommandType.Text, str).ToString();
        return regcode;

    }

    #endregion

    #endregion

    #region DBT_Division Panel
    public List<ListItem> GetProgressTypeByScheme(int schemeid)
    {
        try
        {
            List<ListItem> lst = new List<ListItem>();
            using (var con = new SqlConnection(Constr))
            {
                SqlDataReader sdr;
                if (schemeid > 0)
                {
                    SqlParameter[] param = new SqlParameter[] { 
                         new SqlParameter("@QueryType","Get_WorkType_By_SchemeKey")
                        ,new SqlParameter("@SchemeKey",schemeid)
                    };
                    sdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "DBT_SchemeWorkTypeMaster_DBLayer", param);
                }
                else
                {
                    const string query = "Select WorkTypeKey, WorkTypeName From [dbo].[DBT_WorkTypeMaster] Where ISNULL(IsActive,1) = 1 Order By WorkTypeKey";
                    sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, query);
                }

                using (sdr)
                {
                    while (sdr.Read())
                    {
                        lst.Add(new ListItem
                        {
                            Value = sdr["WorkTypeKey"].ToString(),
                            Text = sdr["WorkTypeName"].ToString()
                        });
                    }
                }
            }
            return lst;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public List<ListItem> GetWorkIntallmentByWorkType(int schemeid, int WorkTypeID)
    {
        try
        {
            List<ListItem> lst = new List<ListItem>();
            using (var con = new SqlConnection(Constr))
            {
                SqlDataReader sdr;
                if (schemeid > 0 && WorkTypeID > 0)
                {
                    SqlParameter[] param = new SqlParameter[] { 
                         new SqlParameter("@QueryType","GET_WorkInsatment_SchemeKey_WorkType")
                        ,new SqlParameter("@SchemeKey",schemeid)
                        ,new SqlParameter("@WorkTypeKey",WorkTypeID)
                    };
                    sdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "DBT_SchemeWorkTypeMaster_DBLayer", param);
                    using (sdr)
                    {
                        while (sdr.Read())
                        {
                            lst.Add(new ListItem
                            {
                                Value = sdr["DetailKey"].ToString(),
                                Text = sdr["InstallmentNo"].ToString()
                            });
                        }
                    }
                }
            }
            return lst;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public List<ListItem> GetWorkIntallmentWithInsKey(int schemeid, int WorkTypeID)
    {
        try
        {
            List<ListItem> lst = new List<ListItem>();
            using (var con = new SqlConnection(Constr))
            {
                SqlDataReader sdr;
                if (schemeid > 0 && WorkTypeID > 0)
                {
                    SqlParameter[] param = new SqlParameter[] { 
                         new SqlParameter("@QueryType","GET_INSTALLMENTWITHNO_SchemeKey_WorkType")
                        ,new SqlParameter("@SchemeKey",schemeid)
                        ,new SqlParameter("@WorkTypeKey",WorkTypeID)
                    };
                    sdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "DBT_SchemeWorkTypeMaster_DBLayer", param);
                    using (sdr)
                    {
                        while (sdr.Read())
                        {
                            lst.Add(new ListItem
                            {
                                Value = sdr["InstallmentNo"].ToString(),
                                Text = sdr["InstallmentName"].ToString()
                            });
                        }
                    }
                }
            }
            return lst;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public DataTable GetDBT_ForwardedListByDivision(string FinYear, int DivisionKey, Int64 SchemeKey, Int64 ProgressKey, Int64 InsKey)
    {
        DataTable dtReg = new DataTable();
        try
        {
            if (FinYear != "" && DivisionKey > 0)
            {
                SqlParameter[] objParam = new SqlParameter[] { 
                    new SqlParameter("@FinYear",FinYear),
                    new SqlParameter("@DivisionKey",DivisionKey),
                    new SqlParameter("@SchemeKey",SchemeKey),
                    new SqlParameter("@WorkTypeKey",ProgressKey),
                    new SqlParameter("@InstallmentKey",InsKey),
                    new SqlParameter("@QueryType","GetList_By_Division")
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "DBT_InsDistribution_DBLayer", objParam);
                dtReg.Load(dr);
            }
            return dtReg;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public DataTable GetDBT_ForwardedStatusByDivision(string FinYear, int DivisionKey)
    {
        DataTable dtReg = new DataTable();
        try
        {
            if (FinYear != "" && DivisionKey > 0)
            {
                SqlParameter[] objParam = new SqlParameter[] { 
                    new SqlParameter("@FinYear",FinYear),
                    new SqlParameter("@DivisionKey",DivisionKey),
                    new SqlParameter("@QueryType","Get_ForwardedBill_Status_Division")
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "DBT_InsDistribution_DBLayer", objParam);
                dtReg.Load(dr);
            }
            return dtReg;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public string UpdateStatusByMandal(DBT_InsDistributionDetail objDBT_InsDistributionDetail, bool IsApproved)
    {
        string regCode = "";
        try
        {
            SqlParameter[] objParam = new SqlParameter[] { 

                new SqlParameter("@DetailKey",objDBT_InsDistributionDetail.DetailKey),
                new SqlParameter("@VerifiedBy",objDBT_InsDistributionDetail.VerifiedBy),
                 new SqlParameter("@IsDocVerify",objDBT_InsDistributionDetail.IsDocVerify),
                new SqlParameter("@InsStatus",(IsApproved ? 31:32)), //Status Code Map with Common Master Table
                new SqlParameter("@QueryType","Update_Status_By_Mandal")

                };

            object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "DBT_InsDistribution_DBLayer", objParam);
            if (obj != null && obj != DBNull.Value)
                regCode = obj.ToString();
            return regCode;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public string UpdateStatusByHO(ICollection<DBT_InsDistributionDetail> objDBT_InsDistributionDetails)
    {
        string regCode = "";
        try
        {
            if (objDBT_InsDistributionDetails.Count > 0)
            {
                string xmlDis = GlobalFunctions.ConvertToXMLFormat<DBT_InsDistributionDetail>(ref objDBT_InsDistributionDetails);
                SqlParameter[] objParam = new SqlParameter[] { 

                new SqlParameter("@xmlDistributions",xmlDis),
                new SqlParameter("@QueryType","FinalApproveByHO")

                };

                object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "DBT_InsDistribution_DBLayer", objParam);
                if (obj != null && obj != DBNull.Value)
                    regCode = obj.ToString();
            }

            return regCode;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public DataTable GetDBT_BillList(Int64 divisionKey)
    {
        DataTable dt = new DataTable();
        try
        {
            SqlParameter[] objParam = new SqlParameter[] { 
                    new SqlParameter("@DivisionKey", divisionKey),
                    new SqlParameter("@QueryType","DBTBillList_By_Division")
                };
            SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "DBT_InsDistribution_DBLayer", objParam);
            dt.Load(dr);

            return dt;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public DataTable GetDBT_BillList_ById(Int64 id)
    {
        DataTable dt = new DataTable();
        try
        {
            SqlParameter[] objParam = new SqlParameter[] { 
                    new SqlParameter("@BillForwardingKey", id),
                    new SqlParameter("@QueryType","DBTBillList_ById")
                };
            SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "DBT_InsDistribution_DBLayer", objParam);
            dt.Load(dr);

            return dt;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public DataTable GetDBT_BillList_Details_ById(Int64 id)
    {
        DataTable dt = new DataTable();
        try
        {
            SqlParameter[] objParam = new SqlParameter[] { 
                    new SqlParameter("@BillForwardingKey", id),
                    new SqlParameter("@QueryType","DBTBillList_Details_ById")
                };
            SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "DBT_InsDistribution_DBLayer", objParam);
            dt.Load(dr);

            return dt;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public string UpdateGeneratedFile(string generatedFileName, Int64 forwardedkey)
    {
        string regCode = "";
        try
        {
            SqlParameter[] objParam = new SqlParameter[] { 

                new SqlParameter("@BillForwardingKey", forwardedkey),
                new SqlParameter("@GeneratedFileName", generatedFileName),
                new SqlParameter("@QueryType", "UpdateGeneratedFileStatus")

                };

            object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "DBT_InsDistribution_DBLayer", objParam);
            if (obj != null && obj != DBNull.Value)
                regCode = obj.ToString();
            return regCode;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    public int InsertFileData(string xmlGeneratedText)
    {
        int key = 0;
        SqlParameter[] objParam = new SqlParameter[] {                         
                    new SqlParameter("@GeneratedTextXML", xmlGeneratedText),
                    new SqlParameter("@QueryType","INSERT")
                   };
        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "DBT_GenerateFile_DBLayer", objParam);
        if (obj != null && obj != DBNull.Value)
            key = Convert.ToInt32(obj.ToString());
        return key;
    }

    public int MappedBeneficiaryID(string registrationNo, string beneficiaryId, Int64 lastmodifiedby)
    {
        int key = 0;
        SqlParameter[] objParam = new SqlParameter[] {                         
                    new SqlParameter("@RegistrationNo", registrationNo),
                    new SqlParameter("@BeneficiaryId", beneficiaryId),
                    new SqlParameter("@LastModifiedBy",lastmodifiedby),
                    new SqlParameter("@QueryType","Mapped_BeneficiaryId")
                   };
        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "DBT_GenerateFile_DBLayer", objParam);
        if (obj != null && obj != DBNull.Value)
            key = Convert.ToInt32(obj.ToString());
        return key;
    }


    public int Update_DBTToken(string tokenno, string dbtdate, Int64 lastmodifiedby, Int64 billforwardingkey)
    {
        int key = 0;
        DateTime dt = Convert.ToDateTime(GeneralClass.GetDateInMMDDYYYY(dbtdate));
        SqlParameter[] objParam = new SqlParameter[] {                         
                    new SqlParameter("@TokenNo", tokenno),
                    new SqlParameter("@DBTDate", dt),
                    new SqlParameter("@LastModifiedBy",lastmodifiedby),
                    new SqlParameter("@BillForwardingKey",billforwardingkey),
                    new SqlParameter("@QueryType","Update_TokenNo")
                   };
        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "DBT_InsDistribution_DBLayer", objParam);
        if (obj != null && obj != DBNull.Value)
            key = Convert.ToInt32(obj.ToString());
        return key;
    }


    #endregion

    #region DBT_HeadQuarter Panel
    public DataTable GetDBT_ForwardedListByMandal(string FinYear, Int64 SchemeKey, Int64 ProgressKey, Int64 InsKey)
    {
        DataTable dtReg = new DataTable();
        try
        {
            if (FinYear != "")
            {
                SqlParameter[] objParam = new SqlParameter[] { 
                    new SqlParameter("@FinYear",FinYear),
                    new SqlParameter("@SchemeKey",SchemeKey),
                    new SqlParameter("@WorkTypeKey",ProgressKey),
                    new SqlParameter("@InstallmentKey",InsKey),
                    new SqlParameter("@QueryType","Get_ForwardedList_By_Mandal")
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "DBT_InsDistribution_DBLayer", objParam);
                dtReg.Load(dr);
            }
            return dtReg;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion





}
