TableExtension 50115 "SSD Warehouse Receipt Line" extends "Warehouse Receipt Line"
{
    fields
    {
        modify("Qty. Outstanding")
        {
        trigger OnAfterValidate()
        begin
            Item1Local.RESET;
            IF Item1Local.GET("Item No.")THEN "Quality Required":=Item1Local."Quality Required";
        end;
        }
        field(50001; "Gate Entry no."; Code[20])
        {
            Description = 'CF001';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Gate Entry no.';
        }
        field(50003; "Gate Line No."; Integer)
        {
            Description = 'CF001';
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'Gate Line No.';
        }
        field(50004; "Posted Source Line No."; Integer)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Posted Source Line No.';
        }
        field(50005; "Quality Required"; Boolean)
        {
            Description = 'QLT -> Coming from Item card';
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'Quality Required';
        }
        field(50006; "Qty. On Purch. Order"; Decimal)
        {
            Description = 'QLT -> Total PO Quatity';
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'Qty. On Purch. Order';
        }
        field(50007; "Qty. On Invoice"; Decimal)
        {
            Description = 'QLT -> Total Challan Qty at Gate Entry';
            DataClassification = CustomerContent;
            Caption = 'Qty. On Invoice';
        }
        field(50008; "Shortage Qty."; Decimal)
        {
            Description = 'QLT -> Diff between (Challan Qty - Actual Qty) during Gate Entry';
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'Shortage Qty.';
        }
        field(50009; "Actual Qty. to Receive"; Decimal)
        {
            Description = 'QLT -> Actual Qty to be receive';
            DataClassification = CustomerContent;
            Caption = 'Actual Qty. to Receive';

            trigger OnValidate()
            var
                PurchaseLine: Record "Purchase Line";
            begin
                if "Actual Qty. to Receive" > "Qty. On Invoice" then Error(Text007, FieldCaption("Actual Qty. to Receive"), "Qty. On Invoice", FieldCaption("Qty. On Invoice"));
                if("Source Type" = 39) and ("Source Subtype" = 1)then begin
                    PurchaseLine.Get(PurchaseLine."Document Type"::Order, "Source No.", "Source Line No.");
                    Validate(Quantity, PurchaseLine.Quantity);
                    Validate("Qty. to Receive", "Actual Qty. to Receive");
                end
                else
                    Validate(Quantity, "Actual Qty. to Receive");
                "Shortage Qty.":="Qty. On Invoice" - "Actual Qty. to Receive";
                "Accepted Qty.":="Actual Qty. to Receive";
                "Rejected Qty.":=0;
                if "Shortage Qty." = "Qty. On Invoice" then "Quality Required":=false;
                if "Shortage Qty." <> "Qty. On Invoice" then begin
                    if item1.Get("Item No.")then begin
                        if item1."Quality Required" = false then "Quality Required":=false
                        else
                            "Quality Required":=true;
                    end;
                end;
            end;
        }
        field(50010; "Accepted Qty."; Decimal)
        {
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'Accepted Qty.';

            trigger OnValidate()
            begin
                "Rejected Qty.":="Actual Qty. to Receive" - "Accepted Qty.";
            end;
        }
        field(50011; "Rejected Qty."; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Rejected Qty.';
        }
        field(50012; "Party Type";Enum "Party Type")
        {
            Description = 'QLT';
            DataClassification = CustomerContent;
            Caption = 'Party Type';
        }
        field(50013; "Party No."; Code[20])
        {
            Description = 'QLT';
            TableRelation = if("Party Type"=const(Vendor))Vendor."No."
            else if("Party Type"=const(Customer))Customer."No.";
            DataClassification = CustomerContent;
            Caption = 'Party No.';
        }
        field(50014; "Send For Quality"; Boolean)
        {
            Description = 'QLT -> After Creation of Quality Order From MRN';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Send For Quality';
        }
        field(50015; "Quality Done"; Boolean)
        {
            Description = 'QLT -> After Posting of Quality order';
            DataClassification = CustomerContent;
            Caption = 'Quality Done';
        }
        field(50017; "Posted Quality Order No."; Code[20])
        {
            Description = 'QLT';
            DataClassification = CustomerContent;
            Caption = 'Posted Quality Order No.';
        }
        field(50018; "Reject Location Code"; Code[10])
        {
            Description = 'QLT';
            TableRelation = Location where("Quality Rejects"=const(true));
            DataClassification = CustomerContent;
            Caption = 'Reject Location Code';
        }
        field(50019; "Reject Bin Code"; Code[20])
        {
            Description = 'QLT';
            TableRelation = if("Zone Code"=filter(''))Bin.Code where("Location Code"=field("Reject Location Code"))
            else if("Zone Code"=filter(<>''))Bin.Code where("Location Code"=field("Reject Location Code"), "Zone Code"=field("Zone Code"));
            DataClassification = CustomerContent;
            Caption = 'Reject Bin Code';
        }
        field(50050; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Description = 'CF001';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
        }
        field(50051; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            Description = 'CF001';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(1));
            DataClassification = CustomerContent;
        }
        field(50052; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Description = 'CF001';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(2));
            DataClassification = CustomerContent;
        }
        field(50053; "No. Of Coils"; Integer)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'No. Of Coils';
        }
        field(50054; "NO.2"; Code[20])
        {
            CalcFormula = lookup(Item."No. 2" where("No."=field("Item No.")));
            Description = 'CE001';
            FieldClass = FlowField;
            Caption = 'NO.2';
        }
        field(50055; Grade; Text[30])
        {
            CalcFormula = lookup(Item.Grade where("No."=field("Item No.")));
            FieldClass = FlowField;
            Caption = 'Grade';
        }
        field(50056; "Subcontracting Transfer Order"; Boolean)
        {
            Description = 'ALLEAA CML-033 300408';
            DataClassification = CustomerContent;
            Caption = 'Subcontracting Transfer Order';
        }
        field(50057; "Description 3"; Text[300])
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Description 3';
        }
        field(54025; "Delivery Challan"; Code[20])
        {
            Description = 'CEN004.07';
            DataClassification = CustomerContent;
            Caption = 'Delivery Challan';
        }
        field(54026; "Delivery Challan Sent Item"; Code[20])
        {
            Description = 'CEN004.07';
            DataClassification = CustomerContent;
            Caption = 'Delivery Challan Sent Item';
        }
        field(54027; "Scrap Item"; Code[20])
        {
            Description = 'CEN_AA001';
            TableRelation = Item;
            DataClassification = CustomerContent;
            Caption = 'Scrap Item';
        }
        field(54028; "Scrap Qty."; Decimal)
        {
            Description = 'CEN_AA001';
            DataClassification = CustomerContent;
            Caption = 'Scrap Qty.';
        }
        field(54030; "Scrap Location"; Code[20])
        {
            Description = 'CEN_AA001';
            TableRelation = Location;
            DataClassification = CustomerContent;
            Caption = 'Scrap Location';
        }
        field(54031; "Scrap Bin"; Code[20])
        {
            Description = 'CEN_AA001';
            TableRelation = Bin.Code where("Location Code"=field("Scrap Location"));
            DataClassification = CustomerContent;
            Caption = 'Scrap Bin';
        }
        field(54032; "Customer No."; Code[20])
        {
            Description = 'ALLE-TRA1.0';
            TableRelation = Customer."No.";
            DataClassification = CustomerContent;
            Caption = 'Customer No.';
        }
        field(54033; "SalesPerson Code"; Code[10])
        {
            Description = 'ALLE-TRA1.0';
            TableRelation = "Salesperson/Purchaser".Code;
            DataClassification = CustomerContent;
            Caption = 'SalesPerson Code';
        }
        field(60008; Trading; Boolean)
        {
            Description = 'ALLE-AA_CML/Purch 19.11.07';
            DataClassification = CustomerContent;
            Caption = 'Trading';
        }
        field(60009; "Purchase Price"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Purchase Price';
        }
        field(60010; "Supplier Batch No."; Code[20])
        {
            Description = 'ALLE-NM';
            DataClassification = CustomerContent;
            Caption = 'Supplier Batch No.';
        }
        //SSD Sunil
        field(60011; "Vendor Item Description"; Text[100])
        {
            Description = 'Vendor Item Description';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Vendor Item Description';
        }
        field(60012; "Direct Unit Cost"; Decimal)
        {
            Description = 'Direct Unit Cost';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Direct Unit Cost';
        }
    }
    trigger OnAfterInsert()
    begin
        WHReceiptHeader.GET("No.");
        "Responsibility Center":=WHReceiptHeader."Responsibility Center";
    end;
    procedure WarehouseReceiptLine(WarehouseNo: Code[20])
    var
        WhoseRecptLine: Record "Warehouse Receipt Line";
    begin
        WhoseRecptLine.SetRange(WhoseRecptLine."No.", WarehouseNo);
        if WhoseRecptLine.Find('-')then repeat WhoseRecptLine.Quantity:=0;
                WhoseRecptLine."Qty. (Base)":=0;
                WhoseRecptLine."Qty. Outstanding":=0;
                WhoseRecptLine."Qty. Outstanding (Base)":=0;
                WhoseRecptLine."Qty. to Receive":=0;
                WhoseRecptLine."Qty. to Receive (Base)":=0;
                WhoseRecptLine."Qty. Received":=0;
                WhoseRecptLine."Qty. Received (Base)":=0;
                WhoseRecptLine."Shortage Qty.":=0;
                WhoseRecptLine."Actual Qty. to Receive":=0;
                WhoseRecptLine."Accepted Qty.":=0;
                WhoseRecptLine."Rejected Qty.":=0;
                WhoseRecptLine."Qty. On Invoice":=0;
                WhoseRecptLine.Modify;
            until WhoseRecptLine.Next = 0;
    end;
    var Item1Local: Record Item;
    item1: Record Item;
    WHReceiptHeader: Record "Warehouse Receipt Header";
    Text007: label '%1 cannot be more than %2  (%3)';
}
