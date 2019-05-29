using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for UserMaster
/// </summary>
public class UserMaster
{
    public Int64 UserKey { get; set; }

    public Int64? UserType { get; set; }

    public int? OfficeKey { get; set; }

    public string Name { get; set; }

    public string Gender { get; set; }

    public string UserName { get; set; }

    public string Password { get; set; }

    public int? DistrictKey { get; set; }

    public string PinCode { get; set; }

    public string ContactPName { get; set; }

    public string ContactPDesignation { get; set; }

    public string OfficeAddress { get; set; }

    public string City { get; set; }

    public string MobileNo { get; set; }

    public string PhoneNo { get; set; }

    public string EmailID { get; set; }

    public string Fax { get; set; }

    public Int64? CreatedBy { get; set; }

    public DateTime? CreatedOn { get; set; }

    public Int64? LastModifiedBy { get; set; }

    public DateTime? LastModifiedOn { get; set; }

    public bool? IsActive { get; set; }

    public bool? IsPasswordChange { get; set; }

}