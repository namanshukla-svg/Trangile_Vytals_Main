Page 50031 "Sales Order Schedule"
{
    // CF001.02 18.01.2006 For showing Posted Invoice lines
    // EXIM 26.02.2006 Filter on Tableview
    // //CF001.03 12.06.2006 For Closing Of Schedule
    // CE_AA007.09  Ankit Agarwal 17.09.07  Validate Structure and Update Flag "Structure Calculated"
    //                                      after calculation.
    Caption = 'Sales Order Schedule';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = where("Document Type"=filter(Order), "Document Subtype"=const(Schedule));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec)then CurrPage.Update;
                    end;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SelltoCustomerNoOnAfterValidat;
                    end;
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
            part(SalesLines; "Sales Order Subform Sch.")
            {
                SubPageLink = "Document No."=field("No.");
                ApplicationArea = All;
            }
            group(CustInfoPanel)
            {
                Caption = 'Customer Information';

                label(Control217)
                {
                    ApplicationArea = All;
                    CaptionClass = Text19070588;
                }
                label(Control218)
                {
                    ApplicationArea = All;
                    CaptionClass = Text19069283;
                }
                label(Control215)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                Editable = false;

                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        BilltoCustomerNoOnAfterValidat;
                    end;
                }
                field("Bill-to Contact No."; Rec."Bill-to Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Address"; Rec."Bill-to Address")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Address 2"; Rec."Bill-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    ApplicationArea = All;
                    Caption = 'Bill-to Post Code/City';
                }
                field("Bill-to City"; Rec."Bill-to City")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = All;
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    ApplicationArea = All;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field(Insurance; Rec.Insurance)
                {
                    ApplicationArea = All;
                }
                field(Freight; Rec.Freight)
                {
                    ApplicationArea = All;
                }
                field("PF Charges"; Rec."PF Charges")
                {
                    ApplicationArea = All;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                Editable = false;

                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to Post Code/City';
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("Promised Delivery Date"; Rec."Promised Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Outbound Whse. Handling Time"; Rec."Outbound Whse. Handling Time")
                {
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Time"; Rec."Shipping Time")
                {
                    ApplicationArea = All;
                }
                field("Late Order Shipping"; Rec."Late Order Shipping")
                {
                    ApplicationArea = All;
                }
                field("Package Tracking No."; Rec."Package Tracking No.")
                {
                    ApplicationArea = All;
                }
                field("Shipping Advice"; Rec."Shipping Advice")
                {
                    ApplicationArea = All;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                Editable = false;

                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date");
                        if ChangeExchangeRate.RunModal = Action::OK then begin
                            Rec.Validate("Currency Factor", ChangeExchangeRate.GetParameter);
                            CurrPage.Update;
                        end;
                        Clear(ChangeExchangeRate);
                    end;
                }
                field("EU 3-Party Trade"; Rec."EU 3-Party Trade")
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ApplicationArea = All;
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = All;
                }
                field("Exit Point"; Rec."Exit Point")
                {
                    ApplicationArea = All;
                }
                field("Area"; Rec.Area)
                {
                    ApplicationArea = All;
                }
            }
            group("E - Commerce")
            {
                Caption = 'E - Commerce';
                Editable = false;

                label(Control70)
                {
                    ApplicationArea = All;
                    CaptionClass = Text19007218;
                }
                field("Effective Date"; Rec."Effective Date")
                {
                    ApplicationArea = All;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = All;
                }
                label(Control188)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                label(Control184)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                label(Control180)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                label(Control190)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                label(Control186)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                label(Control182)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Customer Order No."; Rec."Customer Order No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                Caption = 'O&rder';

                action(Statistics)
                {
                    ApplicationArea = All;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';
                }
                action(Card)
                {
                    ApplicationArea = All;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Customer Card";
                    RunPageLink = "No."=field("Sell-to Customer No.");
                    ShortCutKey = 'Shift+F7';
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type"=field("Document Type"), "No."=field("No.");
                }
                action("S&hipments")
                {
                    ApplicationArea = All;
                    Caption = 'S&hipments';
                    RunObject = Page "Posted Sales Shipments";
                    RunPageLink = "Order No."=field("No.");
                    RunPageView = sorting("Order No.");
                }
                action(Invoices)
                {
                    ApplicationArea = All;
                    Caption = 'Invoices';
                    Image = Invoice;

                    trigger OnAction()
                    var
                        FrmPostedSalesInvoice: Page "Posted Sales Invoices";
                        SalesInvHeaderLocal: Record "Sales Invoice Header";
                        SalesInvLinelLocal: Record "Sales Invoice Line";
                        SalesInvHeaderTmp: Record "Sales Invoice Header" temporary;
                    begin
                        //CF002 St
                        Clear(FrmPostedSalesInvoice);
                        SalesInvHeaderLocal.Reset;
                        SalesInvLinelLocal.Reset;
                        SalesInvLinelLocal.SetCurrentkey("Sell-to Customer No.", "Order No.");
                        SalesInvLinelLocal.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");
                        SalesInvLinelLocal.SetRange("Order No.", Rec."No.");
                        if SalesInvLinelLocal.Find('-')then repeat SalesInvHeaderLocal.Get(SalesInvLinelLocal."Document No.");
                                SalesInvHeaderLocal.Mark(true);
                            until SalesInvLinelLocal.Next = 0;
                        SalesInvHeaderTmp.Reset;
                        SalesInvHeaderTmp.SetCurrentkey("Order No.");
                        SalesInvHeaderTmp.SetRange("Order No.", Rec."No.");
                        if SalesInvHeaderTmp.Find('-')then repeat SalesInvHeaderLocal.Get(SalesInvHeaderTmp."No.");
                                SalesInvHeaderLocal.Mark(true);
                            until SalesInvHeaderTmp.Next = 0;
                        SalesInvHeaderLocal.MarkedOnly(true);
                        FrmPostedSalesInvoice.SetTableview(SalesInvHeaderLocal);
                        FrmPostedSalesInvoice.RunModal;
                    //CF002 En
                    end;
                }
                action(Dimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    Image = Dimensions;

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                    end;
                }
                separator(Action173)
                {
                }
                action("Whse. Shipment Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Whse. Shipment Lines';
                    RunObject = Page "Whse. Shipment Lines";
                    RunPageLink = "Source Type"=const(37), "Source Subtype"=field("Document Type"), "Source No."=field("No.");
                    RunPageView = sorting("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                    Visible = false;
                }
                action("In&vt. Put-away/Pick Lines")
                {
                    ApplicationArea = All;
                    Caption = 'In&vt. Put-away/Pick Lines';
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document"=const("Sales Order"), "Source No."=field("No.");
                    RunPageView = sorting("Source Document", "Source No.", "Location Code");
                    Visible = false;
                }
                separator(Action120)
                {
                }
                action("Pla&nning")
                {
                    ApplicationArea = All;
                    Caption = 'Pla&nning';
                    Visible = false;

                    trigger OnAction()
                    var
                        SalesPlanForm: Page "Sales Order Planning";
                    begin
                        SalesPlanForm.SetSalesOrder(Rec."No.");
                        SalesPlanForm.RunModal;
                    end;
                }
                action("Order &Promising")
                {
                    ApplicationArea = All;
                    Caption = 'Order &Promising';
                    Visible = false;

                    trigger OnAction()
                    var
                        OrderPromisingLine: Record "Order Promising Line" temporary;
                    begin
                        OrderPromisingLine.SetRange("Source Type", Rec."Document Type");
                        OrderPromisingLine.SetRange("Source ID", Rec."No.");
                        Page.RunModal(Page::"Order Promising Lines", OrderPromisingLine);
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';

                separator(Action172)
                {
                }
                action("Get St&d. Cust. Sales Codes")
                {
                    ApplicationArea = All;
                    Caption = 'Get St&d. Cust. Sales Codes';
                    Ellipsis = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        StdCustSalesCode: Record "Standard Customer Sales Code";
                    begin
                        StdCustSalesCode.InsertSalesLines(Rec);
                    end;
                }
                separator(Action171)
                {
                }
                action("Nonstoc&k Items")
                {
                    ApplicationArea = All;
                    Caption = 'Nonstoc&k Items';

                    trigger OnAction()
                    begin
                        if not UpdateAllowed then exit;
                        CurrPage.SalesLines.Page.ShowNonstockItems;
                    end;
                }
                separator(Action192)
                {
                }
                action("Copy Document")
                {
                    ApplicationArea = All;
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    Visible = false;

                    trigger OnAction()
                    begin
                        CopySalesDoc.SetSalesHeader(Rec);
                        CopySalesDoc.RunModal;
                        Clear(CopySalesDoc);
                    end;
                }
                action("Archi&ve Document")
                {
                    ApplicationArea = All;
                    Caption = 'Archi&ve Document';

                    trigger OnAction()
                    var
                        SalesLineLocal: Record "Sales Line";
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        SalesLineLocal.Reset;
                        SalesLineLocal.SetRange("Document Type", Rec."Document Type");
                        SalesLineLocal.SetRange("Document No.", Rec."No.");
                        SalesLineLocal.SetRange("Change After Archieve", true);
                        if SalesLineLocal.Find('-')then begin
                            ArchiveManagement.ArchiveSalesDocument(Rec);
                        end;
                        ReleaseSalesDoc.Reopen(Rec);
                        Commit;
                        CurrPage.SalesLines.Page.AmendmentProcess;
                        CurrPage.Update(false);
                    end;
                }
                action("Move Negative Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Move Negative Lines';
                    Ellipsis = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Clear(MoveNegSalesLines);
                        MoveNegSalesLines.SetSalesHeader(Rec);
                        MoveNegSalesLines.RunModal;
                        MoveNegSalesLines.ShowDocument;
                    end;
                }
                separator(Action195)
                {
                }
                action("Create &Whse. Shipment")
                {
                    ApplicationArea = All;
                    Caption = 'Create &Whse. Shipment';
                    Visible = false;

                    trigger OnAction()
                    var
                        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                    begin
                        GetSourceDocOutbound.CreateFromSalesOrder(Rec);
                    end;
                }
                action("Create Inventor&y Put-away / Pick")
                {
                    ApplicationArea = All;
                    Caption = 'Create Inventor&y Put-away / Pick';
                    Ellipsis = true;
                    Image = CreateInventoryPickup;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.CreateInvtPutAwayPick;
                    end;
                }
                separator(Action174)
                {
                }
                action("Send A&pproval Request")
                {
                    ApplicationArea = All;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                        "Release Sales Document": Codeunit "Release Sales Document";
                    begin
                    //IF ApprovalMgt.SendSalesApprovalRequest(Rec) THEN;  ALLE_UPG
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    ApplicationArea = All;
                    Caption = 'Cancel Approval Re&quest';

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                        "Release Sales Document": Codeunit "Release Sales Document";
                    begin
                    //IF ApprovalMgt.CancelSalesApprovalRequest(Rec,TRUE,TRUE) THEN; ALLE_UPG
                    end;
                }
                separator(Action1000000061)
                {
                }
                action("Re&lease")
                {
                    ApplicationArea = All;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    RunObject = Codeunit "Release Sales Document";
                    ShortCutKey = 'Ctrl+F9';
                }
                action("Re&open")
                {
                    ApplicationArea = All;
                    Caption = 'Re&open';
                    Image = ReOpen;

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.Reopen(Rec);
                    end;
                }
                separator(Action175)
                {
                }
                action("&Send BizTalk Sales Order Cnfmn.")
                {
                    ApplicationArea = All;
                    Caption = '&Send BizTalk Sales Order Cnfmn.';

                    trigger OnAction()
                    begin
                    //BizTalkManagement.SendSalesOrderConf(Rec); // BIS 1145
                    end;
                }
                action("Send IC Sales Order Cnfmn.")
                {
                    ApplicationArea = All;
                    Caption = 'Send IC Sales Order Cnfmn.';

                    trigger OnAction()
                    var
                        ICInOutboxMgt: Codeunit ICInboxOutboxMgt;
                    begin
                        ICInOutboxMgt.SendSalesDoc(Rec, false);
                    end;
                }
                separator(Action1280000)
                {
                }
                separator(Action1280005)
                {
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';

                action("Test Report")
                {
                    ApplicationArea = All;
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action("P&ost")
                {
                    ApplicationArea = All;
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit "Sales-Post (Yes/No)";
                    ShortCutKey = 'F9';
                    Visible = false;
                }
                action("Post and &Print")
                {
                    ApplicationArea = All;
                    Caption = 'Post and &Print';
                    Ellipsis = true;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit "Sales-Post + Print";
                    ShortCutKey = 'Shift+F9';
                    Visible = false;
                }
                action("Post &Batch")
                {
                    ApplicationArea = All;
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Report.RunModal(Report::"Batch Post Sales Orders", true, true, Rec);
                        CurrPage.Update(false);
                    end;
                }
            }
            action("&Print")
            {
                ApplicationArea = All;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    DocPrint.PrintSalesHeader(Rec);
                end;
            }
            action(SalesHistoryBtn)
            {
                ApplicationArea = All;
                Caption = 'Sales H&istory';
                Promoted = true;
                PromotedCategory = Process;
                Visible = SalesHistoryBtnVisible;

                trigger OnAction()
                begin
                //SalesInfoPaneMgt.LookupCustSalesHistory(Rec,"Bill-to Customer No.",TRUE); // BIS 1145
                end;
            }
            action(SalesHistoryStn)
            {
                ApplicationArea = All;
                Caption = 'Sales Histor&y';
                Promoted = true;
                PromotedCategory = Process;
                Visible = SalesHistoryStnVisible;

                trigger OnAction()
                begin
                // SalesInfoPaneMgt.LookupCustSalesHistory(Rec,"Sell-to Customer No.",TRUE); // BIS 1145
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;
    end;
    trigger OnDeleteRecord(): Boolean begin
        CurrPage.SaveRecord;
        exit(Rec.ConfirmDeletion);
    end;
    trigger OnInit()
    begin
        SalesHistoryStnVisible:=true;
        BillToCommentBtnVisible:=true;
        BillToCommentPictVisible:=true;
        SalesHistoryBtnVisible:=true;
    end;
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean begin
        Rec.CheckCreditMaxBeforeInsert;
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center":=UserMgt.GetSalesFilter();
        OnAfterGetCurrRecord;
    end;
    trigger OnOpenPage()
    begin
        if UserMgt.GetSalesFilter() <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Responsibility Center", UserMgt.GetSalesFilter());
            Rec.FilterGroup(0);
        end;
        Rec.SetRange("Date Filter", 0D, WorkDate - 1);
    end;
    var Text000: label 'Unable to execute this function while in view only mode.';
    CopySalesDoc: Report "Copy Sales Document";
    MoveNegSalesLines: Report "Move Negative Sales Lines";
    ReportPrint: Codeunit "Test Report-Print";
    DocPrint: Codeunit "Document-Print";
    ArchiveManagement: Codeunit ArchiveManagement;
    SalesInfoPaneMgt: Codeunit "Sales Info-Pane Management";
    SalesSetup: Record "Sales & Receivables Setup";
    ChangeExchangeRate: Page "Change Exchange Rate";
    UserMgt: Codeunit "User Setup Management";
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
        if CurrPage.Editable = false then Error(Text000);
        exit(true);
    end;
    local procedure SelltoCustomerNoOnAfterValidat()
    begin
        CurrPage.Update;
    end;
    local procedure BilltoCustomerNoOnAfterValidat()
    begin
        CurrPage.Update;
    end;
    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.SalesLines.Page.UpdateForm(true);
    end;
    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.SalesLines.Page.UpdateForm(true);
    end;
    local procedure OnAfterGetCurrRecord()
    begin
        xRec:=Rec;
        Rec.SetRange("Date Filter", 0D, WorkDate - 1);
    end;
}
