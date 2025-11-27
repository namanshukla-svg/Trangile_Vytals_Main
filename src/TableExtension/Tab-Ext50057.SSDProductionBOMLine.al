TableExtension 50057 "SSD Production BOM Line" extends "Production BOM Line"
{
    fields
    {
        modify(Type)
        {
        trigger OnAfterValidate()
        var
            ProdBOMHeader: Record "Production BOM Header";
        begin
            ProdBOMHeader.GET("Production BOM No.");
            "Responsibility Center":=ProdBOMHeader."Responsibility Center";
            "BOM Category":=ProdBOMHeader."BOM Category";
        end;
        }
        field(50001; "BOM Category"; Option)
        {
            Description = 'TR diff for Tool Room or Normal';
            NotBlank = true;
            OptionCaption = 'Normal,Tool';
            OptionMembers = Normal, Tool;
            DataClassification = CustomerContent;
            Caption = 'BOM Category';
        }
        field(50050; "Responsibility Center"; Code[20])
        {
            Description = 'CF001';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center';
        }
        field(50051; "NO. 2"; Code[20])
        {
            CalcFormula = lookup(Item."No. 2" where("No."=field("No.")));
            Description = 'CEN001';
            FieldClass = FlowField;
            Caption = 'NO. 2';
        }
        field(50052; Grade; Text[30])
        {
            CalcFormula = lookup(Item.Grade where("No."=field("No.")));
            FieldClass = FlowField;
            Caption = 'Grade';
        }
        field(50053; "Routing Code"; Code[10])
        {
            TableRelation = "Routing Link";
            DataClassification = CustomerContent;
            Caption = 'Routing Code';
        }
        field(50054; "Location Code"; Code[10])
        {
            Description = 'ALLE5.51';
            TableRelation = Location;
            DataClassification = CustomerContent;
            Caption = 'Location Code';
        }
        field(50055; "Bin Code"; Code[20])
        {
            Description = 'ALLE5.51';
            DataClassification = CustomerContent;
            Caption = 'Bin Code';

            trigger OnLookup()
            begin
                "Bin Code":=WMSManagement.BinLookUp("Location Code", "No.", "Variant Code", ''); //5.51
            end;
            trigger OnValidate()
            begin
                TestField("Location Code");
            end;
        }
    }
    var WMSManagement: Codeunit "WMS Management";
}
