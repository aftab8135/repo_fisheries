using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

public class SchemeMaster
{
    public Int64 SchemeKey { get; set; }

    [Required]
    public Int64 SchemeTypeKey { get; set; }

    [Required]
    [StringLength(50, MinimumLength = 4)]
    public string SchemeCode { get; set; }

    [Required]
    [StringLength(50, MinimumLength = 4)] 
    public string SchemeName { get; set; }

    [Required]
    [StringLength(500, MinimumLength = 10)] 
    public string Description { get; set; }

    [Required]
    [StringLength(50, MinimumLength = 5)] 
    public string GuidelinesUrl { get; set; }

    [Required]
    [StringLength(10, MinimumLength = 10)] 
    public string Start_date { get; set; }

    [Required]
    [StringLength(10, MinimumLength = 10)] 
    public string End_Date { get; set; }

    public string FY_Year { get; set; }

    public bool? IsActive { get; set; }

    public Int64 CreatedBy { get; set; }

    public DateTime? CreatedOn { get; set; }

    public Int64 LastModifiedBy { get; set; }

    public DateTime? LastModifiedOn { get; set; }

    public ICollection<SchemeDocument> Documents;

}