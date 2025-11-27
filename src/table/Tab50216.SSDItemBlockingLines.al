Table 50216 "SSD Item Blocking Lines"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Item No"; Code[20])
        {
            TableRelation = Item;
            Caption = 'Item No';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "User Id":=UserId;
            end;
        }
        field(2; "Customer No."; Code[20])
        {
            TableRelation = Customer;
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
        }
        field(3; "Date since Bloacked"; Date)
        {
            Caption = 'Date since Bloacked';
            DataClassification = CustomerContent;
        }
        field(4; "User Id"; Code[20])
        {
            Editable = false;
            Caption = 'User Id';
            DataClassification = CustomerContent;
        }
        field(5; "Qty to Reserve"; Decimal)
        {
            Caption = 'Qty to Reserve';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Item No", "Customer No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
