Page 50264 "Sales Despatch Order List"
{
    ApplicationArea = All;
    Caption = 'Sales Despatch Slip';
    CardPageID = "Sales Despatch Order";
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = where("Document Type"=filter(Order), "Document Subtype"=const(Despatch));
    UsageCategory = Tasks;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Contact No."; Rec."Sell-to Contact No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Address 2"; Rec."Sell-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    ApplicationArea = All;
                    Caption = 'Sell-to Post Code/City';
                    Editable = false;
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Ref. Doc. Subtype"; Rec."Ref. Doc. Subtype")
                {
                    ApplicationArea = All;
                    Caption = 'Ref. Doc. Type';
                }
                field("Order/Scd. No."; Rec."Order/Scd. No.")
                {
                    ApplicationArea = All;
                    Caption = 'Ref. Doc. No.';
                    Editable = false;

                    trigger OnLookup(var Text: Text): Boolean var
                        SalesHeaderLocal: Record "Sales Header";
                        SalesLineLocal: Record "Sales Line";
                    begin
                    end;
                }
                field(Subcontracting; Rec.Subcontracting)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                    Caption = 'Despatch Date';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'Customer Order No.';
                    Editable = false;
                }
                field("External Doc. Date"; Rec."External Doc. Date")
                {
                    ApplicationArea = All;
                    Caption = 'Customer Order Date';
                    Editable = false;
                }
                field("Total Packed Wt."; Rec."Total Packed Wt.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(creation)
        {
            action("Dispatch Slip")
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    PostExportCommercialInvoice: Report "Export Packing Slip";
                    SalesHeader: Record "Sales Header";
                begin
                    SalesHeader.Reset;
                    SalesHeader.SetRange("No.", Rec."No.");
                    if SalesHeader.FindFirst then begin
                        PostExportCommercialInvoice.SetTableview(SalesHeader);
                        PostExportCommercialInvoice.Run;
                    end;
                end;
            }
        }
    }
    trigger OnDeleteRecord(): Boolean var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."SSD Delete Administrator" then Error('You are not authorise to delete this record');
    end;
    var CopySalesDoc: Report "Copy Sales Document";
    MoveNegSalesLines: Report "Move Negative Sales Lines";
    ReportPrint: Codeunit "Test Report-Print";
    DocPrint: Codeunit "Document-Print";
    ArchiveManagement: Codeunit ArchiveManagement;
    SalesInfoPaneMgt: Codeunit "Sales Info-Pane Management";
    SalesSetup: Record "Sales & Receivables Setup";
    ChangeExchangeRate: Page "Change Exchange Rate";
    UserMgt: Codeunit "SSD User Setup Management";
    "--NAVIN": Integer;
    SalesLine: Record "Sales Line";
    MLTransactionType: Option Purchase, Sale;
    ReleaseSale: Codeunit "Release Sales Document";
    SalesBuffer: Record "SSD Sales Schedule Buffer";
    SLineRec: Record "Sales Line";
    ILE: Record "Item Ledger Entry";
    AvailQty: Decimal;
    ItemRec: Record Item;
    ItemUOM: Record "Item Unit of Measure";
    SalesLine2: Record "Sales Line";
    SalesOrderQty: Decimal;
    DispLineQty: Decimal;
    "DI No.Editable": Boolean;
    "DI DateEditable": Boolean;
    SalesHistoryBtnVisible: Boolean;
    BillToCommentPictVisible: Boolean;
    BillToCommentBtnVisible: Boolean;
    SalesHistoryStnVisible: Boolean;
}
