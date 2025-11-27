Page 50055 "Posted RGP Shipment"
{
    // CML-024 ALLEAG 180208 :
    //   - Function Navigate called in OnPush() trigger of Navigate button.
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "SSD RGP Shipment Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Party Type"; Rec."Party Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;

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
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Party Name"; Rec."Party Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Party Address"; Rec."Party Address")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Party Address 2"; Rec."Party Address 2")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Party PostCode"; Rec."Party PostCode")
                {
                    ApplicationArea = Basic;
                    Caption = 'Party PostCode / City';
                    Editable = false;
                }
                field("Party City"; Rec."Party City")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Party State"; Rec."Party State")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Pre-Assigned No."; Rec."Pre-Assigned No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        Rec."Document Date":=Rec."Posting Date";
                    end;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Purpose Code"; Rec."Purpose Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Purpose Description"; Rec."Purpose Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Firm Freight"; Rec."Firm Freight")
                {
                    ApplicationArea = Basic;
                }
                field("Freight Amount"; Rec."Freight Amount")
                {
                    ApplicationArea = Basic;
                }
            }
            part(RGPShptLine; "Posted RGP Shipment Subform")
            {
                SubPageLink = "Document No."=field("No.");
                ApplicationArea = All;
            }
            group(Shipment)
            {
                Caption = 'Shipment';

                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Advising Employee"; Rec."Advising Employee")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Advising Department"; Rec."Advising Department")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Bearer Name"; Rec."Bearer Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Bearer Department"; Rec."Bearer Department")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Delivery Mode"; Rec."Delivery Mode")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        DeliveryModeOnAfterValidate;
                    end;
                }
                field("Vehical No."; Rec."Vehical No.")
                {
                    ApplicationArea = Basic;
                    Editable = "Vehical No.Editable";
                }
                field("Transporter No."; Rec."Transporter No.")
                {
                    ApplicationArea = Basic;
                    Editable = "Transporter No.Editable";
                }
                field("Transporter Name"; Rec."Transporter Name")
                {
                    ApplicationArea = Basic;
                    Editable = "Transporter NameEditable";
                }
                field("LR No."; Rec."LR No.")
                {
                    ApplicationArea = Basic;
                    Editable = "LR No.Editable";
                }
                field("GR No."; Rec."GR No.")
                {
                    ApplicationArea = Basic;
                    Editable = "GR No.Editable";
                }
            }
            group(Receipt)
            {
                Caption = 'Receipt';

                field("Receipt Date"; Rec."Receipt Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("&Shipment")
            {
                Caption = '&Shipment';

                action("LedgerEntries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ledger Entries';
                    RunObject = Page "RGP Ledger Entries";
                    RunPageLink = "Document Type"=field("Document Type"), "Document No."=field("No.");
                    RunPageView = sorting("Document Type", "Document No.")order(ascending);
                }
                action(RGP)
                {
                    ApplicationArea = Basic;
                    Caption = 'RGP';
                    RunObject = Page "RGP List";
                    RunPageLink = "No."=field("Pre-Assigned No.");
                }
            }
            group("&Line")
            {
                action("Ledger Entries")
                {
                    ApplicationArea = Basic;
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
                ApplicationArea = Basic;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    CompanyInformation: Record "Company Information";
                begin
                    RGPShipmentHeader.Copy(Rec);
                    RGPShipmentHeader.SetRecfilter;
                    if CompanyInformation.Get()then begin
                        if CompanyInformation.Name = 'VYTALS WELLBEING INDIA PRIVATE LIMITED' then Report.Run(Report::"Gate Pass RGP Shipment- Vytals", true, false, RGPShipmentHeader)
                        else
                            Report.Run(Report::"Gate Pass RGP Shipment", true, false, RGPShipmentHeader);
                    end;
                end;
            }
            action("Na&vigate")
            {
                ApplicationArea = Basic;
                Caption = 'Na&vigate';
                Ellipsis = true;
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                Visible = NavigateVisible;

                trigger OnAction()
                begin
                    Rec.Navigate; //CML-024 ALLEAG 180208
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
    RGPShipmentHeader: Record "SSD RGP Shipment Header";
    "Vehical No.Editable": Boolean;
    "Transporter No.Editable": Boolean;
    "Transporter NameEditable": Boolean;
    "LR No.Editable": Boolean;
    "GR No.Editable": Boolean;
    NavigateVisible: Boolean;
    procedure ShowRGPLedger()
    begin
        CurrPage.RGPShptLine.Page.ShowRGPLedger;
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
