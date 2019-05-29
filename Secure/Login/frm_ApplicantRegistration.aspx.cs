using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Script.Services;
using System.Web.Script.Serialization;

public partial class Secure_Login_frm_ApplicantRegistration : System.Web.UI.Page
{
    DBLayer db = new DBLayer();
    protected void Page_Init(object sender, EventArgs e)
    {
        Session.Clear();
        Session.Abandon();

        Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
    }


    protected void Page_Load(object sender, EventArgs e)
    {

    }


    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string ApplicantRegister(ApplicantRegistration objApplicantRegistration)
    {
        var jsondata = new Dictionary<string, string>();
        var jsSerializer = new JavaScriptSerializer();

        string userid = GetRandom(8, 0, 9);
        string pass = objApplicantRegistration.Name.Trim().ToUpper().Replace(" ", "").Substring(0, 4).ToUpper() + "@" + objApplicantRegistration.MobileNo.Trim().Substring(objApplicantRegistration.MobileNo.Trim().Length - 4, 4);
        if ((new DBLayer()).CreateApplicantRegistration(Convert.ToInt16(LegalType.Individual), objApplicantRegistration.AadharNo.Trim(), "", objApplicantRegistration.Name.Trim(), objApplicantRegistration.MobileNo.Trim(), userid, pass, true) > 0)
        {
            string sms = "Dear " + objApplicantRegistration.Name.Trim().ToUpper() + ", You have Successfully Registered.\nUser ID: " + userid + " and Password: " + pass + ".\nKindly login and complete your Application Form.";
            GlobalFunctions.SendSMSN(objApplicantRegistration.MobileNo.Trim(), sms);
            jsondata = new Dictionary<string, string>
                        {
                            { "status","OK"} ,{ "msg",sms}                          
                        };
        }
        else
        {
            jsondata = new Dictionary<string, string>
                        {
                            { "status","ERROR"} ,{ "msg","Something went wrong!"}                          
                        };
        }
        return jsSerializer.Serialize(jsondata);
    }


    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string GetOTP(string mobno)
    {
        Secure_Login_frm_ApplicantRegistration ss = new Secure_Login_frm_ApplicantRegistration();
        var jsondata = new Dictionary<string, string>();
        var jsSerializer = new JavaScriptSerializer();
        if (mobno.Length == 10)
        {
            ss.sendOTP(mobno);
            jsondata = new Dictionary<string, string>
                        {
                            { "status","True"} ,                              
                        };
        }
        else
        {
            jsondata = new Dictionary<string, string>
                        {
                            { "status","False"}                             
                        };
        }
        return jsSerializer.Serialize(jsondata);
    }

    public void sendOTP(string mobileno)
    {
        string rnno = GetRandom(5, 0, 9);
        Session["OTP"] = rnno;
        GlobalFunctions.SendSMSN("Your One Time Password(OTP) is " + rnno + " for Applicant Registration.", mobileno);
    }

    private static string GetRandom(int digit, int min, int max)
    {
        string str = "";

        Random rnd = new Random();
        for (int i = 0; i < digit; i++)
        {
            str += rnd.Next(min, max).ToString();
        }

        return str;
    }


    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string VerifyMobileOTP(string otp)
    {
        Secure_Login_frm_ApplicantRegistration ss = new Secure_Login_frm_ApplicantRegistration();
        var jsondata = new Dictionary<string, string>();
        var jsSerializer = new JavaScriptSerializer();

        Secure_Login_frm_ApplicantRegistration vopt = new Secure_Login_frm_ApplicantRegistration();
        if (vopt.VerifyOTP(otp))
        {
            jsondata = new Dictionary<string, string>
                        {
                            { "status","VERIFY"} ,                              
                        };

        }
        else
        {
            jsondata = new Dictionary<string, string>
                        {
                            { "status","NOTVERIFY"} ,                              
                        };
        }


        return jsSerializer.Serialize(jsondata);
    }

    public bool VerifyOTP(string otp)
    {
        if (Session["OTP"].ToString() == otp)
        {
            return true;
        }
        else
        {
            return false;
        }

    }
}