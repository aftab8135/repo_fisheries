using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for SeedDistributionTarget
/// </summary>
public class SeedDistributionTarget
{
    public int SeedDistributionTargetKey { get; set; }

    public int SDObjectKey { get; set; }

    public string FinYear { get; set; }

    public int? DistrictKey { get; set; }

    public string DistrictName { get; set; }

    public int? DivisionKey { get; set; }

    public string DivisionName { get; set; }

    public decimal? NigamSeedTarget { get; set; }

    public decimal? VibhagiyaSeedTarget { get; set; }

    public decimal? NijiSeedTarget { get; set; }

    public decimal? RearingUnitSeedTarget { get; set; }

    public decimal? OtherSeedTarget { get; set; }

    public decimal? PangesiusSeedTarget { get; set; }

    public bool? IsActive { get; set; }

    public DateTime? CreatedOn { get; set; }

    public int? CreatedBy { get; set; }

    public int? LastModifiedBy { get; set; }

    public DateTime? LastModifiedOn { get; set; }

}