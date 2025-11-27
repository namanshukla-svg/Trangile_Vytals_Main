query 50003 SalesInvoiceReportTest
{
    Caption = 'Sales Invoice Report Test';
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
    dataitem(Detailed_GST_Ledger_Entry;
    "Detailed GST Ledger Entry")
    {
    SqlJoinType = LeftOuterJoin;
    DataItemLink = "Document No."=Sales_Invoice_Line."Document No.", "Document Line No."=Sales_Invoice_Line."Line No.";
    DataItemTableFilter = "GST Component Code"=filter(='CGST'|'IGST'|'SGST');

    filter(Document_Type;
    "Document Type")
    {
    ColumnFilter = Document_Type=filter(='Invoice');
    }
    filter(Entry_Type;
    "Entry Type")
    {
    ColumnFilter = Entry_Type=filter(="Initial Entry");
    }
    filter(Location__Reg__No_;
    "Location  Reg. No.")
    {
    }
    filter(Transaction_Type;
    "Transaction Type")
    {
    ColumnFilter = Transaction_Type=const(Sales);
    }
    filter(Posting_Date;
    "Posting Date")
    {
    }
    column(GST__;
    "GST %")
    {
    Method = Sum;
    }
    column(Document_No_;
    "Document No.")
    {
    }
    column(Document_Line_No_;
    "Document Line No.")
    {
    }
    // column(GST_Component_Code; "GST Component Code") { }
    column(GST_Amount;
    "GST Amount")
    {
    Method = Sum;
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
    }
    trigger OnBeforeOpen()
    begin
    // CurrQuery.SetRange(CurrQuery.Document_Line_No_, CurrQuery.Line_No_);
    end;
}
