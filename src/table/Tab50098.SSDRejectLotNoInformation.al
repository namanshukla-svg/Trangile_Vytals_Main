Table 50098 "SSD Reject Lot No Information"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Template Type"; Option)
        {
            Editable = false;
            OptionCaption = 'Receipt,Manufacturing';
            OptionMembers = Receipt, Manufacturing;
            DataClassification = CustomerContent;
            Caption = 'Template Type';
        }
        field(2; "Quality Order No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(10; "Source Document No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Source Document No.';

            //This property is currently not supported
            //TestTableRelation = true;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = true;
            trigger OnLookup()
            var
                PurchaseHeaderLocal: Record "Purchase Header";
                WRHeaderLocal: Record "Warehouse Receipt Header";
                ProductionOrderLocal: Record "Production Order";
            begin
            end;
        }
        field(11; "Source Doc. Line No."; Integer)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Source Doc. Line No.';
        }
        field(12; "Item No."; Code[20])
        {
            Editable = false;
            TableRelation = Item;
            DataClassification = CustomerContent;
            Caption = 'Item No.';
        }
        field(13; "Variant Code"; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Variant Code';
        }
        field(14; "Lot No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Lot No.';

            trigger OnLookup()
            var
                LotNoInfLocal: Record "Lot No. Information";
                FrmLotNoInf: Page "Lot No. Information Card";
                WHReceiptLineLocal: Record "Warehouse Receipt Line";
            begin
                case "Template Type" of "template type"::Receipt: begin
                    if WHReceiptLineLocal.Get("Source Document No.", "Source Doc. Line No.")then begin
                        LotNoInfLocal.Reset;
                        LotNoInfLocal.SetCurrentkey("Item No.", "Variant Code", "Source Type", "Source Subtype", "Source ID", "Source Prod. Order Line");
                        LotNoInfLocal.FilterGroup(2);
                        LotNoInfLocal.SetRange("Item No.", "Item No.");
                        LotNoInfLocal.SetRange("Variant Code", "Variant Code");
                        LotNoInfLocal.SetRange("Source Type", WHReceiptLineLocal."Source Type");
                        LotNoInfLocal.SetRange("Source Subtype", WHReceiptLineLocal."Source Subtype");
                        LotNoInfLocal.SetRange("Source ID", WHReceiptLineLocal."Source No.");
                        LotNoInfLocal.SetRange("Source Ref. No.", WHReceiptLineLocal."Source Line No.");
                        LotNoInfLocal.FilterGroup(0);
                        if LotNoInfLocal.Find('-')then;
                        Clear(FrmLotNoInf);
                        FrmLotNoInf.SetTableview(LotNoInfLocal);
                        FrmLotNoInf.LookupMode(true);
                        FrmLotNoInf.Editable:=false;
                        if FrmLotNoInf.RunModal = Action::LookupOK then begin
                            FrmLotNoInf.GetRecord(LotNoInfLocal);
                            "Lot No.":=LotNoInfLocal."Lot No.";
                            "Lot Qty":=LotNoInfLocal."Lot Qty. To Handle";
                        end;
                    end;
                end;
                end;
            end;
            trigger OnValidate()
            var
                LotNoInfLocal: Record "Lot No. Information";
                WHReceiptLineLocal: Record "Warehouse Receipt Line";
            begin
                if "Lot No." <> '' then begin
                    if WHReceiptLineLocal.Get("Source Document No.", "Source Doc. Line No.")then begin
                        LotNoInfLocal.Reset;
                        LotNoInfLocal.SetCurrentkey("Item No.", "Variant Code", "Source Type", "Source Subtype", "Source ID", "Source Prod. Order Line");
                        LotNoInfLocal.SetRange("Item No.", WHReceiptLineLocal."Item No.");
                        LotNoInfLocal.SetRange("Variant Code", WHReceiptLineLocal."Variant Code");
                        LotNoInfLocal.SetRange("Source Type", WHReceiptLineLocal."Source Type");
                        LotNoInfLocal.SetRange("Source Subtype", WHReceiptLineLocal."Source Subtype");
                        LotNoInfLocal.SetRange("Source ID", WHReceiptLineLocal."Source No.");
                        LotNoInfLocal.SetRange("Source Ref. No.", WHReceiptLineLocal."Source Line No.");
                        LotNoInfLocal.SetRange("Lot No.", "Lot No.");
                        if not LotNoInfLocal.Find('-')then Error(Text001, "Lot No.", WHReceiptLineLocal."Source No.", WHReceiptLineLocal."Source Line No.");
                    end;
                end;
            end;
        }
        field(15; "Lot Qty"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Lot Qty';
        }
        field(16; "Rejected Qty"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Rejected Qty';

            trigger OnValidate()
            begin
                if "Rejected Qty" > "Lot Qty" then Error(Text002, FieldCaption("Rejected Qty"), "Lot Qty");
            end;
        }
        field(20; "Sub Template Type"; Option)
        {
            Caption = 'Entry Source Type';
            Editable = false;
            OptionCaption = ' ,RcvdCoil,Routing';
            OptionMembers = " ", RcvdCoil, Routing;
            DataClassification = CustomerContent;
        }
        field(21; "Sub Quality Order No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Sub Quality Order No.';
        }
    }
    keys
    {
        key(Key1; "Template Type", "Quality Order No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Template Type", "Quality Order No.", "Source Document No.", "Source Doc. Line No.", "Item No.", "Variant Code", "Sub Template Type", "Sub Quality Order No.")
        {
            SumIndexFields = "Rejected Qty";
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    var
        RejectLotNoInfLocal: Record "SSD Reject Lot No Information";
    begin
        RejectLotNoInfLocal.Reset;
        RejectLotNoInfLocal.SetRange("Template Type", "Template Type");
        RejectLotNoInfLocal.SetRange("Quality Order No.", "Quality Order No.");
        if RejectLotNoInfLocal.Find('+')then "Line No.":=RejectLotNoInfLocal."Line No." + 10000
        else
            "Line No.":=10000;
        ;
    end;
    var Text001: label 'Lot No. %1 not Found for Order No. %2 , Order Line No. %3';
    Text002: label '%1 Cannot be more than %2';
}
