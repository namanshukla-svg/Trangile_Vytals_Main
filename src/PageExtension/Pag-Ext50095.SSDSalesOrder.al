PageExtension 50095 "SSD Sales Order" extends "Sales Order"
{
    layout
    {
        modify("Order Date")
        {
            Editable = DocRelease;
        }
        modify("Document Date")
        {
            Editable = DocRelease;
        }
        modify("VAT Reporting Date")
        {
            Visible = false;
        }
        modify("Shipment Date")
        {
            trigger OnBeforeValidate()
            begin
                IF Rec."Shipment Date" <= WORKDATE THEN ERROR(Test0002, WORKDATE + 1);
            end;
        }
        addafter("Sell-to Contact")
        {
            field("Delivery Resp. Name"; Rec."Delivery Resp. Name")
            {
                ApplicationArea = All;
            }
            field("Delivery Resp. Contact No."; Rec."Delivery Resp. Contact No.")
            {
                ApplicationArea = All;
            }
            field("Cust EMail"; Rec."Cust EMail")
            {
                ApplicationArea = All;
                Caption = 'Sell-to Email';
                Editable = Editable1;

                trigger OnValidate()
                begin
                    Editable1 := true;
                    if Rec.Status = Rec.Status::Released then Editable1 := false;
                end;
            }
        }
        addafter("External Document No.")
        {
            field("External Doc. Date"; Rec."External Doc. Date")
            {
                ApplicationArea = All;
                Caption = 'PO  Date';
            }
            field("Applied to Insurance Policy"; Rec."Applied to Insurance Policy")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Applied to Insurance Policy field.';
            }
        }
        addafter("Responsibility Center")
        {
            field("Freight Zone"; Rec."Freight Zone")
            {
                ApplicationArea = All;
            }
        }
        addafter(Status)
        {
            //IG_DS
            field("Count Reopen"; Rec."Count Reopen")
            {
                Caption = 'Count';
                ApplicationArea = all;
                Visible = false;
            }
            field("Count Date"; Rec."Count Date")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Hold-Dispatch"; Rec."Hold-Dispatch")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                begin
                    Rec.TestField(Status, Status::Open);
                end;
            }
            //IG_DS
            field("Order Confirmation Mail Send"; Rec."Order Confirmation Mail Send")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("SPD/Sample Order"; Rec."SPD/Sample Order")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Price Match/Mismatch"; Rec."Price Match/Mismatch")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Document Subtype"; Rec."Document Subtype")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Document Subtype field.';
            }
        }
        addafter("VAT Bus. Posting Group")
        {
            field("Expected Delivery Date"; Rec."Expected Delivery Date")
            {
                ApplicationArea = All;
            }
            field("Actual Delivery Date"; Rec."Actual Delivery Date")
            {
                ApplicationArea = All;
            }
        }
        //SSDU
        addbefore(Status)
        {
            field("Type of Invoice"; Rec."Type of Invoice")
            {
                ApplicationArea = All;
            }
        }
        //SSDU
        addafter("Tax Info")
        {
            group(Control1000000009)
            {
                Editable = false;

                field(crmRelease; Rec.crmRelease)
                {
                    ApplicationArea = All;
                }
                field(crminsertflag; Rec.crminsertflag)
                {
                    ApplicationArea = All;
                }
                field(crmupdateflag; Rec.crmupdateflag)
                {
                    ApplicationArea = All;
                }
                field(isCRMexception; Rec.isCRMexception)
                {
                    ApplicationArea = All;
                }
                field(exceptiondetail; Rec.exceptiondetail)
                {
                    ApplicationArea = All;
                }
            }
        }
        modify("Currency Code")
        {
            Editable = false;
        }
    }
    actions
    {
        //SSDU
        modify(Post)
        {
            Visible = true;
        }
        modify(PostAndSend)
        {
            Visible = false;
        }
        modify(PostAndNew)
        {
            Visible = false;
        }
        modify(PostPrepaymentCreditMemo)
        {
            Visible = false;
        }
        modify(SendApprovalRequest) //IG_DS_23-06-2025
        {
            trigger OnBeforeAction()
            var
                SalesLine: Record "Sales Line";
            begin
                SalesLine.Reset();
                SalesLine.SetRange("Document Type", Rec."Document Type");
                SalesLine.SetRange("Document No.", Rec."No.");
                if SalesLine.FindFirst() then
                    repeat
                        if SalesLine."Line Discount %" > 0 then
                            SalesLine.TestField("Line Discount Amount");
                        if SalesLine."Location Code" <> Rec."Location Code" then //IG_DS
                            Error(
                                'Line %1: Location Code (%2) must match the header Location Code (%3).',
                                SalesLine."Line No.",
                                SalesLine."Location Code",
                                Rec."Location Code");
                    until SalesLine.Next() = 0;
            end;
        }
        modify(Release)
        {
            trigger OnBeforeAction()
            var
                SalesLine: Record "Sales Line";
            begin
                SalesLine.Reset(); //IG_DS
                SalesLine.SetRange("Document Type", Rec."Document Type");
                SalesLine.SetRange("Document No.", Rec."No.");
                if SalesLine.FindFirst() then
                    repeat
                        if SalesLine."Line Discount %" > 0 then
                            SalesLine.TestField("Line Discount Amount");
                        if SalesLine."Location Code" <> Rec."Location Code" then
                            Error(
                                'Line %1: Location Code (%2) must match the header Location Code (%3).',
                                SalesLine."Line No.",
                                SalesLine."Location Code",
                                Rec."Location Code");
                    until SalesLine.Next() = 0;
            end;
        }
        //SSDU
        addafter(Release)
        {
            group("&Line")
            {
                Caption = '&Line';

                separator(Action123)
                {
                }
                action("Short Close")
                {
                    ApplicationArea = All;
                    Caption = 'Short Close';
                    Image = TaxDetail;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //ALLE 3.29
                        //TESTFIELD(Status,Status::Open);
                        if Confirm(Test0001) then CurrPage.SalesLines.Page.ShortClose;
                    end;
                }
            }
            action("Send Mail as Attachment")
            {
                ApplicationArea = All;
                Caption = 'Send Mail as Attachment';
                Promoted = true;

                trigger OnAction()
                var
                    SalesQuote: Codeunit "Sales-Quote to Order";
                    UserSetup: Record "User Setup";
                begin
                    Rec.TestField(Status, Rec.Status::Released);
                    //SSDU SalesQuote.MailSend(Rec);
                end;
            }
        }
        //IG_DS
        // modify(Release)
        // {
        //     trigger OnBeforeAction()
        //     var
        //         myInt: Integer;
        //     begin
        //         if Rec."Released Date" = 0D then begin
        //             Rec."Released Date" := Today;
        //             Rec.Modify(true);
        //         end;
        //     end;
        // }
        modify(Reopen)
        {
            trigger OnAfterAction()
            var
                SalesLine: Record "Sales Line";
                Item: Record Item;
                CalcShipmentDate: Date;
            begin
                if Rec."Document Type" = Rec."Document Type"::Order then begin
                    Rec."Count Reopen" += 1;
                    Rec."Count Date" := Today;
                end;

                //  if Rec."Released Date" <> Today then begin
                SalesLine.Reset();
                SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                SalesLine.SetRange(Type, SalesLine.Type::Item);
                SalesLine.SetRange("Document No.", Rec."No.");
                //   SalesLine.SetFilter("Quantity Shipped", '%1', 0);
                if SalesLine.FindFirst() then
                    repeat
                        if Item.Get(SalesLine."No.") then begin
                            // Calculate shipment date based on Item's Lead Time Calculation
                            CalcShipmentDate := CalcDate(Item."Lead Time Calculation", Rec."Count Date");
                            SalesLine."Shipment Date" := CalcShipmentDate;
                            SalesLine.Modify();
                        end;
                    until SalesLine.Next() = 0;
                // end;
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

    var
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        Test0001: label 'Do you want to short close the selected lines';
        CT2header: Record "SSD CT2 Header";
        CT2Line: Record "SSD CT2 Line";
        SalesLRec: Record "Sales Line";
        CT3header: Record "SSD CT3 Header";
        CT3Line: Record "SSD CT3 Line";
        SLRec: Record "Sales Line";
        Test0002: label 'Shipment Date can not be less than %1';
        Editable1: Boolean;
        CheckSalesHeader: Record "Sales Header";
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        SL1: Record "Sales Line";
        DocRelease: Boolean;
        SSDSMSManagement: Codeunit "SSD SMS Management";

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Document Subtype" := Rec."Document Subtype"::Order;
    end;
}
