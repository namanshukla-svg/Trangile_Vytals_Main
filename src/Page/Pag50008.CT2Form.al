Page 50008 "CT2 Form"
{
    // ALLE 3.15....ARE3
    ApplicationArea = All;
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "SSD CT2 Header";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("CT2 No."; Rec."CT2 No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec)then CurrPage.Update;
                    end;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    Editable = "Customer No.Editable";
                }
                field("Customer PO No."; Rec."Customer PO No.")
                {
                    ApplicationArea = All;
                    Editable = "Customer PO No.Editable";
                }
                field("Customer PO Date"; Rec."Customer PO Date")
                {
                    ApplicationArea = All;
                    Editable = "Customer PO DateEditable";
                }
                field("CT2 Date"; Rec."CT2 Date")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("CT2 Validate Date"; Rec."CT2 Validate Date")
                {
                    ApplicationArea = All;
                    Editable = "CT2 Validate DateEditable";
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = StatusEditable;

                    trigger OnValidate()
                    begin
                        StatusOnAfterValidate;
                    end;
                }
            }
            part(CT2SubFrm; "CT2 SubFrm")
            {
                Editable = CT2SubFrmEditable;
                SubPageLink = "CT2 Document No."=field("CT2 No.");
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

                action(List)
                {
                    ApplicationArea = All;
                    Caption = 'List';
                    RunObject = Page "CT2 List";
                    ShortCutKey = 'Shift+Ctrl+L';
                }
                action(Reopen)
                {
                    ApplicationArea = All;
                    Caption = 'Reopen';
                    Image = ReOpen;

                    trigger OnAction()
                    begin
                        //CT2Line.RESET;
                        //CT2Line.SETRANGE("CT2 Document No.", "CT2 No.");
                        //IF CT2Line.FIND('-') THEN REPEAT
                        //  CT2Line.CALCFIELDS("Applied Qty", "Order Quantity", "Invoice Qty");
                        //  IF (CT2Line."Applied Qty" <> 0 ) OR  (CT2Line."Order Quantity" <> 0) OR (CT2Line."Invoice Qty" <> 0) THEN
                        //    ERROR('You can not reopen the form');
                        //UNTIL CT2Line.NEXT = 0;
                        Rec.Status:=Rec.Status::" ";
                        Rec.Modify;
                        CurrPage.Update;
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        if Rec.Status <> Rec.Status::" " then begin
            "Customer No.Editable":=false;
            "Customer PO No.Editable":=false;
            "Customer PO DateEditable":=false;
            "CT2 Validate DateEditable":=false;
            StatusEditable:=false;
            CT2SubFrmEditable:=false;
        end
        else
        begin
            "Customer No.Editable":=true;
            "Customer PO No.Editable":=true;
            "Customer PO DateEditable":=true;
            "CT2 Validate DateEditable":=true;
            StatusEditable:=true;
            CT2SubFrmEditable:=true;
        end;
        OnAfterGetCurrRecord;
    end;
    trigger OnInit()
    begin
        CT2SubFrmEditable:=true;
        StatusEditable:=true;
        "CT2 Validate DateEditable":=true;
        "Customer PO DateEditable":=true;
        "Customer PO No.Editable":=true;
        "Customer No.Editable":=true;
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;
    var CT2Line: Record "SSD CT2 Line";
    "Customer No.Editable": Boolean;
    "Customer PO No.Editable": Boolean;
    "Customer PO DateEditable": Boolean;
    "CT2 Validate DateEditable": Boolean;
    StatusEditable: Boolean;
    CT2SubFrmEditable: Boolean;
    local procedure StatusOnAfterValidate()
    begin
        CurrPage.Update(true);
    end;
    local procedure OnAfterGetCurrRecord()
    begin
        xRec:=Rec;
        if Rec.Status <> Rec.Status::" " then begin
            "Customer No.Editable":=false;
            "Customer PO No.Editable":=false;
            "Customer PO DateEditable":=false;
            "CT2 Validate DateEditable":=false;
            //CurrForm.Status.EDITABLE(FALSE);
            CT2SubFrmEditable:=false;
        end
        else
        begin
            "Customer No.Editable":=true;
            "Customer PO No.Editable":=true;
            "Customer PO DateEditable":=true;
            "CT2 Validate DateEditable":=true;
            //CurrForm.Status.EDITABLE(TRUE);
            CT2SubFrmEditable:=true;
        end;
    end;
}
