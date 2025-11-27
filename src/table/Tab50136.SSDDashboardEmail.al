table 50136 "SSD Dashboard Email"
{
    Caption = 'Dashboard Email';
    DataClassification = ToBeClassified;

    fields
    {
        field(4; "Object Type to Run"; Option)
        {
            Caption = 'Object Type to Run';
            InitValue = "Report";
            OptionCaption = ',,,Report,,Codeunit';
            OptionMembers = , , , "Report", , "Codeunit";

            trigger OnValidate()
            begin
                if "Object Type to Run" <> xRec."Object Type to Run" then Validate("Report ID", 0);
            end;
        }
        field(5; "Report ID"; Integer)
        {
            Caption = 'Object ID';
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type"=FIELD("Object Type to Run"));

            trigger OnValidate()
            begin
                IF AllObjectCaption.Get(ObjectType::Report, "Report ID")then Description:=AllObjectCaption."Object Caption"
                else
                    Description:='';
            end;
        }
        field(6; "To Mail"; Text[1050])
        {
            Caption = 'To Mail';
        }
        field(7; "CC Mail"; Text[1050])
        {
            Caption = 'CC Mail';
        }
        field(8; "Mail Subject"; Text[150])
        {
            Caption = 'Mail Subject';
        }
        field(9; "Mail Body"; Text[1050])
        {
            Caption = 'Mail Body';
        }
        field(15; "BCC Mail"; Text[1050])
        {
            Caption = 'BCC Mail';
        }
        field(25; "Description"; Text[1050])
        {
            Caption = 'Description';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Report ID")
        {
            Clustered = true;
        }
    }
    var AllObjectCaption: Record AllObjWithCaption;
}
