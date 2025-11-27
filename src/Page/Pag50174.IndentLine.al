Page 50174 "Indent Line"
{
    ApplicationArea = All;
    Editable = false;
    PageType = List;
    SourceTable = "SSD Indent Line";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Description 3"; Rec."Description 3")
                {
                    ToolTip = 'Specifies the value of the Description 3 field.', Comment = '%';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                }
                field("Qty. per Unit Of Measure"; Rec."Qty. per Unit Of Measure")
                {
                    ApplicationArea = All;
                }
                field("Unit Of Measure Code"; Rec."Unit Of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    ApplicationArea = All;
                }
                field("Indent Date"; Rec."Indent Date")
                {
                    ApplicationArea = All;
                }
                field("Expected Cost"; Rec."Expected Cost")
                {
                    ApplicationArea = All;
                }
                field("Inventory Main Store"; Rec."Inventory Main Store")
                {
                    ApplicationArea = All;
                }
                field("Capital Item"; Rec."Capital Item")
                {
                    ApplicationArea = All;
                }
                field("Qty. on Purchase Order"; Rec."Qty. on Purchase Order")
                {
                    ApplicationArea = All;
                }
                field("Qty. on Req. Line"; Rec."Qty. on Req. Line")
                {
                    ApplicationArea = All;
                }
                field("No.2"; Rec."No.2")
                {
                    ApplicationArea = All;
                }
                field("Template Name"; Rec."Template Name")
                {
                    ApplicationArea = All;
                }
                field("Batch Name"; Rec."Batch Name")
                {
                    ApplicationArea = All;
                }
                field("ROL-Maximum Order Quantity"; Rec."ROL-Maximum Order Quantity")
                {
                    ApplicationArea = All;
                }
                field("CL-Minimum Order Quantity"; Rec."CL-Minimum Order Quantity")
                {
                    ApplicationArea = All;
                }
                field("MSL-Safety Stock Quantity"; Rec."MSL-Safety Stock Quantity")
                {
                    ApplicationArea = All;
                }
                field("Shelf No."; Rec."Shelf No.")
                {
                    ApplicationArea = All;
                }
                field("Gen.Prod.Posting Group"; Rec."Gen.Prod.Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Indenter ID"; Rec."Indenter ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        //ALLE
        if CostCenterValue <> '' then begin
            Rec.CalcFields("Indenter ID");
            Rec.SetRange("Indenter ID", UserId);
            Rec.SetFilter("Shortcut Dimension 1 Code", CostCenterValue);
        end;
    //ALLE
    end;
    trigger OnOpenPage()
    begin
        Rec.SetFilter("Indent Date", '>%1', 20160331D);
        //ALLE
        MapUserDimension.Reset;
        MapUserDimension.SetRange(MapUserDimension."User Id", UserId);
        MapUserDimension.SetRange(MapUserDimension."Dimension Code", 'COSTCEN');
        if MapUserDimension.FindSet then repeat if CostCenterValue = '' then CostCenterValue:=MapUserDimension."Dimension Value"
                else
                    CostCenterValue+='|' + MapUserDimension."Dimension Value";
            until MapUserDimension.Next = 0;
        //ALLE
        if CostCenterValue <> '' then begin
            Rec.CalcFields("Indenter ID");
            Rec.SetRange("Indenter ID", UserId);
            Rec.SetFilter("Shortcut Dimension 1 Code", CostCenterValue);
        end;
    //ALLE
    end;
    var IndentHeader: Record "SSD Indent Header";
    MapUserDimension: Record "SSD Map User Dimension";
    CostCenterValue: Text;
}
