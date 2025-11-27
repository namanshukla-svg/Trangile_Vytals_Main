XmlPort 50005 InventoryPostingGroup
{
    Format = VariableText;

    schema
    {
    textelement(InventoryPostingGroup1)
    {
    tableelement("Inventory Posting Group";
    "Inventory Posting Group")
    {
    XmlName = 'InventoryPostingGroup';

    fieldelement(a;
    "Inventory Posting Group".Code)
    {
    }
    fieldelement(b;
    "Inventory Posting Group".Description)
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
