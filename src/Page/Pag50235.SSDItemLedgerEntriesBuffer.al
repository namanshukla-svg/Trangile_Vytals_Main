Page 50235 "SSD Item Ledger Entries Buffer"
{
    // ALLEAA CML-033 280308
    //   - Added New Form
    Caption = 'Item Ledger Entries';
    DataCaptionExpression = GetCaption;
    DataCaptionFields = "Item No.";
    PageType = List;
    SourceTable = "SSD Item Ledger Entry Buffer";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Subcon Order No."; Rec."Subcon Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Total Quantity';
                    Editable = false;
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Remaining Quantity"; Rec."Remaining Quantity")
                {
                    ApplicationArea = All;
                    Caption = 'Available Quantity';
                    Editable = false;
                }
                field(Apply; Rec.Apply)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    var Navigate: Page Navigate;
    procedure GetCaption(): Text[250]var
        GLSetup: Record "General Ledger Setup";
        ObjTransl: Record "Object Translation";
        Item: Record Item;
        ProdOrder: Record "Production Order";
        Cust: Record Customer;
        Vend: Record Vendor;
        Dimension: Record Dimension;
        DimValue: Record "Dimension Value";
        SourceTableName: Text[100];
        SourceFilter: Text[200];
        Description: Text[100];
    begin
        Description:='';
        case true of Rec.GetFilter("Item No.") <> '': begin
            SourceTableName:=ObjTransl.TranslateObject(ObjTransl."object type"::Table, 27);
            SourceFilter:=Rec.GetFilter("Item No.");
            if MaxStrLen(Item."No.") >= StrLen(SourceFilter)then if Item.Get(SourceFilter)then Description:=Item.Description;
        end;
        Rec.GetFilter("Prod. Order No.") <> '': begin
            SourceTableName:=ObjTransl.TranslateObject(ObjTransl."object type"::Table, 5405);
            SourceFilter:=Rec.GetFilter("Prod. Order No.");
            if MaxStrLen(ProdOrder."No.") >= StrLen(SourceFilter)then if ProdOrder.Get(ProdOrder.Status::Released, SourceFilter) or ProdOrder.Get(ProdOrder.Status::Finished, SourceFilter)then begin
                    SourceTableName:=StrSubstNo('%1 %2', ProdOrder.Status, SourceTableName);
                    Description:=ProdOrder.Description;
                end;
        end;
        Rec.GetFilter("Source No.") <> '': begin
            case Rec."Source Type" of Rec."source type"::Customer: begin
                SourceTableName:=ObjTransl.TranslateObject(ObjTransl."object type"::Table, 18);
                SourceFilter:=Rec.GetFilter("Source No.");
                if MaxStrLen(Cust."No.") >= StrLen(SourceFilter)then if Cust.Get(SourceFilter)then Description:=Cust.Name;
            end;
            Rec."source type"::Vendor: begin
                SourceTableName:=ObjTransl.TranslateObject(ObjTransl."object type"::Table, 23);
                SourceFilter:=Rec.GetFilter("Source No.");
                if MaxStrLen(Vend."No.") >= StrLen(SourceFilter)then if Vend.Get(SourceFilter)then Description:=Vend.Name;
            end;
            end;
        end;
        Rec.GetFilter("Global Dimension 1 Code") <> '': begin
            GLSetup.Get;
            Dimension.Code:=GLSetup."Global Dimension 1 Code";
            SourceFilter:=Rec.GetFilter("Global Dimension 1 Code");
            SourceTableName:=Dimension.GetMLName(GlobalLanguage);
            if MaxStrLen(DimValue.Code) >= StrLen(SourceFilter)then if DimValue.Get(GLSetup."Global Dimension 1 Code", SourceFilter)then Description:=DimValue.Name;
        end;
        Rec.GetFilter("Global Dimension 2 Code") <> '': begin
            GLSetup.Get;
            Dimension.Code:=GLSetup."Global Dimension 2 Code";
            SourceFilter:=Rec.GetFilter("Global Dimension 2 Code");
            SourceTableName:=Dimension.GetMLName(GlobalLanguage);
            if MaxStrLen(DimValue.Code) >= StrLen(SourceFilter)then if DimValue.Get(GLSetup."Global Dimension 2 Code", SourceFilter)then Description:=DimValue.Name;
        end;
        end;
        exit(StrSubstNo('%1 %2 %3', SourceTableName, SourceFilter, Description));
    end;
}
