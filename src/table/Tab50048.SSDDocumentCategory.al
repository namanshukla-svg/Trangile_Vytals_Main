Table 50048 "SSD Document Category"
{
    // *** Matriks Doc Version 3 ***
    // By Tim Ahrentl¢v for Matriks A/S.
    // Visit www.matriks.com for news and updates.
    Caption = 'Document Category';
    DrillDownPageID = "Get Posted NRGP Shipment";
    LookupPageID = "Get Posted NRGP Shipment";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
