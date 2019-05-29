using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using DBLibrary;

/// <summary>
/// Summary description for DVIO_DBLayer
/// </summary>
public partial class DBLayer
{
    public User ReadDVIOApplicantWise(Int32 ApplicationNo)
    {
        SqlDataReader sqlRdr = null;
        try
        {
            string sProcName = null;
            SqlParameter[] paramList;
            User objRecord = new User();
            sProcName = "User_Master_DBLayer";
            paramList = new SqlParameter[2];
            paramList[0] = new SqlParameter("@QueryType", "ReadDVIOApplicantWise");
            paramList[1] = new SqlParameter("@ApplicationNo", ApplicationNo);
            sqlRdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, sProcName, paramList);
            if (sqlRdr.Read())
            {
                objRecord.UserKey = GetInt32(sqlRdr["UserKey"]);
                objRecord.UserName = sqlRdr["UserName"].ToString();
                objRecord.Name = sqlRdr["Name"].ToString();
                objRecord.EmailID = sqlRdr["EmailID"].ToString();
                objRecord.PhoneNo = sqlRdr["PhoneNo"].ToString();
                objRecord.DistrictKey = GetInt16(sqlRdr["DistrictKey"]);
                objRecord.OfficeKey = GetInt32(sqlRdr["OfficeKey"]);
            }
            else
            {
                objRecord.UserKey = 0;
                throw new Exception("Invalid Record Key!");
            }
            return objRecord;
        }
        finally
        {
            if (sqlRdr != null)
                sqlRdr.Close();
        }
    }
    public Boolean InsertDIVISONStatus(Int64 applicationNo, string FileName, Int32 lastmodifiedby)
    {
        SqlParameter[] paramList = new SqlParameter[4];
        paramList[0] = new SqlParameter("@QueryType", "Insert");
        paramList[1] = new SqlParameter("@ApplicationNo", applicationNo);
        paramList[2] = new SqlParameter("@FileName", FileName);
        paramList[3] = new SqlParameter("@LastModifiedBy", lastmodifiedby);

        if (SqlHelper.ExecuteNonQuery(Constr, CommandType.StoredProcedure, "DIVISONDocDetails_DBLayer", paramList) == 0)
            return false;
        else
            return true;
    }
    public Boolean InsertDIVISONOtherStatus(Int64 applicationNo, string FileName, Int32 lastmodifiedby)
    {
        SqlParameter[] paramList = new SqlParameter[4];
        paramList[0] = new SqlParameter("@QueryType", "Insert");
        paramList[1] = new SqlParameter("@ApplicationNo", applicationNo);
        paramList[2] = new SqlParameter("@FileName", FileName);
        paramList[3] = new SqlParameter("@LastModifiedBy", lastmodifiedby);

        if (SqlHelper.ExecuteNonQuery(Constr, CommandType.StoredProcedure, "DIVISONDocOtherDetails_DBLayer", paramList) == 0)
            return false;
        else
            return true;
    }

    public Boolean InsertDVIOStatus(Int64 applicationNo, string FileName, Int32 lastmodifiedby)
    {
        SqlParameter[] paramList = new SqlParameter[4];
        paramList[0] = new SqlParameter("@QueryType", "Insert");
        paramList[1] = new SqlParameter("@ApplicationNo", applicationNo);
        paramList[2] = new SqlParameter("@FileName", FileName);
        paramList[3] = new SqlParameter("@LastModifiedBy", lastmodifiedby);

        if (SqlHelper.ExecuteNonQuery(Constr, CommandType.StoredProcedure, "DVIODocDetails_DBLayer", paramList) == 0)
            return false;
        else
            return true;
    }

    public Boolean InsertDVIOOtherStatus(Int64 applicationNo, string FileName, Int32 lastmodifiedby)
    {
        SqlParameter[] paramList = new SqlParameter[4];
        paramList[0] = new SqlParameter("@QueryType", "Insert");
        paramList[1] = new SqlParameter("@ApplicationNo", applicationNo);
        paramList[2] = new SqlParameter("@FileName", FileName);
        paramList[3] = new SqlParameter("@LastModifiedBy", lastmodifiedby);

        if (SqlHelper.ExecuteNonQuery(Constr, CommandType.StoredProcedure, "DVIODocOtherDetails_DBLayer", paramList) == 0)
            return false;
        else
            return true;
    }
    #region Business Logic using Stored Procedure For - InteractionDetail

    public Int64 CreateInteractionDetail(Int32 ApplicationNo, Int16 InteractionMode, string OfficerName, string Designation, string InteractionDate, string InteractionTime, string InteractionRemark, Int32 CreatedBy)
    {
        if (ApplicationNo == 0 || String.IsNullOrEmpty(OfficerName) || String.IsNullOrEmpty(Designation) || String.IsNullOrEmpty(InteractionRemark) || InteractionMode == 0)
            return 0;
        SqlParameter[] paramList = new SqlParameter[9];
        paramList[0] = new SqlParameter("@QueryType", "INSERT");
        paramList[1] = new SqlParameter("@ApplicationNo", ApplicationNo);
        paramList[2] = new SqlParameter("@InteractionMode", InteractionMode);
        paramList[3] = new SqlParameter("@OfficerName", OfficerName);
        paramList[4] = new SqlParameter("@Designation", Designation);
        paramList[5] = new SqlParameter("@InteractionDate", InteractionDate);
        paramList[6] = new SqlParameter("@InteractionTime", InteractionTime);
        paramList[7] = new SqlParameter("@InteractionRemark", InteractionRemark);
        paramList[8] = new SqlParameter("@CreatedBy", CreatedBy);
        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "InteractionDetail_DBLayer", paramList);

        if (obj == null)
            return 0;

        return Convert.ToInt64(obj);
    }

    public void Read(InteractionDetail objRecord)
    {
        SqlDataReader sqlRdr = null;
        try
        {
            string sProcName = null;
            SqlParameter[] paramList;
            Byte Case;
            if (objRecord.ApplicationNo == 0 && String.IsNullOrEmpty(objRecord.InteractionDate) || String.IsNullOrEmpty(objRecord.InteractionTime))
            {
                sProcName = "InteractionDetail_DBLayer";
                paramList = new SqlParameter[2];
                paramList[0] = new SqlParameter("@QueryType", "SELECTbyPRIMARYKEY");
                paramList[1] = new SqlParameter("@InteractionKey", objRecord.InteractionKey);
                Case = 1;
            }
            else
            {
                sProcName = "InteractionDetail_DBLayer";
                paramList = new SqlParameter[4];
                paramList[0] = new SqlParameter("@QueryType", "SELECTbyUNIQUEKEY");
                paramList[1] = new SqlParameter("@ApplicationNo", objRecord.ApplicationNo);
                paramList[2] = new SqlParameter("@InteractionDate", objRecord.InteractionDate);
                paramList[3] = new SqlParameter("@InteractionTime", objRecord.InteractionTime);
                Case = 2;
            }
            sqlRdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, sProcName, paramList);
            if (sqlRdr.Read())
            {
                objRecord.ApplicationNo = GetInt32(sqlRdr["ApplicationNo"]);
                objRecord.InteractionKey = GetInt64(sqlRdr["InteractionKey"]);
                objRecord.InteractionMode = GetInt16(sqlRdr["InteractionMode"]);
                objRecord.InteractionModeText = ((InteractionMode)GetInt16(sqlRdr["InteractionMode"])).ToString().Replace("_", " ");
                objRecord.InteractionRemark = sqlRdr["InteractionRemark"].ToString();
                objRecord.OfficerName = sqlRdr["OfficerName"].ToString();
                objRecord.Designation = sqlRdr["Designation"].ToString();
                objRecord.InteractionDate = sqlRdr["InteractionDate"].ToString();
                objRecord.InteractionTime = sqlRdr["InteractionTime"].ToString();
                //objRecord.InteractionType = GetInt16(sqlRdr["InteractionType"]);
                //objRecord.InteractionTypeText = ((InteractionType)GetInt16(sqlRdr["InteractionType"])).ToString().Replace("_", " ");
                //objRecord.ExpectedResolvingDate = GetDate(sqlRdr["ExpectedResolvingDate"]);
                //objRecord.ExpectedResolvingDateText = (GetDate(sqlRdr["ExpectedResolvingDate"]).Year == 1) ? "NA" : GetDate(sqlRdr["ExpectedResolvingDate"]).ToString("dd/MMM/yyyy");
                //objRecord.isResolved = GetBoolean(sqlRdr["isResolved"]);
                objRecord.CreatedBy = GetInt16(sqlRdr["CreatedBy"]);
                objRecord.CreatedOn = GetDate(sqlRdr["CreatedOn"]);
            }
            else
            {
                objRecord.InteractionKey = 0;
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

    public List<InteractionDetail> ReadAllInteractionDetail(Int32 ApplicationNo =0)
    {
        List<InteractionDetail> lstInteractionDetail = new List<InteractionDetail>();
        SqlDataReader sqlRdr = null;
        try
        {
            string sProcName = "InteractionDetail_DBLayer";
            SqlParameter[] paramList;

            paramList = new SqlParameter[2];
            paramList[0] = new SqlParameter("@QueryType", "READALL");
            if (ApplicationNo > 0)
                paramList[1] = new SqlParameter("@ApplicationNo", ApplicationNo);
            else
                paramList[1] = new SqlParameter("@ApplicationNo", DBNull.Value);
            sqlRdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, sProcName, paramList);
            while (sqlRdr.Read())
            {
                InteractionDetail obj = new InteractionDetail();
                obj.ApplicationNo = GetInt32(sqlRdr["ApplicationNo"]);
                obj.InteractionKey = GetInt64(sqlRdr["InteractionKey"]);
                obj.InteractionMode = GetInt16(sqlRdr["InteractionMode"]);
                obj.InteractionModeText = ((InteractionMode)GetInt16(sqlRdr["InteractionMode"])).ToString().Replace("_", " ");
                obj.InteractionRemark = sqlRdr["InteractionRemark"].ToString();
                obj.OfficerName = sqlRdr["OfficerName"].ToString();
                obj.Designation = sqlRdr["Designation"].ToString();
                obj.InteractionDate = sqlRdr["InteractionDate"].ToString();
                obj.InteractionTime = sqlRdr["InteractionTime"].ToString();
                //obj.InteractionType = GetInt16(sqlRdr["InteractionType"]);
                //obj.InteractionTypeText = ((InteractionType)GetInt16(sqlRdr["InteractionType"])).ToString().Replace("_", " ");
                //obj.ExpectedResolvingDate = GetDate(sqlRdr["ExpectedResolvingDate"]);
                //obj.ExpectedResolvingDateText = (GetDate(sqlRdr["ExpectedResolvingDate"]).Year == 1) ? "NA" : GetDate(sqlRdr["ExpectedResolvingDate"]).ToString("dd/MMM/yyyy");
                //obj.isResolved = GetBoolean(sqlRdr["isResolved"]);
                obj.CreatedBy = GetInt16(sqlRdr["CreatedBy"]);
                obj.CreatedOn = GetDate(sqlRdr["CreatedOn"]);

                lstInteractionDetail.Add(obj);

            }
        }
        finally
        {
            if (sqlRdr != null)
                sqlRdr.Close();
        }
        return lstInteractionDetail;
    }

    public InteractionDetail GET_OpenInteractionDetail(Int32 ApplicationNo)
    {
        InteractionDetail obj = new InteractionDetail();
        SqlDataReader sqlRdr = null;
        try
        {
            string sProcName = "InteractionDetail_DBLayer";
            SqlParameter[] paramList;

            paramList = new SqlParameter[2];
            paramList[0] = new SqlParameter("@QueryType", "GET_OpenInteractionDetail");
            paramList[1] = new SqlParameter("@ApplicationNo", ApplicationNo);
            sqlRdr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, sProcName, paramList);
            while (sqlRdr.Read())
            {
                obj.ApplicationNo = GetInt32(sqlRdr["ApplicationNo"]);
                obj.InteractionKey = GetInt64(sqlRdr["InteractionKey"]);
                obj.InteractionMode = GetInt16(sqlRdr["InteractionMode"]);
                obj.InteractionModeText = ((InteractionMode)GetInt16(sqlRdr["InteractionMode"])).ToString().Replace("_", " ");
                obj.InteractionRemark = sqlRdr["InteractionRemark"].ToString();
                obj.OfficerName = sqlRdr["OfficerName"].ToString();
                obj.Designation = sqlRdr["Designation"].ToString();
                obj.InteractionDate = sqlRdr["InteractionDate"].ToString();
                obj.InteractionTime = sqlRdr["InteractionTime"].ToString();
                //obj.InteractionType = GetInt16(sqlRdr["InteractionType"]);
                //obj.InteractionTypeText = ((InteractionType)GetInt16(sqlRdr["InteractionType"])).ToString().Replace("_", " ");
                //obj.ExpectedResolvingDateText = (GetDate(sqlRdr["ExpectedResolvingDate"]).Year == 1) ? "NA" : GetDate(sqlRdr["ExpectedResolvingDate"]).ToString("dd/MMM/yyyy");
                //obj.isResolved = GetBoolean(sqlRdr["isResolved"]);
                obj.CreatedBy = GetInt16(sqlRdr["CreatedBy"]);
                obj.CreatedOn = GetDate(sqlRdr["CreatedOn"]);

            }
        }
        finally
        {
            if (sqlRdr != null)
                sqlRdr.Close();
        }
        return obj;
    }

    public void Update(InteractionDetail objInteraction)
    {
        string sProcName = null;
        SqlParameter[] paramList;

        sProcName = "InteractionDetail_DBLayer";

        paramList = new SqlParameter[2];

        paramList[0] = new SqlParameter("@QueryType", "UpdateInteractionStatus");
        paramList[1] = new SqlParameter("@InteractionKey", objInteraction.InteractionKey);
        if (SqlHelper.ExecuteNonQuery(Constr, CommandType.StoredProcedure, sProcName, paramList) == 0)
            throw new Exception("Record Not updated due to some error");

    }

    #endregion

    #region Business Logic using Stored Procedure For - Dashboard

    public DataSet GET_DVIOLEVEL_Summary(Int16 DistrictKey)
    {
        DataSet ds = new DataSet();
        string _proc = "DVIODashboard_DBLayer";
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@QueryType", "DVIOLEVEL_Summary");
        param[1] = new SqlParameter("@DistrictKey", DistrictKey);
        ds = SqlHelper.ExecuteDataset(Constr, CommandType.StoredProcedure, _proc, param);
        return ds;
    }

    #endregion
}