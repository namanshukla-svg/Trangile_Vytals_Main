Page 50199 "Reject Lot No Information"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = List;
    SourceTable = "SSD Reject Lot No Information";
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
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                }
                field("Lot Qty"; Rec."Lot Qty")
                {
                    ApplicationArea = All;
                }
                field("Rejected Qty"; Rec."Rejected Qty")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        RejectLotNoInfLocal: Record "SSD Reject Lot No Information";
                    begin
                        RejectLotNoInfLocal.Reset;
                        RejectLotNoInfLocal.SetCurrentkey("Template Type", "Quality Order No.", "Source Document No.", "Source Doc. Line No.", "Item No.", "Variant Code", "Sub Template Type", "Sub Quality Order No.");
                        RejectLotNoInfLocal.SetRange("Template Type", GTemplateType);
                        RejectLotNoInfLocal.SetRange("Quality Order No.", GQOrderNo);
                        RejectLotNoInfLocal.SetRange("Source Document No.", GSrcDocNo);
                        RejectLotNoInfLocal.SetRange("Source Doc. Line No.", GrcLineNo);
                        RejectLotNoInfLocal.SetRange("Item No.", GItemNo);
                        RejectLotNoInfLocal.SetRange("Variant Code", GVariantCode);
                        RejectLotNoInfLocal.SetRange("Sub Template Type", GSubTmpType);
                        RejectLotNoInfLocal.SetRange("Sub Quality Order No.", GSubQltOrdNo);
                        RejectLotNoInfLocal.SetFilter("Line No.", '<>%1', Rec."Line No.");
                        RejectLotNoInfLocal.CalcSums("Rejected Qty");
                        if(RejectLotNoInfLocal."Rejected Qty" + Rec."Rejected Qty") > GRejectedQty then Error(Error0001, GRejectedQty);
                    end;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Template Type":=GTemplateType;
        Rec."Quality Order No.":=GQOrderNo;
        Rec."Source Document No.":=GSrcDocNo;
        Rec."Source Doc. Line No.":=GrcLineNo;
        Rec."Item No.":=GItemNo;
        Rec."Variant Code":=GVariantCode;
        Rec."Sub Template Type":=GSubTmpType;
        Rec."Sub Quality Order No.":=GSubQltOrdNo;
    end;
    var GQOrderNo: Code[20];
    GSrcDocNo: Code[20];
    GrcLineNo: Integer;
    GItemNo: Code[20];
    GVariantCode: Code[20];
    GSubQltOrdNo: Code[20];
    GTemplateType: Option Receipt, Manufacturing;
    GSubTmpType: Option " ", RcvdCoil, Routing;
    GRejectedQty: Decimal;
    Error0001: label 'Total rejected quantity should not be more than %1';
    procedure InitialValues(var RcQualityOrdHdr: Record "SSD Quality Order Header")
    begin
        case RcQualityOrdHdr."Template Type" of RcQualityOrdHdr."template type"::Receipt: begin
            GTemplateType:=Gtemplatetype::Receipt;
            GQOrderNo:=RcQualityOrdHdr."No.";
            GSubTmpType:=Gsubtmptype::" ";
            GSubQltOrdNo:='';
        end;
        RcQualityOrdHdr."template type"::RcvdCoil: begin
            GTemplateType:=Gtemplatetype::Receipt;
            GSubTmpType:=Gsubtmptype::RcvdCoil;
            GQOrderNo:=RcQualityOrdHdr."Order No.";
            GSubQltOrdNo:=RcQualityOrdHdr."No.";
        end;
        RcQualityOrdHdr."template type"::Manufacturing: begin
            GTemplateType:=Gtemplatetype::Manufacturing;
            GSubTmpType:=Gsubtmptype::" ";
            GQOrderNo:=RcQualityOrdHdr."No.";
            GSubQltOrdNo:='';
        end;
        RcQualityOrdHdr."template type"::Routing: begin
            GTemplateType:=Gtemplatetype::Manufacturing;
            GSubTmpType:=Gsubtmptype::Routing;
            GQOrderNo:=RcQualityOrdHdr."Order No.";
            GSubQltOrdNo:=RcQualityOrdHdr."No.";
        end;
        end;
        GSrcDocNo:=RcQualityOrdHdr."Source Document No.";
        GrcLineNo:=RcQualityOrdHdr."Source Doc. Line No.";
        GItemNo:=RcQualityOrdHdr."Item No.";
        GVariantCode:=RcQualityOrdHdr."Variant Code";
        GRejectedQty:=RcQualityOrdHdr."Rejected Qty.";
    end;
}
