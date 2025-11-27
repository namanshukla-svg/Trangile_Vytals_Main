XmlPort 50023 "Actual Transp.Cont. Det Import"
{
    Format = VariableText;
    FormatEvaluate = Legacy;
    Permissions = TableData "SSD Buffer Aged Acount Report"=rimd;

    schema
    {
    textelement(Root)
    {
    tableelement("<table50037>";
    "SSD Actual Tpt Cont Detail")
    {
    XmlName = 'ATCD';

    fieldelement(City;
    "<Table50037>".City)
    {
    }
    fieldelement(StateCode;
    "<Table50037>".State)
    {
    }
    fieldelement(Shipping_Agent_Code;
    "<Table50037>"."Shipping Agent Code")
    {
    }
    fieldelement(Contact1_Name;
    "<Table50037>"."Contact1 Name")
    {
    }
    fieldelement(Contact1_Mobile;
    "<Table50037>"."Contact1 Mob")
    {
    }
    fieldelement(Contact1_Email;
    "<Table50037>"."Contact1 Email")
    {
    }
    fieldelement(Contact2_Name;
    "<Table50037>"."Contact2 Name")
    {
    }
    fieldelement(Contact2_Mobile;
    "<Table50037>"."Contact2 Mob")
    {
    }
    fieldelement(Contact2_Email;
    "<Table50037>"."Contact2 Email")
    {
    }
    }
    }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
}
