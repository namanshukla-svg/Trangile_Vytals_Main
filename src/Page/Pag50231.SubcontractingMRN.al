Page 50231 "Subcontracting MRN"
{
    // CEN004.06 Rename the subform.
    // ALLEAA CML-033 280308
    //   - Added New Form
    // ALLEAA CML-033 190408
    //  - Code Added for Check Consumption QTY.
    // ALLEAA CML-033 250408
    //   - Code Added for Breakdown in Posting.
    // ALLEAA CML-033 290408
    //   - check open status and qty. consumed at the time of reopen or not.
    DeleteAllowed = true;
    InsertAllowed = false;
    PageType = Document;
    Permissions = TableData "Purch. Rcpt. Header"=rimd,
        TableData "Purch. Rcpt. Line"=rimd;
    RefreshOnActivate = true;
    SourceTable = "SSD RGP Header";
    SourceTableView = sorting(NRGP)order(ascending)where("Document Type"=filter("RGP Inbound"), NRGP=const(true), Subcontracting=const(true), Posted=const(false), "Subcon Posted"=const(false));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec)then CurrPage.Update;
                    end;
                }
                field("Party Type"; Rec."Party Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Party No."; Rec."Party No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Party Name"; Rec."Party Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Party Address"; Rec."Party Address")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Party City"; Rec."Party City")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bill Date"; Rec."Bill Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Gate Entry No."; Rec."Gate Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Expected Shipment Date"; Rec."Expected Shipment Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Caption = 'Subcontracting Location';
                }
                field("To Location"; Rec."To Location")
                {
                    ApplicationArea = All;
                    Caption = 'Company Location';
                }
                field("Delivery Challan No."; Rec."Delivery Challan No.")
                {
                    ApplicationArea = All;
                }
            }
            part(SubRGPHeader; "Subcon MRN Subform")
            {
                SubPageLink = "Document No."=field("No.");
            }
            group(Shipment)
            {
                Caption = 'Shipment';

                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                }
                field("Bill No."; Rec."Bill No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Receipt Remarks"; Rec."Receipt Remarks")
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
            group("&RGP Outbound")
            {
                Caption = '&RGP Outbound';

                action("LedgerEntries")
                {
                    ApplicationArea = All;
                    Caption = 'Ledger Entries';
                    RunObject = Page "RGP Ledger Entries";
                    RunPageLink = "Document Type"=field("Document Type"), "RGP Document No."=field("No.");
                    RunPageView = sorting("Document Type", "RGP Document No.", "RGP Line No.")order(ascending);
                }
                action(Shipments)
                {
                    ApplicationArea = All;
                    Caption = 'Shipments';
                    RunObject = Page "Posted RGP Shipment List";
                    RunPageLink = "Pre-Assigned No."=field("No.");
                }
                action(Receipts)
                {
                    ApplicationArea = All;
                    Caption = 'Receipts';
                    Image = PostedReceipts;
                    RunObject = Page "Posted Receipt List";
                    RunPageLink = "Pre-Assigned No."=field("No.");
                }
                action("Challan Input Item")
                {
                    ApplicationArea = All;
                    Caption = 'Challan Input Item';
                    RunObject = Page "Delivery Challan Subform";
                    RunPageLink = "Delivery Challan No."=field("Delivery Challan No.");
                    RunPageView = sorting("Delivery Challan No.", "Line No.");
                }
            }
            group("&Line")
            {
                Caption = '&Line';

                action("Ledger Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Ledger Entries';

                    trigger OnAction()
                    begin
                        ShowRGPLedger;
                    end;
                }
                action(DeliveryDetails)
                {
                    ApplicationArea = All;
                    Caption = 'DeliveryDetails';

                    trigger OnAction()
                    begin
                        if Rec.Status = Rec.Status::Open then Error('Release the document first');
                        //CurrForm.SubRGPHeader.FORM.CheckScrapDetail;
                        CurrPage.SubRGPHeader.Page.ShowItemLedgForm;
                    //CurrForm.SubRGPHeader.FORM.SelectItemEntry;
                    end;
                }
                action("Posted Consumption Details")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Consumption Details';
                    RunObject = Page "Item Ledger Entries";
                    RunPageLink = "Document No."=field("No.");
                    RunPageView = sorting("Document No.", "Posting Date")order(ascending);
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';

                action("Write Off")
                {
                    ApplicationArea = All;
                    Caption = '&Write Off';

                    trigger OnAction()
                    begin
                        //CurrForm.SubRGPHeader.FORM.LineWriteOff;
                        //*********CEN004.06***********
                        RgpLine.Reset;
                        RgpLine.SetRange(RgpLine."Document Type", Rec."Document Type");
                        RgpLine.SetRange(RgpLine."Document No.", Rec."No.");
                        if RgpLine.Find('-')then repeat RgpLine."Write Off":=true;
                                RgpLine.Modify;
                            until RgpLine.Next = 0;
                    //*********CEN004.06***********
                    end;
                }
                action(CreateNRGP)
                {
                    ApplicationArea = All;
                    Caption = 'Create NRGP';

                    trigger OnAction()
                    begin
                        if not Rec."NRGP Created From RGP" then CurrPage.SubRGPHeader.Page.CreateNRGP(Rec)
                        else
                            Error(Text000);
                    end;
                }
                separator(Action1000000070)
                {
                }
                action("Re&lease")
                {
                    ApplicationArea = All;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    begin
                        CurrPage.SubRGPHeader.Page.CheckScrapDetail;
                        Rec.Release;
                    end;
                }
                action("Re&open")
                {
                    ApplicationArea = All;
                    Caption = 'Re&open';
                    Image = ReOpen;

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        CurrPage.SubRGPHeader.Page.CheckWriteOff; //CEN004.06
                        //ALLEAA CML-033 290408 Start >>
                        RgpLine.Reset;
                        RgpLine.SetRange("Document Type", Rec."Document Type");
                        RgpLine.SetRange("Document No.", Rec."No.");
                        if RgpLine.FindFirst then repeat if RgpLine."Output Qty." <> 0 then Error(Text50001);
                            until RgpLine.Next = 0;
                        //ALLEAA CML-033 290408 End <<
                        Rec.Reopen;
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';

                action("P&ost")
                {
                    ApplicationArea = All;
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    var
                        ILE: Record "Item Ledger Entry";
                        WarehouseEmployee: Record "Warehouse Employee";
                    begin
                        Location.SetRange(Location."Use As In-Transit", true);
                        if not Location.FindFirst then Error(Text50000);
                        // ssd
                        WarehouseEmployee.Reset;
                        WarehouseEmployee.SetRange(WarehouseEmployee."User ID", UserId);
                        WarehouseEmployee.SetRange(WarehouseEmployee.Default, true);
                        WarehouseEmployee.SetFilter(WarehouseEmployee."Location Code", '<>%1', '');
                        if not WarehouseEmployee.FindFirst then Error('Please Select Location in Warehouse Employee Setup');
                        // ssd
                        RgpLine.Reset;
                        RgpLine.SetRange("Document Type", Rec."Document Type");
                        RgpLine.SetRange("Document No.", Rec."No.");
                        if RgpLine.FindFirst then repeat if RGPItem.Get(RgpLine."No.")then begin
                                    RGPItem.TestField(RGPItem."Inventory Posting Group");
                                    InventoryPostingSetup.Get(RgpLine."Location Code", RGPItem."Inventory Posting Group");
                                    InventoryPostingSetup.Get(RgpLine."New Location Code", RGPItem."Inventory Posting Group");
                                end;
                                if RgpLine."Generate Scrap" then if RGPItem.Get(RgpLine."Scrap Item")then begin
                                        RGPItem.TestField(RGPItem."Inventory Posting Group");
                                        InventoryPostingSetup.Get(RgpLine."Scrap Location", RGPItem."Inventory Posting Group");
                                    end;
                            until RgpLine.Next = 0;
                        if Rec."Shortcut Dimension 1 Code" = '' then Error('Please Enter Plant Code');
                        if Confirm('Do you want to Post Subcontracting MRN.')then begin
                            if not Rec."OutPut Post" then begin //ALLEAA CML-033 250408
                                RgpLine.Reset;
                                RgpLine.SetRange("Document Type", Rec."Document Type");
                                RgpLine.SetRange("Document No.", Rec."No.");
                                RgpLine.SetFilter("Quantity to Receive", '<>%1', 0);
                                if RgpLine.Find('-')then repeat if(RgpLine.Subcontracting = true) and ((RgpLine.NRGP = true))then //IF RgpLine."Quantity to Receive" <> RgpLine."Qty. Consumed" THEN //ALLEAA SUBMRN 190408
                                            if RgpLine."Quantity to Receive" <> RgpLine."Output Qty." then //ALLEAA SUBMRN 190408
 Error('First consume all the components on Line No. %1', RgpLine."Line No.");
                                    until RgpLine.Next = 0;
                                if not Rec."Scrap Posted" then //ALLEAA CML-033 250408
 CurrPage.SubRGPHeader.Page.InsertScrapJnlLine(Rec."External Document No.", Rec);
                                Rec."Scrap Posted":=true;
                                Rec.Modify;
                                Clear(RGPShipPost);
                                RGPShipPost.PostRGP(Rec);
                            end
                            else //ALLEAA CML-033 250408
                                PostTrasferOrder; //ALLEAA CML-033 250408
                        end;
                    end;
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //CF001 St
        Rec."Responsibility Center":=UserMgt.GetRespCenterFilter;
    //ERROR('You can not insert New No.');
    end;
    trigger OnOpenPage()
    begin
    //CF001 St
    // if UserMgt.GetRespCenterFilter <> '' then begin
    //     Rec.FilterGroup(2);
    //     Rec.SetRange("Responsibility Center", UserMgt.GetRespCenterFilter);
    //     Rec.FilterGroup(0);
    // end;
    //CF001 En
    end;
    var RGPShipPost: Report "RGP Post";
    UserSetup: Record "User Setup";
    UserMgt: Codeunit "SSD User Setup Management";
    RgpLine: Record "SSD RGP Line";
    Text000: label 'NRGP has already been created';
    ScrapItemJnlLine: Record "Item Journal Line";
    LineNo: Integer;
    DefaultDimension: Record "Default Dimension";
    TransferHeader: Record "Transfer Header";
    ReleaseTransferDocument: Codeunit "Release Transfer Document";
    TransferPostShipment: Codeunit "TransferOrder-Post Shipment";
    TransferPostReceipt: Codeunit "TransferOrder-Post Receipt";
    TransferOrderLines: Record "Transfer Line";
    GLSetup: Record "General Ledger Setup";
    Location: Record Location;
    Text50000: label 'Please define In - Transit Location in Location Card.';
    InventoryPostingSetup: Record "Inventory Posting Setup";
    RGPItem: Record Item;
    Text50001: label 'Consumption has been posted. \ You can''t open this document';
    procedure LineWriteOff()
    begin
        CurrPage.SubRGPHeader.Page.LineWriteOff;
    end;
    procedure ShowRGPLedger()
    begin
    //CurrForm.RGPLines.FORM.ShowRGPLedger;
    end;
    procedure PostLineDetail()
    begin
    end;
    procedure PostTrasferOrder()
    begin
        TransferHeader.SetRange(TransferHeader."No.", Rec."No.");
        if TransferHeader.FindFirst then begin
            if not TransferHeader."Shipment Posted" then begin
                ReleaseTransferDocument.Run(TransferHeader);
                TransferPostShipment.Run(TransferHeader);
            end;
            ReleaseTransferDocument.Reopen(TransferHeader);
            TransferOrderLines.SetRange("Document No.", TransferHeader."No.");
            if TransferOrderLines.FindFirst then repeat TransferOrderLines."Qty. to Receive":=TransferOrderLines."Quantity Shipped";
                    TransferOrderLines.Modify;
                until TransferOrderLines.Next = 0;
            ReleaseTransferDocument.Run(TransferHeader);
            TransferPostReceipt.Run(TransferHeader);
        end;
    end;
}
