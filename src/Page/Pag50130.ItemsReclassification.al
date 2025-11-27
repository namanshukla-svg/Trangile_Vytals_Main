Page 50130 "Items Reclassification"
{
    Caption = 'Items Reclassification';
    DataCaptionFields = "Item No.";
    PageType = List;
    PopulateAllFields = true;
    SourceTable = "SSD Items Reclassification";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Reclass. Item No."; Rec."Reclass. Item No.")
                {
                    ApplicationArea = All;
                }
                field("Reclassif. Factor"; Rec."Reclassif. Factor")
                {
                    ApplicationArea = All;
                }
                field("Reclassified Item Name"; Rec."Reclassified Item Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center":=UserMgt.GetRespCenterFilter;
    end;
    trigger OnOpenPage()
    begin
    // if UserMgt.GetRespCenterFilter() <> '' then begin
    //     Rec.FilterGroup(2);
    //     Rec.SetRange("Responsibility Center", UserMgt.GetRespCenterFilter);
    //     Rec.FilterGroup(0);
    // end;
    end;
    var UserMgt: Codeunit "SSD User Setup Management";
}
