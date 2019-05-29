using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FisheriesMIS.App_Code
{
    public class UserMaster
    {
        public Int16 UserKey { get; set; }

        public Int16 UserType { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public Int16 OfficerKey { get; set; }
        public String OfficerName { get; set; }      //Other
        public String SectorName { get; set; }
        public Boolean IsActive { get; set; }
        public Int16 CreatedBy { get; set; }
        public Int16 LastModifiedBy { get; set; }
        public DateTime CreatedOn { get; set; }
        public DateTime LastModifiedOn { get; set; }
    }
}