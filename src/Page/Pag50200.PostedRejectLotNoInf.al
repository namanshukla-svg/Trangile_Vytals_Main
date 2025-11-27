Page 50200 "Posted Reject Lot No Inf"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
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

                    trigger OnLookup(var Text: Text): Boolean var
                        FrmLotNoInf: Page "Lot No. Information Card";
                        LotNoInfLocal: Record "Lot No. Information";
                    begin
                        LotNoInfLocal.Reset;
                        LotNoInfLocal.FilterGroup(2);
                        LotNoInfLocal.SetRange("Item No.", Rec."Item No.");
                        LotNoInfLocal.SetRange("Variant Code", Rec."Variant Code");
                        LotNoInfLocal.SetRange("Lot No.", Rec."Lot No.");
                        LotNoInfLocal.FilterGroup(0);
                        Clear(FrmLotNoInf);
                        FrmLotNoInf.SetTableview(LotNoInfLocal);
                        FrmLotNoInf.RunModal;
                    end;
                }
                field("Lot Qty"; Rec."Lot Qty")
                {
                    ApplicationArea = All;
                }
                field("Rejected Qty"; Rec."Rejected Qty")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
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
    procedure InitialValues(var RcQualityOrdHdr: Record "SSD Posted Quality Order Hdr")
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
