TableExtension 50117 "SSD Warehouse Shipment Line" extends "Warehouse Shipment Line"
{
    fields
    {
        modify("Qty. to Ship")
        {
            trigger OnAfterValidate()
            var
                SalesHeader: Record "Sales Header";
            begin
                SalesHeader.Reset();
                SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                SalesHeader.SetRange("No.", Rec."Source No.");
                SalesHeader.SetRange("Hold-Dispatch", true);
                if SalesHeader.FindFirst() then
                    Error('Sales Order %1 is on Hold for Dispatch.', SalesHeader."No.");
            end;
        }
        field(50050; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Description = 'CF001';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
        }
        field(50051; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            Description = 'CF001';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            DataClassification = CustomerContent;
        }
        field(50052; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Description = 'CF001';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            DataClassification = CustomerContent;
        }
    }
    trigger OnAfterInsert()
    begin
        WHShipmentHeader.GET("No.");
        "Responsibility Center" := WhseShptHeader."Responsibility Center";
    end;

    var
        WHShipmentHeader: Record "Warehouse Shipment Header";
}
