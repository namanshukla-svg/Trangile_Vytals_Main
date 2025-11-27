tableextension 50077 "SSD Return Shipment Header" extends "Return Shipment Header"
{
    fields
    {
        field(50007; "Hold Payment"; Boolean)
        {
            Description = 'HP1.0';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Hold Payment';
        }
        field(50100; "E-Way Bill No."; Text[30])
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'E-Way Bill No.';
        }
        field(50101; "E-Way Bill Date"; Text[30])
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'E-Way Bill Date';
        }
        field(50102; "E-Way Bill Validity"; Text[30])
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'E-Way Bill Validity';
        }
        field(50103; "E-Way-to generate"; Boolean)
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'E-Way-to generate';
        }
        field(50104; "E-Way Generated"; Boolean)
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'E-Way Generated';
        }
        field(50106; "Vechile No. Update Remark"; Text[250])
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'Vechile No. Update Remark';
        }
        field(50107; "E-Way Canceled"; Boolean)
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'E-Way Canceled';
        }
        field(50108; "New Vechile No."; Code[10])
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'New Vechile No.';
        }
        field(50109; "Transportation Distance"; Integer)
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'Transportation Distance';
        }
        field(55500; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            Description = 'Alle-[E-Way API]';
            TableRelation = "Shipping Agent";
            DataClassification = CustomerContent;
        }
        field(60003; Trading; Boolean)
        {
            Caption = 'Trading';
            Description = 'CE_AA002.01';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }
}
