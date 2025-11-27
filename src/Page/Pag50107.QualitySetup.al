Page 50107 "Quality Setup"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    Editable = true;
    PageType = Card;
    SourceTable = "SSD Quality Setup";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Activate Quality Control Man."; Rec."Activate Quality Control Man.")
                {
                    ApplicationArea = All;
                }
                field("Resupply in Order"; Rec."Resupply in Order")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ResupplyinOrderOnAfterValidate;
                    end;
                }
                field("Requisition Worksheet"; Rec."Requisition Worksheet")
                {
                    ApplicationArea = All;
                    Enabled = "Requisition WorksheetEnable";
                }
                field("Requisition Sheet Batch"; Rec."Requisition Sheet Batch")
                {
                    ApplicationArea = All;
                    Enabled = "Requisition Sheet BatchEnable";
                }
                field("Quality Source Code"; Rec."Quality Source Code")
                {
                    ApplicationArea = All;
                }
                field("Rejection Location Code"; Rec."Rejection Location Code")
                {
                    ApplicationArea = All;
                }
                field("Rework Location Code"; Rec."Rework Location Code")
                {
                    ApplicationArea = All;
                }
                field("Scrap Location Code"; Rec."Scrap Location Code")
                {
                    ApplicationArea = All;
                }
                field("Trading Rejection Location"; Rec."Trading Rejection Location")
                {
                    ApplicationArea = All;
                }
            }
            group(Numbering)
            {
                Caption = 'Numbering';

                field("Sample Test Nos."; Rec."Sample Test Nos.")
                {
                    ApplicationArea = All;
                }
                field("Rcvd. Sampling Temp. No."; Rec."Rcvd. Sampling Temp. No.")
                {
                    ApplicationArea = All;
                }
                field("Manf. Sampling Temp. No."; Rec."Manf. Sampling Temp. No.")
                {
                    ApplicationArea = All;
                }
                field("Rcvd. Quality Ord No."; Rec."Rcvd. Quality Ord No.")
                {
                    ApplicationArea = All;
                }
                field("Manf. Quality Ord. No."; Rec."Manf. Quality Ord. No.")
                {
                    ApplicationArea = All;
                }
                field("Manf. Sub Quality Ord No."; Rec."Manf. Sub Quality Ord No.")
                {
                    ApplicationArea = All;
                }
                field("Rcvd. Sub Quality Ord No."; Rec."Rcvd. Sub Quality Ord No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Eval. Temp. Nos."; Rec."Vendor Eval. Temp. Nos.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Eval. Nos."; Rec."Vendor Eval. Nos.")
                {
                    ApplicationArea = All;
                }
            }
            group(Manufacturing)
            {
                Caption = 'Manufacturing';

                part(Control1000000012; "Setup Quality Sub-Template")
                {
                    SubPageLink = "Responsibility Center"=field("Responsibility Center");
                    SubPageView = sorting("Template Type", "Responsibility Center", "Process / Operation No.", "Line No.")order(ascending)where("Template Type"=const(Manufacturing));
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        "Requisition WorksheetEnable":=not Rec."Resupply in Order";
        "Requisition Sheet BatchEnable":=not Rec."Resupply in Order";
    end;
    trigger OnInit()
    begin
        "Requisition Sheet BatchEnable":=true;
        "Requisition WorksheetEnable":=true;
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserMgt.GetRespCenterFilter end;
    trigger OnOpenPage()
    begin
        if not Rec.Get(Rec."Responsibility Center")then Rec.Insert;
    // if UserMgt.GetRespCenterFilter() <> '' then begin
    //     Rec.FilterGroup(2);
    //     Rec.SetRange("Responsibility Center", UserMgt.GetRespCenterFilter);
    //     Rec.FilterGroup(0);
    // end;
    end;
    var ExisteImagen: Boolean;
    UserMgt: Codeunit "SSD User Setup Management";
    "Requisition WorksheetEnable": Boolean;
    "Requisition Sheet BatchEnable": Boolean;
    local procedure ResupplyinOrderOnAfterValidate()
    begin
        CurrPage.Update(true);
    end;
}
