page 50001 "SSD Insurance Card Form"
{
    ApplicationArea = All;
    Caption = 'SSD Insurance Card Form';
    PageType = List;
    SourceTable = "SSD Insurance Setup";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Insurance Policy No."; Rec."Insurance Policy No.")
                {
                    ToolTip = 'Specifies the value of the Insurance Policy No. field.';
                }
                field("Insurance Vendor No."; Rec."Insurance Vendor No.")
                {
                    ToolTip = 'Specifies the value of the Insurance Vendor No. field.';
                }
                field("Insurance Vendor Name"; Rec."Insurance Vendor Name")
                {
                    ToolTip = 'Specifies the value of the Insurance Vendor Name field.';
                }
                field("Insurance Starting Date"; Rec."Insurance Starting Date")
                {
                    ToolTip = 'Specifies the value of the Insurance Starting Date field.';
                }
                field("Insurance Expiry Date"; Rec."Insurance Expiry Date")
                {
                    ToolTip = 'Specifies the value of the Insurance Expiry Date field.';
                }
                field("Insurance Amount"; Rec."Insurance Amount")
                {
                    ToolTip = 'Specifies the value of the Insurance Amount field.';
                }
                field("Balance Amount"; Rec."Balance Amount")
                {
                    ToolTip = 'Specifies the value of the Balance Amount field.';
                }
                field("Applied Amount"; Rec."Applied Amount")
                {
                    ToolTip = 'Specifies the value of the Applied Amount field.';
                }
                field("Policy Status"; Rec."Policy Status")
                {
                    ToolTip = 'Specifies the value of the Policy Status field.';
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;
    end;
    trigger OnInit()
    begin
        "Insurance AmountEditable":=true;
        "Insurance Expiry DateEditable":=true;
        InsuranceStartingDateEditable:=true;
        "Insurance Vendor No.Editable":=true;
        "Insurance Policy No.Editable":=true;
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;
    var "Insurance Policy No.Editable": Boolean;
    "Insurance Vendor No.Editable": Boolean;
    InsuranceStartingDateEditable: Boolean;
    "Insurance Expiry DateEditable": Boolean;
    "Insurance AmountEditable": Boolean;
    local procedure OnAfterGetCurrRecord()
    begin
        xRec:=Rec;
        if Rec."Policy Status" = Rec."policy status"::" " then begin
            "Insurance Policy No.Editable":=true;
            "Insurance Vendor No.Editable":=true;
            InsuranceStartingDateEditable:=true;
            "Insurance Expiry DateEditable":=true;
            "Insurance AmountEditable":=true;
        end
        else
        begin
            "Insurance Policy No.Editable":=false;
            "Insurance Vendor No.Editable":=false;
            InsuranceStartingDateEditable:=false;
            "Insurance Expiry DateEditable":=false;
            "Insurance AmountEditable":=false;
        end;
    end;
}
