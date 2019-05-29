using System;
using System.Web;
using System.Net;
using System.Web.UI.WebControls;
using System.ComponentModel;
using System.Collections.Generic;
using System.IO;
using System.Net.Mail;
using System.Configuration;
using System.Xml;
using System.Reflection;

public class GlobalFunctions
{
    public GlobalFunctions()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static string ChopStringWithLen(string strName, int Len)
    {
        if (strName.Length > Len)
            return (strName.Substring(0, Len) + "...");
        else
            return strName;
    }

    public static string ChangeHindiTextForLikeOperation(string strName)
    {
        // û - (Alt + 0251)

        strName = strName.Trim().Replace("'", "''");
        strName = strName.Trim().Replace("%", "û%");
        strName = strName.Trim().Replace("_", "û_");
        strName = strName.Trim().Replace("[", "û[");
        strName = strName.Trim().Replace("[", "û]");
        return strName;
    }

    public static void UploadFile(FileUpload fileControl, string direcoryName, string newFileName)
    {
        try
        {
            if (System.IO.Directory.Exists(HttpContext.Current.Server.MapPath("~/" + direcoryName + "/")) == false)
                System.IO.Directory.CreateDirectory(HttpContext.Current.Server.MapPath("~/" + direcoryName + "/"));

            try
            {
                fileControl.PostedFile.SaveAs(HttpContext.Current.Server.MapPath("~/" + direcoryName + "/") + newFileName);
            }
            catch
            {
                if (System.IO.Directory.Exists(HttpContext.Current.Server.MapPath("~/" + direcoryName + "/" + newFileName)))
                    System.IO.File.Delete(HttpContext.Current.Server.MapPath("~/" + direcoryName + "/") + newFileName);

                throw new Exception("Error during Upload Process!");
            }
        }
        catch (Exception ex)
        {
            // new ExceptionAndEventHandling(ex);
            throw new Exception("Error during Upload Process!");
        }
    }

    public static void DeleteFile(string direcoryName, string newFileName)
    {
        try
        {
            if (System.IO.Directory.Exists(HttpContext.Current.Server.MapPath("~/" + direcoryName + "/")))
                if (System.IO.File.Exists(HttpContext.Current.Server.MapPath("~/" + direcoryName + "/") + newFileName))
                    System.IO.File.Delete(HttpContext.Current.Server.MapPath("~/" + direcoryName + "/") + newFileName);
        }
        catch (Exception ex)
        {
            // new ExceptionAndEventHandling(ex);
            throw new Exception("Error during Deletion of File!");
        }
    }

    public static string GetUniqueFileName(string filename)
    {
        try
        {
            string[] ext = filename.Split('.');
            return ext[0] + Guid.NewGuid().ToString() + "." + ext[ext.Length - 1];
        }
        catch (Exception ex)
        {
            //  new ExceptionAndEventHandling(ex);
            return ex.ToString();
        }
    }

    public string GetUniqueFilename(string folder, string postedFileName)
    {
        string fileExtension = postedFileName.Substring(postedFileName.LastIndexOf('.') + 1);
        int index = 2;

        while (System.IO.File.Exists(HttpContext.Current.Server.MapPath("~/" + folder + "/" + postedFileName)))
        {
            if (index == 2)
                postedFileName =
                    string.Format("{0} ({1}).{2}",
                                  postedFileName.Substring(0, postedFileName.LastIndexOf('.')),
                                  index,
                                  fileExtension);
            else
                postedFileName =
                    string.Format("{0} ({1}).{2}",
                                  postedFileName.Substring(0, postedFileName.LastIndexOf(' ')),
                                  index,
                                  fileExtension);
            index++;
        }

        return postedFileName;
    }

    public static String ConvertToXMLFormat<T>(ref ICollection<T> list)
    {
        XmlDocument doc = new XmlDocument();
        XmlNode node = doc.CreateNode(XmlNodeType.Element, string.Empty, "root", null);

        foreach (T xml in list)
        {
            XmlElement element = doc.CreateElement("data");
            PropertyInfo[] allProperties = xml.GetType().GetProperties();
            foreach (PropertyInfo thisProperty in allProperties)
            {
                object value = thisProperty.GetValue(xml, null);
                XmlElement tmp = doc.CreateElement(thisProperty.Name);
                if (value != null)
                {
                    tmp.InnerXml = value.ToString();
                }
                else
                {
                    tmp.InnerXml = string.Empty;
                }
                element.AppendChild(tmp);
            }
            node.AppendChild(element);
        }
        doc.AppendChild(node);
        return doc.InnerXml;
    }

    public static String ConvertToXMLFormat<T>(ref List<T> list)
    {
        XmlDocument doc = new XmlDocument();
        XmlNode node = doc.CreateNode(XmlNodeType.Element, string.Empty, "root", null);

        foreach (T xml in list)
        {
            XmlElement element = doc.CreateElement("data");
            PropertyInfo[] allProperties = xml.GetType().GetProperties();
            foreach (PropertyInfo thisProperty in allProperties)
            {
                object value = thisProperty.GetValue(xml, null);
                XmlElement tmp = doc.CreateElement(thisProperty.Name);
                if (value != null)
                {
                    tmp.InnerXml = value.ToString();
                }
                else
                {
                    tmp.InnerXml = string.Empty;
                }
                element.AppendChild(tmp);
            }
            node.AppendChild(element);
        }
        doc.AppendChild(node);
        return doc.InnerXml;
    }

    public static string GetCalendarYear(DateTime Date)
    {
        if (Date.Month <= 3)
            return (string.Concat((Date.Year - 1) + "-", Date.Year));
        else
            return (string.Concat(Date.Year + "-", (Date.Year + 1)));
    }

    public static string AmountConvertToWord(double amt)
    {
        string AmountConvertToWord = "";
        if (amt > 0)
            AmountConvertToWord = rs_val(amt % 10000000, 100000, "Lacs ") + rs_val(amt % 100000, 1000, "Thousand ") + rs_val(amt % 1000, 100, "Hundred ") + rs_val(amt % 100, 1, " ") + " Rupee Only";
        else
            AmountConvertToWord = "Zero only.";

        return AmountConvertToWord;
    }

    private static string rs_val(double rs, double div, string unit)
    {
        string rs_val = "";
        int ll;
        ll = Convert.ToInt32(Math.Floor(rs / div));
        if (ll > 0)
            rs_val = english_no(ll) + " " + unit;
        else
            rs_val = "";

        return rs_val;
    }

    public static string GetPropertyDescription(Enum objEnum)
    {
        string retVal = "";

        System.Reflection.FieldInfo fi = objEnum.GetType().GetField(objEnum.ToString());
        DescriptionAttribute[] attributes = (DescriptionAttribute[])fi.GetCustomAttributes(typeof(DescriptionAttribute), false);

        if (attributes != null && attributes.Length > 0)
        {
            retVal = attributes[0].Description;
        }
        return retVal;
    }

    private static string english_no(int num)
    {
        string english_no = "";
        switch (num)
        {
            case 1:
                english_no = "One"; break;
            case 2:
                english_no = "Two"; break;
            case 3:
                english_no = "Three";
                break;
            case 4:
                english_no = "Four";
                break;
            case 5:
                english_no = "Five";
                break;
            case 6:
                english_no = "Six";
                break;
            case 7:
                english_no = "Seven";
                break;
            case 8:
                english_no = "Eight";
                break;
            case 9:
                english_no = "Nine";
                break;
            case 10:
                english_no = "Ten";
                break;
            case 11:
                english_no = "Eleven";
                break;
            case 12:
                english_no = "Twelve";
                break;
            case 13:
                english_no = "Thirteen";
                break;
            case 14:
                english_no = "Fourteen";
                break;
            case 15:
                english_no = "Fifteen";
                break;
            case 16:
                english_no = "Sixteen";
                break;
            case 17:
                english_no = "Seventeen";
                break;
            case 18:
                english_no = "Eighteen";
                break;
            case 19:
                english_no = "Ninteen";
                break;
            case 20:
                english_no = "Twenty";
                break;
            case 21:
                english_no = "Twenty One";
                break;
            case 22:
                english_no = "Twenty Two";
                break;
            case 23:
                english_no = "Twenty Three";
                break;
            case 24:
                english_no = "Twenty Four";
                break;
            case 25:
                english_no = "Twenty Five";
                break;
            case 26:
                english_no = "Twenty Six";
                break;
            case 27:
                english_no = "Twenty Seven";
                break;
            case 28:
                english_no = "Twenty Eight";
                break;
            case 29:
                english_no = "Twenty Nine";
                break;
            case 30:
                english_no = "Thirty";
                break;
            case 31:
                english_no = "Thirty One";
                break;
            case 32:
                english_no = "Thirty Two";
                break;
            case 33:
                english_no = "Thirty Three";
                break;
            case 34:
                english_no = "Thirty Four";
                break;
            case 35:
                english_no = "Thirty Five";
                break;
            case 36:
                english_no = "Thirty Six";
                break;
            case 37:
                english_no = "Thirty Seven";
                break;
            case 38:
                english_no = "Thirty Eight";
                break;
            case 39:
                english_no = "Thirty Nine";
                break;
            case 40:
                english_no = "Fourty";
                break;
            case 41:
                english_no = "Fourty One";
                break;
            case 42:
                english_no = "Fourty Two";
                break;
            case 43:
                english_no = "Fourty Three";
                break;
            case 44:
                english_no = "Fourty Four";
                break;
            case 45:
                english_no = "Fourty Five";
                break;
            case 46:
                english_no = "Fourty Six";
                break;
            case 47:
                english_no = "Fourty Seven";
                break;
            case 48:
                english_no = "Fourty Eight";
                break;
            case 49:
                english_no = "Fourty Nine";
                break;
            case 50:
                english_no = "Fifty";
                break;
            case 51:
                english_no = "Fifty One";
                break;
            case 52:
                english_no = "Fifty Two";
                break;
            case 53:
                english_no = "Fifty Three";
                break;
            case 54:
                english_no = "Fifty Four";
                break;
            case 55:
                english_no = "Fifty Five";
                break;
            case 56:
                english_no = "Fifty Six";
                break;
            case 57:
                english_no = "Fifty Seven";
                break;
            case 58:
                english_no = "Fifty Eight";
                break;
            case 59:
                english_no = "Fifty Nine";
                break;
            case 60:
                english_no = "Sixty";
                break;
            case 61:
                english_no = "Sixty One";
                break;
            case 62:
                english_no = "Sixty Two";
                break;
            case 63:
                english_no = "Sixty Three";
                break;
            case 64:
                english_no = "Sixty Four";
                break;
            case 65:
                english_no = "Sixty Five";
                break;
            case 66:
                english_no = "Sixty Six";
                break;
            case 67:
                english_no = "Sixty Seven";
                break;
            case 68:
                english_no = "Sixty Eight";
                break;
            case 69:
                english_no = "Sixty Nine";
                break;
            case 70:
                english_no = "Seventy";
                break;
            case 71:
                english_no = "Seventy One";
                break;
            case 72:
                english_no = "Seventy Two";
                break;
            case 73:
                english_no = "Seventy Three";
                break;
            case 74:
                english_no = "Seventy Four";
                break;
            case 75:
                english_no = "Seventy Five";
                break;
            case 76:
                english_no = "Seventy Six";
                break;
            case 77:
                english_no = "Seventy Seven";
                break;
            case 78:
                english_no = "Seventy Eight";
                break;
            case 79:
                english_no = "Seventy Nine";
                break;
            case 80:
                english_no = "Eighty";
                break;
            case 81:
                english_no = "Eighty One";
                break;
            case 82:
                english_no = "Eighty Two";
                break;
            case 83:
                english_no = "Eighty Three";
                break;
            case 84:
                english_no = "Eighty Four";
                break;
            case 85:
                english_no = "Eighty Five";
                break;
            case 86:
                english_no = "Eighty Six";
                break;
            case 87:
                english_no = "Eighty Seven";
                break;
            case 88:
                english_no = "Eighty Eight";
                break;
            case 89:
                english_no = "Eighty Nine";
                break;
            case 90:
                english_no = "Ninty";
                break;
            case 91:
                english_no = "Ninty One";
                break;
            case 92:
                english_no = "Ninty Two";
                break;
            case 93:
                english_no = "Ninty Three";
                break;
            case 94:
                english_no = "Ninty Four";
                break;
            case 95:
                english_no = "Ninty Five";
                break;
            case 96:
                english_no = "Ninty Six";
                break;
            case 97:
                english_no = "Ninty Seven";
                break;
            case 98:
                english_no = "Ninty Eight";
                break;
            case 99:
                english_no = "Ninty Nine";
                break;
        }
        return english_no;
    }

    public static string Get_MonthName(int num)
    {
        string month_name = "";
        switch (num)
        {
            case 1:
                month_name = "January"; break;
            case 2:
                month_name = "February"; break;
            case 3:
                month_name = "March";
                break;
            case 4:
                month_name = "April";
                break;
            case 5:
                month_name = "MAy";
                break;
            case 6:
                month_name = "June";
                break;
            case 7:
                month_name = "July";
                break;
            case 8:
                month_name = "August";
                break;
            case 9:
                month_name = "September";
                break;
            case 10:
                month_name = "October";
                break;
            case 11:
                month_name = "November";
                break;
            case 12:
                month_name = "December";
                break;
        }
        return month_name;
    }

    public static string GetSMSBalance()
    {
        try
        {
            //string WFLocation = "http://www.infyrupeeonline.com/bliss/SMSCredits.asp?UserCode=SW001-24324-67733-35409-41679&SenderId=ISACON10";
            //string location = WFLocation;
            //HttpWebRequest req = (HttpWebRequest)WebRequest.Create(location);
            //HttpWebResponse resp = (HttpWebResponse)req.GetResponse();
            //System.IO.StreamReader sr = new System.IO.StreamReader(resp.GetResponseStream());
            //string results = sr.ReadToEnd();
            //sr.Close();
            //return results;
            return null;
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }

    public static string SendSMS(string mobileNo, string message, string senderName)
    {
        try
        {
            System.Text.StringBuilder WFLocation = new System.Text.StringBuilder();
            string[] mobileNos = mobileNo.Split(',');
            string results = null;

            foreach (string mb in mobileNos)
            {
                WFLocation = new System.Text.StringBuilder();
                //WFLocation.AppendFormat("http://www.infyrupeeonline.com/bliss/SendWebSMS.asp?UserCode={0}&SenderId={1}", "SW001-24324-67733-35409-41679", HttpContext.Current.Server.UrlEncode(senderName));
                //WFLocation.AppendFormat("&Mobile=+91{0}&Message={1}&Type=N", HttpContext.Current.Server.UrlEncode(mb.Trim()), HttpContext.Current.Server.UrlEncode(message));

                HttpWebRequest req = (HttpWebRequest)WebRequest.Create(WFLocation.ToString());
                HttpWebResponse resp = (HttpWebResponse)req.GetResponse();
                System.IO.StreamReader sr = new System.IO.StreamReader(resp.GetResponseStream());

                string response = sr.ReadToEnd();
                if (response.Equals("01-True"))
                    results += "";
                else
                    results += mb + ":" + response;
                sr.Close();
            }

            return results;
        }
        catch (Exception ex)
        {
            return "false";
        }
    }

    public static void SendSMSN(String Message, string Mobile_Number)
    {

        //string stringpost = "http://marg.sms-center.co.in/api/sendmsg.php?user=margdemo&pass=S$K8fd@asd3!8&sender=MARGSD&phone=" + Mobile_Number + "&text=" + Message + "&priority=ndnd&stype=normal";

        string stringpost = "http://api.sss.bz/smpp?username=swgida&password=swgida2017&from=GIDAUP&to=91" + Mobile_Number + "&text=" + Message;
        try
        {
            HttpWebRequest httpreq = (HttpWebRequest)WebRequest.Create(stringpost);
            try
            {
                HttpWebResponse httpres = (HttpWebResponse)httpreq.GetResponse();
                StreamReader sr = new StreamReader(httpres.GetResponseStream());
                string results = sr.ReadToEnd();
                sr.Close();

            }
            catch
            {

            }
        }
        catch (Exception ex)
        {
            // return (ex.ToString());
        }
    }

    public static void SendMail(string sendTo, string body, string subject)
    {
        try
        {
            string server = Convert.ToString(ConfigurationManager.ConnectionStrings["ServerName"].ConnectionString);
            string userID = Convert.ToString(ConfigurationManager.ConnectionStrings["UserName"].ConnectionString);
            string password = Convert.ToString(ConfigurationManager.ConnectionStrings["Password"].ConnectionString);

            System.Net.Mail.MailMessage mail = new System.Net.Mail.MailMessage();
            mail.To.Add(sendTo);
            mail.From = new MailAddress(userID);
            mail.Subject = subject;
            mail.Body = body.ToString();
            mail.IsBodyHtml = true;
            SmtpClient smtp = new SmtpClient(server);
            smtp.Host = server;
            smtp.Port = 25;
            smtp.UseDefaultCredentials = false;
            smtp.Credentials = new System.Net.NetworkCredential(userID, password);
            smtp.EnableSsl = false;
            smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
            smtp.Send(mail);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    public static void AddMonthInNumberToDropDownList(DropDownList ddlList)
    {
        for (int i = 1; i <= 12; i++)
        {
            if (i < 10)
                ddlList.Items.Add(new ListItem("0" + i.ToString(), i.ToString()));
            else
                ddlList.Items.Add(new ListItem(i.ToString(), i.ToString()));
        }
        ddlList.Items.Insert(0, new ListItem("Select", "0"));
        ddlList.SelectedValue = "0";
    }

    public static System.Collections.ArrayList GetFinYearArrayList(string prevFinYears)
    {
        System.Collections.ArrayList arrList = new System.Collections.ArrayList();
        string[] strArrFinYear = prevFinYears.Split(',');
        for (int i = 0; i < strArrFinYear.Length; i++)
        {
            arrList.Add(strArrFinYear[i]);
        }
        return arrList;
    }

    public static void SendSMS(string mobs, string msg)
    {
        //string results = "";
        try
        {
            if (!string.IsNullOrEmpty(mobs))
            {
                // string location = "http://203.129.203.243/sms/user/urlsms.php?username=margsoftdemo&pass=marg&senderid=UPPCFL&dest_mobileno=" + mobs + "&message=" + msg + "&msgType=UNI&response=Y";
                string location = "http://203.129.203.243/sms/user/urlsms.php?username=margsoftdemo&pass=marg&senderid=BCMLTD&dest_mobileno=" + mobs + "&message=" + msg + "&msgType=UNI&response=Y";
                HttpWebRequest req = (HttpWebRequest)WebRequest.Create(location);
                req.GetResponse().Close();
                req.Abort();

                //StreamReader sr = new StreamReader(resp.GetResponseStream());
                //results = sr.ReadToEnd();
                //sr.Close();
            }
        }

        catch (Exception ex)
        {
            throw new Exception("Message Sending Error Occured!");
        }

        //return results;
    }

    // Eliminate special ecape character.
    private string Unquote(string strVal)
    {
        if (strVal == null) return "";
        return strVal.Replace("'", "''");
    }

    // Get Integer value from object.
    private char GetChar(object objVal)
    {
        char charValue;
        if (objVal == null) return '\0';
        if (objVal is DBNull) return '\0';
        if (objVal is char) return (char)objVal;
        char.TryParse(objVal.ToString(), out charValue);
        return charValue;
    }

    // Get Integer value from object.
    private int GetInteger(object objVal)
    {
        int intValue = 0;
        if (objVal == null) return 0;
        if (objVal is DBNull) return 0;
        if (objVal is int) return (int)objVal;
        int.TryParse(objVal.ToString(), out intValue);
        return intValue;
    }

    // Get Integer value from object.
    private Int64 GetInt64(object objVal)
    {
        Int64 intValue = 0;
        if (objVal == null) return 0;
        if (objVal is DBNull) return 0;
        if (objVal is Int64) return (Int64)objVal;
        Int64.TryParse(objVal.ToString(), out intValue);
        return intValue;
    }

    // Get Integer value from object.
    private Int16 GetInt16(object objVal)
    {
        Int16 intValue = 0;
        if (objVal == null) return 0;
        if (objVal is DBNull) return 0;
        if (objVal is Int16) return (Int16)objVal;
        Int16.TryParse(objVal.ToString(), out intValue);
        return intValue;
    }

    // Get int value from object.
    private int GetInt32(object objVal)
    {
        int intValue = 0;
        if (objVal == null) return 0;
        if (objVal is DBNull) return 0;
        if (objVal is int) return (int)objVal;
        int.TryParse(objVal.ToString(), out intValue);
        return intValue;
    }

    // Get Date type value from object.
    private DateTime GetDate(object objVal)
    {
        if (objVal == null) return Convert.ToDateTime(null);
        if (objVal is DBNull) return Convert.ToDateTime(null);
        if (objVal is string && string.IsNullOrEmpty(objVal.ToString())) return Convert.ToDateTime(null);
        return Convert.ToDateTime(objVal);
    }

    private bool GetBoolean(object objVal)
    {
        if (objVal is DBNull) return false;
        if (objVal == null) return false;
        return Convert.ToBoolean(objVal);
    }

    // Converts the item into its decimal value.
    private decimal GetDecimal(object objVal)
    {
        decimal decobjVal = 0M;
        if (objVal == null) return decobjVal;
        if (objVal is DBNull) return decobjVal;
        if (objVal is float) return Convert.ToDecimal(objVal);
        if (objVal is double) return Convert.ToDecimal(objVal);
        decimal.TryParse(objVal.ToString(), out decobjVal);
        return decobjVal;
    }

    // Converts the item into its floating point value.
    private double GetDouble(object objVal)
    {
        double result = 0;
        if (objVal == null) return 0;
        if (objVal is DBNull) return 0;
        string strObjVal = objVal.ToString();
        strObjVal = strObjVal.Replace("$", "");
        strObjVal = strObjVal.Replace(",", "");
        double.TryParse(strObjVal, out result);
        return result;
    }

    // Converts the item into its byte value.
    private byte GetByte(object objVal)
    {
        byte result;
        if (objVal is DBNull) return 0;
        if (objVal == null) return 0;
        byte.TryParse(objVal.ToString(), out result);
        return result;
    }



}
