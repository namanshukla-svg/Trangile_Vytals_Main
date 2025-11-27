XmlPort 50069 "Sampling temp Line"
{
    Format = VariableText;

    schema
    {
    textelement(SamplingTempLine1)
    {
    tableelement("Sampling Temp. Line";
    "SSD Sampling Temp. Line")
    {
    XmlName = 'SamplingTempLine';

    fieldelement(a;
    "Sampling Temp. Line"."Document No.")
    {
    }
    fieldelement(b;
    "Sampling Temp. Line"."Line No.")
    {
    }
    fieldelement(c;
    "Sampling Temp. Line"."Test No.")
    {
    }
    fieldelement(d;
    "Sampling Temp. Line"."Meas. Code")
    {
    }
    fieldelement(e;
    "Sampling Temp. Line"."Template Type")
    {
    }
    fieldelement(f;
    "Sampling Temp. Line"."Responsibility Center")
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
