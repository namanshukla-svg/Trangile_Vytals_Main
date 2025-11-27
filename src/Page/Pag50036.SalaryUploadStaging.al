page 50036 "Salary Upload Staging"
{
    ApplicationArea = All;
    Caption = 'Salary Upload Staging';
    PageType = List;
    SourceTable = "SSD Salary Upload Staging";
    UsageCategory = History;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    DeleteAllowed = true; //SSD Sunil after change true to false

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("ATT Award"; Rec."ATT Award")
                {
                    ToolTip = 'Specifies the value of the ATT Award field.';
                }
                field("Bank Account Number"; Rec."Bank Account Number")
                {
                    ToolTip = 'Specifies the value of the Bank Account Number field.';
                }
                field("Bank Branch"; Rec."Bank Branch")
                {
                    ToolTip = 'Specifies the value of the Bank Branch field.';
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ToolTip = 'Specifies the value of the Bank Name field.';
                }
                field(Basic; Rec.Basic)
                {
                    ToolTip = 'Specifies the value of the Basic field.';
                }
                field("Beneficiary Name"; Rec."Beneficiary Name")
                {
                    ToolTip = 'Specifies the value of the Beneficiary Name field.';
                }
                field("Company Name"; Rec."Company Name")
                {
                    ToolTip = 'Specifies the value of the Company Name field.';
                }
                field("Cost Center Name"; Rec."Cost Center Name")
                {
                    ToolTip = 'Specifies the value of the Cost Center Name field.';
                }
                field(DOJ; Rec.DOJ)
                {
                    ToolTip = 'Specifies the value of the DOJ field.';
                }
                field(DOL; Rec.DOL)
                {
                    ToolTip = 'Specifies the value of the DOL field.';
                }
                field("DVR REIM"; Rec."DVR REIM")
                {
                    ToolTip = 'Specifies the value of the DVR REIM field.';
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field(Designation; Rec.Designation)
                {
                    ToolTip = 'Specifies the value of the Designation field.';
                }
                field(EECLWF; Rec.EECLWF)
                {
                    ToolTip = 'Specifies the value of the EECLWF field.';
                }
                field(ESI; Rec.ESI)
                {
                    ToolTip = 'Specifies the value of the ESI field.';
                }
                field("Emp Location"; Rec."Emp Location")
                {
                    ToolTip = 'Specifies the value of the Emp Location field.';
                }
                field("Employee Code"; Rec."Employee Code")
                {
                    ToolTip = 'Specifies the value of the Employee Code field.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field("Employee Status"; Rec."Employee Status")
                {
                    ToolTip = 'Specifies the value of the Employee Status field.';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field(Female; Rec.Female)
                {
                    ToolTip = 'Specifies the value of the Female field.';
                }
                field("Fuel REIM"; Rec."Fuel REIM")
                {
                    ToolTip = 'Specifies the value of the Fuel REIM field.';
                }
                field("GROSS DED"; Rec."GROSS DED")
                {
                    ToolTip = 'Specifies the value of the GROSS DED field.';
                }
                field("GWA OT"; Rec."GWA OT")
                {
                    ToolTip = 'Specifies the value of the GWA OT field.';
                }
                field(Grade; Rec.Grade)
                {
                    ToolTip = 'Specifies the value of the Grade field.';
                }
                field("Gross Earn"; Rec."Gross Earn")
                {
                    ToolTip = 'Specifies the value of the Gross Earn field.';
                }
                field(HRA; Rec.HRA)
                {
                    ToolTip = 'Specifies the value of the HRA field.';
                }
                field("IFSE code"; Rec."IFSE code")
                {
                    ToolTip = 'Specifies the value of the IFSE code field.';
                }
                field(IT; Rec.IT)
                {
                    ToolTip = 'Specifies the value of the IT field.';
                }
                field(LTA; Rec.LTA)
                {
                    ToolTip = 'Specifies the value of the LTA field.';
                }
                field(Location; Rec.Location)
                {
                    ToolTip = 'Specifies the value of the Location field.';
                }
                field("MEALS REC"; Rec."MEALS REC")
                {
                    ToolTip = 'Specifies the value of the MEALS REC field.';
                }
                field("NET PAY"; Rec."NET PAY")
                {
                    ToolTip = 'Specifies the value of the NET PAY field.';
                }
                field("Other Earn"; Rec."Other Earn")
                {
                    ToolTip = 'Specifies the value of the Other Earn field.';
                }
                field("PAN Number"; Rec."PAN Number")
                {
                    ToolTip = 'Specifies the value of the PAN Number field.';
                }
                field(PF; Rec.PF)
                {
                    ToolTip = 'Specifies the value of the PF field.';
                }
                field(Paymode; Rec.Paymode)
                {
                    ToolTip = 'Specifies the value of the Paymode field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("SAL ADV"; Rec."SAL ADV")
                {
                    ToolTip = 'Specifies the value of the SAL ADV field.';
                }
                field("SPL ALLOW"; Rec."SPL ALLOW")
                {
                    ToolTip = 'Specifies the value of the SPL ALLOW field.';
                }
                field("Salary Hold"; Rec."Salary Hold")
                {
                    ToolTip = 'Specifies the value of the Salary Hold field.';
                }
                field(SeqID; Rec.SeqID)
                {
                    ToolTip = 'Specifies the value of the SeqID field.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("VPF SAL"; Rec."VPF SAL")
                {
                    ToolTip = 'Specifies the value of the VPF SAL field.';
                }
                field("Veh REIM"; Rec."Veh REIM")
                {
                    ToolTip = 'Specifies the value of the Veh REIM field.';
                }
            }
        }
    }
}
