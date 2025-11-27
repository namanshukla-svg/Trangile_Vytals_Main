Page 50213 "Item Ledger Entries For QR Cod"
{
    Caption = 'Item Ledger Entries For QR Cod';
    DataCaptionFields = "Item No.";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Item Ledger Entry";
    SourceTableView = where("Order Type"=filter(Production), "Entry Type"=filter(Output));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Document Line No."; Rec."Document Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Invoiced Quantity"; Rec."Invoiced Quantity")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Remaining Quantity"; Rec."Remaining Quantity")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Reserved Quantity"; Rec."Reserved Quantity")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Open; Rec.Open)
                {
                    ApplicationArea = All;
                }
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Order Line No."; Rec."Order Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Prod. Order Comp. Line No."; Rec."Prod. Order Comp. Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Inv. Lot Scanned"; Rec."Inv. Lot Scanned")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
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
                        ProdOrderLine: Record "Prod. Order Line";
                        Desc: Text;
                    begin
                        //CORP::PK 200719 >>>
                        Desc:='';
                        ProdOrderLine.Reset;
                        ProdOrderLine.SetRange("Prod. Order No.", Rec."Document No.");
                        ProdOrderLine.SetRange("Item No.", Rec."Item No.");
                        if ProdOrderLine.FindFirst then Desc:=ProdOrderLine.Description + ' ' + ProdOrderLine."Description 2";
                        QRCodeDetail.Reset;
                        if not QRCodeDetail.Find('+')then BarCodeNoInt:=0
                        else
                            BarCodeNoInt:=QRCodeDetail."Barcode No Integer";
                        I:=1;
                        BarCodeNoInt+=1;
                        QRCodeDetail.Reset;
                        QRCodeDetail.SetRange("QR Code No.", ItemLedgerEntry."Document No." + '/' + Format(I));
                        if not QRCodeDetail.FindFirst then begin
                            BinCode:='';
                            WarehouseEntry.Reset;
                            WarehouseEntry.SetRange("Reference No.", Rec."Document No.");
                            WarehouseEntry.SetRange("Item No.", Rec."Item No.");
                            if WarehouseEntry.FindFirst then BinCode:=WarehouseEntry."Bin Code";
                            QRCodeDetail.Init;
                            QRCodeDetail."QR Code No.":=Rec."Document No." + '/' + Format(I);
                            QRCodeDetail."Lot No.":=Rec."Lot No.";
                            QRCodeDetail."MRN No.":=Rec."Document No.";
                            QRCodeDetail."MRN Date":=Rec."Posting Date";
                            QRCodeDetail."Item Code":=Rec."Item No.";
                            QRCodeDetail."Item Description":=Desc;
                            QRCodeDetail."Location Code":=Rec."Location Code";
                            QRCodeDetail.UOM:=Rec."Unit of Measure Code";
                            QRCodeDetail."Expiration Date":=Rec."Expiration Date";
                            QRCodeDetail."Barcode No Integer":=BarCodeNoInt;
                            QRCodeDetail."Creation Date":=Today;
                            QRCodeDetail."BIN Code":=BinCode;
                            QRCodeDetail.Quantity:=Rec.Quantity;
                            QRCodeDetail.Insert;
                            I+=1;
                        end;
                        Message(Text001);
                    //CORP::PK 200719 <<<
                    end;
                }
                action("Print QR Code")
                {
                    ApplicationArea = All;
                    Caption = 'Print QR Code';
                    Image = BarCode;

                    trigger OnAction()
                    begin
                        QRCodeMgt.BarcodeForILE(Rec); //CORP::PK 200719
                    end;
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
    end;
    var "--------CS------------": Integer;
    QRCodeDetail: Record "SSD QR Code Detail";
    BarCodeNoInt: Integer;
    I: Integer;
    ItemLedgerEntry: Record "Item Ledger Entry";
    QRCodeMgt: Codeunit "QR Code Mgt.";
    WarehouseEntry: Record "Warehouse Entry";
    BinCode: Code[20];
    ReceiptNo: Code[20];
}
