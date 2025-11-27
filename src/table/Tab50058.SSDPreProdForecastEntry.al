Table 50058 "SSD Pre. Prod. Forecast Entry"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            TableRelation = Customer."No.";
            DataClassification = CustomerContent;
            Caption = 'Customer No.';

            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                if Customer.Get("Customer No.")then;
                "Customer Name":=Customer.Name;
            end;
        }
        field(2; "Item Code"; Code[20])
        {
            TableRelation = Item."No.";
            DataClassification = CustomerContent;
            Caption = 'Item Code';

            trigger OnValidate()
            var
                Item: Record Item;
            begin
                if Item.Get("Item Code")then;
                "Item Description":=Item.Description;
                "Item Description 2":=Item."Description 2";
            //SSD "Item Description 3" := Item."Description 3";
            end;
        }
        field(3; "Minimum Stock Level"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Minimum Stock Level';
        }
        field(4; "Item Description"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Item Description';
        }
        field(5; "Item Description 2"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Item Description 2';
        }
        field(6; "Item Description 3"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Item Description 3';
        }
        field(7; "Customer Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer Name';
        }
        field(8; "Month Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Month Date';
        }
        field(9; "Forecast Qty"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Forecast Qty';
        }
        field(10; "Posted to Production Forecast"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Posted to Production Forecast';
        }
    }
    keys
    {
        key(Key1; "Customer No.", "Item Code", "Month Date")
        {
            Clustered = true;
        }
        key(Key2; "Forecast Qty", "Item Code")
        {
        }
        key(Key3; "Month Date", "Item Code")
        {
        }
        key(Key4; "Customer No.", "Month Date", "Item Code")
        {
        }
    }
    fieldgroups
    {
    }
}
