using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for VillageName
/// </summary>

    public class Village
    {
        public Int64 VillageKey { get; set; }
        public Int64 BlockKey { get; set; }
        public String EnglishName { get; set; }
        public String HindiName { get; set; }
        public bool IsActive { get; set; }
        public Int64 CreatedBy { get; set; }
        public DateTime CreatedOn { get; set; }
        public Int64? LastModifiedBy { get; set; }
        public DateTime LastModifiedOn { get; set; }
    }
