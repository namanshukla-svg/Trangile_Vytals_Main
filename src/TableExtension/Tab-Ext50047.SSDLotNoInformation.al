TableExtension 50047 "SSD Lot No. Information" extends "Lot No. Information"
{
    fields
    {
        field(50002; "Source Type"; Integer)
        {
            Caption = 'Source Type';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50003; "Source Subtype"; Option)
        {
            Caption = 'Source Subtype';
            Editable = false;
            OptionCaption = '0,1,2,3,4,5,6,7,8,9,10';
            OptionMembers = "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10";
            DataClassification = CustomerContent;
        }
        field(50004; "Source ID"; Code[20])
        {
            Caption = 'Source ID';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50005; "Source Prod. Order Line"; Integer)
        {
            Caption = 'Source Prod. Order Line';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50006; "Source Ref. No."; Integer)
        {
            Caption = 'Source Ref. No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50007; "Lot Total Quantity"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Lot Total Quantity';
        }
        field(50008; "Lot Qty. To Handle"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Lot Qty. To Handle';
        }
    }
}
