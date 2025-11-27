XmlPort 50012 ItemUOM
{
    Format = VariableText;

    schema
    {
    textelement(ItemUOM1)
    {
    tableelement("Item Unit of Measure";
    "Item Unit of Measure")
    {
    XmlName = 'ItemUOM';

    fieldelement(a;
    "Item Unit of Measure"."Item No.")
    {
    }
    fieldelement(b;
    "Item Unit of Measure".Code)
    {
    }
    fieldelement(c;
    "Item Unit of Measure"."Qty. per Unit of Measure")
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
