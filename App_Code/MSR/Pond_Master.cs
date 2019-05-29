using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


public class Pond_Master
{
    public Int64 Pondkey { get; set; }

    public Int64? DistrictKey { get; set; }

    public string PondName { get; set; }

    public bool? IsActive { get; set; }

    public DateTime? CreatedOn { get; set; }

    public int? CreatedBy { get; set; }

    public DateTime? LastModifiedOn { get; set; }

    public int? LastModifiedBy { get; set; }

}
