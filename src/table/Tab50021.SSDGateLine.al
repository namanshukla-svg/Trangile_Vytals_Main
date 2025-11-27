Table 50021 "SSD Gate Line"
{
    DataClassification = CustomerContent;

    fields
    {
        field(2; "Document No."; Code[20])
        {
            TableRelation = "SSD Gate Header"."No.";
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(5; "Party Type"; Option)
        {
            OptionMembers = Vendor, Customer, Employee;
            Caption = 'Party Type';
            DataClassification = CustomerContent;
        }
        field(6; "Party No."; Code[20])
        {
            TableRelation = if("Party Type"=const(Vendor))Vendor."No."
            else if("Party Type"=const(Customer))Customer."No."
            else if("Party Type"=const(Employee))"Dimension Value".Code where("Dimension Code"=const('EMPLOYEE'), "Dimension Value Type"=const(Standard));
            Caption = 'Party No.';
            DataClassification = CustomerContent;
        }
        field(7; "Ref. Document Type"; Option)
        {
            OptionCaption = 'Purchase Order,Sales Returns,RGP Outbound,RGP Inbound,Cash Purchase,Purchase Schedule,Other,Posted Delivery Challan,Subcontracting';
            OptionMembers = "Purchase Order", "Sales Returns", "RGP Outbound", "RGP Inbound", "Cash Purchase", "Purchase Schedule", Other, "Posted Delivery Challan", Subcontracting;
            Caption = 'Ref. Document Type';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                CheckDocumentType();
            end;
        }
        field(8; "Ref. Document No."; Code[20])
        {
            TableRelation = if("Party Type"=const(Vendor), "Ref. Document Type"=const("Purchase Order"))"Purchase Header"."No." where("Document Type"=const(Order), "Buy-from Vendor No."=field("Party No."), "Document Subtype"=const(Order), Status=const(Released))
            else if("Party Type"=const(Vendor), "Ref. Document Type"=const("Purchase Schedule"))"Purchase Header"."No." where("Document Type"=const(Order), "Buy-from Vendor No."=field("Party No."), "Document Subtype"=const(Schedule), Status=const(Released))
            else if("Ref. Document Type"=const("RGP Outbound"))"SSD RGP Header"."No." where("Document Type"=const("RGP Outbound"), "Party No."=field("Party No."));
            Caption = 'Ref. Document No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                "Gate Entry IN Line": Record "SSD Gate Line";
            begin
                CheckDocumentType();
            end;
        }
        field(9; "Max Line No."; Integer)
        {
            CalcFormula = max("SSD Gate Line"."Line No." where("Document No."=field("Document No.")));
            FieldClass = FlowField;
            Caption = 'Max Line No.';
        }
        field(10; Type; Option)
        {
            Editable = true;
            OptionMembers = " ", "Account (G/L)", Item, Resource, "Fixed Asset", "Charge (Item)";
            Caption = 'Type';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                GateIn: Page "Gate In";
            begin
            //CheckDocumentType();
            end;
        }
        field(11; "No."; Code[20])
        {
            Editable = true;
            NotBlank = true;
            TableRelation = if(Type=filter(Item))Item."No."
            else if(Type=filter("Fixed Asset"))"Fixed Asset"."No.";
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                CheckDocumentType();
                if Type = Type::Item then begin
                    Item.Get("No.");
                    if "Ref. Document Type" = "ref. document type"::Subcontracting then Item.TestField("Quality Required");
                    Description:=Item.Description;
                    Description:=Item."Description 2";
                    "Unit of Measure Code":=Item."Base Unit of Measure";
                    CalcFields("Posted Challan Quantity");
                end;
            end;
        }
        field(12; Description; Text[100])
        {
            Description = 'SM_ML007 80->100';
            Editable = true;
            Caption = 'Description';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                CheckDocumentType();
            end;
        }
        field(13; "Outstandiing Quantity"; Decimal)
        {
            Editable = false;
            NotBlank = true;
            Caption = 'Outstandiing Quantity';
            DataClassification = CustomerContent;
        }
        field(14; "Unit of Measure Code"; Code[10])
        {
            Editable = true;
            TableRelation = if(Type=const(Item))"Item Unit of Measure".Code where("Item No."=field("No."))
            else
            "Unit of Measure";
            Caption = 'Unit of Measure Code';
            DataClassification = CustomerContent;
        }
        field(15; "Challan Quantity"; Decimal)
        {
            Caption = 'Challan Quantity';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                PurchRcptHeader: Record "Purch. Rcpt. Header";
                PurchRcptLine: Record "Purch. Rcpt. Line";
                ShortageQty: Decimal;
                GateLine: Record "SSD Gate Line";
            begin
                CalcFields("Posted Challan Quantity", "Posted Actual Quantity");
                GateLine.SetCurrentkey("Ref. Document Type", "Ref. Document No.", "Line No.");
                GateLine.SetRange("Ref. Document Type", "Ref. Document Type");
                GateLine.SetRange("Ref. Document No.", "Ref. Document No.");
                GateLine.SetRange("Line No.", "Line No.");
                GateLine.CalcSums("Challan Quantity");
                /*
                IF ("Party Type"="Party Type"::Vendor) AND ("Ref. Document Type"="Ref. Document Type"::"Purchase Order") AND
                   (GateLine."Challan Quantity" - xRec."Challan Quantity" + "Challan Quantity" > ("Total Quantity" - "Posted Actual Quantity"
                   )) THEN
                   ERROR(Text0001, ("Total Quantity" - "Posted Actual Quantity" - GateLine."Challan Quantity" + xRec."Challan Quantity"));
                */
                /*
                IF ("Party Type"="Party Type"::Vendor) AND ("Ref. Document Type"="Ref. Document Type"::"Purchase Order") AND
                   (GateLine."Challan Quantity" > "Total Quantity") THEN
                   ERROR(Text0001, ("Total Quantity"));
                */
                if("Party Type" = "party type"::Vendor) and ("Ref. Document Type" = "ref. document type"::"Purchase Order") and ("Challan Quantity" > "Total Quantity")then Error(Text0001, 'Challan Quantity', ("Total Quantity"));
                RecGateHeader.SetRange(RecGateHeader."No.", "Document No.");
                if RecGateHeader.Find('-')then if(RecGateHeader."Ref. Document Type" <> 3) and (RecGateHeader."Ref. Document Type" <> RecGateHeader."ref. document type"::Subcontracting)then begin
                        if "Challan Quantity" > "Total Quantity" then Error(Text0001, FieldCaption("Challan Quantity"), "Total Quantity");
                        "Actual Quantity":="Challan Quantity";
                    end
                    else
                    begin
                    // "Total Quantity":="Challan Quantity"; 5.51
                    // "Outstandiing Quantity":="Challan Quantity";  5.51
                    end;
            end;
        }
        field(16; "Posted Challan Quantity"; Decimal)
        {
            CalcFormula = sum("SSD Posted Gate Line"."Challan Quantity" where("Ref. Document Type"=field("Ref. Document Type"), "Ref. Document No."=field("Ref. Document No."), "Line No."=field("Line No.")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Posted Challan Quantity';
        }
        field(17; "Total Quantity"; Decimal)
        {
            Caption = 'Total Quantity';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                CheckDocumentType();
            end;
        }
        field(18; "Expected Receipt Date"; Date)
        {
            Caption = 'Expected Receipt Date';
            DataClassification = CustomerContent;
        }
        field(28; "Responsibility Center"; Code[20])
        {
            Description = 'CF001';
            TableRelation = "Responsibility Center".Code;
            Caption = 'Responsibility Center';
            DataClassification = CustomerContent;
        }
        field(50000; "Posted Actual Quantity"; Decimal)
        {
            CalcFormula = sum("SSD Posted Gate Line"."Actual Quantity" where("Ref. Document Type"=field("Ref. Document Type"), "Ref. Document No."=field("Ref. Document No."), "Line No."=field("Line No.")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Posted Actual Quantity';
        }
        field(50003; "Ref. Document Line No."; Integer)
        {
            Description = 'CF001';
            Caption = 'Ref. Document Line No.';
            DataClassification = CustomerContent;
        }
        field(50004; "Description 3"; Text[300])
        {
            Description = 'ALLE-AT';
            Caption = 'Description 3';
            DataClassification = CustomerContent;
        }
        field(50052; "Actual Quantity"; Decimal)
        {
            Caption = 'Actual Quantity';
            DataClassification = CustomerContent;
        }
        field(50053; "No. 2"; Code[20])
        {
            CalcFormula = lookup(Item."No. 2" where("No."=field("No.")));
            Description = 'CF001 No. 2 Flow from Item Master';
            FieldClass = FlowField;
            Caption = 'No. 2';
        }
        field(50054; "Description 2"; Text[50])
        {
            CalcFormula = lookup(Item."Description 2" where("No."=field("No.")));
            FieldClass = FlowField;
            Caption = 'Description 2';
        }
        field(50055; Grade; Text[30])
        {
            //CalcFormula = lookup(Item.Grade where("No." = field("No."))); //SSDU
            Description = 'PK CGN 005 (flow grade from item master)';
            //FieldClass = FlowField; //SSDU
            Caption = 'Grade';
        }
        field(50056; Thickness; Decimal)
        {
            //CalcFormula = lookup(Item."Thick (mm)" where("No." = field("No."))); //SSU
            Description = 'PK IND 005 (flow Thick from item master)060507';
            //FieldClass = FlowField; SSDU
            Caption = 'Thickness';
        }
        field(50057; Width; Decimal)
        {
            //CalcFormula = lookup(Item."Blank Width (mm)" where("No." = field("No."))); //SSDU
            Description = 'PK IND 005 (flow Width from item master)060507';
            //FieldClass = FlowField; SSDU
            Caption = 'Width';
        }
        field(50058; Length; Decimal)
        {
            //CalcFormula = lookup(Item."Blank Length (mm)" where("No." = field("No."))); //SSDU
            Description = 'PK IND 005 (flow Length from item master)060507';
            //FieldClass = FlowField; SSDU
            Caption = 'Length';
        }
        field(50059; "Direct Unit Cost"; Decimal)
        {
            Description = 'ALLE-AT';
            Caption = 'Direct Unit Cost';
            DataClassification = CustomerContent;
        }
        field(54025; "Customer No."; Code[20])
        {
            Description = 'ALLE-TRA1.0';
            TableRelation = Customer."No.";
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
        }
        field(54026; "SalesPerson Code"; Code[10])
        {
            Description = 'ALLE-TRA1.0';
            TableRelation = "Salesperson/Purchaser".Code;
            Caption = 'SalesPerson Code';
            DataClassification = CustomerContent;
        }
        field(60008; Trading; Boolean)
        {
            Description = 'ALLE-AA_CML/Purch 19.11.07';
            Caption = 'Trading';
            DataClassification = CustomerContent;
        }
        //SSD Sunil
        field(60009; "Vendor Item Description"; Text[100])
        {
            Description = 'Vendor Item Description';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Vendor Item Description';
        }
    }
    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Ref. Document Type", "Ref. Document No.", "Line No.")
        {
            SumIndexFields = "Challan Quantity";
        }
        key(Key3; "Party Type", "Party No.", "Ref. Document Type", "Ref. Document No.", Type, "No.", "Ref. Document Line No.")
        {
            SumIndexFields = "Challan Quantity";
        }
        key(Key4; "Document No.", "Party Type", "Party No.")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        GEHeader.Get("Document No.");
        "Party Type":=GEHeader."Party Type";
        "Party No.":=GEHeader."Party No.";
        "Ref. Document Type":=GEHeader."Ref. Document Type";
        "Ref. Document No.":=GEHeader."Ref. Document No.";
        CalcFields("Max Line No.");
        "Line No.":="Max Line No." + 10000;
        CalcFields("Posted Challan Quantity");
    //CF001 St
    //SSD "Responsibility Center" := UserMgt.GetRespCenterFilter;
    //CF001 En
    end;
    var Item: Record Item;
    FA: Record "Fixed Asset";
    GEHeader: Record "SSD Gate Header";
    Text0001: label '%1 must be less than  or equal to %2.';
    GateHeader: Record "SSD Gate Header";
    //SSD UserMgt: Codeunit "SSD User Setup Management";
    RecGateHeader: Record "SSD Gate Header";
    no: Code[20];
    procedure CheckDocumentType()
    begin
        if GateHeader.Get("Document No.")then begin
            case GateHeader."Ref. Document Type" of GateHeader."ref. document type"::"Purchase Order": Error('You can''t modify the record');
            GateHeader."ref. document type"::"RGP Outbound": Error('You can''t modify the record');
            end;
        end
        else
            Error('Gate Header doesn''t exist');
    end;
    procedure GateCaptionClass(FieldNo1: Integer): Text[3]var
        GateHeader: Record "SSD Gate Header";
    begin
        if not GateHeader.Get("Document No.")then begin
            GateHeader."No.":='';
            GateHeader.Init;
        end;
        case GateHeader."Ref. Document Type" of GateHeader."ref. document type"::"Purchase Order": exit('7,1');
        GateHeader."ref. document type"::"RGP Outbound": exit('7,1');
        GateHeader."ref. document type"::"Cash Purchase": exit('7,1');
        GateHeader."ref. document type"::"RGP Inbound": exit('7,1');
        else
            exit('8,1');
        end;
    end;
}
