Page 50065 "NRGP outbound Subform"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "SSD RGP Line";
    SourceTableView = sorting(NRGP)order(ascending)where(NRGP=const(true), "Document Type"=filter("RGP Outbound"));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.NRGP:=true;
                    end;
                }
                field("No. 2"; Rec."No. 2")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
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
                field("Bin Code"; Rec."Bin Code")
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
                field("Quantity Shipped"; Rec."Quantity Shipped")
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
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Date"; Rec."Shipping Date")
                {
                    ApplicationArea = All;
                }
                field("MRR No."; Rec."MRR No.")
                {
                    ApplicationArea = All;
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
                        //This functionality was copied from page #50064. Unsupported part was commented. Please check it.
                        /*CurrPage.RGPLines.PAGE.*/
                        LineWriteOff;
                    end;
                }
            }
            group("&Line")
            {
                Caption = '&Line';

                group("Item &Tracking Lines")
                {
                    Caption = 'Item &Tracking Lines';

                    action("&Shipment")
                    {
                        ApplicationArea = All;
                        Caption = '&Shipment';

                        trigger OnAction()
                        begin
                            //ALLE[551]
                            //This functionality was copied from page #50064. Unsupported part was commented. Please check it.
                            /*CurrPage.RGPLines.PAGE.*/
                            _OpenItemTrackingLines(0);
                        end;
                    }
                    action("&Receipt")
                    {
                        ApplicationArea = All;
                        Caption = '&Receipt';

                        trigger OnAction()
                        begin
                            //ALLE[551]
                            //This functionality was copied from page #50064. Unsupported part was commented. Please check it.
                            /*CurrPage.RGPLines.PAGE.*/
                            _OpenItemTrackingLines(1);
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
        Rec.NRGP:=true;
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
    procedure _OpenItemTrackingLines(Direction: Option Outbound, Inbound)
    begin
        //ALLE[551]
        if Direction = 0 then Rec.TestField("Quantity to Ship")
        else
            Rec.TestField("Quantity to Receive");
        Rec.OpenItemTrackingLines(Direction);
    end;
    procedure OpenItemTrackingLines(Direction: Option Outbound, Inbound)
    begin
        //ALLE[551]
        if Direction = 0 then Rec.TestField("Quantity to Ship")
        else
            Rec.TestField("Quantity to Receive");
        Rec.OpenItemTrackingLines(Direction);
    end;
}
