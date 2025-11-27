TableExtension 50059 "SSD Production Order" extends "Production Order"
{
    fields
    {
        field(50000; "Variance Cause"; Option)
        {
            Description = 'Alle 15022021';
            OptionCaption = ' ,DN-PPC,DN-PPC YIELD,DN-BOM,DN-SALES,DN-SUBCON,DN-QA,DN-VENDOR,NO LOSS,NOTIONAL-SCM,DN-TS/PMM,NOTIONAL-GENERAL';
            OptionMembers = " ","DN-PPC","DN-PPC YIELD","DN-BOM","DN-SALES","DN-SUBCON","DN-QA","DN-VENDOR","NO LOSS","NOTIONAL-SCM","DN-TS/PMM","NOTIONAL-GENERAL";
            DataClassification = CustomerContent;
            Caption = 'Variance Cause';
        }
        field(50001; Remarks; Text[100])
        {
            Description = 'Alle 23062021';
            DataClassification = CustomerContent;
            Caption = 'Remarks';
        }
        field(50010; Reprocess; Boolean)
        {
            Description = 'QLT';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Reprocess';
        }
        field(50011; "Source Doc. No."; Code[20])
        {
            Description = 'QLT';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Source Doc. No.';
        }
        field(50012; "Item Entry Source No."; Integer)
        {
            Description = 'QLT';
            Editable = false;
            TableRelation = "Item Ledger Entry";
            DataClassification = CustomerContent;
            Caption = 'Item Entry Source No.';
        }
        field(50056; "Req Generated"; Boolean)
        {
            Description = 'ALLE3.26';
            DataClassification = CustomerContent;
            Caption = 'Req Generated';
        }
        field(50057; "Finished Qty."; Decimal)
        {
            CalcFormula = lookup("Prod. Order Line"."Finished Quantity" where(Status = field(Status), "Prod. Order No." = field("No."), "Item No." = field("Source No.")));
            FieldClass = FlowField;
            Caption = 'Finished Qty.';
        }
        field(50058; Closed; Boolean)
        {
            Description = 'ALLE[5.51] dated-27-6-13';
            DataClassification = CustomerContent;
            Caption = 'Closed';
        }
        field(50059; "Sales Order No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Sales Order No.';
        }
        field(50060; "No. of Archived Version"; Integer)
        {
            CalcFormula = max("SSD Production Order Archive"."Version No." where(Status = field(Status), "No." = field("No.")));
            FieldClass = FlowField;
            Caption = 'No. of Archived Version';
        }
        field(54040; "Order Created from MRP"; Boolean)
        {
            Description = 'ALLE';
            DataClassification = CustomerContent;
            Caption = 'Order Created from MRP';
        }
        field(54041; "Manufacturing Date"; Date)
        {
            Description = 'Alle - 221020';
            DataClassification = CustomerContent;
            Caption = 'Manufacturing Date';
        }
        field(54042; "Output Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Output Date';
            Editable = false;
        }
    }
    trigger OnAfterInsert()
    begin
        "Assigned User ID" := UserId;
    end;
}
