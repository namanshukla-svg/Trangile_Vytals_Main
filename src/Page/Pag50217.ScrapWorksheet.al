Page 50217 "Scrap Worksheet"
{
    Editable = false;
    PageType = List;
    SourceTable = "SSD Subcontracting Scrap";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                }
                field("Source Subtype"; Rec."Source Subtype")
                {
                    ApplicationArea = All;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                }
                field("Source Line No."; Rec."Source Line No.")
                {
                    ApplicationArea = All;
                }
                field("Source Document"; Rec."Source Document")
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
                field("Zone Code"; Rec."Zone Code")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Qty. (Base)"; Rec."Qty. (Base)")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
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
                field("Posted Source Document"; Rec."Posted Source Document")
                {
                    ApplicationArea = All;
                }
                field("Posted Source No."; Rec."Posted Source No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Vendor Shipment No."; Rec."Vendor Shipment No.")
                {
                    ApplicationArea = All;
                }
                field("Whse. Receipt No."; Rec."Whse. Receipt No.")
                {
                    ApplicationArea = All;
                }
                field("Whse Receipt Line No."; Rec."Whse Receipt Line No.")
                {
                    ApplicationArea = All;
                }
                field("Gate Entry no."; Rec."Gate Entry no.")
                {
                    ApplicationArea = All;
                }
                field("Gate Line No."; Rec."Gate Line No.")
                {
                    ApplicationArea = All;
                }
                field("Posted Source Line No."; Rec."Posted Source Line No.")
                {
                    ApplicationArea = All;
                }
                field("Qty. On Purch. Order"; Rec."Qty. On Purch. Order")
                {
                    ApplicationArea = All;
                }
                field("Qty. On Invoice"; Rec."Qty. On Invoice")
                {
                    ApplicationArea = All;
                }
                field("Actual Qty. to Receive"; Rec."Actual Qty. to Receive")
                {
                    ApplicationArea = All;
                }
                field("Accepted Qty."; Rec."Accepted Qty.")
                {
                    ApplicationArea = All;
                }
                field("Rejected Qty."; Rec."Rejected Qty.")
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
                field("Reject Location Code"; Rec."Reject Location Code")
                {
                    ApplicationArea = All;
                }
                field("Reject Bin Code"; Rec."Reject Bin Code")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
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
                field("Party Name"; Rec."Party Name")
                {
                    ApplicationArea = All;
                }
                field("Delivery Challan"; Rec."Delivery Challan")
                {
                    ApplicationArea = All;
                }
                field("Delivery Challan Sent Item"; Rec."Delivery Challan Sent Item")
                {
                    ApplicationArea = All;
                }
                field("Scrap Item"; Rec."Scrap Item")
                {
                    ApplicationArea = All;
                }
                field("Scrap Qty."; Rec."Scrap Qty.")
                {
                    ApplicationArea = All;
                }
                field("Scrap Updated"; Rec."Scrap Updated")
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
            group("&Scrap")
            {
                Caption = '&Scrap';
                Visible = false;

                action("Update Scrap")
                {
                    ApplicationArea = All;
                    Caption = 'Update Scrap';

                    trigger OnAction()
                    var
                        PostedWareHouseReceipt: Record "Posted Whse. Receipt Line";
                    begin
                        LineNo:=0;
                        if Rec.Find('-')then repeat LineNo:=LineNo + 10000;
                                UpdateScrap();
                                PostedWareHouseReceipt.SetRange(PostedWareHouseReceipt."No.", Rec."Document No.");
                                PostedWareHouseReceipt.SetRange(PostedWareHouseReceipt."Line No.", Rec."Line No.");
                                if PostedWareHouseReceipt.Find('-')then begin
                                    PostedWareHouseReceipt."Scrap Updated":=true;
                                    PostedWareHouseReceipt.Modify;
                                end;
                            until Rec.Next = 0;
                    end;
                }
            }
        }
    }
    var LineNo: Integer;
    procedure UpdateScrap()
    var
        ItemJournal: Record "Item Journal Line";
        ItemJnlPost: Codeunit "Item Jnl.-Post Line";
        PostedWareHouseReceipt: Record "Posted Whse. Receipt Line";
        FirstLoop: Boolean;
        SecondLoop: Boolean;
        Ile: Record "Item Ledger Entry";
        LocationLocal: Record Location;
        WMSMgmt: Codeunit "WMS Management";
        WhseJnlLine: Record "Warehouse Journal Line";
        WhseJnlPostLine: Codeunit "Whse. Jnl.-Register Line";
    begin
        LineNo:=10000;
        if Rec.Find('-')then repeat if Rec."Scrap Updated" = false then begin
                    ItemJournal.Init;
                    ItemJournal."Journal Template Name":='SCRAP';
                    ItemJournal."Journal Batch Name":='SCRAP';
                    ItemJournal.Validate(ItemJournal."Item No.", Rec."Item No.");
                    ItemJournal."Posting Date":=Rec."Posting Date";
                    ItemJournal."Entry Type":=ItemJournal."entry type"::"Negative Adjmt.";
                    ItemJournal."Document No.":=Rec."Document No.";
                    ItemJournal."Line No.":=LineNo;
                    ItemJournal."Responsibility Center":=Rec."Responsibility Center";
                    ItemJournal.Validate("Shortcut Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
                    ItemJournal.Validate("Shortcut Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
                    ItemJournal."Location Code":=Rec."Location Code";
                    ItemJournal."Bin Code":=Rec."Bin Code";
                    ItemJournal.Validate(ItemJournal.Quantity, Rec."Scrap Qty.");
                    ItemJournal."Source Code":='ITEMJNL';
                    ItemJournal.Validate(ItemJournal."Location Code");
                    Ile.SetRange(Ile."Item No.", ItemJournal."Item No.");
                    Ile.SetRange(Ile."Location Code", ItemJournal."Location Code");
                    if Ile.Find('+')then if(Ile.Open = true) and (Ile."Remaining Quantity" >= ItemJournal.Quantity)then ItemJournal."Applies-to Entry":=Ile."Entry No.";
                    ItemJnlPost.Run(ItemJournal);
                    if LocationLocal.Get(ItemJournal."Location Code")then if LocationLocal."Bin Mandatory" then begin
                            WMSMgmt.CreateWhseJnlLine(ItemJournal, 1, WhseJnlLine, false);
                            WMSMgmt.CheckWhseJnlLine(WhseJnlLine, 2, 0, false);
                            WhseJnlPostLine.Run(WhseJnlLine);
                        end;
                    ItemJournal.Init;
                    ItemJournal."Journal Template Name":='SCRAP';
                    ItemJournal."Journal Batch Name":='SCRAP';
                    ItemJournal."Line No.":=LineNo + LineNo;
                    ItemJournal.Validate(ItemJournal."Item No.", Rec."Scrap Item");
                    ItemJournal."Posting Date":=Rec."Posting Date";
                    ItemJournal."Entry Type":=ItemJournal."entry type"::"Positive Adjmt.";
                    ItemJournal."Document No.":=Rec."Document No.";
                    ItemJournal."Responsibility Center":=Rec."Responsibility Center";
                    ItemJournal.Validate("Shortcut Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
                    ItemJournal.Validate("Shortcut Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
                    ItemJournal."Location Code":=Rec."Scrap Location";
                    ItemJournal."Bin Code":=Rec."Scrap Bin";
                    ItemJournal.Validate(ItemJournal.Quantity, Rec."Scrap Qty.");
                    ItemJournal."Source Code":='ITEMJNL';
                    ItemJournal.Validate(ItemJournal."Location Code");
                    ItemJnlPost.Run(ItemJournal);
                    if LocationLocal.Get(ItemJournal."Location Code")then if LocationLocal."Bin Mandatory" then begin
                            WMSMgmt.CreateWhseJnlLine(ItemJournal, 1, WhseJnlLine, false);
                            WMSMgmt.CheckWhseJnlLine(WhseJnlLine, 2, 0, false);
                            WhseJnlPostLine.Run(WhseJnlLine);
                        end;
                    Rec."Scrap Updated":=true;
                    Rec.Modify;
                    PostedWareHouseReceipt.SetRange(PostedWareHouseReceipt."No.", Rec."Document No.");
                    PostedWareHouseReceipt.SetRange(PostedWareHouseReceipt."Line No.", Rec."Line No.");
                    if PostedWareHouseReceipt.Find('-')then begin
                        PostedWareHouseReceipt."Scrap Updated":=true;
                        PostedWareHouseReceipt.Modify;
                    end;
                end;
            until Rec.Next = 0;
    end;
    procedure CalulateScrap()
    var
        PostedWhseReceiptLine: Record "Posted Whse. Receipt Line";
    begin
        if PostedWhseReceiptLine.Find('-')then repeat if(PostedWhseReceiptLine."Scrap Item" <> '') and (PostedWhseReceiptLine."Scrap Updated" = false)then begin
                    Rec.Init;
                    Rec.TransferFields(PostedWhseReceiptLine);
                    Rec.Insert;
                end;
            until PostedWhseReceiptLine.Next = 0;
    end;
}
