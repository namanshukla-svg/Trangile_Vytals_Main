Table 50023 "SSD SalesDashBoardCommentLine"
{
    Caption = 'Sales DashBoard Comment Line';
    DrillDownPageID = "Sales Dashboard Comment Sheet";
    LookupPageID = "Sales Dashboard Comment Sheet";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,Shipment,Posted Invoice,Posted Credit Memo,Posted Return Receipt';
            OptionMembers = Quote, "Order", Invoice, "Credit Memo", "Blanket Order", "Return Order", Shipment, "Posted Invoice", "Posted Credit Memo", "Posted Return Receipt";
            DataClassification = CustomerContent;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(4; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(5; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(6; Comment; Text[250])
        {
            Caption = 'Comment';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "Comment Date":=Today;
                "Comment Time":=Time;
                "User Id":=UserId;
            end;
        }
        field(7; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
            DataClassification = CustomerContent;
        }
        field(8; "Comment Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Comment Date';
        }
        field(9; "Comment Time"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Comment Time';
        }
        field(10; "User Id"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'User Id';
        }
    }
    keys
    {
        key(Key1; "Document Type", "No.", "Document Line No.", "Code", "Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
    //ERROR(Text50002);
    end;
    trigger OnModify()
    begin
        Error(Text50001);
    end;
    var Text50001: label 'You can not modify once it get saved.';
    Text50002: label 'You can not delete comment once it get saved.';
    procedure SetUpNewLine()
    var
        SalesCommentLine: Record "Sales Comment Line";
    begin
        SalesCommentLine.SetRange("Document Type", "Document Type");
        SalesCommentLine.SetRange("No.", "No.");
        SalesCommentLine.SetRange("Document Line No.", "Document Line No.");
        SalesCommentLine.SetRange(Date, WorkDate);
        if not SalesCommentLine.Find('-')then Date:=WorkDate;
    end;
}
