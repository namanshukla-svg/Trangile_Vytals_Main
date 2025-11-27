Page 50244 "Item Issue subform"
{
    AutoSplitKey = true;
    Caption = 'Item Issue Lines';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "SSD Indent Line2";
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
                    Visible = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Issued Qty"; Rec."Issued Qty")
                {
                    ApplicationArea = All;
                    Editable = IssueQtyEditable;
                }
                field("Balance Qty"; Rec."Balance Qty")
                {
                    ApplicationArea = All;
                    Editable = IssueQtyEditable;
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
    trigger OnAfterGetCurrRecord()
    var
        IndentHeader2: Record "SSD Indent Header2";
    begin
        IndentHeader2.SetRange("No.", Rec."Document No.");
        if IndentHeader2.FindFirst then begin
            if IndentHeader2.Post then IssueQtyEditable:=false
            else
                IssueQtyEditable:=true;
        end;
    end;
    trigger OnAfterGetRecord()
    var
        IndentHeader2: Record "SSD Indent Header2";
    begin
        IndentHeader2.SetRange("No.", Rec."Document No.");
        if IndentHeader2.FindFirst then begin
            if IndentHeader2.Post then IssueQtyEditable:=false
            else
                IssueQtyEditable:=true;
        end;
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        UserSetup: Record "User Setup";
    begin
        Rec.Type:=xRec.Type;
        if IndentHeader.Get(Rec."Document No.")then begin
            if xRec."Due Date" = 0D then Rec."Due Date":=IndentHeader."Due Date"
            else
                Rec."Due Date":=xRec."Due Date";
            Rec."Responsibility Center":=IndentHeader."Responsibility Center";
            Rec."Shortcut Dimension 1 Code":=IndentHeader."Shortcut Dimension 1 Code";
            Rec."Shortcut Dimension 2 Code":=IndentHeader."Shortcut Dimension 2 Code";
        end;
    end;
    var Item: Record Item;
    ItemAvailByDate: Page "Item Availability by Periods";
    ItemAvailByVar: Page "Item Availability by Variant";
    ItemAvailByLoc: Page "Item Availability by Location";
    Text001: label 'Change %1 from %2 to %3?';
    IndentHeader: Record "SSD Indent Header";
    Inventory: Decimal;
    IssueQtyEditable: Boolean;
    procedure ItemAvailability(AvailabilityType: Option Date, Variant, Location, Bin)
    begin
        Rec.TestField(Type, Rec.Type::"Fixed Asset");
        Rec.TestField("No.");
        Item.Reset;
        Item.Get(Rec."No.");
        Item.SetRange("No.", Rec."No.");
        Item.SetRange("Date Filter", 0D, Rec."Indent Date");
        case AvailabilityType of Availabilitytype::Date: begin
            Item.SetRange("Variant Filter", Rec."Variant Code");
            Clear(ItemAvailByDate);
            ItemAvailByDate.LookupMode(true);
            ItemAvailByDate.SetRecord(Item);
            ItemAvailByDate.SetTableview(Item);
            if ItemAvailByDate.RunModal = Action::LookupOK then if Rec."Indent Date" <> ItemAvailByDate.GetLastDate then if Confirm(Text001, true, Rec.FieldCaption("Indent Date"), Rec."Indent Date", ItemAvailByDate.GetLastDate)then Rec.Validate("Indent Date", ItemAvailByDate.GetLastDate);
        end;
        Availabilitytype::Variant: begin
            Clear(ItemAvailByVar);
            ItemAvailByVar.LookupMode(true);
            ItemAvailByVar.SetRecord(Item);
            ItemAvailByVar.SetTableview(Item);
            if ItemAvailByVar.RunModal = Action::LookupOK then if Rec."Variant Code" <> ItemAvailByVar.GetLastVariant then if Confirm(Text001, true, Rec.FieldCaption("Variant Code"), Rec."Variant Code", ItemAvailByVar.GetLastVariant)then Rec.Validate("Variant Code", ItemAvailByVar.GetLastVariant);
        end;
        Availabilitytype::Location: begin
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
