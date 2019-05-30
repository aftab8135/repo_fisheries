using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using DBLibrary;

/// <summary>
/// Summary description for MSR_DBLayer
/// </summary>
public partial class DBLayer
{
    #region "Business Logic - MSR_PhyEventMaster"

    public List<ListItem> GetMSR_Category()
    {
        List<ListItem> lst = new List<ListItem>();
        try
        {
            SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, "Select CategoryKey, CatHindiName From MSR_CategoryMaster Where IsActive = 1");
            using (sdr)
            {
                while (sdr.Read())
                {
                    lst.Add(new ListItem
                    {
                        Value = sdr["CategoryKey"].ToString(),
                        Text = sdr["CatHindiName"].ToString()
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
    public DataTable GetMSR_PhyEventMonthList(string FinYear, int DistKey, int CateKey)
    {
        DataTable dtPhyEventMonthList = new DataTable();
        try
        {
            if (FinYear != "")
            {
                SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@FinYear",FinYear),
                    new SqlParameter("@DistrictKey",DistKey),
                    new SqlParameter("@CatKey",CateKey),
                    new SqlParameter("@QueryType","GET_MSR_FOR_MONTH"),
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "MSR_CatSubCatRel_DBLayer", param);
                dtPhyEventMonthList.Load(dr);
                return dtPhyEventMonthList;
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
        return dtPhyEventMonthList;
    }
    public int Create_MSR_PHY_EVENT(MSR_PhyEventMaster objMSR_PhyEventMaster)
    {
        int intMstKey = 0;
        try
        {
            string xmlEvtDetail = GlobalFunctions.ConvertToXMLFormat<MSR_PhyEventDetail>(ref objMSR_PhyEventMaster.EventDts);
            SqlParameter[] objParam = new SqlParameter[] {
                new SqlParameter("@CategoryKey",objMSR_PhyEventMaster.CategoryKey),
                new SqlParameter("@CreatedBy",objMSR_PhyEventMaster.CreatedBy),
                new SqlParameter("@FinancialYear",objMSR_PhyEventMaster.FinancialYear),
                new SqlParameter("@DistrictKey",objMSR_PhyEventMaster.DistrictKey),
                new SqlParameter("@DivisionKey",objMSR_PhyEventMaster.DivisionKey),
                new SqlParameter("@MonthId",objMSR_PhyEventMaster.MonthId),
                new SqlParameter("@DetailXML",xmlEvtDetail),
                new SqlParameter("@QueryType","INSERT")
                };
            object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "MSR_PhyEventMaster_DBLayer", objParam);
            if (obj != null && obj != DBNull.Value)
                intMstKey = Convert.ToInt32(obj);
            else
                intMstKey = 0;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return intMstKey;
    }
    public bool IS_MSR_PhyEventExist(int MonthId, int CategoryId, int DistrictKey, string FinancialYear)
    {
        bool blnExist = false;
        try
        {
            SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@FinancialYear",FinancialYear),
                    new SqlParameter("@MonthId",MonthId),
                    new SqlParameter("@CategoryKey",CategoryId),
                    new SqlParameter("@DistrictKey",DistrictKey),
                    new SqlParameter("@QueryType","RECORD_MONTH_EXIST"),
                };

            object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "MSR_PhyEventMaster_DBLayer", param);
            if (obj != null && obj != DBNull.Value)
                blnExist = (Convert.ToInt32(obj) > 0 ? true : false);
            return blnExist;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    #region Report
    public DataTable GetRpt_MSR_PhyEvent(string FinYear, int MonthId, int DivisionKey = 0, int DistrictKey = 0, int CateKey = 0)
    {
        DataTable dtPhyEventMonthList = new DataTable();
        try
        {
            if (FinYear != "")
            {
                SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@FinancialYear",FinYear),
                    new SqlParameter("@DivisionKey",DivisionKey),
                    new SqlParameter("@DistrictKey",DistrictKey),
                    new SqlParameter("@MonthId",MonthId),
                    new SqlParameter("@CateKey",CateKey),
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "MSR_PhyEventMonthRpt", param);
                dtPhyEventMonthList.Load(dr);
                return dtPhyEventMonthList;
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
        return dtPhyEventMonthList;
    }
    public DataTable GetRpt_SchemesForApplicant(string FinYear, int MonthId, int DivisionKey = 0, int DistrictKey = 0, int SchemeKey = 0)
    {
        DataTable dtPhyEventMonthList = new DataTable();
        try
        {
            if (FinYear != "")
            {
                SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@FinYear",FinYear),
                    new SqlParameter("@DivisionKey",DivisionKey),
                    new SqlParameter("@DistrictKey",DistrictKey),
                    new SqlParameter("@MonthId",MonthId),
                    new SqlParameter("@SchemeID",SchemeKey),
                    new SqlParameter("@QueryType","ReportForDis"),
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "RPT_SCHEMES_DB_LAYER", param);
                dtPhyEventMonthList.Load(dr);
                return dtPhyEventMonthList;
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
        return dtPhyEventMonthList;
    }
    public DataTable GetRpt_PhyProgressSummry(string FinYear, int MonthId, int DivisionKey = 0, int DistrictKey = 0, int SchemeTypeKey = 0, int SchemeKey = 0)
    {
        DataTable dtPhyEventMonthList = new DataTable();
        try
        {
            if (FinYear != "")
            {
                SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@FinYear",FinYear),
                    new SqlParameter("@DivisionKey",DivisionKey),
                    new SqlParameter("@DistrictKey",DistrictKey),
                    new SqlParameter("@MonthId",MonthId),
                    new SqlParameter("@SchemeTypeID",SchemeTypeKey),
                    new SqlParameter("@SchemeID",SchemeKey),
                    new SqlParameter("@QueryType","ReportForPhyShchemeSummry"),
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "RPT_SCHEMES_DB_LAYER", param);
                dtPhyEventMonthList.Load(dr);
                return dtPhyEventMonthList;
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
        return dtPhyEventMonthList;
    }
    public DataTable GetSP_SeedDistributionReport(string FinYear, int MonthId, int DivisionKey = 0, int DistrictKey = 0)
    {
        DataTable dtRecord = new DataTable();
        try
        {
            if (FinYear != "")
            {
                SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@FinYear",FinYear),
                    new SqlParameter("@DivisionKey",DivisionKey),
                    new SqlParameter("@DistrictKey",DistrictKey),
                    new SqlParameter("@MonthKey",MonthId),
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "SP_SeedDistributionReport", param);
                dtRecord.Load(dr);
                return dtRecord;
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
        return dtRecord;
    }

    public DataTable GetSP_SeedStockReport(string FinYear, int MonthId, int DivisionKey = 0, int DistrictKey = 0)
    {
        DataTable dtRecord = new DataTable();
        try
        {
            if (FinYear != "")
            {
                SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@FinYear",FinYear),
                    new SqlParameter("@DivisionKey",DivisionKey),
                    new SqlParameter("@DistrictKey",DistrictKey),
                    new SqlParameter("@MonthKey",MonthId),
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "SP_SeedStockReport", param);
                dtRecord.Load(dr);
                return dtRecord;
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
        return dtRecord;
    }
    #endregion

    #endregion

    #region "Business Logic - Pond Auction"
    public int CreatePondAuctionMaster(PondAuctionMaster objPondAuctionMaster)
    {
        int intMstKey = 0;
        try
        {
            string xmlAuctins = GlobalFunctions.ConvertToXMLFormat<PondAuctionDetail>(ref objPondAuctionMaster.Auctions);
            SqlParameter[] objParam = new SqlParameter[] {
                new SqlParameter("@CreatedBy",objPondAuctionMaster.CreatedBy),
                new SqlParameter("@FinYear",objPondAuctionMaster.FinYear),
                new SqlParameter("@MonthKey",objPondAuctionMaster.MonthKey),
                new SqlParameter("@xmlAuctions",xmlAuctins),
                new SqlParameter("@QueryType","INSERT")
                };
            object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "PondAuction_Master_DBLayer", objParam);
            if (obj != null && obj != DBNull.Value)
                intMstKey = Convert.ToInt32(obj);
            else
                intMstKey = 0;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return intMstKey;
    }
    public DataTable GetPondAuctionListByDistict(string FinYear, int DistKey)
    {
        DataTable dtPhyEventMonthList = new DataTable();
        try
        {
            if (FinYear != "")
            {
                SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@FinYear",FinYear),
                    new SqlParameter("@DistrictKey",DistKey),
                    new SqlParameter("@QueryType","SELECT_ACTION_BY_DISTRICT"),
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "PondAuction_DBLayer", param);
                dtPhyEventMonthList.Load(dr);
                return dtPhyEventMonthList;
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
        return dtPhyEventMonthList;
    }
    public DataTable GetRptPondAuctionInfo(string FinYear, int MonthId, int DivisionKey = 0, int DistrictKey = 0)
    {
        DataTable dt = new DataTable();
        try
        {
            if (FinYear != "")
            {
                SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@FinYear",FinYear),
                    new SqlParameter("@DivisionKey",DivisionKey),
                    new SqlParameter("@DistrictKey",DistrictKey),
                    new SqlParameter("@QueryType","SELECT_POND_AUCTION_LIST_FOR_REPORT"),
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "PondAuction_Master_DBLayer", param);
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

    #region "Business Logic - Fish Production Tantative"
    public int CreateFishProdTant(FishProductionTant objFishProductionTant)
    {
        int intMstKey = 0;
        try
        {
            SqlParameter[] objParam = new SqlParameter[] {
                    new SqlParameter("@CreatedBy",objFishProductionTant.CreatedBy),
                    new SqlParameter("@DistrictKey",objFishProductionTant.DistrictKey),
                    new SqlParameter("@FinYear",objFishProductionTant.FinYear),
                    new SqlParameter("@Lake",objFishProductionTant.Lake),
                    new SqlParameter("@LastModifiedBy",objFishProductionTant.LastModifiedBy),
                    new SqlParameter("@MonthKey",objFishProductionTant.MonthKey),
                    new SqlParameter("@Pond",objFishProductionTant.Pond),
                    new SqlParameter("@Remark",objFishProductionTant.Remark),
                    new SqlParameter("@River",objFishProductionTant.River),
                    new SqlParameter("@Total",objFishProductionTant.Total),
                    new SqlParameter("@WaterArea",objFishProductionTant.WaterArea),
                    new SqlParameter("@YearlyTarget",objFishProductionTant.YearlyTarget),
                    new SqlParameter("@IsActive",objFishProductionTant.IsActive),
                    new SqlParameter("@QueryType","INSERT")
                };
            object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "FishProductionTant_DBLayer", objParam);
            if (obj != null && obj != DBNull.Value)
                intMstKey = Convert.ToInt32(obj);
            else
                intMstKey = 0;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return intMstKey;
    }
    public DataTable GetRptFishProductionTant(string FinYear, int MonthId, int DivisionKey = 0, int DistrictKey = 0)
    {
        DataTable dt = new DataTable();
        try
        {
            if (FinYear != "")
            {
                SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@FinYear",FinYear),
                    new SqlParameter("@MonthKey",MonthId),
                    new SqlParameter("@DivisionKey",DivisionKey),
                    new SqlParameter("@DistrictKey",DistrictKey),
                    new SqlParameter("@QueryType","TentativeFishProductionReport"),
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "FishProductionTant_DBLayer", param);
                dt.Load(dr);

            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
        return dt;
    }

    public DataTable GetRptFishProductionAllSources(string FinYear, int MonthId, int DistrictKey = 0, int DivisionKey = 0)
    {
        DataTable dt = new DataTable();
        try
        {
            if (FinYear != "")
            {
                SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@FinYear",FinYear),
                    new SqlParameter("@MonthId",MonthId),
                    new SqlParameter("@DistrictKey",DistrictKey),
                    new SqlParameter("@DivisionKey",DivisionKey)

                 //   new SqlParameter("@QueryType","RPT_FishProductionAllSources"),
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "RPT_FishProductionAllSources", param);
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

    #region "BusinessLogic - Pond First Progress"
    public int CreatePondProgress(PondProgressFirstMaster PondProgressFirstMaster)
    {
        int intMstKey = 0;
        try
        {
            SqlParameter[] objParam = new SqlParameter[] {
                new SqlParameter("@CreatedBy",PondProgressFirstMaster.CreatedBy),
                new SqlParameter("@DistrictKey",PondProgressFirstMaster.DistrictKey),
                new SqlParameter("@DivisionKey",PondProgressFirstMaster.DivisionKey),
                new SqlParameter("@FinYear",PondProgressFirstMaster.FinYear),

                new SqlParameter("@AbortPattaArea",PondProgressFirstMaster.AbortPattaArea),
                new SqlParameter("@AbortPattaNos",PondProgressFirstMaster.AbortPattaNos),

                new SqlParameter("@CurrPattaArea",PondProgressFirstMaster.CurrPattaArea),
                new SqlParameter("@CurrPattaNos",PondProgressFirstMaster.CurrPattaNos),

                new SqlParameter("@MonthKey",PondProgressFirstMaster.MonthKey),

                new SqlParameter("@PastPastArea",PondProgressFirstMaster.PastPastArea),
                new SqlParameter("@PastPastNos",PondProgressFirstMaster.PastPastNos),

                new SqlParameter("@PondArea",PondProgressFirstMaster.PondArea),
                new SqlParameter("@PondNos",PondProgressFirstMaster.PondNos),

                new SqlParameter("@TotalPattaArea",PondProgressFirstMaster.TotalPattaArea),
                new SqlParameter("@TotalPattaNos",PondProgressFirstMaster.TotalPattaNos),

                new SqlParameter("@YearlyTarget",PondProgressFirstMaster.YearlyTarget),

                new SqlParameter("@QueryType","INSERT")
                };
            object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "PondProgressFirstMaster_DBLayer", objParam);
            if (obj != null && obj != DBNull.Value)
                intMstKey = Convert.ToInt32(obj);
            else
                intMstKey = 0;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return intMstKey;
    }

    public DataTable GetFirstTotalPatta(string FinYear, int MonthId, int DistrictKey = 0)
    {
        DataTable dt = new DataTable();
        try
        {
            if (FinYear != "")
            {
                SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@FinYear",FinYear),
                    new SqlParameter("@MonthKey",MonthId),
                    new SqlParameter("@DistrictKey",DistrictKey),
                    new SqlParameter("@QueryType","SELECT_FIRST_TOTAL_PATTA"),
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "PondProgressFirstMaster_DBLayer", param);
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

    #region "BusinessLogic - Pond Second Progress"
    public int CreatePondProgress(PondProgressMaster objPondProgressMaster)
    {
        int intMstKey = 0;
        try
        {
            SqlParameter[] objParam = new SqlParameter[] {
                new SqlParameter("@CreatedBy",objPondProgressMaster.CreatedBy),
                new SqlParameter("@DistrictKey",objPondProgressMaster.DistrictKey),
                new SqlParameter("@DivisionKey",objPondProgressMaster.DivisionKey),

                new SqlParameter("@FCFemaleArea",objPondProgressMaster.FCFemaleArea),
                new SqlParameter("@FCFemaleNos",objPondProgressMaster.FCFemaleNos),
                new SqlParameter("@FCMaleArea",objPondProgressMaster.FCMaleArea),
                new SqlParameter("@FCMaleNos",objPondProgressMaster.FCMaleNos),

                new SqlParameter("@FGovtArea",objPondProgressMaster.FGovtArea),
                new SqlParameter("@FGovtNos",objPondProgressMaster.FGovtNos),

                new SqlParameter("@FinYear",objPondProgressMaster.FinYear),

                new SqlParameter("@GenFemaleArea",objPondProgressMaster.GenFemaleArea),
                new SqlParameter("@GenFemaleNos",objPondProgressMaster.GenFemaleNos),
                new SqlParameter("@GenMaleArea",objPondProgressMaster.GenMaleArea),
                new SqlParameter("@GenMaleNos",objPondProgressMaster.GenMaleNos),

                new SqlParameter("@IsActive",objPondProgressMaster.IsActive),
                new SqlParameter("@LastModifiedBy",objPondProgressMaster.LastModifiedBy),
                new SqlParameter("@MonthKey",objPondProgressMaster.MonthKey),

                new SqlParameter("@MusFemaleArea",objPondProgressMaster.MusFemaleArea),
                new SqlParameter("@MusFemaleNos",objPondProgressMaster.MusFemaleNos),

                new SqlParameter("@MusMaleArea",objPondProgressMaster.MusMaleArea),
                new SqlParameter("@MusMaleNos",objPondProgressMaster.MusMaleNos),

                new SqlParameter("@OBCFemaleArea",objPondProgressMaster.OBCFemaleArea),
                new SqlParameter("@OBCFemaleNos",objPondProgressMaster.OBCFemaleNos),
                new SqlParameter("@OBCMaleArea",objPondProgressMaster.OBCMaleArea),
                new SqlParameter("@OBCMaleNos",objPondProgressMaster.OBCMaleNos),

                new SqlParameter("@SCFemaleArea",objPondProgressMaster.SCFemaleArea),
                new SqlParameter("@SCFemaleNos",objPondProgressMaster.SCFemaleNos),

                new SqlParameter("@SchPattaArea",objPondProgressMaster.SchPattaArea),
                new SqlParameter("@SchPattaNos",objPondProgressMaster.SchPattaNos),

                new SqlParameter("@SCMaleArea",objPondProgressMaster.SCMaleArea),
                new SqlParameter("@SCMaleNos",objPondProgressMaster.SCMaleNos),

                new SqlParameter("@STFemaleArea",objPondProgressMaster.STFemaleArea),
                new SqlParameter("@STFemaleNos",objPondProgressMaster.STFemaleNos),
                new SqlParameter("@STMaleArea",objPondProgressMaster.STMaleArea),
                new SqlParameter("@STMaleNos",objPondProgressMaster.STMaleNos),

                new SqlParameter("@QueryType","INSERT")

                };
            object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "PondProgressMaster_DBLayer", objParam);
            if (obj != null && obj != DBNull.Value)
                intMstKey = Convert.ToInt32(obj);
            else
                intMstKey = 0;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return intMstKey;
    }

    public DataTable GetRptPondProgressPartFirst(string FinYear, int MonthId, int DivisionKey = 0, int DistrictKey = 0)
    {
        DataTable dt = new DataTable();
        try
        {
            if (FinYear != "")
            {
                SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@FinYear",FinYear),
                    new SqlParameter("@MonthKey",MonthId),
                    new SqlParameter("@DivisionKey",DivisionKey),
                    new SqlParameter("@DistrictKey",DistrictKey),
                    new SqlParameter("@QueryType","SELECT_POND_PATTA_PROGRESS_FIRST_FOR_REPORT"),
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "PondProgressFirstMaster_DBLayer", param);
                dt.Load(dr);

            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
        return dt;
    }
    public DataTable GetRptPondProgressPartSecond(string FinYear, int MonthId, int DivisionKey = 0, int DistrictKey = 0)
    {
        DataTable dt = new DataTable();
        try
        {
            if (FinYear != "")
            {
                SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@FinYear",FinYear),
                    new SqlParameter("@MonthKey",MonthId),
                    new SqlParameter("@DivisionKey",DivisionKey),
                    new SqlParameter("@DistrictKey",DistrictKey),
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "SP_VillagePondProgress_II", param);
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

    #region "BusinessLogic - Blue Revolution Scheme"

    public int CreateBlueRevolution(BlueRevolution objBlueRevolution)
    {
        int key = 0;
        try
        {
            SqlParameter[] objParam = new SqlParameter[] {
                new SqlParameter("@DivisionKey",objBlueRevolution.DivisionKey),
                new SqlParameter("@DistrictKey",objBlueRevolution.DistrictKey),
                new SqlParameter("@SchemeKey",objBlueRevolution.SchemeKey),
                new SqlParameter("@SchemeSubTypeKey",objBlueRevolution.SchemeSubTypeKey),
                new SqlParameter("@MonthKey",objBlueRevolution.MonthKey),
                new SqlParameter("@FinYear",objBlueRevolution.FinYear),

                new SqlParameter("@TotalApplicant",objBlueRevolution.TotalApplicant),
                  new SqlParameter("@TotalArea",objBlueRevolution.TotalArea),
                new SqlParameter("@TotalWorkStart",objBlueRevolution.TotalWorkStart),
                new SqlParameter("@TotalCompletedWork",objBlueRevolution.TotalCompletedWork),
                new SqlParameter("@TotalAllocatedAmount",objBlueRevolution.TotalAllocatedAmount),
                new SqlParameter("@TotalExpandAmount",objBlueRevolution.TotalExpandAmount),
                new SqlParameter("@TotalExpandPercent",objBlueRevolution.TotalExpandPercent),

                new SqlParameter("@IsActive",objBlueRevolution.IsActive),
                new SqlParameter("@CreatedBy",objBlueRevolution.CreatedBy),
                new SqlParameter("@QueryType","INSERT")


            };

            object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "BlueRevolution_DBLayer", objParam);
            if (obj != null && obj != DBNull.Value)
                key = Convert.ToInt32(obj);
            else
                key = 0;
        }
        catch (Exception ex)
        {

            throw ex;
        }

        return key;
    }

    public BlueRevolution Get_BlueRevolution(string FinYear, int MonthId, int DistrictKey, int SchemeKey, int SchemeSubTypeKey)
    {
        DataTable dt = new DataTable();
        BlueRevolution obj = new BlueRevolution();
        try
        {
            if (FinYear != "" && MonthId > 0 && DistrictKey > 0 && SchemeKey > 0 && SchemeSubTypeKey > 0)
            {
                SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@FinYear",FinYear),
                    new SqlParameter("@MonthKey",MonthId),
                    new SqlParameter("@DistrictKey",DistrictKey),
                    new SqlParameter("@SchemeKey",SchemeKey),
                    new SqlParameter("@SchemeSubTypeKey",SchemeSubTypeKey),
                    new SqlParameter("@QueryType","Load_BlueRevolution"),
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "BlueRevolution_DBLayer", param);
                dt.Load(dr);
                if (dt.Rows.Count > 0)
                {
                    obj.BlueRevolutionKey = Convert.ToInt64(dt.Rows[0]["BlueRevolutionKey"]);
                    obj.TotalApplicant = Convert.ToInt32(dt.Rows[0]["TotalApplicant"]);
                    obj.TotalArea = Convert.ToDecimal(dt.Rows[0]["TotalArea"]);
                    obj.TotalWorkStart = Convert.ToInt32(dt.Rows[0]["TotalWorkStart"]);
                    obj.TotalCompletedWork = Convert.ToInt32(dt.Rows[0]["TotalCompletedWork"]);
                    obj.TotalAllocatedAmount = Convert.ToDecimal(dt.Rows[0]["TotalAllocatedAmount"]);
                    obj.TotalExpandAmount = Convert.ToDecimal(dt.Rows[0]["TotalExpandAmount"]);
                }

            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
        return obj;
    }

    public DataTable GetRpt_BlueRevolution(string QueryType, string FinYear, int MonthId, int DivisionKey = 0, int DistrictKey = 0)
    {
        DataTable dt = new DataTable();
        try
        {
            if (FinYear != "" && MonthId > 0)
            {
                SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@FinYear",FinYear),
                    new SqlParameter("@DivisionKey",DivisionKey),
                    new SqlParameter("@DistrictKey",DistrictKey),
                    new SqlParameter("@MonthId",MonthId),
                    new SqlParameter("@QueryType",QueryType),
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "RPT_BlueRevolution", param);
                dt.Load(dr);
                return dt;
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
        return dt;
    }
    #endregion

    #region - BusinessLogic - Machua Awas Monthly Progress Details

    public MachuaAwasYearlyTarget GetYearlyTarget(string FinYear, int DistrictKey)
    {
        DataSet ds = new DataSet();
        MachuaAwasYearlyTarget obj = new MachuaAwasYearlyTarget();
        if (FinYear != "" && DistrictKey > 0)
        {
            SqlParameter[] paramList = new SqlParameter[3];
            paramList[0] = new SqlParameter("@QueryType", "GetYearlyTarget");
            paramList[1] = new SqlParameter("@FinYear", FinYear);
            paramList[2] = new SqlParameter("@DistrictKey", DistrictKey);
            ds = SqlHelper.ExecuteDataset(Constr, CommandType.StoredProcedure, "MachuaAwasMonthlyProgress_DBLayer", paramList);
            if (ds.Tables[0].Rows.Count > 0)
            {
                obj.DistrictKey = DistrictKey;
                obj.FinYear = FinYear;
                obj.DivisionKey = Convert.ToInt32(ds.Tables[0].Rows[0]["DivisionKey"]);
                obj.MA_YearlyTarget = Convert.ToInt32(ds.Tables[0].Rows[0]["MA_YearlyTarget"]);
                obj.YearlyTargetKey = Convert.ToInt32(ds.Tables[0].Rows[0]["YearlyTargetKey"]);
            }

        }

        return obj;
    }

    public int CreateMachuaAwasMonthlyProgress(MachuaAwasMonthlyProgress objRecord)
    {
        int key = 0;
        try
        {
            SqlParameter[] objParam = new SqlParameter[] {
                new SqlParameter("@DivisionKey",objRecord.DivisionKey),
                new SqlParameter("@DistrictKey",objRecord.DistrictKey),
                new SqlParameter("@MonthKey",objRecord.MonthKey),
                new SqlParameter("@FinYear",objRecord.FinYear),
                new SqlParameter("@YearlyTargetKey",objRecord.YearlyTargetKey),
                new SqlParameter("@YearlyTarget",objRecord.YearlyTarget),
                new SqlParameter("@AwasCompleted",objRecord.AwasCompleted),
                new SqlParameter("@AwasUnConstruction",objRecord.AwasUnConstruction),
                new SqlParameter("@AwasUntimely",objRecord.AwasUntimely),
                new SqlParameter("@AllocatedAmount",objRecord.AllocatedAmount),
                new SqlParameter("@FirstInstallment",objRecord.FirstInstallment),
                new SqlParameter("@SecondInstallment",objRecord.SecondInstallment),
                new SqlParameter("@ExpenditureAmount",objRecord.ExpenditureAmount),
                new SqlParameter("@BalanceAmount",objRecord.BalanceAmount),
                new SqlParameter("@Remarks",objRecord.Remarks),
                new SqlParameter("@IsActive",objRecord.IsActive),
                new SqlParameter("@CreatedBy",objRecord.CreatedBy),

                new SqlParameter("@QueryType","INSERT")
            };

            object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "MachuaAwasMonthlyProgress_DBLayer", objParam);
            if (obj != null && obj != DBNull.Value)
                key = Convert.ToInt32(obj);
            else
                key = 0;
        }
        catch (Exception ex)
        {

            throw ex;
        }

        return key;
    }

    public DataTable GetRpt_MachuaAwasMonthlyProgress(string QueryType, string FinYear, int MonthId, int DivisionKey = 0, int DistrictKey = 0)
    {
        DataTable dt = new DataTable();
        try
        {
            if (FinYear != "" && MonthId > 0)
            {
                SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@FinYear",FinYear),
                    new SqlParameter("@DivisionKey",DivisionKey),
                    new SqlParameter("@DistrictKey",DistrictKey),
                    new SqlParameter("@MonthId",MonthId),
                    new SqlParameter("@QueryType",QueryType),
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "RPT_MachuaAwasMonthlyProgressReport", param);
                dt.Load(dr);
                return dt;
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
        return dt;
    }
    #endregion

    #region - BusinessLogic - Seed Distribution Target

    public List<SeedDistributionTarget> GetSeedYearlyTarget(int SDObjectKey)
    {
        DataSet ds = new DataSet();
        List<SeedDistributionTarget> lst = new List<SeedDistributionTarget>();
        SqlParameter[] paramList = new SqlParameter[2];

        paramList[0] = new SqlParameter("@QueryType", "GetYearlyTarget");
        paramList[1] = new SqlParameter("@SDObjectKey", SDObjectKey);

        ds = SqlHelper.ExecuteDataset(Constr, CommandType.StoredProcedure, "SeedDistributionTarget_DBLayer", paramList);
        if (ds.Tables[0].Rows.Count > 0)
        {
            for (int i = 0; i <= ds.Tables[0].Rows.Count; i++)
            {
                SeedDistributionTarget obj = new SeedDistributionTarget();
                obj.DistrictKey = Convert.ToInt32(ds.Tables[0].Rows[i]["DistrictKey"]);
                obj.FinYear = ds.Tables[0].Rows[i]["FinYear"].ToString();
                obj.DivisionKey = Convert.ToInt32(ds.Tables[0].Rows[i]["DivisionKey"]);
                obj.DistrictName = ds.Tables[0].Rows[i]["DistrictName"].ToString();
                obj.DivisionName = ds.Tables[0].Rows[i]["DivisionName"].ToString();
                obj.NigamSeedTarget = Convert.ToInt32(ds.Tables[0].Rows[i]["NigamSeedTarget"]);
                obj.NijiSeedTarget = Convert.ToInt32(ds.Tables[0].Rows[i]["NijiSeedTarget"]);
                obj.VibhagiyaSeedTarget = Convert.ToInt32(ds.Tables[0].Rows[i]["VibhagiyaSeedTarget"]);
                obj.RearingUnitSeedTarget = Convert.ToInt32(ds.Tables[0].Rows[i]["RearingUnitSeedTarget"]);
                obj.OtherSeedTarget = Convert.ToInt32(ds.Tables[0].Rows[i]["OtherSeedTarget"]);
                obj.PangesiusSeedTarget = Convert.ToInt32(ds.Tables[0].Rows[i]["PangesiusSeedTarget"]);

                lst.Add(obj);

            }

        }

        return lst;
    }

    public DataTable GetSeedYearlyTarget_dt(string FinYear, int SDObjectKey)
    {
        DataSet ds = new DataSet();
        SqlParameter[] paramList = new SqlParameter[3];

        paramList[0] = new SqlParameter("@QueryType", "GetYearlyTarget");
        paramList[1] = new SqlParameter("@SDObjectKey", SDObjectKey);
        paramList[2] = new SqlParameter("@FinYear", FinYear);
        ds = SqlHelper.ExecuteDataset(Constr, CommandType.StoredProcedure, "SeedDistributionTarget_DBLayer", paramList);


        return ds.Tables[0];
    }

    public List<ListItem> GetSeedObject()
    {
        List<ListItem> lst = new List<ListItem>();
        try
        {
            SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, "select SDObjectKey, SDObjectName from seedDistObjectMaster Where IsActive = 1");
            using (sdr)
            {
                while (sdr.Read())
                {
                    lst.Add(new ListItem
                    {
                        Value = sdr["SDObjectKey"].ToString(),
                        Text = sdr["SDObjectName"].ToString()
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

    public DataTable GetSeedTarget_DistrictWise(string FinYear, int Districtkey, int SDObjectKey)
    {
        try
        {
            DataSet ds = new DataSet();
            SqlParameter[] paramList = new SqlParameter[4];

            paramList[0] = new SqlParameter("@QueryType", "GetSeedTarget_By_District");
            paramList[1] = new SqlParameter("@FinYear", FinYear);
            paramList[2] = new SqlParameter("@DistrictKey", Districtkey);
            paramList[3] = new SqlParameter("@SDObjectKey", SDObjectKey);
            ds = SqlHelper.ExecuteDataset(Constr, CommandType.StoredProcedure, "SeedDistributionTarget_DBLayer", paramList);


            return ds.Tables[0];
        }
        catch (Exception ex)
        {
            return null;
        }

    }

    public int CreateSeedDistributionTarget(SeedDistributionTarget objRecord)
    {
        int key = 0;
        try
        {
            SqlParameter[] objParam = new SqlParameter[] {
                new SqlParameter("@DistrictKey",objRecord.DistrictKey),
                new SqlParameter("@FinYear",objRecord.FinYear),

                new SqlParameter("@OtherSeedTarget",objRecord.OtherSeedTarget),
                new SqlParameter("@RearingUnitSeedTarget",objRecord.RearingUnitSeedTarget),
                new SqlParameter("@VibhagiyaSeedTarget",objRecord.VibhagiyaSeedTarget),
                new SqlParameter("@NijiSeedTarget",objRecord.NijiSeedTarget),
                new SqlParameter("@NigamSeedTarget",objRecord.NigamSeedTarget),           
                new SqlParameter("@PangesiusSeedTarget",objRecord.PangesiusSeedTarget),
                new SqlParameter("@SDObjectKey",objRecord.SDObjectKey),

                new SqlParameter("@IsActive",objRecord.IsActive),
                new SqlParameter("@CreatedBy",objRecord.CreatedBy),

                new SqlParameter("@QueryType","INSERT")
            };

            object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "SeedDistributionTarget_DBLayer", objParam);
            if (obj != null && obj != DBNull.Value)
                key = Convert.ToInt32(obj);
            else
                key = 0;
        }
        catch (Exception ex)
        {

            throw ex;
        }

        return key;
    }
    public int UpdateSeedDistributionTarget(SeedDistributionTarget objRecord)
    {
        int key = 0;
        try
        {
            SqlParameter[] objParam = new SqlParameter[] {
                new SqlParameter("@DivisionKey",objRecord.DivisionKey),
                new SqlParameter("@DistrictKey",objRecord.DistrictKey),
                new SqlParameter("@DistrictName",objRecord.DistrictName),
                new SqlParameter("@DivisionName",objRecord.DivisionName),
                new SqlParameter("@FinYear",objRecord.FinYear),

                new SqlParameter("@OtherSeedTarget",objRecord.OtherSeedTarget),
                new SqlParameter("@RearingUnitSeedTarget",objRecord.RearingUnitSeedTarget),
                new SqlParameter("@VibhagiyaSeedTarget",objRecord.VibhagiyaSeedTarget),
                new SqlParameter("@NijiSeedTarget",objRecord.NijiSeedTarget),
                new SqlParameter("@NigamSeedTarget",objRecord.NigamSeedTarget),
                new SqlParameter("@PangesiusSeedTarget",objRecord.PangesiusSeedTarget),

                new SqlParameter("@IsActive",objRecord.IsActive),
                new SqlParameter("@LastModifiedBy",objRecord.LastModifiedBy),
                new SqlParameter("@SeedDistributionTargetKey",objRecord.SeedDistributionTargetKey),
                new SqlParameter("@SDObjectKey",objRecord.SDObjectKey),
                new SqlParameter("@QueryType","UPDATE")
            };

            object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "SeedDistributionTarget_DBLayer", objParam);
            if (obj != null && obj != DBNull.Value)
                key = Convert.ToInt32(obj);
            else
                key = 0;
        }
        catch (Exception ex)
        {

            throw ex;
        }

        return key;
    }

    public DataTable GetRpt_SeedDistributionTarget(string QueryType, string FinYear)
    {
        DataTable dt = new DataTable();
        try
        {
            if (FinYear != "")
            {
                SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@FinYear",FinYear),
                    new SqlParameter("@QueryType",QueryType),
                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "SeedDistributionTarget_DBLayer", param);
                dt.Load(dr);
                return dt;
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
        return dt;
    }
    #endregion

    #region "BusinessLogic - Seed Distribution"
    public int CreateSeedDistribution(SeedDistributionMaster objSeedDistributionMaster)
    {
        int intMstKey = 0;
        try
        {
            string xmlDistDetails = GlobalFunctions.ConvertToXMLFormat<SeedDistributionDetail>(ref objSeedDistributionMaster.DistDetails);
            SqlParameter[] objParam = new SqlParameter[] {
                new SqlParameter("@CreatedBy",objSeedDistributionMaster.CreatedBy),
                new SqlParameter("@DistrictKey",objSeedDistributionMaster.DistrictKey),
                new SqlParameter("@DivisionKey",objSeedDistributionMaster.DivisionKey),
                new SqlParameter("@FinYear",objSeedDistributionMaster.FinYear),
                new SqlParameter("@MonthKey",objSeedDistributionMaster.MonthKey),
                new SqlParameter("@SDObjectKey",objSeedDistributionMaster.SDObjectKey),
                new SqlParameter("@xmlSeedDetail",xmlDistDetails),
                new SqlParameter("@QueryType","INSERT")
                };
            object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "SeedDistributionMaster_DBLayer", objParam);
            if (obj != null && obj != DBNull.Value)
                intMstKey = Convert.ToInt32(obj);
            else
                intMstKey = 0;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return intMstKey;
    }
    #endregion

    #region "Business Logic - Seed Stock"
     public DataTable GetSeedStockObject()
    {
        try
        {
            DataTable dt = new DataTable();
            SqlParameter[] paramList = new SqlParameter[4];

            SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.Text, "SELECT SSSubObjectKey, SSSubObjectName From [dbo].[SeedStockSubObject] Where IsActive = 1");
            dt.Load(dr);

            return dt;
        }
        catch (Exception ex)
        {
            return null;
        }

    }

     public int CreateSeedStock(SeedStockMaster objSeedStockMaster)
     {
         int intMstKey = 0;
         try
         {
             string xmlStockDetails = GlobalFunctions.ConvertToXMLFormat<SeedStockDetail>(ref objSeedStockMaster.SeedStocks);
             SqlParameter[] objParam = new SqlParameter[] {
                new SqlParameter("@CreatedBy",objSeedStockMaster.CreatedBy),
                new SqlParameter("@DistrictKey",objSeedStockMaster.DistrictKey),
                new SqlParameter("@DivisionKey",objSeedStockMaster.DivisionKey),
                new SqlParameter("@FinYear",objSeedStockMaster.FinYear),
                new SqlParameter("@MonthKey",objSeedStockMaster.MonthKey),
                new SqlParameter("@YearlyTarget",objSeedStockMaster.YearlyTarget),
                new SqlParameter("@SSObjectKey",objSeedStockMaster.SSObjectKey),
                new SqlParameter("@xmlSeedStock",xmlStockDetails),
                new SqlParameter("@QueryType","INSERT")
                };
             object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "SeedStockMaster_DBLayer", objParam);
             if (obj != null && obj != DBNull.Value)
                 intMstKey = Convert.ToInt32(obj);
             else
                 intMstKey = 0;
         }
         catch (Exception ex)
         {
             throw ex;
         }
         return intMstKey;
     }
    #endregion

     #region "Business Logic - Fish Production from All Sources"
     public List<ListItem> GetMPR_GetProdHeadMaster()
     {
         List<ListItem> lst = new List<ListItem>();
         try
         {
             SqlDataReader sdr = SqlHelper.ExecuteReader(Constr, CommandType.Text, "Select FishProdHeadKey, ProductionHeadName From MPR_FishProductionHeadMaster");
             using (sdr)
             {
                 while (sdr.Read())
                 {
                     lst.Add(new ListItem
                     {
                         Value = sdr["FishProdHeadKey"].ToString(),
                         Text = sdr["ProductionHeadName"].ToString()
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

     public DataTable GetMPR_FishproductionMonthList(string FinYear, int DistKey, int CateKey)
     {
         DataTable dtPhyEventMonthList = new DataTable();
         try
         {
             if (FinYear != "")
             {
                 SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@FinancialYear",FinYear),
                    new SqlParameter("@DistrictKey",DistKey),
                    new SqlParameter("@FishProdHeadKey",CateKey),
                    new SqlParameter("@QueryType","GET_MSR_FOR_MONTH"),
                };

                 SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "MPR_FisheryProdMaster_DBLayer", param);
                 dtPhyEventMonthList.Load(dr);
                 return dtPhyEventMonthList;
             }
         }
         catch (Exception ex)
         {

             throw ex;
         }
         return dtPhyEventMonthList;
     }

     public bool IS_MPR_FishProductionExist(int MonthId, int CategoryId, int DistrictKey, string FinancialYear)
     {
         bool blnExist = false;
         try
         {
             SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@FinancialYear",FinancialYear),
                    new SqlParameter("@MonthId",MonthId),
                    new SqlParameter("@FishProdHeadKey",CategoryId),
                    new SqlParameter("@DistrictKey",DistrictKey),
                    new SqlParameter("@QueryType","RECORD_MONTH_EXIST"),
                };

             object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "MPR_FisheryProdMaster_DBLayer", param);
             if (obj != null && obj != DBNull.Value)
                 blnExist = (Convert.ToInt32(obj) > 0 ? true : false);
             return blnExist;
         }
         catch (Exception ex)
         {
             throw ex;
         }
     }

     public int Create_MSR_FisheryProduction(MSR_FisheryProductionAllSources objMSR_FishProd)
     {
         int intMstKey = 0;
         try
         {
             string xmlFPDetail = GlobalFunctions.ConvertToXMLFormat<MSR_FisheryProductionAllSourcesDetail>(ref objMSR_FishProd.FishProdDetails);
             SqlParameter[] objParam = new SqlParameter[] {
                new SqlParameter("@DivisionKey",objMSR_FishProd.DivisionKey),
                new SqlParameter("@DistrictKey",objMSR_FishProd.DistrictKey),
                new SqlParameter("@FinancialYear",objMSR_FishProd.FinancialYear),
                new SqlParameter("@MonthId",objMSR_FishProd.MonthId),
                new SqlParameter("@FishProdHeadKey",objMSR_FishProd.FishProdHeadKey),
                new SqlParameter("@YearlyTarget",objMSR_FishProd.YearlyTaget),
                new SqlParameter("@CreatedBy",objMSR_FishProd.CreatedBy),
                new SqlParameter("@DetailXML",xmlFPDetail),
                new SqlParameter("@QueryType","INSERT")
                };
             object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "MPR_FisheryProdMaster_DBLayer", objParam);
             if (obj != null && obj != DBNull.Value)
                 intMstKey = Convert.ToInt32(obj);
             else
                 intMstKey = 0;
         }
         catch (Exception ex)
         {
             throw ex;
         }
         return intMstKey;
     }

     #endregion

     #region "BusinessLogic - RKVY Scheme"

     public int CreateRKVY(RKVY objRKVY)
     {
         int key = 0;
         try
         {
             SqlParameter[] objParam = new SqlParameter[] {
                new SqlParameter("@DivisionKey",objRKVY.DivisionKey),
                new SqlParameter("@DistrictKey",objRKVY.DistrictKey),
                new SqlParameter("@SchemeKey",objRKVY.SchemeKey),
                new SqlParameter("@SchemeSubTypeKey",objRKVY.SchemeSubTypeKey),
                new SqlParameter("@MonthKey",objRKVY.MonthKey),
                new SqlParameter("@FinYear",objRKVY.FinYear),

                new SqlParameter("@TotalApplicant",objRKVY.TotalApplicant),
                new SqlParameter("@TotalArea",objRKVY.TotalArea),
                new SqlParameter("@TotalWorkStart",objRKVY.TotalWorkStart),
                new SqlParameter("@TotalWorkUnStart",objRKVY.TotalWorkUnStart),
                new SqlParameter("@TotalCompletedWork",objRKVY.TotalCompletedWork),
                new SqlParameter("@TotalAllocatedAmount",objRKVY.TotalAllocatedAmount),
                new SqlParameter("@TotalExpandAmount",objRKVY.TotalExpandAmount),
                new SqlParameter("@TotalExpandPercent",objRKVY.TotalExpandPercent),

                new SqlParameter("@IsActive",objRKVY.IsActive),
                new SqlParameter("@CreatedBy",objRKVY.CreatedBy),
                new SqlParameter("@QueryType","INSERT")


            };

             object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "RKVY_DBLayer", objParam);
             if (obj != null && obj != DBNull.Value)
                 key = Convert.ToInt32(obj);
             else
                 key = 0;
         }
         catch (Exception ex)
         {

             throw ex;
         }

         return key;
     }

     public RKVY Get_RKVY(string FinYear, int MonthId, int DistrictKey, int SchemeKey, int SchemeSubTypeKey)
     {
         DataTable dt = new DataTable();
         RKVY obj = new RKVY();
         try
         {
             if (FinYear != "" && MonthId > 0 && DistrictKey > 0 && SchemeKey > 0 && SchemeSubTypeKey > 0)
             {
                 SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@FinYear",FinYear),
                    new SqlParameter("@MonthKey",MonthId),
                    new SqlParameter("@DistrictKey",DistrictKey),
                    new SqlParameter("@SchemeKey",SchemeKey),
                    new SqlParameter("@SchemeSubTypeKey",SchemeSubTypeKey),
                    new SqlParameter("@QueryType","Load_RKVY"),
                };

                 SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "RKVY_DBLayer", param);
                 dt.Load(dr);
                 if (dt.Rows.Count > 0)
                 {
                     obj.RKVYKey = Convert.ToInt64(dt.Rows[0]["RKVYKey"]);
                     obj.TotalApplicant = Convert.ToInt32(dt.Rows[0]["TotalApplicant"]);
                     obj.TotalArea = Convert.ToDecimal(dt.Rows[0]["TotalArea"]);
                     obj.TotalWorkStart = Convert.ToInt32(dt.Rows[0]["TotalWorkStart"]);
                     obj.TotalWorkUnStart = Convert.ToInt32(dt.Rows[0]["TotalWorkUnStart"]);
                     obj.TotalCompletedWork = Convert.ToInt32(dt.Rows[0]["TotalCompletedWork"]);
                     obj.TotalAllocatedAmount = Convert.ToDecimal(dt.Rows[0]["TotalAllocatedAmount"]);
                     obj.TotalExpandAmount = Convert.ToDecimal(dt.Rows[0]["TotalExpandAmount"]);
                 }

             }
         }
         catch (Exception ex)
         {

             throw ex;
         }
         return obj;
     }

     public DataTable GetRpt_RKVY(string QueryType, string FinYear, int MonthId, int DivisionKey = 0, int DistrictKey = 0)
     {
         DataTable dt = new DataTable();
         try
         {
             if (FinYear != "" && MonthId > 0)
             {
                 SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@FinYear",FinYear),
                    new SqlParameter("@DivisionKey",DivisionKey),
                    new SqlParameter("@DistrictKey",DistrictKey),
                    new SqlParameter("@MonthId",MonthId),
                    new SqlParameter("@QueryType",QueryType),
                };

                 SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "RPT_RKVY", param);
                 dt.Load(dr);
                 return dt;
             }
         }
         catch (Exception ex)
         {

             throw ex;
         }
         return dt;
     }


     public DataTable GetRpt_KCC(string QueryType, string FinYear, int MonthId, int DivisionKey = 0, int DistrictKey = 0)
     {
         DataTable dt = new DataTable();
         try
         {
             if (FinYear != "" && MonthId > 0)
             {
                 SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@FinYear",FinYear),
                    new SqlParameter("@DivisionKey",DivisionKey),
                    new SqlParameter("@DistrictKey",DistrictKey),
                    new SqlParameter("@MonthId",MonthId),

                };

                 SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "RPT_KisanCreditCardDetails", param);
                 dt.Load(dr);
                 return dt;
             }
         }
         catch (Exception ex)
         {

             throw ex;
         }
         return dt;
     }


     #endregion

     #region BusinessLogin - KCC Target

     public DataTable GetKCCYearlyTarget_dt(string FinYear)
     {
         DataSet ds = new DataSet();
         SqlParameter[] paramList = new SqlParameter[2];

         paramList[0] = new SqlParameter("@QueryType", "Read_KCCTarget");
         paramList[1] = new SqlParameter("@FinYear", FinYear);
         ds = SqlHelper.ExecuteDataset(Constr, CommandType.StoredProcedure, "KCCYearlyTarget_DBLayer", paramList);


         return ds.Tables[0];
     }

     public int CreateKCC_Target(KCC_Target objKCCTarget)
     {
         int intKCCTargetKey = 0;
         try
         {
             SqlParameter[] objParam = new SqlParameter[] {
                new SqlParameter("@CreatedBy",objKCCTarget.CreatedBy),
                new SqlParameter("@DistrictKey",objKCCTarget.DistrictKey),
                new SqlParameter("@KCCTarget",objKCCTarget.KCCTarget),
                new SqlParameter("@FinYear",objKCCTarget.FinYear),
  
                new SqlParameter("@QueryType","INSERT")
                };
             object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "KCCYearlyTarget_DBLayer", objParam);
             if (obj != null && obj != DBNull.Value)
                 intKCCTargetKey = Convert.ToInt32(obj);
             else
                 intKCCTargetKey = 0;
         }
         catch (Exception ex)
         {
             throw ex;
         }
         return intKCCTargetKey;
     }

     public KCC_Target GetKCC_YearlyTarget(string FinYear, int DistrictKey)
     {
         DataSet ds = new DataSet();
         KCC_Target obj = new KCC_Target();
         if (FinYear != "" && DistrictKey > 0)
         {
             SqlParameter[] paramList = new SqlParameter[3];
             paramList[0] = new SqlParameter("@QueryType", "GetKCCTarget_ByDistrict");
             paramList[1] = new SqlParameter("@FinYear", FinYear);
             paramList[2] = new SqlParameter("@DistrictKey", DistrictKey);
             ds = SqlHelper.ExecuteDataset(Constr, CommandType.StoredProcedure, "KCCYearlyTarget_DBLayer", paramList);
             if (ds.Tables[0].Rows.Count > 0)
             {
                 obj.DistrictKey = DistrictKey;
                 obj.FinYear = FinYear;
                 obj.KCCTarget = Convert.ToInt32(ds.Tables[0].Rows[0]["KCCTarget"]);

             }

         }

         return obj;
     }

     public int CreateKCCMonthlyProgress(KCCMonthlyProgress objRecord)
     {
         int key = 0;
         try
         {
             SqlParameter[] objParam = new SqlParameter[] {
                new SqlParameter("@DistrictKey",objRecord.DistrictKey),
                new SqlParameter("@MonthKey",objRecord.MonthKey),
                new SqlParameter("@FinYear",objRecord.FinYear),
                new SqlParameter("@TotalTarget",objRecord.TotalTarget),
                new SqlParameter("@PastMonthTotalCard",objRecord.PastMonthTotalCard),
                new SqlParameter("@PastMonthTotalAmount",objRecord.PastMonthTotalAmount),
                new SqlParameter("@CurrentMonthTotalCard",objRecord.CurrentMonthTotalCard),
                new SqlParameter("@CurrentMonthTotalAmount",objRecord.CurrentMonthTotalAmount),
                new SqlParameter("@IsActive",objRecord.IsActive),
                new SqlParameter("@CreatedBy",objRecord.CreatedBy),
                new SqlParameter("@QueryType","INSERT_KCCMonthlyProgress")
            };

             object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "KCCYearlyTarget_DBLayer", objParam);
             if (obj != null && obj != DBNull.Value)
                 key = Convert.ToInt32(obj);
             else
                 key = 0;
         }
         catch (Exception ex)
         {

             throw ex;
         }

         return key;
     }

     public KCC_PastMonth GetKCC_PastMonth(string FinYear, int DistrictKey)
     {
         DataSet ds = new DataSet();
         KCC_PastMonth obj = new KCC_PastMonth();
         if (FinYear != "" && DistrictKey > 0)
         {
             SqlParameter[] paramList = new SqlParameter[3];
             paramList[0] = new SqlParameter("@QueryType", "KCCPastMonthProgress");
             paramList[1] = new SqlParameter("@FinYear", FinYear);
             paramList[2] = new SqlParameter("@DistrictKey", DistrictKey);
             ds = SqlHelper.ExecuteDataset(Constr, CommandType.StoredProcedure, "KCCYearlyTarget_DBLayer", paramList);
             if (ds.Tables[0].Rows.Count > 0)
             {
                 obj.PastMonthTotalCard = Convert.ToInt32(ds.Tables[0].Rows[0]["PastMonthTotalCard"]);
                 obj.PastMonthTotalAmount = Convert.ToDecimal(ds.Tables[0].Rows[0]["PastMonthTotalAmount"]);

             }

         }

         return obj;
     }
     #endregion

   

     #region "Business Logic - Pond Grade Wise Nistarn Progress"
     public int CreatePondGrdNistarnProg(PondGrdNistarnProgMaster objPondGrdNistarnProgMaster)
     {
         int intMstKey = 0;
         try
         {
             SqlParameter[] objParam = new SqlParameter[] {
                    new SqlParameter("@FinYear",objPondGrdNistarnProgMaster.FinYear),
                    new SqlParameter("@MonthKey",objPondGrdNistarnProgMaster.MonthKey),
                    new SqlParameter("@DistrictKey",objPondGrdNistarnProgMaster.DistrictKey),

                    new SqlParameter("@GRGradeOne",objPondGrdNistarnProgMaster.GRGradeOne),
                    new SqlParameter("@GRGradeTwo",objPondGrdNistarnProgMaster.GRGradeTwo),
                    new SqlParameter("@GRGradeThree",objPondGrdNistarnProgMaster.GRGradeThree),
                    new SqlParameter("@GRGradeFour",objPondGrdNistarnProgMaster.GRGradeFour),
                    new SqlParameter("@GRGradeOneFourTotal",objPondGrdNistarnProgMaster.GRGradeOneFourTotal),
                    new SqlParameter("@GRGradeFive",objPondGrdNistarnProgMaster.GRGradeFive),
                    new SqlParameter("@GRAistanNos",objPondGrdNistarnProgMaster.GRAistanNos),
                    new SqlParameter("@GRPondNos",objPondGrdNistarnProgMaster.GRPondNos),

                     new SqlParameter("@NSGradeOne",objPondGrdNistarnProgMaster.NSGradeOne),
                    new SqlParameter("@NSGradeTwo",objPondGrdNistarnProgMaster.NSGradeTwo),
                    new SqlParameter("@NSGradeThree",objPondGrdNistarnProgMaster.NSGradeThree),
                    new SqlParameter("@NSGradeFour",objPondGrdNistarnProgMaster.NSGradeFour),
                    new SqlParameter("@NSGradeOneTFourTotal",objPondGrdNistarnProgMaster.NSGradeOneTFourTotal),
                    new SqlParameter("@NSGradeFive",objPondGrdNistarnProgMaster.NSGradeFive),
                    new SqlParameter("@NSAistanNos",objPondGrdNistarnProgMaster.NSAistanNos),
                    new SqlParameter("@NSPondNos",objPondGrdNistarnProgMaster.NSPondNos),

                    new SqlParameter("@ANSGradeOne",objPondGrdNistarnProgMaster.ANSGradeOne),
                    new SqlParameter("@ANSGradeTwo",objPondGrdNistarnProgMaster.ANSGradeTwo),
                    new SqlParameter("@ANSGradeThree",objPondGrdNistarnProgMaster.ANSGradeThree),
                    new SqlParameter("@ANSGradeFour",objPondGrdNistarnProgMaster.ANSGradeFour),
                    new SqlParameter("@ANSGradeOneTFourTotal",objPondGrdNistarnProgMaster.ANSGradeOneTFourTotal),
                    new SqlParameter("@ANSGradeFive",objPondGrdNistarnProgMaster.ANSGradeFive),
                    new SqlParameter("@ANSAistanNos",objPondGrdNistarnProgMaster.ANSAistanNos),
                    new SqlParameter("@ANSPondNos",objPondGrdNistarnProgMaster.ANSPondNos),

                    new SqlParameter("@IsActive",objPondGrdNistarnProgMaster.IsActive),
                    new SqlParameter("@CreatedBy",objPondGrdNistarnProgMaster.CreatedBy),
                    new SqlParameter("@QueryType","INSERT")
                };
             object obj = SqlHelper.ExecuteScalar(Constr, CommandType.StoredProcedure, "PondGrdNistarnProgMaster_DBLayer", objParam);
             if (obj != null && obj != DBNull.Value)
                 intMstKey = Convert.ToInt32(obj);
             else
                 intMstKey = 0;
         }
         catch (Exception ex)
         {
             throw ex;
         }
         return intMstKey;
     }
     public DataTable GetRptPondGrdNistarnProg(string FinYear, int MonthId, int DivisionKey = 0, int DistrictKey = 0)
     {
         DataTable dt = new DataTable();
         try
         {
             if (FinYear != "")
             {
                 SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@FinYear",FinYear),
                    new SqlParameter("@MonthKey",MonthId),
                    new SqlParameter("@DivisionKey",DivisionKey),
                    new SqlParameter("@DistrictKey",DistrictKey),
                };

                 SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "SP_DepartmentalGradePondNistarn", param);
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


    public DataTable GetRpt_SansadAdarshGramYojnaDetails(string QueryType, string FinYear, int MonthId, int DivisionKey = 0, int DistrictKey = 0)
    {
        DataTable dt = new DataTable();
        try
        {
            if (FinYear != "" && MonthId > 0)
            {
                SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@FinYear",FinYear),
                    new SqlParameter("@DivisionKey",DivisionKey),
                    new SqlParameter("@DistrictKey",DistrictKey),
                    new SqlParameter("@MonthId",MonthId),

                };

                SqlDataReader dr = SqlHelper.ExecuteReader(Constr, CommandType.StoredProcedure, "RPT_SansadAdarshGramYojnaDetails", param);
                dt.Load(dr);
                return dt;
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
        return dt;
    }
}