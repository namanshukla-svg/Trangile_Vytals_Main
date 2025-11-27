Table 50026 "SSD Permission Selection"
{
    Caption = 'Permission Selection';
    DataPerCompany = true;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Role ID"; Code[20])
        {
            Caption = 'Role ID';
            TableRelation = User.State;
            DataClassification = CustomerContent;
        }
        field(2; "Role Name"; Text[30])
        {
            Caption = 'Role Name';
            FieldClass = Normal;
            DataClassification = CustomerContent;
        }
        field(3; "Object Type"; Option)
        {
            Caption = 'Object Type';
            OptionCaption = 'Table Data,Table,Form,Report,Dataport,Codeunit,,,,,System';
            OptionMembers = "Table Data", "Table", Form, "Report", Dataport, "Codeunit", , , , , System;
            DataClassification = CustomerContent;
        }
        field(4; "Object ID"; Integer)
        {
            Caption = 'Object ID';
            DataClassification = CustomerContent;
        }
        field(5; "Object Name"; Text[249])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type"=field("Object Type"), "Object ID"=field("Object ID")));
            Caption = 'Object Name';
            FieldClass = FlowField;
        }
        field(6; "Read Permission"; Option)
        {
            Caption = 'Read Permission';
            InitValue = Yes;
            OptionCaption = ' ,Yes,Indirect';
            OptionMembers = " ", Yes, Indirect;
            DataClassification = CustomerContent;
        }
        field(7; "Insert Permission"; Option)
        {
            Caption = 'Insert Permission';
            InitValue = Yes;
            OptionCaption = ' ,Yes,Indirect';
            OptionMembers = " ", Yes, Indirect;
            DataClassification = CustomerContent;
        }
        field(8; "Modify Permission"; Option)
        {
            Caption = 'Modify Permission';
            InitValue = Yes;
            OptionCaption = ' ,Yes,Indirect';
            OptionMembers = " ", Yes, Indirect;
            DataClassification = CustomerContent;
        }
        field(9; "Delete Permission"; Option)
        {
            Caption = 'Delete Permission';
            InitValue = Yes;
            OptionCaption = ' ,Yes,Indirect';
            OptionMembers = " ", Yes, Indirect;
            DataClassification = CustomerContent;
        }
        field(10; "Execute Permission"; Option)
        {
            Caption = 'Execute Permission';
            InitValue = Yes;
            OptionCaption = ' ,Yes,Indirect';
            OptionMembers = " ", Yes, Indirect;
            DataClassification = CustomerContent;
        }
        field(11; "Security Filter"; TableFilter)
        {
            Caption = 'Security Filter';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Role ID", "Object Type", "Object ID")
        {
            Clustered = true;
        }
        key(Key2; "Object Type", "Object ID")
        {
        }
    }
    fieldgroups
    {
    }
}
