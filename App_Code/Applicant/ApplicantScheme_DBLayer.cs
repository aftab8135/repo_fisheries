using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using DBLibrary;
using FisheriesMIS.App_Code;

/// <summary>
/// Summary description for ApplicantScheme_DBLayer
/// </summary>
public partial class DBLayer
{
    public DataTable GetUserNo(int Registrationkey)
    {
        DataTable dt = new DataTable();

        using (var con = new SqlConnection(Constr))
        {
            string query = "SELECT UserNo  from dbo.ApplicantProfile  UM  where RegistrationKey=" + Registrationkey + " ";


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

    public Int64 UpdateApplicantSchemeAllDetails(int ApplicationNo, string fy_year, Int64 Registrationkey, int user_no, int DistrictNo, int Category, string Revenue_Village, string PostOffice, string PinNo, int BlockNo, int TehsilNo, string PlotNo, string Ownership, double totalland, double totalwaterarea, string detailsproposedwork, string Details_regard_assistance_received, double Project_cost, double Beneficiaries_share, double Total_Subsidy_Amount, double Central_share, double State_share, double applicant_payment_Financial_institution, double Estimate_Project_cost_regarding_recurring_cost, string Applicant_Experience, string Details_economics, string finacial_tieupanybank, double finacial_tieupanybankamount, DateTime expect_operation_date, Boolean Marketing_tieup, string Source_of_labour, int No_Of_Labour ,int Schemekey)
    {
        


        SqlParameter[] paramList = new SqlParameter[35];

        paramList[0] = new SqlParameter("@QueryType", "UpdateApplicantSchemeRegistration");
        paramList[1] = new SqlParameter("@fy_year", fy_year);
        paramList[2] = new SqlParameter("@Registrationkey", Registrationkey);

        paramList[3] = new SqlParameter("@user_no", user_no);
        paramList[4] = new SqlParameter("@DistrictNo", DistrictNo);
        paramList[5] = new SqlParameter("@Category", Category);

        paramList[6] = new SqlParameter("@Isfinalsubmit", true);
        paramList[7] = new SqlParameter("@SchemeKey", Schemekey);
        paramList[8] = new SqlParameter("@ApplicationNo", ApplicationNo);
        paramList[9] = new SqlParameter("@Revenue_Village", Revenue_Village);
        paramList[10] = new SqlParameter("@PostOffice", PostOffice);
        paramList[11] = new SqlParameter("@PinNo", PinNo);
        paramList[12] = new SqlParameter("@BlockNo", BlockNo);
        paramList[13] = new SqlParameter("@TehsilNo", TehsilNo);
        paramList[14] = new SqlParameter("@PlotNo", PlotNo);
        paramList[15] = new SqlParameter("@Ownership", Ownership);
        paramList[16] = new SqlParameter("@totalland", totalland);
        paramList[17] = new SqlParameter("@totalwaterarea", totalwaterarea);
        paramList[18] = new SqlParameter("@detailsproposedwork", detailsproposedwork);
        paramList[19] = new SqlParameter("@Details_regard_assistance_received", Details_regard_assistance_received);
        paramList[20] = new SqlParameter("@Project_cost", Project_cost);
        paramList[21] = new SqlParameter("@Beneficiaries_share", Beneficiaries_share);
        paramList[22] = new SqlParameter("@Total_Subsidy_Amount", Total_Subsidy_Amount);
        paramList[23] = new SqlParameter("@Central_share", Central_share);
        paramList[24] = new SqlParameter("@State_share", State_share);
        paramList[25] = new SqlParameter("@applicant_payment_Financial_institution", applicant_payment_Financial_institution);
        paramList[26] = new SqlParameter("@Estimate_Project_cost_regarding_recurring_cost", Estimate_Project_cost_regarding_recurring_cost);
        paramList[27] = new SqlParameter("@Applicant_Experience", Applicant_Experience);
        paramList[28] = new SqlParameter("@Details_economics", Details_economics);
        paramList[29] = new SqlParameter("@finacial_tieupanybank", finacial_tieupanybank);
        paramList[30] = new SqlParameter("@finacial_tieupanybankamount", finacial_tieupanybankamount);
        paramList[31] = new SqlParameter("@expect_operation_date", expect_operation_date);
        paramList[32] = new SqlParameter("@Marketing_tieup", Marketing_tieup);
        paramList[33] = new SqlParameter("@Source_of_labour", Source_of_labour);
        paramList[34] = new SqlParameter("@No_Of_Labour", No_Of_Labour);
        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "ApplicantSchemeRegistration_DBLayer", paramList);

        if (obj == null)
            return 0;

        return Convert.ToInt64(obj);
    }

    public Boolean CreateSchemeDocumentDetail(Int16 DocumentKey, int RegistrationKey,int ApplicationKey,string FileName )
    {
        if (ApplicationKey == 0)
            return false;
        SqlParameter[] paramList = new SqlParameter[5];
        paramList[0] = new SqlParameter("@QueryType", "INSERT");
        paramList[1] = new SqlParameter("@DocumentKey", DocumentKey);
        paramList[2] = new SqlParameter("@RegistrationKey", RegistrationKey);
        paramList[3] = new SqlParameter("@ApplicationKey", ApplicationKey);
        paramList[4] = new SqlParameter("@FileName", FileName);
        //  paramList[2] = new SqlParameter("@XML", XML);

        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "ApplicantScheme_DocumentsDetail_DBLayer", paramList);

        if (obj == null)
            return false;

        return true;
    }

    public Boolean CreateMapDocumentDetail(Int64 ApplicationKey, string XML)
    {
        if (ApplicationKey == 0 && string.IsNullOrEmpty(XML))
            return false;
        SqlParameter[] paramList = new SqlParameter[2];
        paramList[0] = new SqlParameter("@QueryType", "INSERT");
        paramList[1] = new SqlParameter("@ApplicationKey", ApplicationKey);
      //  paramList[2] = new SqlParameter("@XML", XML);

        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "ApplicantScheme_DocumentsDetail_DBLayer", paramList);

        if (obj == null)
            return false;

        return true;
    }


    public Int64 UpdateApplicantSchemeDetails(int ApplicationNo,string fy_year, Int64 Registrationkey, int user_no, int DistrictNo, int Category, string Revenue_Village, string PostOffice, string PinNo, int BlockNo, int TehsilNo, string PlotNo, string Ownership, double totalland,double totalwaterarea,int SchemeKey)
    {

        SqlParameter[] paramList = new SqlParameter[18];

        paramList[0] = new SqlParameter("@QueryType", "UpdateApplicantSchemeRegistration");
        paramList[1] = new SqlParameter("@fy_year", fy_year);
        paramList[2] = new SqlParameter("@Registrationkey", Registrationkey);

        paramList[3] = new SqlParameter("@user_no", user_no);
        paramList[4] = new SqlParameter("@DistrictNo", DistrictNo);
        paramList[5] = new SqlParameter("@Category", Category);

        paramList[6] = new SqlParameter("@Isfinalsubmit", false);
        paramList[7] = new SqlParameter("@SchemeKey", SchemeKey);
        paramList[8] = new SqlParameter("@ApplicationNo", ApplicationNo);
        paramList[9] = new SqlParameter("@Revenue_Village", Revenue_Village);
        paramList[10] = new SqlParameter("@PostOffice", PostOffice);
        paramList[11] = new SqlParameter("@PinNo", PinNo);
        paramList[12] = new SqlParameter("@BlockNo", BlockNo);
        paramList[13] = new SqlParameter("@TehsilNo", TehsilNo);
        paramList[14] = new SqlParameter("@PlotNo", PlotNo);
        paramList[15] = new SqlParameter("@Ownership", Ownership);
        paramList[16] = new SqlParameter("@totalland", totalland);
        paramList[17] = new SqlParameter("@totalwaterarea", totalwaterarea);
        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "ApplicantSchemeRegistration_DBLayer", paramList);

        if (obj == null)
            return 0;

        return Convert.ToInt64(obj);
    }


    public Int64 CreateApplicantSchemeDetails(string fy_year, Int64 Registrationkey ,int user_no, int DistrictNo, int Category, int schemekey)
    {

        SqlParameter[] paramList = new SqlParameter[8];

        paramList[0] = new SqlParameter("@QueryType", "INSERT");
        paramList[1] = new SqlParameter("@fy_year", fy_year);
        paramList[2] = new SqlParameter("@Registrationkey", Registrationkey);

        paramList[3] = new SqlParameter("@user_no", user_no);
        paramList[4] = new SqlParameter("@DistrictNo", DistrictNo);
        paramList[5] = new SqlParameter("@Category", Category);
       
        paramList[6] = new SqlParameter("@Isfinalsubmit", false);
        paramList[7] = new SqlParameter("@SchemeKey", schemekey);




        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "ApplicantSchemeRegistration_DBLayer", paramList);

        if (obj == null)
            return 0;

        return Convert.ToInt64(obj);
    }


    public int checkApplicantscheme(ApplicantSchemeRegistration objrecord)
    {
        string sProcName = "[ApplicantSchemeRegistration_DBLayer]";
        SqlParameter[] paramList;
        paramList = new SqlParameter[3];
        paramList[0] = new SqlParameter("@QueryType", "SELECTbyUniqueComplete");
        paramList[1] = new SqlParameter("@Registrationkey", objrecord.Registrationkey);
        paramList[2] = new SqlParameter("@Isfinalsubmit", objrecord.Isfinalsubmit);

        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, sProcName, paramList);
        if (obj == null)
            return 0;
        else
            return Convert.ToInt32(obj);
    }



    public int checkApplicantschemeUnique(ApplicantSchemeRegistration objrecord)
    {
        string sProcName = "[ApplicantSchemeRegistration_DBLayer]";
        SqlParameter[] paramList;
        paramList = new SqlParameter[3];
        paramList[0] = new SqlParameter("@QueryType", "SELECTbyUniqueunComplete");
        paramList[1] = new SqlParameter("@Registrationkey", objrecord.Registrationkey);
        paramList[2] = new SqlParameter("@SchemeKey", objrecord.SchemeKey);

        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, sProcName, paramList);
        if (obj == null)
            return 0;
        else
            return Convert.ToInt32(obj);
    }

    public int checkApplicantschemeUniqueSteptwo(ApplicantSchemeRegistration objrecord)
    {
        string sProcName = "[ApplicantSchemeRegistration_DBLayer]";
        SqlParameter[] paramList;
        paramList = new SqlParameter[3];
        paramList[0] = new SqlParameter("@QueryType", "SELECTbyUniqueunCompleteStep2");
        paramList[1] = new SqlParameter("@Registrationkey", objrecord.Registrationkey);
        paramList[2] = new SqlParameter("@SchemeKey", objrecord.SchemeKey);

        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, sProcName, paramList);
        if (obj == null)
            return 0;
        else
            return Convert.ToInt32(obj);
    }

    public int checkApplicantschemeUniqueStepthree(ApplicantSchemeRegistration objrecord)
    {
        string sProcName = "[ApplicantSchemeRegistration_DBLayer]";
        SqlParameter[] paramList;
        paramList = new SqlParameter[3];
        paramList[0] = new SqlParameter("@QueryType", "SELECTbyUniqueunCompleteStep3");
        paramList[1] = new SqlParameter("@Registrationkey", objrecord.Registrationkey);
        paramList[2] = new SqlParameter("@SchemeKey", objrecord.SchemeKey);

        object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, sProcName, paramList);
        if (obj == null)
            return 0;
        else
            return Convert.ToInt32(obj);
    }

    public DataTable GetUserSchemeDetails(int Registrationkey, int UserNo)
    {
        DataTable dt = new DataTable();

        using (var con = new SqlConnection(Constr))
        {
            string query = "SELECT *  from dbo.ApplicantSchemeRegistration  UM  where Registrationkey=" + Registrationkey + " and user_no=" + UserNo + " and UM.Isfinalsubmit=1 ";


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

    public DataSet GetApplicantSchemeRegistrationBykey(int Regkey,int userno, int schemekey)
    {
        DataSet ds = new DataSet();

        string strSQL = "select * from ApplicantSchemeRegistration  where ApplicantSchemeRegistration.Registrationkey  =" + Regkey + " and ApplicantSchemeRegistration.user_no= " + userno + " and ApplicantSchemeRegistration.SchemeKey =" +schemekey+" ";
        ds = SqlHelper.ExecuteDataset(Constr, CommandType.Text, strSQL);
        return ds;
    }
}