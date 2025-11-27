XmlPort 50073 "Quality requried on Item card"
{
    Format = VariableText;

    schema
    {
    textelement(Item1)
    {
    tableelement(Item;
    Item)
    {
    XmlName = 'Item';

    fieldelement(a;
    Item."No.")
    {
    }
    fieldelement(b;
    Item."Quality Required")
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
