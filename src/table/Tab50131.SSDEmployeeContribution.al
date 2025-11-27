Table 50131 "SSD Employee Contribution"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
            DataClassification = CustomerContent;
        }
        field(3; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
        }
        field(4; "Cost Centre"; Code[20])
        {
            Caption = 'Cost Centre';
            DataClassification = CustomerContent;
        }
        field(5; "PF EmpCon"; Decimal)
        {
            Caption = 'PF EmpCon';
            DataClassification = CustomerContent;
        }
        field(6; "ESI EmpCon"; Decimal)
        {
            Caption = 'ESI EmpCon';
            DataClassification = CustomerContent;
        }
        field(7; "LWF EmpCon"; Decimal)
        {
            Caption = 'LWF EmpCon';
            DataClassification = CustomerContent;
        }
        field(8; "NPS EmpCon"; Decimal)
        {
            Caption = 'NPS EmpCon';
            DataClassification = CustomerContent;
        }
        field(9; "PF Admin Charges"; Decimal)
        {
            Caption = 'PF Admin Charges';
            DataClassification = CustomerContent;
        }
        field(10; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(11; Remark; Text[100])
        {
            Caption = 'Remark';
            DataClassification = CustomerContent;
        }
        field(12; Status; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Open,Success,Fail';
            OptionMembers = Open, Success, Fail;
            Caption = 'Status';
        }
        field(13; "Emp Location"; Option)
        {
            OptionCaption = ' ,Corporate,Plant';
            OptionMembers = " ", Corporate, Plant;
            Caption = 'Emp Location';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
