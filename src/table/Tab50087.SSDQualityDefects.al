Table 50087 "SSD Quality Defects"
{
    Caption = 'Quality Defects';
    DrillDownPageID = "Quality Defect Codes";
    LookupPageID = "Quality Defect Codes";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Defect Code"; Code[10])
        {
            Caption = 'Defect Code';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Manufacturing Scrap"; Boolean)
        {
            Caption = 'Manufacturing Scrap';
            DataClassification = CustomerContent;
        }
        field(4; Comment; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Comment';
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
        key(Key1; "Defect Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnModify()
    begin
        if "Manufacturing Scrap" then if not Scrap.Get("Defect Code")then begin
                Scrap.Code:="Defect Code";
                Scrap.Description:=Description;
                Scrap.Insert;
            end;
    end;
    var Scrap: Record Scrap;
}
