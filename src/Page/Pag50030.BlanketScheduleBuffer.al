Page 50030 "Blanket Schedule Buffer"
{
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
                field("Schedule Quantity"; Rec."Schedule Quantity")
                {
                    ApplicationArea = All;
                    Caption = 'Schedule Quantity';

                    trigger OnValidate()
                    var
                        SalesScheduleBufferLocal: Record "SSD Sales Schedule Buffer";
                    begin
                        SalesScheduleBufferLocal.Reset;
                        SalesScheduleBufferLocal.SetRange("Document Type", GOrderType);
                        SalesScheduleBufferLocal.SetRange("Document No.", GOrderNo);
                        SalesScheduleBufferLocal.SetRange("Sell-to Customer No.", GSelltoCustomerNo);
                        SalesScheduleBufferLocal.SetRange("Item No.", "GNo.");
                        SalesScheduleBufferLocal.SetRange("Order Line No.", GLineNo);
                        SalesScheduleBufferLocal.SetFilter("Line No.", '<>%1', Rec."Line No.");
                        SalesScheduleBufferLocal.CalcSums("Schedule Quantity");
                        if(SalesScheduleBufferLocal."Schedule Quantity" + Rec."Schedule Quantity") > GQuantity then Error(Error0001, GQuantity);
                    end;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                    Caption = 'Planned Shipment Date';
                }
            }
        }
    }
    actions
    {
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Document Type":=GOrderType;
        Rec."Document No.":=GOrderNo;
        Rec."Sell-to Customer No.":=GSelltoCustomerNo;
        Rec."Item No.":="GNo.";
        Rec."Order Line No.":=GLineNo;
    end;
    var "GNo.": Code[20];
    GSelltoCustomerNo: Code[20];
    GOrderNo: Code[20];
    GQuantity: Decimal;
    GLineNo: Integer;
    Error0001: label 'Total schedule quantity should not be more than %1';
    GOrderType: Option Quote, "Order", Invoice, "Credit Memo", "Blanket Order", "Return Order";
    procedure InitialValues("RecNo.": Code[20]; RecSelltoCustomerNo: Code[20]; RecOrderNo: Code[20]; RecQuantity: Decimal; RecLineNo: Integer; RecOrderType: Option Quote, "Order", Invoice, "Credit Memo", "Blanket Order", "Return Order")
    begin
        //InitialValues
        "GNo.":="RecNo.";
        GSelltoCustomerNo:=RecSelltoCustomerNo;
        GOrderNo:=RecOrderNo;
        GQuantity:=RecQuantity;
        GLineNo:=RecLineNo;
        GOrderType:=RecOrderType;
    end;
}
