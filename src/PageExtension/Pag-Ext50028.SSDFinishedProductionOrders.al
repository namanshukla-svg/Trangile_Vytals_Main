PageExtension 50028 "SSD Finished Production Orders" extends "Finished Production Orders"
{
    layout
    {
        addafter(Description)
        {
            // field("Description 2"; Rec."Description 2") //IG_DS_Before
            // {
            //     ApplicationArea = All;
            // }
            field("Description2"; Rec."Description 2")
            {
                ApplicationArea = All;
                Caption = 'Description 2';
            }
            field("Creation Date"; Rec."Creation Date")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Output Date"; Rec."Output Date")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
    }
    actions
    {
        addafter("Production Order Statistics")
        {
            action(Print)
            {
                ApplicationArea = All;
                Caption = 'Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ProductionOrderLine: Record "Prod. Order Line";
                    JobCard: Report "Job Card/Production Card";
                begin
                    ProductionOrderLine.Reset;
                    ProductionOrderLine.SetRange(ProductionOrderLine."Prod. Order No.", Rec."No.");
                    JobCard.SetTableview(ProductionOrderLine);
                    JobCard.Run;
                end;
            }
            group("QR Code")
            {
                Caption = 'QR Code';

                action("Create QR Code")
                {
                    ApplicationArea = All;
                    Caption = 'Create QR Code';
                    Image = CreateDocument;

                    trigger OnAction()
                    var
                        Text001: label 'QR Code Created Successfully!';
                    begin
                        //CORP::PK >>>
                        QRCodeDetail.Reset;
                        if not QRCodeDetail.Find('+') then
                            BarCodeNoInt := 0
                        else
                            BarCodeNoInt := QRCodeDetail."Barcode No Integer";
                        I := 1;
                        ItemLedgerEntry.Reset;
                        ItemLedgerEntry.SetRange("Document No.", Rec."No.");
                        ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."entry type"::Output);
                        if ItemLedgerEntry.FindSet then begin
                            BarCodeNoInt += 1;
                            QRCodeDetail.Reset;
                            QRCodeDetail.SetRange("QR Code No.", ItemLedgerEntry."Document No." + '/' + Format(I));
                            if not QRCodeDetail.FindFirst then begin
                                BinCode := '';
                                WarehouseEntry.Reset;
                                WarehouseEntry.SetRange("Reference No.", ItemLedgerEntry."Document No.");
                                WarehouseEntry.SetRange("Item No.", ItemLedgerEntry."Item No.");
                                if WarehouseEntry.FindFirst then BinCode := WarehouseEntry."Bin Code";
                                QRCodeDetail.Init;
                                QRCodeDetail."QR Code No." := Rec."No." + '/' + Format(I); // '-' + COPYSTR("No.",8,11) +
                                QRCodeDetail."Lot No." := ItemLedgerEntry."Lot No.";
                                QRCodeDetail."MRN No." := Rec."No."; //ItemLedgerEntry."Document No.";
                                QRCodeDetail."MRN Date" := ItemLedgerEntry."Posting Date";
                                QRCodeDetail."Item Code" := ItemLedgerEntry."Item No.";
                                QRCodeDetail."Location Code" := ItemLedgerEntry."Location Code";
                                QRCodeDetail.UOM := ItemLedgerEntry."Unit of Measure Code";
                                QRCodeDetail."Expiration Date" := ItemLedgerEntry."Expiration Date";
                                QRCodeDetail."Barcode No Integer" := BarCodeNoInt;
                                QRCodeDetail."Creation Date" := Today;
                                QRCodeDetail."BIN Code" := BinCode;
                                QRCodeDetail.Quantity := ItemLedgerEntry.Quantity;
                                QRCodeDetail.Insert;
                                I += 1;
                            end;
                        end;
                        Message(Text001);
                        //CORP::PK <<<
                    end;
                }
                action("Print QR Code")
                {
                    ApplicationArea = All;
                    Caption = 'Print QR Code';
                    Image = BarCode;

                    trigger OnAction()
                    begin
                        QRCodeMgt.BarcodeForRPO(Rec); //CORP::PK >>>
                    end;
                }
            }
        }

    }
    trigger OnOpenPage()
    var
        ProductionOrder: Record "Production Order";
        ILE: Record "Item Ledger Entry";
    begin
        // ProductionOrder.Reset();
        // ProductionOrder.SetRange(Status, ProductionOrder.Status::Finished);
        // ProductionOrder.SetFilter("Output Date", '%1', 0D);
        // if ProductionOrder.FindFirst() then
        //     repeat
        //         ILE.Reset();
        //         ILE.SetRange("Document No.", ProductionOrder."No.");
        //         ILE.SetRange("Entry Type", ILE."Entry Type"::Output);
        //         if ILE.FindFirst() then begin
        //             ProductionOrder."Output Date" := ILE."Posting Date";
        //             ProductionOrder.Modify(true);
        //         end;
        //     until ProductionOrder.Next() = 0;
    end;

    var
        QRCodeDetail: Record "SSD QR Code Detail";
        BarCodeNoInt: Integer;
        I: Integer;
        ItemLedgerEntry: Record "Item Ledger Entry";
        QRCodeMgt: Codeunit "QR Code Mgt.";
        WarehouseEntry: Record "Warehouse Entry";
        BinCode: Code[20];
        ReceiptNo: Code[20];
}
