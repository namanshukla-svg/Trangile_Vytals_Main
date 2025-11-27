Table 50005 "SSD Posted Indent Header"
{
    // vipin 17.03.08 new key on field posting date created
    DataCaptionFields = "No.", "Requester ID";
    DrillDownPageID = "Posted Indent List";
    LookupPageID = "Posted Indent List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(10; Remarks; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Remarks';
        }
        field(12; "Due Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Due Date';
        }
        field(13; "Requester ID"; Code[20])
        {
            TableRelation = Employee;
            DataClassification = CustomerContent;
            Caption = 'Requester ID';
        }
        field(15; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
            end;
        }
        field(16; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
            end;
        }
        field(17; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center".Code;
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center';
        }
        field(50; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(50001; "Indent Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Indent Date';
        }
        field(50002; "User ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'User ID';

            trigger OnLookup()
            begin
                //SSD LoginMgt.LookupUserID("User ID");
            end;
        }
        field(50003; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Date';
        }
        field(50014; "Indent Order Type"; Option)
        {
            OptionMembers = " ",Inventory,"Fixed Assets",Services;
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Posting Date")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        //Alle Event Start
        // PostedIndentLine.SETRANGE("Document No.", "No.");
        // IF PostedIndentLine.FIND('-') THEN
        // PostedIndentLine.DELETEALL;
        //
        // InvtComnt.SETRANGE("Document Type", InvtComnt."Document Type"::"5");
        // InvtComnt.SETRANGE("No.", "No.");
        // IF InvtComnt.FIND('-') THEN
        // InvtComnt.DELETEALL;
        //Alle Event Stop
        /* // BIS 1145
            //Dimension
            PostedDocDim.RESET;
            PostedDocDim.SETRANGE("Table ID",DATABASE::"Posted Indent Header");
            PostedDocDim.SETRANGE("Document No.","No.");
            PostedDocDim.DELETEALL;
            PostedDocDim.SETRANGE("Table ID",DATABASE::"Posted Indent Line");
            PostedDocDim.DELETEALL;
            */
    end;

    var
        LoginMgt: Codeunit "User Management";
        PostedIndentLine: Record "SSD Posted Indent Line";
        InvtComnt: Record "Inventory Comment Line";
}
