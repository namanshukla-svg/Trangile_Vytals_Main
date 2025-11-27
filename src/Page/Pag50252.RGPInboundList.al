Page 50252 "RGP Inbound List"
{
    // CEN004.06 Rename the subform.
    ApplicationArea = All;
    CardPageID = "RGP Inbound";
    PageType = Document;
    RefreshOnActivate = true;
    Editable = false;
    ModifyAllowed = false;
    InsertAllowed = false;
    SourceTable = "SSD RGP Header";
    SourceTableView = where("Document Type"=filter("RGP Inbound"));
    UsageCategory = Tasks;

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
                field("Party Type"; Rec."Party Type")
                {
                    ApplicationArea = All;
                }
                field("Party No."; Rec."Party No.")
                {
                    ApplicationArea = All;
                }
                field("Party Name"; Rec."Party Name")
                {
                    ApplicationArea = All;
                }
                field("Party Address"; Rec."Party Address")
                {
                    ApplicationArea = All;
                }
                field("Party Address 2"; Rec."Party Address 2")
                {
                    ApplicationArea = All;
                }
                field("Party City"; Rec."Party City")
                {
                    ApplicationArea = All;
                }
                field("Receipt Remarks"; Rec."Receipt Remarks")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Expected Shipment Date"; Rec."Expected Shipment Date")
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
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(NRGP; Rec.NRGP)
                {
                    ApplicationArea = All;
                }
                field("Purpose Code"; Rec."Purpose Code")
                {
                    ApplicationArea = All;
                }
                field("Purpose Description"; Rec."Purpose Description")
                {
                    ApplicationArea = All;
                }
                field("Advising Employee"; Rec."Advising Employee")
                {
                    ApplicationArea = All;
                }
                field("Ship Remarks"; Rec."Ship Remarks")
                {
                    ApplicationArea = All;
                }
                field("Bearer Name"; Rec."Bearer Name")
                {
                    ApplicationArea = All;
                }
                field("Bearer Department"; Rec."Bearer Department")
                {
                    ApplicationArea = All;
                }
                field("MRR No."; Rec."MRR No.")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Delivery Mode"; Rec."Delivery Mode")
                {
                    ApplicationArea = All;
                }
                field("Transporter No."; Rec."Transporter No.")
                {
                    ApplicationArea = All;
                }
                field("Transporter Name"; Rec."Transporter Name")
                {
                    ApplicationArea = All;
                }
                field("LR No."; Rec."LR No.")
                {
                    ApplicationArea = All;
                }
                field("GR No."; Rec."GR No.")
                {
                    ApplicationArea = All;
                }
                field("Party Shipment/Rect. No."; Rec."Party Shipment/Rect. No.")
                {
                    ApplicationArea = All;
                }
                field("Party Shipment/Rect. Date"; Rec."Party Shipment/Rect. Date")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
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
            group("&RGP Outbound")
            {
                Caption = '&RGP Outbound';

                action("LedgerEntries")
                {
                    ApplicationArea = All;
                    Caption = 'Ledger Entries';
                    RunObject = Page "RGP Ledger Entries";
                    RunPageLink = "Document Type"=field("Document Type"), "RGP Document No."=field("No.");
                    RunPageView = sorting("Document Type", "RGP Document No.", "RGP Line No.")order(ascending);
                }
                action(Shipments)
                {
                    ApplicationArea = All;
                    Caption = 'Shipments';
                    RunObject = Page "Posted RGP Shipment List";
                    RunPageLink = "Pre-Assigned No."=field("No.");
                }
                action(Receipts)
                {
                    ApplicationArea = All;
                    Caption = 'Receipts';
                    Image = PostedReceipts;
                    RunObject = Page "Posted Receipt List";
                    RunPageLink = "Pre-Assigned No."=field("No.");
                }
            }
            group("&Line")
            {
                Caption = '&Line';

                action("Ledger Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Ledger Entries';

                    trigger OnAction()
                    begin
                        ShowRGPLedger;
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';

                action("Write Off")
                {
                    ApplicationArea = All;
                    Caption = '&Write Off';

                    trigger OnAction()
                    begin
                        //CurrForm.SubRGPHeader.FORM.LineWriteOff;
                        //*********CEN004.06***********
                        RgpLine.Reset;
                        RgpLine.SetRange(RgpLine."Document Type", Rec."Document Type");
                        RgpLine.SetRange(RgpLine."Document No.", Rec."No.");
                        if RgpLine.Find('-')then repeat RgpLine."Write Off":=true;
                                RgpLine.Modify;
                            until RgpLine.Next = 0;
                    //*********CEN004.06***********
                    end;
                }
                action(CreateNRGP)
                {
                    ApplicationArea = All;
                    Caption = 'Create NRGP';
                }
                separator(Action1000000070)
                {
                }
                action("Re&lease")
                {
                    ApplicationArea = All;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    begin
                        Rec.Release;
                    end;
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
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';

                action("P&ost")
                {
                    ApplicationArea = All;
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        if Rec."Shortcut Dimension 1 Code" = '' then Error('Please Enter Plant Code');
                        Clear(RGPShipPost);
                        RGPShipPost.PostRGP(Rec);
                    end;
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //CF001 St
        Rec."Responsibility Center":=UserMgt.GetRespCenterFilter;
        Rec."Shortcut Dimension 1 Code":='11'; //ssd
    end;
    trigger OnOpenPage()
    begin
    //CF001 St
    // if UserMgt.GetRespCenterFilter <> '' then begin
    //     Rec.FilterGroup(2);
    //     Rec.SetRange("Responsibility Center", UserMgt.GetRespCenterFilter);
    //     Rec.FilterGroup(0);
    // end;
    //CF001 En
    end;
    var RGPShipPost: Report "RGP Post";
    UserSetup: Record "User Setup";
    UserMgt: Codeunit "SSD User Setup Management";
    RgpLine: Record "SSD RGP Line";
    Text000: label 'NRGP has already been created';
    procedure LineWriteOff()
    begin
    //Page.SubRGPHeader.PAGE.LineWriteOff;
    end;
    procedure ShowRGPLedger()
    begin
    //CurrForm.RGPLines.FORM.ShowRGPLedger;
    end;
    procedure PostLineDetail()
    begin
    end;
}
