PageExtension 50097 "SSD Sales Order Subform" extends "Sales Order Subform"
{
    layout
    {
        modify(Description)
        {
            Enabled = true;
            Editable = false;
        }
        modify("Description 2")
        {
            Editable = true;
            Enabled = true;
        }
        modify("Line Discount %")
        {
            Editable = false;
        }
        modify("Line Discount Amount")
        {
            Enabled = true;
            Editable = false;
        }
        modify("Qty. to Ship")
        {
            Editable = QtytoShipEditable;
        }
        modify("Invoice Discount Amount")
        {
            Editable = false;
        }
        addafter("Quantity Invoiced")
        {
            field("Short Clode"; Rec."Short Close")
            {
                ApplicationArea = All;
                ShowMandatory = TypeChosen;
            }
            field("Short Close Qty."; Rec."Short Close Qty.")
            {
                ApplicationArea = All;
            }
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
                Caption = 'Remarks For SP';
            }
            field("PMM Remarks"; Rec."PMM Remarks")
            {
                ApplicationArea = All;
            }
        }
        addafter("Description 2")
        {
            field("Item.""Description 3"""; Item."Description 3")
            {
                ApplicationArea = All;
                Caption = 'Description 3';
                Editable = true;
            }
            field("Hold-Dispatch"; Rec."Hold-Dispatch")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    SalesHeader: Record "Sales Header";
                begin
                    SalesHeader.Reset();
                    SalesHeader.SetRange("Document Type", Rec."Document Type");
                    SalesHeader.SetRange("No.", Rec."Document No.");
                    if SalesHeader.FindFirst() then
                        SalesHeader.TestField(SalesHeader.Status, SalesHeader.Status::Open);
                end;
            }
        }
        addafter("Drop Shipment")
        {
            field("Forecast Name"; Rec."Forecast Name")
            {
                ApplicationArea = All;
            }
            field("SP Order No."; Rec."SP Order No.")
            {
                ApplicationArea = All;
            }
            field(Ismrpupdated; Rec.Ismrpupdated)
            {
                ApplicationArea = All;
            }
            field(Ismrpexception; Rec.Ismrpexception)
            {
                ApplicationArea = All;
            }
            field(crminsertflag; Rec.crminsertflag)
            {
                ApplicationArea = All;
            }
            field(isCRMexception; Rec.isCRMexception)
            {
                ApplicationArea = All;
            }
        }
        modify("Variant Code")
        {
            Visible = true;
        }
        movebefore(Quantity; "Variant Code")
        addafter("Unit Price")
        {
            field("<Unit Price CRM>"; Rec."Unit Price Dup.")
            {
                ApplicationArea = All;
                Caption = 'Unit Price CRM';
                Editable = false;
            }
            field("MOQ Quantity"; Rec."MOQ Quantity")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MOQ Quantity field.';
            }
        }
        addafter("Line No.")
        {
            field("Effective Date"; Rec."Effective Date")
            {
                ApplicationArea = All;
                Caption = 'Special Priority Date';

                trigger OnValidate()
                begin
                    if Rec."Effective Date" <> 0D then if Rec."Effective Date" < CalcDate('3D', Today) then Error('Special Priority date can not be less than today');
                end;
            }
            field("MRP No."; Rec."MRP No.")
            {
                ApplicationArea = All;
            }
            field("Budgeted Cost Amount"; Rec."Budgeted Cost Amount")
            {
                ApplicationArea = All;
                Editable = false;
                Enabled = true;
            }
            field("Required Receipt Date"; Rec."Required Receipt Date")
            {
                ApplicationArea = All;
            }
            field("Price Match/Mismatch"; Rec."Price Match/Mismatch")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("SP Remarks"; Rec."SP Remarks")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Sales Line No."; Rec."Sales Line No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Internal Remarks"; Rec."Internal Remarks")
            {
                ApplicationArea = All;
            }
            field("Revised Shipment Date"; Rec."Revised Shipment Date")
            {
                ApplicationArea = All;
            }
            field("Inventory Available"; Rec."Inventory Available")
            {
                ApplicationArea = all;
                Visible = true;
            }
            field("Output Date"; Rec."Output Date")
            {
                ApplicationArea = all;
                Visible = true;
            }
        }
    }
    actions
    {
        addlast(processing)
        {
            action("Short Close")
            {
                ApplicationArea = All;
                Caption = 'Short Close';
                Image = TaxDetail;

                trigger OnAction()
                begin
                    if Confirm(Test0001) then begin
                        ShortClose;
                    end;
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        if Item.Get(Rec."No.") then;
    end;

    var
        SaleHeader: Record "Sales Header";
        CT2Line: Record "SSD CT2 Line";
        SalesLRec: Record "Sales Line";
        SalesLRec1: Record "Sales Line";
        LineNo: Integer;
        CT3Line: Record "SSD CT3 Line";
        Cont: Boolean;
        TypeChosen: Boolean;
        DescriptionEditable: Boolean;
        "Unit of Measure CodeEditable": Boolean;
        QtytoShipEditable: Boolean;
        Test0001: label 'Do you want to short close the selected lines';
        Item: Record Item;
        SalesHeader_G: Record "Sales Header";
        AlleEvents: Codeunit "Alle Events";

    procedure ShortClose()
    var
        SalesHeader: Record "Sales Header";
        SalesLines: Record "Sales Line";
    begin
        //ALLE 3.29
        CurrPage.SetSelectionFilter(SalesLines);
        if SalesLines.FindFirst then begin
            repeat
                SalesLines."Short Close Qty." := SalesLines."Outstanding Quantity";
                SalesLines."Outstanding Quantity" := 0;
                SalesLines."Outstanding Qty. (Base)" := 0;
                SalesLines.Validate("Qty. to Invoice", 0);
                SalesLines.Validate("Qty. to Ship", 0);
                SalesLines."Short Close" := true;
                SalesLines."Short Close DateTime" := CurrentDatetime; //ALLE-NM 16072019
                SalesLines.Modify;
            until SalesLines.Next = 0;
        end;
        SalesLines.Reset;
        SalesLines.SetRange("Document Type", Rec."Document Type");
        SalesLines.SetRange("Document No.", Rec."Document No.");
        SalesLines.SetRange("Short Close", false);
        if not SalesLines.FindFirst then begin
            if SalesHeader.Get(SalesLines."Document Type", SalesLines."Document No.") then begin
                SalesHeader."Completely Closed" := true;
                SalesHeader.Modify;
            end;
        end;
    end;
}
