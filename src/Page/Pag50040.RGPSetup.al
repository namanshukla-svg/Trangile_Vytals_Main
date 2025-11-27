Page 50040 "RGP Setup"
{
    // SM_PP001 13.07.2005 Reference to the Source table changed
    // ALLE 6.12.....57F4 Customisation
    ApplicationArea = All;
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "SSD AddOn Setup"; //SSD Sunil 
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("RGP In Nos"; Rec."RGP In Nos")
                {
                    ApplicationArea = All;
                }
                field("RGP Out Nos"; Rec."RGP Out Nos")
                {
                    ApplicationArea = All;
                }
                field("Posted RGP OUT Shipment Nos"; Rec."Posted RGP OUT Shipment Nos")
                {
                    ApplicationArea = All;
                }
                field("Posted RGP OUT Receipt Nos"; Rec."Posted RGP OUT Receipt Nos")
                {
                    ApplicationArea = All;
                }
                field("NRGP In Nos"; Rec."NRGP In Nos")
                {
                    ApplicationArea = All;
                }
                field("NRGP Out Nos"; Rec."NRGP Out Nos")
                {
                    ApplicationArea = All;
                }
                field("Posted RGP IN Shipment Nos"; Rec."Posted RGP IN Shipment Nos")
                {
                    ApplicationArea = All;
                }
                field("Posted RGP IN Receipt Nos"; Rec."Posted RGP IN Receipt Nos")
                {
                    ApplicationArea = All;
                }
            //SSD Sunil Not required
            /*
                field("57F4 Nos"; Rec."57F4 Nos")
                {
                    ApplicationArea = All;
                }
                field("57F4 Shpt Nos"; Rec."57F4 Shpt Nos")
                {
                    ApplicationArea = All;
                }
                field("57F4 Rcpt Nos"; Rec."57F4 Rcpt Nos")
                {
                    ApplicationArea = All;
                }
                */
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
        Rec.Reset;
        if not Rec.Get then begin
            Rec.Init;
            Rec.Insert;
        end;
    //ALLE-MSI
    //SSD Sunil to be deleted
    // if UserMgt.GetPurchasesFilter() <> '' then begin
    //     Rec.FilterGroup(2);
    //     Rec.SetRange(Code, UserMgt.GetPurchasesFilter());
    //     Rec.FilterGroup(0);
    // end;
    end;
    var UserMgt: Codeunit "User Setup Management";
}
