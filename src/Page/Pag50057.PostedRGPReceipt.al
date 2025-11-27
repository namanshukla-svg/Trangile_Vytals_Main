Page 50057 "Posted RGP Receipt"
{
    // CML-024 ALLEAG 180208 :
    //   - Function Navigate called in OnPush() trigger of Navigate button.
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "SSD RGP Receipt Header";
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
                }
                field("Party Type"; Rec."Party Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if Rec."Party No." <> '' then begin
                            if Confirm('Do you want to change Party Type')then begin
                                Rec."Party No.":='';
                                Rec."Party Name":='';
                                Rec."Party Address":='';
                                Rec."Party Address 2":='';
                                Rec."Party City":='';
                                Rec."Party PostCode":='';
                                Rec."Party State":='';
                                Rec."Party Country":='';
                            end
                            else
                                Rec."Party Type":=xRec."Party Type";
                        end;
                    end;
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
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec."Document Date":=Rec."Posting Date";
                    end;
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
                    Editable = false;
                }
            }
            part(RGPRcptLines; "Posted RGP Receipt Subform")
            {
                SubPageLink = "Document No."=field("No.");
                ApplicationArea = All;
            }
            group(Shipment)
            {
                Caption = 'Shipment';
                Editable = false;

                field("Advising Employee"; Rec."Advising Employee")
                {
                    ApplicationArea = All;
                }
                field("Advising Department"; Rec."Advising Department")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
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
            }
            group(Receipt)
            {
                Caption = 'Receipt';
                Editable = false;

                field("Receipt Date"; Rec."Receipt Date")
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
            group("&Receipt")
            {
                Caption = '&Receipt';

                action("Ledger Entries2")
                {
                    ApplicationArea = All;
                    Caption = 'Ledger Entries';
                    RunObject = Page "RGP Ledger Entries";
                    RunPageLink = "Document Type"=field("Document Type"), "Document No."=field("No.");
                    RunPageView = sorting("Document Type", "Document No.")order(ascending);
                }
                action(RGP)
                {
                    ApplicationArea = All;
                    Caption = 'RGP';
                    RunObject = Page "RGP List";
                    RunPageLink = "No."=field("Pre-Assigned No.");
                }
            }
            group("&Line")
            {
                action("Ledger Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Ledger Entries';

                    trigger OnAction()
                    begin
                        ShowRGPLedger();
                    end;
                }
            }
        }
        area(processing)
        {
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
                    //REPORT.RUN(REPORT::"Posted RGP",TRUE,FALSE,Rec);
                    Rec.SetRecfilter;
                    //REPORT.RUN(REPORT::"Returnable Gate Pass",TRUE,FALSE,Rec);
                    Report.Run(Report::"Gate Pass RGP Receipt", true, false, Rec);
                    Rec.Reset;
                end;
            }
            action("Na&vigate")
            {
                ApplicationArea = All;
                Caption = 'Na&vigate';
                Ellipsis = true;
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                Visible = NavigateVisible;

                trigger OnAction()
                begin
                    Rec.Navigate(); //CML-024 ALLEAG 180208
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec."Document Date":=WorkDate;
        if Rec."Delivery Mode" = Rec."delivery mode"::"Own Vehical" then begin
            "Vehical No.Editable":=true;
            "Transporter No.Editable":=false;
            "Transporter NameEditable":=false;
            "LR No.Editable":=false;
            "GR No.Editable":=false;
        end;
        if Rec."Delivery Mode" = Rec."delivery mode"::Transporter then begin
            "Vehical No.Editable":=false;
            "Transporter No.Editable":=true;
            "Transporter NameEditable":=true;
            "LR No.Editable":=true;
            "GR No.Editable":=true;
        end;
        if Rec."Delivery Mode" = Rec."delivery mode"::"By Hand Party" then begin
            "Vehical No.Editable":=false;
            "Transporter No.Editable":=false;
            "Transporter NameEditable":=false;
            "LR No.Editable":=false;
            "GR No.Editable":=false;
        end;
    end;
    trigger OnInit()
    begin
        "GR No.Editable":=true;
        "LR No.Editable":=true;
        "Transporter NameEditable":=true;
        "Transporter No.Editable":=true;
        "Vehical No.Editable":=true;
    end;
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        //CF001 St
        // if UserMgt.GetRespCenterFilter <> '' then begin
        //     Rec.FilterGroup(2);
        //     Rec.SetRange("Responsibility Center", UserMgt.GetRespCenterFilter);
        //     Rec.FilterGroup(0);
        // end;
        //CF001 En
        // >> ALLE NA.DP1.00
        UserSetup.Get(UserId);
        NavigateVisible:=UserSetup."Navigate Visible";
    //IF NOT UserSetup."Drilldown Permission" THEN
    //ERROR('You dont have permission to open this page');
    // << ALLE NA.DP1.00
    end;
    var RGPShipPost: Report "RGP Post";
    UserMgt: Codeunit "SSD User Setup Management";
    "Vehical No.Editable": Boolean;
    "Transporter No.Editable": Boolean;
    "Transporter NameEditable": Boolean;
    "LR No.Editable": Boolean;
    "GR No.Editable": Boolean;
    NavigateVisible: Boolean;
    procedure ShowRGPLedger()
    begin
        CurrPage.RGPRcptLines.Page.ShowRGPLedger;
    end;
    local procedure DeliveryModeOnAfterValidate()
    begin
        if Rec."Delivery Mode" = Rec."delivery mode"::"Own Vehical" then begin
            "Vehical No.Editable":=true;
            "Transporter No.Editable":=false;
            "Transporter NameEditable":=false;
            "LR No.Editable":=false;
            "GR No.Editable":=false;
        end;
        if Rec."Delivery Mode" = Rec."delivery mode"::Transporter then begin
            "Vehical No.Editable":=false;
            "Transporter No.Editable":=true;
            "Transporter NameEditable":=true;
            "LR No.Editable":=true;
            "GR No.Editable":=true;
        end;
        if Rec."Delivery Mode" = Rec."delivery mode"::"By Hand Party" then begin
            "Vehical No.Editable":=false;
            "Transporter No.Editable":=false;
            "Transporter NameEditable":=false;
            "LR No.Editable":=false;
            "GR No.Editable":=false;
        end;
    end;
}
