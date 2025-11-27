query 51000 "Inventory Dashboard Query"
{
    Caption = 'Inventory Dashboard Query';
    QueryType = Normal;

    elements
    {
    dataitem(ItemLedgerEntry;
    "Item Ledger Entry")
    {
    DataItemTableFilter = "Remaining Quantity"=filter(>0), "Location Code"=filter(<>'STR_DAMAGE');

    column(PostingDate;
    "Posting Date")
    {
    }
    column(ItemNo;
    "Item No.")
    {
    }
    column(LocationCode;
    "Location Code")
    {
    }
    column(UnitofMeasureCode;
    "Unit of Measure Code")
    {
    }
    column(CostAmountActual;
    "Cost Amount (Actual)")
    {
    Method = Sum;
    }
    column(CostAmountExpected;
    "Cost Amount (Expected)")
    {
    Method = Sum;
    }
    column(Quantity;
    Quantity)
    {
    Method = Sum;
    }
    column(RemainingQuantity;
    "Remaining Quantity")
    {
    Method = Sum;
    }
    dataitem(Item;
    Item)
    {
    //SqlJoinType = InnerJoin;
    DataItemLink = "No."=ItemLedgerEntry."Item No.";

    column(Description;
    Description)
    {
    }
    column(Description2;
    "Description 2")
    {
    }
    column(ProcurementType;
    "Procurement Type")
    {
    }
    column(GenProdPostingGroup;
    "Gen. Prod. Posting Group")
    {
    }
    dataitem(Item_Category;
    "Item Category")
    {
    //SqlJoinType = InnerJoin;
    DataItemLink = Code=Item."Item Category Code";

    column(Parent_Category;
    "Parent Category")
    {
    }
    column(Code;
    Code)
    {
    }
    }
    }
    }
    }
    trigger OnBeforeOpen()
    begin
    end;
}
