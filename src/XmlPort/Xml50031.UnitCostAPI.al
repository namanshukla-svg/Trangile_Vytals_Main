XmlPort 50031 UnitCostAPI
{
    Direction = Export;
    UseDefaultNamespace = true;

    schema
    {
    textelement(Root)
    {
    tableelement("Unit Cost API";
    "SSD Unit Cost API")
    {
    XmlName = 'UnitCostAPI';

    fieldelement(ItemNo;
    "Unit Cost API"."Item No.")
    {
    }
    fieldelement(CreationDate;
    "Unit Cost API"."Creation Date")
    {
    }
    fieldelement(ItemDescription;
    "Unit Cost API".Description)
    {
    }
    fieldelement(LandedCost;
    "Unit Cost API"."Landed Cost")
    {
    }
    fieldelement(ILEDate;
    "Unit Cost API"."ILE Date")
    {
    }
    fieldelement(UnitCost;
    "Unit Cost API"."Unit Cost")
    {
    }
    fieldelement(FirstPOPrice;
    "Unit Cost API"."First PO Price")
    {
    }
    fieldelement(SecondPOPrice;
    "Unit Cost API"."Second PO Price")
    {
    }
    fieldelement(ThirdPOPrice;
    "Unit Cost API"."Third PO Price")
    {
    }
    fieldelement(BudgetedCost;
    "Unit Cost API"."Budgeted Cost")
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
