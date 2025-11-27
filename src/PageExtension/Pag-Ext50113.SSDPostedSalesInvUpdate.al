pageextension 50113 "SSD Posted Sales Inv. - Update" extends "Posted Sales Inv. - Update"
{
    layout
    {
        addafter(General)
        {
            //SSD Sunil
            field("LR/RR No."; Rec."LR/RR No.")
            {
                AccessByPermission = TableData "Sales Invoice Header"=RM;
                ApplicationArea = All;
                ToolTip = 'Specifies the lorry receipt number of the document.';
            }
            field("LR/RR Date"; Rec."LR/RR Date")
            {
                AccessByPermission = TableData "Sales Invoice Header"=RM;
                ApplicationArea = All;
                ToolTip = 'Specifies the lorry receipt date.';
            }
            field("LR/RR No. Capture Date"; Rec."LR/RR No. Capture Date")
            {
                AccessByPermission = TableData "Sales Invoice Header"=RM;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the LR/RR No. Capture Date field.';
            }
            field("LR/RR No. Capture Time"; Rec."LR/RR No. Capture Time")
            {
                AccessByPermission = TableData "Sales Invoice Header"=RM;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the LR/RR No. Capture Time field.';
            }
            field("Actual Delivery Date"; Rec."Actual Delivery Date")
            {
                AccessByPermission = TableData "Sales Invoice Header"=RM;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Actual Delivery Date field.';
            }
            field("Calculated Freight Amount"; Rec."Calculated Freight Amount")
            {
                AccessByPermission = TableData "Sales Invoice Line"=RM;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Calculated Freight Amount field.';

                trigger OnValidate()
                begin
                    //AlleRavik/ZDD/001 Begin
                    rec.Validate("Freight Amount", rec."Calculated Freight Amount");
                //Modify;
                //AlleRavik/ZDD/001 End
                end;
            }
            // field("Shipping Agent Code"; Rec."Shipping Agent Code")
            // {
            //     AccessByPermission = TableData "Sales Invoice Header" = RM;
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies which shipping agent is used to transport the items on the sales document to the customer.';
            // }
            field("Actual Shipping Agent code"; Rec."Actual Shipping Agent code")
            {
                AccessByPermission = TableData "Sales Invoice Header"=RM;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Actual Shipping Agent code field.';
            }
            field("Transport Method"; Rec."Transport Method")
            {
                AccessByPermission = TableData "Sales Invoice Header"=RM;
                ApplicationArea = All;
                ToolTip = 'Specifies the transport method of the sales header that this line was posted from.';
            }
            field("Firm Freight"; Rec."Firm Freight")
            {
                AccessByPermission = TableData "Sales Invoice Header"=RM;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Firm Freight field.';
                Editable = FieldEditable;

                trigger OnValidate()
                begin
                    CurrPage.Update(true);
                end;
            }
            field("Transportation Distance"; Rec."Transportation Distance")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Transportation Distance field.';
            }
            field("Freight Amount"; Rec."Freight Amount")
            {
                AccessByPermission = TableData "Sales Invoice Line"=RM;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Freight Amount field.';
                Editable = FreigthAmt;

                trigger OnValidate()
                var
                    SalesInvLine: Record "Sales Invoice Line";
                    TotalWaight: Decimal;
                    Validation: Codeunit Validation;
                begin
                    //SSD_Sunil_To be deleted
                    // SalesInvLine.Reset;
                    // SalesInvLine.SetRange("Document No.", Rec."No.");
                    // TotalWaight := 0;
                    // if SalesInvLine.Find('-') then
                    //     repeat
                    //         TotalWaight += SalesInvLine."Gross Wt";
                    //     until SalesInvLine.Next = 0;
                    // SalesInvLine.Reset;
                    // SalesInvLine.SetRange("Document No.", rec."No.");
                    // if SalesInvLine.Find('-') then
                    //     repeat
                    //         if TotalWaight <> 0 then
                    //             SalesInvLine."Freight Amount" := ROUND(rec."Freight Amount" * SalesInvLine."Gross Wt" / TotalWaight)
                    //         else
                    //             SalesInvLine."Freight Amount" := 0;
                    //         SalesInvLine.Modify;
                    //     until SalesInvLine.Next = 0;
                    //SSD_Sunil_To be deleted
                    Validation.SetFreightAmt(Rec);
                end;
            }
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the external document number that is entered on the sales header that this line was posted from.';
            }
            field(Remarks1; Rec.Remarks1)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Remarks field.';
                Caption = 'Remarks';
            }
        //SSD Sunil
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        SetEditable();
    end;
    trigger OnOpenPage()
    begin
        SetEditable();
    end;
    trigger OnAfterGetRecord()
    begin
        SetEditable();
    end;
    procedure SetEditable()
    begin
        UserSetup.Get(UserId);
        if UserSetup."Firm Freight Permission" then FieldEditable:=true
        else
            FieldEditable:=false;
        if Rec."Firm Freight" then FreigthAmt:=false
        else
            FreigthAmt:=true;
    end;
    var UserSetup: Record "User Setup";
    FieldEditable: Boolean;
    FreigthAmt: Boolean;
}
