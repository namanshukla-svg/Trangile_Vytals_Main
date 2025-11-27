PageExtension 50108 "SSD Vendor List" extends "Vendor List"
{
    layout
    {
        addafter(Name)
        {
            field("MSME Registerd"; Rec."MSME Registerd")
            {
                ApplicationArea = All;
            }
            field("MSME Activity"; Rec."MSME Activity")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MSME Activity field.';
            }
            field("MSME Category"; Rec."MSME Category")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MSME Category field.';
            }
            field("MSME Classification Year"; Rec."MSME Classification Year")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MSME Classification Year field.', Comment = '%';
            }
            field("Udhyam Registration Number"; Rec."Udhyam Registration Number")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Udhyam Registration Number field.', Comment = '%';
            }
            field(Address; Rec.Address)
            {
                ApplicationArea = All;
            }
            field("Address 2"; Rec."Address 2")
            {
                ApplicationArea = All;
            }
            field(City; Rec.City)
            {
                ApplicationArea = All;
            }
        }
        addafter("Lead Time Calculation")
        {
            field("Balance Due"; Rec."Balance Due")
            {
                ApplicationArea = All;
            }
        }
        addafter("Base Calendar Code")
        {
            field("GST Vendor Type"; Rec."GST Vendor Type")
            {
                ApplicationArea = All;
            }
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnDeleteRecord(): Boolean begin
        ERROR('You are not authorise to delete this record');
    end;
}
