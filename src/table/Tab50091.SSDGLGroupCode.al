Table 50091 "SSD G/L Group Code"
{
    Caption = 'G/L Group Code';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "G/L Group Code"; Code[50])
        {
            Caption = 'G/L Group Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "G/L Group Code")
        {
            Clustered = true;
        }
        key(Key2; Description)
        {
        }
    }
    fieldgroups
    {
    }
    var VendorIncidenceCode: Record "SSD Amazon Staging";
    procedure Navegar()
    var
        FNavigate: Page Navigate;
    begin
    end;
}
