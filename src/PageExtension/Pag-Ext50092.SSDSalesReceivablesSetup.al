PageExtension 50092 "SSD Sales Receivables Setup" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("GST Dependency Type")
        {
            field("E-Way User Name"; Rec."E-Way User Name")
            {
                ApplicationArea = All;
            }
            field("E-Way Password"; Rec."E-Way Password")
            {
                ApplicationArea = All;
                ExtendedDatatype = Masked;
            }
            field("Sales Forecast Nos."; Rec."Sales Forecast Nos.")
            {
                ApplicationArea = All;
            }
            field("Amazon Invoice Nos."; Rec."Amazon Invoice Nos.")
            {
                ApplicationArea = All;
            }
            field("Amazon Posted Invoice Nos."; Rec."Amazon Posted Invoice Nos.")
            {
                ApplicationArea = All;
            }
            field("Amazon Credit Memo Nos."; Rec."Amazon Credit Memo Nos.")
            {
                ApplicationArea = All;
            }
            field("Amazon Posted Credit Memo Nos."; Rec."Amazon Posted Credit Memo Nos.")
            {
                ApplicationArea = All;
            }
            field("Amazon Location Master"; Rec."Amazon Location Master")
            {
                ApplicationArea = All;
            }
            field("COA Start Date"; Rec."COA Start Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the COA Start Date field.', Comment = '%';
            }
        }
        addlast("Number Series")
        {
            field("Sales Dispatch No."; Rec."Sales Dispatch No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sales Dispatch No. field.';
            }
        }
    }
}
