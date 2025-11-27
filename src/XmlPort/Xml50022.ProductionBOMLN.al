XmlPort 50022 "Production BOM LN"
{
    Format = VariableText;

    schema
    {
    textelement(ProductionBOMLine1)
    {
    tableelement("Production BOM Line";
    "Production BOM Line")
    {
    XmlName = 'ProductionBOMLine';

    fieldelement(a;
    "Production BOM Line"."Production BOM No.")
    {
    }
    fieldelement(b;
    "Production BOM Line"."Line No.")
    {
    }
    fieldelement(c;
    "Production BOM Line".Type)
    {
    }
    fieldelement(d;
    "Production BOM Line"."No.")
    {
    }
    fieldelement(e;
    "Production BOM Line"."Location Code")
    {
    }
    fieldelement(f;
    "Production BOM Line"."Bin Code")
    {
    }
    fieldelement(g;
    "Production BOM Line"."Unit of Measure Code")
    {
    }
    fieldelement(h;
    "Production BOM Line"."Quantity per")
    {
    }
    fieldelement(i;
    "Production BOM Line"."Responsibility Center")
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
