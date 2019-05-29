using System;

public class CurrentUser 
{
    public static readonly CurrentUser CurrentInstance = new CurrentUser();
    int _UserKey;
    int _UnitKey;
    string _LoginId;
    string _UserProfile;

    public int UserKey
    {
        get
        {
            return _UserKey;
        }
        set
        {
            _UserKey = value;
        }
    }

    // Factory Key
    public int UnitKey
    {
        get
        {
            return _UnitKey;
        }
        set
        {
            _UnitKey = value;
        }
    }

    public string LoginId
    {
        get
        {
            return _LoginId;
        }
        set
        {
            _LoginId = value;
        }
    }

    public string UserProfile
    {
        get
        {
            return _UserProfile;
        }
        set
        {
            _UserProfile = value;
        }
    }
}
