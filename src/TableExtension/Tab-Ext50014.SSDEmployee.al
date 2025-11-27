TableExtension 50014 "SSD Employee" extends Employee
{
    fields
    {
        field(50000; "Employee Location"; Option)
        {
            OptionCaption = ' ,Corporate,Plant';
            OptionMembers = " ", Corporate, Plant;
            DataClassification = CustomerContent;
            Caption = 'Employee Location';
        }
        field(50008; "Employee Dimension Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Dimension Code"=const('EMPLOYEE'));
            Caption = 'Employee Dimension Code';
        }
        field(50009; "Business Segment"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code"=const('BUSINESS SEGMENT'));
            DataClassification = CustomerContent;
            Caption = 'Business Segment';
        }
        field(50100; "Consumption Entry"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Consumption Entry';
        }
        field(50101; "Inventory Movement"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inventory Movement';
        }
        field(50102; "GP Sales Invoice"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'GP Sales Invoice';
        }
        field(50103; "GP Transfer Shipment"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'GP Transfer Shipment';
        }
        field(50104; "GP Sub Con DC"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'GP Sub Con DC';
        }
        field(50105; "GP Credit Memo"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'GP Credit Memo';
        }
        field(50106; "GP RGP"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'GP RGP';
        }
        field(50107; "GP NRGP"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'GP NRGP';
        }
        field(50108; Password; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Password';
        }
    }
}
