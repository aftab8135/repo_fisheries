using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using DBLibrary;

/// <summary>
/// Summary description for Applicant_DBLayer
/// </summary>

public partial class DBLayer
{

    #region Business Logic using Stored Procedure For - ApplicantRegistration

    public Int64 CreateAwasYojanaInstallment(int allotmentkey, int applicantkey, string first_for_month, string first_for_year, string first_remarks, bool IsActive, int creteby)
    {
        if (String.IsNullOrEmpty(first_for_month) || String.IsNullOrEmpty(first_for_year))
            return 0;
        SqlParameter[] paramList = new SqlParameter[8];
        paramList[0] = new SqlParameter("@QueryType", "INSERTFirstIstallment");
        paramList[1] = new SqlParameter("@AlottmentKey", allotmentkey);
        paramList[2] = new SqlParameter("@first_for_month", first_for_month);
        paramList[3] = new SqlParameter("@First_for_year", first_for_year);
        paramList[4] = new SqlParameter("@first_remarks", first_remarks);
        paramList[5] = new SqlParameter("@ApplicantKey", applicantkey);
        paramList[6] = new SqlParameter("@IsActive", IsActive);
        paramList[7] = new SqlParameter("@CreateBy", creteby);

        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "AwasYojanaInstallmentDetails_DBLayer", paramList);

        if (obj == null)
            return 0;

        return Convert.ToInt64(obj);
    }

    public Int64 CreateAwasYojanaDetails(int MandalKey, int DistrictKey, int BlockKey, string VillageName, int applicantkey, string ApplicantName, string Gender, DateTime DOB, string ApplicantAddress, string ApplicantMobileno, string ApplicantAadhar, int SchemeID, Int32 fundallotbydept, string for_month, string For_year, bool IsActive, Int16 creteby)
    {
        if (String.IsNullOrEmpty(VillageName) || String.IsNullOrEmpty(ApplicantName) || String.IsNullOrEmpty(ApplicantMobileno) || String.IsNullOrEmpty(ApplicantAddress))
            return 0;
        SqlParameter[] paramList = new SqlParameter[22];

        paramList[0] = new SqlParameter("@QueryType", "INSERT");
        paramList[1] = new SqlParameter("@MandalKey", MandalKey);
        paramList[2] = new SqlParameter("@DistrictKey", DistrictKey);
        paramList[3] = new SqlParameter("@BlockKey", BlockKey);
        paramList[4] = new SqlParameter("@VillageName", VillageName);
        paramList[5] = new SqlParameter("@ApplicantKey", applicantkey);
        paramList[6] = new SqlParameter("@ApplicantName", ApplicantName);
        paramList[7] = new SqlParameter("@Gender", Gender);
        paramList[8] = new SqlParameter("@DOB", DOB);
        paramList[9] = new SqlParameter("@ApplicantDistrictKey", null);
        paramList[10] = new SqlParameter("@ApplicantBlockKey", null);
        paramList[11] = new SqlParameter("@ApplicantMobileno", ApplicantMobileno);
        paramList[12] = new SqlParameter("@ApplicantAadhar", ApplicantAadhar);
        paramList[13] = new SqlParameter("@SchemeID", SchemeID);
        paramList[14] = new SqlParameter("@fundallotbydept", fundallotbydept);
        paramList[15] = new SqlParameter("@For_Month", for_month);
        paramList[16] = new SqlParameter("@For_Year", For_year);
        paramList[17] = new SqlParameter("@CreateBy", creteby);
        paramList[18] = new SqlParameter("@CreatedOn", DateTime.UtcNow.Date);
        paramList[19] = new SqlParameter("@IsActive", IsActive);
        paramList[20] = new SqlParameter("@ApplicantAddress", ApplicantAddress);

        paramList[21] = new SqlParameter("@Status", "Unstarted");
        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "AwasYojanaDetails_DBLayer", paramList);

        if (obj == null)
            return 0;

        return Convert.ToInt64(obj);
    }

    public Int64 UpdateAwasYojanaInstallment(int allotmentkey, int applicantkey, string Second_for_month, string Second_for_year, string Second_remarks, int LastModifiedBy)
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


    public Int64 UpdateAwasYojanasecondinstallmentupdate(int allotmentkey, Int32 secondInstallment, string status, Int16 LastModifiedBy)
    {
        SqlParameter[] paramList = new SqlParameter[5];
        paramList[0] = new SqlParameter("@QueryType", "Update_Secondinstallment");
        paramList[1] = new SqlParameter("@AlottmentKey", allotmentkey);
        paramList[2] = new SqlParameter("@SecondInstallment", secondInstallment);
        paramList[3] = new SqlParameter("@status", status);
        paramList[4] = new SqlParameter("@LastModifiedBy", LastModifiedBy);

        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "AwasYojanaDetails_DBLayer", paramList);

        if (obj == null)
            return 0;

        return Convert.ToInt64(obj);
    }


    public Int64 UpdateAwasYojanafirstinstallmentupdate(int allotmentkey, Int32 FirstInstallment, string status, Int16 LastModifiedBy)
    {
        SqlParameter[] paramList = new SqlParameter[5];
        paramList[0] = new SqlParameter("@QueryType", "Update_Firstinstallment");
        paramList[1] = new SqlParameter("@AlottmentKey", allotmentkey);
        paramList[2] = new SqlParameter("@FirstInstallment", FirstInstallment);
        paramList[3] = new SqlParameter("@status", status);
        paramList[4] = new SqlParameter("@LastModifiedBy", LastModifiedBy);

        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "AwasYojanaDetails_DBLayer", paramList);

        if (obj == null)
            return 0;

        return Convert.ToInt64(obj);
    }

    public Int64 UpdateAwasYojanaDetails(int allotmentkey, int MandalKey, int DistrictKey, int BlockKey, string VillageName, int applicantkey, string ApplicantName, string Gender, DateTime DOB, string ApplicantAddress, string ApplicantMobileno, string ApplicantAadhar, int SchemeID, Int32 fundallotbydept, string for_month, string For_year, bool IsActive, Int16 LastModifiedBy)
    {
        if (String.IsNullOrEmpty(VillageName) || String.IsNullOrEmpty(ApplicantName) || String.IsNullOrEmpty(ApplicantMobileno) || String.IsNullOrEmpty(ApplicantAddress))
            return 0;
        SqlParameter[] paramList = new SqlParameter[20];

        paramList[0] = new SqlParameter("@QueryType", "Update_Applicantform");
        paramList[1] = new SqlParameter("@MandalKey", MandalKey);
        paramList[2] = new SqlParameter("@DistrictKey", DistrictKey);
        paramList[3] = new SqlParameter("@BlockKey", BlockKey);
        paramList[4] = new SqlParameter("@VillageName", VillageName);
        paramList[5] = new SqlParameter("@ApplicantKey", applicantkey);
        paramList[6] = new SqlParameter("@ApplicantName", ApplicantName);
        paramList[7] = new SqlParameter("@Gender", Gender);
        paramList[8] = new SqlParameter("@DOB", DOB);
        paramList[9] = new SqlParameter("@ApplicantDistrictKey", null);
        paramList[10] = new SqlParameter("@ApplicantBlockKey", null);
        paramList[11] = new SqlParameter("@ApplicantMobileno", ApplicantMobileno);
        paramList[12] = new SqlParameter("@ApplicantAadhar", ApplicantAadhar);
        paramList[13] = new SqlParameter("@SchemeID", SchemeID);
        paramList[14] = new SqlParameter("@fundallotbydept", fundallotbydept);
        paramList[15] = new SqlParameter("@For_Month", for_month);
        paramList[16] = new SqlParameter("@For_Year", For_year);
        paramList[17] = new SqlParameter("@LastModifiedBy", LastModifiedBy);
        paramList[18] = new SqlParameter("@IsActive", IsActive);
        paramList[19] = new SqlParameter("@ApplicantAddress", ApplicantAddress);

        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "AwasYojanaDetails_DBLayer", paramList);

        if (obj == null)
            return 0;

        return Convert.ToInt64(obj);
    }

    public Int64 CreateApplicantRegistration(Int16 LegalType, string AadharNo, string Salutation, string Name, string MobileNo, string UserName, string Password, bool isactive)
    {
        if (LegalType == 0 || String.IsNullOrEmpty(Name) || String.IsNullOrEmpty(MobileNo))
            return 0;
        SqlParameter[] paramList = new SqlParameter[9];
        paramList[0] = new SqlParameter("@QueryType", "INSERT");
        paramList[1] = new SqlParameter("@LegalType", LegalType);
        paramList[2] = new SqlParameter("@AadharNo", AadharNo);
        paramList[3] = new SqlParameter("@Salutation", Salutation);
        paramList[4] = new SqlParameter("@Name", Name);
        paramList[5] = new SqlParameter("@MobileNo", MobileNo);
        paramList[6] = new SqlParameter("@UserName", UserName);
        paramList[7] = new SqlParameter("@Password", Password);
        paramList[8] = new SqlParameter("@isactive", isactive);
        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "ApplicantRegistration_DBLayer", paramList);

        if (obj == null)
            return 0;

        return Convert.ToInt64(obj);
    }


    public void Read(ApplicantRegistration objRecord)
    {
        SqlDataReader sqlRdr = null;
        try
        {
            string sProcName = null;
            SqlParameter[] paramList;
            Byte Case;
            if (objRecord.AadharNo == null)
            {
                sProcName = "ApplicantRegistration_DBLayer";
                paramList = new SqlParameter[2];
                paramList[0] = new SqlParameter("@QueryType", "SELECTbyPRIMARYKEY");
                paramList[1] = new SqlParameter("@RegistrationKey", objRecord.RegistrationKey);
                Case = 1;
            }
            else
            {
                sProcName = "ApplicantRegistration_DBLayer";
                paramList = new SqlParameter[2];
                paramList[0] = new SqlParameter("@QueryType", "SELECTbyUNIQUEKEY");
                paramList[1] = new SqlParameter("@AadharNo", objRecord.AadharNo);
                Case = 2;
            }
            sqlRdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, sProcName, paramList);
            if (sqlRdr.Read())
            {
                objRecord.RegistrationKey = GetInt64(sqlRdr["RegistrationKey"]);
                objRecord.AadharNo = sqlRdr["AadharNo"].ToString();
                objRecord.MobileNo = sqlRdr["MobileNo"].ToString();
                objRecord.Salutation = sqlRdr["Salutation"].ToString();
                objRecord.Name = sqlRdr["Name"].ToString();
                objRecord.UserName = sqlRdr["UserName"].ToString();
                objRecord.Password = sqlRdr["Password"].ToString();
                objRecord.IsActive = GetBoolean(sqlRdr["IsActive"]);
                objRecord.CreatedOn = GetDate(sqlRdr["CreatedOn"]);
                objRecord.PrevPasswords = sqlRdr["PrevPasswords"].ToString();
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


    public void Read(Awayojana objRecord)
    {
        SqlDataReader sqlRdr = null;
        try
        {
            string sProcName = null;
            SqlParameter[] paramList;
            Byte Case;
            if (objRecord.AlottmentKey != 0)
            {
                sProcName = "AwasYojanaDetails_DBLayer";
                paramList = new SqlParameter[2];
                paramList[0] = new SqlParameter("@QueryType", "getAwasYojnaApplicantDetails");
                paramList[1] = new SqlParameter("@AlottmentKey", objRecord.AlottmentKey);
                Case = 1;
            }
            else
            {
                sProcName = "AwasYojanaDetails_DBLayer";
                paramList = new SqlParameter[2];
                paramList[0] = new SqlParameter("@QueryType", "getAwasYojnaApplicantDetails");
                paramList[1] = new SqlParameter("@AlottmentKey", objRecord.AlottmentKey);
                Case = 2;
            }
            sqlRdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, sProcName, paramList);
            if (sqlRdr.Read())
            {
                objRecord.AlottmentKey = GetInt16(sqlRdr["AlottmentKey"]);
                objRecord.MandalKey = GetInt16(sqlRdr["MandalKey"]);
                objRecord.DistrictKey = GetInt16(sqlRdr["DistrictKey"]);
                objRecord.BlockKey = GetInt16(sqlRdr["BlockKey"]);
                objRecord.ApplicantName = sqlRdr["ApplicantName"].ToString();
                objRecord.VillageName = sqlRdr["VillageName"].ToString();
                objRecord.ApplicantMobileno = sqlRdr["ApplicantMobileno"].ToString();
                objRecord.ApplicantAadhar = sqlRdr["ApplicantAadhar"].ToString();
                objRecord.for_month = sqlRdr["for_month"].ToString();
                objRecord.For_year = sqlRdr["for_year"].ToString();
                objRecord.fundallotbydept = GetInt32(sqlRdr["fundallotbydept"]);
                objRecord.Gender = sqlRdr["Gender"].ToString();
                objRecord.SchemeID = GetInt16(sqlRdr["SchemeID"]);
                objRecord.ApplicantAddress = sqlRdr["ApplicantAddress"].ToString();
                objRecord.DOB = Convert.ToDateTime(sqlRdr["DOB"].ToString());

            }
            else
            {
                objRecord.AlottmentKey = 0;
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

    public DataSet getapplicantkey(Int16 AlottmentKey)
    {
        DataSet ds = new DataSet();

        using (var con = new SqlConnection(Constr))
        {

            string query = "SELECT applicantkey FROM  AwasYojanaDetails where AlottmentKey=" + AlottmentKey + "";


            using (var cmd = new SqlCommand(query, con))
            {
                using (var sda = new SqlDataAdapter())
                {
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    using (ds)
                    {
                        ds.Clear();
                        sda.Fill(ds);
                    }
                }
            }
        }

        return ds;
    }



    public DataSet getmandal(Int16 districtkey)
    {
        DataSet ds = new DataSet();

        using (var con = new SqlConnection(Constr))
        {

            string query = "SELECT District.EnglishName, Division.DivisionEnglish, Division.DivisionKey, District.DistrictKey FROM  District INNER JOIN Division ON District.DivisionKey = Division.DivisionKey where DistrictKey=" + districtkey + "";


            using (var cmd = new SqlCommand(query, con))
            {
                using (var sda = new SqlDataAdapter())
                {
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    using (ds)
                    {
                        ds.Clear();
                        sda.Fill(ds);
                    }
                }
            }
        }

        return ds;
    }

    public DataSet GET_AwaYogna_Detail(Int16 userkey)
    {
        DataSet ds = new DataSet();
        string _proc = "AwasYojanaDetails_DBLayer";
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@QueryType", "getAwasYojnaDetails");
        param[1] = new SqlParameter("@CreateBy", userkey);

        ds = SqlHelper.ExecuteDataset(Constr, CommandType.StoredProcedure, _proc, param);
        return ds;
    }

    public DataSet GET_rptAwasYogna_Detail(string for_month, string for_year)
    {
        DataSet ds = new DataSet();
        string _proc = "HO_Awasyojna_Rpt_District";
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@For_month", for_month);
        param[1] = new SqlParameter("@For_year", for_year);


        ds = SqlHelper.ExecuteDataset(Constr, CommandType.StoredProcedure, _proc, param);
        return ds;
    }
    public DataSet GET_secondinstallmen_Detail(Int16 userkey, string for_month, string for_year)
    {
        DataSet ds = new DataSet();
        string _proc = "AwasYojanaDetails_DBLayer";
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@QueryType", "getsecondinstallment");
        param[1] = new SqlParameter("@CreateBy", userkey);
        param[2] = new SqlParameter("@For_month", for_month);
        param[3] = new SqlParameter("@For_year", for_year);

        ds = SqlHelper.ExecuteDataset(Constr, CommandType.StoredProcedure, _proc, param);
        return ds;
    }

    public DataSet GET_firstinstallmen_Detail(Int16 userkey, string for_month, string for_year)
    {
        DataSet ds = new DataSet();
        string _proc = "AwasYojanaDetails_DBLayer";
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@QueryType", "getfirstinstallment");
        param[1] = new SqlParameter("@CreateBy", userkey);
        param[2] = new SqlParameter("@For_month", for_month);
        param[3] = new SqlParameter("@For_year", for_year);

        ds = SqlHelper.ExecuteDataset(Constr, CommandType.StoredProcedure, _proc, param);
        return ds;
    }
    public Int64 CreateDepartmentRegistration(int usertype, string name, string gender, string UserName, string password, string mobileno, int districtkey, string emailid, bool IsActive)
    {
        if (String.IsNullOrEmpty(gender) || String.IsNullOrEmpty(name) || String.IsNullOrEmpty(mobileno) || String.IsNullOrEmpty(UserName) || String.IsNullOrEmpty(password))
            return 0;
        SqlParameter[] paramList = new SqlParameter[10];

        paramList[0] = new SqlParameter("@QueryType", "INSERT");
        paramList[1] = new SqlParameter("@UserType", usertype);

        paramList[2] = new SqlParameter("@Name", name);
        paramList[3] = new SqlParameter("@Gender", gender);
        paramList[4] = new SqlParameter("@UserName", UserName);
        paramList[5] = new SqlParameter("@Password", password);
        paramList[6] = new SqlParameter("@DistrictKey", districtkey);
        paramList[7] = new SqlParameter("@MobileNo", mobileno);

        paramList[8] = new SqlParameter("@EmailID", emailid);
        paramList[9] = new SqlParameter("@IsActive", IsActive);
        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "User_Master_DBLayer", paramList);

        if (obj == null)
            return 0;

        return Convert.ToInt64(obj);
    }

    public int ApplicantDetailsExist(Int64 RegistrationKey)
    {

        string sProcName = "ApplicantProfile_DBLayer";
        SqlParameter[] paramList;
        paramList = new SqlParameter[2];
        paramList[0] = new SqlParameter("@QueryType", "SlectUserExist");
        paramList[1] = new SqlParameter("@RegistrationKey", RegistrationKey);

        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, sProcName, paramList);
        if (obj == null)
            return 0;
        else
            return Convert.ToInt32(obj);

    }
    public DataTable GetApplicantUserMaster(int Registrationkey)
    {
        DataTable dt = new DataTable();

        using (var con = new SqlConnection(Constr))
        {
            string query = "SELECT *  from dbo.ApplicantRegistration  UM  where Registrationkey=" + Registrationkey + " ";


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
    public DataTable GetApplicantUserMaster(string username, string password)
    {
        DataTable dt = new DataTable();

        using (var con = new SqlConnection(Constr))
        {
            string query = "SELECT *  from dbo.ApplicantRegistration  UM  where UserName='" + username + "' AND Password='" + password + "'";


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

    public DataTable GetDeptUserMaster(string username, string password)
    {
        DataTable dt = new DataTable();

        using (var con = new SqlConnection(Constr))
        {
            string query = "SELECT Userkey, [Password], UserName, UM.Officekey, UserType, UM.Name, UM.DistrictKey " +
          " from dbo.User_Master  UM  where UserName='" + username + "' AND Password='" + password + "'";


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

    public int UserExistDept(string username, string password)
    {

        if (username == "" && password == "")
            return 4;
        string sProcName = "User_Master_DBLayer";
        SqlParameter[] paramList;
        paramList = new SqlParameter[3];
        paramList[0] = new SqlParameter("@QueryType", "login_check");
        paramList[1] = new SqlParameter("@UserName", username);
        paramList[2] = new SqlParameter("@Password", password);
        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, sProcName, paramList);
        if (obj == null)
            return 0;
        else
            return Convert.ToInt32(obj);

    }

    public int ApplicantExist(string username, string password)
    {

        if (username == "" && password == "")
            return 4;
        string sProcName = "ApplicantRegistration_DBLayer";
        SqlParameter[] paramList;
        paramList = new SqlParameter[3];
        paramList[0] = new SqlParameter("@QueryType", "login_check");
        paramList[1] = new SqlParameter("@UserName", username);
        paramList[2] = new SqlParameter("@Password", password);
        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, sProcName, paramList);
        if (obj == null)
            return 0;
        else
            return Convert.ToInt32(obj);

    }

    public void AwasYojanaDetailsRead(Awayojana objRecord)
    {
        SqlDataReader sqlRdr = null;
        try
        {
            string sProcName = null;
            SqlParameter[] paramList;
            Byte Case;


            sProcName = "AwasYojanaDetails_DBLayer";
            paramList = new SqlParameter[3];
            paramList[0] = new SqlParameter("@QueryType", "SELECTbyUNIQUEKEY");
            paramList[1] = new SqlParameter("@ApplicantName", objRecord.ApplicantName);
            paramList[2] = new SqlParameter("@ApplicantMobileno", objRecord.ApplicantMobileno);
            Case = 2;

            sqlRdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, sProcName, paramList);

            if (sqlRdr.Read())
            {
                objRecord.ApplicantKey = GetInt16(sqlRdr["ApplicantKey"]);

                objRecord.IsActive = GetBoolean(sqlRdr["IsActive"]);

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

    public void DeptRead(ApplicantRegistration objRecord)
    {
        SqlDataReader sqlRdr = null;
        try
        {
            string sProcName = null;
            SqlParameter[] paramList;
            Byte Case;


            sProcName = "User_Master_DBLayer";
            paramList = new SqlParameter[2];
            paramList[0] = new SqlParameter("@QueryType", "SELECTbyUNIQUEKEY");
            paramList[1] = new SqlParameter("@UserName", objRecord.UserName);
            Case = 2;

            sqlRdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, sProcName, paramList);

            if (sqlRdr.Read())
            {
                objRecord.userkey = GetInt64(sqlRdr["userkey"]);

                objRecord.IsActive = GetBoolean(sqlRdr["IsActive"]);

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

  
    public void ReadLogin(ApplicantRegistration objRecord)
    {
        SqlDataReader sqlRdr = null;
        try
        {
            string sProcName = null;
            SqlParameter[] paramList;
            Byte Case;
            if (objRecord.UserName == null)
            {
                return;
            }
            else
            {
                sProcName = "ApplicantRegistration_DBLayer";
                paramList = new SqlParameter[2];
                paramList[0] = new SqlParameter("@QueryType", "LOGINSELECTbyUNIQUEKEY");
                paramList[1] = new SqlParameter("@UserName", objRecord.UserName);
                Case = 2;
            }
            sqlRdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, sProcName, paramList);
            if (sqlRdr.Read())
            {
                objRecord.RegistrationKey = GetInt64(sqlRdr["RegistrationKey"]);
                objRecord.AadharNo = sqlRdr["AadharNo"].ToString();
                objRecord.MobileNo = sqlRdr["MobileNo"].ToString();
                objRecord.Salutation = sqlRdr["Salutation"].ToString();
                objRecord.Name = sqlRdr["Name"].ToString();
                objRecord.UserName = sqlRdr["UserName"].ToString();
                objRecord.Password = sqlRdr["Password"].ToString();
                objRecord.IsActive = GetBoolean(sqlRdr["IsActive"]);
                objRecord.CreatedOn = GetDate(sqlRdr["CreatedOn"]);
                objRecord.PrevPasswords = sqlRdr["PrevPasswords"].ToString();
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

    public void UpdateMobileNo(ApplicantRegistration objApplicant)
    {
        string sProcName = null;
        SqlParameter[] paramList;

        sProcName = "ApplicantRegistration_DBLayer";
        paramList = new SqlParameter[3];
        paramList[0] = new SqlParameter("@QueryType", "CHECKforDuplicate");
        paramList[1] = new SqlParameter("@RegistrationKey", objApplicant.RegistrationKey);
        paramList[2] = new SqlParameter("@UserName", objApplicant.MobileNo);
        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, sProcName, paramList);
        if (obj != null)
            throw new Exception("This Mobile No. already registered.");

        paramList = new SqlParameter[3];

        paramList[0] = new SqlParameter("@QueryType", "UpdateMobileNo");
        paramList[1] = new SqlParameter("@RegistrationKey", objApplicant.RegistrationKey);
        paramList[2] = new SqlParameter("@MobileNo", objApplicant.MobileNo);
        if (SqlHelper.ExecuteNonQuery(Constr, CommandType.StoredProcedure, sProcName, paramList) == 0)
            throw new Exception("Record Not updated due to some error");

    }

    #endregion

    #region Business Logic using Stored Procedure For - ApplicationDetail

    public Int64 CreateApplicationDetail(Int64 RegistrationKey, Int16 AgencyKey, Int16 DistrictKey, Int32 OfficeKey, Int16 Gender, DateTime DOB, Int16 SocialCategory, Int16 SpecialCategory, Int16 Qualification, Int16 WorkExpYear, Int16 WorkExpMonth, String CommunicationHouseNo, String CommunicationVillage, String CommunicationPO, String CommunicationVikasKhand, Int16 CommunicationDistrictKey, String CommunicationPinCode, Int16 UnitLocation, String UnitHouseNo, String UnitVillage, String UnitPO, String UnitVikasKhand, Int16 UnitDistrictKey, String UnitPinCode, String MobileNo1, String MobileNo2, String UnitEast, String UnitWest, String UnitNorth, String UnitSouth, String EMail, String PANNo, Int16 ActivityType, String ActivityName, String ProductDescription, Boolean EDPTraining, String EDPTrainingInstn, Decimal CapitalExpenditure, Decimal WorkingCapital, Int32 Employment, Int16 EmploymentType, Int32 FirstFinancingBankKey, Int64 FirstFinancingBankDetailKey, String FirstFinancingIFSCCode, String FirstFinancingBranchName, String FirstFinancingAddress, String FirstFinancingDistrict, String AlternateFinancingBankName, String AlternateFinancingIFSCCode, bool IsFinalSubmit, Int16 ApplicationStatus, String CSCUserName)
    {
        if (RegistrationKey == 0 || AgencyKey == 0 || DistrictKey == 0)
            return 0;
        SqlParameter[] paramList = new SqlParameter[53];
        paramList[0] = new SqlParameter("@QueryType", "INSERT");
        paramList[1] = new SqlParameter("@RegistrationKey", RegistrationKey);
        paramList[2] = new SqlParameter("@AgencyKey", AgencyKey);
        paramList[3] = new SqlParameter("@DistrictKey", DistrictKey);
        paramList[4] = new SqlParameter("@OfficeKey", OfficeKey);
        paramList[5] = new SqlParameter("@Gender", Gender);
        paramList[6] = new SqlParameter("@DOB", DOB);
        paramList[7] = new SqlParameter("@SocialCategory", SocialCategory);
        paramList[8] = new SqlParameter("@SpecialCategory", SpecialCategory);
        paramList[9] = new SqlParameter("@Qualification", Qualification);
        paramList[10] = new SqlParameter("@WorkExpYear", WorkExpYear);
        paramList[11] = new SqlParameter("@WorkExpMonth", WorkExpMonth);
        //paramList[12] = new SqlParameter("@CommunicationAddress", CommunicationAddress);
        //paramList[13] = new SqlParameter("@CommunicationBlock", CommunicationBlock);
        paramList[12] = new SqlParameter("@CommunicationHouseNo", CommunicationHouseNo);
        paramList[13] = new SqlParameter("@CommunicationVillage", CommunicationVillage);
        paramList[14] = new SqlParameter("@CommunicationPO", CommunicationPO);
        paramList[15] = new SqlParameter("@CommunicationVikasKhand", CommunicationVikasKhand);
        paramList[16] = new SqlParameter("@CommunicationDistrictKey", CommunicationDistrictKey);
        paramList[17] = new SqlParameter("@CommunicationPinCode", CommunicationPinCode);
        paramList[18] = new SqlParameter("@UnitLocation", UnitLocation);
        //paramList[17] = new SqlParameter("@UnitAddress", UnitAddress);
        //paramList[18] = new SqlParameter("@UnitBlock", UnitBlock);
        paramList[19] = new SqlParameter("@UnitHouseNo", UnitHouseNo);
        paramList[20] = new SqlParameter("@UnitVillage", UnitVillage);
        paramList[21] = new SqlParameter("@UnitPO", UnitPO);
        paramList[22] = new SqlParameter("@UnitVikasKhand", UnitVikasKhand);
        paramList[23] = new SqlParameter("@UnitDistrictKey", UnitDistrictKey);
        paramList[24] = new SqlParameter("@UnitPinCode", UnitPinCode);
        paramList[25] = new SqlParameter("@UnitEast", UnitEast);
        paramList[26] = new SqlParameter("@UnitWest", UnitWest);
        paramList[27] = new SqlParameter("@UnitNorth", UnitNorth);
        paramList[28] = new SqlParameter("@UnitSouth", UnitSouth);
        paramList[29] = new SqlParameter("@MobileNo1", MobileNo1);
        paramList[30] = new SqlParameter("@MobileNo2", MobileNo2);
        paramList[31] = new SqlParameter("@EMail", EMail);
        paramList[32] = new SqlParameter("@PANNo", PANNo);
        paramList[33] = new SqlParameter("@ActivityType", ActivityType);
        paramList[34] = new SqlParameter("@ActivityName", ActivityName);
        paramList[35] = new SqlParameter("@ProductDescription", ProductDescription);
        paramList[36] = new SqlParameter("@EDPTraining", EDPTraining);
        paramList[37] = new SqlParameter("@EDPTrainingInstn", EDPTrainingInstn);
        paramList[38] = new SqlParameter("@CapitalExpenditure", CapitalExpenditure);

        paramList[39] = new SqlParameter("@WorkingCapital", WorkingCapital);
        paramList[40] = new SqlParameter("@Employment", Employment);
        paramList[41] = new SqlParameter("@EmploymentType", EmploymentType);
        paramList[42] = new SqlParameter("@FirstFinancingBankKey", FirstFinancingBankKey);
        paramList[43] = new SqlParameter("@FirstFinancingBankDetailKey", FirstFinancingBankDetailKey);
        paramList[44] = new SqlParameter("@FirstFinancingIFSCCode", FirstFinancingIFSCCode);
        paramList[45] = new SqlParameter("@FirstFinancingBranchName", FirstFinancingBranchName);
        paramList[46] = new SqlParameter("@FirstFinancingAddress", FirstFinancingAddress);
        paramList[47] = new SqlParameter("@FirstFinancingDistrict", FirstFinancingDistrict);
        paramList[48] = new SqlParameter("@AlternateFinancingBankName", AlternateFinancingBankName);
        paramList[49] = new SqlParameter("@AlternateFinancingIFSCCode", AlternateFinancingIFSCCode);

        paramList[50] = new SqlParameter("@IsFinalSubmit", IsFinalSubmit);
        paramList[51] = new SqlParameter("@ApplicationStatus", ApplicationStatus);
        paramList[52] = new SqlParameter("@CSCUserName", CSCUserName);
        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "ApplicationDetail_DBLayer", paramList);

        if (obj == null)
            return 0;

        return Convert.ToInt64(obj);
    }


    public void Update(ApplicationDetail objApplicationDetail, string UserLevel = null)
    {
        string sProcName = null;
        SqlParameter[] paramList;

        sProcName = "ApplicationDetail_DBLayer";
        paramList = new SqlParameter[3];
        paramList[0] = new SqlParameter("@QueryType", "CHECKforDuplicate");
        paramList[1] = new SqlParameter("@RegistrationKey", objApplicationDetail.RegistrationKey);
        paramList[2] = new SqlParameter("@ApplicationKey", objApplicationDetail.ApplicationKey);
        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, sProcName, paramList);
        if (obj != null)
            throw new Exception("Application already exists.");
        if (String.IsNullOrEmpty(UserLevel) || UserLevel == "DVIO")
        {
            paramList = new SqlParameter[45];
            if (String.IsNullOrEmpty(UserLevel))
                paramList[0] = new SqlParameter("@QueryType", "UPDATE");
            else if (UserLevel == "DVIO")
                paramList[0] = new SqlParameter("@QueryType", "UPDATEDVIO");
            paramList[1] = new SqlParameter("@AgencyKey", objApplicationDetail.AgencyKey);
            paramList[2] = new SqlParameter("@DistrictKey", objApplicationDetail.DistrictKey);
            paramList[3] = new SqlParameter("@OfficeKey", objApplicationDetail.OfficeKey);
            paramList[4] = new SqlParameter("@Gender", objApplicationDetail.Gender);
            paramList[5] = new SqlParameter("@DOB", objApplicationDetail.DOB);
            paramList[6] = new SqlParameter("@SocialCategory", objApplicationDetail.SocialCategory);
            paramList[7] = new SqlParameter("@SpecialCategory", objApplicationDetail.SpecialCategory);
            paramList[8] = new SqlParameter("@Qualification", objApplicationDetail.Qualification);
            paramList[9] = new SqlParameter("@WorkExpYear", objApplicationDetail.WorkExpYear);
            paramList[10] = new SqlParameter("@WorkExpMonth", objApplicationDetail.WorkExpMonth);
            //paramList[11] = new SqlParameter("@CommunicationAddress", objApplicationDetail.CommunicationAddress);
            //paramList[12] = new SqlParameter("@CommunicationBlock", objApplicationDetail.CommunicationBlock);
            paramList[11] = new SqlParameter("@CommunicationHouseNo", objApplicationDetail.CommunicationHouseNo);
            paramList[12] = new SqlParameter("@CommunicationVillage", objApplicationDetail.CommunicationVillage);
            paramList[13] = new SqlParameter("@CommunicationPO", objApplicationDetail.CommunicationPO);
            paramList[14] = new SqlParameter("@CommunicationVikasKhand", objApplicationDetail.CommunicationVikasKhand);
            paramList[15] = new SqlParameter("@CommunicationDistrictKey", objApplicationDetail.CommunicationDistrictKey);
            paramList[16] = new SqlParameter("@CommunicationPinCode", objApplicationDetail.CommunicationPinCode);
            paramList[17] = new SqlParameter("@UnitLocation", objApplicationDetail.UnitLocation);
            //paramList[16] = new SqlParameter("@UnitAddress", objApplicationDetail.UnitAddress);
            //paramList[17] = new SqlParameter("@UnitBlock", objApplicationDetail.UnitBlock);
            paramList[18] = new SqlParameter("@UnitHouseNo", objApplicationDetail.UnitHouseNo);
            paramList[19] = new SqlParameter("@UnitVillage", objApplicationDetail.UnitVillage);
            paramList[20] = new SqlParameter("@UnitPO", objApplicationDetail.UnitPO);
            paramList[21] = new SqlParameter("@UnitVikasKhand", objApplicationDetail.UnitVikasKhand);
            paramList[22] = new SqlParameter("@UnitDistrictKey", objApplicationDetail.UnitDistrictKey);
            paramList[23] = new SqlParameter("@UnitPinCode", objApplicationDetail.UnitPinCode);
            paramList[24] = new SqlParameter("@UnitEast", objApplicationDetail.UnitEast);
            paramList[25] = new SqlParameter("@UnitWest", objApplicationDetail.UnitWest);
            paramList[26] = new SqlParameter("@UnitNorth", objApplicationDetail.UnitNorth);
            paramList[27] = new SqlParameter("@UnitSouth", objApplicationDetail.UnitSouth);
            paramList[28] = new SqlParameter("@MobileNo1", objApplicationDetail.MobileNo1);
            paramList[29] = new SqlParameter("@MobileNo2", objApplicationDetail.MobileNo2);
            paramList[30] = new SqlParameter("@EMail", objApplicationDetail.EMail);
            paramList[31] = new SqlParameter("@PANNo", objApplicationDetail.PANNo);
            paramList[32] = new SqlParameter("@ActivityType", objApplicationDetail.ActivityType);
            paramList[33] = new SqlParameter("@ActivityName", objApplicationDetail.ActivityName);
            paramList[34] = new SqlParameter("@ProductDescription", objApplicationDetail.ProductDescription);
            paramList[35] = new SqlParameter("@EDPTraining", objApplicationDetail.EDPTraining);
            paramList[36] = new SqlParameter("@EDPTrainingInstn", objApplicationDetail.EDPTrainingInstn);
            paramList[37] = new SqlParameter("@CapitalExpenditure", objApplicationDetail.CapitalExpenditure);
            paramList[38] = new SqlParameter("@WorkingCapital", objApplicationDetail.WorkingCapital);
            paramList[39] = new SqlParameter("@Employment", objApplicationDetail.Employment);
            paramList[40] = new SqlParameter("@EmploymentType", objApplicationDetail.EmploymentType);
            paramList[41] = new SqlParameter("@FirstFinancingBankKey", objApplicationDetail.FirstFinancingBankKey);
            paramList[42] = new SqlParameter("@FirstFinancingBankDetailKey", objApplicationDetail.FirstFinancingBankDetailKey);
            paramList[43] = new SqlParameter("@ApplicationKey", objApplicationDetail.ApplicationKey);
            paramList[44] = new SqlParameter("@ApplicantName", objApplicationDetail.ApplicantName);
        }
        else if (UserLevel == "DLSC")
        {
            paramList = new SqlParameter[4];

            paramList[0] = new SqlParameter("@QueryType", "UPDATEDLSC");
            paramList[1] = new SqlParameter("@ApprovedCapitalExpenditure", objApplicationDetail.ApprovedCapitalExpenditure);
            paramList[2] = new SqlParameter("@ApprovedWorkingCapital", objApplicationDetail.ApprovedWorkingCapital);
            paramList[3] = new SqlParameter("@ApplicationKey", objApplicationDetail.ApplicationKey);
        }
        if (SqlHelper.ExecuteNonQuery(Constr, CommandType.StoredProcedure, sProcName, paramList) == 0)
            throw new Exception("Record Not updated due to some error");

    }

    public void BankReforward(ApplicationDetail objApplicationDetail, Int32 UserKey)
    {
        string sProcName = null;
        SqlParameter[] paramList;

        sProcName = "ApplicationDetail_DBLayer";
        paramList = new SqlParameter[4];
        paramList[0] = new SqlParameter("@QueryType", "CHECKforDuplicate");
        paramList[1] = new SqlParameter("@RegistrationKey", objApplicationDetail.RegistrationKey);
        paramList[2] = new SqlParameter("@ApplicationKey", objApplicationDetail.ApplicationKey);
        paramList[3] = new SqlParameter("@UserKey", UserKey);
        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, sProcName, paramList);
        if (obj != null)
            throw new Exception("Application already exists.");

        paramList = new SqlParameter[3];

        paramList[0] = new SqlParameter("@QueryType", "BankReforward");
        paramList[1] = new SqlParameter("@FirstFinancingBankDetailKey", objApplicationDetail.FirstFinancingBankDetailKey);
        paramList[2] = new SqlParameter("@ApplicationKey", objApplicationDetail.ApplicationKey);
        if (SqlHelper.ExecuteNonQuery(Constr, CommandType.StoredProcedure, sProcName, paramList) == 0)
            throw new Exception("Record Not updated due to some error");

    }

    public void ApplicationReturn(ApplicationDetail objApplicationDetail, Int32 UserKey)
    {
        string sProcName = null;
        SqlParameter[] paramList;

        sProcName = "ApplicationDetail_DBLayer";
        paramList = new SqlParameter[4];
        paramList[0] = new SqlParameter("@QueryType", "CHECKforDuplicate");
        paramList[1] = new SqlParameter("@RegistrationKey", objApplicationDetail.RegistrationKey);
        paramList[2] = new SqlParameter("@ApplicationKey", objApplicationDetail.ApplicationKey);
        paramList[3] = new SqlParameter("@UserKey", UserKey);
        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, sProcName, paramList);
        if (obj != null)
            throw new Exception("Application already exists.");

        paramList = new SqlParameter[2];

        paramList[0] = new SqlParameter("@QueryType", "ApplicationReturn");
        paramList[1] = new SqlParameter("@ApplicationKey", objApplicationDetail.ApplicationKey);
        if (SqlHelper.ExecuteNonQuery(Constr, CommandType.StoredProcedure, sProcName, paramList) == 0)
            throw new Exception("Record Not updated due to some error");

    }

    public string FinalSubmitApplication(Int64 ApplicationKey)
    {
        if (ApplicationKey == 0)
            return "";
        SqlParameter[] paramList = new SqlParameter[2];
        paramList[0] = new SqlParameter("@QueryType", "FinalSubmitApplication");
        paramList[1] = new SqlParameter("@ApplicationKey", ApplicationKey);
        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "ApplicationDetail_DBLayer", paramList);
        if (obj == null)
            return "";

        return obj.ToString();
    }



    #endregion

    #region Business Logic using Stored Procedure For - DocumentsDetail

    public Int64 CreateDocumentsDetail(Int64 RegistrationKey, Int64 ApplicationKey, string XML)
    {
        if (ApplicationKey == 0)
            return 0;
        SqlParameter[] paramList = new SqlParameter[4];
        paramList[0] = new SqlParameter("@QueryType", "INSERT");
        paramList[1] = new SqlParameter("@RegistrationKey", RegistrationKey);
        paramList[2] = new SqlParameter("@ApplicationKey", ApplicationKey);
        paramList[3] = new SqlParameter("@XML", XML);
        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "ApplicantScheme_DocumentsDetail_DBLayer", paramList);

        if (obj == null)
            return 0;

        return Convert.ToInt64(obj);
    }

    //public List<DocumentsDetail> Read(DocumentsDetail objRecord)
    //{
    //    SqlDataReader sqlRdr = null;
    //    List<DocumentsDetail> lstDoc = new List<DocumentsDetail>();
    //    try
    //    {

    //        string sProcName = null;
    //        SqlParameter[] paramList;
    //        if (objRecord.DocumentKey > 0)
    //        {
    //            sProcName = "DocumentsDetail_DBLayer";
    //            paramList = new SqlParameter[2];
    //            paramList[0] = new SqlParameter("@QueryType", "SELECTbyPRIMARYKEY");
    //            paramList[1] = new SqlParameter("@DocumentKey", objRecord.DocumentKey);


    //            //paramList[0] = new SqlParameter("@QueryType", "SELECTbySignature");
    //            //paramList[1] = new SqlParameter("@DocumentKey", objRecord.DocumentKey);
    //        }
    //        else 
    //        {
    //            sProcName = "DocumentsDetail_DBLayer";
    //            paramList = new SqlParameter[2];
    //            paramList[0] = new SqlParameter("@QueryType", "SELECTbyUNIQUEKEY");
    //            paramList[1] = new SqlParameter("@ApplicationKey", objRecord.ApplicationKey);
    //        }


    //        sqlRdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, sProcName, paramList);
    //        while (sqlRdr.Read())
    //        {
    //            DocumentsDetail obj = new DocumentsDetail();
    //            obj.DocumentDetailKey = GetInt64(sqlRdr["DocumentDetailKey"]);
    //            obj.DocumentKey = GetInt64(sqlRdr["DocumentKey"]);
    //            obj.ApplicationKey = GetInt64(sqlRdr["ApplicationKey"]);
    //            obj.RegistrationKey = GetInt64(sqlRdr["RegistrationKey"]);
    //            obj.DocumentTitle = sqlRdr["DocumentTitle"].ToString();
    //            obj.FileName = sqlRdr["FileName"].ToString();
    //            obj.MaxSize = GetInt32(sqlRdr["MaxSize"]);
    //            obj.isRequired = GetBoolean(sqlRdr["isRequired"]);
    //            obj.forAllCaste = GetBoolean(sqlRdr["forAllCaste"]);
    //            obj.AllowedFormats = sqlRdr["AllowedFormats"].ToString();
    //            obj.Remark = sqlRdr["Remark"].ToString();
    //            obj.CreatedOn = GetDate(sqlRdr["CreatedOn"]);
    //            obj.LastModifiedOn = GetDate(sqlRdr["LastModifiedOn"]);

    //            lstDoc.Add(obj);
    //        }
    //    }
    //    finally
    //    {
    //        if (sqlRdr != null)
    //            sqlRdr.Close();
    //    }
    //    return lstDoc;
    //}

    #endregion

    #region Business Logic using Stored Procedure For - StatusDetail

    public Int64 CreateStatusDetail(Int64 ApplicationNo, Int32 StatusKey, string Remark, Int32 CreatedBy, DateTime? DocReceiveDate = null)
    {
        if (ApplicationNo == 0 || StatusKey == 0)
            return 0;
        SqlParameter[] paramList = new SqlParameter[6];
        paramList[0] = new SqlParameter("@QueryType", "INSERT");
        paramList[1] = new SqlParameter("@ApplicationNo", ApplicationNo);
        paramList[2] = new SqlParameter("@StatusKey", StatusKey);
        paramList[3] = new SqlParameter("@Remark", Remark);
        paramList[4] = new SqlParameter("@ActionBy", CreatedBy);
        if (DocReceiveDate.HasValue)
            paramList[5] = new SqlParameter("@DocReceiveDate", DocReceiveDate);
        else
            paramList[5] = new SqlParameter("@DocReceiveDate", DBNull.Value);
        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "StatusDetail_DBLayer", paramList);

        if (obj == null)
            return 0;

        return Convert.ToInt64(obj);
    }

    public Int64 CreateStatusDetail(Int64 ApplicationKey, Int32 StatusKey, string Remark, Int32 CreatedBy, Int16 MeetingStatus)
    {
        if (ApplicationKey == 0 || StatusKey == 0)
            return 0;
        SqlParameter[] paramList = new SqlParameter[6];
        paramList[0] = new SqlParameter("@QueryType", "INSERTWithMEETINGUPDATE");
        paramList[1] = new SqlParameter("@ApplicationKey", ApplicationKey);
        paramList[2] = new SqlParameter("@StatusKey", StatusKey);
        paramList[3] = new SqlParameter("@Remark", Remark);
        paramList[4] = new SqlParameter("@ActionBy", CreatedBy);
        paramList[5] = new SqlParameter("@MeetingStatus", MeetingStatus);
        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "StatusDetail_DBLayer", paramList);

        if (obj == null)
            return 0;

        return Convert.ToInt64(obj);
    }

    public Int64 CreateStatusDetail(string XML)
    {
        if (String.IsNullOrEmpty(XML))
            return 0;
        SqlParameter[] paramList = new SqlParameter[2];
        paramList[0] = new SqlParameter("@QueryType", "INSERTXML");
        paramList[1] = new SqlParameter("@XML", XML);
        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "StatusDetail_DBLayer", paramList);

        if (obj == null)
            return 0;

        return Convert.ToInt64(obj);
    }

    public Int64 updatecheckstatus(int applicationno, int flag)
    {
        if (applicationno == 0 || flag == 0)
            return 0;
        SqlParameter[] paramList = new SqlParameter[3];
        paramList[0] = new SqlParameter("@QueryType", "UpdateDistrictstatusflag");
        paramList[1] = new SqlParameter("@ApplicationNo", applicationno);
        paramList[2] = new SqlParameter("@District_Flag", flag);
        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "ApplicantSchemeRegistration_DBLayer", paramList);

        if (obj == null)
            return 0;

        return Convert.ToInt64(obj);
    }


    public Int64 CreateStatusDetail(Int64 ApplicationKey, Int32 StatusKey, Int32 CreatedBy, bool isCGTMSCovered, decimal SanctionTAmount, DateTime SanctionDate, decimal OwnContriPerc, string Remark, string XMLSanction, DateTime? DocReceiveDate = null)
    {
        if (ApplicationKey == 0 || StatusKey == 0)
            return 0;
        SqlParameter[] paramList = new SqlParameter[11];
        paramList[0] = new SqlParameter("@QueryType", "INSERTWithLOANSANCTION");
        paramList[1] = new SqlParameter("@ApplicationKey", ApplicationKey);
        paramList[2] = new SqlParameter("@StatusKey", StatusKey);
        paramList[3] = new SqlParameter("@isCGTMSCovered", isCGTMSCovered);
        paramList[4] = new SqlParameter("@SanctionTAmount", SanctionTAmount);
        paramList[5] = new SqlParameter("@SanctionDate", SanctionDate);
        paramList[6] = new SqlParameter("@OwnContriPerc", OwnContriPerc);
        paramList[7] = new SqlParameter("@Remark", Remark);
        paramList[8] = new SqlParameter("@XMLSanction", XMLSanction);
        paramList[9] = new SqlParameter("@ActionBy", CreatedBy);
        if (DocReceiveDate.HasValue)
            paramList[10] = new SqlParameter("@DocReceiveDate", DocReceiveDate);
        else
            paramList[10] = new SqlParameter("@DocReceiveDate", DBNull.Value);
        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "StatusDetail_DBLayer", paramList);

        if (obj == null)
            return 0;

        return Convert.ToInt64(obj);
    }

    public DataSet GET_ApplicationList(Int32 districtKey, string FinYear="", Int32 SchemeTypeKey = 0, Int32 SchemeKey = 0, Int32 CurStatus = 0, string AppCode="", string FromDate ="",string ToDate ="")
    {
        DataSet ds = new DataSet();
        string _proc = "APT_SchemeRegistration_DBLayer";
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@QueryType", "GET_ApplicationList");
        if (districtKey > 0)
            param[1] = new SqlParameter("@DistrictKey", districtKey);
        else
            param[1] = new SqlParameter("@DistrictKey", DBNull.Value);
        ds = SqlHelper.ExecuteDataset(Constr, CommandType.StoredProcedure, _proc, param);
        return ds;
    }

    public DataTable GET_ApplicationForHO(string FinYear)
    {
        try
        {
            DataTable dt = new DataTable();
            string _proc = "APT_SchemeRegistration_DBLayer";
            SqlParameter[] param = new SqlParameter[2];

            if (FinYear != "")
            {
                param[0] = new SqlParameter("@QueryType", "GET_ApplicationList_HO");
                param[1] = new SqlParameter("@FinYear", FinYear);
                dt = SqlHelper.ExecuteDataset(Constr, CommandType.StoredProcedure, _proc, param).Tables[0];
            }
            return dt;
        }
        catch (Exception)
        {

            throw;
        }

    }

    public DataSet GET_ApplicationList_Scheme(Int16 registrationkey)
    {
        DataSet ds = new DataSet();
        string _proc = "[ApplicantSchemeRegistration_DBLayer]";
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@QueryType", "SelectApplicantView");
        if (registrationkey > 0)
            param[1] = new SqlParameter("@registrationkey", registrationkey);

        ds = SqlHelper.ExecuteDataset(Constr, CommandType.StoredProcedure, _proc, param);
        return ds;
    }
    public DataSet GET_ApplicationList_DIVISON(Int16 divisionkey)
    {
        DataSet ds = new DataSet();
        string _proc = "StatusDetail_DBLayer";
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@QueryType", "GET_ApplicationList_DIVISON");
        if (divisionkey > 0)
            param[1] = new SqlParameter("@DivisionId", divisionkey);
        else
            param[1] = new SqlParameter("@DivisionId", DBNull.Value);
        ds = SqlHelper.ExecuteDataset(Constr, CommandType.StoredProcedure, _proc, param);
        return ds;
    }
    public DataSet GET_ApplicationList_DVIOSearh(Int16 districtKey, Int16 schemeKey, Int16 StatusKey, DateTime frmdate, DateTime todate)
    {
        DataSet ds = new DataSet();
        string _proc = "StatusDetail_DBLayer";
        SqlParameter[] param = new SqlParameter[6];
        param[0] = new SqlParameter("@QueryType", "GET_ApplicationList_DVIO_Search");
        if (districtKey > 0)
            param[1] = new SqlParameter("@DistrictKey", districtKey);
        else
            param[1] = new SqlParameter("@DistrictKey", DBNull.Value);
        if (schemeKey > 0)
            param[2] = new SqlParameter("@SchemeKey", schemeKey);
        else
            param[2] = new SqlParameter("@SchemeKey", DBNull.Value);
        if (StatusKey > 0)
            param[3] = new SqlParameter("@StatusKey", StatusKey);
        else
            param[3] = new SqlParameter("@StatusKey", DBNull.Value);
        if (frmdate.Date == Convert.ToDateTime("1-1-0001"))
        {
            param[4] = new SqlParameter("@fromdate", DBNull.Value);
        }
        else
            param[4] = new SqlParameter("@fromdate", frmdate);

        if (todate.Date == Convert.ToDateTime("1-1-0001"))
        {
            param[5] = new SqlParameter("@todate", DBNull.Value);
        }
        else
            param[5] = new SqlParameter("@todate", todate);

        ds = SqlHelper.ExecuteDataset(Constr, CommandType.StoredProcedure, _proc, param);
        return ds;
    }

    public DataSet GET_ApplicationList_DIVIOSONSearh(Int16 districtKey, Int16 schemeKey, Int16 StatusKey, DateTime frmdate, DateTime todate)
    {
        DataSet ds = new DataSet();
        string _proc = "StatusDetail_DBLayer";
        SqlParameter[] param = new SqlParameter[6];
        param[0] = new SqlParameter("@QueryType", "GET_ApplicationList_DIVISON_Search");
        if (districtKey > 0)
            param[1] = new SqlParameter("@DistrictKey", districtKey);
        else
            param[1] = new SqlParameter("@DistrictKey", DBNull.Value);
        if (schemeKey > 0)
            param[2] = new SqlParameter("@SchemeKey", schemeKey);
        else
            param[2] = new SqlParameter("@SchemeKey", DBNull.Value);
        if (StatusKey > 0)
            param[3] = new SqlParameter("@StatusKey", StatusKey);
        else
            param[3] = new SqlParameter("@StatusKey", DBNull.Value);
        if (frmdate.Date == Convert.ToDateTime("1-1-0001"))
        {
            param[4] = new SqlParameter("@fromdate", DBNull.Value);
        }
        else
            param[4] = new SqlParameter("@fromdate", frmdate);

        if (todate.Date == Convert.ToDateTime("1-1-0001"))
        {
            param[5] = new SqlParameter("@todate", DBNull.Value);
        }
        else
            param[5] = new SqlParameter("@todate", todate);

        ds = SqlHelper.ExecuteDataset(Constr, CommandType.StoredProcedure, _proc, param);
        return ds;
    }
    public DataSet GET_Assign_MeetingList(Int16 districtKey)
    {
        DataSet ds = new DataSet();
        string _proc = "StatusDetail_DBLayer";
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@QueryType", "GET_Assign_MeetingList");
        if (districtKey > 0)
            param[1] = new SqlParameter("@DistrictKey", districtKey);
        else
            param[1] = new SqlParameter("@DistrictKey", DBNull.Value);
        ds = SqlHelper.ExecuteDataset(Constr, CommandType.StoredProcedure, _proc, param);
        return ds;
    }

    public DataSet GET_ApplicantList_MeetingWise(Int64 MeetingKey)
    {
        DataSet ds = new DataSet();
        string _proc = "StatusDetail_DBLayer";
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@QueryType", "ApplicantList_MeetingWise");
        //if (districtKey > 0)
        //    param[1] = new SqlParameter("@DistrictKey", districtKey);
        //else
        //    param[1] = new SqlParameter("@DistrictKey", DBNull.Value);
        if (MeetingKey > 0)
            param[1] = new SqlParameter("@MeetingKey", MeetingKey);
        else
            param[1] = new SqlParameter("@MeetingKey", DBNull.Value);
        ds = SqlHelper.ExecuteDataset(Constr, CommandType.StoredProcedure, _proc, param);
        return ds;
    }


    //Rejected


    public DataSet GET_ApplicantList_MeetingWiseRejected(Int64 MeetingKey)
    {
        DataSet ds = new DataSet();
        string _proc = "StatusDetail_DBLayer";
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@QueryType", "ApplicantList_MeetingWiseRejected");
        //if (districtKey > 0)
        //    param[1] = new SqlParameter("@DistrictKey", districtKey);
        //else
        //    param[1] = new SqlParameter("@DistrictKey", DBNull.Value);
        if (MeetingKey > 0)
            param[1] = new SqlParameter("@MeetingKey", MeetingKey);
        else
            param[1] = new SqlParameter("@MeetingKey", DBNull.Value);
        ds = SqlHelper.ExecuteDataset(Constr, CommandType.StoredProcedure, _proc, param);
        return ds;
    }

    public DataSet GET_ApplicantList_MeetingWiseApproved(Int64 MeetingKey)
    {
        DataSet ds = new DataSet();
        string _proc = "StatusDetail_DBLayer";
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@QueryType", "ApplicantList_MeetingWiseApproved");
        //if (districtKey > 0)
        //    param[1] = new SqlParameter("@DistrictKey", districtKey);
        //else
        //    param[1] = new SqlParameter("@DistrictKey", DBNull.Value);
        if (MeetingKey > 0)
            param[1] = new SqlParameter("@MeetingKey", MeetingKey);
        else
            param[1] = new SqlParameter("@MeetingKey", DBNull.Value);
        ds = SqlHelper.ExecuteDataset(Constr, CommandType.StoredProcedure, _proc, param);
        return ds;
    }


    public DataSet GET_ApplicationList_DLSC(Int16 districtKey, Int64 meetingkey = 0)
    {
        DataSet ds = new DataSet();
        string _proc = "StatusDetail_DBLayer";
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@QueryType", "GET_ApplicationList_DLSC");
        if (districtKey > 0)
            param[1] = new SqlParameter("@DistrictKey", districtKey);
        else
            param[1] = new SqlParameter("@DistrictKey", DBNull.Value);
        if (meetingkey > 0)
            param[2] = new SqlParameter("@MeetingKey", meetingkey);
        else
            param[2] = new SqlParameter("@MeetingKey", DBNull.Value);
        ds = SqlHelper.ExecuteDataset(Constr, CommandType.StoredProcedure, _proc, param);
        return ds;
    }

    public DataSet GET_ApplicationList_BANK(Int32 officeKey)
    {
        DataSet ds = new DataSet();
        string _proc = "StatusDetail_DBLayer";
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@QueryType", "GET_ApplicationList_BANK");
        if (officeKey > 0)
            param[1] = new SqlParameter("@officeKey", officeKey);
        else
            param[1] = new SqlParameter("@officeKey", DBNull.Value);
        ds = SqlHelper.ExecuteDataset(Constr, CommandType.StoredProcedure, _proc, param);
        return ds;
    }

    public DataSet GET_BANK_RejectionList(Int16 districtKey)
    {
        DataSet ds = new DataSet();
        string _proc = "StatusDetail_DBLayer";
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@QueryType", "GET_BANK_RejectionList");
        if (districtKey > 0)
            param[1] = new SqlParameter("@DistrictKey", districtKey);
        else
            param[1] = new SqlParameter("@DistrictKey", DBNull.Value);
        ds = SqlHelper.ExecuteDataset(Constr, CommandType.StoredProcedure, _proc, param);
        return ds;
    }

    public DataSet GET_ApplicationList_ZO(Int16 divisionKey)
    {
        DataSet ds = new DataSet();
        string _proc = "StatusDetail_DBLayer";
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@QueryType", "GET_ApplicationList_ZO");
        if (divisionKey > 0)
            param[1] = new SqlParameter("@DivisionId", divisionKey);
        else
            param[1] = new SqlParameter("@DivisionId", DBNull.Value);
        ds = SqlHelper.ExecuteDataset(Constr, CommandType.StoredProcedure, _proc, param);
        return ds;
    }

    #endregion

    #region Business Logic using Stored Procedure For - GrievanceDetail

    public string CreateGrievanceDetail(Int64 RegistrationKey, Int16 DistrictKey, Int32 OfficeKey, string GrievanceDescription, string Attachment, Boolean NotifybyEmail, Boolean NotifybySMS, Int16 GrievanceStatus)
    {
        if (RegistrationKey == 0 || DistrictKey == 0 || OfficeKey == 0 || String.IsNullOrEmpty(GrievanceDescription))
            return "";
        SqlParameter[] paramList = new SqlParameter[9];
        paramList[0] = new SqlParameter("@QueryType", "INSERT");
        paramList[1] = new SqlParameter("@RegistrationKey", RegistrationKey);
        paramList[2] = new SqlParameter("@DistrictKey", DistrictKey);
        paramList[3] = new SqlParameter("@OfficeKey", OfficeKey);
        paramList[4] = new SqlParameter("@GrievanceDescription", GrievanceDescription);
        paramList[5] = new SqlParameter("@Attachment", Attachment);
        paramList[6] = new SqlParameter("@NotifybyEmail", NotifybyEmail);
        paramList[7] = new SqlParameter("@NotifybySMS", NotifybySMS);
        paramList[8] = new SqlParameter("@GrievanceStatus", GrievanceStatus);
        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "GrievanceDetail_DBLayer", paramList);

        if (obj == null)
            return "";

        return obj.ToString();
    }

    //public void Update(GrievanceDetail objGrievanceDetail)
    //{
    //    string sProcName = null;
    //    SqlParameter[] paramList;

    //    sProcName = "GrievanceDetail_DBLayer";

    //    paramList = new SqlParameter[5];

    //    paramList[0] = new SqlParameter("@QueryType", "UPDATE");
    //    paramList[1] = new SqlParameter("@GrievanceStatus", objGrievanceDetail.GrievanceStatus);
    //    paramList[2] = new SqlParameter("@Reply", objGrievanceDetail.Reply);
    //    paramList[3] = new SqlParameter("@ReplyBy", objGrievanceDetail.ReplyBy);
    //    paramList[4] = new SqlParameter("@GrievanceKey", objGrievanceDetail.GrievanceKey);

    //    if (SqlHelper.ExecuteNonQuery(Constr, CommandType.StoredProcedure, sProcName, paramList) == 0)
    //        throw new Exception("Record Not updated due to some error");

    //}

    //public void Read(GrievanceDetail objRecord)
    //{
    //    SqlDataReader sqlRdr = null;
    //    try
    //    {
    //        string sProcName = null;
    //        SqlParameter[] paramList;
    //        Byte Case;
    //        sProcName = "GrievanceDetail_DBLayer";
    //        paramList = new SqlParameter[2];
    //        paramList[0] = new SqlParameter("@QueryType", "SELECTbyPRIMARYKEY");
    //        paramList[1] = new SqlParameter("@GrievanceKey", objRecord.GrievanceKey);

    //        sqlRdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, sProcName, paramList);
    //        if (sqlRdr.Read())
    //        {
    //            objRecord.GrievanceKey = GetInt64(sqlRdr["GrievanceKey"]);
    //            objRecord.GrievanceNo = sqlRdr["GrievanceNo"].ToString();
    //            objRecord.RegistrationKey = GetInt64(sqlRdr["RegistrationKey"]);
    //            objRecord.ApplicantName = sqlRdr["ApplicantName"].ToString();
    //            objRecord.Mobile = sqlRdr["MobileNo"].ToString();
    //            objRecord.DistrictKey = GetInt16(sqlRdr["DistrictKey"]);
    //            objRecord.OfficeKey = GetInt32(sqlRdr["OfficeKey"]);
    //            objRecord.GrievanceDescription = sqlRdr["GrievanceDescription"].ToString();
    //            objRecord.Attachment = sqlRdr["Attachment"].ToString();

    //            objRecord.NotifybyEmail = GetBoolean(sqlRdr["NotifybyEmail"]);
    //            objRecord.NotifybySMS = GetBoolean(sqlRdr["NotifybySMS"]);
    //            objRecord.GrievanceDate = GetDate(sqlRdr["GrievanceDate"]);
    //            objRecord.GrievanceStatus = GetInt16(sqlRdr["GrievanceStatus"]);
    //            objRecord.Reply = sqlRdr["Reply"].ToString();
    //            objRecord.ReplyDate = GetDate(sqlRdr["ReplyDate"]);
    //            objRecord.ReplyBy = GetInt16(sqlRdr["ReplyBy"]);
    //        }
    //        else
    //        {
    //            objRecord.GrievanceKey = 0;
    //        }
    //    }
    //    finally
    //    {
    //        if (sqlRdr != null)
    //            sqlRdr.Close();
    //    }
    //}

    //public List<GrievanceDetail> ReadAllGrievanceDetail(Int64 RegistrationKey = 0, Int16 DistrictKey = 0)
    //{
    //    List<GrievanceDetail> lstGrievanceDetail = new List<GrievanceDetail>();
    //    SqlDataReader sqlRdr = null;
    //    try
    //    {
    //        string sProcName = "GrievanceDetail_DBLayer";
    //        SqlParameter[] paramList;

    //        paramList = new SqlParameter[3];
    //        paramList[0] = new SqlParameter("@QueryType", "READALL");
    //        if (RegistrationKey > 0)
    //            paramList[1] = new SqlParameter("@RegistrationKey", RegistrationKey);
    //        else
    //            paramList[1] = new SqlParameter("@RegistrationKey", DBNull.Value);
    //        if (DistrictKey > 0)
    //            paramList[2] = new SqlParameter("@DistrictKey", DistrictKey);
    //        else
    //            paramList[2] = new SqlParameter("@DistrictKey", DBNull.Value);
    //        sqlRdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, sProcName, paramList);
    //        while (sqlRdr.Read())
    //        {
    //            GrievanceDetail obj = new GrievanceDetail();
    //            obj.GrievanceKey = GetInt64(sqlRdr["GrievanceKey"]);
    //            obj.GrievanceNo = sqlRdr["GrievanceNo"].ToString();
    //            obj.RegistrationKey = GetInt64(sqlRdr["RegistrationKey"]);
    //            obj.ApplicantName = sqlRdr["Name"].ToString();
    //            obj.DistrictKey = GetInt16(sqlRdr["DistrictKey"]);
    //            obj.OfficeKey = GetInt32(sqlRdr["OfficeKey"]);
    //            obj.GrievanceDescription = sqlRdr["GrievanceDescription"].ToString();
    //            obj.Attachment = sqlRdr["Attachment"].ToString();
    //            obj.NotifybyEmail = GetBoolean(sqlRdr["NotifybyEmail"]);
    //            obj.NotifybySMS = GetBoolean(sqlRdr["NotifybySMS"]);
    //            obj.GrievanceDate = GetDate(sqlRdr["GrievanceDate"]);
    //            obj.GrievanceStatus = GetInt16(sqlRdr["GrievanceStatus"]);
    //            obj.Reply = sqlRdr["Reply"].ToString();
    //            obj.ReplyDate = GetDate(sqlRdr["ReplyDate"]);
    //            obj.ReplyBy = GetInt32(sqlRdr["ReplyBy"]);

    //            lstGrievanceDetail.Add(obj);

    //        }
    //    }
    //    finally
    //    {
    //        if (sqlRdr != null)
    //            sqlRdr.Close();
    //    }
    //    return lstGrievanceDetail;
    //}

    #endregion
}
