XmlPort 50017 NoSeriesLine
{
    Format = VariableText;

    schema
    {
    textelement(NoSeriesLine1)
    {
    tableelement("No. Series Line";
    "No. Series Line")
    {
    XmlName = 'NoSeriesLine';

    fieldelement(a;
    "No. Series Line"."Series Code")
    {
    }
    fieldelement(b;
    "No. Series Line"."Line No.")
    {
    }
    fieldelement(c;
    "No. Series Line"."Starting Date")
    {
    }
    fieldelement(d;
    "No. Series Line"."Starting No.")
    {
    }
    fieldelement(e;
    "No. Series Line"."Increment-by No.")
    {
    }
    fieldelement(f;
    "No. Series Line".Open)
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
