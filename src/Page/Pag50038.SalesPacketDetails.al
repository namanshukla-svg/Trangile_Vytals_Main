Page 50038 "Sales Packet Details"
{
    // ALLE 6.01....Deviation Calculation
    // ALLE 3.08....Freight Zone
    // ISS-013.....Batch No. field given of type Text[20]
    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = List;
    SourceTable = "SSD Sales Schedule Buffer";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No. of Box"; Rec."No. of Box")
                {
                    ApplicationArea = All;
                    Caption = 'No of Box/Bin/Trolley';

                    trigger OnValidate()
                    begin
                        ValidationOfTotalQty(Rec, GQuantity);
                    end;
                }
                field("Qty per Box"; Rec."Qty per Box")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ValidationOfTotalQty(Rec, GQuantity);
                    end;
                }
                field("Total Qty"; Rec."Total Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Lot Line No"; Rec."Lot Line No")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean var
                        ReservationEntry: Record "Reservation Entry";
                        ReservationEntries: Page "Resevation Entries Page";
                    begin
                        //"Reservation Entry"."MRN Line No." WHERE (Item No.=FIELD(Item No.),Source ID=FIELD(Document No.),Source Ref. No.=FIELD(Order Line No.))
                        ReservationEntry.SetRange("Item No.", Rec."Item No.");
                        ReservationEntry.SetRange("Source ID", Rec."Document No.");
                        ReservationEntry.SetRange("Source Ref. No.", Rec."Order Line No.");
                        if Page.RunModal(50323, ReservationEntry) = Action::LookupOK then begin
                            Rec."Lot Line No":=ReservationEntry."MRN Line No.";
                            Rec.Modify;
                        end;
                    end;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec."Batch No.":=Rec."Lot No.";
                    end;
                }
                field("Batch No."; Rec."Batch No.")
                {
                    ApplicationArea = All;
                }
                field("Actual Weight"; Rec."Actual Weight")
                {
                    ApplicationArea = All;
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    ApplicationArea = All;
                }
                field("Gross Wt. Per Case"; Rec."Gross Wt. Per Case")
                {
                    ApplicationArea = All;
                    Caption = '<Gross Wt. Per BaseUOM>';
                }
                field("Net Wt. Per Case"; Rec."Net Wt. Per Case")
                {
                    ApplicationArea = All;
                    Caption = '<Net Wt. Per Base UOM>';
                }
                field(Packing; Rec.Packing)
                {
                    ApplicationArea = All;
                }
                field("Packing Length"; Rec."Packing Length")
                {
                    ApplicationArea = All;
                }
                field("Packing Breadth"; Rec."Packing Breadth")
                {
                    ApplicationArea = All;
                }
                field("Lot Qty."; Rec."Lot Qty.")
                {
                    ApplicationArea = All;
                }
                field("Packing Height"; Rec."Packing Height")
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        //alle
        Rec."Batch No.":=Rec."Lot No.";
    //alle
    end;
    trigger OnClosePage()
    begin
        //CORP::PK 070819 >>>
        CopyofPacking.Reset;
        CopyofPacking.SetRange("Document No.", Rec."Document No.");
        if CopyofPacking.FindSet then CopyofPacking.DeleteAll;
        SalesScheduleBuffer.Reset;
        SalesScheduleBuffer.SetRange("Document No.", Rec."Document No.");
        if SalesScheduleBuffer.FindSet then repeat RemainingBox:=0;
                LineNo:=0;
                RemainingBox:=SalesScheduleBuffer."No. of Box";
                repeat CopyofPacking.Reset;
                    CopyofPacking.SetRange("Document No.", SalesScheduleBuffer."Document No.");
                    if not CopyofPacking.FindLast then LineNo:=10000
                    else
                        LineNo:=CopyofPacking."Line No." + 10000;
                    RemainingBox:=RemainingBox - 1;
                    CopyofPacking.Init;
                    CopyofPacking.Validate("Document No.", SalesScheduleBuffer."Document No.");
                    CopyofPacking.Validate("Document Line No.", SalesScheduleBuffer."Line No.");
                    CopyofPacking.Validate("Line No.", LineNo);
                    CopyofPacking.Validate("Customer No.", SalesScheduleBuffer."Sell-to Customer No.");
                    CopyofPacking.Validate("Item No.", SalesScheduleBuffer."Item No.");
                    CopyofPacking.Validate("Order Line No.", SalesScheduleBuffer."Order Line No.");
                    CopyofPacking.Validate("No. of Box", 1);
                    CopyofPacking.Validate(Quantity, SalesScheduleBuffer."Qty per Box");
                    CopyofPacking.Validate("Lot No.", SalesScheduleBuffer."Batch No.");
                    CopyofPacking.Insert;
                until RemainingBox = 0;
            until SalesScheduleBuffer.Next = 0;
    //CORP::PK 070819 <<<
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Document Type":=GOrderType;
        Rec."Document No.":=GOrderNo;
        Rec."Sell-to Customer No.":=GSelltoCustomerNo;
        Rec."Item No.":="GNo.";
        Rec."Order Line No.":=GLineNo;
        //ALLE 3.08
        Rec."Gross Wt. Per Case":=GrossWt;
        Rec."Net Wt. Per Case":=NetWt;
        Rec."Unit of Measure Code":=UnitOfMCode;
        //ALLE 3.08
        Rec."Variant Code":=VariantCode // Alle 26052021
 end;
    trigger OnQueryClosePage(CloseAction: action): Boolean begin
        //ALLE 6.01
        if Rec."Calculated Weight" <> 0 then Rec.TestField("Actual Weight");
    end;
    var "GNo.": Code[20];
    GSelltoCustomerNo: Code[20];
    GOrderNo: Code[20];
    GLineNo: Integer;
    Error0001: label 'Total Order Quantity should not be more than %1';
    GOrderType: Option Quote, "Order", Invoice, "Credit Memo", "Blanket Order", "Return Order";
    GQuantity: Decimal;
    TotalQtyPerOrderLine: Decimal;
    GrossWt: Decimal;
    NetWt: Decimal;
    UnitOfMCode: Code[10];
    CopyofPacking: Record "SSD Copy of Packing";
    RemainingBox: Integer;
    LineNo: Integer;
    SalesScheduleBuffer: Record "SSD Sales Schedule Buffer";
    VariantCode: Code[10];
    procedure InitialValues(RecOrderType: Option Quote, "Order", Invoice, "Credit Memo", "Blanket Order", "Return Order"; RecOrderNo: Code[20]; RecSelltoCustomerNo: Code[20]; RecLineNo: Integer; "RecNo.": Code[20]; RecQuantity: Decimal; RecGWt: Decimal; RecNWt: Decimal; UOMCode: Code[10])
    begin
        GOrderType:=RecOrderType;
        GOrderNo:=RecOrderNo;
        GSelltoCustomerNo:=RecSelltoCustomerNo;
        GLineNo:=RecLineNo;
        "GNo.":="RecNo.";
        GQuantity:=RecQuantity;
        //ALLE 3.08
        GrossWt:=RecGWt;
        NetWt:=RecNWt;
        UnitOfMCode:=UOMCode;
    //ALLE 3.08
    end;
    procedure ValidationOfTotalQty(RecSalesScheduleBuffer: Record "SSD Sales Schedule Buffer"; RecTotalQuantity: Decimal)
    var
        SalesScheduleBufferLocal: Record "SSD Sales Schedule Buffer";
    begin
        TotalQtyPerOrderLine:=0;
        SalesScheduleBufferLocal.Reset;
        SalesScheduleBufferLocal.SetRange("Document Type", RecSalesScheduleBuffer."Document Type");
        SalesScheduleBufferLocal.SetRange("Document No.", RecSalesScheduleBuffer."Document No.");
        SalesScheduleBufferLocal.SetRange("Sell-to Customer No.", RecSalesScheduleBuffer."Sell-to Customer No.");
        SalesScheduleBufferLocal.SetRange("Item No.", RecSalesScheduleBuffer."Item No.");
        SalesScheduleBufferLocal.SetRange("Order Line No.", RecSalesScheduleBuffer."Order Line No.");
        SalesScheduleBufferLocal.SetFilter("Line No.", '<>%1', RecSalesScheduleBuffer."Line No.");
        if SalesScheduleBufferLocal.Find('-')then repeat TotalQtyPerOrderLine:=TotalQtyPerOrderLine + ((SalesScheduleBufferLocal."No. of Box") * (SalesScheduleBufferLocal."Qty per Box"));
            until SalesScheduleBufferLocal.Next = 0;
        if(TotalQtyPerOrderLine + RecSalesScheduleBuffer."Total Qty") > RecTotalQuantity then Error(Error0001, RecTotalQuantity);
    end;
    local procedure BatchNoOnActivate()
    begin
        //ALLE[5.51]
        Rec."Batch No.":=Rec."Lot No.";
        CurrPage.SaveRecord;
    //ALLE[5.51]
    end;
    local procedure OnTimer()
    begin
        //<<<<< ALLE [5.51]
        //"Lot Line No":="Line No.";
        Rec."Batch No.":=Rec."Lot No.";
        CurrPage.SaveRecord;
    //>>>> ALLE[5.51]
    end;
    procedure InitialValues2(RecOrderType: Option Quote, "Order", Invoice, "Credit Memo", "Blanket Order", "Return Order"; RecOrderNo: Code[20]; RecSelltoCustomerNo: Code[20]; RecLineNo: Integer; "RecNo.": Code[20]; RecQuantity: Decimal; RecGWt: Decimal; RecNWt: Decimal; UOMCode: Code[10]; VariantCode: Code[10])
    begin
        GOrderType:=RecOrderType;
        GOrderNo:=RecOrderNo;
        GSelltoCustomerNo:=RecSelltoCustomerNo;
        GLineNo:=RecLineNo;
        "GNo.":="RecNo.";
        GQuantity:=RecQuantity;
        //ALLE 3.08
        GrossWt:=RecGWt;
        NetWt:=RecNWt;
        UnitOfMCode:=UOMCode;
        //ALLE 3.08
        VariantCode:=Rec."Variant Code"; //Alle 26052021
    end;
}
