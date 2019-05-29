using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using DBLibrary;

/// <summary>
/// Summary description for DBLayer
/// </summary>
public partial class DBLayer
{
    #region Business Logic Using Query For - Getting Data

    public DataTable GetDocumentType()
    {
        DataSet ds = new DataSet();
        try
        {
            string query = "Select DocumentId, DocumentName From DocumentMst";
            ds = SqlHelper.ExecuteDataset(Constr, CommandType.Text, query);
            if (ds.Tables.Count > 0)
            {
                return ds.Tables[0];
            }
            else
                return null;
        }
        catch
        {
            return null;
        }
    }

    #endregion

    #region Business Logic Using Procedure - Scheme

    public int UpdateScheme(SchemeMaster objSchemeMaster, bool isUpdate)
    {
        int intRowAffected = 0;
        try
        {
            string xmlDoc = GlobalFunctions.ConvertToXMLFormat<SchemeDocument>(ref objSchemeMaster.Documents);
            if (isUpdate == false)
            {
                SqlParameter[] objParam = new SqlParameter[] { 
                new SqlParameter("@SchemeCode",objSchemeMaster.SchemeCode),
                new SqlParameter("@SchemeTypeKey",objSchemeMaster.SchemeTypeKey),
                new SqlParameter("@SchemeName",objSchemeMaster.SchemeName),
                new SqlParameter("@Description",objSchemeMaster.Description),
                new SqlParameter("@GuidelinesUrl",objSchemeMaster.GuidelinesUrl),
                new SqlParameter("@Start_date",GeneralClass.GetDateForDB((objSchemeMaster.Start_date))),
                new SqlParameter("@End_date",GeneralClass.GetDateForDB((objSchemeMaster.End_Date))),
                new SqlParameter("@IsActive",objSchemeMaster.IsActive),
                new SqlParameter("@CreatedBy",objSchemeMaster.CreatedBy),
                new SqlParameter("@DocXML",xmlDoc),
                new SqlParameter("@QueryType","INSERT")
                };
                object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "SchemeMaster_DBLayer", objParam);
                if (obj != null && obj != DBNull.Value)
                    intRowAffected = Convert.ToInt32(obj);
                else
                    intRowAffected = 0;
            }
            else
            {
                SqlParameter[] objParam = new SqlParameter[] { 
                    new SqlParameter("@SchemeKey",objSchemeMaster.SchemeKey),
                    new SqlParameter("@SchemeTypeKey",objSchemeMaster.SchemeTypeKey),
                    new SqlParameter("@SchemeCode",objSchemeMaster.SchemeCode),
                    new SqlParameter("@SchemeName",objSchemeMaster.SchemeName),
                    new SqlParameter("@Description",objSchemeMaster.Description),
                    new SqlParameter("@GuidelinesUrl",objSchemeMaster.GuidelinesUrl),
                    new SqlParameter("@Start_date",GeneralClass.GetDateForDB((objSchemeMaster.Start_date))),
                    new SqlParameter("@End_date",GeneralClass.GetDateForDB((objSchemeMaster.End_Date))),
                    new SqlParameter("@IsActive",objSchemeMaster.IsActive),
                      new SqlParameter("@LastModifiedBy",objSchemeMaster.LastModifiedBy),
                    new SqlParameter("@DocXML",xmlDoc),
                    new SqlParameter("@QueryType","UPDATE")
                };
                object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "SchemeMaster_DBLayer", objParam);
                if (obj != null && obj != DBNull.Value)
                    intRowAffected = Convert.ToInt32(obj);
                else
                    intRowAffected = 0;
            }

            return intRowAffected;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public DataTable GetAllScheme(Int64 intSchemeKey = 0)
    {
        DataTable dtShemes = new DataTable();
        try
        {
            if (intSchemeKey == 0)
            {
                SqlParameter[] objParam = new SqlParameter[] { 
                new SqlParameter("@QueryType","SELECT_ALL_DATA")
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "SchemeMaster_DBLayer", objParam);
                dtShemes.Load(dr);
            }
            else
            {
                SqlParameter[] objParam = new SqlParameter[] { 
                    new SqlParameter("@SchemeKey",intSchemeKey),
                    new SqlParameter("@QueryType","SELECT_BY_ID")
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "SchemeMaster_DBLayer", objParam);
                dtShemes.Load(dr);

            }
            return dtShemes;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public List<ListItem> GetSchemesForSelect()
    {
        List<ListItem> lst = new List<ListItem>();
        try
        {
            SqlParameter[] objParam = new SqlParameter[] { 
                new SqlParameter("@QueryType","SELECT_ALL_SCHEMES")
                };

            SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "SchemeMaster_DBLayer", objParam);
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
        catch (Exception ex)
        {
            throw ex;
        }
    }
   
    public int DeleteScheme(Int64 SchemeKey)
    {
        int intRowAffected = 0;
        try
        {
            SqlParameter[] objParam = new SqlParameter[] { 
                new SqlParameter("@SchemeKey",SchemeKey),
                new SqlParameter("@QueryType","DELETE")
                };

            object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "SchemeMaster_DBLayer", objParam);
            if (obj != null && obj != DBNull.Value)
                intRowAffected = Convert.ToInt32(obj);
            else
                intRowAffected = 0;
            return intRowAffected;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public int DeActiveScheme(SchemeMaster objSchemeMaster)
    {
        int intRowAffected = 0;
        try
        {
            SqlParameter[] objParam = new SqlParameter[] { 
                new SqlParameter("@SchemeKey",objSchemeMaster.SchemeKey),
                new SqlParameter("@LastModifiedBy",objSchemeMaster.LastModifiedBy),
                new SqlParameter("@QueryType","ACTIVE_DEACTIVE")
                };

            object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "SchemeMaster_DBLayer", objParam);
            if (obj != null && obj != DBNull.Value)
                intRowAffected = Convert.ToInt32(obj);
            else
                intRowAffected = 0;
            return intRowAffected;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public DataTable GetDocumentBySchemeKey(Int64 intSchemeKey)
    {
        DataTable dtShemes = new DataTable();
        try
        {
            SqlParameter[] objParam = new SqlParameter[] { 
                new SqlParameter("@QueryType","Get_Document_By_SchemeKey"),
                new SqlParameter("@SchemeKey",intSchemeKey)
            };

            SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "SchemeMaster_DBLayer", objParam);
            dtShemes.Load(dr);

            return dtShemes;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region Business Logic Using Procedure - Scheme Beneficiary Share

    public int UpdateSchemeShare(BeneficiaryMaster objBeneficiaryMaster, bool isUpdate)
    {
        int intRowAffected = 0;
        try
        {
            string xmlDoc = GlobalFunctions.ConvertToXMLFormat<BeneficiaryScheme>(ref objBeneficiaryMaster.BeneficiarySchemes);
            if (isUpdate == false)
            {
                SqlParameter[] objParam = new SqlParameter[] { 
                new SqlParameter("@EffectiveDate",GeneralClass.GetDateForDB((objBeneficiaryMaster.EffectiveDate))),
                new SqlParameter("@IsWomen",objBeneficiaryMaster.IsWomen),
                new SqlParameter("@Category",objBeneficiaryMaster.Category),
                new SqlParameter("@BShare",objBeneficiaryMaster.BShare),
                new SqlParameter("@CShare",objBeneficiaryMaster.CShare),
                new SqlParameter("@SShare",objBeneficiaryMaster.SShare),
                new SqlParameter("@IsActive",objBeneficiaryMaster.IsActive),
                new SqlParameter("@CreatedBy",objBeneficiaryMaster.CreatedBy),
                new SqlParameter("@SchemesXML",xmlDoc),
                new SqlParameter("@QueryType","INSERT")
                };
                object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "SchemeShare_DBLayer", objParam);
                if (obj != null && obj != DBNull.Value)
                    intRowAffected = Convert.ToInt32(obj);
                else
                    intRowAffected = 0;
            }
            else
            {
                SqlParameter[] objParam = new SqlParameter[] { 
                new SqlParameter("@MasterId",objBeneficiaryMaster.MasterId),
                new SqlParameter("@EffectiveDate",GeneralClass.GetDateForDB((objBeneficiaryMaster.EffectiveDate))),
                new SqlParameter("@IsWomen",objBeneficiaryMaster.IsWomen),
                new SqlParameter("@Category",objBeneficiaryMaster.Category),
                new SqlParameter("@BShare",objBeneficiaryMaster.BShare),
                new SqlParameter("@CShare",objBeneficiaryMaster.CShare),
                new SqlParameter("@SShare",objBeneficiaryMaster.SShare),
                new SqlParameter("@ModifiedBy",objBeneficiaryMaster.ModifiedBy),
                new SqlParameter("@SchemesXML",xmlDoc),
                new SqlParameter("@QueryType","UPDATE")
                };
                object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "SchemeShare_DBLayer", objParam);
                if (obj != null && obj != DBNull.Value)
                    intRowAffected = Convert.ToInt32(obj);
                else
                    intRowAffected = 0;
            }

            return intRowAffected;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public DataTable GetAllSchemeShare(Int64 intShareKey = 0)
    {
        DataTable dtShemes = new DataTable();
        try
        {
            if (intShareKey == 0)
            {
                SqlParameter[] objParam = new SqlParameter[] { 
                new SqlParameter("@QueryType","SELECT_ALL_DATA")
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "SchemeShare_DBLayer", objParam);
                dtShemes.Load(dr);
            }
            else
            {
                SqlParameter[] objParam = new SqlParameter[] { 
                    new SqlParameter("@MasterId",intShareKey),
                    new SqlParameter("@QueryType","SELECT_BY_ID")
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "SchemeShare_DBLayer", objParam);
                dtShemes.Load(dr);

            }
            return dtShemes;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public int DeleteSchemeShare(Int64 ShareKey)
    {
        int intRowAffected = 0;
        try
        {
            SqlParameter[] objParam = new SqlParameter[] { 
                new SqlParameter("@MasterId",ShareKey),
                new SqlParameter("@QueryType","DELETE")
                };

            object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "SchemeShare_DBLayer", objParam);
            if (obj != null && obj != DBNull.Value)
                intRowAffected = Convert.ToInt32(obj);
            else
                intRowAffected = 0;
            return intRowAffected;

        }
        catch (Exception ex)
        {
            return 0;
        }
    }

    public DataTable GetSchemeShareForApplicant(Int64 intShareKey, int Caste, bool IsWomen)
    {
        DataTable dtShemes = new DataTable();
        try
        {
            SqlParameter[] objParam = new SqlParameter[] { 
                    new SqlParameter("@QueryType","GetSchemeShareForApplicant"),
                    new SqlParameter("@SchemeKey",intShareKey),
                    new SqlParameter("@Category",Caste),
                    new SqlParameter("@IsWomen",IsWomen),
                };

            SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "SchemeShare_DBLayer", objParam);
            dtShemes.Load(dr);
            return dtShemes;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region Business Logic Using Procedure - RTI

    public int UpdateRTI(RTIMaster objRTIMaster)
    {
        int intRowAffected = 0;
        try
        {
            SqlParameter[] objParam = new SqlParameter[] { 
                new SqlParameter("@EffectiveDate",GeneralClass.GetDateForDB((objRTIMaster.EffectiveDate))),
                new SqlParameter("@Amount",objRTIMaster.Amount),
                new SqlParameter("@CreatedBy",objRTIMaster.CreatedBy),
                new SqlParameter("@QueryType","INSERT")
                };
            object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "RTI_DBLayer", objParam);
            if (obj != null && obj != DBNull.Value)
                intRowAffected = Convert.ToInt32(obj);
            else
                intRowAffected = 0;
            return intRowAffected;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public DataTable GetAllRTI(Int64 intMasterKey = 0)
    {
        DataTable dtShemes = new DataTable();
        try
        {
            if (intMasterKey == 0)
            {
                SqlParameter[] objParam = new SqlParameter[] { 
                new SqlParameter("@QueryType","SELECT_ALL_DATA")
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "RTI_DBLayer", objParam);
                dtShemes.Load(dr);
            }
            else
            {
                SqlParameter[] objParam = new SqlParameter[] { 
                    new SqlParameter("@MasterKey",intMasterKey),
                    new SqlParameter("@QueryType","SELECT_BY_ID")
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "RTI_DBLayer", objParam);
                dtShemes.Load(dr);

            }
            return dtShemes;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public int DeleteRTI(Int64 intMasterKey)
    {
        int intRowAffected = 0;
        try
        {
            SqlParameter[] objParam = new SqlParameter[] { 
                new SqlParameter("@MasterKey",intMasterKey),
                new SqlParameter("@QueryType","DELETE")
                };

            object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "RTI_DBLayer", objParam);
            if (obj != null && obj != DBNull.Value)
                intRowAffected = Convert.ToInt32(obj);
            else
                intRowAffected = 0;
            return intRowAffected;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region  Business Logic using Stored Procedure For - Complain Sourse Master

    public Boolean CreateComplainSourseMaster(ComplainSource objComplainSourse)
    {

        if (string.IsNullOrEmpty(objComplainSourse.ComplainSourceName))
            return false;

        SqlParameter[] paramList = new SqlParameter[4];
        paramList[0] = new SqlParameter("@QueryType", "INSERT");
        paramList[1] = new SqlParameter("@ComplainSourceName", objComplainSourse.ComplainSourceName);
        paramList[2] = new SqlParameter("@CreatedBy", objComplainSourse.CreatedBy);
        paramList[3] = new SqlParameter("@IsActive", objComplainSourse.IsActive);
        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "ComplainSource_DBLayer", paramList);
        if (obj == null)
            return false;
        return true;
    }

    public List<ComplainSource> ReadComplainSourseByKey(ComplainSource objComplainSourse)
    {
        List<ComplainSource> lstSection = new List<ComplainSource>();
        SqlDataReader sqlRdr = null;
        try
        {
            string sProcName = null;
            SqlParameter[] paramList;
            Byte Case;
            if (objComplainSourse.ComplainSourceName == null)
            {
                sProcName = "ComplainSource_DBLayer";
                paramList = new SqlParameter[2];
                paramList[0] = new SqlParameter("@QueryType", "SELECTbyPRIMARYKEY");
                paramList[1] = new SqlParameter("@ComplainSourcekey", objComplainSourse.ComplainSourceKey);
                Case = 1;
            }
            else
            {
                sProcName = "ComplainSource_DBLayer";
                paramList = new SqlParameter[2];
                paramList[0] = new SqlParameter("@QueryType", "SELECTbyUNIQUEKEY");
                paramList[1] = new SqlParameter("@ComplainSourceName", objComplainSourse.ComplainSourceName);
                Case = 2;
            }
            sqlRdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, sProcName, paramList);
            if (sqlRdr.Read())
            {
                ComplainSource obj = new ComplainSource();

                obj.ComplainSourceKey = Convert.ToInt16(sqlRdr["ComplainSourcekey"]);
                obj.ComplainSourceName = sqlRdr["ComplainSourceName"].ToString();
                obj.IsActive = Convert.ToBoolean(sqlRdr["IsActive"]);
                obj.CreatedBy = Convert.ToInt32(sqlRdr["CreatedBy"]);
                obj.CreatedOn = Convert.ToDateTime(sqlRdr["CreatedOn"]);
                obj.LastModifiedBy = Convert.ToInt32(sqlRdr["LastModifiedBy"]);
                obj.LastModifiedOn = Convert.ToDateTime(sqlRdr["LastModifiedOn"]);
                lstSection.Add(obj);
            }
            else
            {
                if (Case == 1)
                    throw new Exception("Invalid Record Key!");
            }
        }
        finally
        {
            if (sqlRdr != null)
                sqlRdr.Close();
        }
        return lstSection;
    }


    public List<ComplainSource> ReadAllComplainSourse(ComplainSource objComplainsourse)
    {

        List<ComplainSource> lstSection = new List<ComplainSource>();
        SqlDataReader sqlRdr = null;
        try
        {
            string sProcName = "ComplainSource_DBLayer";
            SqlParameter[] paramList;

            sProcName = "ComplainSource_DBLayer";
            paramList = new SqlParameter[1];
            paramList[0] = new SqlParameter("@QueryType", "READALL");

            sqlRdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, sProcName, paramList);
            while (sqlRdr.Read())
            {
                ComplainSource obj = new ComplainSource();



                obj.ComplainSourceKey = Convert.ToInt16(sqlRdr["ComplainSourcekey"]);
                obj.ComplainSourceName = sqlRdr["ComplainSourceName"].ToString();
                obj.IsActive = Convert.ToBoolean(sqlRdr["IsActive"]);
                obj.CreatedBy = Convert.ToInt32(sqlRdr["CreatedBy"]);
                obj.CreatedOn = Convert.ToDateTime(sqlRdr["CreatedOn"]);
                obj.LastModifiedBy = Convert.ToInt32(sqlRdr["LastModifiedBy"]);
                obj.LastModifiedOn = Convert.ToDateTime(sqlRdr["LastModifiedOn"]);

                lstSection.Add(obj);

            }
        }
        finally
        {
            if (sqlRdr != null)
                sqlRdr.Close();
        }
        return lstSection;
    }

    public string UpdateComplainSourse(ComplainSource objComplainSourse)
    {
        string msg = "";
        string sProcName = null;
        SqlParameter[] paramList;
        sProcName = "ComplainSource_DBLayer";
        paramList = new SqlParameter[2];
        paramList[0] = new SqlParameter("@QueryType", "CHECKforDUPLICATE");
        paramList[1] = new SqlParameter("@ComplainSourceName", objComplainSourse.ComplainSourceName);
        paramList[paramList.GetUpperBound(0)] = new SqlParameter("@ComplainSourcekey", objComplainSourse.ComplainSourceKey);
        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, sProcName, paramList);
        if (obj != null)
            msg = "Exist";
        paramList = new SqlParameter[4];
        paramList[0] = new SqlParameter("@QueryType", "UPDATE");
        paramList[1] = new SqlParameter("@ComplainSourcekey", objComplainSourse.ComplainSourceKey);
        paramList[2] = new SqlParameter("@ComplainSourceName", objComplainSourse.ComplainSourceName);
        paramList[3] = new SqlParameter("@LastModifiedBy", objComplainSourse.LastModifiedBy);
        object obj2 = SqlHelper.ExecuteNonQuery(Constr, CommandType.StoredProcedure, sProcName, paramList);
        if (obj2 == null)
            return msg = "";

        return msg;
    }

    public void DeleteComplainSourse(int id)
    {
        if (id == 0)
            return;
        string sProcName = "ComplainSource_DBLayer";
        SqlParameter[] paramList;
        paramList = new SqlParameter[2];
        paramList[0] = new SqlParameter("@QueryType", "DELETE");
        paramList[1] = new SqlParameter("@ComplainSourcekey", id);
        if (SqlHelper.ExecuteNonQuery(Constr, CommandType.StoredProcedure, sProcName, paramList) <= 0)
            throw new Exception("Record did not delete due to some error !!!");
    }
    public void ActiveDeactiveComplainSourse(ComplainSource objComplainSourse)
    {
        if (objComplainSourse == null)
            return;
        string sProcName = "ComplainSource_DBLayer";
        SqlParameter[] paramList;
        paramList = new SqlParameter[3];
        paramList[0] = new SqlParameter("@QueryType", "ActiveDeactive");
        paramList[1] = new SqlParameter("@ComplainSourcekey", objComplainSourse.ComplainSourceKey);
        paramList[2] = new SqlParameter("@LastModifiedBy", objComplainSourse.LastModifiedBy);
        if (SqlHelper.ExecuteNonQuery(Constr, CommandType.StoredProcedure, sProcName, paramList) <= 0)
            throw new Exception("Record did not updated due to some error !!!");
    }

    public DataTable GetAllComplainSourse()
    {
        DataTable dt = new DataTable();

        using (var con = new SqlConnection(Constr))
        {
            const string query = "select * from ComplainSource order by ComplainSourcekey";
            using (var cmd = new SqlCommand(query, con))
            {
                using (var sda = new SqlDataAdapter())
                {
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    using (dt)
                    {
                        dt.Clear();
                        sda.Fill(dt);
                    }
                }
            }
        }

        return dt;
    }

    public DataTable GetAllComplainSourseByKey(int ComplainSoursekey)
    {

        DataTable dt = new DataTable();

        using (var con = new SqlConnection(Constr))
        {
            string query = "select * from ComplainSource where ComplainSourcekey=" + ComplainSoursekey + "";
            using (var cmd = new SqlCommand(query, con))
            {
                using (var sda = new SqlDataAdapter())
                {
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    using (dt)
                    {
                        dt.Clear();
                        sda.Fill(dt);
                    }
                }
            }
        }

        return dt;
    }

    #endregion

    #region  Business Logic using Stored Procedure For - Complain Type Master

    public Boolean CreateComplainTypeMaster(ComplainTypeMaster objComplainTypeMaster)
    {

        if (string.IsNullOrEmpty(objComplainTypeMaster.ComplainName))
            return false;

        SqlParameter[] paramList = new SqlParameter[4];
        paramList[0] = new SqlParameter("@QueryType", "INSERT");
        paramList[1] = new SqlParameter("@ComplainName", objComplainTypeMaster.ComplainName);
        paramList[2] = new SqlParameter("@CreatedBy", objComplainTypeMaster.CreatedBy);
        paramList[3] = new SqlParameter("@IsActive", objComplainTypeMaster.IsActive);
        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "ComplainTypeMaster_DBLayer", paramList);
        if (obj == null)
            return false;
        return true;
    }

    public List<ComplainTypeMaster> ReadComplainTypeByKey(ComplainTypeMaster objComplainTypeMaster)
    {
        List<ComplainTypeMaster> lstSection = new List<ComplainTypeMaster>();
        SqlDataReader sqlRdr = null;
        try
        {
            string sProcName = null;
            SqlParameter[] paramList;
            Byte Case;
            if (objComplainTypeMaster.ComplainName == null)
            {
                sProcName = "ComplainTypeMaster_DBLayer";
                paramList = new SqlParameter[2];
                paramList[0] = new SqlParameter("@QueryType", "SELECTbyPRIMARYKEY");
                paramList[1] = new SqlParameter("@ComplainTypeKey", objComplainTypeMaster.ComplainTypeKey);
                Case = 1;
            }
            else
            {
                sProcName = "ComplainTypeMaster_DBLayer";
                paramList = new SqlParameter[2];
                paramList[0] = new SqlParameter("@QueryType", "SELECTbyUNIQUEKEY");
                paramList[1] = new SqlParameter("@ComplainName", objComplainTypeMaster.ComplainName);
                Case = 2;
            }
            sqlRdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, sProcName, paramList);
            if (sqlRdr.Read())
            {
                ComplainTypeMaster obj = new ComplainTypeMaster();

                obj.ComplainTypeKey = Convert.ToInt16(sqlRdr["ComplainTypeKey"]);
                obj.ComplainName = sqlRdr["ComplainName"].ToString();
                obj.IsActive = Convert.ToBoolean(sqlRdr["IsActive"]);
                obj.CreatedBy = Convert.ToInt32(sqlRdr["CreatedBy"]);
                obj.CreatedOn = Convert.ToDateTime(sqlRdr["CreatedOn"]);
                obj.LastModifiedBy = Convert.ToInt32(sqlRdr["LastModifiedBy"]);
                obj.LastModifiedOn = Convert.ToDateTime(sqlRdr["LastModifiedOn"]);
                lstSection.Add(obj);
            }
            else
            {
                if (Case == 1)
                    throw new Exception("Invalid Record Key!");
            }
        }
        finally
        {
            if (sqlRdr != null)
                sqlRdr.Close();
        }
        return lstSection;
    }


    public List<ComplainTypeMaster> ReadAllComplainType(ComplainTypeMaster objComplainTypeMaster)
    {

        List<ComplainTypeMaster> lstSection = new List<ComplainTypeMaster>();
        SqlDataReader sqlRdr = null;
        try
        {
            string sProcName = "ComplainTypeMaster_DBLayer";
            SqlParameter[] paramList;

            sProcName = "ComplainTypeMaster_DBLayer";
            paramList = new SqlParameter[1];
            paramList[0] = new SqlParameter("@QueryType", "READALL");

            sqlRdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, sProcName, paramList);
            while (sqlRdr.Read())
            {
                ComplainTypeMaster obj = new ComplainTypeMaster();



                obj.ComplainTypeKey = Convert.ToInt16(sqlRdr["ComplainTypeKey"]);
                obj.ComplainName = sqlRdr["ComplainName"].ToString();
                obj.IsActive = Convert.ToBoolean(sqlRdr["IsActive"]);
                obj.CreatedBy = Convert.ToInt32(sqlRdr["CreatedBy"]);
                obj.CreatedOn = Convert.ToDateTime(sqlRdr["CreatedOn"]);
                obj.LastModifiedBy = Convert.ToInt32(sqlRdr["LastModifiedBy"]);
                obj.LastModifiedOn = Convert.ToDateTime(sqlRdr["LastModifiedOn"]);

                lstSection.Add(obj);

            }
        }
        finally
        {
            if (sqlRdr != null)
                sqlRdr.Close();
        }
        return lstSection;
    }

    public string UpdateComplainSourse(ComplainTypeMaster objComplainTypeMaster)
    {
        string msg = "";
        string sProcName = null;
        SqlParameter[] paramList;
        sProcName = "ComplainTypeMaster_DBLayer";
        paramList = new SqlParameter[2];
        paramList[0] = new SqlParameter("@QueryType", "CHECKforDUPLICATE");
        paramList[1] = new SqlParameter("@ComplainName", objComplainTypeMaster.ComplainName);
        paramList[paramList.GetUpperBound(0)] = new SqlParameter("@ComplainTypeKey", objComplainTypeMaster.ComplainTypeKey);
        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, sProcName, paramList);
        if (obj != null)
            msg = "Exist";
        paramList = new SqlParameter[4];
        paramList[0] = new SqlParameter("@QueryType", "UPDATE");
        paramList[1] = new SqlParameter("@ComplainTypeKey", objComplainTypeMaster.ComplainTypeKey);
        paramList[2] = new SqlParameter("@ComplainName", objComplainTypeMaster.ComplainName);
        paramList[3] = new SqlParameter("@LastModifiedBy", objComplainTypeMaster.LastModifiedBy);
        object obj2 = SqlHelper.ExecuteNonQuery(Constr, CommandType.StoredProcedure, sProcName, paramList);
        if (obj2 == null)
            return msg = "";

        return msg;
    }

    public void DeleteComplainType(int id)
    {
        if (id == 0)
            return;
        string sProcName = "ComplainTypeMaster_DBLayer";
        SqlParameter[] paramList;
        paramList = new SqlParameter[2];
        paramList[0] = new SqlParameter("@QueryType", "DELETE");
        paramList[1] = new SqlParameter("@ComplainTypeKey", id);
        if (SqlHelper.ExecuteNonQuery(Constr, CommandType.StoredProcedure, sProcName, paramList) <= 0)
            throw new Exception("Record did not delete due to some error !!!");
    }
    public void ActiveDeactive(ComplainTypeMaster objComplainTypeMaster)
    {
        if (objComplainTypeMaster == null)
            return;
        string sProcName = "ComplainTypeMaster_DBLayer";
        SqlParameter[] paramList;
        paramList = new SqlParameter[3];
        paramList[0] = new SqlParameter("@QueryType", "ActiveDeactive");
        paramList[1] = new SqlParameter("@ComplainTypeKey", objComplainTypeMaster.ComplainTypeKey);
        paramList[2] = new SqlParameter("@LastModifiedBy", objComplainTypeMaster.LastModifiedBy);
        if (SqlHelper.ExecuteNonQuery(Constr, CommandType.StoredProcedure, sProcName, paramList) <= 0)
            throw new Exception("Record did not updated due to some error !!!");
    }

    public DataTable GetAllComplainType()
    {
        DataTable dt = new DataTable();

        using (var con = new SqlConnection(Constr))
        {
            const string query = "select * from ComplainTypeMaster order by ComplainTypekey";
            using (var cmd = new SqlCommand(query, con))
            {
                using (var sda = new SqlDataAdapter())
                {
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    using (dt)
                    {
                        dt.Clear();
                        sda.Fill(dt);
                    }
                }
            }
        }

        return dt;
    }

    public DataTable GetAllComplainTypeByKey(int ComplainSoursekey)
    {

        DataTable dt = new DataTable();

        using (var con = new SqlConnection(Constr))
        {
            string query = "select * from ComplainTypeMaster where ComplainTypekey=" + ComplainSoursekey + "";
            using (var cmd = new SqlCommand(query, con))
            {
                using (var sda = new SqlDataAdapter())
                {
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    using (dt)
                    {
                        dt.Clear();
                        sda.Fill(dt);
                    }
                }
            }
        }

        return dt;
    }

    #endregion

    #region  Business Logic using Stored Procedure For - Complain Sub Type

    public Boolean CreateComplainSubType(ComplainSubType objComplainSubType, bool UpdateFlag)
    {
        try
        {
            if (string.IsNullOrEmpty(objComplainSubType.SubTypeName) || objComplainSubType.ComplainTypeKey == 0 || objComplainSubType.DesignationKey == 0 || objComplainSubType.SectionKey == 0 || objComplainSubType.TimeFrame == 0)
                return false;
            if (!UpdateFlag)
            {
                SqlParameter[] paramList = new SqlParameter[]{
                    new SqlParameter("@QueryType", "INSERT"),
                    new SqlParameter("@ComplainTypeKey", objComplainSubType.ComplainTypeKey),
                    new SqlParameter("@SubTypeName", objComplainSubType.SubTypeName),
                    new SqlParameter("@DesignationKey", objComplainSubType.DesignationKey),
                    new SqlParameter("@SectionKey", objComplainSubType.SectionKey),
                    new SqlParameter("@TimeFrame", objComplainSubType.TimeFrame),
                    new SqlParameter("@IsActive", objComplainSubType.IsActive),
                    new SqlParameter("@CreatedBy", objComplainSubType.CreatedBy),
                };
                object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "ComplainSubType_DBLayer", paramList);
                if (obj == null)
                    return false;
                return true;
            }
            else
            {
                SqlParameter[] paramList = new SqlParameter[]{
                    new SqlParameter("@QueryType", "UPDATE"),
                    new SqlParameter("@SubTypeKey", objComplainSubType.SubTypeKey),
                    new SqlParameter("@ComplainTypeKey", objComplainSubType.ComplainTypeKey),
                    new SqlParameter("@SubTypeName", objComplainSubType.SubTypeName),
                    new SqlParameter("@DesignationKey", objComplainSubType.DesignationKey),
                    new SqlParameter("@SectionKey", objComplainSubType.SectionKey),
                    new SqlParameter("@TimeFrame", objComplainSubType.TimeFrame),
                    new SqlParameter("@IsActive", objComplainSubType.IsActive),
                    new SqlParameter("@LastModifiedBy", objComplainSubType.LastModifiedBy)
                };
                object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "ComplainSubType_DBLayer", paramList);
                if (obj == null)
                    return false;
                return true;
            }

        }
        catch (Exception ex)
        {
            return false;
        }


    }

    public DataTable GetAllComplainSubType(Int64 intSubTypeKey = 0)
    {
        DataTable dtShemes = new DataTable();
        try
        {
            if (intSubTypeKey == 0)
            {
                SqlParameter[] objParam = new SqlParameter[] { 
                new SqlParameter("@QueryType","SELECT_ALL_DATA")
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "ComplainSubType_DBLayer", objParam);
                dtShemes.Load(dr);
            }
            else
            {
                SqlParameter[] objParam = new SqlParameter[] { 
                    new SqlParameter("@SubTypeKey",intSubTypeKey),
                    new SqlParameter("@QueryType","SELECT_BY_ID")
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "ComplainSubType_DBLayer", objParam);
                dtShemes.Load(dr);

            }
            return dtShemes;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public int DeleteComplainSubType(Int64 intSubTypeKey)
    {
        int intRowAffected = 0;
        try
        {
            SqlParameter[] objParam = new SqlParameter[] { 
                new SqlParameter("@SubTypeKey",intSubTypeKey),
                new SqlParameter("@QueryType","DELETE")
                };

            object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "ComplainSubType_DBLayer", objParam);
            if (obj != null && obj != DBNull.Value)
                intRowAffected = Convert.ToInt32(obj);
            else
                intRowAffected = 0;
            return intRowAffected;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public int ActiveateDeActivateComplainSubType(ComplainSubType objComplainSubType)
    {
        int intRowAffected = 0;
        try
        {
            SqlParameter[] objParam = new SqlParameter[] { 
                new SqlParameter("@SubTypeKey",objComplainSubType.SubTypeKey),
                new SqlParameter("@LastModifiedBy",objComplainSubType.LastModifiedBy),
                new SqlParameter("@QueryType","ACTIVATE_DEACTIVATE")
                };

            object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "ComplainSubType_DBLayer", objParam);
            if (obj != null && obj != DBNull.Value)
                intRowAffected = Convert.ToInt32(obj);
            else
                intRowAffected = 0;
            return intRowAffected;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    #endregion

    #region Business Logic Using Procedure - Scheme Work Type

    public int UpdateSchemeWorkInstallment(SchemeWorkTypeMaster objSchemeWorkTypeMaster, bool isUpdate)
    {
        int intRowAffected = 0;
        try
        {
            string xmlDoc = GlobalFunctions.ConvertToXMLFormat<SchemeWorkTypeDetail>(ref objSchemeWorkTypeMaster.SchemeWorkTypeDetails);
            if (isUpdate == false)
            {
                SqlParameter[] objParam = new SqlParameter[] { 
                new SqlParameter("@EffectiveDate",GeneralClass.GetDateForDB((objSchemeWorkTypeMaster.EffectiveDate))),
                new SqlParameter("@SchemeKey",objSchemeWorkTypeMaster.SchemeKey),
                new SqlParameter("@WorkTypeKey",objSchemeWorkTypeMaster.WorkTypeKey),
                new SqlParameter("@InstPercent",objSchemeWorkTypeMaster.InstPercent),
                new SqlParameter("@InstNos",objSchemeWorkTypeMaster.InstNos),
                new SqlParameter("@IsActive",objSchemeWorkTypeMaster.IsActive),
                new SqlParameter("@CreatedBy",objSchemeWorkTypeMaster.CreatedBy),
                new SqlParameter("@DetailXML",xmlDoc),
                new SqlParameter("@QueryType","INSERT")
                };
                object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "DBT_SchemeWorkTypeMaster_DBLayer", objParam);
                if (obj != null && obj != DBNull.Value)
                    intRowAffected = Convert.ToInt32(obj);
                else
                    intRowAffected = 0;
            }
            else
            {
                SqlParameter[] objParam = new SqlParameter[] { 
                new SqlParameter("@SchemeWorkKey",objSchemeWorkTypeMaster.SchemeWorkKey),
                new SqlParameter("@EffectiveDate",GeneralClass.GetDateForDB((objSchemeWorkTypeMaster.EffectiveDate))),
                new SqlParameter("@SchemeKey",objSchemeWorkTypeMaster.SchemeKey),
                new SqlParameter("@WorkTypeKey",objSchemeWorkTypeMaster.WorkTypeKey),
                new SqlParameter("@InstPercent",objSchemeWorkTypeMaster.InstPercent),
                new SqlParameter("@InstNos",objSchemeWorkTypeMaster.InstNos),
                new SqlParameter("@IsActive",objSchemeWorkTypeMaster.IsActive),
                new SqlParameter("@LastModifiedBy",objSchemeWorkTypeMaster.CreatedBy),
                new SqlParameter("@DetailXML",xmlDoc),
                new SqlParameter("@QueryType","UPDATE")
                };
                object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "DBT_SchemeWorkTypeMaster_DBLayer", objParam);
                if (obj != null && obj != DBNull.Value)
                    intRowAffected = Convert.ToInt32(obj);
                else
                    intRowAffected = 0;
            }

            return intRowAffected;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public DataTable GetAllSchemeWork(Int64 intScheme = 0)
    {
        DataTable dtShemes = new DataTable();
        try
        {
            SqlParameter[] objParam = new SqlParameter[] { 
                    new SqlParameter("@SchemeKey",intScheme),
                    new SqlParameter("@QueryType","SELECT_BY_SchemeKey")
                };

            SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "DBT_SchemeWorkTypeMaster_DBLayer", objParam);
            dtShemes.Load(dr);

            return dtShemes;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public DataTable GetAllSchemeWorkInstallment(Int64 intSchemeWorkKey = 0)
    {
        DataTable dtShemes = new DataTable();
        try
        {
            if (intSchemeWorkKey == 0)
            {
                SqlParameter[] objParam = new SqlParameter[] { 
                new SqlParameter("@QueryType","SELECT_ALL_DATA")
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "DBT_SchemeWorkTypeMaster_DBLayer", objParam);
                dtShemes.Load(dr);
            }
            else
            {
                SqlParameter[] objParam = new SqlParameter[] { 
                    new SqlParameter("@SchemeWorkKey",intSchemeWorkKey),
                    new SqlParameter("@QueryType","SELECT_BY_ID")
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "DBT_SchemeWorkTypeMaster_DBLayer", objParam);
                dtShemes.Load(dr);

            }
            return dtShemes;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public int DeleteSchemeWorkInstallment(Int64 intSchemeWorkKey)
    {
        int intRowAffected = 0;
        try
        {
            SqlParameter[] objParam = new SqlParameter[] { 
                new SqlParameter("@SchemeWorkKey",intSchemeWorkKey),
                new SqlParameter("@QueryType","DELETE")
                };

            object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "DBT_SchemeWorkTypeMaster_DBLayer", objParam);
            if (obj != null && obj != DBNull.Value)
                intRowAffected = Convert.ToInt32(obj);
            else
                intRowAffected = 0;
            return intRowAffected;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public int DeActiveSchemeWorkInstallment(SchemeWorkTypeMaster objSchemeWorkTypeMaster)
    {
        int intRowAffected = 0;
        try
        {
            SqlParameter[] objParam = new SqlParameter[] { 
                new SqlParameter("@SchemeWorkKey",objSchemeWorkTypeMaster.SchemeWorkKey),
                new SqlParameter("@LastModifiedBy",objSchemeWorkTypeMaster.LastModifiedBy),
                new SqlParameter("@QueryType","ACTIVE_DEACTIVE")
                };

            object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "DBT_SchemeWorkTypeMaster_DBLayer", objParam);
            if (obj != null && obj != DBNull.Value)
                intRowAffected = Convert.ToInt32(obj);
            else
                intRowAffected = 0;
            return intRowAffected;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public List<ListItem> GetProgressType(int schemeid = 0)
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



    #endregion

    #region  Business Logic using Stored Procedure For - Object Master

    public Boolean CreateObjectMaster(ObjectMaster objMaster)
    {

        if ((string.IsNullOrEmpty(objMaster.ObjectEnglishName) && string.IsNullOrEmpty(objMaster.ObjectHindiName)) || (string.IsNullOrEmpty(objMaster.ObjectCode)))
            return false;

        SqlParameter[] paramList = new SqlParameter[]{
            new SqlParameter("@QueryType", "INSERT"),
            new SqlParameter("@ObjectCode", objMaster.ObjectCode),
            new SqlParameter("@ObjectEnglishName", objMaster.ObjectEnglishName),
            new SqlParameter("@ObjectHindiName", objMaster.ObjectHindiName),
            new SqlParameter("@CreatedBy", objMaster.CreatedBy),
            new SqlParameter("@IsActive", objMaster.IsActive)
        };
        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "ObjectMaster_DBLayer", paramList);
        if (obj == null)
            return false;
        return true;
    }

    public List<ObjectMaster> ReadObjectMasterByKey(ObjectMaster objMaster)
    {
        List<ObjectMaster> lstSection = new List<ObjectMaster>();
        SqlDataReader sqlRdr = null;
        try
        {
            string sProcName = null;
            SqlParameter[] paramList;
            Byte Case;
            if (objMaster.ObjectEnglishName == null)
            {
                sProcName = "ObjectMaster_DBLayer";
                paramList = new SqlParameter[2];
                paramList[0] = new SqlParameter("@QueryType", "SELECTbyPRIMARYKEY");
                paramList[1] = new SqlParameter("@ObjectKey", objMaster.ObjectKey);
                Case = 1;
            }
            else
            {
                sProcName = "ObjectMaster_DBLayer";
                paramList = new SqlParameter[2];
                paramList[0] = new SqlParameter("@QueryType", "SELECTbyUNIQUEKEY");
                paramList[1] = new SqlParameter("@ObjectEnglishName", objMaster.ObjectEnglishName);
                Case = 2;
            }
            sqlRdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, sProcName, paramList);
            if (sqlRdr.Read())
            {
                ObjectMaster obj = new ObjectMaster();

                obj.ObjectKey = Convert.ToInt16(sqlRdr["ObjectKey"]);
                obj.ObjectEnglishName = sqlRdr["ObjectEnglishName"].ToString();
                obj.ObjectHindiName = sqlRdr["ObjectHindiName"].ToString();
                obj.IsActive = Convert.ToBoolean(sqlRdr["IsActive"]);
                obj.CreatedBy = Convert.ToInt32(sqlRdr["CreatedBy"]);

                obj.LastModifiedBy = Convert.ToInt32(sqlRdr["LastModifiedBy"]);
                lstSection.Add(obj);
            }
            else
            {
                if (Case == 1)
                    throw new Exception("Invalid Record Key!");
            }
        }
        finally
        {
            if (sqlRdr != null)
                sqlRdr.Close();
        }
        return lstSection;
    }


    public List<ObjectMaster> ReadAllObjectMaster(ObjectMaster objMaster)
    {

        List<ObjectMaster> lstSection = new List<ObjectMaster>();
        SqlDataReader sqlRdr = null;
        try
        {
            string sProcName = "ObjectMaster_DBLayer";
            SqlParameter[] paramList;

            sProcName = "ObjectMaster_DBLayer";
            paramList = new SqlParameter[1];
            paramList[0] = new SqlParameter("@QueryType", "READALL");

            sqlRdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, sProcName, paramList);
            while (sqlRdr.Read())
            {
                ObjectMaster obj = new ObjectMaster();



                obj.ObjectKey = Convert.ToInt16(sqlRdr["Objectkey"]);
                obj.ObjectEnglishName = sqlRdr["ObjectHindiName"].ToString();
                obj.ObjectHindiName = sqlRdr["ObjectHindiName"].ToString();
                obj.IsActive = Convert.ToBoolean(sqlRdr["IsActive"]);
                obj.CreatedBy = Convert.ToInt32(sqlRdr["CreatedBy"]);
                obj.LastModifiedBy = Convert.ToInt32(sqlRdr["LastModifiedBy"]);

                lstSection.Add(obj);

            }
        }
        finally
        {
            if (sqlRdr != null)
                sqlRdr.Close();
        }
        return lstSection;
    }

    public string UpdateObjectMaster(ObjectMaster objMaster)
    {
        string msg = "";
        string sProcName = null;
        SqlParameter[] paramList;
        sProcName = "ObjectMaster_DBLayer";
        paramList = new SqlParameter[3];
        paramList[0] = new SqlParameter("@QueryType", "CHECKforDUPLICATE");
        paramList[1] = new SqlParameter("@ObjectHindiName", objMaster.ObjectHindiName);
        paramList[2] = new SqlParameter("@ObjectEnglishName", objMaster.ObjectEnglishName);
        paramList[paramList.GetUpperBound(0)] = new SqlParameter("@ObjectKey", objMaster.ObjectKey);
        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, sProcName, paramList);
        if (obj != null)
            msg = "Exist";
        paramList = new SqlParameter[5];
        paramList[0] = new SqlParameter("@QueryType", "UPDATE");
        paramList[1] = new SqlParameter("@ObjectHindiName", objMaster.ObjectHindiName);
        paramList[2] = new SqlParameter("@ObjectEnglishName", objMaster.ObjectEnglishName);
        paramList[3] = new SqlParameter("@LastModifiedBy", objMaster.LastModifiedBy);
        paramList[4] = new SqlParameter("@ObjectCode", objMaster.ObjectCode);
        object obj2 = SqlHelper.ExecuteNonQuery(Constr, CommandType.StoredProcedure, sProcName, paramList);
        if (obj2 == null)
            return msg = "";

        return msg;
    }

    public void DeleteObjectMaster(int id)
    {
        if (id == 0)
            return;
        string sProcName = "ObjectMaster_DBLayer";
        SqlParameter[] paramList;
        paramList = new SqlParameter[2];
        paramList[0] = new SqlParameter("@QueryType", "DELETE");
        paramList[1] = new SqlParameter("@Objectkey", id);
        if (SqlHelper.ExecuteNonQuery(Constr, CommandType.StoredProcedure, sProcName, paramList) <= 0)
            throw new Exception("Record did not delete due to some error !!!");
    }

    public void ActiveDeactiveObjectMaster(ObjectMaster objMaster)
    {
        if (objMaster == null)
            return;
        string sProcName = "ObjectMaster_DBLayer";
        SqlParameter[] paramList;
        paramList = new SqlParameter[3];
        paramList[0] = new SqlParameter("@QueryType", "ActiveDeactive");
        paramList[1] = new SqlParameter("@ObjectKey", objMaster.ObjectKey);
        paramList[2] = new SqlParameter("@LastModifiedBy", objMaster.LastModifiedBy);
        if (SqlHelper.ExecuteNonQuery(Constr, CommandType.StoredProcedure, sProcName, paramList) <= 0)
            throw new Exception("Record did not updated due to some error !!!");
    }

    public DataTable GetAllObjectMaster()
    {
        DataTable dt = new DataTable();

        using (var con = new SqlConnection(Constr))
        {
            const string query = "select * from ObjectMaster order by Objectkey";
            using (var cmd = new SqlCommand(query, con))
            {
                using (var sda = new SqlDataAdapter())
                {
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    using (dt)
                    {
                        dt.Clear();
                        sda.Fill(dt);
                    }
                }
            }
        }

        return dt;
    }

    public DataTable GetAllObjectMasterByKey(int Objectkey)
    {

        DataTable dt = new DataTable();

        using (var con = new SqlConnection(Constr))
        {
            string query = "select * from ObjectMaster where ObjectKey=" + Objectkey + "";
            using (var cmd = new SqlCommand(query, con))
            {
                using (var sda = new SqlDataAdapter())
                {
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    using (dt)
                    {
                        dt.Clear();
                        sda.Fill(dt);
                    }
                }
            }
        }

        return dt;
    }

    public List<ListItem> PopulateObjectMaster(bool isHindi = false)
    {
        List<ListItem> lst = new List<ListItem>();
        try
        {
            if (isHindi)
            {
                SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, "Select ObjectKey,'['+ ObjectCode +'] - ' + ObjectHindiName  As ObjectHindiName From ObjectMaster Where Isnull(IsActive,1) = 1  Order BY ObjectHindiName");
                using (sdr)
                {
                    while (sdr.Read())
                    {
                        lst.Add(new ListItem
                        {
                            Value = sdr["ObjectKey"].ToString(),
                            Text = sdr["ObjectHindiName"].ToString()
                        });
                    }
                }
            }
            else
            {
                SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, "Select ObjectKey,'['+ ObjectCode +'] - ' + ObjectEnglishName  As ObjectEnglishName From ObjectMaster Where Isnull(IsActive,1) = 1  Order BY ObjectEnglishName");
                using (sdr)
                {
                    while (sdr.Read())
                    {
                        lst.Add(new ListItem
                        {
                            Value = sdr["ObjectKey"].ToString(),
                            Text = sdr["ObjectEnglishName"].ToString()
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

    #endregion

    #region  Business Logic using Stored Procedure For - Financial Year Master

    public Boolean CreateFinYearMaster(FinYearMaster objFinYearMaster)
    {

        if (string.IsNullOrEmpty(objFinYearMaster.FinYear))
            return false;

        SqlParameter[] paramList = new SqlParameter[4];
        paramList[0] = new SqlParameter("@QueryType", "INSERT");
        paramList[1] = new SqlParameter("@FinYear", objFinYearMaster.FinYear);
        paramList[2] = new SqlParameter("@CreatedBy", objFinYearMaster.CreatedBy);
        paramList[3] = new SqlParameter("@IsActive", objFinYearMaster.IsActive);
        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "FinYearMaster_DBLayer", paramList);
        if (obj == null)
            return false;
        return true;
    }

    public List<FinYearMaster> ReadFinYearByKey(FinYearMaster objFinYearMaster)
    {
        List<FinYearMaster> lstSection = new List<FinYearMaster>();
        SqlDataReader sqlRdr = null;
        try
        {
            string sProcName = null;
            SqlParameter[] paramList;
            Byte Case;
            if (objFinYearMaster.FinYear == null)
            {
                sProcName = "FinYearMaster_DBLayer";
                paramList = new SqlParameter[2];
                paramList[0] = new SqlParameter("@QueryType", "SELECTbyPRIMARYKEY");
                paramList[1] = new SqlParameter("@FinYearKey", objFinYearMaster.FinYearKey);
                Case = 1;
            }
            else
            {
                sProcName = "FinYearMaster_DBLayer";
                paramList = new SqlParameter[2];
                paramList[0] = new SqlParameter("@QueryType", "SELECTbyUNIQUEKEY");
                paramList[1] = new SqlParameter("@FinYear", objFinYearMaster.FinYear);
                Case = 2;
            }
            sqlRdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, sProcName, paramList);
            if (sqlRdr.Read())
            {
                FinYearMaster obj = new FinYearMaster();

                obj.FinYearKey = Convert.ToInt16(sqlRdr["FinYearKey"]);
                obj.FinYear = sqlRdr["FinYear"].ToString();
                obj.IsActive = Convert.ToBoolean(sqlRdr["IsActive"]);
                obj.CreatedOn = Convert.ToDateTime(sqlRdr["CreatedOn"]);
                obj.LastModifiedOn = Convert.ToDateTime(sqlRdr["LastModifiedOn"]);
                lstSection.Add(obj);
            }
            else
            {
                if (Case == 1)
                    throw new Exception("Invalid Record Key!");
            }
        }
        finally
        {
            if (sqlRdr != null)
                sqlRdr.Close();
        }
        return lstSection;
    }

    public List<FinYearMaster> ReadAllFinYear(FinYearMaster objFinYearMaster)
    {

        List<FinYearMaster> lstSection = new List<FinYearMaster>();
        SqlDataReader sqlRdr = null;
        try
        {
            string sProcName = "FinYearMaster_DBLayer";
            SqlParameter[] paramList;

            sProcName = "FinYearMaster_DBLayer";
            paramList = new SqlParameter[1];
            paramList[0] = new SqlParameter("@QueryType", "READALL");

            sqlRdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, sProcName, paramList);
            while (sqlRdr.Read())
            {
                FinYearMaster obj = new FinYearMaster();

                obj.FinYearKey = Convert.ToInt16(sqlRdr["FinYearKey"]);
                obj.FinYear = sqlRdr["FinYear"].ToString();
                obj.IsActive = Convert.ToBoolean(sqlRdr["IsActive"]);
                obj.CreatedOn = Convert.ToDateTime(sqlRdr["CreatedOn"]);
                obj.LastModifiedOn = Convert.ToDateTime(sqlRdr["LastModifiedOn"]);

                lstSection.Add(obj);

            }
        }
        finally
        {
            if (sqlRdr != null)
                sqlRdr.Close();
        }
        return lstSection;
    }

    public string UpdateFinYear(FinYearMaster objFinYearMaster)
    {
        string msg = "";
        string sProcName = null;
        SqlParameter[] paramList;
        sProcName = "FinYearMaster_DBLayer";
        paramList = new SqlParameter[2];
        paramList[0] = new SqlParameter("@QueryType", "CHECKforDUPLICATE");
        paramList[1] = new SqlParameter("@FinYear", objFinYearMaster.FinYear);
        paramList[paramList.GetUpperBound(0)] = new SqlParameter("@FinYearKey", objFinYearMaster.FinYearKey);
        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, sProcName, paramList);
        if (obj != null)
            msg = "Exist";
        paramList = new SqlParameter[4];
        paramList[0] = new SqlParameter("@QueryType", "UPDATE");
        paramList[1] = new SqlParameter("@FinYearKey", objFinYearMaster.FinYearKey);
        paramList[2] = new SqlParameter("@FinYear", objFinYearMaster.FinYear);
        paramList[3] = new SqlParameter("@LastModifiedBy", objFinYearMaster.LastModifiedBy);
        object obj2 = SqlHelper.ExecuteNonQuery(Constr, CommandType.StoredProcedure, sProcName, paramList);
        if (obj2 == null)
            return msg = "";

        return msg;
    }

    public void DeleteFinYear(int id)
    {
        if (id == 0)
            return;
        string sProcName = "FinYearMaster_DBLayer";
        SqlParameter[] paramList;
        paramList = new SqlParameter[2];
        paramList[0] = new SqlParameter("@QueryType", "DELETE");
        paramList[1] = new SqlParameter("@FinYearKey", id);
        if (SqlHelper.ExecuteNonQuery(Constr, CommandType.StoredProcedure, sProcName, paramList) <= 0)
            throw new Exception("Record did not delete due to some error !!!");
    }

    public void DeActiveFinYear(FinYearMaster objFinYearMaster)
    {
        if (objFinYearMaster.FinYearKey == 0)
            return;
        string sProcName = "FinYearMaster_DBLayer";
        SqlParameter[] paramList;
        paramList = new SqlParameter[3];
        paramList[0] = new SqlParameter("@QueryType", "ActiveDeactive");
        paramList[1] = new SqlParameter("@FinYearKey", objFinYearMaster.FinYearKey);
        paramList[2] = new SqlParameter("@LastModifiedBy", objFinYearMaster.LastModifiedBy);
        if (SqlHelper.ExecuteNonQuery(Constr, CommandType.StoredProcedure, sProcName, paramList) <= 0)
            throw new Exception("Record did not update due to some error !!!");
    }

    public DataTable GetAllFinYear()
    {
        DataTable dt = new DataTable();

        using (var con = new SqlConnection(Constr))
        {
            const string query = "select * from FinYearMaster order by FinYearKey";
            using (var cmd = new SqlCommand(query, con))
            {
                using (var sda = new SqlDataAdapter())
                {
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    using (dt)
                    {
                        dt.Clear();
                        sda.Fill(dt);
                    }
                }
            }
        }

        return dt;
    }

    public DataTable GetAllFinYearKey(int ComplainSoursekey)
    {

        DataTable dt = new DataTable();

        using (var con = new SqlConnection(Constr))
        {
            string query = "select * from FinYearMaster Where FinYearKey=" + ComplainSoursekey + "";
            using (var cmd = new SqlCommand(query, con))
            {
                using (var sda = new SqlDataAdapter())
                {
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    using (dt)
                    {
                        dt.Clear();
                        sda.Fill(dt);
                    }
                }
            }
        }

        return dt;
    }

    public List<ListItem> PopulateFinancialYear()
    {
        List<ListItem> lst = new List<ListItem>();
        try
        {
            SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, "Select FinYear From FinYearMaster Where Isnull(IsActive,1) = 1  Order BY FinYear");
            using (sdr)
            {
                while (sdr.Read())
                {
                    lst.Add(new ListItem
                    {
                        Value = sdr["FinYear"].ToString(),
                        Text = sdr["FinYear"].ToString()
                    });
                }
            }
            return lst;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public List<ListItem> PopulateMonthName()
    {
        try
        {
            List<ListItem> lstMonth = new List<ListItem>();

            for (int i = 1; i <= 12; i++)
            {
                ListItem month = new ListItem();
                month.Value = i.ToString();
                month.Text = System.Globalization.DateTimeFormatInfo.CurrentInfo.GetMonthName(i);
                lstMonth.Add(month);
            }

            return lstMonth;
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    #endregion

    #region  Business Logic using Stored Procedure For - Budget Dept Booking

    public Boolean CreateBudgetDeptBooking(Bud_DeptBooking objBud_DeptBooking, bool isUpdate = true)
    {
        try
        {
            if (string.IsNullOrEmpty(objBud_DeptBooking.FinancialYear) || string.IsNullOrEmpty(objBud_DeptBooking.GONo) || string.IsNullOrEmpty(objBud_DeptBooking.RefNo)

               || (objBud_DeptBooking.AccountType == 0) || (objBud_DeptBooking.BankKey == 0) || (objBud_DeptBooking.BudgetType == 0)
               || (objBud_DeptBooking.ObjectKey == 0) || (objBud_DeptBooking.PaymentType == 0)
               || (objBud_DeptBooking.SourceKey == 0) || (objBud_DeptBooking.BAmount == 0)
           )
                return false;
            object obj = null;
            if (!isUpdate)
            {
                SqlParameter[] paramList = new SqlParameter[]{
                new SqlParameter("@QueryType", "INSERT"),
                new SqlParameter("@AccountType",objBud_DeptBooking.AccountType),
                new SqlParameter("@BAmount",objBud_DeptBooking.BAmount),
                new SqlParameter("@BankKey",objBud_DeptBooking.BankKey),
                new SqlParameter("@BudgetType",objBud_DeptBooking.BudgetType),
                new SqlParameter("@CreatedBy",objBud_DeptBooking.CreatedBy),
                new SqlParameter("@FinancialYear",objBud_DeptBooking.FinancialYear),
                new SqlParameter("@GONo",objBud_DeptBooking.GONo),
                new SqlParameter("@GODate",GeneralClass.GetDateForDB(objBud_DeptBooking.GODate)),
                new SqlParameter("@GrandCode",objBud_DeptBooking.GrandCode),
                new SqlParameter("@HeadNameKey",objBud_DeptBooking.HeadNameKey),
                new SqlParameter("@ObjectKey",objBud_DeptBooking.ObjectKey),
                new SqlParameter("@PaymentType",objBud_DeptBooking.PaymentType),
                new SqlParameter("@RefDate",GeneralClass.GetDateForDB(objBud_DeptBooking.RefDate)),
                new SqlParameter("@RefNo",objBud_DeptBooking.RefNo),
                new SqlParameter("@Remark",objBud_DeptBooking.Remark),
                new SqlParameter("@SchemeKey",objBud_DeptBooking.SchemeKey),
                new SqlParameter("@SourceKey",objBud_DeptBooking.SourceKey)
            };

                obj = SqlHelper.ExecuteNonQuery(Constr, CommandType.StoredProcedure, "Bud_DeptBooking_DBLayer", paramList);
            }
            else
            {
                SqlParameter[] paramList = new SqlParameter[]{
                new SqlParameter("@QueryType", "UPDATE"),
                new SqlParameter("@AccountType",objBud_DeptBooking.AccountType),
                new SqlParameter("@BAmount",objBud_DeptBooking.BAmount),
                new SqlParameter("@BankKey",objBud_DeptBooking.BankKey),
                new SqlParameter("@BudgetType",objBud_DeptBooking.BudgetType),
                new SqlParameter("@CreatedBy",objBud_DeptBooking.CreatedBy),
                new SqlParameter("@FinancialYear",objBud_DeptBooking.FinancialYear),
                new SqlParameter("@GONo",objBud_DeptBooking.GONo),
                new SqlParameter("@GODate",GeneralClass.GetDateForDB(objBud_DeptBooking.GODate)),
                new SqlParameter("@GrandCode",objBud_DeptBooking.GrandCode),
                new SqlParameter("@HeadNameKey",objBud_DeptBooking.HeadNameKey),
                new SqlParameter("@ObjectKey",objBud_DeptBooking.ObjectKey),
                new SqlParameter("@PaymentType",objBud_DeptBooking.PaymentType),
                new SqlParameter("@RefDate",GeneralClass.GetDateForDB(objBud_DeptBooking.RefDate)),
                new SqlParameter("@RefNo",objBud_DeptBooking.RefNo),
                new SqlParameter("@Remark",objBud_DeptBooking.Remark),
                new SqlParameter("@SchemeKey",objBud_DeptBooking.SchemeKey),
                new SqlParameter("@SourceKey",objBud_DeptBooking.SourceKey)
            };
                obj = SqlHelper.ExecuteNonQuery(Constr, CommandType.StoredProcedure, "Bud_DeptBooking_DBLayer", paramList);
            }

            if (obj == null)
                return false;
            return true;
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    public void DeleteBud_DeptBooking(Int64 id)
    {
        if (id == 0)
            return;
        string sProcName = "Bud_DeptBooking_DBLayer";
        SqlParameter[] paramList;
        paramList = new SqlParameter[2];
        paramList[0] = new SqlParameter("@QueryType", "DELETE");
        paramList[1] = new SqlParameter("@BookingKey", id);
        if (SqlHelper.ExecuteNonQuery(Constr, CommandType.StoredProcedure, sProcName, paramList) <= 0)
            throw new Exception("Record did not delete due to some error !!!");
    }

    public DataTable GetAllBud_DeptBooking(Int64 intBookingKey = 0)
    {
        DataTable dtShemes = new DataTable();
        try
        {
            if (intBookingKey == 0)
            {
                SqlParameter[] objParam = new SqlParameter[] { 
                new SqlParameter("@QueryType","SELECT_ALL_DATA")
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "Bud_DeptBooking_DBLayer", objParam);
                dtShemes.Load(dr);
            }
            else
            {
                SqlParameter[] objParam = new SqlParameter[] { 
                    new SqlParameter("@BookingKey",intBookingKey),
                    new SqlParameter("@QueryType","SELECT_BY_ID")
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "Bud_DeptBooking_DBLayer", objParam);
                dtShemes.Load(dr);

            }
            return dtShemes;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    #endregion

    #region Business Logic Using Procedure - Role

    public int UpdateRole(RoleMaster objRoleMaster, bool UpdateFlag)
    {
        int intRowAffected = 0;
        try
        {
            object obj = null;
            if (!UpdateFlag)
            {
                SqlParameter[] objParam = new SqlParameter[] { 
                new SqlParameter("@RoleName",objRoleMaster.RoleName),
                new SqlParameter("@IsActive",objRoleMaster.IsActive),
                new SqlParameter("@CreatedBy",objRoleMaster.CreatedBy),
                new SqlParameter("@QueryType","INSERT")
                };
                obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "Role_DBLayer", objParam);
            }
            else
            {
                SqlParameter[] objParam = new SqlParameter[] { 
                    
                new SqlParameter("@ID",objRoleMaster.ID),
                new SqlParameter("@IsActive",objRoleMaster.IsActive),
                new SqlParameter("@QueryType","UPDATE")
                };
                obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "Role_DBLayer", objParam);
            }

            if (obj != null && obj != DBNull.Value)
                intRowAffected = Convert.ToInt32(obj);
            else
                intRowAffected = 0;
            return intRowAffected;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public DataTable GetAllRole(Int64 intRoleKey = 0)
    {
        DataTable dtShemes = new DataTable();
        try
        {
            if (intRoleKey == 0)
            {
                SqlParameter[] objParam = new SqlParameter[] { 
                new SqlParameter("@QueryType","SELECT_ALL_DATA")
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "Role_DBLayer", objParam);
                dtShemes.Load(dr);
            }
            else
            {
                SqlParameter[] objParam = new SqlParameter[] { 
                    new SqlParameter("@ID",intRoleKey),
                    new SqlParameter("@QueryType","SELECT_BY_ID")
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "Role_DBLayer", objParam);
                dtShemes.Load(dr);

            }
            return dtShemes;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public int DeleteRole(Int64 intID)
    {
        int intRowAffected = 0;
        try
        {
            SqlParameter[] objParam = new SqlParameter[] { 
                new SqlParameter("@ID",intID),
                new SqlParameter("@QueryType","DELETE")
                };

            object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "ROLE_DBLayer", objParam);
            if (obj != null && obj != DBNull.Value)
                intRowAffected = Convert.ToInt32(obj);
            else
                intRowAffected = 0;
            return intRowAffected;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public int ActivateRole(Int64 intID)
    {
        int intRowAffected = 0;
        try
        {
            SqlParameter[] objParam = new SqlParameter[] { 
                new SqlParameter("@ID",intID),
                new SqlParameter("@QueryType","ACTIVATE")
                };

            object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "ROLE_DBLayer", objParam);
            if (obj != null && obj != DBNull.Value)
                intRowAffected = Convert.ToInt32(obj);
            else
                intRowAffected = 0;
            return intRowAffected;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region Business Logic using Stored Procedure For - DepartmentRegistration

    public Int32 UpdateDeptUser(UserMaster objUserMaster, bool UpdateFlag)
    {
        try
        {
            if (objUserMaster.UserType == 0 || String.IsNullOrEmpty(objUserMaster.Name) || String.IsNullOrEmpty(objUserMaster.Gender))
                return 0;
            object obj = null;
            if (!UpdateFlag)
            {
                SqlParameter[] paramList = new SqlParameter[11];


                paramList[0] = new SqlParameter("@QueryType", "INSERT");
                paramList[1] = new SqlParameter("@UserType", objUserMaster.UserType);

                paramList[2] = new SqlParameter("@Name", objUserMaster.Name);
                paramList[3] = new SqlParameter("@Gender", objUserMaster.Gender);
                paramList[4] = new SqlParameter("@UserName", objUserMaster.UserName);
                paramList[5] = new SqlParameter("@Password", objUserMaster.Password);
                paramList[6] = new SqlParameter("@DistrictKey", objUserMaster.DistrictKey);
                paramList[7] = new SqlParameter("@MobileNo", objUserMaster.MobileNo);

                paramList[8] = new SqlParameter("@EmailID", objUserMaster.EmailID);
                paramList[9] = new SqlParameter("@IsActive", objUserMaster.IsActive);
                paramList[10] = new SqlParameter("@CreatedBy", objUserMaster.CreatedBy);
                obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "User_Master_DBLayer", paramList);
            }
            else
            {
                SqlParameter[] paramList = new SqlParameter[11];


                paramList[0] = new SqlParameter("@QueryType", "UPDATE");
                paramList[1] = new SqlParameter("@UserType", objUserMaster.UserType);
                paramList[2] = new SqlParameter("@Name", objUserMaster.Name);
                paramList[3] = new SqlParameter("@Gender", objUserMaster.Gender);
                paramList[4] = new SqlParameter("@UserName", objUserMaster.UserName);
                paramList[5] = new SqlParameter("@Password", objUserMaster.Password);
                paramList[6] = new SqlParameter("@DistrictKey", objUserMaster.DistrictKey);
                paramList[7] = new SqlParameter("@MobileNo", objUserMaster.MobileNo);
                paramList[8] = new SqlParameter("@EmailID", objUserMaster.EmailID);
                paramList[9] = new SqlParameter("@UserKey", objUserMaster.UserKey);
                paramList[10] = new SqlParameter("@LastModifiedBy", objUserMaster.LastModifiedBy);

                obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "User_Master_DBLayer", paramList);
            }


            if (obj == null)
                return 0;
            return Convert.ToInt32(obj);
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    public DataTable GetDeptUserForSU(Int64 intUserKey = 0)
    {
        DataTable dtShemes = new DataTable();
        try
        {
            if (intUserKey == 0)
            {
                SqlParameter[] objParam = new SqlParameter[] { 
                new SqlParameter("@QueryType","SELECT_ALL_DATA_FOR_SU")
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "User_Master_DBLayer", objParam);
                dtShemes.Load(dr);
            }
            else
            {
                SqlParameter[] objParam = new SqlParameter[] { 
                    new SqlParameter("@UserKey",intUserKey),
                    new SqlParameter("@QueryType","SELECT_DATA_FOR_SU_ID")
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "User_Master_DBLayer", objParam);
                dtShemes.Load(dr);

            }
            return dtShemes;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public int DeleteUser(Int64 intUserId)
    {
        int intRowAffected = 0;
        try
        {
            SqlParameter[] objParam = new SqlParameter[] { 
                new SqlParameter("@UserKey",intUserId),
                new SqlParameter("@QueryType","DELETE")
                };

            object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "User_Master_DBLayer", objParam);
            if (obj != null && obj != DBNull.Value)
                intRowAffected = Convert.ToInt32(obj);
            else
                intRowAffected = 0;
            return intRowAffected;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    public List<ListItem> PopulateBudgetHead(bool isHindi = false)
    {
        List<ListItem> lst = new List<ListItem>();
        try
        {
            if (isHindi)
            {
                SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, "Select HeadKey,'['+ HeadCode +'] - ' + HeadHindiName  As HeadHindiName From Bud_HeadMaster Where Isnull(IsActive,1) = 1  Order BY HeadHindiName");
                using (sdr)
                {
                    while (sdr.Read())
                    {
                        lst.Add(new ListItem
                        {
                            Value = sdr["HeadKey"].ToString(),
                            Text = sdr["HeadHindiName"].ToString()
                        });
                    }
                }
            }
            else
            {
                SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, "Select HeadKey,'['+ HeadCode +'] - ' + HeadEnglishName  As HeadEnglishName From Bud_HeadMaster Where Isnull(IsActive,1) = 1 Order BY HeadEnglishName");
                using (sdr)
                {
                    while (sdr.Read())
                    {
                        lst.Add(new ListItem
                        {
                            Value = sdr["HeadKey"].ToString(),
                            Text = sdr["HeadEnglishName"].ToString()
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

    public List<ListItem> GetAllSchemeType()
    {
        List<ListItem> lst = new List<ListItem>();
        try
        {
            string str = "SELECT SchemeTypekey, SchemeTypeHindi FROM [dbo].[SchemeType_Master] where IsActive=1";

            SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, str);

            using (sdr)
            {
                while (sdr.Read())
                {
                    lst.Add(new ListItem
                    {
                        Value = sdr["SchemeTypekey"].ToString(),
                        Text = sdr["SchemeTypeHindi"].ToString()
                    });
                }
            }

            return lst;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public List<ListItem> GetSchemesForSelect(int schemetypekey)
    {
        List<ListItem> lst = new List<ListItem>();
        try
        {
            string str = "SELECT SchemeName, SchemeKey from SchemeMaster where SchemeTypeKey=" + schemetypekey + " AND IsActive=1";

            SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, str);

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
        catch (Exception ex)
        {
            throw ex;
        }
    }

    

}