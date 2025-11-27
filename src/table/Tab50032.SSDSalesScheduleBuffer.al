table 50032 "SSD Sales Schedule Buffer"
{
    DrillDownPageID = "Sales Packet Details";
    LookupPageID = "Sales Packet Details";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote, "Order", Invoice, "Credit Memo", "Blanket Order", "Return Order";
            DataClassification = CustomerContent;
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(3; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            Editable = false;
            TableRelation = Customer;
            DataClassification = CustomerContent;
        }
        field(4; "Order Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Order Line No.';
        }
        field(6; "Item No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Item No.';
        }
        field(10; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(15; "Schedule Quantity"; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
        }
        field(20; "Shipment Date"; Date)
        {
            Caption = 'Shipment Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                CheckDateConflict: Codeunit "Reservation-Check Date Confl.";
            begin
            end;
        }
        field(21; "No. of Box"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'No. of Box';

            trigger OnValidate()
            begin
                if "No. of Box" = 0 then "No. of Box":=1;
                if "Qty per Box" = 0 then "Qty per Box":=1;
                "Total Qty":=("No. of Box") * ("Qty per Box");
                //ALLE 6.01
                if ItemRec.Get("Item No.")then begin
                    if ItemUOM.Get(ItemRec."No.", ItemRec."Base Unit of Measure")then;
                    if ItemUOM1.Get("Item No.", "Unit of Measure Code")then;
                    //"Calculated Weight" := "Total Qty" * ItemRec."Gross Weight";
                    //"Actual Weight" := "Total Qty" * ItemRec."Gross Weight";
                    "Calculated Weight":=("Total Qty" / ROUND((ItemUOM."Qty. per Unit of Measure" / ItemUOM1."Qty. per Unit of Measure"), 1)) * ItemRec."Net Weight";
                    "Actual Weight":=("Total Qty" / ROUND((ItemUOM."Qty. per Unit of Measure" / ItemUOM1."Qty. per Unit of Measure"), 1)) * ItemRec."Net Weight";
                    //>>alle VPB
                    "Gross Weight":=("Total Qty" / ROUND((ItemUOM."Qty. per Unit of Measure" / ItemUOM1."Qty. per Unit of Measure"), 1)) * ItemRec."Gross Weight";
                //<<Alle VPB
                end;
            end;
        }
        field(22; "Qty per Box"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty per Box';

            trigger OnValidate()
            begin
                if "No. of Box" = 0 then "No. of Box":=1;
                if "Qty per Box" = 0 then "Qty per Box":=1;
                "Total Qty":=("No. of Box") * ("Qty per Box");
                Validate("Total Qty"); //5.51
                //ALLE 6.01
                if ItemRec.Get("Item No.")then begin
                    if ItemUOM.Get(ItemRec."No.", ItemRec."Base Unit of Measure")then;
                    if ItemUOM1.Get("Item No.", "Unit of Measure Code")then;
                    //"Calculated Weight" := "Total Qty" * ItemRec."Gross Weight";
                    //"Actual Weight" := "Total Qty" * ItemRec."Gross Weight";
                    "Calculated Weight":=("Total Qty" / ROUND((ItemUOM."Qty. per Unit of Measure" / ItemUOM1."Qty. per Unit of Measure"), 1)) * ItemRec."Net Weight";
                    "Actual Weight":=("Total Qty" / ROUND((ItemUOM."Qty. per Unit of Measure" / ItemUOM1."Qty. per Unit of Measure"), 1)) * ItemRec."Net Weight";
                    //>>Alle VPB
                    "Gross Weight":=("Total Qty" / ROUND((ItemUOM."Qty. per Unit of Measure" / ItemUOM1."Qty. per Unit of Measure"), 1)) * ItemRec."Gross Weight";
                //<<Alle VPB
                end;
            end;
        }
        field(23; "Total Qty"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Qty';

            trigger OnValidate()
            begin
                TOTALQTY:=-("Total Qty"); //5.51
                //<<<<< ALLE [5.51]
                "Lot Line No":="Line No.";
                "Batch No.":="Lot No.";
            //>>>> ALLE[5.51]
            end;
        }
        field(34; "Gross Weight"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Gross Weight';
        }
        field(35; "Schedule Time"; Time)
        {
            Description = 'CE_AA002';
            DataClassification = CustomerContent;
            Caption = 'Schedule Time';
        }
        field(50000; "From Box No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'From Box No.';
        }
        field(50001; "To Box No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'To Box No.';
        }
        field(50002; "Gross Wt. Per Case"; Decimal)
        {
            DecimalPlaces = 2: 5;
            DataClassification = CustomerContent;
            Caption = 'Gross Wt. Per Case';
        }
        field(50003; "Net Wt. Per Case"; Decimal)
        {
            DecimalPlaces = 2: 5;
            DataClassification = CustomerContent;
            Caption = 'Net Wt. Per Case';
        }
        field(50004; Packing; Option)
        {
            OptionCaption = ' ,Pallet,Case,Master Carton,Inner Carton,Box,Roll,Steel Drum,PE Can,Bundles,Others,Plastic Drum';
            OptionMembers = " ", Pallet, "Case", "Master Carton", "Inner Carton", Box, Roll, "Steel Drum", "PE Can", Bundles, Others, "Plastic Drum";
            DataClassification = CustomerContent;
            Caption = 'Packing';
        }
        field(50005; "Packing Length"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Packing Length';
        }
        field(50006; "Packing Breadth"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Packing Breadth';
        }
        field(50007; "Packing Height"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Packing Height';
        }
        field(50008; "Calculated Weight"; Decimal)
        {
            Description = 'ALLE 6.01';
            DataClassification = CustomerContent;
            Caption = 'Calculated Weight';
        }
        field(50009; "Actual Weight"; Decimal)
        {
            Description = 'ALLE 6.01';
            DataClassification = CustomerContent;
            Caption = 'Actual Weight';

            trigger OnValidate()
            begin
            //ALLE 6.01
            //SSD Comment Start
            // if ItemRec.Get("Item No.") then begin
            //     if (((Abs("Actual Weight" - "Calculated Weight")) / "Calculated Weight") * 100) > ItemRec."Deviation %" then
            //         Message('Actual Deviation is %1,which is more than the Expected %2',
            //                  (((Abs("Actual Weight" - "Calculated Weight")) / "Calculated Weight") * 100),
            //                  ItemRec."Deviation %");
            // end;
            //SSD Comment End;
            end;
        }
        field(50010; "Unit of Measure Code"; Code[10])
        {
            Description = 'ALLE 6.01';
            Editable = false;
            TableRelation = "Item Unit of Measure";
            DataClassification = CustomerContent;
            Caption = 'Unit of Measure Code';
        }
        field(50011; "Batch No."; Text[30])
        {
            Description = 'ISS-013';
            DataClassification = CustomerContent;
            Caption = 'Batch No.';
        }
        field(50012; "Lot No."; Code[50])
        {
            CalcFormula = lookup("Reservation Entry"."Lot No." where("Item No."=field("Item No."), "Source ID"=field("Document No."), "Source Ref. No."=field("Order Line No."), "MRN Line No."=field("Lot Line No")));
            Description = 'VIJ-5.51-added to lookup Lot no.';
            FieldClass = FlowField;
            Caption = 'Lot No.';

            trigger OnValidate()
            begin
                //alle
                "Batch No.":="Lot No.";
            //alle
            end;
        }
        field(50013; "Lot Qty."; Decimal)
        {
            CalcFormula = lookup("Reservation Entry".Quantity where("Item No."=field("Item No."), "Source ID"=field("Document No."), "Source Ref. No."=field("Order Line No."), "Quantity (Base)"=field(TOTALQTY), "MRN Line No."=field("Lot Line No")));
            Description = 'VIJ-5.51-added to lookup Lot Qty.';
            FieldClass = FlowField;
            Caption = 'Lot Qty.';

            trigger OnValidate()
            begin
                //5.51
                if "Total Qty" > Abs("Lot Qty.")then Error('You cannot enter more than Lot Qty');
            //5.51
            end;
        }
        field(50014; TOTALQTY; Decimal)
        {
            Description = 'VIJ-5.51-added to lookup Lot Qty.';
            DataClassification = CustomerContent;
            Caption = 'TOTALQTY';
        }
        field(50015; "Lot Line No"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Lot Line No';
        }
        field(50016; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            Description = 'Alle 26052021';
            TableRelation = "Item Variant".Code where("Item No."=field("Item No."));
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Document Type", "Document No.", "Sell-to Customer No.", "Order Line No.", "Item No.", "Line No.")
        {
            Clustered = true;
            SumIndexFields = "Schedule Quantity", "No. of Box", "Total Qty", "Actual Weight", "Gross Weight";
        }
        key(Key2; "Document No.", "Document Type", "Sell-to Customer No.")
        {
        }
        key(Key3; "Document Type", "Document No.", "Item No.")
        {
        }
        key(Key4; "From Box No.")
        {
        }
    }
    fieldgroups
    {
    }
    var LastBuffer: Record "SSD Sales Schedule Buffer";
    BoxCount: Integer;
    ItemRec: Record Item;
    ItemUOM: Record "Item Unit of Measure";
    ItemUOM1: Record "Item Unit of Measure";
    procedure SetSalesBuffer(var DocNo: Code[20])
    var
        SalesHeader: Record "Sales Header";
    begin
        BoxCount:=0;
        LastBuffer.SetCurrentkey("Document Type", "Document No.", "Item No.");
        LastBuffer.SetRange("Document Type", LastBuffer."document type"::Order);
        LastBuffer.SetRange(LastBuffer."Document No.", DocNo);
        if LastBuffer.FindSet then repeat LastBuffer."From Box No.":=BoxCount + 1;
                LastBuffer."To Box No.":=LastBuffer."From Box No." + LastBuffer."No. of Box" - 1;
                BoxCount+=LastBuffer."No. of Box";
                LastBuffer.Modify;
            until LastBuffer.Next = 0;
    end;
    procedure SetSalesBufferInvoice(var DocNo: Code[20])
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        BoxCount:=0;
        SalesLine.SetCurrentkey("Document Type", "Document No.", Type, "No.");
        SalesLine.SetRange(SalesLine."Document Type", SalesLine."document type"::Invoice);
        SalesLine.SetRange(SalesLine."Document No.", DocNo);
        SalesLine.SetRange(SalesLine.Type, SalesLine.Type::Item);
        if SalesLine.FindSet then repeat LastBuffer.SetCurrentkey("Document Type", "Document No.", "Item No.");
                LastBuffer.SetRange("Document Type", LastBuffer."document type"::Invoice);
                LastBuffer.SetRange(LastBuffer."Document No.", DocNo);
                LastBuffer.SetRange(LastBuffer."Item No.", SalesLine."No.");
                LastBuffer.SetRange(LastBuffer."Order Line No.", SalesLine."Line No.");
                if LastBuffer.FindSet then repeat LastBuffer."From Box No.":=BoxCount + 1;
                        LastBuffer."To Box No.":=LastBuffer."From Box No." + LastBuffer."No. of Box" - 1;
                        BoxCount+=LastBuffer."No. of Box";
                        LastBuffer.Modify;
                    until LastBuffer.Next = 0;
            until SalesLine.Next = 0;
    end;
}
