PageExtension 50093 "SSD Sales Invoice" extends "Sales Invoice"
{
    Editable = true;

    layout
    {
        addafter("Posting Date")
        {
            field("Applied to Insurance Policy"; Rec."Applied to Insurance Policy")
            {
                ApplicationArea = All;
            }
            field("ST38 No"; Rec."ST38 No")
            {
                ApplicationArea = All;
                Caption = 'E-Way Bill No.';
            }
            field("Expected Delivery Date"; Rec."Expected Delivery Date")
            {
                ApplicationArea = All;
            }
            //SSDU
            field("Type of Invoice"; Rec."Type of Invoice")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Type of Invoice field.';
            }
            //SSDU
        }
        addafter(Status)
        {
            field("Customer Road Permit No."; Rec."Customer Road Permit No.")
            {
                ApplicationArea = All;
            }
            field("SPD/Sample Order"; Rec."SPD/Sample Order")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Delivery Resp. Contact No."; Rec."Delivery Resp. Contact No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Bill-to Contact")
        {
            field("Actual Delivery Date"; Rec."Actual Delivery Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Ship-to Contact")
        {
            field(CT2; Rec.CT2)
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter("Package Tracking No.")
        {
            field("CT2 Form"; Rec."CT2 Form")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(CT3; Rec.CT3)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("CT3 Form"; Rec."CT3 Form")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        modify("VAT Reporting Date")
        {
            Visible = false;
        }
        modify("Currency Code")
        {
            Editable = false;
        }
        movebefore(Status; "Shipping Agent Code")
        movebefore("Shipping Agent Code"; "Shipment Method Code")
        movebefore("Shipment Method Code"; "Transport Method")
    }
    actions
    {
        addafter(Preview)
        {
            action(RemoveItemtracking)
            {
                ApplicationArea = All;
                Caption = 'Remove Item Tracking';
                Image = Delete;
                RunObject = Report "Remove Reservation Entry";
            }
        }
        //IG_DS
        modify(Post)
        {
            trigger OnBeforeAction()
            var
                TaxTransactionValue: Record "Tax Transaction Value";
                SalesLine: Record "Sales Line";
                TaxTypeObjHelper: Codeunit "Tax Type Object Helper";
                SGSTAmt: Decimal;
                IGSTAmt: Decimal;
                CGSTAmt: Decimal;
            begin
                if (Rec."GST Customer Type" = Rec."GST Customer Type"::Registered) or (Rec."GST Customer Type" = Rec."GST Customer Type"::Unregistered) then begin
                    SalesLine.Reset();
                    SalesLine.SetRange("Document Type", Rec."Document Type");
                    SalesLine.SetRange("Document No.", Rec."No.");
                    SalesLine.Setfilter("No.", '<>%1', '');
                    if SalesLine.FindFirst() then
                        repeat
                            SGSTAmt := 0;
                            IGSTAmt := 0;
                            CGSTAmt := 0;
                            TaxTransactionValue.Reset();
                            TaxTransactionValue.SetFilter("Tax Record ID", '%1', SalesLine.RecordId);
                            TaxTransactionValue.SetFilter("Value Type", '%1', TaxTransactionValue."Value Type"::Component);
                            TaxTransactionValue.SetRange("Visible on Interface", true);
                            if TaxTransactionValue.FindSet() then
                                repeat
                                    if TaxTransactionValue.GetAttributeColumName = 'IGST' then begin
                                        // IGSTPer := TaxTransactionValue.Percent;
                                        IGSTAmt += TaxTypeObjHelper.GetComponentAmountFrmTransValue(TaxTransactionValue);
                                    end;
                                    if TaxTransactionValue.GetAttributeColumName = 'CGST' then begin
                                        // CGSTPer := TaxTransactionValue.Percent;
                                        CGSTAmt += TaxTypeObjHelper.GetComponentAmountFrmTransValue(TaxTransactionValue);
                                    end;
                                    if TaxTransactionValue.GetAttributeColumName = 'SGST' then begin
                                        // SGSTPer := TaxTransactionValue.Percent;
                                        SGSTAmt += TaxTypeObjHelper.GetComponentAmountFrmTransValue(TaxTransactionValue);
                                    end;
                                until TaxTransactionValue.Next() = 0;
                            if (IGSTAmt = 0) and ((SGSTAmt = 0) and (CGSTAmt = 0)) then
                                Error('Please calculate the GST for Line No. %1', SalesLine."Line No.");
                        until SalesLine.Next() = 0;
                end;
            end;
        }
        modify(PostAndSend)
        {
            trigger OnBeforeAction()
            var
                TaxTransactionValue: Record "Tax Transaction Value";
                SalesLine: Record "Sales Line";
                TaxTypeObjHelper: Codeunit "Tax Type Object Helper";
                SGSTAmt: Decimal;
                IGSTAmt: Decimal;
                CGSTAmt: Decimal;
            begin
                if (Rec."GST Customer Type" = Rec."GST Customer Type"::Registered) or (Rec."GST Customer Type" = Rec."GST Customer Type"::Unregistered) then begin
                    SalesLine.Reset();
                    SalesLine.SetRange("Document Type", Rec."Document Type");
                    SalesLine.SetRange("Document No.", Rec."No.");
                    SalesLine.Setfilter("No.", '<>%1', '');
                    if SalesLine.FindFirst() then
                        repeat
                            SGSTAmt := 0;
                            IGSTAmt := 0;
                            CGSTAmt := 0;
                            TaxTransactionValue.Reset();
                            TaxTransactionValue.SetFilter("Tax Record ID", '%1', SalesLine.RecordId);
                            TaxTransactionValue.SetFilter("Value Type", '%1', TaxTransactionValue."Value Type"::Component);
                            TaxTransactionValue.SetRange("Visible on Interface", true);
                            if TaxTransactionValue.FindSet() then
                                repeat
                                    if TaxTransactionValue.GetAttributeColumName = 'IGST' then begin
                                        // IGSTPer := TaxTransactionValue.Percent;
                                        IGSTAmt += TaxTypeObjHelper.GetComponentAmountFrmTransValue(TaxTransactionValue);
                                    end;
                                    if TaxTransactionValue.GetAttributeColumName = 'CGST' then begin
                                        // CGSTPer := TaxTransactionValue.Percent;
                                        CGSTAmt += TaxTypeObjHelper.GetComponentAmountFrmTransValue(TaxTransactionValue);
                                    end;
                                    if TaxTransactionValue.GetAttributeColumName = 'SGST' then begin
                                        // SGSTPer := TaxTransactionValue.Percent;
                                        SGSTAmt += TaxTypeObjHelper.GetComponentAmountFrmTransValue(TaxTransactionValue);
                                    end;
                                until TaxTransactionValue.Next() = 0;
                            if (IGSTAmt = 0) and ((SGSTAmt = 0) and (CGSTAmt = 0)) then
                                Error('Please calculate the GST for Line No. %1', SalesLine."Line No.");
                        until SalesLine.Next() = 0;
                end;
            end;
        }
        //IG_DS
    }
    trigger OnDeleteRecord(): Boolean
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."SSD Delete Administrator" then Error('You are not authorise to delete this record');
    end;
}
