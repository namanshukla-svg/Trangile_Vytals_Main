Page 50188 "QR Printing"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    //PageType = Worksheet;
    PageType = List;
    CardPageId = "QR Printing Card";
    SourceTable = "SSD QR Printing";
    SourceTableView = sorting("QR Printing Type", "QR Printing Code")order(ascending);
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("QR Printing Type"; Rec."QR Printing Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("QR Printing Code"; Rec."QR Printing Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("QR Description"; Rec."QR Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("QR Images"; Rec."QR Images")
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;
                }
                field("Add Item QR Print"; Rec."Add Item QR Print")
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
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";

                action("Insert QR Printing")
                {
                    ApplicationArea = All;
                    Image = CopyRouteHeader;

                    trigger OnAction()
                    begin
                        InsertQRCodePrinting(GItemNo);
                    end;
                }
            }
        }
    }
    var GItemNo: Code[20];
    procedure InsertQRCodePrinting(ItemNo: Code[20])
    var
        Item: Record Item;
        QRPrintItemInfo: Record "SSD QR Prining info";
    begin
        Item.Get(GItemNo);
        //SETRANGE("QR Printing Type",QROption);
        Rec.SetRange("Add Item QR Print", true);
        if Rec.FindSet then repeat QRPrintItemInfo.Init;
                QRPrintItemInfo."QR Printing Type":=Rec."QR Printing Type";
                QRPrintItemInfo."QR Printing Code":=Rec."QR Printing Code";
                QRPrintItemInfo."Item No.":=Item."No.";
                QRPrintItemInfo."QR Description":=Rec."QR Description";
                QRPrintItemInfo.Insert;
            until Rec.Next = 0;
        Rec.ModifyAll("Add Item QR Print", false);
    end;
    trigger OnDeleteRecord(): Boolean begin
        Error('');
    end;
    procedure GetItem(ItemNo: Code[20])
    begin
        GItemNo:=ItemNo;
    end;
}
