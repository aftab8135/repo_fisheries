using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using DBLibrary;
using FisheriesMIS.App_Code;


/// <summary>
/// Summary description for ApplicantDetails_DBLayer
/// </summary>
public partial class DBLayer
{
    #region "Applicant Panel - New Code"

    #region "Applicant Registration"
    public Int64 CreateApplicantDetails(ApplicantDetail objApplicantDetail)
    {
        try
        {
            SqlParameter[] paramList = new SqlParameter[]{
                new SqlParameter("@QueryType", "INSERT"),
                new SqlParameter("@RegistrationKey", objApplicantDetail.RegistrationKey),
                new SqlParameter("@CareOf", objApplicantDetail.CareOf),
                new SqlParameter("@FatherName", objApplicantDetail.FatherName),
                new SqlParameter("@DOB", GeneralClass.GetDateForDB(objApplicantDetail.DOB)),
                new SqlParameter("@Gender", objApplicantDetail.Gender),
                new SqlParameter("@Caste", objApplicantDetail.Caste),
                new SqlParameter("@RevenueVillage", objApplicantDetail.RevenueVillage),
                new SqlParameter("@PostOffice", objApplicantDetail.PostOffice),
                new SqlParameter("@PinNo", objApplicantDetail.PinNo),
                new SqlParameter("@DistrictNo", objApplicantDetail.DistrictNo),
                new SqlParameter("@BlockNo", objApplicantDetail.BlockNo),
                new SqlParameter("@TehsilNo", objApplicantDetail.TehsilNo),
                new SqlParameter("@PostallAddress", objApplicantDetail.PostallAddress),
                new SqlParameter("@EmailID", objApplicantDetail.EmailID),
                new SqlParameter("@UserBankName", objApplicantDetail.UserBankName),
                new SqlParameter("@UserBankShakha", objApplicantDetail.UserBankShakha),
                new SqlParameter("@UserBankIFSC", objApplicantDetail.UserBankIFSC),
                new SqlParameter("@UserAcNo", objApplicantDetail.UserAcNo),
                new SqlParameter("@Phone_no", objApplicantDetail.Phone_no),
                new SqlParameter("@MobileNo", objApplicantDetail.MobileNo),
                new SqlParameter("@TehsilName", objApplicantDetail.TehsilName)
            };
            object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "ApplicantProfile_DBLayer", paramList);
            if (obj == null)
                return 0;
            return Convert.ToInt64(obj);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public Int64 UpdateApplicantDetails(ApplicantDetail objApplicantDetail)
    {
        try
        {
            SqlParameter[] paramList = new SqlParameter[]{
                new SqlParameter("@QueryType", "Update"),
                new SqlParameter("@RegistrationKey", objApplicantDetail.RegistrationKey),
                new SqlParameter("@CareOf", objApplicantDetail.CareOf),
                new SqlParameter("@FatherName", objApplicantDetail.FatherName),
                new SqlParameter("@DOB", GeneralClass.GetDateForDB(objApplicantDetail.DOB)),
                new SqlParameter("@Gender", objApplicantDetail.Gender),
                new SqlParameter("@Caste", objApplicantDetail.Caste),
                new SqlParameter("@RevenueVillage", objApplicantDetail.RevenueVillage),
                new SqlParameter("@PostOffice", objApplicantDetail.PostOffice),
                new SqlParameter("@PinNo", objApplicantDetail.PinNo),
                new SqlParameter("@DistrictNo", objApplicantDetail.DistrictNo),
                new SqlParameter("@BlockNo", objApplicantDetail.BlockNo),
                new SqlParameter("@TehsilNo", objApplicantDetail.TehsilNo),
                new SqlParameter("@PostallAddress", objApplicantDetail.PostallAddress),
                new SqlParameter("@EmailID", objApplicantDetail.EmailID),
                new SqlParameter("@UserBankName", objApplicantDetail.UserBankName),
                new SqlParameter("@UserBankShakha", objApplicantDetail.UserBankShakha),
                new SqlParameter("@UserBankIFSC", objApplicantDetail.UserBankIFSC),
                new SqlParameter("@UserAcNo", objApplicantDetail.UserAcNo),
                new SqlParameter("@Phone_no", objApplicantDetail.Phone_no),
                new SqlParameter("@MobileNo", objApplicantDetail.MobileNo),
                new SqlParameter("@TehsilName", objApplicantDetail.TehsilName)
            };
            object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "ApplicantProfile_DBLayer", paramList);
            if (obj == null)
                return 0;
            return Convert.ToInt64(obj);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region "Applicant Scheme"

    public string CreateAPT_SchemeRegistration(APT_SchemeRegistration objAPT_SchemeRegistration)
    {
        try
        {
            object obj = null;
            string result = "";

            if (objAPT_SchemeRegistration.RegistrationKey == 0 || objAPT_SchemeRegistration.SchemeKey == 0
                    || objAPT_SchemeRegistration.TotalArea == 0 || objAPT_SchemeRegistration.TotalSubAmount == 0
                    || objAPT_SchemeRegistration.SchemeDocuments.Count == 0)
            {
                result = "InValid";
            }
            else
            {
                string xmlSchemeDocs = GlobalFunctions.ConvertToXMLFormat<APT_SchemeDocuments>(ref objAPT_SchemeRegistration.SchemeDocuments);
                SqlParameter[] objParam = new SqlParameter[] { 
                            new SqlParameter("@QueryType","INSERT"),
                            new SqlParameter("@APTExperience",objAPT_SchemeRegistration.APTExperience),
                            new SqlParameter("@AssistanceReceived",objAPT_SchemeRegistration.AssistanceReceived),
                            new SqlParameter("@BenShareCost",objAPT_SchemeRegistration.BenShareCost),
                            new SqlParameter("@CenShareCost",objAPT_SchemeRegistration.CenShareCost),
                            new SqlParameter("@EcoOperation",objAPT_SchemeRegistration.EcoOperation),
                            new SqlParameter("@EstRecCost",objAPT_SchemeRegistration.EstRecCost),
                            new SqlParameter("@ExcOprtDate",objAPT_SchemeRegistration.ExcOprtDate),
                            new SqlParameter("@FinancialTieUp",objAPT_SchemeRegistration.FinancialTieUp),
                            new SqlParameter("@LabourNos",objAPT_SchemeRegistration.LabourNos),
                            new SqlParameter("@LabourSource",objAPT_SchemeRegistration.LabourSource),
                            new SqlParameter("@LandArea",objAPT_SchemeRegistration.LandArea),
                            new SqlParameter("@LandOwnership",objAPT_SchemeRegistration.LandOwnership),
                            new SqlParameter("@LeaseDuration",objAPT_SchemeRegistration.LeaseDuration),
                            new SqlParameter("@MarketingTieUp",objAPT_SchemeRegistration.MarketingTieUp),
                            new SqlParameter("@PlotNo",objAPT_SchemeRegistration.PlotNo),
                            new SqlParameter("@ProjectCost",objAPT_SchemeRegistration.ProjectCost),
                            new SqlParameter("@ProposedWork",objAPT_SchemeRegistration.ProposedWork),
                            new SqlParameter("@ReasonForFinDef",objAPT_SchemeRegistration.ReasonForFinDef),
                            new SqlParameter("@RegistrationKey",objAPT_SchemeRegistration.RegistrationKey),
                            new SqlParameter("@SchemeKey",objAPT_SchemeRegistration.SchemeKey),
                            new SqlParameter("@SocialCategory",objAPT_SchemeRegistration.SocialCategory),
                            new SqlParameter("@SpecialCategory",objAPT_SchemeRegistration.SpecialCategory),
                            new SqlParameter("@StaShareCost",objAPT_SchemeRegistration.StaShareCost),
                            new SqlParameter("@TotalArea",objAPT_SchemeRegistration.TotalArea),
                            new SqlParameter("@TotalSubAmount",objAPT_SchemeRegistration.TotalSubAmount),
                            new SqlParameter("@UserNo",objAPT_SchemeRegistration.UserNo),
                            new SqlParameter("@WaterArea",objAPT_SchemeRegistration.WaterArea),
                            new SqlParameter("@SchemeDocsXml",xmlSchemeDocs),
                        };
                obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "APT_SchemeRegistration_DBLayer", objParam);
                if (obj != null && obj != DBNull.Value)
                    result = obj.ToString();
                else
                    result = "NotDone";
            }

            return result;
        }
        catch (Exception ex)
        {
            foreach (APT_SchemeDocuments objDoc in objAPT_SchemeRegistration.SchemeDocuments)
            {
                try
                {
                    if (objDoc.DocFilePath != "" && System.IO.File.Exists(HttpContext.Current.Server.MapPath("~/" + DBLayer.APT_SchemeDocuments + '/' + objDoc.DocFilePath)))
                        System.IO.File.Delete(HttpContext.Current.Server.MapPath("~/" + DBLayer.APT_SchemeDocuments + "/") + objDoc.DocFilePath);
                }
                catch (Exception exx)
                {
                    throw exx;
                }
            }
            throw ex;
        }
    }

    public string UpdateAPT_SchemeRegistration(APT_SchemeRegistration objAPT_SchemeRegistration, bool UpdateDoc = false)
    {
        try
        {
            object obj = null;
            string result = "";

            if (objAPT_SchemeRegistration.RegistrationKey == 0 || objAPT_SchemeRegistration.SchemeKey == 0
                    || objAPT_SchemeRegistration.TotalArea == 0 || objAPT_SchemeRegistration.TotalSubAmount == 0
                 || objAPT_SchemeRegistration.ApplicationCode == "")
            {
                result = "InValid";
            }
            else
            {
                string xmlSchemeDocs;
                if (!UpdateDoc)
                {

                    SqlParameter[] objParam = new SqlParameter[] { 
                            new SqlParameter("@QueryType","UPDATE"),
                            new SqlParameter("@ApplicationCode",objAPT_SchemeRegistration.ApplicationCode),
                            new SqlParameter("@APTExperience",objAPT_SchemeRegistration.APTExperience),
                            new SqlParameter("@AssistanceReceived",objAPT_SchemeRegistration.AssistanceReceived),
                            new SqlParameter("@BenShareCost",objAPT_SchemeRegistration.BenShareCost),
                            new SqlParameter("@CenShareCost",objAPT_SchemeRegistration.CenShareCost),
                            new SqlParameter("@EcoOperation",objAPT_SchemeRegistration.EcoOperation),
                            new SqlParameter("@EstRecCost",objAPT_SchemeRegistration.EstRecCost),
                            new SqlParameter("@ExcOprtDate",objAPT_SchemeRegistration.ExcOprtDate),
                            new SqlParameter("@FinancialTieUp",objAPT_SchemeRegistration.FinancialTieUp),
                            new SqlParameter("@LabourNos",objAPT_SchemeRegistration.LabourNos),
                            new SqlParameter("@LabourSource",objAPT_SchemeRegistration.LabourSource),
                            new SqlParameter("@LandArea",objAPT_SchemeRegistration.LandArea),
                            new SqlParameter("@LandOwnership",objAPT_SchemeRegistration.LandOwnership),
                            new SqlParameter("@LeaseDuration",objAPT_SchemeRegistration.LeaseDuration),
                            new SqlParameter("@MarketingTieUp",objAPT_SchemeRegistration.MarketingTieUp),
                            new SqlParameter("@PlotNo",objAPT_SchemeRegistration.PlotNo),
                            new SqlParameter("@ProjectCost",objAPT_SchemeRegistration.ProjectCost),
                            new SqlParameter("@ProposedWork",objAPT_SchemeRegistration.ProposedWork),
                            new SqlParameter("@ReasonForFinDef",objAPT_SchemeRegistration.ReasonForFinDef),
                            new SqlParameter("@RegistrationKey",objAPT_SchemeRegistration.RegistrationKey),
                            new SqlParameter("@SchemeKey",objAPT_SchemeRegistration.SchemeKey),
                            new SqlParameter("@SocialCategory",objAPT_SchemeRegistration.SocialCategory),
                            new SqlParameter("@SpecialCategory",objAPT_SchemeRegistration.SpecialCategory),
                            new SqlParameter("@StaShareCost",objAPT_SchemeRegistration.StaShareCost),
                            new SqlParameter("@TotalArea",objAPT_SchemeRegistration.TotalArea),
                            new SqlParameter("@TotalSubAmount",objAPT_SchemeRegistration.TotalSubAmount),
                            new SqlParameter("@UserNo",objAPT_SchemeRegistration.UserNo),
                            new SqlParameter("@WaterArea",objAPT_SchemeRegistration.WaterArea),
                           
                        };
                    obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "APT_SchemeRegistration_DBLayer", objParam);
                    if (obj != null && obj != DBNull.Value)
                        result = obj.ToString();
                    else
                        result = "NotDone";
                }
                else if (objAPT_SchemeRegistration.SchemeDocuments != null)
                {
                    if (objAPT_SchemeRegistration.SchemeDocuments.Count > 0)
                    {
                        xmlSchemeDocs = GlobalFunctions.ConvertToXMLFormat<APT_SchemeDocuments>(ref objAPT_SchemeRegistration.SchemeDocuments);
                        SqlParameter[] objParam = new SqlParameter[] { 
                            new SqlParameter("@QueryType","UPDATEWITHDOC"),
                            new SqlParameter("@ApplicationCode",objAPT_SchemeRegistration.ApplicationCode),
                            new SqlParameter("@APTExperience",objAPT_SchemeRegistration.APTExperience),
                            new SqlParameter("@AssistanceReceived",objAPT_SchemeRegistration.AssistanceReceived),
                            new SqlParameter("@BenShareCost",objAPT_SchemeRegistration.BenShareCost),
                            new SqlParameter("@CenShareCost",objAPT_SchemeRegistration.CenShareCost),
                            new SqlParameter("@EcoOperation",objAPT_SchemeRegistration.EcoOperation),
                            new SqlParameter("@EstRecCost",objAPT_SchemeRegistration.EstRecCost),
                            new SqlParameter("@ExcOprtDate",objAPT_SchemeRegistration.ExcOprtDate),
                            new SqlParameter("@FinancialTieUp",objAPT_SchemeRegistration.FinancialTieUp),
                            new SqlParameter("@LabourNos",objAPT_SchemeRegistration.LabourNos),
                            new SqlParameter("@LabourSource",objAPT_SchemeRegistration.LabourSource),
                            new SqlParameter("@LandArea",objAPT_SchemeRegistration.LandArea),
                            new SqlParameter("@LandOwnership",objAPT_SchemeRegistration.LandOwnership),
                            new SqlParameter("@LeaseDuration",objAPT_SchemeRegistration.LeaseDuration),
                            new SqlParameter("@MarketingTieUp",objAPT_SchemeRegistration.MarketingTieUp),
                            new SqlParameter("@PlotNo",objAPT_SchemeRegistration.PlotNo),
                            new SqlParameter("@ProjectCost",objAPT_SchemeRegistration.ProjectCost),
                            new SqlParameter("@ProposedWork",objAPT_SchemeRegistration.ProposedWork),
                            new SqlParameter("@ReasonForFinDef",objAPT_SchemeRegistration.ReasonForFinDef),
                            new SqlParameter("@RegistrationKey",objAPT_SchemeRegistration.RegistrationKey),
                            new SqlParameter("@SchemeKey",objAPT_SchemeRegistration.SchemeKey),
                            new SqlParameter("@SocialCategory",objAPT_SchemeRegistration.SocialCategory),
                            new SqlParameter("@SpecialCategory",objAPT_SchemeRegistration.SpecialCategory),
                            new SqlParameter("@StaShareCost",objAPT_SchemeRegistration.StaShareCost),
                            new SqlParameter("@TotalArea",objAPT_SchemeRegistration.TotalArea),
                            new SqlParameter("@TotalSubAmount",objAPT_SchemeRegistration.TotalSubAmount),
                            new SqlParameter("@UserNo",objAPT_SchemeRegistration.UserNo),
                            new SqlParameter("@WaterArea",objAPT_SchemeRegistration.WaterArea),
                            new SqlParameter("@SchemeDocsXml",xmlSchemeDocs),
                        };
                        obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "APT_SchemeRegistration_DBLayer", objParam);
                        if (obj != null && obj != DBNull.Value)
                            result = obj.ToString();
                        else
                            result = "NotDone";
                    }
                    else
                    {
                        result = "InValid";
                    }
                }
                else
                {
                    result = "InValid";
                }

            }

            return result;
        }
        catch (Exception ex)
        {
            if (objAPT_SchemeRegistration.SchemeDocuments != null)
            {
                foreach (APT_SchemeDocuments objDoc in objAPT_SchemeRegistration.SchemeDocuments)
                {
                    try
                    {
                        if (objDoc.DocFilePath != "" && System.IO.File.Exists(HttpContext.Current.Server.MapPath("~/" + DBLayer.APT_SchemeDocuments + '/' + objDoc.DocFilePath)))
                            System.IO.File.Delete(HttpContext.Current.Server.MapPath("~/" + DBLayer.APT_SchemeDocuments + "/") + objDoc.DocFilePath);
                    }
                    catch (Exception exx)
                    {
                        throw exx;
                    }
                }
            }

            throw ex;
        }
    }

    public DataTable GetApplicantSchemes(int RegistrationKey)
    {
        try
        {
            DataTable dt = new DataTable();
            SqlParameter[] objParam = new SqlParameter[] { 
                    new SqlParameter("@RegistrationKey",RegistrationKey),
                    new SqlParameter("@QueryType","GetAppliedSchemeByRegistrationKey")
                };

            SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "APT_SchemeRegistration_DBLayer", objParam);
            dt.Load(dr);
            return dt;
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }

    public DataTable GetSchemeApplicationCode(String ApplicantCode)
    {
        DataTable dt = new DataTable();
        try
        {
            if (ApplicantCode != "")
            {
                SqlParameter[] param = new SqlParameter[] { 
                    new SqlParameter("@QueryType", "GetSchemeApplicationCode"),
                    new SqlParameter("@ApplicationCode ", ApplicantCode)
                };
                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "APT_SchemeRegistration_DBLayer", param);
                dt.Load(dr);
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
        return dt;
    }

    public DataTable GetSchemeDocsApplicationCode(String ApplicantCode)
    {
        DataTable dt = new DataTable();
        try
        {
            if (ApplicantCode != "")
            {
                SqlParameter[] param = new SqlParameter[] { 
                    new SqlParameter("@QueryType", "GetSchemeDocsApplicationCode"),
                    new SqlParameter("@ApplicationCode ", ApplicantCode)
                };
                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "APT_SchemeRegistration_DBLayer", param);
                dt.Load(dr);
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
        return dt;
    }

    public DataTable GetSchemeAcknowledgement(String ApplicantCode)
    {
        DataTable dt = new DataTable();
        try
        {
            if (ApplicantCode != "")
            {
                SqlParameter[] param = new SqlParameter[] { 
                    new SqlParameter("@QueryType", "Get_Scheme_AcknowledgemenDetail"),
                    new SqlParameter("@ApplicationCode ", ApplicantCode)
                };
                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "APT_SchemeRegistration_DBLayer", param);
                dt.Load(dr);
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
        return dt;
    }
    #endregion

    #region "Scheme-District Level"
    public int TakeAction(APT_SchemeActionDetail objSchemeActionDetail)
    {
        int intRowAffected = 0;
        try
        {
            SqlParameter[] objParam = new SqlParameter[] { 
                new SqlParameter("@ActionBy",objSchemeActionDetail.ActionBy),
                new SqlParameter("@ApplicationNo",objSchemeActionDetail.ApplicationNo),
                new SqlParameter("@CreatedBy",objSchemeActionDetail.CreatedBy),
                new SqlParameter("@IsForword",objSchemeActionDetail.IsForword),
                new SqlParameter("@ObjAttach",objSchemeActionDetail.ObjAttach),
                new SqlParameter("@ObjForm",objSchemeActionDetail.ObjForm),
                new SqlParameter("@LastModifiedBy",objSchemeActionDetail.LastModifiedBy),
                new SqlParameter("@OtherFileName",objSchemeActionDetail.OtherFileName),
                new SqlParameter("@OtherFilePath",objSchemeActionDetail.OtherFilePath),
                new SqlParameter("@RegistrationKey",objSchemeActionDetail.RegistrationKey),
                new SqlParameter("@Remarks",objSchemeActionDetail.Remarks),
                new SqlParameter("@CurStatus",objSchemeActionDetail.CurStatus),
                new SqlParameter("@SchemeKey",objSchemeActionDetail.SchemeKey),
                new SqlParameter("@SurveryFileName",objSchemeActionDetail.SurveryFileName),
                new SqlParameter("@SurveryFilePath",objSchemeActionDetail.SurveryFilePath),
                new SqlParameter("@QueryType","INSERT")
                };
            object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "APT_SchemeActionDetail_DBLayer", objParam);
            if (obj != null && obj != DBNull.Value)
                intRowAffected = Convert.ToInt32(obj);
            else
                intRowAffected = 0;
        }
        catch (Exception ex)
        {

            throw ex;
        }
        return intRowAffected;
    }

    public int TakeAction(ICollection<APT_SchemeActionDetail> objSchemes)
    {
        int intRowAffected = 0;
        try
        {
            if (objSchemes.Count > 0)
            {
                string xmlSchemes = GlobalFunctions.ConvertToXMLFormat<APT_SchemeActionDetail>(ref objSchemes);
                SqlParameter[] objParam = new SqlParameter[] { 
                new SqlParameter("@xmlSchemes",xmlSchemes),
                new SqlParameter("@QueryType","FinalApproveByHO")
                };
                object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "APT_SchemeActionDetail_DBLayer", objParam);
                if (obj != null && obj != DBNull.Value)
                    intRowAffected = Convert.ToInt32(obj);
                else
                    intRowAffected = 0;
            }
           
        }
        catch (Exception ex)
        {

            throw ex;
        }
        return intRowAffected;
    }

    public DataTable GetSchemeByApplicatonNo(Int64 ApplicationNo)
    {
        try
        {
            DataTable dt = new DataTable();
            SqlParameter[] objParam = new SqlParameter[] { 
                    new SqlParameter("@ApplicationNo",ApplicationNo),
                    new SqlParameter("@QueryType","GetSchemeApplicationKey")
                };

            SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "APT_SchemeRegistration_DBLayer", objParam);
            dt.Load(dr);
            return dt;
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }

    public DataTable GetSchemeByApplicatonNoWithDocs(Int64 ApplicationNo)
    {
        try
        {
            DataTable dt = new DataTable();
            SqlParameter[] objParam = new SqlParameter[] { 
                    new SqlParameter("@ApplicationNo",ApplicationNo),
                    new SqlParameter("@QueryType","GetSchemeApplicationKeyWithDoc")
                };

            SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "APT_SchemeRegistration_DBLayer", objParam);
            dt.Load(dr);
            return dt;
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }

    public DataTable GetApplicantListForMandal(Int64 DivisionKey)
    {
        try
        {
            DataTable dt = new DataTable();
            SqlParameter[] objParam = new SqlParameter[] { 
                    new SqlParameter("@DivisionKey",DivisionKey),
                    new SqlParameter("@QueryType","GetApplicantListForMandal")
                };

            SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "APT_SchemeRegistration_DBLayer", objParam);
            dt.Load(dr);
            return dt;
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }
    #endregion

    #endregion

    #region "Applicant Registration - Done By Sanjay Srivastava (Some Code are Obsolete)"
    public void ReadApplicant(ApplicantDetail objRecord)
    {
        SqlDataReader sqlRdr = null;
        try
        {
            string sProcName = null;
            SqlParameter[] paramList;

            if (objRecord.RegistrationKey != 0)
            {
                sProcName = "ApplicantProfile_DBLayer";
                paramList = new SqlParameter[2];
                paramList[0] = new SqlParameter("@QueryType", "SlectUserExist");
                paramList[1] = new SqlParameter("@RegistrationKey", objRecord.RegistrationKey);

                sqlRdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, sProcName, paramList);
            }


            if (sqlRdr.Read())
            {

                objRecord.UserNo = GetInt16(sqlRdr["UserNo"]);
                objRecord.CareOf = sqlRdr["CareOf"].ToString();
                objRecord.FatherName = sqlRdr["FatherName"].ToString();
                objRecord.DOB = sqlRdr["DOB"].ToString();
                objRecord.Gender = Convert.ToInt16(sqlRdr["Gender"].ToString());
                objRecord.RevenueVillage = sqlRdr["RevenueVillage"].ToString();
                objRecord.PinNo = sqlRdr["PinNo"].ToString();
                objRecord.PostOffice = sqlRdr["PostOffice"].ToString();
                objRecord.DistrictNo = GetInt16(sqlRdr["DistrictNo"].ToString());
                objRecord.BlockNo = GetInt16(sqlRdr["BlockNo"].ToString());
                objRecord.TehsilNo = GetInt16(sqlRdr["TehsilNo"].ToString());
                objRecord.PostallAddress = sqlRdr["PostallAddress"].ToString();
                objRecord.EmailID = sqlRdr["EmailID"].ToString();
                objRecord.Phone_no = sqlRdr["Phone_No"].ToString();
                objRecord.PostallAddress = sqlRdr["PostallAddress"].ToString();
                objRecord.UserBankName = GetInt16(sqlRdr["UserBankName"].ToString());
                objRecord.UserBankShakha = GetInt16(sqlRdr["UserBankShakha"].ToString());
                objRecord.UserBankIFSC = sqlRdr["UserBankIFSC"].ToString();
                objRecord.UserAcNo = sqlRdr["UserAcNo"].ToString();

            }


            else
            {
                objRecord.RegistrationKey = 0;
                throw new Exception("Invalid Record Key!");

            }
        }
        finally
        {
            if (sqlRdr != null)
                sqlRdr.Close();
        }
    }

    public void ReadApplication(ApplicantSchemeRegistration objRecord)
    {
        SqlDataReader sqlRdr = null;
        try
        {
            string sProcName = null;
            SqlParameter[] paramList;
            Byte Case;
            if (objRecord.ApplicationNo > 0)
            {
                sProcName = "ApplicantSchemeRegistration_DBLayer";
                paramList = new SqlParameter[2];
                paramList[0] = new SqlParameter("@QueryType", "SelectApplicantSchemeDetail");
                paramList[1] = new SqlParameter("@ApplicationNo", objRecord.ApplicationNo);
                Case = 1;
            }
            else
            {
                sProcName = "ApplicantSchemeRegistration_DBLayer";
                paramList = new SqlParameter[2];
                paramList[0] = new SqlParameter("@QueryType", "SELECTbyUNIQUEKEY");
                paramList[1] = new SqlParameter("@ApplicationNo", objRecord.ApplicationNo);
                Case = 2;
            }
            sqlRdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, sProcName, paramList);
            if (sqlRdr.Read())
            {

                objRecord.Registrationkey = GetInt16(sqlRdr["RegistrationKey"]);
                objRecord.ApplicationNo = GetInt16(sqlRdr["ApplicationNo"].ToString());
                objRecord.AadharNo = sqlRdr["AadharNo"].ToString();
                objRecord.Name = sqlRdr["Name"].ToString();


                objRecord.DistrictNo = GetInt16(sqlRdr["DistrictNo"]);

                //objRecord.OfficeKey = GetInt32(sqlRdr["OfficeKey"]);
                //objRecord.OfficeName = sqlRdr["OfficeName"].ToString();
                objRecord.Gender = GetInt16(sqlRdr["Gender"]);
                objRecord.DOB = GetDate(sqlRdr["DOB"]);
                objRecord.Category = GetInt16(sqlRdr["Category"]);
                //objRecord.SocialCategoryName = ((ReservationCategory)GetInt16(sqlRdr["Category"])).ToString().Replace("_", " ");


                objRecord.PostallAddress = sqlRdr["PostallAddress"].ToString();
                objRecord.Revenue_Village = sqlRdr["Revenue_Village"].ToString();
                objRecord.PostOffice = sqlRdr["PostOffice"].ToString();
                objRecord.PinNo = sqlRdr["PinNo"].ToString();
                objRecord.EnglishName = sqlRdr["EnglishName"].ToString();
                objRecord.DivisionName = sqlRdr["DivisionEnglish"].ToString();
                objRecord.BlockName = sqlRdr["BlockName"].ToString();


                objRecord.MobileNo = sqlRdr["MobileNo"].ToString();

                objRecord.EmailID = sqlRdr["EmailID"].ToString();



                objRecord.createdon = GetDate(sqlRdr["CreatedOn"]);
                objRecord.Isfinalsubmit = GetBoolean(sqlRdr["IsFinalSubmit"]);
                objRecord.ApplicationStatus = GetInt16(sqlRdr["ApplicationStatus"]);

                objRecord.CurrentStatusText = sqlRdr["CurrentStatusText"].ToString();
                objRecord.AvailableStatus = sqlRdr["AvailableStatus"].ToString();
                objRecord.LevelFrom = sqlRdr["LevelFrom"].ToString();
                objRecord.LevelTo = sqlRdr["LevelTo"].ToString();

                objRecord.DocReceiveDate = GetDate(sqlRdr["DocReceiveDate"]);
                objRecord.Remark = sqlRdr["Remark"].ToString();
                objRecord.detailsproposedwork = sqlRdr["detailsproposedwork"].ToString();
                objRecord.SchemeName = sqlRdr["SchemeName"].ToString();
                objRecord.PlotNo = sqlRdr["PlotNo"].ToString();
                objRecord.Project_cost = GetDouble(sqlRdr["Project_cost"].ToString());
                objRecord.totalland = GetDouble(sqlRdr["totalland"].ToString());
                objRecord.totalwaterarea = GetDouble(sqlRdr["totalwaterarea"].ToString());
                objRecord.Beneficiaries_share = GetDouble(sqlRdr["Beneficiaries_share"].ToString());
                objRecord.Total_Subsidy_Amount = GetDouble(sqlRdr["Total_Subsidy_Amount"].ToString());
                objRecord.Central_share = GetDouble(sqlRdr["Central_share"].ToString());
                objRecord.State_share = GetDouble(sqlRdr["State_share"].ToString());
                objRecord.Applicant_Experience = sqlRdr["Applicant_Experience"].ToString();
                objRecord.Details_economics = sqlRdr["Details_economics"].ToString();
                objRecord.UserBankName = GetInt16(sqlRdr["UserBankName"].ToString());
                objRecord.UserBankIFSC = sqlRdr["UserBankIFSC"].ToString();
                objRecord.BranchName = sqlRdr["BranchName"].ToString();
                objRecord.Address = sqlRdr["Address"].ToString();
                objRecord.BankName = sqlRdr["BankName"].ToString();
                objRecord.District_Flag = Convert.ToInt16(sqlRdr["District_Flag"].ToString());
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
    }

    public DataTable GetApplicantProfile(Int64 RegistrationKey)
    {
        DataTable dt = new DataTable();
        try
        {
            if (RegistrationKey != 0)
            {
                SqlParameter[] param = new SqlParameter[] { 
                    new SqlParameter("@QueryType", "SelectUserProfile"),
                    new SqlParameter("@RegistrationKey", RegistrationKey)
                };
                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "ApplicantProfile_DBLayer", param);
                dt.Load(dr);
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
        return dt;
    }



    public void ReadStatusMaster(ApplicationStatus_Master objRecord)
    {
        SqlDataReader sqlRdr = null;
        try
        {
            string sProcName = null;
            SqlParameter[] paramList;
            Byte Case;
            sProcName = "ApplicationStatus_Master_DBLayer";
            paramList = new SqlParameter[2];
            paramList[0] = new SqlParameter("@QueryType", "SELECTbyPRIMARYKEY");
            paramList[1] = new SqlParameter("@StatusKey", objRecord.StatusKey);

            sqlRdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, sProcName, paramList);
            if (sqlRdr.Read())
            {
                objRecord.StatusKey = GetInt32(sqlRdr["StatusKey"]);
                objRecord.StatusText = sqlRdr["StatusText"].ToString();
                objRecord.LevelFrom = sqlRdr["LevelFrom"].ToString();
                objRecord.LevelTo = sqlRdr["LevelTo"].ToString();
                objRecord.AvailableStatus = sqlRdr["AvailableStatus"].ToString();
                objRecord.CurrentStatusText = sqlRdr["CurrentStatusText"].ToString();
                objRecord.IntimateApplicant = GetBoolean(sqlRdr["IntimateApplicant"]);

                objRecord.IsActive = GetBoolean(sqlRdr["IsActive"]);
                objRecord.CreatedOn = GetDate(sqlRdr["CreatedOn"]);
                objRecord.CreatedBy = GetInt16(sqlRdr["CreatedBy"]);
                objRecord.LastModifiedOn = GetDate(sqlRdr["LastModifiedOn"]);
                objRecord.LastModifiedBy = GetInt16(sqlRdr["LastModifiedBy"]);
            }
            else
            {
                objRecord.StatusKey = 0;
            }
        }
        finally
        {
            if (sqlRdr != null)
                sqlRdr.Close();
        }
    }

    public void Read(ApplicantDetail objRecord)
    {
        SqlDataReader sqlRdr = null;
        try
        {
            string sProcName = null;
            SqlParameter[] paramList;

            if (objRecord.RegistrationKey != 0)
            {
                sProcName = "ApplicantProfile_DBLayer";
                paramList = new SqlParameter[2];
                paramList[0] = new SqlParameter("@QueryType", "getAwasYojnaApplicantDetails");
                paramList[1] = new SqlParameter("@AlottmentKey", objRecord.RegistrationKey);

                sqlRdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, sProcName, paramList);
            }


            if (sqlRdr.Read())
            {
                objRecord.UserNo = GetInt16(sqlRdr["UserNo"]);
                objRecord.CareOf = sqlRdr["CareOf"].ToString();
                objRecord.FatherName = sqlRdr["FatherName"].ToString();
                objRecord.DOB = sqlRdr["DOB"].ToString();
                objRecord.Gender = Convert.ToInt16(sqlRdr["Gender"].ToString());
                objRecord.RevenueVillage = sqlRdr["RevenueVillage"].ToString();
                objRecord.PinNo = sqlRdr["PinNo"].ToString();
                objRecord.PostOffice = sqlRdr["PostOffice"].ToString();
                objRecord.DistrictNo = GetInt16(sqlRdr["DistrictNo"].ToString());
                objRecord.BlockNo = GetInt16(sqlRdr["BlockNo"].ToString());
                objRecord.TehsilNo = GetInt16(sqlRdr["TehsilNo"].ToString());
                objRecord.PostallAddress = sqlRdr["PostallAddress"].ToString();
                objRecord.EmailID = sqlRdr["EmailID"].ToString();
                objRecord.Phone_no = sqlRdr["Phone_No"].ToString();
                objRecord.PostallAddress = sqlRdr["PostallAddress"].ToString();


            }


            else
            {
                objRecord.RegistrationKey = 0;
                throw new Exception("Invalid Record Key!");

            }
        }
        finally
        {
            if (sqlRdr != null)
                sqlRdr.Close();
        }
    }

    public List<ApplicationStatus_Master> ReadAllApplicationStatus(Boolean isActive = false, Int32 StatusKey = 0, string LevelFrom = null)
    {
        List<ApplicationStatus_Master> lstApplicationStatus = new List<ApplicationStatus_Master>();
        SqlDataReader sqlRdr = null;
        try
        {
            string sProcName = "ApplicationStatus_Master_DBLayer";
            SqlParameter[] paramList;

            paramList = new SqlParameter[4];
            paramList[0] = new SqlParameter("@QueryType", "READALL");
            if (isActive)
                paramList[1] = new SqlParameter("@isActive", true);
            else
                paramList[1] = new SqlParameter("@isActive", DBNull.Value);
            if (StatusKey > 0)
                paramList[2] = new SqlParameter("@StatusKey", StatusKey);
            else
                paramList[2] = new SqlParameter("@StatusKey", DBNull.Value);
            if (!String.IsNullOrEmpty(LevelFrom))
                paramList[3] = new SqlParameter("@LevelFrom", LevelFrom);
            else
                paramList[3] = new SqlParameter("@LevelFrom", DBNull.Value);

            sqlRdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, sProcName, paramList);
            while (sqlRdr.Read())
            {
                ApplicationStatus_Master obj = new ApplicationStatus_Master();

                obj.StatusKey = GetInt32(sqlRdr["StatusKey"]);
                obj.StatusText = sqlRdr["StatusText"].ToString();
                obj.LevelFrom = sqlRdr["LevelFrom"].ToString();
                obj.LevelTo = sqlRdr["LevelTo"].ToString();
                obj.AvailableStatus = sqlRdr["AvailableStatus"].ToString();
                obj.CurrentStatusText = sqlRdr["CurrentStatusText"].ToString();
                obj.IsActive = GetBoolean(sqlRdr["IsActive"]);
                obj.CreatedBy = GetInt16(sqlRdr["CreatedBy"]);
                obj.CreatedOn = GetDate(sqlRdr["CreatedOn"]);
                obj.LastModifiedBy = GetInt16(sqlRdr["LastModifiedBy"]);
                obj.LastModifiedOn = GetDate(sqlRdr["LastModifiedOn"]);
                obj.IntimateApplicant = GetBoolean(sqlRdr["IntimateApplicant"]);

                lstApplicationStatus.Add(obj);

            }
        }
        finally
        {
            if (sqlRdr != null)
                sqlRdr.Close();
        }
        return lstApplicationStatus;
    }

    public List<ApplicationStatus_Master> ReadAllApplicationStatusDvision(Boolean isActive = false, Int32 StatusKey = 0, string LevelFrom = null)
    {
        List<ApplicationStatus_Master> lstApplicationStatus = new List<ApplicationStatus_Master>();
        SqlDataReader sqlRdr = null;
        try
        {
            string sProcName = "ApplicationStatus_Master_DBLayer";
            SqlParameter[] paramList;

            paramList = new SqlParameter[4];
            paramList[0] = new SqlParameter("@QueryType", "READALL");
            if (isActive)
                paramList[1] = new SqlParameter("@isActive", true);
            else
                paramList[1] = new SqlParameter("@isActive", DBNull.Value);
            if (StatusKey > 0)
                paramList[2] = new SqlParameter("@StatusKey", StatusKey);
            else
                paramList[2] = new SqlParameter("@StatusKey", DBNull.Value);
            if (!String.IsNullOrEmpty(LevelFrom))
                paramList[3] = new SqlParameter("@LevelFrom", LevelFrom);
            else
                paramList[3] = new SqlParameter("@LevelFrom", DBNull.Value);

            sqlRdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, sProcName, paramList);
            while (sqlRdr.Read())
            {
                ApplicationStatus_Master obj = new ApplicationStatus_Master();

                obj.StatusKey = GetInt32(sqlRdr["StatusKey"]);
                obj.StatusText = sqlRdr["StatusText"].ToString();
                obj.LevelFrom = sqlRdr["LevelFrom"].ToString();
                obj.LevelTo = sqlRdr["LevelTo"].ToString();
                obj.AvailableStatus = sqlRdr["AvailableStatus"].ToString();
                obj.CurrentStatusText = sqlRdr["CurrentStatusText"].ToString();
                obj.IsActive = GetBoolean(sqlRdr["IsActive"]);
                obj.CreatedBy = GetInt16(sqlRdr["CreatedBy"]);
                obj.CreatedOn = GetDate(sqlRdr["CreatedOn"]);
                obj.LastModifiedBy = GetInt16(sqlRdr["LastModifiedBy"]);
                obj.LastModifiedOn = GetDate(sqlRdr["LastModifiedOn"]);
                obj.IntimateApplicant = GetBoolean(sqlRdr["IntimateApplicant"]);

                lstApplicationStatus.Add(obj);

            }
        }
        finally
        {
            if (sqlRdr != null)
                sqlRdr.Close();
        }
        return lstApplicationStatus;
    }

    public DataSet getdockey(String doctype)
    {
        DataSet dt = new DataSet();
        string query = "SELECT *  from dbo.DocumentMst  UM  where DocumentName='" + doctype.Trim() + "' ";



        dt = SqlHelper.ExecuteDataset(Constr, CommandType.Text, query);

        return dt;
    }

    public DataTable GetBranchDetail(int BankDetailId)
    {
        DataTable dt = new DataTable();

        using (var con = new SqlConnection(Constr))
        {
            string query = "SELECT *  from dbo.BankDetail  UM  where BankDetailKey=" + BankDetailId + " and isActive = 1";


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

    public List<Applicantdocumentdetails> Read(Applicantdocumentdetails objRecord)
    {
        SqlDataReader sqlRdr = null;
        List<Applicantdocumentdetails> lstDoc = new List<Applicantdocumentdetails>();
        try
        {

            string sProcName = null;
            SqlParameter[] paramList;
            if (objRecord.DocumentKey > 0)
            {
                sProcName = "ApplicantScheme_DocumentsDetail_DBLayer";
                paramList = new SqlParameter[2];
                paramList[0] = new SqlParameter("@QueryType", "SELECTbyPRIMARYKEY");
                paramList[1] = new SqlParameter("@DocumentKey", objRecord.DocumentKey);


                //paramList[0] = new SqlParameter("@QueryType", "SELECTbySignature");
                //paramList[1] = new SqlParameter("@DocumentKey", objRecord.DocumentKey);
            }
            else
            {
                sProcName = "ApplicantScheme_DocumentsDetail_DBLayer";
                paramList = new SqlParameter[2];
                paramList[0] = new SqlParameter("@QueryType", "SELECTbyUNIQUEKEY");
                paramList[1] = new SqlParameter("@ApplicationKey", objRecord.ApplicationKey);
            }


            sqlRdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, sProcName, paramList);
            while (sqlRdr.Read())
            {
                Applicantdocumentdetails obj = new Applicantdocumentdetails();
                obj.DocumentDetailKey = GetInt32(sqlRdr["DocumentDetailKey"]);
                obj.DocumentKey = GetInt64(sqlRdr["DocumentID"]);
                obj.ApplicationKey = GetInt32(sqlRdr["ApplicationKey"]);

                obj.documentname = sqlRdr["documentname"].ToString();
                obj.FileName = sqlRdr["FileName"].ToString();

                lstDoc.Add(obj);
            }
        }
        finally
        {
            if (sqlRdr != null)
                sqlRdr.Close();
        }
        return lstDoc;
    }

    public DataTable GetSchemeDocumentdetails(int schemekey)
    {
        DataTable dt = new DataTable();

        using (var con = new SqlConnection(Constr))
        {
            string query = "SELECT     SchemeMaster.SchemeKey, SchemeMaster.SchemeName, DocumentMst.DocumentName,documentMst.DocumentID FROM SchemeMaster INNER JOIN SchemeDocument ON SchemeMaster.SchemeKey = SchemeDocument.SchemeKey INNER JOIN DocumentMst ON SchemeDocument.DocumentId = DocumentMst.DocumentID where  SchemeMaster.SchemeKey =" + schemekey + "";


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

    public DataTable PrintSchemedetails(int registrationkey, int schemekey)
    {
        DataTable dt = new DataTable();

        using (var con = new SqlConnection(Constr))
        {
            string query = "  SELECT     ApplicantRegistration.Name, ApplicantRegistration.MobileNo, ApplicantProfile.FatherName, ApplicantSchemeRegistration.ApplicationNo, SchemeMaster.SchemeName, ApplicantSchemeRegistration.createdon FROM ApplicantSchemeRegistration INNER JOIN ";
            query = query + " ApplicantRegistration ON ApplicantSchemeRegistration.Registrationkey = ApplicantRegistration.Registrationkey INNER JOIN ";
            query = query + " ApplicantProfile ON ApplicantRegistration.Registrationkey = ApplicantProfile.RegistrationKey INNER JOIN ";
            query = query + " SchemeMaster ON ApplicantSchemeRegistration.SchemeKey = SchemeMaster.SchemeKey where  ApplicantRegistration.Registrationkey =" + registrationkey + " and SchemeMaster.SchemeKey =" + schemekey + " ";


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

    public DataTable GetSchemedetails()
    {
        DataTable dt = new DataTable();

        using (var con = new SqlConnection(Constr))
        {
            string query = "SELECT *  from dbo.SchemeMaster where isActive=1";
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

    public int BankExist(Int16 Branchkey)
    {
        string sProcName = "BankDetail_DBLayer";
        SqlParameter[] paramList;
        paramList = new SqlParameter[2];
        paramList[0] = new SqlParameter("@QueryType", "Branch_Detail");
        paramList[1] = new SqlParameter("@BankDetailKey", Branchkey);

        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, sProcName, paramList);
        if (obj == null)
            return 0;
        else
            return Convert.ToInt32(obj);

    }

    public int checkApplicant(ApplicantDetail objrecord)
    {
        string sProcName = "ApplicantProfile_DBLayer";
        SqlParameter[] paramList;
        paramList = new SqlParameter[2];
        paramList[0] = new SqlParameter("@QueryType", "SlectUserExist");
        paramList[1] = new SqlParameter("@Registrationkey", objrecord.RegistrationKey);

        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, sProcName, paramList);
        if (obj == null)
            return 0;
        else
            return Convert.ToInt32(obj);
    }

    public DataSet GET_ApplicationList_DVIO(int districtKey)
    {
        DataSet ds = new DataSet();
        string _proc = "StatusDetail_DBLayer";
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@QueryType", "GET_ApplicationList_DVIO");
        if (districtKey > 0)
            param[1] = new SqlParameter("@DistrictKey", districtKey);
        else
            param[1] = new SqlParameter("@DistrictKey", DBNull.Value);
        ds = SqlHelper.ExecuteDataset(Constr, CommandType.StoredProcedure, _proc, param);
        return ds;
    }

    public Int64 UpdateApplicantDetails(int allotmentkey, int applicantkey, string Second_for_month, string Second_for_year, string Second_remarks, int LastModifiedBy)
    {
        if (String.IsNullOrEmpty(Second_for_month) || String.IsNullOrEmpty(Second_for_year))
            return 0;
        SqlParameter[] paramList = new SqlParameter[8];

        paramList[0] = new SqlParameter("@QueryType", "UpdateSecondIstallment");
        paramList[1] = new SqlParameter("@AlottmentKey", allotmentkey);
        paramList[2] = new SqlParameter("@Second_for_month", Second_for_month);

        paramList[3] = new SqlParameter("@Second_for_year", Second_for_year);
        paramList[4] = new SqlParameter("@Second_remarks", Second_remarks);
        paramList[5] = new SqlParameter("@ApplicantKey", applicantkey);

        paramList[7] = new SqlParameter("@LastModifiedBy", LastModifiedBy);

        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "AwasYojanaInstallmentDetails_DBLayer", paramList);

        if (obj == null)
            return 0;

        return Convert.ToInt64(obj);
    }

    #endregion


    public Int64 CreateVillage(Village objVillage)
    {
        try
        {
            SqlParameter[] paramList = new SqlParameter[]{
                new SqlParameter("@QueryType", "INSERT_VILLAGE"),
                new SqlParameter("@BlockKey", objVillage.BlockKey),
                new SqlParameter("@EnglishName", objVillage.EnglishName),
                new SqlParameter("@CreatedBy", objVillage.CreatedBy),
                new SqlParameter("@IsActive", objVillage.IsActive),
             };
            object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "DBT_ApplicantRegistration_DBLayer", paramList);
            if (obj == null)
                return 0;
            return Convert.ToInt64(obj);
        }
        catch (Exception)
        {           
            throw;
        }
    }

}