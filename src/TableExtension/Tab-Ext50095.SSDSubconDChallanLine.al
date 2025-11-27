TableExtension 50095 "SSD Subcon. DChallan Line" extends "Subcon. Delivery Challan Line"
{
    fields
    {
        field(50006; "Process Description"; Text[30])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Process Description';
        }
        field(50007; "Old Delivery Challan No."; Text[30])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Old Delivery Challan No.';
        }
        field(50008; "Old Delivery Challan Date"; Date)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Old Delivery Challan Date';
        }
        field(50010; "Ref. PO No."; Code[20])
        {
            Description = 'CF001';
            TableRelation = "Purchase Header"."No." where("Document Type"=const(Order), "Buy-from Vendor No."=field("Subcontractor No."), Subcontracting=const(true));
            DataClassification = CustomerContent;
            Caption = 'Ref. PO No.';
        }
        field(50011; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            Description = 'CF001';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(1));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(50012; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Description = 'CF001';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(2));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(50040; "OutPut Item Quantity"; Decimal)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'OutPut Item Quantity';
        }
        field(50041; "OutPut Item UOM"; Code[20])
        {
            Description = 'CF001';
            TableRelation = "Unit of Measure";
            DataClassification = CustomerContent;
            Caption = 'OutPut Item UOM';
        }
        field(50045; "Company Bin Code"; Code[20])
        {
            Caption = 'Company Bin Code';
            Description = 'CF001';
            TableRelation = "Bin Content"."Bin Code" where("Location Code"=field("Company Location"), "Item No."=field("Item No."), "Variant Code"=field("Variant Code"));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "Applies-to Entry":=0;
            end;
        }
        field(50046; "Vendor Bin Code"; Code[10])
        {
            Caption = 'Vendor Bin Code';
            Description = 'CF001';
            TableRelation = Bin.Code where("Location Code"=field("Vendor Location"), "Item Filter"=field("Item No."), "Variant Filter"=field("Variant Code"));
            DataClassification = CustomerContent;
        }
        field(50047; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50050; "Responsibility Center"; Code[20])
        {
            Description = 'CF001';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center';
        }
        field(50051; No2; Code[20])
        {
            Description = 'CGN005';
            DataClassification = CustomerContent;
            Caption = 'No2';
        }
    }
    procedure CheckforItemDuplication(SubconDeliveryChallanLine: Record "Subcon. Delivery Challan Line")
    var
        ItemNo: Code[20];
        DocumentNo: Code[20];
        LineNo: Integer;
        NoOfRecords: Integer;
    begin
        ItemNo:=SubconDeliveryChallanLine."Item No.";
        DocumentNo:=SubconDeliveryChallanLine."Document No.";
        LineNo:=SubconDeliveryChallanLine."Line No.";
        SubconDeliveryChallanLine.SetRange("Document No.", DocumentNo);
        SubconDeliveryChallanLine.SetRange("Item No.", ItemNo);
        SubconDeliveryChallanLine.SetFilter("Line No.", '<>%1', LineNo);
        NoOfRecords:=SubconDeliveryChallanLine.Count;
        if NoOfRecords >= 1 then Error('Item No. %1 already exist in the Delivery Challan %2', ItemNo, DocumentNo);
    end;
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
    /* // BIS 1145
        IF "Line No." <> 0 THEN
          DimMgt.SaveDocDim(
            DATABASE::"Subcon. Delivery Challan Line",1,"Document No.",
            "Line No.",FieldNumber,ShortcutDimCode)
        ELSE
          DimMgt.SaveTempDim(FieldNumber,ShortcutDimCode);
        */
    end;
}
