tableextension 50123 "Approval Entry" extends "Approval Entry"
{
    fields
    {
        field(50000; "Order Type"; Enum "SSD Purchase Order Type")
        {
            Caption = 'Order Type';
            DataClassification = ToBeClassified;
        }
        field(50014; "Indent Order Type"; Option)
        {
            OptionMembers = " ",Inventory,"Fixed Assets",Services;
            DataClassification = CustomerContent;
        }
    }
}
