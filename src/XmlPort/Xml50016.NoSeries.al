XmlPort 50016 NoSeries
{
    Format = VariableText;

    schema
    {
    textelement(NoSeries1)
    {
    tableelement("No. Series";
    "No. Series")
    {
    XmlName = 'NoSeries';

    fieldelement(a;
    "No. Series".Code)
    {
    }
    fieldelement(b;
    "No. Series".Description)
    {
    }
    fieldelement(c;
    "No. Series"."Default Nos.")
    {
    }
    fieldelement(d;
    "No. Series"."Manual Nos.")
    {
    }
    fieldelement(e;
    "No. Series"."Date Order")
    {
    }
    fieldelement(f;
    "No. Series"."Responsibility Center")
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
