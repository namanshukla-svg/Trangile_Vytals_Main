Table 50097 "SSD Quality Order Sample Line"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Quality Order No."; Code[20])
        {
            Caption = 'Quality Order No.';
            Editable = false;
            TableRelation = "SSD Quality Order Line"."Document No.";
            DataClassification = CustomerContent;
        }
        field(2; "Quality Order Line No."; Integer)
        {
            Editable = false;
            TableRelation = "SSD Quality Order Line"."Line No." where("Document No."=field("Quality Order No."));
            DataClassification = CustomerContent;
            Caption = 'Quality Order Line No.';
        }
        field(3; "Document Type"; Option)
        {
            Description = 'InitialSample,Hour';
            OptionCaption = 'InitialSample,Hour';
            OptionMembers = InitialSample, Hour;
            DataClassification = CustomerContent;
            Caption = 'Document Type';
        }
        field(4; "Working Date"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Working Date';
        }
        field(5; "Working Shift Code"; Code[10])
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Working Shift Code';
        }
        field(6; "Line No."; Integer)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(10; Value; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Value';
        }
        field(11; "Template Type"; Option)
        {
            Editable = false;
            OptionCaption = 'Receipt,Manufacturing,Routing';
            OptionMembers = Receipt, Manufacturing, Routing;
            DataClassification = CustomerContent;
            Caption = 'Template Type';
        }
        field(12; "Ref. Quality Order No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Ref. Quality Order No.';
        }
        field(20; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Released';
            OptionMembers = Open, Released;
            DataClassification = CustomerContent;
            Caption = 'Status';
        }
        field(30; Finished; Boolean)
        {
            Description = 'Finished after Completion of Prod. Order';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Finished';
        }
        field(50; "Work Order No."; Code[20])
        {
            CalcFormula = lookup("SSD Quality Order Header"."Source Code" where("Template Type"=field("Template Type"), "No."=field("Quality Order No.")));
            Description = 'Coming From QOrder.Source Code';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Work Order No.';
        }
        field(51; "Work Order Line No."; Integer)
        {
            CalcFormula = lookup("SSD Quality Order Header"."Source Doc. Line No." where("Template Type"=field("Template Type"), "No."=field("Quality Order No.")));
            Description = 'Coming From QOrder.Source Line No.';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Work Order Line No.';
        }
        field(52; "Item No."; Code[20])
        {
            CalcFormula = lookup("SSD Quality Order Header"."Item No." where("Template Type"=field("Template Type"), "No."=field("Quality Order No.")));
            Description = 'Coming From QOrder.Item No.';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Item No.';
        }
        field(53; "Lot No."; Code[20])
        {
            Description = 'Coming From Item Ledger Entry With Prod. Order No.,Prod. Order Line No.';
            DataClassification = CustomerContent;
            Caption = 'Lot No.';

            trigger OnLookup()
            var
                ItemLdgrEntryLocal: Record "Item Ledger Entry";
                FrmProdOrdLotInf: Page "Prod. Order Lot Information";
            begin
                CalcFields("Work Order No.", "Work Order Line No.", "Item No.");
                ItemLdgrEntryLocal.Reset;
                ItemLdgrEntryLocal.FilterGroup(2);
                ItemLdgrEntryLocal.SetCurrentkey("Order No.", "Order Line No.", "Prod. Order Comp. Line No.", "Entry Type");
                ItemLdgrEntryLocal.SetRange("Order No.", "Work Order No.");
                ItemLdgrEntryLocal.SetRange("Order Line No.", "Work Order Line No.");
                ItemLdgrEntryLocal.SetRange("Entry Type", ItemLdgrEntryLocal."entry type"::Output);
                ItemLdgrEntryLocal.SetRange("Item No.", "Item No.");
                ItemLdgrEntryLocal.SetFilter("Posting Date", '<=%1', "Working Date");
                ItemLdgrEntryLocal.FilterGroup(0);
                if ItemLdgrEntryLocal.Find('-')then begin
                    Clear(FrmProdOrdLotInf);
                    FrmProdOrdLotInf.SetTableview(ItemLdgrEntryLocal);
                    FrmProdOrdLotInf.LookupMode(true);
                    if FrmProdOrdLotInf.RunModal = Action::LookupOK then begin
                        FrmProdOrdLotInf.GetRecord(ItemLdgrEntryLocal);
                        "Lot No.":=ItemLdgrEntryLocal."Lot No.";
                    end;
                end;
            end;
            trigger OnValidate()
            var
                ItemLdgrEntryLocal: Record "Item Ledger Entry";
            begin
                if "Lot No." <> '' then begin
                    CalcFields("Work Order No.", "Work Order Line No.", "Item No.");
                    ItemLdgrEntryLocal.Reset;
                    ItemLdgrEntryLocal.SetCurrentkey("Order No.", "Order Line No.", "Prod. Order Comp. Line No.", "Entry Type");
                    ItemLdgrEntryLocal.SetRange("Order No.", "Work Order No.");
                    ItemLdgrEntryLocal.SetRange("Order Line No.", "Work Order Line No.");
                    ItemLdgrEntryLocal.SetRange("Entry Type", ItemLdgrEntryLocal."entry type"::Output);
                    ItemLdgrEntryLocal.SetRange("Item No.", "Item No.");
                    //SSD ItemLdgrEntryLocal.SetRange("Lot No.", "Lot No.");
                    ItemLdgrEntryLocal.SetFilter("Posting Date", '<=%1', "Working Date");
                    if not ItemLdgrEntryLocal.Find('-')then Error(Text001, "Lot No.", "Work Order No.", "Work Order Line No.");
                end;
            end;
        }
        field(50001; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Editable = false;
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Quality Order No.", "Quality Order Line No.", "Document Type", "Working Date", "Working Shift Code", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Ref. Quality Order No.", "Quality Order Line No.", "Document Type", "Line No.")
        {
        }
        key(Key3; "Template Type", "Document Type", "Working Date", "Working Shift Code", "Lot No.", "Quality Order No.")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        StatusCheck;
    end;
    trigger OnModify()
    begin
        StatusCheck;
    end;
    trigger OnRename()
    begin
        Error('');
    end;
    var Text001: label 'Lot No. %1 not Found for Prod. Order No. %2 , Prod. Order Line No. %3';
    procedure StatusCheck()
    begin
        TestField(Finished, false);
        TestField(Status, Status::Open);
    end;
}
