using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;


public enum LegalType
{
    Individual = 1,
    //NonIndividual = 2,
}


public enum ApplicationMode
{
    OnLine = 1,
    OffLine = 2,
}

//public enum ReservationCategory
//{
//    General = 1,
//    SC = 2,
//    ST = 3,
//    OBC = 4
//}

public enum AttachedDocument
{
    Passport = 1,
    Pan_Card = 2,
    Voter_Id_Card = 3,
    Driving_License = 4,
    Letter_of_Public_Servant = 5,
    Employer_Issued_ID_Card = 6,
    Electricity_Bill = 7,
    Telephone_Bill = 8,
    House_Tax_Bill = 9,
    Income_Tax_Statement = 10,
    Bank_Passbook_Account_Detail = 11,
    Qualified_Public_Officer_Letter = 12,
    Domicile_Certificate = 13,
    Cast_Certificate = 14,
    Aadhar_Card = 15
}

//public enum Religion
//{
//    Hindu = 1,
//    Muslim = 2,
//    Sikh = 3,
//    Christian = 4,
//    Other = 5
//}

public enum IDProofType
{
    Passport = 1,
    Pan_Card = 2,
    Voter_Id_Card = 3,
    Driving_License = 4,
    Lok_Sewak_Letter = 5,
    ID_Card_Issued_by_the_Company = 6,
}

public enum AddressProofType
{
    Electricity_Bill = 1,
    Telephone_Bill = 2,
    Employers_Letter = 3,
    HR_Bill = 4,
    ITR = 5,
    Bank_Passbook_Account_Detail = 6,
    Gazetted_Officers_Letter = 7
   
}

//public enum Gender
//{
//    Male = 1,
//    Female = 2,
//    Transgender = 3,
//}

public enum InteractionMode
{
    By_Email = 1,
    By_Phone_or_Mobile = 2,
    By_Other_Mode = 3,
}

