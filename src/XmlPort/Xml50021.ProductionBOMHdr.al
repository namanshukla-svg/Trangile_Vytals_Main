XmlPort 50021 "Production BOM Hdr"
{
    Format = VariableText;

    schema
    {
    textelement(ProductionBOMHdr1)
    {
    tableelement("Production BOM Header";
    "Production BOM Header")
    {
    XmlName = 'ProductionBOMHdr';

    fieldelement(a;
    "Production BOM Header"."No.")
    {
    }
    fieldelement(b;
    "Production BOM Header".Description)
    {
    }
    fieldelement(c;
    "Production BOM Header"."Description 2")
    {
    }
    fieldelement(d;
    "Production BOM Header"."Unit of Measure Code")
    {
    }
    fieldelement(e;
    "Production BOM Header".Status)
    {
    }
    fieldelement(f;
    "Production BOM Header"."Responsibility Center")
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
