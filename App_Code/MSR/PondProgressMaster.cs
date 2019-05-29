using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for PondProgressMaster
/// </summary>
public class PondProgressMaster
{
    public Int64 PondProgMstKey { get; set; }

    public string FinYear { get; set; }

    public int? MonthKey { get; set; }

    public int? DistrictKey { get; set; }

    public int? DivisionKey { get; set; }

    public decimal? SchPattaNos { get; set; }

    public decimal? SchPattaArea { get; set; }

    public decimal? FCMaleNos { get; set; }

    public decimal? FCMaleArea { get; set; }

    public decimal? FCFemaleNos { get; set; }

    public decimal? FCFemaleArea { get; set; }

    public decimal? FGovtNos { get; set; }

    public decimal? FGovtArea { get; set; }

    public decimal? SCMaleNos { get; set; }

    public decimal? SCMaleArea { get; set; }

    public decimal? SCFemaleNos { get; set; }

    public decimal? SCFemaleArea { get; set; }

    public decimal? STMaleNos { get; set; }

    public decimal? STMaleArea { get; set; }

    public decimal? STFemaleNos { get; set; }

    public decimal? STFemaleArea { get; set; }

    public decimal? OBCMaleNos { get; set; }

    public decimal? OBCMaleArea { get; set; }

    public decimal? OBCFemaleNos { get; set; }

    public decimal? OBCFemaleArea { get; set; }

    public decimal? MusMaleNos { get; set; }

    public decimal? MusMaleArea { get; set; }

    public decimal? MusFemaleNos { get; set; }

    public decimal? MusFemaleArea { get; set; }

    public decimal? GenMaleNos { get; set; }

    public decimal? GenMaleArea { get; set; }

    public decimal? GenFemaleNos { get; set; }

    public decimal? GenFemaleArea { get; set; }

    public bool? IsActive { get; set; }

    public Int64 CreatedBy { get; set; }

    public int? LastModifiedBy { get; set; }

}
