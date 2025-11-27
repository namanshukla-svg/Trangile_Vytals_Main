Page 50022 "CT3 Form"
{
    // ALLE 3.16....ARE3
    ApplicationArea = All;
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "SSD CT3 Header";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("CT3 No."; Rec."CT3 No.")
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
                field("CT3 Date"; Rec."CT3 Date")
                {
                    ApplicationArea = All;
                }
                field("CT3 Validate Date"; Rec."CT3 Validate Date")
                {
                    ApplicationArea = All;
                    Editable = "CT3 Validate DateEditable";
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
            part(CT3SubFrm; "CT3 SubFrm")
            {
                Editable = CT3SubFrmEditable;
                SubPageLink = "CT3 Document No."=field("CT3 No.");
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
                    RunObject = Page "CT3 List";
                    ShortCutKey = 'Shift+Ctrl+L';
                }
                action(Reopen)
                {
                    ApplicationArea = All;
                    Caption = 'Reopen';
                    Image = ReOpen;

                    trigger OnAction()
                    begin
                        //CT3Line.RESET;
                        //CT3Line.SETRANGE("CT3 Document No.", "CT3 No.");
                        //IF CT3Line.FIND('-') THEN REPEAT
                        //  CT3Line.CALCFIELDS("Applied Qty", "Order Qty", "Invoice Qty");
                        //  IF (CT3Line."Applied Qty" <> 0 ) OR  (CT3Line."Order Qty" <> 0) OR (CT3Line."Invoice Qty" <> 0) THEN
                        //    ERROR('You can not reopen the form');
                        //UNTIL CT3Line.NEXT = 0;
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
            "CT3 Validate DateEditable":=false;
            StatusEditable:=false;
            CT3SubFrmEditable:=false;
        end
        else
        begin
            "Customer No.Editable":=true;
            "Customer PO No.Editable":=true;
            "Customer PO DateEditable":=true;
            "CT3 Validate DateEditable":=true;
            StatusEditable:=true;
            CT3SubFrmEditable:=true;
        end;
        OnAfterGetCurrRecord;
    end;
    trigger OnInit()
    begin
        CT3SubFrmEditable:=true;
        StatusEditable:=true;
        "CT3 Validate DateEditable":=true;
        "Customer PO DateEditable":=true;
        "Customer PO No.Editable":=true;
        "Customer No.Editable":=true;
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;
    var CT3Line: Record "SSD CT3 Line";
    "Customer No.Editable": Boolean;
    "Customer PO No.Editable": Boolean;
    "Customer PO DateEditable": Boolean;
    "CT3 Validate DateEditable": Boolean;
    StatusEditable: Boolean;
    CT3SubFrmEditable: Boolean;
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
            "CT3 Validate DateEditable":=false;
            //CurrForm.Status.EDITABLE(FALSE);
            CT3SubFrmEditable:=false;
        end
        else
        begin
            "Customer No.Editable":=true;
            "Customer PO No.Editable":=true;
            "Customer PO DateEditable":=true;
            "CT3 Validate DateEditable":=true;
            //CurrForm.Status.EDITABLE(TRUE);
            CT3SubFrmEditable:=true;
        end;
    end;
}
