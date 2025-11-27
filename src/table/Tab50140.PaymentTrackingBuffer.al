table 50140 "Payment Tracking Buffer"
{
    Caption = 'Payment Tracking Buffer';
    DataClassification = ToBeClassified;
    TableType = Temporary;

    fields
    {
        field(5; "GRN No."; Code[20])
        {
            Caption = 'GRN No.';
        }
        field(6; "GRN Date"; Date)
        {
            Caption = 'GRN Date';
        }
        field(7; "System GRN Date"; DateTime)
        {
            Caption = 'System GRN Date';
        }
        field(8; "PI No."; Code[20])
        {
            Caption = 'PI No.';
        }
        field(9; "PI Date"; Date)
        {
            Caption = 'PI Date';
        }
        field(10; "System PI Date"; DateTime)
        {
            Caption = 'System PI Date';
        }
        field(11; "Gate Entry No."; Code[20])
        {
            Caption = 'Gate Entry No.';
        }
        field(12; "Gate Entry Date"; Date)
        {
            Caption = 'Gate Entry Date';
        }
        field(13; "Receipt Send by Store Date Time"; DateTime)
        {
            Caption = 'Receipt Send by Store Date Time';
        }
        field(14; "Receipt Recd by Fin Date Time"; DateTime)
        {
            Caption = 'Receipt Recd by Fin Date Time';
        }
        field(15; "Payment Document No."; Code[20])
        {
            Caption = 'Payment Document No.';
        }
        field(16; "Payment Date"; Date)
        {
            Caption = 'Payment Date';
        }
        field(17; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(18; "PI Approval Stage 1 Date"; DateTime)
        {
            Caption = 'PI Approval Stage 1 Date';
        }
        field(19; "PI Approval Stage 2 Date"; DateTime)
        {
            Caption = 'PI Approval Stage 2 Date';
        }
        field(20; "PI Approval Stage 3 Date"; DateTime)
        {
            Caption = 'PI Approval Stage 3 Date';
        }
        field(21; "Total Days MRN TO PI Posting"; Integer)
        {
            Caption = 'Total Days MRN TO PI Posting';
        }
        field(22; "Total Days MRN To Payment Posting"; Integer)
        {
            Caption = 'Total Days MRN To Payment Posting';
        }
        field(23; "Days taken to post PI from receipt "; Integer)
        {
            Caption = 'Days taken to post PI from receipt ';
        }
        field(24; "Party Name"; Text[100])
        {
            Caption = 'Party Name';
        }
        field(25; "Invoice No."; Code[50])
        {
            Caption = 'Days taken to post PI from receipt ';
        }
        field(26; "PI Sent for Approval"; DateTime)
        {
            Caption = 'PI Sent for Approval Date';
        }
        field(28; "Party No."; Code[20])
        {
            Caption = 'Party No.';
        }
    }
    keys
    {
        key(PK; "GRN No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
