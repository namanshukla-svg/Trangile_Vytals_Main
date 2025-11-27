Table 50063 "SSD Sales Forecast Line"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Sales Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Sales Document No.';
        }
        field(2; "Customer Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer Code';
        }
        field(3; "Line No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = CustomerContent;
            Caption = 'Line No.';

            trigger OnValidate()
            begin
                SalesForecastHeader.Reset;
                SalesForecastHeader.SetRange(SalesForecastHeader."Sales Planning No.", "Sales Document No.");
                if SalesForecastHeader.FindFirst then "Customer Code":=SalesForecastHeader."Customer No.";
            end;
        }
        field(4; "Item Code"; Code[20])
        {
            TableRelation = Item."No.";
            DataClassification = CustomerContent;
            Caption = 'Item Code';

            trigger OnValidate()
            begin
                Item.Get("Item Code");
                Customer.Get("Customer Code");
                //SSD "Lead Time Dispatch" := Item."Lead Time Dispatch";
                "Shipping Time":=Customer."Shipping Time";
                "Item Name":=Item.Description + ',' + Item."Description 2";
                //SSD "Pack Size" := Item."Pack Size";
                MiniStockforCustForecast.Reset;
                //SSD MiniStockforCustForecast.SetRange("Customer No.", Rec."Customer Code");
                MiniStockforCustForecast.SetRange("Item Code", Rec."Item Code");
                if MiniStockforCustForecast.FindFirst then "Minimum Stock Level":=MiniStockforCustForecast."Minimum Stock Level";
                Clear("Shipped Qty Intransit");
                SIH.Reset;
                SIH.SetRange("Sell-to Customer No.", "Customer Code");
                SIH.SetRange("Actual Delivery Date", 0D);
                SIH.SetFilter("Posting Date", '>=%1', "Opening Stock Date");
                if SIH.FindSet then repeat SalesInvoiceLine.Reset;
                        SalesInvoiceLine.SetRange("Document No.", SIH."No.");
                        SalesInvoiceLine.SetRange("No.", Rec."Item Code");
                        SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::Item);
                        if SalesInvoiceLine.FindSet then begin
                            SalesInvoiceLine.CalcSums(Quantity);
                            "Shipped Qty Intransit"+=SalesInvoiceLine.Quantity;
                        end;
                    until SIH.Next = 0;
                Clear("SO Qty (Remaining)");
                SalesHeader.Reset;
                SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                SalesHeader.SetRange("Sell-to Customer No.", "Customer Code");
                //SalesHeader.SETFILTER("Actual Delivery Date",'<>%1',0D);
                SalesHeader.SetFilter("Posting Date", '>=%1', "Opening Stock Date");
                if SalesHeader.FindSet then repeat SalesLine.Reset;
                        SalesLine.SetRange("Document No.", SalesHeader."No.");
                        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
                        SalesLine.SetFilter("Outstanding Quantity", '<>%1', 0);
                        SalesLine.SetRange("No.", Rec."Item Code");
                        if SalesLine.FindSet then begin
                            //SalesLine.CALCSUMS("Qty. to Ship");
                            "SO Qty (Remaining)"+=SalesLine."Outstanding Quantity";
                        end;
                    until SalesHeader.Next = 0;
                Clear("SP Sold Qty.");
                SIH.Reset;
                SIH.SetRange("Sell-to Customer No.", "Customer Code");
                SIH.SetFilter("Actual Delivery Date", '<>%1', 0D);
                SIH.SetFilter("Posting Date", '>=%1', "Opening Stock Date");
                if SIH.FindSet then repeat SalesInvoiceLine.Reset;
                        SalesInvoiceLine.SetRange("Document No.", SIH."No.");
                        SalesInvoiceLine.SetRange("No.", Rec."Item Code");
                        SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::Item);
                        if SalesInvoiceLine.FindSet then begin
                            SalesInvoiceLine.CalcSums(Quantity);
                            "SP Sold Qty."+=SalesInvoiceLine.Quantity;
                        end;
                    until SIH.Next = 0;
                Validate(Stock);
                Validate("Forecast Quantity");
                Validate("SO Qty (Remaining)");
                Validate("Shipped Qty Intransit");
                Validate("Minimum Stock Level");
            //"Expected Receipt Date" := CALCDATE("Lead Time Dispatch",Date);
            //"Expected Receipt Date" := CALCDATE("Shipping Time","Expected Receipt Date");
            end;
        }
        field(5; "Lead Time Dispatch"; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'Lead Time Dispatch';

            trigger OnValidate()
            begin
                Evaluate(Text1, Format("Lead Time Dispatch"));
                Var2:=StrLen(Text1);
                Var1:=CopyStr(Text1, Var2, Var2);
                Var3:=CopyStr(Text1, 1, Var2 - 1);
                Evaluate(Int1, Var3);
                if Var1 = 'D' then "Lead Time In Days":=Int1 * 1
                else if Var1 = 'M' then "Lead Time In Days":=Int1 * 30
                    else if Var1 = 'Q' then "Lead Time In Days":=Int1 * 90
                        else
                            "Lead Time In Days":=Int1 * 7;
            end;
        }
        field(6; "Shipping Time"; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'Shipping Time';

            trigger OnValidate()
            begin
                Evaluate(Text1, Format("Shipping Time"));
                Var2:=StrLen(Text1);
                Var1:=CopyStr(Text1, Var2, Var2);
                Var3:=CopyStr(Text1, 1, Var2 - 1);
                Evaluate(Int1, Var3);
                if Var1 = 'D' then "Shipping Time In Days":=Int1 * 1
                else if Var1 = 'M' then "Shipping Time In Days":=Int1 * 30
                    else if Var1 = 'Q' then "Shipping Time In Days":=Int1 * 90
                        else
                            "Shipping Time In Days":=Int1 * 7;
            end;
        }
        field(7; "Item Name"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Item Name';
        }
        field(8; "Forecast Name"; Code[10])
        {
            TableRelation = "Production Forecast Name".Name;
            DataClassification = CustomerContent;
            Caption = 'Forecast Name';

            trigger OnValidate()
            begin
                Validate("Forecast Quantity");
            end;
        }
        field(9; Stock; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Stock';

            trigger OnValidate()
            begin
                Stock:=(("Opending Stock" - "SSR for Specific Period") + "SP Sold Qty.");
                "Cal Suggested Dealer PO Qty":=("Forecast Quantity" + "Minimum Stock Level") - (Stock + "SO Qty (Remaining)" + "Shipped Qty Intransit");
            end;
        }
        field(10; "Forecast Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Forecast Quantity';

            trigger OnValidate()
            begin
                "Cal Suggested Dealer PO Qty":=("Forecast Quantity" + "Minimum Stock Level") - (Stock + "SO Qty (Remaining)" + "Shipped Qty Intransit");
            end;
        }
        field(11; "SO Qty (Remaining)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'SO Qty (Remaining)';

            trigger OnValidate()
            begin
                "Cal Suggested Dealer PO Qty":=("Forecast Quantity" + "Minimum Stock Level") - (Stock + "SO Qty (Remaining)" + "Shipped Qty Intransit");
            end;
        }
        field(12; "Shipped Qty Intransit"; Decimal)
        {
            FieldClass = Normal;
            DataClassification = CustomerContent;
            Caption = 'Shipped Qty Intransit';

            trigger OnValidate()
            begin
                "Cal Suggested Dealer PO Qty":=("Forecast Quantity" + "Minimum Stock Level") - (Stock + "SO Qty (Remaining)" + "Shipped Qty Intransit");
            end;
        }
        field(13; "Minimum Stock Level"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Minimum Stock Level';

            trigger OnValidate()
            begin
                "Cal Suggested Dealer PO Qty":=("Forecast Quantity" + "Minimum Stock Level") - (Stock + "SO Qty (Remaining)" + "Shipped Qty Intransit");
            end;
        }
        field(14; "Cal Suggested Dealer PO Qty"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cal Suggested Dealer PO Qty';

            trigger OnValidate()
            begin
                "Cal Suggested Dealer PO Qty":=("Forecast Quantity" + "Minimum Stock Level") - (Stock + "SO Qty (Remaining)" + "Shipped Qty Intransit");
            end;
        }
        field(15; "Act Suggested Dealer PO Qty"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Act Suggested Dealer PO Qty';
        }
        field(16; "Expected Receipt Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Expected Receipt Date';
        }
        field(17; "PO Given by Dealer"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'PO Given by Dealer';
        }
        field(18; "SO NO."; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'SO NO.';
        }
        field(19; "SO QTY"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'SO QTY';
        }
        field(20; "Opending Stock"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Opending Stock';

            trigger OnValidate()
            begin
                Validate(Stock, (("Opending Stock" - "SSR for Specific Period") + "SP Sold Qty."));
            end;
        }
        field(21; "SSR for Specific Period"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'SSR for Specific Period';

            trigger OnValidate()
            begin
                Validate(Stock, (("Opending Stock" - "SSR for Specific Period") + "SP Sold Qty."));
            end;
        }
        field(22; "SP Sold Qty."; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'SP Sold Qty.';

            trigger OnValidate()
            begin
                Validate(Stock, (("Opending Stock" - "SSR for Specific Period") + "SP Sold Qty."));
            end;
        }
        field(23; "Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date';
        }
        field(24; "Pack Size"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Pack Size';
        }
        field(25; ISCRMInserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'ISCRMInserted';
        }
        field(26; ISUpdated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'ISUpdated';
        }
        field(27; ISCRMException; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'ISCRMException';
        }
        field(28; ExceptionDetails; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'ExceptionDetails';
        }
        field(29; "Lead Time In Days"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Lead Time In Days';
        }
        field(30; "Shipping Time In Days"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Shipping Time In Days';
        }
        field(31; "Opening Stock Date"; Date)
        {
            Description = 'ALLE-NM 31072019';
            DataClassification = CustomerContent;
            Caption = 'Opening Stock Date';

            trigger OnValidate()
            begin
                Validate("Item Code");
                Validate(Stock, (("Opending Stock" - "SSR for Specific Period") + "SP Sold Qty."));
                "Cal Suggested Dealer PO Qty":=("Forecast Quantity" + "Minimum Stock Level") - (Stock + "SO Qty (Remaining)" + "Shipped Qty Intransit");
                Validate("Forecast Quantity");
            end;
        }
    }
    keys
    {
        key(Key1; "Sales Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        SalesForecastHeader.Reset;
        SalesForecastHeader.SetRange(SalesForecastHeader."Sales Planning No.", "Sales Document No.");
        if SalesForecastHeader.FindFirst then begin
            "Customer Code":=SalesForecastHeader."Customer No.";
            Date:=SalesForecastHeader.Date;
        end;
    end;
    var SalesForecastHeader: Record "SSD Sales Forecast Header";
    Item: Record Item;
    Customer: Record Customer;
    SalesHeader: Record "Sales Header";
    SalesLine: Record "Sales Line";
    Date1: Text;
    SIH: Record "Sales Invoice Header";
    SalesInvoiceLine: Record "Sales Invoice Line";
    MiniStockforCustForecast: Record "SSD Pre. Prod. Forecast Entry";
    Var1: Text;
    Var2: Integer;
    Var3: Text;
    Text1: Text;
    Int1: Integer;
}
