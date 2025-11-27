XmlPort 50066 "Sampling Test Line"
{
    Format = VariableText;

    schema
    {
    textelement(SamplingTestLine1)
    {
    tableelement("Sampling Test Line";
    "SSD Sampling Test Line")
    {
    XmlName = 'SamplingTestLine';

    fieldelement(a;
    "Sampling Test Line"."Test Code")
    {
    }
    fieldelement(b;
    "Sampling Test Line"."Line No.")
    {
    }
    fieldelement(c;
    "Sampling Test Line"."Meas. Code")
    {
    }
    fieldelement(d;
    "Sampling Test Line".Description)
    {
    }
    fieldelement(e;
    "Sampling Test Line"."Minimum Value")
    {
    }
    fieldelement(f;
    "Sampling Test Line"."Maximum Value")
    {
    }
    fieldelement(g;
    "Sampling Test Line"."Responsibility Center")
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
