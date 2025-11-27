Table 50057 "SSD Map User Dimension"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "User Id"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
            Caption = 'User Id';
            DataClassification = CustomerContent;
        }
        field(2; "Dimension Code"; Code[20])
        {
            TableRelation = Dimension.Code;
            Caption = 'Dimension Code';
            DataClassification = CustomerContent;
        }
        field(3; "Dimension Value"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code"=field("Dimension Code"));
            Caption = 'Dimension Value';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "User Id", "Dimension Code", "Dimension Value")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
