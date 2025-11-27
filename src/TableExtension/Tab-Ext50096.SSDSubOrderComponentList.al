TableExtension 50096 "SSD Sub Order Component List" extends "Sub Order Component List"
{
    fields
    {
        field(50011; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            Description = 'CF001';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(1));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(50012; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Description = 'CF001';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(2));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(50015; Position; Code[10])
        {
            Caption = 'Position';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50016; "Position 2"; Code[10])
        {
            Caption = 'Position 2';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50017; "Position 3"; Code[10])
        {
            Caption = 'Position 3';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50018; "Production Lead Time"; DateFormula)
        {
            Caption = 'Production Lead Time';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50019; "Routing Link Code"; Code[10])
        {
            Caption = 'Routing Link Code';
            Description = 'CF001';
            TableRelation = "Routing Link";
            DataClassification = CustomerContent;
        }
        field(50028; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50029; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50040; Length; Decimal)
        {
            Caption = 'Length';
            DecimalPlaces = 0: 5;
            Description = 'CF001';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                Validate("Calculation Formula");
            end;
        }
        field(50041; Width; Decimal)
        {
            Caption = 'Width';
            DecimalPlaces = 0: 5;
            Description = 'CF001';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                Validate("Calculation Formula");
            end;
        }
        field(50042; Weight; Decimal)
        {
            Caption = 'Weight';
            DecimalPlaces = 0: 5;
            Description = 'CF001';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                Validate("Calculation Formula");
            end;
        }
        field(50043; Depth; Decimal)
        {
            Caption = 'Depth';
            DecimalPlaces = 0: 5;
            Description = 'CF001';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                Validate("Calculation Formula");
            end;
        }
        field(50044; "Calculation Formula"; Option)
        {
            Caption = 'Calculation Formula';
            Description = 'CF001';
            OptionCaption = ' ,Length,Length * Width,Length * Width * Depth,Weight';
            OptionMembers = " ", Length, "Length * Width", "Length * Width * Depth", Weight;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                /*tESTFIELD("No.");*/
                case "Calculation Formula" of "calculation formula"::" ": "Prod. Order Qty.":="Quantity per";
                "calculation formula"::Length: "Prod. Order Qty.":=ROUND(Length * "Quantity per", 0.00001);
                "calculation formula"::"Length * Width": "Prod. Order Qty.":=ROUND(Length * Width * "Quantity per", 0.00001);
                "calculation formula"::"Length * Width * Depth": "Prod. Order Qty.":=ROUND(Length * Width * Depth * "Quantity per", 0.00001);
                "calculation formula"::Weight: "Prod. Order Qty.":=ROUND(Weight * "Quantity per", 0.00001);
                end;
            end;
        }
        field(50045; "Company Bin Code"; Code[20])
        {
            Caption = 'Company Bin Code';
            Description = 'CF001';
            TableRelation = Bin.Code where("Location Code"=field("Company Location"));
            DataClassification = CustomerContent;
        }
        field(50046; "Vendor Bin Code"; Code[10])
        {
            Caption = 'Vendor Bin Code';
            Description = 'CF001';
            TableRelation = Bin.Code where("Location Code"=field("Vendor Location"));
            DataClassification = CustomerContent;
        }
    }
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
    end;
}
