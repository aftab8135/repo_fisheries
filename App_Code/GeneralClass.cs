using System;
using System.Collections.Generic;
using System.Text;
using System.Security.Cryptography;
using System.IO;
using System.Net;
using System.Web.UI.WebControls;



public class GeneralClass
{
    
    public static bool bProceed;
    public static int ID;
    public static int CurrentRowIndex;
    //temporary Added
    public static bool IsDouble(object Expression)
    {
        try
        {
            if (Expression == null)
                return false;

            double objVal;
            if (double.TryParse(Expression.ToString(), System.Globalization.NumberStyles.Any, System.Globalization.CultureInfo.CurrentCulture, out objVal))
                return true;
            else
                return false;
        }
        catch (Exception ex)
        {
            // new ExceptionAndEventHandling(ex);
            return false;
        }
    }

    public static bool IsInteger(object Expression)
    {
        try
        {
            if (Expression == null)
                return false;

            int objVal;
            if (int.TryParse(Expression.ToString(), System.Globalization.NumberStyles.Any, System.Globalization.CultureInfo.CurrentCulture, out objVal))
                return true;
            else
                return false;
        }
        catch (Exception ex)
        {
            // new ExceptionAndEventHandling(ex);
            return false;
        }
    }

    public static bool IsInt16(object Expression)
    {
        try
        {
            if (Expression == null)
                return false;

            Int16 objVal;
            if (Int16.TryParse(Expression.ToString(), System.Globalization.NumberStyles.Any, System.Globalization.CultureInfo.CurrentCulture, out objVal))
                return true;
            else
                return false;
        }
        catch (Exception ex)
        {
            // new ExceptionAndEventHandling(ex);
            return false;
        }
    }

    public static bool IsInt32(object Expression)
    {
        try
        {
            if (Expression == null)
                return false;

            int objVal;
            if (int.TryParse(Expression.ToString(), System.Globalization.NumberStyles.Any, System.Globalization.CultureInfo.CurrentCulture, out objVal))
                return true;
            else
                return false;
        }
        catch (Exception ex)
        {
            // new ExceptionAndEventHandling(ex);
            return false;
        }
    }

    public static bool IsInt64(object Expression)
    {
        try
        {
            if (Expression == null)
                return false;

            Int64 objVal;
            if (Int64.TryParse(Expression.ToString(), System.Globalization.NumberStyles.Any, System.Globalization.CultureInfo.CurrentCulture, out objVal))
                return true;
            else
                return false;
        }
        catch (Exception ex)
        {
            //new ExceptionAndEventHandling(ex);
            return false;
        }
    }

    public static bool IsDateTime(object Expression)
    {
        try
        {
            if (Expression == null)
                return false;

            DateTime objVal;
            if (DateTime.TryParse(Expression.ToString(), System.Globalization.CultureInfo.CurrentCulture, System.Globalization.DateTimeStyles.None, out objVal))
                return true;
            else
                return false;
        }
        catch (Exception ex)
        {
            // new ExceptionAndEventHandling(ex);
            return false;
        }
    }

    public static object GetDateForUI(object obj)
    {
        DateTime objDate;
        if (DateTime.TryParse(obj.ToString(), out objDate) && objDate.Year != 1)
            return objDate.ToString("dd/MM/yyyy");
        else
            return "";
    }

    public static DateTime GetDateForDB(object obj)
    {
        DateTime objDate;
        if (!string.IsNullOrEmpty(obj.ToString()))
            obj = (object)GetDateInMMDDYYYY(obj);
        if (DateTime.TryParse(obj.ToString(), out objDate) && objDate.Year != 1)
            return objDate;
        else
            return objDate;
    }


    public static object GetDateForDB2(object obj)
    {
        // DateTime objDate;
        if (!string.IsNullOrEmpty(obj.ToString()))
            obj = (object)GetDateInMMDDYYYY(obj);
        //if (DateTime.TryParse(obj.ToString(), out objDate) && objDate.Year != 1)
        //    return objDate;
        // else
        return obj;
    }

    public static string GetDateInMMDDYYYY(object obj)
    {
        string[] objDate = obj.ToString().Split('/');
        return objDate[2] + "/" + objDate[1] + "/" + objDate[0];
    }

    public static object GetTimeForUI(object obj)
    {
        DateTime objDate;
        if (DateTime.TryParse(obj.ToString(), out objDate) && objDate.Year != 1)
            return objDate.ToString("hh:mm");
        else
            return "";
    }

    public static DateTime GetTimeForDB(object obj)
    {
        DateTime objDate;
        if (DateTime.TryParse("01/01/1900 " + obj.ToString(), out objDate) && objDate.Year != 1)
            return objDate;
        else
            return objDate;
    }

    public static string Encrypt(string clearText)
    {
        string EncryptionKey = "MAKV2SPBNI99212";
        //byte[] clearBytes = Encoding.Unicode.GetBytes(clearText);
        byte[] clearBytes = Encoding.Unicode.GetBytes(clearText);

        using (Aes encryptor = Aes.Create())
        {
            Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
            encryptor.Key = pdb.GetBytes(32);
            encryptor.IV = pdb.GetBytes(16);
            using (MemoryStream ms = new MemoryStream())
            {
                using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
                {
                    cs.Write(clearBytes, 0, clearBytes.Length);
                    cs.Close();
                }
                clearText = Convert.ToBase64String(ms.ToArray());
            }
        }
        return clearText;
    }

    public static string Decrypt(string cipherText)
    {
        string EncryptionKey = "MAKV2SPBNI99212";
        cipherText = cipherText.Replace(" ", "+");
        byte[] cipherBytes = Convert.FromBase64String(cipherText);
        using (Aes encryptor = Aes.Create())
        {
            Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
            encryptor.Key = pdb.GetBytes(32);
            encryptor.IV = pdb.GetBytes(16);
            using (MemoryStream ms = new MemoryStream())
            {
                using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateDecryptor(), CryptoStreamMode.Write))
                {
                    cs.Write(cipherBytes, 0, cipherBytes.Length);
                    cs.Close();
                }
                cipherText = Encoding.Unicode.GetString(ms.ToArray());
            }
        }
        return cipherText;
    }

    public static void SendSMS(String Mobile_Number, String Message)
    {
        string stringpost = "http://103.16.101.52:8080/bulksms/bulksms?username=mag1-upkvib&password=upkvib12&type=0&dlr=0&destination=91" + Mobile_Number + "&source=upkvib&message=" + Message;
        //string stringpost = "http://api.sss.bz/smpp?username=margsoft&password=FZZuJ6SfA&from=MARGSS&to=91" + Mobile_Number + "&text=" + Message;
        //string stringpost = "http://marg.sms-center.co.in/api/sendmsg.php?user=upkhadi&pass=khadi$07!up&sender=UPKVIB&phone=" + Mobile_Number + "&text=" + Message + "&priority=ndnd&stype=normal";                
        try
        {
            HttpWebRequest httpreq = (HttpWebRequest)WebRequest.Create(stringpost);
            try
            {
                HttpWebResponse httpres = (HttpWebResponse)httpreq.GetResponse();
                System.IO.StreamReader sr = new System.IO.StreamReader(httpres.GetResponseStream());
                string results = sr.ReadToEnd();
                sr.Close();

            }
            catch
            {

            }
        }
        catch (Exception ex)
        {
            //  return (ex.ToString());

        }
    }

    public static void LoadCombo(ref DropDownList DropDownRef, ref List<ListItem> ItemList, string DefaultValue = "Select")
    {
        try
        {
            DropDownRef.Items.Clear();
            foreach (ListItem objListItem in ItemList)
            {
                DropDownRef.Items.Add(objListItem);
            }
            DropDownRef.Items.Insert(0, new ListItem { Text = DefaultValue, Value = "" });
            DropDownRef.Items[0].Attributes.Add("disabled", "disabled");
            DropDownRef.Items[0].Attributes.Add("hidden", "hidden");
        }
        catch (Exception ex)
        {
            
            throw ex;
        }
    }
}

