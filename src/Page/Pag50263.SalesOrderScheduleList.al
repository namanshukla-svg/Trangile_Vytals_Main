Page 50263 "Sales Order Schedule List"
{
    ApplicationArea = All;
    Caption = 'Sales Order Schedule List';
    CardPageID = "Sales Order Schedule";
    DeleteAllowed = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = where("Document Type"=filter(Order), "Document Subtype"=const(Schedule));
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';
                Editable = false;

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
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                    ApplicationArea = All;
                }
                field("Schedule Month"; Rec."Schedule Month")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("Order/Scd. No."; Rec."Order/Scd. No.")
                {
                    ApplicationArea = All;
                    Caption = 'Blanket Order No.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                }
                field("External Doc. Date"; Rec."External Doc. Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No. of Archived Versions"; Rec."No. of Archived Versions")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    var Text000: label 'Unable to execute this function while in view only mode.';
    CopySalesDoc: Report "Copy Sales Document";
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
    Text001: label 'Do you sure to close the Schedule Order';
    SalesHistoryBtnVisible: Boolean;
    BillToCommentPictVisible: Boolean;
    BillToCommentBtnVisible: Boolean;
    SalesHistoryStnVisible: Boolean;
    Text19007218: label 'Commerce Portal';
    Text19070588: label 'Sell-to Customer';
    Text19069283: label 'Bill-to Customer';
    procedure UpdateAllowed(): Boolean begin
    end;
    local procedure UpdateInfoPanel()
    var
        DifferSellToBillTo: Boolean;
    begin
    end;
    local procedure SelltoCustomerNoOnAfterValidat()
    begin
    end;
    local procedure BilltoCustomerNoOnAfterValidat()
    begin
    end;
    local procedure ShortcutDimension1CodeOnAfterV()
    begin
    end;
    local procedure ShortcutDimension2CodeOnAfterV()
    begin
    end;
    local procedure OnAfterGetCurrRecord()
    begin
    end;
}
