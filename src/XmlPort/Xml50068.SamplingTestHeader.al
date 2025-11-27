XmlPort 50068 "Sampling Test Header"
{
    Format = VariableText;

    schema
    {
    textelement(SamplingTestHeader1)
    {
    tableelement("Sampling Test Header";
    "SSD Sampling Test Header")
    {
    XmlName = 'SamplingTestHeader';

    fieldelement(a;
    "Sampling Test Header"."No.")
    {
    }
    fieldelement(b;
    "Sampling Test Header"."Series No.")
    {
    }
    fieldelement(c;
    "Sampling Test Header".Description)
    {
    }
    fieldelement(d;
    "Sampling Test Header".Status)
    {
    }
    fieldelement(e;
    "Sampling Test Header"."Responsibility Center")
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
