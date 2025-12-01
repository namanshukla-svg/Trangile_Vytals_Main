PageExtension 50041 "SSD Item Card" extends "Item Card"
{
    layout
    {
        modify("VAT Prod. Posting Group")
        {
            Visible = false;
        }
        modify("Safety Stock Quantity")
        {
            Caption = 'MSL';
        }
        modify("Minimum Order Quantity")
        {
            Caption = 'CL';
        }
        modify("Maximum Order Quantity")
        {
            Caption = 'ROL';
        }
        modify("Item Category Code")
        {
            Caption = 'Product Group Code';
        }
        modify(Blocked)
        {
            //Editable = false;
            trigger OnBeforeValidate()
            begin
                IF (Rec."Inventory Taging Req." = TRUE) AND (Rec."Inventory Taging Person" = '') THEN ERROR('Inventory Taging cannot be Blank ');
            end;
        }
        modify(PreventNegInventoryDefaultNo)
        {
            Visible = false;
        }
        modify("Replenishment System")
        {
            trigger OnAfterValidate()
            begin
                IF Rec."Replenishment System" = Rec."Replenishment System"::Purchase THEN
                    ProcurementTypeEditable := TRUE
                ELSE
                    ProcurementTypeEditable := FALSE;
            end;
        }
        addafter("No.")
        {
            field("Temp Product ID"; Rec."Temp Product ID")
            {
                ApplicationArea = All;
                Editable = FieldEditable;
            }
        }
        addafter(Description)
        {
            field("SSD Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
            }
            field("SSD Description 3"; Rec."Description 3")
            {
                ApplicationArea = All;
                Visible = true;
            }
            field("BOM Consideration"; Rec."BOM Consideration")
            {
                ApplicationArea = All;
            }
        }
        addafter("Item Category Code")
        {
            field("Item Type"; Rec."Item Type")
            {
                ApplicationArea = All;
            }
            field("Deviation %"; Rec."Deviation %")
            {
                ApplicationArea = All;
            }
            field("Quality Required"; Rec."Quality Required")
            {
                ApplicationArea = All;
            }
        }
        addafter(Inventory)
        {
            field("Net Change"; Rec."Net Change")
            {
                ApplicationArea = All;
            }
        }
        addafter(PreventNegInventoryDefaultYes)
        {
            field("Inventory Tracking"; Rec."Inventory Tracking")
            {
                ApplicationArea = All;
            }
            field("Inventory Taging Req."; Rec."Inventory Taging Req.")
            {
                ApplicationArea = All;
                Caption = 'Inventory Tagging Req.';

                trigger OnValidate()
                begin
                    if (Rec."Inventory Taging Req." = true) and (Rec."Inventory Taging Person" = '') then //begin
                        EditableInventoryTag := true
                    else
                        EditableInventoryTag := false;
                    CurrPage.Update(true);
                end;
            }
            field("Pack Size"; Rec."Pack Size")
            {
                ApplicationArea = All;
            }
            field("Inventory Tagging Person"; Rec."Inventory Taging Person")
            {
                ApplicationArea = All;
                Caption = 'Inventory Tagging Person';
                Editable = true;
            }
            field("Phy. Bin Required"; Rec."Phy. Bin Required")
            {
                ApplicationArea = All;
            }
            field("Purchase Group 1"; Rec."Purchase Group 1")
            {
                ApplicationArea = All;
            }
            field("Purchase Group 2"; Rec."Purchase Group 2")
            {
                ApplicationArea = All;
            }
            field("Purchase Group 3"; Rec."Purchase Group 3")
            {
                ApplicationArea = All;
            }
            //Atul::01122025
            // field("No. of Price Valadity in Days"; Rec."No. of Price Valadity in Days")
            // {
            //     ApplicationArea = All;
            // }
            //Atul::01122025
        }
        //Atul::01122025
        addafter(InventoryGrp)
        {
            group("CRM Integration")
            {
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
                field(exceptionDetail; Rec.exceptionDetail)
                {
                    ApplicationArea = All;
                }
            }
        }
        //Atul::01122025
        addafter("Sales Unit of Measure")
        {
            field("Lead Time Dispatch"; Rec."Lead Time Dispatch")
            {
                ApplicationArea = All;
            }
            field("Allow Shipping Variance"; Rec."Allow Shipping Variance")
            {
                ApplicationArea = All;
            }
        }
        addafter("Replenishment System")
        {
            field(ProcurementType; Rec."Procurement Type")
            {
                ApplicationArea = All;
                Editable = ProcurementTypeEditable;
            }
            field("Procurement Category"; Rec."Procurement Category")
            {
                ApplicationArea = All;
            }
            field("Procurement Category 1"; Rec."Procurement Category 1")
            {
                ApplicationArea = All;
            }
        }
        addafter("Purch. Unit of Measure")
        {
            //Atul::01122025
            // field("Self Life"; Rec."Self Life")
            // {
            //     ApplicationArea = All;
            // }
            //Atul::01122025
            field("Hazard material classification"; Rec."Hazard material classification")
            {
                ApplicationArea = All;
                Visible = true;
            }
            field("Material Safety data sheet"; Rec."Material Safety data sheet")
            {
                ApplicationArea = All;
                Visible = true;
            }
            field("Technical data sheet"; Rec."Technical data sheet")
            {
                ApplicationArea = All;
                Visible = true;
            }
        }
        addafter("Safety Stock Quantity")
        {
            field(MOQ; Rec.MOQ)
            {
                ApplicationArea = All;
                Caption = 'MOQ For Sales';
            }
        }
        addafter("Gross Weight")
        {
            //Atul::01122025
            // field("SQ. Meter"; Rec."SQ. Meter")
            // {
            //     ApplicationArea = All;
            // }
            //Atul::01122025
        }
        addafter("Costs & Posting")
        {
            group("HDS Information")
            {
                // Atul 01122025
                Caption = 'MSDS Information';
                // Atul 01122025

                field(PICTOGRAMS; Rec.PICTOGRAMS)
                {
                    ApplicationArea = All;
                }
                field("PRECAUTIONARY STATEMENTS"; Rec."PRECAUTIONARY STATEMENTS")
                {
                    ApplicationArea = All;
                }
                field(CLASSIFICATIONS; Rec.CLASSIFICATIONS)
                {
                    ApplicationArea = All;
                }
                field("UN NUMBER"; Rec."UN NUMBER")
                {
                    ApplicationArea = All;
                }
                field("PRODUCT TYPE"; Rec."PRODUCT TYPE")
                {
                    ApplicationArea = All;
                }
            }
        }
        moveafter("Item Category Code"; "Manufacturing Policy")
        //IG_DS
        addafter("Base Unit of Measure")
        {
            field("Product Classification"; Rec."Product Classification") { ApplicationArea = all; }
            field("SKU Category"; Rec."SKU Category") { ApplicationArea = all; }
        }
        //IG_DS
    }
    actions
    {
        modify(SendApprovalRequest) //IG_DS
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                //IG_DS Rec.TestField(Rec."Product Classification");
            end;
        }
        addafter(Resources)
        {
            action("Receiving Sampling Templates")
            {
                ApplicationArea = All;
                Caption = 'Receiving Sampling Templates';

                trigger OnAction()
                begin
                    Clear(FrmItemSamplingTemp);
                    ItemSamplingTemp.Reset;
                    ItemSamplingTemp.FilterGroup(2);
                    ItemSamplingTemp.SetRange("Item Code", Rec."No.");
                    ItemSamplingTemp.SetRange("Template Type", ItemSamplingTemp."template type"::Receipt);
                    ItemSamplingTemp.FilterGroup(0);
                    FrmItemSamplingTemp.SetTableview(ItemSamplingTemp);
                    FrmItemSamplingTemp.SetTemplateType(ItemSamplingTemp."template type"::Receipt);
                    FrmItemSamplingTemp.RunModal;
                end;
            }
        }
        addafter("Item Tracing")
        {
            action("QR Printing List")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    QRPrint: Page "QR Printing";
                begin
                    QRPrint.GetItem(Rec."No.");
                    QRPrint.Run;
                end;
            }
        }
        addafter(CancelApprovalRequest)
        {
            action("ReOpen")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Reopen';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Category8;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    IF Confirm('Do you want to reopen the Item') then begin
                        Rec.Validate(Blocked, true);
                        Rec.Modify();
                    end
                end;
            }
        }
    }
    var
        ItemCostMgt: Codeunit ItemCostManagement;

    var
        AverageCostLCY: Decimal;
        AverageCostACY: Decimal;
        UserMgt: Codeunit "SSD User Setup Management";
        ItemSamplingTemp: Record "Item Sampling Template";
        FrmItemSamplingTemp: Page "Item Sampling Templates";
        Usersetup: Record "User Setup";
        ProcurementTypeEditable: Boolean;

    var
        QRPrint: Record "SSD QR Printing";
        EditableVar: Boolean;
        EditableInventoryTag: Boolean;
        EditableInv: Boolean;
        InventoryTag: Code[20];
        ILE: Record "Item Ledger Entry";
        FieldEditable: Boolean;

    trigger OnAfterGetRecord()
    begin
        if Rec.Type = Rec.Type::Inventory then
            Rec."Inventory Taging Req." := TRUE
        else
            Rec."Inventory Taging Req." := false;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        ProcurementTypeEditable := TRUE;
        SetEditable();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        EditableVar := TRUE;
    end;

    trigger OnOpenPage()
    begin
        EditableVar := FALSE;
        if Rec.Type = Rec.Type::Inventory then
            Rec."Inventory Taging Req." := TRUE
        else
            Rec."Inventory Taging Req." := false;
        SetEditable();
    end;

    local procedure ProcurementTypeOnActivate()
    begin
        if Rec."Replenishment System" = Rec."replenishment system"::Purchase then
            ProcurementTypeEditable := true
        else
            ProcurementTypeEditable := false;
    end;

    procedure SetEditable()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if (UserSetup."Item UnBlock Rights") or (UserSetup."Master Editing Permission") then
            FieldEditable := true
        else
            FieldEditable := false;
    end;
}
