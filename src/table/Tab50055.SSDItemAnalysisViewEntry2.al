Table 50055 "SSD Item Analysis View Entry2"
{
    Caption = 'Item Analysis View Entry';
    DrillDownPageID = "Item Analysis View Entries";
    LookupPageID = "Item Analysis View Entries";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Analysis Area"; Option)
        {
            Caption = 'Analysis Area';
            OptionCaption = 'Sales,Purchase,Inventory';
            OptionMembers = Sales, Purchase, Inventory;
            DataClassification = CustomerContent;
        }
        field(2; "Analysis View Code"; Code[10])
        {
            Caption = 'Analysis View Code';
            NotBlank = true;
            TableRelation = "Item Analysis View".Code where("Analysis Area"=field("Analysis Area"), Code=field("Analysis View Code"));
            DataClassification = CustomerContent;
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(4; "Source Type"; Option)
        {
            Caption = 'Source Type';
            OptionCaption = ' ,Customer,Vendor,Item';
            OptionMembers = " ", Customer, Vendor, Item;
            DataClassification = CustomerContent;
        }
        field(5; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            TableRelation = if("Source Type"=const(Customer))Customer
            else if("Source Type"=const(Vendor))Vendor
            else if("Source Type"=const(Item))Item;
            DataClassification = CustomerContent;
        }
        field(8; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(9; "Dimension 1 Value Code"; Code[20])
        {
            CaptionClass = GetCaptionClass(1);
            Caption = 'Dimension 1 Value Code';
            DataClassification = CustomerContent;
        }
        field(10; "Dimension 2 Value Code"; Code[20])
        {
            CaptionClass = GetCaptionClass(2);
            Caption = 'Dimension 2 Value Code';
            DataClassification = CustomerContent;
        }
        field(11; "Dimension 3 Value Code"; Code[20])
        {
            CaptionClass = GetCaptionClass(3);
            Caption = 'Dimension 3 Value Code';
            DataClassification = CustomerContent;
        }
        field(12; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(13; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(14; "Item Ledger Entry Type"; Option)
        {
            Caption = 'Item Ledger Entry Type';
            OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output, ,Assembly Consumption,Assembly Output';
            OptionMembers = Purchase, Sale, "Positive Adjmt.", "Negative Adjmt.", Transfer, Consumption, Output, " ", "Assembly Consumption", "Assembly Output";
            DataClassification = CustomerContent;
        }
        field(15; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            OptionCaption = 'Direct Cost,Revaluation,Rounding,Indirect Cost,Variance';
            OptionMembers = "Direct Cost", Revaluation, Rounding, "Indirect Cost", Variance;
            DataClassification = CustomerContent;
        }
        field(21; "Invoiced Quantity"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Invoiced Quantity';
            DataClassification = CustomerContent;
        }
        field(22; "Sales Amount (Actual)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Sales Amount (Actual)';
            DataClassification = CustomerContent;
        }
        field(23; "Cost Amount (Actual)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount (Actual)';
            DataClassification = CustomerContent;
        }
        field(24; "Cost Amount (Non-Invtbl.)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount (Non-Invtbl.)';
            DataClassification = CustomerContent;
        }
        field(31; Quantity; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
        field(32; "Sales Amount (Expected)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Sales Amount (Expected)';
            DataClassification = CustomerContent;
        }
        field(33; "Cost Amount (Expected)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount (Expected)';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Analysis Area", "Analysis View Code", "Item No.", "Item Ledger Entry Type", "Entry Type", "Source Type", "Source No.", "Dimension 2 Value Code", "Dimension 3 Value Code", "Location Code", "Posting Date", "Entry No.")
        {
            Clustered = true;
            SumIndexFields = "Sales Amount (Actual)", "Sales Amount (Expected)", "Cost Amount (Actual)", "Cost Amount (Expected)", Quantity, "Invoiced Quantity", "Cost Amount (Non-Invtbl.)";
        }
    }
    fieldgroups
    {
    }
    var Text000: label '1,5,,Dimension 1 Value Code';
    Text001: label '1,5,,Dimension 2 Value Code';
    Text002: label '1,5,,Dimension 3 Value Code';
    ItemAnalysisView: Record "Item Analysis View";
    procedure GetCaptionClass(AnalysisViewDimType: Integer): Text[250]begin
        if(ItemAnalysisView."Analysis Area" <> "Analysis Area") or (ItemAnalysisView.Code <> "Analysis View Code")then ItemAnalysisView.Get("Analysis Area", "Analysis View Code");
        case AnalysisViewDimType of 1: begin
            if ItemAnalysisView."Dimension 1 Code" <> '' then exit('1,5,' + ItemAnalysisView."Dimension 1 Code");
            exit(Text000);
        end;
        2: begin
            if ItemAnalysisView."Dimension 2 Code" <> '' then exit('1,5,' + ItemAnalysisView."Dimension 2 Code");
            exit(Text001);
        end;
        3: begin
            if ItemAnalysisView."Dimension 3 Code" <> '' then exit('1,5,' + ItemAnalysisView."Dimension 3 Code");
            exit(Text002);
        end;
        end;
    end;
}
