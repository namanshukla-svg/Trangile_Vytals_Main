Page 50223 "Posted Requision Slip Form"
{
    Editable = false;
    PageType = Document;
    SourceTable = "SSD Posted Req. Slip Header";
    SourceTableView = where("Document Type"=filter("Material Issue"));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Req. Slip No."; Rec."Req. Slip No.")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Req. Date"; Rec."Req. Date")
                {
                    ApplicationArea = All;
                }
                field("Req. Time"; Rec."Req. Time")
                {
                    ApplicationArea = All;
                }
                field("Transfer-From Location"; Rec."Transfer-From Location")
                {
                    ApplicationArea = All;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ApplicationArea = All;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                }
                field("Source Description"; Rec."Source Description")
                {
                    ApplicationArea = All;
                }
            }
            part(Control1000000001; "Posted Requision Slip SubForm")
            {
                SubPageLink = "Req. Slip Document No."=field("Req. Slip No."), "Document Type"=field("Document Type");
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
        //SETRANGE("Document Type",DocumentTypeGlb);
        //SETRANGE(Departments,DepartmentValueGlb);
        //ALLE.RC.03 Start
        if UserMgt.GetSalesFilter() <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Responsibility Center", UserMgt.GetSalesFilter());
            Rec.FilterGroup(0);
        end;
    //ALLE.RC.03 Start
    end;
    var //SSDU GetMatReq: Report "PO Print";
    DocumentTypeGlb: Option " ", "Material Issue", "Material Return", "Line Rejection", "Floor Rejection", Offer, ReOffer;
    DepartmentValueGlb: Option " ", PPC, AWP, WIP, Conveyor, ED, Store;
    UserMgt: Codeunit "User Setup Management";
    procedure SetDefaultValues(DocumentType: Option " ", "Material Issue", "Material Return", "Line Rejection", "Floor Rejection", Offer, ReOffer; DepartmentValue: Option " ", PPC, AWP, WIP, Conveyor, ED, Store)
    var
        DocumentTypeLocal: Option " ", "Material Issue", "Material Return", "Line Rejection", "Floor Rejection", Offer, ReOffer;
        DepartmentValueLocal: Option " ", PPC, AWP, WIP, Conveyor, ED, Store;
    begin
        DocumentTypeGlb:=DocumentType;
        DepartmentValueGlb:=DepartmentValue;
    end;
}
