XmlPort 50030 ItemVariant
{
    UseDefaultNamespace = true;

    schema
    {
    textelement(Root)
    {
    tableelement("Item Variant";
    "Item Variant")
    {
    XmlName = 'ItemVariant';

    fieldelement(Code;
    "Item Variant".Code)
    {
    }
    fieldelement(ItemNo;
    "Item Variant"."Item No.")
    {
    }
    fieldelement(Description;
    "Item Variant".Description)
    {
    }
    fieldelement(Description2;
    "Item Variant"."Description 2")
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
