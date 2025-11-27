Page 50152 "Warehouse Entry Creation."
{
    PageType = List;
    Permissions = TableData "Warehouse Entry"=rimd;
    SourceTable = "Warehouse Entry";
    SourceTableTemporary = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Journal Template Name"; Rec."Journal Template Name")
                {
                    ApplicationArea = All;
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Registering Date"; Rec."Registering Date")
                {
                    ApplicationArea = All;
                }
                field("Whse. Document No."; Rec."Whse. Document No.")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if Item.Get(Rec."Item No.")then Rec."Unit of Measure Code":=Item."Base Unit of Measure";
                    end;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec."Qty. (Base)":=Rec.Quantity;
                    end;
                }
                field("Qty. (Base)"; Rec."Qty. (Base)")
                {
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                }
                field("Reference No."; Rec."Reference No.")
                {
                    ApplicationArea = All;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
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
            action("&Create")
            {
                ApplicationArea = All;
                Caption = '&Create';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Are you sure want to Create Warehouse entry ?', true)then begin
                        WarehouseEntry2.Reset;
                        WarehouseEntry4.Reset;
                        WarehouseEntry4.FindLast;
                        WarehouseEntry2:=Rec;
                        WarehouseEntry2."Entry No.":=WarehouseEntry4."Entry No." + 1;
                        WarehouseEntry2.Insert;
                        Rec.Delete;
                    end;
                end;
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean begin
        Rec."Entry No.":=EntryNo + 1;
        EntryNo+=Rec."Entry No.";
    end;
    trigger OnOpenPage()
    begin
        WarehouseEntry2.Reset;
        WarehouseEntry2.FindLast;
        EntryNo:=WarehouseEntry2."Entry No.";
    end;
    var WarehouseEntry2: Record "Warehouse Entry";
    EntryNo: Integer;
    WarehouseEntry4: Record "Warehouse Entry";
    Item: Record Item;
}
