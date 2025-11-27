PageExtension 50021 "SSD ChangeStatusonProdOrder" extends "Change Status on Prod. Order"
{
    layout
    {
        addafter(ReqUpdUnitCost)
        {
            field(VarianceCause; VarianceCause)
            {
                ApplicationArea = All;
                Caption = 'VrianceCause';

                trigger OnValidate()
                begin
                    SingleInstance.SetCode(VarianceCause);
                end;
            }
            field(Remarks; Remarks)
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    SingleInstance.SetCode(Remarks);
                end;
            }
        }
    }
    var
        SingleInstance: Codeunit "SSD Single Instance";
        ProdOrderStatus: Record "Production Order";
        VarianceCause: Enum "SSD Variance Cause";
        Remarks: Text[100];
        GlobalPostingDate: Date;

    trigger OnOpenPage()
    begin
        ReqUpdUnitCost := TRUE;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF ProdOrderStatus.Status = ProdOrderStatus.Status::Finished THEN IF VarianceCause = VarianceCause::" " THEN ERROR('Please Select Vriance Cause');
    end;
    /// <summary>
    /// SSDReturnPostingInfo.
    /// </summary>
    /// <param name="Status">VAR Enum "Production Order Status".</param>
    /// <param name="PostingDate2">VAR Date.</param>
    /// <param name="UpdUnitCost">VAR Boolean.</param>
    procedure SSDReturnPostingInfo(var Status: Enum "Production Order Status"; var PostingDate2: Date; var UpdUnitCost: Boolean; VAR VCause: Enum "SSD Variance Cause"; VAR RMarks: Text[100])
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeReturnPostingInfoCustom(Status, PostingDate2, UpdUnitCost, IsHandled);
        if IsHandled then exit;
        Status := ProdOrderStatus.Status;
        PostingDate2 := GlobalPostingDate;
        UpdUnitCost := ReqUpdUnitCost;
        VCause := VarianceCause;
        RMarks := Remarks;
    end;

    [IntegrationEvent(false, false)]
    //IG_DS_Before local procedure OnBeforeReturnPostingInfo(var Status: Enum "Production Order Status"; var PostingDate2: Date; var UpdUnitCost: Boolean; var IsHandled: Boolean)
    local procedure OnBeforeReturnPostingInfoCustom(var Status: Enum "Production Order Status"; var PostingDate2: Date; var UpdUnitCost: Boolean; var IsHandled: Boolean)
    begin
    end;
    //Unsupported feature: Parameter Insertion (Parameter: VCause) (ParameterCollection) on "ReturnPostingInfo(PROCEDURE 4)".
    //Unsupported feature: Parameter Insertion (Parameter: RMarks) (ParameterCollection) on "ReturnPostingInfo(PROCEDURE 4)".
    //Unsupported feature: Code Modification on "ReturnPostingInfo(PROCEDURE 4)".
    //procedure ReturnPostingInfo();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
        Status := ProdOrderStatus.Status;
        PostingDate2 := PostingDate;
        UpdUnitCost := ReqUpdUnitCost;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
        #1..3
        VCause := VarianceCause;  //dp 170221
        RMarks := Remarks;
        */
    //end;
}
