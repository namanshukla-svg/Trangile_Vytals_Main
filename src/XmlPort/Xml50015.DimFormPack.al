XmlPort 50015 DimFormPack
{
    Format = VariableText;

    schema
    {
    textelement(DimFormPack1)
    {
    tableelement("Dimension Value";
    "Dimension Value")
    {
    XmlName = 'DimFormPack';

    fieldelement(a;
    "Dimension Value"."Dimension Code")
    {
    }
    fieldelement(b;
    "Dimension Value".Code)
    {
    }
    fieldelement(c;
    "Dimension Value".Name)
    {
    }
    fieldelement(d;
    "Dimension Value"."Dimension Value Type")
    {
    }
    fieldelement(e;
    "Dimension Value".Totaling)
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
