Page 50044 "57F4 outbound Subform"
{
    // CML-024 ALLEAG 180208 :
    //   - "No." Field sifted before "No. 2" field.
    // ALLE 6.12.....57F4 Customisation
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "SSD RGP Line";
    SourceTableView = sorting(NRGP)order(ascending)where(NRGP=const(false), "Document Type"=filter("RGP Outbound"));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("No. 2"; Rec."No. 2")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit Of Measure Code"; Rec."Unit Of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                }
                field("Quantity to Ship"; Rec."Quantity to Ship")
                {
                    ApplicationArea = All;
                }
                field("Quantity Shipped"; Rec."Quantity Shipped")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Quantity to Receive"; Rec."Quantity to Receive")
                {
                    ApplicationArea = All;
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Party Type"; Rec."Party Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Party No."; Rec."Party No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("In-Transit Code"; Rec."In-Transit Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Ship Quantity"; Rec."Outstanding Ship Quantity")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Outstanding Rcpt. Quantity"; Rec."Outstanding Rcpt. Quantity")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Qty. to Write Off"; Rec."Qty. to Write Off")
                {
                    ApplicationArea = All;
                }
                field("Quantity Write Off"; Rec."Quantity Write Off")
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Completely Received"; Rec."Completely Received")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shipping Date"; Rec."Shipping Date")
                {
                    ApplicationArea = All;
                }
                field("Receipt Time"; Rec."Receipt Time")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
    actions
    {
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
                        //This functionality was copied from page #50043. Unsupported part was commented. Please check it.
                        /*CurrPage.RGPLines.PAGE.*/
                        LineWriteOff;
                    end;
                }
            }
            group("&Line")
            {
                Caption = '&Line';

                group("Item &Tracking Line")
                {
                    Caption = 'Item &Tracking Line';

                    action("&Shipment")
                    {
                        ApplicationArea = All;
                        Caption = '&Shipment';

                        trigger OnAction()
                        begin
                            //ALLE[551]
                            //This functionality was copied from page #50043. Unsupported part was commented. Please check it.
                            /*CurrPage.RGPLines.PAGE.*/
                            OpenItemTrackingLines2(0);
                        end;
                    }
                    action("&Receipt")
                    {
                        ApplicationArea = All;
                        Caption = '&Receipt';

                        trigger OnAction()
                        begin
                            //ALLE[551]
                            //This functionality was copied from page #50043. Unsupported part was commented. Please check it.
                            /*CurrPage.RGPLines.PAGE.*/
                            OpenItemTrackingLines2(1);
                        end;
                    }
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        UserSetup: Record "User Setup";
    begin
        Rec.Type:=xRec.Type;
        //MUA01 Starts
        if UserSetup.Get(UserId)then Rec."Responsibility Center":=UserSetup."Responsibility Center";
    //MUA01 Ends
    end;
    procedure LineWriteOff()
    var
        RGPLine: Record "SSD RGP Line";
    begin
        RGPLine.Copy(Rec);
        RGPLine.SetRange("Document Type", Rec."Document Type");
        RGPLine.SetRange("Document No.", Rec."Document No.");
        RGPLine.SetRange("Write Off", true);
        RGPLine.SetFilter("Qty. to Write Off", '<>%1', 0);
        Rec.PostWriteOff(RGPLine);
        Commit;
    end;
    procedure ShowRGPLedger()
    begin
        Rec.ShowLedgerEntries(Rec);
    end;
    procedure OpenItemTrackingLines2(Direction: Option Outbound, Inbound)
    begin
        //ALLE[551]
        if Direction = 0 then Rec.TestField("Quantity to Ship")
        else
            Rec.TestField("Quantity to Receive");
        Rec.OpenItemTrackingLines(Direction);
    end;
}
