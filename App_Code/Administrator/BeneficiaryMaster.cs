using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

public class BeneficiaryMaster
{
    
    public Int64 MasterId { get; set; }
    public string EffectiveDate { get; set; }

    public bool IsWomen { get; set; }

    public int Category { get; set; }

    public decimal BShare { get; set; }

    public decimal CShare { get; set; }

    public decimal SShare { get; set; }

    public bool IsActive { get; set; }

    public string CreationDate { get; set; }
   
    public Int64 CreatedBy { get; set; }

    public string ModifiedDate { get; set; }

    public Int64? ModifiedBy { get; set; }

    public ICollection<BeneficiaryScheme> BeneficiarySchemes;

}