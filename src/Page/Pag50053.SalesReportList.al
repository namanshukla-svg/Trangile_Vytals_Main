Page 50053 "Sales Report List"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Sales Invoice Line";
    SourceTableView = sorting("Document No.", "Line No.");
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            group(Control1000000013)
            {
                field(FromDate; FromDate)
                {
                    ApplicationArea = All;
                    Caption = 'Year';
                }
            }
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Customer.""Address 3"""; Customer."Address 3")
                {
                    ApplicationArea = All;
                    Caption = 'Type';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                    Caption = 'Sell to Customer No.';
                }
                field("Customer.Name"; Customer.Name)
                {
                    ApplicationArea = All;
                    Caption = 'Customer Name';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Item Code';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                    Caption = 'Description 1';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    Caption = 'UOM';
                }
                field("Item.""Lead Time Dispatch"""; Item."Lead Time Dispatch")
                {
                    ApplicationArea = All;
                    Caption = 'Dispatch Lead';
                }
                label("Shipping Time")
                {
                    ApplicationArea = All;
                    Caption = 'Shipping Time';
                }
                field("GetQuantity('01'+'04'+FromDate + '..' + '30'+'04'+FromDate)"; GetQuantity('01' + '04' + FromDate + '..' + '30' + '04' + FromDate))
                {
                    ApplicationArea = All;
                    Caption = 'Quantity Delivered (Apr)';
                }
                field("GetQuantity('01'+'05'+FromDate + '..' + '31'+'05'+FromDate)"; GetQuantity('01' + '05' + FromDate + '..' + '31' + '05' + FromDate))
                {
                    ApplicationArea = All;
                    Caption = 'Quantity Delivered (May)';
                }
                field("GetQuantity('01'+'06'+FromDate + '..' + '30'+'06'+FromDate)"; GetQuantity('01' + '06' + FromDate + '..' + '30' + '06' + FromDate))
                {
                    ApplicationArea = All;
                    Caption = 'Quantity Delivered (June)';
                }
                field("GetQuantity('01'+'07'+FromDate + '..' + '31'+'07'+FromDate)"; GetQuantity('01' + '07' + FromDate + '..' + '31' + '07' + FromDate))
                {
                    ApplicationArea = All;
                    Caption = 'Quantity Delivered (July)';
                }
                field("GetQuantity('01'+'08'+FromDate+ '..' + '31'+'08'+FromDate)"; GetQuantity('01' + '08' + FromDate + '..' + '31' + '08' + FromDate))
                {
                    ApplicationArea = All;
                    Caption = 'Quantity Delivered (Aug)';
                }
                field("GetQuantity('01'+'09'+FromDate + '..' + '30'+'09'+FromDate)"; GetQuantity('01' + '09' + FromDate + '..' + '30' + '09' + FromDate))
                {
                    ApplicationArea = All;
                    Caption = 'Quantity Delivered (Sep)';
                }
                field("GetQuantity('01'+'10'+FromDate + '..' + '31'+'10'+FromDate)"; GetQuantity('01' + '10' + FromDate + '..' + '31' + '10' + FromDate))
                {
                    ApplicationArea = All;
                    Caption = 'Quantity Delivered (Oct)';
                }
                field("GetQuantity('01'+'11'+FromDate + '..' + '30'+'11'+FromDate)"; GetQuantity('01' + '11' + FromDate + '..' + '30' + '11' + FromDate))
                {
                    ApplicationArea = All;
                    Caption = 'Quantity Delivered (Nov)';
                }
                label("MSL Qty.")
                {
                    ApplicationArea = All;
                    Caption = 'MSL Qty.';
                }
                label("MSL Value")
                {
                    ApplicationArea = All;
                    Caption = 'MSL Value';
                }
                label("ROL Qty.")
                {
                    ApplicationArea = All;
                    Caption = 'ROL Qty.';
                }
                label("ROL Value")
                {
                    ApplicationArea = All;
                    Caption = 'ROL Value';
                }
                label("WH. Stock Qty.")
                {
                    ApplicationArea = All;
                    Caption = 'WH. Stock Qty.';
                }
                field("GetWhQty('-10D')"; GetWhQty('-10D'))
                {
                    ApplicationArea = All;
                    Caption = 'Transit Qty. [Posting Inv. Date <10D from the Date of Invoice]';
                }
                field("GetWhQty('-30D')"; GetWhQty('-30D'))
                {
                    ApplicationArea = All;
                    Caption = 'WH Regular/ Low Risk Value (<30D Age)';
                }
                field("GetWhQty('+30D-60D')"; GetWhQty('+30D-60D'))
                {
                    ApplicationArea = All;
                    Caption = 'Medium Risk Value (31-60D Age)';
                }
                field("GetWhQty('61D-90D')"; GetWhQty('61D-90D'))
                {
                    ApplicationArea = All;
                    Caption = 'High Risk Value (61-90D Age)';
                }
                field("GetWhQty('-90D')"; GetWhQty('-90D'))
                {
                    ApplicationArea = All;
                    Caption = 'Obsolete Risk Value (90+D Age)';
                }
                label("Short/Excess Qty. on MSL [WH Stock - MSL]")
                {
                    ApplicationArea = All;
                    Caption = 'Short/Excess Qty. on MSL [WH Stock - MSL]';
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        if Customer.Get(Rec."Sell-to Customer No.")then;
        if Rec.Type = Rec.Type::Item then Item.Get(Rec."No.");
    end;
    trigger OnOpenPage()
    begin
        FromDate:=Format(Date2dmy(Today, 3));
    end;
    var CustomerSpecialField: Text;
    CustomerName: Text;
    Customer: Record Customer;
    SalesInvoiceHeader: Record "Sales Invoice Header";
    SalesPrice: Decimal;
    SalesInvoiceLine: Record "Sales Invoice Line";
    Item: Record Item;
    FromDate: Text;
    procedure GetLatestSalesPrice(): Decimal begin
        SalesInvoiceLine.Reset;
        SalesInvoiceLine.SetCurrentkey("Posting Date", "Document No.", "Line No.");
        SalesInvoiceLine.SetRange("Posting Date", Rec."Posting Date");
        SalesInvoiceLine.SetRange("Document No.", Rec."Document No.");
        if SalesInvoiceLine.FindLast then exit(SalesInvoiceLine."Unit Price");
    end;
    procedure GetQuantity(ActualDeliveryDate: Text)Qty: Decimal begin
        Qty:=0;
        SalesInvoiceHeader.Reset;
        SalesInvoiceHeader.SetRange("No.", Rec."Document No.");
        SalesInvoiceHeader.SetFilter("Actual Delivery Date", ActualDeliveryDate);
        if SalesInvoiceHeader.FindSet then repeat SalesInvoiceLine.Reset;
                SalesInvoiceLine.SetCurrentkey("Posting Date", "Document No.", "Line No.");
                SalesInvoiceLine.SetRange("Document No.", SalesInvoiceHeader."No.");
                if SalesInvoiceLine.FindSet then repeat Qty+=SalesInvoiceLine.Quantity;
                    until SalesInvoiceLine.Next = 0;
            until SalesInvoiceHeader.Next = 0;
    end;
    procedure GetWhQty(VarDate: Text)Qty: Decimal begin
        Qty:=0;
        SalesInvoiceLine.Reset;
        SalesInvoiceLine.SetCurrentkey("Posting Date", "Document No.", "Line No.");
        SalesInvoiceLine.SetRange("Document No.", Rec."Document No.");
        SalesInvoiceLine.SetRange("Posting Date", 0D, CalcDate(VarDate, WorkDate));
        if SalesInvoiceLine.FindSet then repeat Qty+=SalesInvoiceLine.Quantity;
            until SalesInvoiceLine.Next = 0;
    end;
}
