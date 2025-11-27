Table 50031 "SSD User Res. Center Setup"
{
    LookupPageID = "User Templates";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "User ID"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
            DataClassification = CustomerContent;
            Caption = 'User ID';
        }
        field(3; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center';
        }
    }
    keys
    {
        key(Key1; "User ID", "Responsibility Center")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var GenJnlTemplate: Record "Gen. Journal Template";
    ItemJnlTemplate: Record "Item Journal Template";
    ReqWorksheetTemplate: Record "Req. Wksh. Template";
}
