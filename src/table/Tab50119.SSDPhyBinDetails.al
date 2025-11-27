Table 50119 "SSD Phy. Bin Details"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            TableRelation = Location;
            Caption = 'Location Code';
            DataClassification = CustomerContent;
        }
        field(2; "Bin Code"; Code[20])
        {
            TableRelation = Bin.Code where("Location Code"=field("Location Code"));
            Caption = 'Bin Code';
            DataClassification = CustomerContent;
        }
        field(3; "Phy. Bin Code"; Code[20])
        {
            Caption = 'Phy. Bin Code';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Location Code", "Bin Code", "Phy. Bin Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(tEST; "Location Code", "Bin Code", "Phy. Bin Code")
        {
        }
    }
}
