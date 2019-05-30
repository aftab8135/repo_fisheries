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
    
    #region Business Logic using Stored Procedure For - Candidate Registration



    public int CreateCandidate(string RegistrationNo, int RegistrationType, Int32 propertykey, Int32 schemekey, Int32 sectorkey, string allotmentno, string UserName, string Password, string FullName, string AadharNo, string CurrentAddress, string PostalAddress, string PinCode, string MobileNo, string EmailId, DateTime DateOfBirth, string PanNo, int createdby, bool isactive, bool isonline, string fatherName, string city, int districtkey, int statekey, int postalstatekey, int postaldistrictkey, string postalcity, string postalpincode, bool issameaddress, string tehsil, string village, string postaltehsil, string postalvillage)
    {
        if (string.IsNullOrEmpty(FullName))
            return 0;
        SqlParameter[] paramList = new SqlParameter[34];
        paramList[0] = new SqlParameter("@QueryType", "INSERT");
        paramList[1] = new SqlParameter("@RegistrationNo", RegistrationNo);
        paramList[2] = new SqlParameter("@RegistrationType", RegistrationType);
        paramList[3] = new SqlParameter("@UserName", UserName);
        paramList[4] = new SqlParameter("@Password", Password);

        paramList[5] = new SqlParameter("@FullName", FullName);
        paramList[6] = new SqlParameter("@FatherName", fatherName);
        paramList[7] = new SqlParameter("@AadharNo", AadharNo);
        paramList[8] = new SqlParameter("@MobileNo", MobileNo);
        paramList[9] = new SqlParameter("@EmailId", EmailId);
        if (DateOfBirth == Convert.ToDateTime("1/1/0001 12:00:00 AM"))
        {
            paramList[10] = new SqlParameter("@DateOfBirth", DBNull.Value);
        }
        else
        {
            paramList[10] = new SqlParameter("@DateOfBirth", DateOfBirth);
        }
        paramList[11] = new SqlParameter("@PanNo", PanNo);

        paramList[12] = new SqlParameter("@CurrentAddress", CurrentAddress);
        paramList[13] = new SqlParameter("@StateKey", statekey);
        paramList[14] = new SqlParameter("@DistrictKey", districtkey);
        paramList[15] = new SqlParameter("@City", city);
        paramList[16] = new SqlParameter("@PinCode", PinCode);

        paramList[17] = new SqlParameter("@IsSameAddress", issameaddress);
        paramList[18] = new SqlParameter("@PostalAddress", PostalAddress);
        paramList[19] = new SqlParameter("@PostalStateKey", postalstatekey);
        paramList[20] = new SqlParameter("@PostalDistrictKey", postaldistrictkey);
        paramList[21] = new SqlParameter("@PostalCity", postalcity);
        paramList[22] = new SqlParameter("@PostalPinCode", postalpincode);

        paramList[23] = new SqlParameter("@Createdby", createdby);
        paramList[24] = new SqlParameter("@IsActive", isactive);
        paramList[25] = new SqlParameter("@IsOnline", isonline);

        paramList[26] = new SqlParameter("@PostalTehsil", postaltehsil);
        paramList[27] = new SqlParameter("@PostalVillage", postalvillage);
        paramList[28] = new SqlParameter("@Tehsil", tehsil);
        paramList[29] = new SqlParameter("@Village", village);

        paramList[30] = new SqlParameter("@PropertyKey", propertykey);
        paramList[31] = new SqlParameter("@SchemeKey", schemekey);
        paramList[32] = new SqlParameter("@SectorKey", sectorkey);
        paramList[33] = new SqlParameter("@AllotmentNo", allotmentno);

        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "CandidateRegistration_DBLayer", paramList);

        if (obj == null)
            return 0;

        return Convert.ToInt32(obj);
    }
    public string GetMaxRegNo()
    {
        string regNo = "";
        SqlParameter[] paramList = new SqlParameter[1];
        paramList[0] = new SqlParameter("@QueryType", "MAX_REGNO");
        regNo = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "CandidateRegistration_DBLayer", paramList).ToString();
        return regNo;
    }

    public int CandidateExist(string username, string password)
    {

        if (username == "" && password == "")
            return 4;
        string sProcName = "CandidateRegistration_DBLayer";
        SqlParameter[] paramList;
        paramList = new SqlParameter[3];
        paramList[0] = new SqlParameter("@QueryType", "login_check");
        paramList[1] = new SqlParameter("@UserName", username);
        paramList[2] = new SqlParameter("@Password", password);
        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, sProcName, paramList);
        if (obj == null)
            return 4;
        else
            return Convert.ToInt32(obj);

    }

    public DataSet GetCandidateDetail(string uname, string pwd)
    {
        DataSet ds = new DataSet();
        string str = "select * from ApplicantRegistration where UserName ='" + uname + "' and [Password] = '" + pwd + "'";
        ds = SqlHelper.ExecuteDataset(Constr, CommandType.Text, str);
        return ds;
    }

    public DataSet GetCandidateDetail(int regNo)
    {
        DataSet ds = new DataSet();
        string str = "select * from ApplicantRegistration where RegistrationKey ='" + regNo + "'";
        ds = SqlHelper.ExecuteDataset(Constr, CommandType.Text, str);
        return ds;
    }

    public List<CandidateRegistration> GetCandidateDetail()
    {
        SqlDataReader sqlRdr = null;
        List<CandidateRegistration> lstApplicant = new List<CandidateRegistration>();
        string str = "SELECT * from CandidateRegistration";
        sqlRdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, str);
        while (sqlRdr.Read())
        {
            CandidateRegistration objCandidate = new CandidateRegistration();
            objCandidate.RegistrationKey = GetInt64(sqlRdr["RegistrationKey"]);
            objCandidate.RegistrationNo = sqlRdr["RegistrationNo"].ToString();
            objCandidate.RegistrationType = GetInt32(sqlRdr["RegistrationType"]);
            objCandidate.UserName = sqlRdr["UserName"].ToString();
            objCandidate.Password = sqlRdr["Password"].ToString();
            objCandidate.FullName = sqlRdr["FullName"].ToString();
            objCandidate.FatherName = sqlRdr["FatherName"].ToString();
            objCandidate.AadharNo = sqlRdr["AadharNo"].ToString();
            objCandidate.CurrentAddress = sqlRdr["CurrentAddress"].ToString();
            objCandidate.City = sqlRdr["City"].ToString();
            objCandidate.PinCode = sqlRdr["PinCode"].ToString();
            objCandidate.MobileNo = sqlRdr["MobileNo"].ToString();
            objCandidate.EmailId = sqlRdr["EmailId"].ToString();
            objCandidate.DateOfBirth = GetDate(sqlRdr["DateOfBirth"]);
            if (sqlRdr["DateOfBirth"].ToString() != "")
            {
                objCandidate.Dob = Convert.ToDateTime(sqlRdr["DateOfBirth"]).ToString("dd/MM/yyyy");
            }
            objCandidate.PanNo = sqlRdr["PanNo"].ToString();
            objCandidate.DistrictKey = GetInt16(sqlRdr["DistrictKey"]);
            objCandidate.StateKey = GetInt16(sqlRdr["StateKey"]);
            objCandidate.IsActive = GetBoolean(sqlRdr["IsActive"]);
            objCandidate.CreatedBy = GetInt16(sqlRdr["CreatedBy"]);
            objCandidate.CreatedOn = GetDate(sqlRdr["CreatedOn"]);
            objCandidate.LastModifiedBy = GetInt16(sqlRdr["LastModifiedBy"]);
            objCandidate.LastModifiedOn = GetDate(sqlRdr["LastModifiedOn"]);
            objCandidate.RegistrationMode = GetBoolean(sqlRdr["IsOnline"]);
            objCandidate.IsSameAddress = GetBoolean(sqlRdr["IsSameAddress"]);
            objCandidate.PostalAddress = sqlRdr["PostalAddress"].ToString();
            objCandidate.PostalStateKey = GetInt32(sqlRdr["PostalStateKey"]);
            objCandidate.PostalDistrictKey = GetInt32(sqlRdr["PostalDistrictKey"]);
            objCandidate.PostalCity = sqlRdr["PostalCity"].ToString();
            objCandidate.PostalPinCode = sqlRdr["PostalPinCode"].ToString();

            objCandidate.PostalTehsil = sqlRdr["PostalTehsil"].ToString();
            objCandidate.PostalVillage = sqlRdr["PostalVillage"].ToString();
            objCandidate.Tehsil = sqlRdr["Tehsil"].ToString();
            objCandidate.Village = sqlRdr["Village"].ToString();


            lstApplicant.Add(objCandidate);
        }

        return lstApplicant;
    }

    public CandidateRegistration ReadCandidateByKey(CandidateRegistration objCandidate)
    {
        SqlDataReader sqlRdr = null;
        try
        {
            string sProcName = null;
            SqlParameter[] paramList;
            Byte Case;
            if (objCandidate.UserName == null)
            {
                sProcName = "CandidateRegistration_DBLayer";
                paramList = new SqlParameter[2];
                paramList[0] = new SqlParameter("@QueryType", "SELECTbyPRIMARYKEY");
                paramList[1] = new SqlParameter("@RegistrationKey", objCandidate.RegistrationKey);
                Case = 1;
            }
            else
            {
                sProcName = "CandidateRegistration_DBLayer";
                paramList = new SqlParameter[2];
                paramList[0] = new SqlParameter("@QueryType", "SELECTbyUNIQUEKEY");
                paramList[1] = new SqlParameter("@UserName", objCandidate.UserName);
                Case = 2;
            }
            sqlRdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, sProcName, paramList);
            if (sqlRdr.Read())
            {

                objCandidate.RegistrationKey = GetInt64(sqlRdr["RegistrationKey"]);
                objCandidate.RegistrationNo = sqlRdr["RegistrationNo"].ToString();
                objCandidate.RegistrationType = GetInt32(sqlRdr["RegistrationType"]);
                objCandidate.UserName = sqlRdr["UserName"].ToString();
                objCandidate.Password = sqlRdr["Password"].ToString();
                objCandidate.FullName = sqlRdr["FullName"].ToString();
                objCandidate.FatherName = sqlRdr["FatherName"].ToString();
                objCandidate.AadharNo = sqlRdr["AadharNo"].ToString();
                objCandidate.CurrentAddress = sqlRdr["CurrentAddress"].ToString();
                objCandidate.PostalAddress = sqlRdr["PostalAddress"].ToString();
                objCandidate.City = sqlRdr["City"].ToString();
                objCandidate.PinCode = sqlRdr["PinCode"].ToString();
                objCandidate.MobileNo = sqlRdr["MobileNo"].ToString();
                objCandidate.EmailId = sqlRdr["EmailId"].ToString();
                if (sqlRdr["DateOfBirth"].ToString() != "")
                {
                    objCandidate.DateOfBirth = GetDate(sqlRdr["DateOfBirth"]);
                    objCandidate.Dob = Convert.ToDateTime(sqlRdr["DateOfBirth"]).ToString("dd/MM/yyyy");
                }
                objCandidate.PanNo = sqlRdr["PanNo"].ToString();
                objCandidate.DistrictKey = GetInt16(sqlRdr["DistrictKey"]);
                objCandidate.StateKey = GetInt16(sqlRdr["StateKey"]);
                objCandidate.IsActive = GetBoolean(sqlRdr["IsActive"]);
                objCandidate.CreatedBy = GetInt16(sqlRdr["CreatedBy"]);
                objCandidate.CreatedOn = GetDate(sqlRdr["CreatedOn"]);
                objCandidate.LastModifiedBy = GetInt16(sqlRdr["LastModifiedBy"]);
                objCandidate.LastModifiedOn = GetDate(sqlRdr["LastModifiedOn"]);
                objCandidate.RegistrationMode = GetBoolean(sqlRdr["IsOnline"]);

                objCandidate.PostalAddress = sqlRdr["PostalAddress"].ToString();
                objCandidate.PostalStateKey = GetInt32(sqlRdr["PostalStateKey"]);
                objCandidate.PostalDistrictKey = GetInt32(sqlRdr["PostalDistrictKey"]);
                objCandidate.PostalCity = sqlRdr["PostalCity"].ToString();
                objCandidate.PostalPinCode = sqlRdr["PostalPinCode"].ToString();

                objCandidate.PostalTehsil = sqlRdr["PostalTehsil"].ToString();
                objCandidate.PostalVillage = sqlRdr["PostalVillage"].ToString();
                objCandidate.Tehsil = sqlRdr["Tehsil"].ToString();
                objCandidate.Village = sqlRdr["Village"].ToString();

                objCandidate.SectorKey = GetInt32(sqlRdr["SectorKey"]);
                objCandidate.SchemeKey = GetInt32(sqlRdr["SchemeKey"]);
                objCandidate.PropertyKey = GetInt32(sqlRdr["PropertyKey"]);
                objCandidate.AllotmentNo = sqlRdr["AllotmentNo"].ToString();

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
        return objCandidate;
    }


    public CandidateRegistration ReadCandidateByMapApplicationKey(Int64 ApplicationKey)
    {
        SqlDataReader sqlRdr = null;
        CandidateRegistration objCandidate = new CandidateRegistration();
        try
        {
            string sProcName = null;
            SqlParameter[] paramList;

            if (ApplicationKey > 0)
            {
                sProcName = "CandidateRegistration_DBLayer";
                paramList = new SqlParameter[2];
                paramList[0] = new SqlParameter("@QueryType", "ReadCandidateByMapApplicationKey");
                paramList[1] = new SqlParameter("@ApplicationKey", ApplicationKey);
            }
            else
            {
                return objCandidate;
            }
            sqlRdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, sProcName, paramList);
            if (sqlRdr.Read())
            {

                objCandidate.RegistrationKey = GetInt64(sqlRdr["RegistrationKey"]);
                objCandidate.RegistrationNo = sqlRdr["RegistrationNo"].ToString();
                objCandidate.RegistrationType = GetInt32(sqlRdr["RegistrationType"]);
                objCandidate.UserName = sqlRdr["UserName"].ToString();
                objCandidate.Password = sqlRdr["Password"].ToString();
                objCandidate.FullName = sqlRdr["FullName"].ToString();
                objCandidate.FatherName = sqlRdr["FatherName"].ToString();
                objCandidate.AadharNo = sqlRdr["AadharNo"].ToString();
                objCandidate.CurrentAddress = sqlRdr["CurrentAddress"].ToString();
                objCandidate.PostalAddress = sqlRdr["PostalAddress"].ToString();
                objCandidate.City = sqlRdr["City"].ToString();
                objCandidate.PinCode = sqlRdr["PinCode"].ToString();
                objCandidate.MobileNo = sqlRdr["MobileNo"].ToString();
                objCandidate.EmailId = sqlRdr["EmailId"].ToString();
                objCandidate.DateOfBirth = GetDate(sqlRdr["DateOfBirth"]);
                objCandidate.PanNo = sqlRdr["PanNo"].ToString();
                objCandidate.IsActive = GetBoolean(sqlRdr["IsActive"]);
                objCandidate.CreatedBy = GetInt16(sqlRdr["CreatedBy"]);
                objCandidate.CreatedOn = GetDate(sqlRdr["CreatedOn"]);
                objCandidate.LastModifiedBy = GetInt16(sqlRdr["LastModifiedBy"]);
                objCandidate.LastModifiedOn = GetDate(sqlRdr["LastModifiedOn"]);
            }

        }
        finally
        {
            if (sqlRdr != null)
                sqlRdr.Close();
        }
        return objCandidate;
    }

    public DataSet GetApplicantAllomentDetails(string allotmentno, int propertytype, int sectorkey, int schemekey)
    {
        DataSet ds = new DataSet();

        string str = "select * from [dbo].[PlotAllotment] where AllotmentNo='" + allotmentno + "' AND PropertyKey=" + propertytype + " AND SectorName=" + sectorkey + " AND SchemeKey=" + schemekey + "";
        ds = SqlHelper.ExecuteDataset(Constr, CommandType.Text, str);
        return ds;
    }
    public DataTable GetUserMaster(string UserName, string Password, string UserType)
    {
        DataTable dt = new DataTable();

        using (var con = new SqlConnection(Constr))
        {
           // string query = "SELECT UserKey, UserType, Name, UserName, Password, DistrictKey, DivisionKey,Isnull(OfficeKey,0)  As OfficeKey, (select RoleName from RoleMaster Where ID = UserType) As UserTypeName FROM User_Master WHERE ISNULL(IsActive,1) = 1 And UserName='" + UserName.Trim() + "' ";
            string query = "SELECT UserKey, UserType, Name, UserName, [Password], A.DistrictKey, A.DivisionKey,Isnull(OfficeKey,0)  As OfficeKey, (select RoleName from RoleMaster Where ID = UserType) As UserTypeName, EnglishName DistrictName, C.DivisionEnglish as DivisionName  FROM User_Master A INNER JOIN District B ON A.DistrictKey=B.DistrictKey INNER JOIN Division C On A.DivisionKey=C.DivisionKey WHERE ISNULL(A.IsActive,1) = 1 And UserName='" + UserName.Trim() + "'";
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
            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0]["Password"].ToString() != Password)
                {
                    dt.Rows.Clear();
                }
            }
        }

        return dt;
    }

    public DataTable GetUserMasterByDistrict(int DistrictKey, string Password)
    {
        DataTable dt = new DataTable();

        using (var con = new SqlConnection(Constr))
        {
            string query = "SELECT UserKey, UserType, Name, UserName, Password, DistrictKey, DivisionKey,Isnull(OfficeKey,0)  As OfficeKey FROM User_Master WHERE ISNULL(IsActive,1) = 1 And DistrictKey=" + DistrictKey + " And UserType=";

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

            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0]["Password"].ToString() != Password)
                {
                    dt.Rows.Clear();
                }
            }

        }

        return dt;
    }

    public DataTable GetUserMasterByDivision(int DivisionKey, string Password)
    {
        DataTable dt = new DataTable();

        using (var con = new SqlConnection(Constr))
        {
            string query = "SELECT UserKey, UserType, Name, UserName, Password, DistrictKey, DivisionKey,Isnull(OfficeKey,0)  As OfficeKey, (select RoleName from RoleMaster Where ID = UserType) As UserTypeName FROM User_Master WHERE ISNULL(IsActive,1) = 1 And DivisionKey=" + DivisionKey + " And ";

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

            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0]["Password"].ToString() != Password)
                {
                    dt.Rows.Clear();
                }
            }

        }

        return dt;
    }

    public List<ListItem> GetDeptLoginType()
    {
        List<ListItem> lst = new List<ListItem>();
        try
        {
            SqlParameter[] objParam = new SqlParameter[] { 
                new SqlParameter("@QueryType","SELECT_ALL_LOGIN_DEPT")
                };

            SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "User_Master_DBLayer", objParam);
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
            return lst;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public List<ListItem> GetDeptLoginTypebyKey()
    {
        List<ListItem> lst = new List<ListItem>();
        try
        {
            SqlParameter[] objParam = new SqlParameter[] { 
                new SqlParameter("@QueryType","SELECT_ALL_LOGIN_DEPT")
                };

            SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "User_Master_DBLayer", objParam);
            using (sdr)
            {
                while (sdr.Read())
                {
                    if (sdr["id"].ToString() == "1")
                    {
                        lst.Add(new ListItem
                        {
                            Value = sdr["id"].ToString(),
                            Text = sdr["RoleName"].ToString()
                        });
                    }
                    if (sdr["id"].ToString() == "7")
                    {
                        lst.Add(new ListItem
                        {
                            Value = sdr["id"].ToString(),
                            Text = sdr["RoleName"].ToString()
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

    public int UserExist(string username, string password)
    {

        if (username == "" && password == "")
            return 4;
        string sProcName = "UserMaster_DBLayer";
        SqlParameter[] paramList;
        paramList = new SqlParameter[3];
        paramList[0] = new SqlParameter("@QueryType", "login_check");
        paramList[1] = new SqlParameter("@UserName", username);
        paramList[2] = new SqlParameter("@Password", password);
        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, sProcName, paramList);
        if (obj == null)
            return 4;
        else
            return Convert.ToInt32(obj);

    }

    public Boolean CheckUserExist(string username)
    {
        SqlDataReader sqlRdr = null;
        string str = "select RegistrationKey from candidateRegistration where UserName='" + username + "'";
        sqlRdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, str);
        if (sqlRdr.HasRows)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    #endregion

    #region Business Logic using Stored Procedure For - Lodge Complain

    public int CreateComplain(int complainsourcekey, int complaintypekey, int complainsubtypekey, string complain, string attachmentfile, string complaintokenno, string notifyby, int registrationkey, int createdby, bool isactive, int complainstatus, int applicationMode, string othercomplainsource)
    {
        if (string.IsNullOrEmpty(complain))
            return 0;
        SqlParameter[] paramList = new SqlParameter[14];
        paramList[0] = new SqlParameter("@QueryType", "INSERT");
        paramList[1] = new SqlParameter("@RegistrationKey", registrationkey);
        paramList[2] = new SqlParameter("@ComplainSourceKey", complainsourcekey);
        paramList[3] = new SqlParameter("@ComplainTypeKey", complaintypekey);
        paramList[4] = new SqlParameter("@ComplainSubTypeKey", complainsubtypekey);
        paramList[5] = new SqlParameter("@Complain", complain);
        paramList[6] = new SqlParameter("@AttachmentFile", attachmentfile);
        paramList[7] = new SqlParameter("@ComplainTokenNo", complaintokenno);
        paramList[8] = new SqlParameter("@NotifyBy", notifyby);
        paramList[9] = new SqlParameter("@IsActive", isactive);
        paramList[10] = new SqlParameter("@CreatedBy", createdby);

        paramList[11] = new SqlParameter("@ComplainStatus", complainstatus);
        paramList[12] = new SqlParameter("@ApplicationMode", applicationMode);
        paramList[13] = new SqlParameter("@OtherComplainSource", othercomplainsource);

        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "Complain_DBLayer", paramList);

        if (obj == null)
            return 0;

        return Convert.ToInt32(obj);
    }


    public int CreateComplain_Dispatch(int complainsourcekey, int complaintypekey, int complainsubtypekey, string complain, string attachmentfile, string complaintokenno, string notifyby, int registrationkey, int createdby, bool isactive, int complainstatus, int applicationMode, string letterrefno, DateTime letterdate, DateTime recievingdate)
    {
        if (string.IsNullOrEmpty(complain))
            return 0;
        SqlParameter[] paramList = new SqlParameter[16];
        paramList[0] = new SqlParameter("@QueryType", "INSERT");
        paramList[1] = new SqlParameter("@RegistrationKey", registrationkey);
        paramList[2] = new SqlParameter("@ComplainSourceKey", complainsourcekey);
        paramList[3] = new SqlParameter("@ComplainTypeKey", complaintypekey);
        paramList[4] = new SqlParameter("@ComplainSubTypeKey", complainsubtypekey);
        paramList[5] = new SqlParameter("@Complain", complain);
        paramList[6] = new SqlParameter("@AttachmentFile", attachmentfile);
        paramList[7] = new SqlParameter("@ComplainTokenNo", complaintokenno);
        paramList[8] = new SqlParameter("@NotifyBy", notifyby);
        paramList[9] = new SqlParameter("@IsActive", isactive);
        paramList[10] = new SqlParameter("@CreatedBy", createdby);
        paramList[11] = new SqlParameter("@ComplainStatus", complainstatus);
        paramList[12] = new SqlParameter("@ApplicationMode", applicationMode);
        paramList[13] = new SqlParameter("@LetterRefNo", letterrefno);
        paramList[14] = new SqlParameter("@LetterDate", letterdate);
        paramList[15] = new SqlParameter("@ReceivingDate", recievingdate);

        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "Complain_DBLayer", paramList);

        if (obj == null)
            return 0;

        return Convert.ToInt32(obj);
    }

    public DataSet ComplainReceipt(int complainkey)
    {
        DataSet ds = new DataSet();
        SqlParameter[] paramList = new SqlParameter[1];
        //   paramList[0] = new SqlParameter("@QueryType", "Receipt");
        paramList[0] = new SqlParameter("@ComplainKey", complainkey);
        ds = SqlHelper.ExecuteDataset(Constr, CommandType.StoredProcedure, "GenerateReceipt", paramList);

        return ds;

    }


    public DataSet ReadAllComplainByCond(string cond)
    {
        DataSet ds = new DataSet();
        SqlParameter[] paramList = new SqlParameter[2];
        paramList[0] = new SqlParameter("@QueryType", "READALLBYCOND");
        paramList[1] = new SqlParameter("@Condition", cond);
        ds = SqlHelper.ExecuteDataset(Constr, CommandType.StoredProcedure, "Complain_DBLayer", paramList);

        return ds;

    }

    public DataSet ReadAllComplainCEO(string cond)
    {
        DataSet ds = new DataSet();
        SqlParameter[] paramList = new SqlParameter[2];
        paramList[0] = new SqlParameter("@QueryType", "READALL_CEO");
        paramList[1] = new SqlParameter("@Condition", cond);
        ds = SqlHelper.ExecuteDataset(Constr, CommandType.StoredProcedure, "Complain_DBLayer", paramList);

        return ds;

    }

    public DataSet ReadAllComplain()
    {
        DataSet ds = new DataSet();
        SqlParameter[] paramList = new SqlParameter[1];
        paramList[0] = new SqlParameter("@QueryType", "READALL");
        ds = SqlHelper.ExecuteDataset(Constr, CommandType.StoredProcedure, "Complain_DBLayer", paramList);

        return ds;
    }

    public DataSet ReadComplainDetail(int complainkey)
    {
        DataSet ds = new DataSet();
        SqlParameter[] paramList = new SqlParameter[2];
        paramList[0] = new SqlParameter("@QueryType", "ComplainDetail");
        paramList[1] = new SqlParameter("@ComplainKey", complainkey);
        ds = SqlHelper.ExecuteDataset(Constr, CommandType.StoredProcedure, "Complain_DBLayer", paramList);

        return ds;
    }

    public DataSet ReadForwardedComplain(int complainkey, int action)
    {
        DataSet ds = new DataSet();
        SqlParameter[] paramList = new SqlParameter[3];
        paramList[0] = new SqlParameter("@QueryType", "ForwardedComplain");
        paramList[1] = new SqlParameter("@ComplainKey", complainkey);
        paramList[2] = new SqlParameter("@Action", action);
        // paramList[3] = new SqlParameter("@FromOfficerKey", officerkey);
        ds = SqlHelper.ExecuteDataset(Constr, CommandType.StoredProcedure, "Complain_DBLayer", paramList);

        return ds;
    }

    public string GetMaxComplainNo()
    {
        //MAX_COMPLAINNO
        string compno = "";
        SqlParameter[] paramList = new SqlParameter[1];
        paramList[0] = new SqlParameter("@QueryType", "MAX_COMPLAINNO");
        compno = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "Complain_DBLayer", paramList).ToString();
        return compno;
    }

    public DataSet GetComplainByKey(string strcondition)
    {
        DataSet ds = new DataSet();
        string str = "SELECT Complainkey,ComplainTokenNo,ComplainDate,Complain,ComplainTypeKey,ComplainSubTypeKey,ComplainStatus,CurrentStatus,ComplainType,ComplainSubType,FilePath FROM dbo.VW_ComplainDetail  " + strcondition;

        ds = SqlHelper.ExecuteDataset(Constr, CommandType.Text, str);

        return ds;
    }

    public DataSet ReadAllComplainDispatch(string strcondition)
    {
        DataSet ds = new DataSet();
        string str = "SELECT C.ComplainKey, C.ComplainTokenNo, c.ComplainDate, c.Complain, s.[FieldText] Status, CTM.ComplainName as ComplainType, CSTM.ComplainName as ComplainSubType,CSTM.TimeFrame-DATEDIFF(DAY, C.[ComplainDate],GETDATE()) as RemainingTime, C.ApplicationMode,CASE C.CurrentStatus WHEN 5 THEN 'Approved' WHEN 4 THEN 'Disapproved' ELSE s.[FieldText] END as ComplainStatus from Complain C Left JOIN ComplainType_Master CTM ON C.ComplainTypeKey=CTM.ComplainTypeKey Left JOIN ComplainType_Master CSTM ON C.ComplainSubTypeKey=CSTM.ComplainTypeKey INNER JOIN ApplicationStatus S ON C.CurrentStatus=s.TBKey " + strcondition + " order by C.ComplainKey desc";

        ds = SqlHelper.ExecuteDataset(Constr, CommandType.Text, str);
        return ds;
    }


    public DataTable GetAllcomplain()
    {
        DataTable dt = new DataTable();

        using (var con = new SqlConnection(Constr))
        {
            const string query = "select * from Complain order by complainDate";
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

    #region Business Logic using Stored Procedure For - Complain Forwarded

    public Boolean CreateforwardComplain(int complainkey, int tosectionkey, int toOfficerkey, int status, int fromOfficerKey, string attachmentfile, string remark, int createdby, int lastmodifiedby)
    {
        if (string.IsNullOrEmpty(remark))
            return false;
        SqlParameter[] paramList = new SqlParameter[10];
        paramList[0] = new SqlParameter("@QueryType", "INSERT_COMPLAIN_FORWARDED");
        paramList[1] = new SqlParameter("@ComplainKey", complainkey);
        paramList[2] = new SqlParameter("@ToSectionKey", tosectionkey);
        paramList[3] = new SqlParameter("@FromOfficerKey", fromOfficerKey);
        paramList[4] = new SqlParameter("@ToOfficerKey", toOfficerkey);
        paramList[5] = new SqlParameter("@ComplainStatus", status);
        paramList[6] = new SqlParameter("@AttachmentFile", attachmentfile);
        paramList[7] = new SqlParameter("@Remarks", remark);
        paramList[8] = new SqlParameter("@CreatedBy", createdby);
        paramList[9] = new SqlParameter("@LastModifiedBy", lastmodifiedby);

        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "Complain_DBLayer", paramList);

        if (obj == null)
            return false;

        return true;
    }

    #endregion

    #region Business Logic using Stored Procedure For - GetDashboard

    public DataSet GetDashboard(int regkey, string querytype)
    {
        DataSet ds = new DataSet();
        SqlParameter[] paramList = new SqlParameter[2];
        paramList[0] = new SqlParameter("@QueryType", querytype);
        paramList[1] = new SqlParameter("@RegistrationKey", regkey);
        ds = SqlHelper.ExecuteDataset(Constr, CommandType.StoredProcedure, "GetDashboard", paramList);

        return ds;
    }

    public DataSet GetDashboard()
    {
        DataSet ds = new DataSet();
        ds = SqlHelper.ExecuteDataset(Constr, CommandType.StoredProcedure, "GetDashboard_Dispatch");

        return ds;
    }

    #endregion


    public Boolean CheckForApproval(int officerkey)
    {
        DataSet ds = new DataSet();
        string str = "select IsAuthorizedForApproval from dbo.Officer_Master where OfficerKey=" + officerkey + "";
        ds = SqlHelper.ExecuteDataset(Constr, CommandType.Text, str);

        return Convert.ToBoolean(ds.Tables[0].Rows[0]["IsAuthorizedForApproval"].ToString());
    }

    public Boolean CheckGrievanceStatus(int officerkey, int complainkey)
    {
       
        string str = "select ComplainKey from dbo.ComplainForwarded where ComplainKey="+ complainkey +" and FromOfficerKey="+ officerkey +" And Status=1";
        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.Text, str);
        if (obj == null)
            return false;
        else
            return true; 
    }


    public  int ChangePassword(int userkey, string oldpassword, string newpassword)
    {      
        try
        {
            SqlParameter[] objParam = new SqlParameter[] { 
                new SqlParameter("@UserKey",userkey),
                new SqlParameter("@Currpwd",oldpassword),
                new SqlParameter("@Newpwd",newpassword)

                };

            object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "sp_ChangePassword", objParam);
            if (obj == null)
                return 0;
            else
                return Convert.ToInt32(obj);         
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


}