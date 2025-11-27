Table 50008 "SSD CT2 Line"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "CT2 Document No."; Code[20])
        {
            Caption = 'CT2 Document No.';
            DataClassification = CustomerContent;
        }
        field(2; "CT2 Line No."; Integer)
        {
            Caption = 'CT2 Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "CT2 Customer No."; Code[20])
        {
            TableRelation = Customer;
            Caption = 'CT2 Customer No.';
            DataClassification = CustomerContent;
        }
        field(4; "CT2 Customer PO No."; Code[20])
        {
            Caption = 'CT2 Customer PO No.';
            DataClassification = CustomerContent;
        }
        field(5; "CT2 Customer PO Date"; Date)
        {
            Caption = 'CT2 Customer PO Date';
            DataClassification = CustomerContent;
        }
        field(6; "Item No."; Code[20])
        {
            TableRelation = Item;
            Caption = 'Item No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                GetCT2Header("CT2 Document No.");
                "CT2 Customer No.":=CT2Header."Customer No.";
                "CT2 Customer PO No.":=CT2Header."Customer PO No.";
                "CT2 Customer PO Date":=CT2Header."Customer PO Date";
                "CT2 Validate Date":=CT2Header."CT2 Validate Date";
                if ItemRec.Get("Item No.")then begin
                    Description:=ItemRec.Description;
                    "Description 2":=ItemRec."Description 2";
                    UOM:=ItemRec."Sales Unit of Measure";
                    "Qty. Per Unit Of Measure":=GetQtyPerUnitOfMeasure("Item No.", UOM);
                end;
            end;
        }
        field(7; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(8; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                CalcFields("Applied Qty", "Order Quantity", "Order Short Close Qty");
                if xRec.Quantity <> 0 then begin
                    if Quantity < ("Applied Qty" + "Order Quantity" - "Order Short Close Qty")then Error('Quantity can not be less than %1.', "Applied Qty" + "Order Quantity" - "Order Short Close Qty");
                    "Balance Quantity":=Quantity - "Applied Qty";
                end
                else
                begin
                    TestField("Applied Qty", 0);
                    TestField("Blanket Order Quantity", 0);
                    TestField("Order Quantity", 0);
                    TestField("Invoice Qty", 0);
                    /*Alle VPB Commented Temporary as per Zavenir Request

                    //ALLE 6.01
                    //IF (Quantity MOD "Qty. Per Unit Of Measure") <> 0 THEN
                    //  ERROR('Quantity Entered need to be the multiple of %1',"Qty. Per Unit Of Measure");
                    IF ItemRec.GET("Item No.") THEN BEGIN
                      IF ItemUOM.GET(ItemRec."No.",ItemRec."Base Unit of Measure") THEN BEGIN
                        //MESSAGE('%1',ROUND((ItemUOM."Qty. per Unit of Measure")/("Qty. per Unit of Measure"),1));
                        IF Quantity MOD ROUND((ItemUOM."Qty. per Unit of Measure")/("Qty. Per Unit Of Measure"),1) <> 0 THEN
                          ERROR('Quantity Entered need to be the multiple of %1',
                                    ROUND((ItemUOM."Qty. per Unit of Measure"/"Qty. Per Unit Of Measure"),1));
                      END;
                    END;
                    //ALLE 6.01
                    Alle VPB Commented Temporary as per Zavenir Request */
                    "Balance Quantity":=Quantity;
                end;
            end;
        }
        field(9; "Balance Quantity"; Decimal)
        {
            Caption = 'Balance Quantity';
            DataClassification = CustomerContent;
        }
        field(10; "Applied Qty"; Decimal)
        {
            CalcFormula = sum("Sales Invoice Line".Quantity where("CT2 Form"=field("CT2 Document No."), "CT2 Form Line No."=field("CT2 Line No."), "No."=field("Item No.")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Applied Qty';
        }
        field(11; UOM; Code[10])
        {
            Caption = 'UOM';
            DataClassification = CustomerContent;
        }
        field(12; "CT2 Validate Date"; Date)
        {
            Caption = 'CT2 Validate Date';
            DataClassification = CustomerContent;
        }
        field(13; "Blanket Order Quantity"; Decimal)
        {
            CalcFormula = sum("Sales Line".Quantity where("Document Type"=filter("Blanket Order"), "CT2 Form"=field("CT2 Document No."), "CT2 Form Line No."=field("CT2 Line No.")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Blanket Order Quantity';
        }
        field(14; "Order Quantity"; Decimal)
        {
            CalcFormula = sum("Sales Line".Quantity where("Document Type"=filter(Order), "CT2 Form"=field("CT2 Document No."), "CT2 Form Line No."=field("CT2 Line No."), "Document Subtype"=filter(Order)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Order Quantity';
        }
        field(15; "Invoice Qty"; Decimal)
        {
            CalcFormula = sum("Sales Line".Quantity where("Document Type"=filter(Invoice), "CT2 Form"=field("CT2 Document No."), "CT2 Form Line No."=field("CT2 Line No.")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Invoice Qty';
        }
        field(16; "Qty. Per Unit Of Measure"; Decimal)
        {
            Caption = 'Qty. Per Unit Of Measure';
            DataClassification = CustomerContent;
        }
        field(17; "Order Short Close Qty"; Decimal)
        {
            CalcFormula = sum("Sales Line"."Short Close Qty." where("Document Type"=filter(Order), "CT2 Form"=field("CT2 Document No."), "CT2 Form Line No."=field("CT2 Line No."), "Document Subtype"=filter(Order)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Order Short Close Qty';
        }
        field(18; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "CT2 Document No.", "CT2 Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        GetCT2Header("CT2 Document No.");
        CT2Header.TestField(Status, CT2Header.Status::" ");
        CalcFields("Invoice Qty", "Applied Qty", "Order Quantity", "Blanket Order Quantity", "Order Short Close Qty");
        TestField("Applied Qty", 0);
        TestField("Blanket Order Quantity", 0);
        TestField("Order Quantity", 0);
        TestField("Invoice Qty", 0);
    end;
    trigger OnInsert()
    begin
        GetCT2Header("CT2 Document No.");
        CT2Header.TestField(Status, CT2Header.Status::" ")end;
    trigger OnModify()
    begin
        GetCT2Header("CT2 Document No.");
        CT2Header.TestField(Status, CT2Header.Status::" ")end;
    var ItemRec: Record Item;
    CT2Header: Record "SSD CT2 Header";
    Item: Record Item;
    ItemUnitOfMeasure: Record "Item Unit of Measure";
    ItemUOM: Record "Item Unit of Measure";
    procedure GetCT2Header(DocNo: Code[20])
    begin
        if CT2Header.Get(DocNo)then begin
            CT2Header.TestField("Customer No.");
            CT2Header.TestField("Customer PO No.");
            CT2Header.TestField("Customer PO Date");
            CT2Header.TestField("CT2 Validate Date");
            CT2Header.TestField(Status, CT2Header.Status::" ");
        end;
    end;
    procedure GetQtyPerUnitOfMeasure(ItemNo: Code[20]; UnitOfMeasureCode: Code[10]): Decimal begin
        Item.Get(ItemNo);
        if UnitOfMeasureCode in[Item."Base Unit of Measure", '']then exit(1);
        if(Item."No." <> ItemUnitOfMeasure."Item No.") or (UnitOfMeasureCode <> ItemUnitOfMeasure.Code)then ItemUnitOfMeasure.Get(Item."No.", UnitOfMeasureCode);
        ItemUnitOfMeasure.TestField("Qty. per Unit of Measure");
        exit(ItemUnitOfMeasure."Qty. per Unit of Measure");
    end;
}
