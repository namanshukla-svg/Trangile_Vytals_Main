XmlPort 50076 "Sampling Temp. line to be prin"
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
    "Sampling Temp. Line"."Responsibility Center")
    {
    }
    fieldelement(d;
    "Sampling Temp. Line"."To be Print")
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
