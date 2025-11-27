Page 50083 "Posted Gate In"
{
    // CMLTEST-026 AA 300108
    //   - Code Comment to block the unposted MRN and Delete Same MRN No.
    // CML-023 ALLEAG 270208 :
    //   - Disable the option of Undo Gate Entry in Menu button Posted Gate In.
    // CML-023 ALLEAG 280208 :
    //   - Written code to restrict the undo gate entry functionality against Posted Delivery Challan.
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Document;
    SourceTable = "SSD Posted Gate Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Address2; Rec.Address2)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Phone; Rec.Phone)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Telex; Rec.Telex)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Ref. Document Type"; Rec."Ref. Document Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Ref. Document No."; Rec."Ref. Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("ST38 No."; Rec."ST38 No.")
                {
                    ApplicationArea = All;
                    Caption = 'Page 31';
                    Editable = false;
                }
                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("MRN No."; Rec."MRN No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                }
                field("Purchase Invoice No."; Rec."Purchase Invoice No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
            }
            part(Control1000000001; "Posted Gate In SubForm")
            {
                SubPageLink = "Document No."=field("No.");
                ApplicationArea = All;
            }
            group(Information)
            {
                Caption = 'Information';
                Editable = false;

                field("Bill No."; Rec."Bill No.")
                {
                    ApplicationArea = All;
                }
                field("Bill Date"; Rec."Bill Date")
                {
                    ApplicationArea = All;
                }
                field("Bill Amount"; Rec."Bill Amount")
                {
                    ApplicationArea = All;
                }
                field("Register No."; Rec."Register No.")
                {
                    ApplicationArea = All;
                    Caption = 'Register Entry No.';
                }
                field("Register Entry Date"; Rec."Register Entry Date")
                {
                    ApplicationArea = All;
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ApplicationArea = All;
                }
                field("In Time"; Rec."In Time")
                {
                    ApplicationArea = All;
                }
            }
            group(Others)
            {
                Caption = 'Others';
                Editable = false;

                field("Vechile Type"; Rec."Vechile Type")
                {
                    ApplicationArea = All;
                }
                field("Mode of Transport"; Rec."Mode of Transport")
                {
                    ApplicationArea = All;
                }
                field("Transporter Name"; Rec."Transporter Name")
                {
                    ApplicationArea = All;
                }
                field("Transporter Bill No."; Rec."Transporter Bill No.")
                {
                    ApplicationArea = All;
                }
                field("Transporter Bill Date"; Rec."Transporter Bill Date")
                {
                    ApplicationArea = All;
                }
                field("Delivery Challan No."; Rec."Delivery Challan No.")
                {
                    ApplicationArea = All;
                }
                field("Delivery Challan Date"; Rec."Delivery Challan Date")
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
            group("Posted Gate In")
            {
                Caption = 'Posted Gate In';

                separator(Action1000000019)
                {
                }
                action("Unposted MRN")
                {
                    ApplicationArea = All;
                    Caption = 'Unposted MRN';

                    trigger OnAction()
                    var
                        FrmWarehouseReceipts: Page "Warehouse Receipts";
                        WHReceiptHeaderLocal: Record "Warehouse Receipt Header";
                        PostedGateLineLocal: Record "SSD Posted Gate Line";
                    begin
                        Clear(FrmWarehouseReceipts);
                        WHReceiptHeaderLocal.Reset;
                        PostedGateLineLocal.Reset;
                        PostedGateLineLocal.SetRange("Document No.", Rec."No.");
                        if PostedGateLineLocal.Find('-')then repeat if WHReceiptHeaderLocal.Get(PostedGateLineLocal."WH Receipt No.")then WHReceiptHeaderLocal.Mark(true);
                            until PostedGateLineLocal.Next = 0;
                        WHReceiptHeaderLocal.MarkedOnly(true);
                        FrmWarehouseReceipts.SetTableview(WHReceiptHeaderLocal);
                        FrmWarehouseReceipts.RunModal;
                    end;
                }
                action("Posted MRN")
                {
                    ApplicationArea = All;
                    Caption = 'Posted MRN';

                    trigger OnAction()
                    var
                        FrmWarehouseReceipts: Page "Posted Whse. Receipt List";
                        WHReceiptHeaderLocal: Record "Posted Whse. Receipt Header";
                        PostedGateLineLocal: Record "SSD Posted Gate Line";
                    begin
                        Clear(FrmWarehouseReceipts);
                        WHReceiptHeaderLocal.Reset;
                        PostedGateLineLocal.Reset;
                        PostedGateLineLocal.SetRange("Document No.", Rec."No.");
                        if PostedGateLineLocal.Find('-')then repeat WHReceiptHeaderLocal.SetRange("Whse. Receipt No.", PostedGateLineLocal."WH Receipt No.");
                                if WHReceiptHeaderLocal.Find('-')then WHReceiptHeaderLocal.Mark(true);
                            until PostedGateLineLocal.Next = 0;
                        WHReceiptHeaderLocal.MarkedOnly(true);
                        FrmWarehouseReceipts.SetTableview(WHReceiptHeaderLocal);
                        FrmWarehouseReceipts.RunModal;
                    end;
                }
                action("Undo Gate Entry")
                {
                    ApplicationArea = All;
                    Caption = 'Undo Gate Entry';

                    trigger OnAction()
                    begin
                        usersetup.Get(UserId);
                        usersetup.TestField(usersetup."Undo Gate Receipt");
                        //CML-023 ALLEAG 280208 Start
                        if Rec."Ref. Document Type" = Rec."ref. document type"::"Posted Delivery Challan" then Error(Text001);
                        //CML-023 ALLEAG 280208 Finish
                        if Confirm('Do you Want to Undo Posted Gate Entry')then begin
                            PostedWarehouseReceiptHeader.Reset;
                            PostedWarehouseReceiptHeader.SetRange(PostedWarehouseReceiptHeader."Gate Entry no.", Rec."No.");
                            if PostedWarehouseReceiptHeader.Find('-')then Error('You Can not Block Gate Entry Bcos MRN is already posted');
                            GateHeader.Init;
                            GateHeader.TransferFields(Rec);
                            GateHeader.Insert;
                            PGateLine.Reset;
                            PGateLine.SetRange("Document No.", Rec."No.");
                            if PGateLine.Find('-')then begin
                                repeat GateLine.Init;
                                    GateLine.TransferFields(PGateLine);
                                    GateLine.Insert until PGateLine.Next = 0;
                            end;
                            WarehouseReceiptHeader.Reset;
                            WarehouseReceiptHeader.SetRange("Gate Entry no.", Rec."No.");
                            if WarehouseReceiptHeader.Find('-')then //CMLTEST-026 AA 300108 Start
                                WarehouseReceiptHeader.Delete(true);
                            //CMLTEST-026 AA 300108 Finish
                            GateRegister.Reset;
                            GateRegister.SetRange("Gate Entry No.", Rec."No.");
                            GateRegister.DeleteAll;
                            PGateLine.DeleteAll;
                            Rec.Delete;
                        end;
                    end;
                }
            }
        }
    }
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
    var UserMgt: Codeunit "SSD User Setup Management";
    PostedWarehouseReceiptHeader: Record "Posted Whse. Receipt Header";
    PostedGateLine: Record "SSD Posted Gate Line";
    WarehouseReceiptHeader: Record "Warehouse Receipt Header";
    WarehouseReceiptLine: Record "Warehouse Receipt Line";
    GateHeader: Record "SSD Gate Header";
    GateLine: Record "SSD Gate Line";
    PGateLine: Record "SSD Posted Gate Line";
    GateRegister: Record "SSD Gate Register";
    Text001: label 'You can not Undo Gate Entry against the posted Delivery Challan.';
    usersetup: Record "User Setup";
}
