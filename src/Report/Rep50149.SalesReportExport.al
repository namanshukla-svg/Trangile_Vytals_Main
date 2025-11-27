Report 50149 "Sales Report Export"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    // ApplicationArea = true;
    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No.");

            column(ReportForNavId_1000000002;1000000002)
            {
            }
            trigger OnAfterGetRecord()
            begin
                SaleInvoiceLine.Reset;
                SaleInvoiceLine.SetCurrentkey("No.", "Order No.", "Document No.");
                SaleInvoiceLine.SetRange(Type, SaleInvoiceLine.Type::Item);
                SaleInvoiceLine.SetRange("Sell-to Customer No.", "No.");
                SaleInvoiceLine.SetRange("Posting Date", 0D, AsonDate);
                if SaleInvoiceLine.FindSet then repeat if XItem <> SaleInvoiceLine."No." then begin
                            Item.Get(SaleInvoiceLine."No.");
                            TempExcelBuffer.NewRow;
                            TempExcelBuffer.AddColumn(Customer."Address 3", false, '', false, false, false, '', TempExcelBuffer."cell type"::Text);
                            TempExcelBuffer.AddColumn(SaleInvoiceLine."Sell-to Customer No.", false, '', false, false, false, '', TempExcelBuffer."cell type"::Text);
                            TempExcelBuffer.AddColumn(Customer.Name, false, '', false, false, false, '', TempExcelBuffer."cell type"::Text);
                            TempExcelBuffer.AddColumn(SaleInvoiceLine."No.", false, '', false, false, false, '', TempExcelBuffer."cell type"::Text);
                            TempExcelBuffer.AddColumn(SaleInvoiceLine.Description, false, '', false, false, false, '', TempExcelBuffer."cell type"::Text);
                            TempExcelBuffer.AddColumn(SaleInvoiceLine."Description 2", false, '', false, false, false, '', TempExcelBuffer."cell type"::Text);
                            TempExcelBuffer.AddColumn(SaleInvoiceLine."Unit of Measure Code", false, '', false, false, false, '', TempExcelBuffer."cell type"::Text);
                            TempExcelBuffer.AddColumn(Item."Lead Time Dispatch", false, '', false, false, false, '', TempExcelBuffer."cell type"::Text);
                            TempExcelBuffer.AddColumn(Customer."Shipping Time", false, '', false, false, false, '', TempExcelBuffer."cell type"::Text);
                            LatestPrice:=GetLatestSalesPrice(Customer."No.", Item."No.");
                            TempExcelBuffer.AddColumn(LatestPrice, false, '', false, false, false, '', TempExcelBuffer."cell type"::Number);
                            TempExcelBuffer.AddColumn(GetQuantity('01' + '01' + Format(Date2dmy(AsonDate, 3)) + '..' + '31' + '01' + Format(Date2dmy(AsonDate, 3)), SaleInvoiceLine."No."), false, '', false, false, false, '', TempExcelBuffer."cell type"::Number);
                            if(Date2dmy(AsonDate, 3) MOD 2) = 0 then TempExcelBuffer.AddColumn(GetQuantity('01' + '02' + Format(Date2dmy(AsonDate, 3)) + '..' + '29' + '02' + Format(Date2dmy(AsonDate, 3)), SaleInvoiceLine."No."), false, '', false, false, false, '', TempExcelBuffer."cell type"::Number)
                            else
                                TempExcelBuffer.AddColumn(GetQuantity('01' + '02' + Format(Date2dmy(AsonDate, 3)) + '..' + '28' + '02' + Format(Date2dmy(AsonDate, 3)), SaleInvoiceLine."No."), false, '', false, false, false, '', TempExcelBuffer."cell type"::Number);
                            TempExcelBuffer.AddColumn(GetQuantity('01' + '03' + Format(Date2dmy(AsonDate, 3)) + '..' + '31' + '03' + Format(Date2dmy(AsonDate, 3)), SaleInvoiceLine."No."), false, '', false, false, false, '', TempExcelBuffer."cell type"::Number);
                            TempExcelBuffer.AddColumn(GetQuantity('01' + '04' + Format(Date2dmy(AsonDate, 3)) + '..' + '30' + '04' + Format(Date2dmy(AsonDate, 3)), SaleInvoiceLine."No."), false, '', false, false, false, '', TempExcelBuffer."cell type"::Number);
                            TempExcelBuffer.AddColumn(GetQuantity('01' + '05' + Format(Date2dmy(AsonDate, 3)) + '..' + '31' + '05' + Format(Date2dmy(AsonDate, 3)), SaleInvoiceLine."No."), false, '', false, false, false, '', TempExcelBuffer."cell type"::Number);
                            TempExcelBuffer.AddColumn(GetQuantity('01' + '06' + Format(Date2dmy(AsonDate, 3)) + '..' + '30' + '06' + Format(Date2dmy(AsonDate, 3)), SaleInvoiceLine."No."), false, '', false, false, false, '', TempExcelBuffer."cell type"::Number);
                            TempExcelBuffer.AddColumn(GetQuantity('01' + '07' + Format(Date2dmy(AsonDate, 3)) + '..' + '31' + '07' + Format(Date2dmy(AsonDate, 3)), SaleInvoiceLine."No."), false, '', false, false, false, '', TempExcelBuffer."cell type"::Number);
                            TempExcelBuffer.AddColumn(GetQuantity('01' + '08' + Format(Date2dmy(AsonDate, 3)) + '..' + '31' + '08' + Format(Date2dmy(AsonDate, 3)), SaleInvoiceLine."No."), false, '', false, false, false, '', TempExcelBuffer."cell type"::Number);
                            TempExcelBuffer.AddColumn(GetQuantity('01' + '09' + Format(Date2dmy(AsonDate, 3)) + '..' + '30' + '09' + Format(Date2dmy(AsonDate, 3)), SaleInvoiceLine."No."), false, '', false, false, false, '', TempExcelBuffer."cell type"::Number);
                            TempExcelBuffer.AddColumn(GetQuantity('01' + '10' + Format(Date2dmy(AsonDate, 3)) + '..' + '31' + '10' + Format(Date2dmy(AsonDate, 3)), SaleInvoiceLine."No."), false, '', false, false, false, '', TempExcelBuffer."cell type"::Number);
                            TempExcelBuffer.AddColumn(GetQuantity('01' + '11' + Format(Date2dmy(AsonDate, 3)) + '..' + '30' + '11' + Format(Date2dmy(AsonDate, 3)), SaleInvoiceLine."No."), false, '', false, false, false, '', TempExcelBuffer."cell type"::Number);
                            TempExcelBuffer.AddColumn(GetQuantity('01' + '12' + Format(Date2dmy(AsonDate, 3)) + '..' + '31' + '12' + Format(Date2dmy(AsonDate, 3)), SaleInvoiceLine."No."), false, '', false, false, false, '', TempExcelBuffer."cell type"::Number);
                            GetMSLQty(Item."No.");
                            TempExcelBuffer.AddColumn(MSLQty, false, '', false, false, false, '', TempExcelBuffer."cell type"::Number);
                            TempExcelBuffer.AddColumn(LatestPrice * MSLQty, false, '', false, false, false, '', TempExcelBuffer."cell type"::Number);
                            TempExcelBuffer.AddColumn(ROLQty, false, '', false, false, false, '', TempExcelBuffer."cell type"::Number);
                            TempExcelBuffer.AddColumn(LatestPrice * ROLQty, false, '', false, false, false, '', TempExcelBuffer."cell type"::Number);
                            WhQty:=GetWhQty(0D, CalcDate('-10D', AsonDate), Item."No.");
                            TempExcelBuffer.AddColumn(WhQty, false, '', false, false, false, '', TempExcelBuffer."cell type"::Number);
                            WhQty2:=GetWhQty(CalcDate('-10D', AsonDate), AsonDate, Item."No.");
                            TempExcelBuffer.AddColumn(WhQty2, false, '', false, false, false, '', TempExcelBuffer."cell type"::Number);
                            OrderQty:=GetSalesOrderQty(Customer."No.", Item."No.");
                            TempExcelBuffer.AddColumn(OrderQty, false, '', false, false, false, '', TempExcelBuffer."cell type"::Number);
                            TempExcelBuffer.AddColumn(GetWhQty(CalcDate('-31D', AsonDate), AsonDate, Item."No."), false, '', false, false, false, '', TempExcelBuffer."cell type"::Number);
                            TempExcelBuffer.AddColumn(OrderQty * LatestPrice, false, '', false, false, false, '', TempExcelBuffer."cell type"::Number);
                            TempExcelBuffer.AddColumn(GetWhQty(CalcDate('-60D', AsonDate), AsonDate, Item."No."), false, '', false, false, false, '', TempExcelBuffer."cell type"::Number);
                            TempExcelBuffer.AddColumn(GetWhQty(CalcDate('-90D', AsonDate), AsonDate, Item."No."), false, '', false, false, false, '', TempExcelBuffer."cell type"::Number);
                            TempExcelBuffer.AddColumn(GetWhQty(CalcDate('-180D', AsonDate), AsonDate, Item."No."), false, '', false, false, false, '', TempExcelBuffer."cell type"::Number);
                            TempExcelBuffer.AddColumn(WhQty - MSLQty, false, '', false, false, false, '', TempExcelBuffer."cell type"::Number);
                            TempExcelBuffer.AddColumn(ROLQty - WhQty - WhQty2, false, '', false, false, false, '', TempExcelBuffer."cell type"::Number);
                        end;
                        XItem:=SaleInvoiceLine."No.";
                    until SaleInvoiceLine.Next = 0;
            end;
            trigger OnPreDataItem()
            begin
                if CustomerType <> '' then SetFilter("Address 3", CustomerType);
                TempExcelBuffer.DeleteAll;
                TempExcelBuffer.AddColumn('Type', false, '', true, false, true, '', TempExcelBuffer."cell type"::Text);
                TempExcelBuffer.AddColumn('Sell-to Customer No.', false, '', true, false, true, '', TempExcelBuffer."cell type"::Text);
                TempExcelBuffer.AddColumn('Sellt-to Customer Name', false, '', true, false, true, '', TempExcelBuffer."cell type"::Text);
                TempExcelBuffer.AddColumn('Item Code', false, '', true, false, true, '', TempExcelBuffer."cell type"::Text);
                TempExcelBuffer.AddColumn(Item.FieldCaption(Description), false, '', true, false, true, '', TempExcelBuffer."cell type"::Text);
                TempExcelBuffer.AddColumn(Item.FieldCaption(Description) + ' 1', false, '', true, false, true, '', TempExcelBuffer."cell type"::Text);
                TempExcelBuffer.AddColumn('UOM', false, '', true, false, true, '', TempExcelBuffer."cell type"::Text);
                TempExcelBuffer.AddColumn('Dispatch Lead', false, '', true, false, true, '', TempExcelBuffer."cell type"::Text);
                TempExcelBuffer.AddColumn('Shipping Time', false, '', true, false, true, '', TempExcelBuffer."cell type"::Text);
                TempExcelBuffer.AddColumn('Sales Price', false, '', true, false, true, '', TempExcelBuffer."cell type"::Text);
                TempExcelBuffer.AddColumn('Quantity Delivered (Jan)', false, '', true, false, true, '', TempExcelBuffer."cell type"::Text);
                TempExcelBuffer.AddColumn('Quantity Delivered (Feb)', false, '', true, false, true, '', TempExcelBuffer."cell type"::Text);
                TempExcelBuffer.AddColumn('Quantity Delivered (Mar)', false, '', true, false, true, '', TempExcelBuffer."cell type"::Text);
                TempExcelBuffer.AddColumn('Quantity Delivered (Apr)', false, '', true, false, true, '', TempExcelBuffer."cell type"::Text);
                TempExcelBuffer.AddColumn('Quantity Delivered (May)', false, '', true, false, true, '', TempExcelBuffer."cell type"::Text);
                TempExcelBuffer.AddColumn('Quantity Delivered (June)', false, '', true, false, true, '', TempExcelBuffer."cell type"::Text);
                TempExcelBuffer.AddColumn('Quantity Delivered (July)', false, '', true, false, true, '', TempExcelBuffer."cell type"::Text);
                TempExcelBuffer.AddColumn('Quantity Delivered (Aug)', false, '', true, false, true, '', TempExcelBuffer."cell type"::Text);
                TempExcelBuffer.AddColumn('Quantity Delivered (Sep)', false, '', true, false, true, '', TempExcelBuffer."cell type"::Text);
                TempExcelBuffer.AddColumn('Quantity Delivered (Oct)', false, '', true, false, true, '', TempExcelBuffer."cell type"::Text);
                TempExcelBuffer.AddColumn('Quantity Delivered (Nov)', false, '', true, false, true, '', TempExcelBuffer."cell type"::Text);
                TempExcelBuffer.AddColumn('Quantity Delivered (Dec)', false, '', true, false, true, '', TempExcelBuffer."cell type"::Text);
                TempExcelBuffer.AddColumn('MSL Qty', false, '', true, false, true, '', TempExcelBuffer."cell type"::Text);
                TempExcelBuffer.AddColumn('MSL Value', false, '', true, false, true, '', TempExcelBuffer."cell type"::Text);
                TempExcelBuffer.AddColumn('ROL Qty', false, '', true, false, true, '', TempExcelBuffer."cell type"::Text);
                TempExcelBuffer.AddColumn('ROL Value', false, '', true, false, true, '', TempExcelBuffer."cell type"::Text);
                TempExcelBuffer.AddColumn('WH. Stock Qty.', false, '', true, false, true, '', TempExcelBuffer."cell type"::Text);
                TempExcelBuffer.AddColumn('Transit Qty. [Posting Inv. Date <10D from the Date of Invoice]', false, '', true, false, true, '', TempExcelBuffer."cell type"::Text);
                TempExcelBuffer.AddColumn('Outstanding Qty. on Sales Order', false, '', true, false, true, '', TempExcelBuffer."cell type"::Text);
                TempExcelBuffer.AddColumn('WH Regular/ Low Risk Value (<30D Age)', false, '', true, false, true, '', TempExcelBuffer."cell type"::Text);
                TempExcelBuffer.AddColumn('Qty. * Sales Price', false, '', true, false, true, '', TempExcelBuffer."cell type"::Text);
                TempExcelBuffer.AddColumn('Medium Risk Value (31-60D Age)', false, '', true, false, true, '', TempExcelBuffer."cell type"::Text);
                TempExcelBuffer.AddColumn('High Risk Value (61-90D Age)', false, '', true, false, true, '', TempExcelBuffer."cell type"::Text);
                TempExcelBuffer.AddColumn('Obsolete Risk Value (90+D Age)', false, '', true, false, true, '', TempExcelBuffer."cell type"::Text);
                TempExcelBuffer.AddColumn('Short/Excess Qty. on MSL [WH Stock - MSL]', false, '', true, false, true, '', TempExcelBuffer."cell type"::Text);
                TempExcelBuffer.AddColumn('Short/Excess Qty. on ROL [ROL-WH Stock - Transit Qty]', false, '', true, false, true, '', TempExcelBuffer."cell type"::Text);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(AsonDate; AsonDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'As on Date';
                }
                field(CustomerType; CustomerType)
                {
                    ApplicationArea = Basic;
                    Caption = 'Type';
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPostReport()
    begin
    //TempExcelBuffer.CreateBook('Sales Invoice Line');  //ALLE_UPG
    // TempExcelBuffer.CreateBook('Sales Invoice Line',''); //ALLE_UPG
    // TempExcelBuffer.WriteSheet('Sales Invoice Line',COMPANYNAME,UserId);
    // TempExcelBuffer.CloseBook;
    // TempExcelBuffer.OpenExcel;
    // TempExcelBuffer.GiveUserControl;
    end;
    trigger OnPreReport()
    begin
        if AsonDate = 0D then Error(Text0001);
    end;
    var AsonDate: Date;
    TempExcelBuffer: Record "Excel Buffer" temporary;
    Rowno: Integer;
    Column: Integer;
    CustomerType: Text;
    Item: Record Item;
    Text0001: label 'As on Date filter must be defined.';
    LatestPrice: Decimal;
    Customer2: Record Customer;
    MSLQty: Decimal;
    ROLQty: Decimal;
    WhQty: Decimal;
    WhQty2: Decimal;
    SaleInvoiceLine: Record "Sales Invoice Line";
    XItem: Code[20];
    SalesInvoiceHeader: Record "Sales Invoice Header";
    OrderQty: Decimal;
    local procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; Italic: Boolean; UnderLine: Boolean; Format: Text[30]; CellType: Option)
    begin
        TempExcelBuffer.Init;
        TempExcelBuffer.Validate("Row No.", RowNo);
        TempExcelBuffer.Validate("Column No.", ColumnNo);
        TempExcelBuffer."Cell Value as Text":=CellValue;
        TempExcelBuffer.Formula:='';
        TempExcelBuffer.Bold:=Bold;
        TempExcelBuffer.Italic:=Italic;
        TempExcelBuffer.Underline:=UnderLine;
        TempExcelBuffer.NumberFormat:=Format;
        TempExcelBuffer."Cell Type":=CellType;
        TempExcelBuffer.Insert;
    end;
    procedure GetLatestSalesPrice(CustomerNo: Code[20]; ItemNo: Code[20]): Decimal var
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        SalesInvoiceLine.Reset;
        SalesInvoiceLine.SetCurrentkey("Posting Date", "Document No.", "Line No.");
        SalesInvoiceLine.SetRange("Sell-to Customer No.", CustomerNo);
        SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::Item);
        SalesInvoiceLine.SetRange("No.", ItemNo);
        if SalesInvoiceLine.FindLast then exit(SalesInvoiceLine."Unit Price");
    end;
    procedure GetQuantity(ActualDeliveryDate: Text; itemNo: Code[20])qty: Decimal var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        qty:=0;
        SalesInvoiceHeader.Reset;
        SalesInvoiceHeader.SetCurrentkey("Posting Date");
        SalesInvoiceHeader.SetRange("Sell-to Customer No.", Customer."No.");
        SalesInvoiceHeader.SetFilter("Actual Delivery Date", ActualDeliveryDate);
        if SalesInvoiceHeader.FindSet then repeat SalesInvoiceLine.Reset;
                SalesInvoiceLine.SetRange("Document No.", SalesInvoiceHeader."No.");
                SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::Item);
                SalesInvoiceLine.SetRange("No.", itemNo);
                if SalesInvoiceLine.FindSet then repeat qty+=SalesInvoiceLine.Quantity until SalesInvoiceLine.Next = 0;
            until SalesInvoiceHeader.Next = 0;
    end;
    procedure GetWhQty(StartDate: Date; EndDate: Date; ItemNo: Code[20])Qty: Decimal var
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        SalesInvoiceHeader.Reset;
        SalesInvoiceHeader.SetCurrentkey("Posting Date");
        SalesInvoiceHeader.SetRange("Sell-to Customer No.", Customer."No.");
        SalesInvoiceHeader.SetRange("Actual Delivery Date", 0D);
        SalesInvoiceHeader.SetRange("Posting Date", StartDate, EndDate);
        if SalesInvoiceHeader.FindFirst then begin
            SalesInvoiceLine.Reset;
            SalesInvoiceLine.SetCurrentkey("Posting Date", "Document No.", "Line No.");
            SalesInvoiceLine.SetRange("Document No.", SalesInvoiceHeader."No.");
            SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::Item);
            SalesInvoiceLine.SetRange("No.", ItemNo);
            if SalesInvoiceLine.FindSet then repeat Qty+=SalesInvoiceLine.Quantity;
                until SalesInvoiceLine.Next = 0;
        end;
    end;
    procedure GetMSLQty(ItemNo: Code[20])
    var
        SalesPrices: Record "Sales Price";
    begin
        MSLQty:=0;
        ROLQty:=0;
        SalesPrices.Reset;
        SalesPrices.SetCurrentkey("Starting Date", "Ending Date", "Item No.", "Sales Code", "Sales Type");
        SalesPrices.SetRange("Item No.", ItemNo);
        SalesPrices.SetRange("Sales Code", Customer."No.");
        SalesPrices.SetRange("Sales Type", SalesPrices."sales type"::Customer);
        SalesPrices.Ascending(false);
        if SalesPrices.FindFirst then begin
        /* SSD Gurmeet//"MSL Qty","ROL Qty" does not exist in BC SalesPrice table
            MSLQty := SalesPrices."MSL Qty";
             ROLQty := SalesPrices."ROL Qty";
             */
        end;
    end;
    procedure GetSalesOrderQty(CustomerNo: Code[20]; ItemNo: Code[20])qty: Decimal var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.Reset;
        SalesLine.SetRange("Document Type", SalesLine."document type"::Order);
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        SalesLine.SetRange("No.", ItemNo);
        SalesLine.SetRange("Sell-to Customer No.", Customer."No.");
        if SalesLine.FindSet then repeat qty+=SalesLine.Quantity;
            until SalesLine.Next = 0;
    end;
}
