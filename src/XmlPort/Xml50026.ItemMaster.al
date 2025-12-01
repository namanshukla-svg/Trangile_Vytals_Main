XmlPort 50026 ItemMaster
{
    Direction = Export;
    UseDefaultNamespace = true;

    schema
    {
        textelement(Root)
        {
            tableelement(Item;
            Item)
            {
                XmlName = 'Item';

                fieldelement("No.";
                Item."No.")
                {
                }
                fieldelement(Description;
                Item.Description)
                {
                }
                fieldelement(Description2;
                Item."Description 2")
                {
                }
                fieldelement(Description3;
                Item."Description 3")
                {
                }
                fieldelement(BaseUnitofMeasure;
                Item."Base Unit of Measure")
                {
                }
                fieldelement(ProcurementType;
                Item."Procurement Type")
                {
                }
                fieldelement(PurchaseGroup1;
                Item."Purchase Group 1")
                {
                }
                fieldelement(PurchaseGroup2;
                Item."Purchase Group 2")
                {
                }
                fieldelement(PurchaseGroup3;
                Item."Purchase Group 3")
                {
                }
                fieldelement(Blocked;
                Item.Blocked)
                {
                }
                fieldelement(ItemCatagoryCode;
                Item."Item Category Code")
                {
                }
                fieldelement(ProductType;
                Item."PRODUCT TYPE")
                {
                }
                fieldelement(HSNSACCode;
                Item."HSN/SAC Code")
                {
                }
                fieldelement(GSTGroupCode;
                Item."GST Group Code")
                {
                }
                fieldelement(ProcurementCategory;
                Item."Procurement Category")
                {
                }
                fieldelement("Purch.UnitofMeasure";
                Item."Purch. Unit of Measure")
                {
                }
                fieldelement(NetWeight;
                Item."Net Weight")
                {
                }
                fieldelement(GrossWeight;
                Item."Gross Weight")
                {
                }
                fieldelement(BudgetedAmount;
                Item."Budgeted Amount")
                {
                }
                //Atul::01122025
                // fieldelement(PriceValidity;Item."No. of Price Valadity in Days")
                // {
                // }
                //Atul::01122025
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
