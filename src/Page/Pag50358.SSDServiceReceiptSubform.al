page 50358 "SSD Service Receipt Subform"
{
    Caption = 'Lines';
    LinksAllowed = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = "Purchase Line";
    SourceTableView = where("Document Type" = filter(Order));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;

                field(Type; Rec.Type)
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the line type.';
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Suite;
                    ShowMandatory = not IsCommentLine;
                    ToolTip = 'Specifies what you are buying, such as a product or a fixed asset. You’ll see different lists of things to choose from depending on your choice in the Type field.';
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Describes what is being purchased. The suggested text comes from the item itself. You can change it to suit your needs for this document. If you change it here, the source of the text will not change. If the line''s Type field is set to Comment, you can use this field to write the comment, and leave the other fields empty.';
                    Editable = false;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies information in addition to the description.';
                    Editable = false;
                }
                field("Description 3"; Rec."Description 3")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description 3 field.', Comment = '%';
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Location;
                    ToolTip = 'Specifies a code for the location where you want the items to be placed when they are received.';
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Suite;
                    BlankZero = true;
                    Enabled = not IsBlankNumber;
                    ShowMandatory = (Rec.Type <> Rec.Type::" ") and (Rec."No." <> '');
                    ToolTip = 'Specifies the quantity of what you''re buying. The number is based on the unit chosen in the Unit of Measure Code field.';
                    Editable = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';
                    Editable = false;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the unit of measure.';
                    Visible = false;
                    Editable = false;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = Suite;
                    BlankZero = true;
                    Editable = false;
                    Enabled = not IsBlankNumber;
                    ShowMandatory = (Rec.Type <> Rec.Type::" ") and (Rec."No." <> '');
                    ToolTip = 'Specifies the price of one unit of what you''re buying.';
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = Suite;
                    BlankZero = true;
                    Editable = false;
                    Enabled = not IsBlankNumber;
                    ToolTip = 'Specifies the net amount, excluding any invoice discount amount, that must be paid for products on the line.';
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the discount amount that is granted for the item on the line.';
                    Visible = false;
                    Editable = false;
                }
                field("Qty. to Receive"; Rec."Qty. to Receive")
                {
                    ApplicationArea = Suite;
                    BlankZero = true;
                    ToolTip = 'Specifies the quantity of items that remains to be received.';

                    trigger OnValidate()
                    begin
                        SetItemChargeFieldsStyle();
                    end;
                }
                field("SSD Receipt Remarks"; Rec."SSD Receipt Remarks")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Receipt Remarks field.';
                }
                field("SSD Deduction Amount"; Rec."SSD Deduction Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Deduction Amount field.';
                }
                field("SSD Deduction Remarks"; Rec."SSD Deduction Remarks")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Deduction Remarks field.';
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    ApplicationArea = Suite;
                    BlankZero = true;
                    ToolTip = 'Specifies how many units of the item on the line have been posted as received.';

                    trigger OnDrillDown()
                    var
                        PurchRcptLine: Record "Purch. Rcpt. Line";
                    begin
                        PurchRcptLine.SetCurrentKey("Document No.", "No.", "Planned Receipt Date");
                        PurchRcptLine.SetRange("Order No.", Rec."Document No.");
                        PurchRcptLine.SetRange("Order Line No.", Rec."Line No.");
                        PurchRcptLine.SetFilter(Quantity, '<>%1', 0);
                        PAGE.RunModal(0, PurchRcptLine);
                    end;
                }
                field("Qty. to Assign"; Rec."Qty. to Assign")
                {
                    ApplicationArea = ItemCharges;
                    StyleExpr = ItemChargeStyleExpression;
                    ToolTip = 'Specifies how many units of the item charge will be assigned to the line.';

                    trigger OnDrillDown()
                    begin
                        CurrPage.SaveRecord();
                        Rec.ShowItemChargeAssgnt();
                        UpdateForm(false);
                    end;
                }
                field("Item Charge Qty. to Handle"; Rec."Item Charge Qty. to Handle")
                {
                    ApplicationArea = ItemCharges;
                    QuickEntry = false;
                    StyleExpr = ItemChargeToHandleStyleExpression;
                    ToolTip = 'Specifies how many items the item charge will be assigned to on the line. It can be either equal to Qty. to Assign or to zero. If it is zero, the item charge will not be assigned to the line.';

                    trigger OnDrillDown()
                    begin
                        CurrPage.SaveRecord();
                        Rec.ShowItemChargeAssgnt();
                        UpdateForm(false);
                    end;
                }
                field("Qty. Assigned"; Rec."Qty. Assigned")
                {
                    ApplicationArea = ItemCharges;
                    BlankZero = true;
                    ToolTip = 'Specifies how much of the item charge that has been assigned.';

                    trigger OnDrillDown()
                    begin
                        CurrPage.SaveRecord();
                        Rec.ShowItemChargeAssgnt();
                        UpdateForm(false);
                    end;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    Visible = DimVisible1;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    Visible = DimVisible2;
                }
                field(ShortcutDimCode3; ShortcutDimCode[3])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,3';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3), "Dimension Value Type" = const(Standard), Blocked = const(false));
                    Visible = DimVisible3;
                    ToolTip = 'Specifies the value of the ShortcutDimCode[3] field.';

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field(ShortcutDimCode4; ShortcutDimCode[4])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,4';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4), "Dimension Value Type" = const(Standard), Blocked = const(false));
                    Visible = DimVisible4;
                    ToolTip = 'Specifies the value of the ShortcutDimCode[4] field.';

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field(ShortcutDimCode5; ShortcutDimCode[5])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,5';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5), "Dimension Value Type" = const(Standard), Blocked = const(false));
                    Visible = DimVisible5;
                    ToolTip = 'Specifies the value of the ShortcutDimCode[5] field.';

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field(ShortcutDimCode6; ShortcutDimCode[6])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,6';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6), "Dimension Value Type" = const(Standard), Blocked = const(false));
                    Visible = DimVisible6;
                    ToolTip = 'Specifies the value of the ShortcutDimCode[6] field.';

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field(ShortcutDimCode7; ShortcutDimCode[7])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,7';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7), "Dimension Value Type" = const(Standard), Blocked = const(false));
                    Visible = DimVisible7;
                    ToolTip = 'Specifies the value of the ShortcutDimCode[7] field.';

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field(ShortcutDimCode8; ShortcutDimCode[8])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,8';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8), "Dimension Value Type" = const(Standard), Blocked = const(false));
                    Visible = DimVisible8;
                    ToolTip = 'Specifies the value of the ShortcutDimCode[8] field.';

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;

                action(ItemChargeAssignment)
                {
                    AccessByPermission = TableData "Item Charge" = R;
                    ApplicationArea = ItemCharges;
                    Caption = 'Item Charge &Assignment';
                    Image = ItemCosts;
                    Enabled = Rec.Type = Rec.Type::"Charge (Item)";
                    ToolTip = 'Record additional direct costs, for example for freight. This action is available only for Charge (Item) line types.';

                    trigger OnAction()
                    begin
                        Rec.ShowItemChargeAssgnt();
                        SetItemChargeFieldsStyle();
                    end;
                }
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        SetItemChargeFieldsStyle();
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        SetItemChargeFieldsStyle();
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        Error('');
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.InitType();
        Clear(ShortcutDimCode);
    end;

    trigger OnOpenPage()
    begin
        SetDimensionsVisibility();
    end;

    var
        ItemChargeStyleExpression: Text;
        ItemChargeToHandleStyleExpression: Text;
        ShortcutDimCode: array[8] of Code[20];
        DimVisible1: Boolean;
        DimVisible2: Boolean;
        DimVisible3: Boolean;
        DimVisible4: Boolean;
        DimVisible5: Boolean;
        DimVisible6: Boolean;
        DimVisible7: Boolean;
        DimVisible8: Boolean;
        IsBlankNumber: Boolean;
        IsCommentLine: Boolean;
    /// <summary>
    /// UpdateForm.
    /// </summary>
    /// <param name="SetSaveRecord">Boolean.</param>
    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.Update(SetSaveRecord);
    end;

    local procedure SetItemChargeFieldsStyle()
    begin
        ItemChargeStyleExpression := '';
        ItemChargeToHandleStyleExpression := '';
        if Rec.AssignedItemCharge() then begin
            if Rec."Qty. To Assign" <> (Rec.Quantity - Rec."Qty. Assigned") then ItemChargeStyleExpression := 'Unfavorable';
            if Rec."Item Charge Qty. to Handle" <> Rec."Qty. to Invoice" then ItemChargeToHandleStyleExpression := 'Unfavorable';
        end;
    end;

    local procedure SetDimensionsVisibility()
    var
        DimensionManagement: Codeunit DimensionManagement;
    begin
        DimVisible1 := false;
        DimVisible2 := false;
        DimVisible3 := false;
        DimVisible4 := false;
        DimVisible5 := false;
        DimVisible6 := false;
        DimVisible7 := false;
        DimVisible8 := false;
        DimensionManagement.UseShortcutDims(DimVisible1, DimVisible2, DimVisible3, DimVisible4, DimVisible5, DimVisible6, DimVisible7, DimVisible8);
        Clear(DimensionManagement);
    end;
}
