query 50001 SalesInvoiceReport
{
    Caption = 'Sales Invoice Report';
    QueryType = Normal;

    elements
    {
    dataitem(SalesInvoiceHeader;
    "Sales Invoice Header")
    {
    column(OrderScdNo;
    "Order/Scd. No.")
    {
    }
    column(ExternalDocumentNo;
    "External Document No.")
    {
    }
    column(No;
    "No.")
    {
    }
    column(TypeofInvoice;
    "Type of Invoice")
    {
    }
    column(PostingDate;
    "Posting Date")
    {
    }
    column(DueDate;
    "Due Date")
    {
    }
    column(SelltoCustomerNo;
    "Sell-to Customer No.")
    {
    }
    column(SelltoCustomerName;
    "Sell-to Customer Name")
    {
    }
    column(BilltoCustomerNo;
    "Bill-to Customer No.")
    {
    }
    column(BilltoName;
    "Bill-to Name")
    {
    }
    column(Ship_to_Code;
    "Ship-to Code")
    {
    }
    column(Ship_to_Name;
    "Ship-to Name")
    {
    }
    column(SalespersonCode;
    "Salesperson Code")
    {
    }
    column(ShippingAgentCode;
    "Shipping Agent Code")
    {
    }
    column(ShipmentMethodCode;
    "Shipment Method Code")
    {
    }
    column(LRRRNo;
    "LR/RR No.")
    {
    }
    column(LRRRDate;
    "LR/RR Date")
    {
    }
    column(ActualDeliveryDate;
    "Actual Delivery Date")
    {
    }
    column(CurrencyCode;
    "Currency Code")
    {
    }
    column(CurrencyFactor;
    "Currency Factor")
    {
    }
    column(FirmFreight;
    "Firm Freight")
    {
    }
    column(CalculatedFreightAmount;
    "Calculated Freight Amount")
    {
    }
    column(Remarks1;
    Remarks1)
    {
    }
    dataitem(Sales_Invoice_Line;
    "Sales Invoice Line")
    {
    SqlJoinType = InnerJoin;
    DataItemLink = "Document No."=SalesInvoiceHeader."No.";

    column("Type";
    "Type")
    {
    }
    column(Line_No_;
    "Line No.")
    {
    }
    column(Item_Category_Code;
    "Item Category Code")
    {
    }
    column(No_;
    "No.")
    {
    }
    column(Description;
    Description)
    {
    }
    column(Description_2;
    "Description 2")
    {
    }
    column(Unit_of_Measure_Code;
    "Unit of Measure Code")
    {
    }
    column(Quantity;
    Quantity)
    {
    }
    column(Net_Weight;
    "Net Weight")
    {
    }
    column(Unit_Price;
    "Unit Price")
    {
    }
    column(Line_Amount;
    "Line Amount")
    {
    }
    column(GST_Group_Code;
    "GST Group Code")
    {
    }
    column(HSN_SAC_Code;
    "HSN/SAC Code")
    {
    }
    column(Transport_Method;
    "Transport Method")
    {
    }
    column(Dimension_Set_ID;
    "Dimension Set ID")
    {
    }
    dataitem(Item_Category;
    "Item Category")
    {
    SqlJoinType = LeftOuterJoin;
    DataItemLink = Code=Sales_Invoice_Line."Item Category Code";

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
