Page 50013 "Indent Subform"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "SSD Indent Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("No.2"; Rec."No.2")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Description 3"; Rec."Description 3")
                {
                    ToolTip = 'Specifies the value of the Description 3 field.', Comment = '%';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field(Inventory; Rec."Inventory Main Store")
                {
                    ApplicationArea = All;
                    Caption = 'Inventory';
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Qty. on Req. Line"; Rec."Qty. on Req. Line")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Qty. on Purchase Order"; Rec."Qty. on Purchase Order")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unit Of Measure Code"; Rec."Unit Of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Qty. per Unit Of Measure"; Rec."Qty. per Unit Of Measure")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Rec.Validate("Line Amount", Rec."Direct Unit Cost" * Rec.Quantity);
                    end;
                }
                field("Expected Cost"; Rec."Expected Cost")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    Caption = 'Requested Receipt Date';
                }
                field("Item.""Variant Filter"""; Item."Variant Filter")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Indent Date"; Rec."Indent Date")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Capital Item"; Rec."Capital Item")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shelf No."; Rec."Shelf No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Gen.Prod.Posting Group"; Rec."Gen.Prod.Posting Group")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("ROL-Maximum Order Quantity"; Rec."ROL-Maximum Order Quantity")
                {
                    ApplicationArea = All;
                }
                field("MSL-Safety Stock Quantity"; Rec."MSL-Safety Stock Quantity")
                {
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
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

                action(Card)
                {
                    ApplicationArea = All;
                    Caption = 'Card';
                    Image = EditLines;
                    ShortCutKey = 'Shift+F7';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50012. Unsupported part was commented. Please check it.
                        /*CurrPage.IndentLines.PAGE.*/
                        ShowCard;
                    end;
                }
                group("Item Avalibility By")
                {
                    Caption = 'Item Avalibility By';

                    action(Period)
                    {
                        ApplicationArea = All;
                        Caption = 'Period';

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #50012. Unsupported part was commented. Please check it.
                            /*CurrPage.IndentLines.PAGE.*/
                            ItemAvailability(0);
                        end;
                    }
                    action(Variant)
                    {
                        ApplicationArea = All;
                        Caption = 'Variant';

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #50012. Unsupported part was commented. Please check it.
                            /*CurrPage.IndentLines.PAGE.*/
                            ItemAvailability(1);
                        end;
                    }
                    action(Location)
                    {
                        ApplicationArea = All;
                        Caption = 'Location';

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #50012. Unsupported part was commented. Please check it.
                            /*CurrPage.IndentLines.PAGE.*/
                            ItemAvailability(2);
                        end;
                    }
                }
                action(Dimension)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50012. Unsupported part was commented. Please check it.
                        /*CurrPage.IndentLines.PAGE.*/
                        ShowDimensions;
                    end;
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        UserSetup: Record "User Setup";
    begin
        Rec.Type := xRec.Type;
        if IndentHeader.Get(Rec."Document No.") then begin
            if xRec."Due Date" = 0D then
                Rec."Due Date" := IndentHeader."Due Date"
            else
                Rec."Due Date" := xRec."Due Date";
            Rec."Responsibility Center" := IndentHeader."Responsibility Center";
            Rec."Shortcut Dimension 1 Code" := IndentHeader."Shortcut Dimension 1 Code";
            Rec."Shortcut Dimension 2 Code" := IndentHeader."Shortcut Dimension 2 Code";
            Rec."Indent Order Type" := IndentHeader."Indent Order Type";
        end;
    end;

    var
        Item: Record Item;
        ItemAvailByDate: Page "Item Availability by Periods";
        ItemAvailByVar: Page "Item Availability by Variant";
        ItemAvailByLoc: Page "Item Availability by Location";
        Text001: label 'Change %1 from %2 to %3?';
        IndentHeader: Record "SSD Indent Header";
        Inventory: Decimal;

    procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin)
    begin
        Rec.TestField(Type, Rec.Type::"Fixed Asset");
        Rec.TestField("No.");
        Item.Reset;
        Item.Get(Rec."No.");
        Item.SetRange("No.", Rec."No.");
        Item.SetRange("Date Filter", 0D, Rec."Indent Date");
        case AvailabilityType of
            Availabilitytype::Date:
                begin
                    Item.SetRange("Variant Filter", Rec."Variant Code");
                    Clear(ItemAvailByDate);
                    ItemAvailByDate.LookupMode(true);
                    ItemAvailByDate.SetRecord(Item);
                    ItemAvailByDate.SetTableview(Item);
                    if ItemAvailByDate.RunModal = Action::LookupOK then if Rec."Indent Date" <> ItemAvailByDate.GetLastDate then if Confirm(Text001, true, Rec.FieldCaption("Indent Date"), Rec."Indent Date", ItemAvailByDate.GetLastDate) then Rec.Validate("Indent Date", ItemAvailByDate.GetLastDate);
                end;
            Availabilitytype::Variant:
                begin
                    Clear(ItemAvailByVar);
                    ItemAvailByVar.LookupMode(true);
                    ItemAvailByVar.SetRecord(Item);
                    ItemAvailByVar.SetTableview(Item);
                    if ItemAvailByVar.RunModal = Action::LookupOK then if Rec."Variant Code" <> ItemAvailByVar.GetLastVariant then if Confirm(Text001, true, Rec.FieldCaption("Variant Code"), Rec."Variant Code", ItemAvailByVar.GetLastVariant) then Rec.Validate("Variant Code", ItemAvailByVar.GetLastVariant);
                end;
            Availabilitytype::Location:
                begin
                    Item.SetRange("Variant Filter", Rec."Variant Code");
                    Clear(ItemAvailByLoc);
                    ItemAvailByLoc.LookupMode(true);
                    ItemAvailByLoc.SetRecord(Item);
                    ItemAvailByLoc.SetTableview(Item);
                    if ItemAvailByLoc.RunModal = Action::LookupOK then;
                end;
        end;
    end;

    procedure ShowCard()
    var
        Item: Record Item;
    begin
        Item.SetRange("No.", Rec."No.");
        Page.Run(30, Item);
    end;

    procedure ShowReceipt()
    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
    begin
        PurchRcptLine.SetCurrentkey("Indent No.");
        PurchRcptLine.SetRange("Indent No.", Rec."Document No.");
        PurchRcptLine.SetRange("Indent Line No.", Rec."Line No.");
        PurchRcptLine.SetCurrentkey("Document No.", "Line No.");
        Page.Run(528, PurchRcptLine);
    end;

    procedure ShowDimensions()
    begin
        Rec.TestField("Document No.");
        Rec.TestField("Line No.");
        /* // BIS 1145
            DocDim.SETRANGE("Table ID",DATABASE::"Indent Line");
            DocDim.SETRANGE("Document Type",6);
            DocDim.SETRANGE("Document No.","Document No.");
            DocDim.SETRANGE("Line No.","Line No.");
            DocDimensions.SETTABLEVIEW(DocDim);
            DocDimensions.RUNMODAL;
            */
    end;

}
