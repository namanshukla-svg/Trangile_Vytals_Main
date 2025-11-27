Table 50089 "SSD Items Reclassification"
{
    Caption = 'Items Reclassification';
    DataCaptionFields = "Item No.";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            NotBlank = true;
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(2; "Reclass. Item No."; Code[20])
        {
            Caption = 'Reclass. Item No.';
            NotBlank = true;
            TableRelation = Item;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                CalcFields("Reclassified Item Name");
            end;
        }
        field(3; "Reclassif. Factor"; Decimal)
        {
            Caption = 'Reclassif. Factor';
            DataClassification = CustomerContent;
        }
        field(4; "Reclassified Item Name"; Text[30])
        {
            CalcFormula = lookup(Item.Description where("No."=field("Reclass. Item No.")));
            Caption = 'Reclassified Item Name';
            Editable = false;
            FieldClass = FlowField;
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
        key(Key1; "Item No.", "Reclass. Item No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
