Page 50250 "RGP outbound List"
{
    // CF001 08.01.2005 Responsibility Center
    ApplicationArea = All;
    CardPageID = "RGP outbound";
    //DeleteAllowed = false;
    Editable = false;
    ModifyAllowed = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "SSD RGP Header";
    SourceTableView = sorting(NRGP)order(ascending)where(NRGP=const(false), "Document Type"=filter("RGP Outbound"), "Document SubType"=const(" "));
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
                field("Party PostCode"; Rec."Party PostCode")
                {
                    ApplicationArea = All;
                    Caption = 'Party PostCode / City';
                }
                field("Party City"; Rec."Party City")
                {
                    ApplicationArea = All;
                }
                field("Party State"; Rec."Party State")
                {
                    ApplicationArea = All;
                }
                field(Remark2; Rec.Remark2)
                {
                    ApplicationArea = All;
                    Caption = 'Note';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
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
                field("Purpose Code"; Rec."Purpose Code")
                {
                    ApplicationArea = All;
                }
                field("Purpose Description"; Rec."Purpose Description")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Receipt Remarks"; Rec."Receipt Remarks")
                {
                    ApplicationArea = All;
                    Caption = 'Period';
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Advising Employee"; Rec."Advising Employee")
                {
                    ApplicationArea = All;
                }
                field("Advising Department"; Rec."Advising Department")
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
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                }
                field("Delivery Mode"; Rec."Delivery Mode")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        DeliveryModeOnAfterValidate;
                    end;
                }
                field("Vehical No."; Rec."Vehical No.")
                {
                    ApplicationArea = All;
                    Editable = "Vehical No.Editable";
                }
                field("Transporter No."; Rec."Transporter No.")
                {
                    ApplicationArea = All;
                    Editable = "Transporter No.Editable";
                }
                field("Transporter Name"; Rec."Transporter Name")
                {
                    ApplicationArea = All;
                    Editable = "Transporter NameEditable";
                }
                field("LR No."; Rec."LR No.")
                {
                    ApplicationArea = All;
                    Editable = "LR No.Editable";
                }
                field("GR No."; Rec."GR No.")
                {
                    ApplicationArea = All;
                    Editable = "GR No.Editable";
                }
                field("Posted Shpmt. No Series"; Rec."Posted Shpmt. No Series")
                {
                    ApplicationArea = All;
                }
                field("Posted Rect. No Series"; Rec."Posted Rect. No Series")
                {
                    ApplicationArea = All;
                }
                field("Send to Approval"; Rec."Send to Approval")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Approved; Rec.Approved)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sender ID"; Rec."Sender ID")
                {
                    ApplicationArea = All;
                    Editable = false;
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

                separator(Action1000000022)
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
                        Rec.TestField("Shortcut Dimension 1 Code");
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
                        Rec.Reopen;
                    end;
                }
                action(SendApprovalRequest)
                {
                    ApplicationArea = All;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = New;

                    trigger OnAction()
                    begin
                        if UserSetup1.Get(UserId)then if UserSetup1."RGP Send For Approval" then begin
                                CurrPage.SetSelectionFilter(RGPHeader);
                                if RGPHeader.FindSet then begin
                                    RGPHeader.ModifyAll("Send to Approval", true);
                                    RGPHeader.ModifyAll("Sender ID", UserId);
                                end;
                            end
                            else
                                Error('You are not authorised for sending approval');
                        Clear(RGPHeader);
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
                        if Rec.Approved then begin
                            Clear(RGPShipPost);
                            RGPShipPost.PostRGP(Rec);
                        end
                        else
                            Error('Please Approve RGP before posting');
                    end;
                }
            }
            action(Print)
            {
                ApplicationArea = All;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    Rec.SetRecfilter;
                    //REPORT.RUN(REPORT::"Returnable Gate Pass",TRUE,FALSE,Rec);
                    Report.Run(Report::"Gate Pass RGP", true, false, Rec);
                    Rec.Reset;
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        case Rec."Delivery Mode" of Rec."delivery mode"::"Own Vehical": begin
            "Vehical No.Editable":=true;
            "Transporter No.Editable":=false;
            "Transporter NameEditable":=false;
            "LR No.Editable":=false;
            "GR No.Editable":=false;
        end;
        Rec."delivery mode"::Transporter: begin
            "Vehical No.Editable":=false;
            "Transporter No.Editable":=true;
            "Transporter NameEditable":=true;
            "LR No.Editable":=true;
            "GR No.Editable":=true;
        end;
        Rec."delivery mode"::"By Hand Party": begin
            "Vehical No.Editable":=false;
            "Transporter No.Editable":=false;
            "Transporter NameEditable":=false;
            "LR No.Editable":=false;
            "GR No.Editable":=false;
        end;
        end;
        Rec.SetRange("No.");
    end;
    trigger OnInit()
    begin
        "GR No.Editable":=true;
        "LR No.Editable":=true;
        "Transporter NameEditable":=true;
        "Transporter No.Editable":=true;
        "Vehical No.Editable":=true;
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //CF001 St
        Rec."Responsibility Center":=UserMgt.GetRespCenterFilter;
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
    trigger OnDeleteRecord(): Boolean var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."SSD Delete Administrator" then Error('You are not authorise to delete this record');
    end;
    var RGPShipPost: Report "RGP Post";
    UserSetup: Record "User Setup";
    UserMgt: Codeunit "SSD User Setup Management";
    "Vehical No.Editable": Boolean;
    "Transporter No.Editable": Boolean;
    "Transporter NameEditable": Boolean;
    "LR No.Editable": Boolean;
    "GR No.Editable": Boolean;
    UserSetup1: Record "User Setup";
    RGPHeader: Record "SSD RGP Header";
    procedure LineWriteOff()
    begin
    end;
    procedure ShowRGPLedger()
    begin
    end;
    local procedure DeliveryModeOnAfterValidate()
    begin
        case Rec."Delivery Mode" of Rec."delivery mode"::"Own Vehical": begin
            "Vehical No.Editable":=true;
            "Transporter No.Editable":=false;
            "Transporter NameEditable":=false;
            "LR No.Editable":=false;
            "GR No.Editable":=false;
        end;
        Rec."delivery mode"::Transporter: begin
            "Vehical No.Editable":=false;
            "Transporter No.Editable":=true;
            "Transporter NameEditable":=true;
            "LR No.Editable":=true;
            "GR No.Editable":=true;
        end;
        Rec."delivery mode"::"By Hand Party": begin
            "Vehical No.Editable":=false;
            "Transporter No.Editable":=false;
            "Transporter NameEditable":=false;
            "LR No.Editable":=false;
            "GR No.Editable":=false;
        end;
        end;
    end;
}
