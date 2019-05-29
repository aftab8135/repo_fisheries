using System.Web;

namespace DBLibrary
{
	public sealed class CnSettings
	{
        public static string connectionStr = null;

        private CnSettings()
		{			 
		}

		public static string cnString1 
		{
			get
			{
                string cn = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStr"].ConnectionString;
                return connectionStr;
			}
		}	
	}
}
			