PageExtension 50105 "SSD Vendor BA Card" extends "Vendor Bank Account Card"
{
    layout
    {
        addfirst(Transfer)
        {
            field("Beneficiary Name"; Rec."Beneficiary Name")
            {
                ApplicationArea = All;
            }
            field("Beneficiary Address"; Rec."Beneficiary Address")
            {
                ApplicationArea = All;
            }
            field("Beneficiary Address 2"; Rec."Beneficiary Address 2")
            {
                ApplicationArea = All;
            }
            field("Beneficiary Post Code"; Rec."Beneficiary Post Code")
            {
                ApplicationArea = All;
                Caption = 'Beneficiary Post Code/City';
            }
            field("Beneficiary City"; Rec."Beneficiary City")
            {
                ApplicationArea = All;
            }
        }
        addafter(Iban)
        {
            field("NEFT/RTGS Code"; Rec."NEFT/RTGS Code")
            {
                ApplicationArea = All;
            }
        }
    }
}
