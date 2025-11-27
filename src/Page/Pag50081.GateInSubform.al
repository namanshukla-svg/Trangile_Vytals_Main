Page 50081 "Gate In Subform"
{
    // //CF001.01 For Responsibility Center
    // //CF001.02 16.03.2006 for subcontractor
    // //CEN003 Gate Inbound
    // //CEN004.05 For Autometic RGp Inbound
    // CML-023 ALLEAG 270207 :
    //   - Written code to make the challan quantity in case of Ref. Document type as Posted Delivery Challan.
    // ALLEAA CML-033 280308
    //   - Added Code for SUBCON MRN
    // ALLEAA CML-033 310308
    //   - Code Written for set Editable Mode.
    // ALLEAA CML-033 230408
    //   - Flow dimension in Subcon MRN
    // 
    // SSD-0001 Short Close lines filtered
    // ALLE-TRA1.0 - Code added to flow CustomerNo. & Salesperson code in Gate Line
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "SSD Gate Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("No. 2"; Rec."No. 2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Vendor Item Description"; Rec."Vendor Item Description")
                {
                    ToolTip = 'Specifies the value of the Vendor Item Description field.';
                    Editable = false;
                }
                field(Width; Rec.Width)
                {
                    ApplicationArea = All;
                }
                field(Length; Rec.Length)
                {
                    ApplicationArea = All;
                }
                field(Thickness; Rec.Thickness)
                {
                    ApplicationArea = All;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Unit of Measure"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Challan Quantity"; Rec."Challan Quantity")
                {
                    ApplicationArea = All;
                    DecimalPlaces = 1 : 4;

                    trigger OnValidate()
                    var
                        GateHeaderLocal: Record "SSD Gate Header";
                    begin
                        //CF002 St
                        GateHeaderLocal.Get(Rec."Document No.");
                        if not (GateHeaderLocal."Ref. Document Type" = GateHeaderLocal."ref. document type"::Other) then if Rec."Challan Quantity" > Rec."Outstandiing Quantity" then Error(Error0001, Rec."Outstandiing Quantity");
                        //CF002 En
                    end;
                }
                field("Total Quantity"; Rec."Total Quantity")
                {
                    ApplicationArea = All;
                }
                field("Outstandiing Quantity"; Rec."Outstandiing Quantity")
                {
                    ApplicationArea = All;
                }
                field("Posted Actual Quantity"; Rec."Posted Actual Quantity")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    var
        "ShortageQty.": Decimal;
        Error0001: label 'Challan Quantity cann''''t be more than %1';
        RecGateHeader: Record "SSD Gate Header";
        GateSetup: Record "SSD AddOn Setup";
        GateHeader: Record "SSD Gate Header";
        Text000: label 'RGP Inbound No. %1 has been created.';
        Text0001: label 'Ref. Document Type should be Subcontracting or RGP Inbound';
        DeliveryChallanHeader: Record "Delivery Challan Header";
        Text50000: label 'Already Consumed...';

    procedure InsertGateLines(var GateHeader: Record "SSD Gate Header")
    var
        PurchLine: Record "Purchase Line";
        GateEntryLine: Record "SSD Gate Line";
        RGPLine: Record "SSD RGP Line";
        WHReceiptLineLocal: Record "Warehouse Receipt Line";
        TotalRcptQty: Decimal;
        PurchaseHeaderLocal: Record "Purchase Header";
        SalesLine: Record "Sales Line";
        DeliveryChallanLine: Record "Delivery Challan Line";
        DCRemainQty: Decimal;
        Item: Record Item;
        TransferHeader: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
    begin
        //Purchase Invoice
        case GateHeader."Ref. Document Type" of
            GateHeader."ref. document type"::"Purchase Order", GateHeader."ref. document type"::"Purchase Schedule", GateHeader."ref. document type"::Subcontracting: //added 5.51 and changes code for subcontracting
                begin
                    PurchLine.SetRange("Document Type", PurchLine."document type"::Order);
                    if GateHeader."Ref. Document Type" = GateHeader."ref. document type"::Subcontracting then begin
                        if DeliveryChallanHeader.Get(GateHeader."Ref. Document No.") then PurchLine.SetRange("Document No.", DeliveryChallanHeader."Sub. order No.");
                    end
                    else begin
                        PurchLine.SetRange("Document No.", GateHeader."Ref. Document No.");
                    end;
                    PurchLine.SetRange(Type, PurchLine.Type::Item, PurchLine.Type::"Fixed Asset"); //5.51 added FA
                    PurchLine.SetRange("Short Closed", false); //Alle VPB
                                                               //PurchLine.SETRANGE(PurchLine."Posted Short Close",FALSE);//SSD Short Close
                    if PurchLine.Find('-') then begin
                        repeat
                            PurchLine.CalcFields("Total Posted Gate Challan Qty", "Total Gate Challan Qty");
                            if (PurchLine.Quantity > (PurchLine."Total Posted Gate Challan Qty" + PurchLine."Total Gate Challan Qty")) or (PurchLine.Quantity = (PurchLine."Total Posted Gate Challan Qty" + PurchLine."Total Gate Challan Qty")) then begin
                                GateEntryLine.Init;
                                GateEntryLine."Document No." := GateHeader."No.";
                                GateEntryLine."Line No." := PurchLine."Line No.";
                                GateEntryLine."Party Type" := GateHeader."Party Type";
                                GateEntryLine."Party No." := GateHeader."Party No.";
                                GateEntryLine."Ref. Document Type" := GateHeader."Ref. Document Type";
                                GateEntryLine."Ref. Document No." := GateHeader."Ref. Document No.";
                                GateEntryLine."Ref. Document Line No." := PurchLine."Line No.";
                                GateEntryLine.Type := PurchLine.Type; // GateEntryLine.Type::Item;5.51
                                GateEntryLine."No." := PurchLine."No.";
                                GateEntryLine.Description := PurchLine.Description;
                                GateEntryLine."Description 2" := PurchLine."Description 2";
                                GateEntryLine."Expected Receipt Date" := PurchLine."Expected Receipt Date";
                                GateEntryLine."Unit of Measure Code" := PurchLine."Unit of Measure Code";
                                GateEntryLine."Customer No." := PurchLine."Customer No."; //ALLE-TRA1.0
                                GateEntryLine."SalesPerson Code" := PurchLine."SalesPerson Code"; //ALLE-TRA1.0
                                                                                                  //ALLE-AT >>
                                GateEntryLine."Vendor Item Description" := PurchLine."Vendor Item Description"; //Sunil
                                if GateEntryLine.Type = GateEntryLine.Type::Item then begin
                                    Item.Get(GateEntryLine."No.");
                                    GateEntryLine."Description 3" := PurchLine."Description 3";
                                end;
                                //ALLE-AT <<
                                //CF001.02 St
                                if not PurchLine.Subcontracting then begin
                                    GateEntryLine."Outstandiing Quantity" := Rec."Outstandiing Quantity";
                                    GateEntryLine."Total Quantity" := (PurchLine.Quantity - PurchLine."Total Gate Challan Qty");
                                    GateEntryLine."Outstandiing Quantity" := GateEntryLine."Total Quantity";
                                end
                                else begin
                                    PurchLine.CalcFields("Total Delivery Challan Qty");
                                    GateEntryLine."Outstandiing Quantity" := PurchLine."Outstanding Quantity";
                                    GateEntryLine."Total Quantity" := (PurchLine.Quantity - PurchLine."Total Gate Challan Qty");
                                end;
                                if GateEntryLine."Total Quantity" < 0 then GateEntryLine."Total Quantity" := 0;
                                GateEntryLine."Challan Quantity" := 0;
                                GateEntryLine."Direct Unit Cost" := PurchLine."Direct Unit Cost"; //ALLE-AT
                                GateEntryLine.Insert;
                                //CF001.01 En
                            end;
                        until PurchLine.Next = 0;
                        //CF001.02 St
                        ///***** Modify For Gate Header Subcontracting **************
                        if PurchaseHeaderLocal.Get(PurchaseHeaderLocal."document type"::Order, GateHeader."Ref. Document No.") then begin
                            GateHeader.Trading := PurchaseHeaderLocal.Trading;
                            GateHeader.Subcontracting := PurchaseHeaderLocal.Subcontracting;
                            GateHeader.Modify;
                        end;
                        //CF001.02 En
                    end;
                end;
            //CML-023 DKU180208 Start
            GateHeader."ref. document type"::"Posted Delivery Challan":
                begin
                    DeliveryChallanLine.SetRange(DeliveryChallanLine."Delivery Challan No.", GateHeader."Ref. Document No.");
                    if DeliveryChallanLine.FindFirst then begin
                        repeat
                            DeliveryChallanLine.CalcFields(DeliveryChallanLine."Remaining Quantity");
                            DCRemainQty := DeliveryChallanLine."Remaining Quantity";
                            if DCRemainQty > 0 then begin
                                GateEntryLine.Init;
                                GateEntryLine."Document No." := GateHeader."No.";
                                GateEntryLine."Line No." := DeliveryChallanLine."Line No.";
                                GateEntryLine."Party Type" := GateHeader."Party Type";
                                GateEntryLine.Validate(GateEntryLine."Party No.", GateHeader."Party No.");
                                GateEntryLine."Ref. Document Type" := GateHeader."ref. document type"::"Posted Delivery Challan";
                                GateEntryLine."Ref. Document No." := GateHeader."Ref. Document No.";
                                GateEntryLine."Ref. Document Line No." := DeliveryChallanLine."Line No.";
                                GateEntryLine.Type := GateEntryLine.Type::Item;
                                GateEntryLine."No." := DeliveryChallanLine."Item No.";
                                GateEntryLine.Description := DeliveryChallanLine.Description;
                                GateEntryLine."Expected Receipt Date" := DeliveryChallanLine."Return Date";
                                GateEntryLine."Unit of Measure Code" := DeliveryChallanLine."Unit of Measure";
                                GateEntryLine."Total Quantity" := DeliveryChallanLine.Quantity;
                                //GateEntryLine."Challan Quantity" := DCRemainQty;
                                GateEntryLine."Challan Quantity" := 0; //CML-023 ALLEAG 270207
                                GateEntryLine."Outstandiing Quantity" := DCRemainQty;
                                GateEntryLine.Insert;
                            end;
                        until DeliveryChallanLine.Next = 0;
                    end;
                end;
            //CML-023 DKU180208 Finish
            //Transfer Order Begin
            GateHeader."ref. document type"::"Transfer Order":
                begin
                    TransferLine.SetRange("Document No.", GateHeader."Ref. Document No.");
                    if TransferLine.Find('-') then begin
                        repeat
                            if TransferLine."Quantity Shipped" <> 0 then begin
                                GateEntryLine.Init;
                                GateEntryLine."Document No." := GateHeader."No.";
                                GateEntryLine."Line No." := TransferLine."Line No.";
                                GateEntryLine."Party Type" := GateHeader."Party Type";
                                GateEntryLine."Party No." := GateHeader."Party No.";
                                GateEntryLine."Ref. Document Type" := GateHeader."Ref. Document Type";
                                GateEntryLine."Ref. Document No." := GateHeader."Ref. Document No.";
                                GateEntryLine."Ref. Document Line No." := TransferLine."Line No.";
                                GateEntryLine.Type := GateEntryLine.Type::Item;
                                GateEntryLine."No." := TransferLine."Item No.";
                                GateEntryLine.Description := TransferLine.Description;
                                GateEntryLine."Description 2" := TransferLine."Description 2";
                                GateEntryLine."Outstandiing Quantity" := TransferLine.Quantity - TransferLine."Quantity Shipped";
                                GateEntryLine."Unit of Measure Code" := TransferLine."Unit of Measure Code";
                                GateEntryLine."Total Quantity" := TransferLine.Quantity;
                                GateEntryLine.CalcFields("Posted Challan Quantity");
                                //IF GateEntryLine."Total Quantity" - GateEntryLine."Posted Challan Quantity" > 0 THEN
                                GateEntryLine.Insert;
                            end;
                        until TransferLine.Next = 0;
                    end;
                end;
            //Transfer Order End
            //RGP Inbound Begin
            GateHeader."ref. document type"::"RGP Inbound":
                begin
                    RGPLine.SetRange("Document Type", RGPLine."document type"::"RGP Inbound");
                    RGPLine.SetRange("Document No.", GateHeader."Ref. Document No.");
                    if RGPLine.Find('-') then begin
                        repeat
                            if RGPLine."Quantity Received" <> 0 then begin
                                GateEntryLine.Init;
                                GateEntryLine."Document No." := GateHeader."No.";
                                GateEntryLine."Line No." := RGPLine."Line No.";
                                GateEntryLine."Party Type" := GateHeader."Party Type";
                                GateEntryLine."Party No." := GateHeader."Party No.";
                                GateEntryLine."Ref. Document Type" := GateHeader."Ref. Document Type";
                                GateEntryLine."Ref. Document No." := GateHeader."Ref. Document No.";
                                GateEntryLine."Ref. Document Line No." := RGPLine."Line No.";
                                case RGPLine.Type of
                                    RGPLine.Type::Item:
                                        GateEntryLine.Type := GateEntryLine.Type::Item;
                                    RGPLine.Type::"Item Description":
                                        GateEntryLine.Type := GateEntryLine.Type::" ";
                                    RGPLine.Type::"Fixed Asset":
                                        GateEntryLine.Type := GateEntryLine.Type::"Fixed Asset";
                                end;
                                GateEntryLine."No." := RGPLine."No.";
                                GateEntryLine.Description := RGPLine.Description;
                                GateEntryLine."Description 2" := RGPLine."Description 2";
                                GateEntryLine."Outstandiing Quantity" := RGPLine.Quantity - RGPLine."Outstanding Rcpt. Quantity";
                                GateEntryLine."Unit of Measure Code" := RGPLine."Unit Of Measure Code";
                                GateEntryLine."Total Quantity" := RGPLine.Quantity;
                                GateEntryLine.CalcFields("Posted Challan Quantity");
                                if GateEntryLine."Total Quantity" - GateEntryLine."Posted Challan Quantity" > 0 then GateEntryLine.Insert;
                            end;
                        until RGPLine.Next = 0;
                    end;
                end;
            //RGP Inbound End
            // RGP Outbound
            GateHeader."ref. document type"::"RGP Outbound":
                begin
                    RGPLine.SetRange("Document Type", RGPLine."document type"::"RGP Outbound");
                    RGPLine.SetRange("Document No.", GateHeader."Ref. Document No.");
                    if PurchLine.Find('-') then begin
                        repeat
                            if RGPLine."Quantity Shipped" <> 0 then begin
                                GateEntryLine.Init;
                                GateEntryLine."Document No." := GateHeader."No.";
                                GateEntryLine."Line No." := RGPLine."Line No.";
                                GateEntryLine."Party Type" := GateHeader."Party Type";
                                GateEntryLine."Party No." := GateHeader."Party No.";
                                GateEntryLine."Ref. Document Type" := GateHeader."Ref. Document Type";
                                GateEntryLine."Ref. Document No." := GateHeader."Ref. Document No.";
                                GateEntryLine."Ref. Document Line No." := RGPLine."Line No.";
                                case RGPLine.Type of
                                    RGPLine.Type::Item:
                                        GateEntryLine.Type := GateEntryLine.Type::Item;
                                    RGPLine.Type::"Item Description":
                                        GateEntryLine.Type := GateEntryLine.Type::" ";
                                    RGPLine.Type::"Fixed Asset":
                                        GateEntryLine.Type := GateEntryLine.Type::"Fixed Asset";
                                end;
                                GateEntryLine."No." := RGPLine."No.";
                                GateEntryLine.Description := RGPLine.Description;
                                GateEntryLine."Description 2" := RGPLine."Description 2";
                                GateEntryLine."Outstandiing Quantity" := RGPLine."Outstanding Rcpt. Quantity";
                                GateEntryLine."Unit of Measure Code" := RGPLine."Unit Of Measure Code";
                                GateEntryLine."Total Quantity" := RGPLine.Quantity;
                                GateEntryLine.CalcFields("Posted Challan Quantity");
                                if GateEntryLine."Total Quantity" - GateEntryLine."Posted Challan Quantity" > 0 then GateEntryLine.Insert;
                            end;
                        until RGPLine.Next = 0;
                    end;
                end;
            GateHeader."ref. document type"::"Sales Returns":
                begin
                    SalesLine.Reset;
                    SalesLine.SetRange("Document Type", SalesLine."document type"::"Return Order");
                    SalesLine.SetRange("Document No.", GateHeader."Ref. Document No.");
                    SalesLine.SetRange(Type, SalesLine.Type::Item);
                    if SalesLine.Find('-') then begin
                        repeat
                            SalesLine.CalcFields("Total Posted Gate Challan Qty", "Total Gate Challan Qty");
                            if SalesLine.Quantity > (SalesLine."Total Posted Gate Challan Qty" + SalesLine."Total Gate Challan Qty") then begin
                                GateEntryLine.Init;
                                GateEntryLine."Document No." := GateHeader."No.";
                                GateEntryLine."Line No." := SalesLine."Line No.";
                                GateEntryLine."Party Type" := GateHeader."Party Type";
                                GateEntryLine."Party No." := GateHeader."Party No.";
                                GateEntryLine."Ref. Document Type" := GateHeader."Ref. Document Type";
                                GateEntryLine."Ref. Document No." := GateHeader."Ref. Document No.";
                                GateEntryLine."Ref. Document Line No." := SalesLine."Line No.";
                                GateEntryLine.Type := GateEntryLine.Type::Item;
                                GateEntryLine."No." := SalesLine."No.";
                                GateEntryLine.Description := SalesLine.Description;
                                GateEntryLine."Description 2" := SalesLine."Description 2";
                                //GateEntryLine."Expected Receipt Date" := SalesLine."Expected Receipt Date";
                                GateEntryLine."Unit of Measure Code" := SalesLine."Unit of Measure Code";
                                GateEntryLine."Outstandiing Quantity" := Rec."Outstandiing Quantity";
                                GateEntryLine."Total Quantity" := (SalesLine.Quantity - SalesLine."Total Posted Gate Challan Qty" - SalesLine."Total Gate Challan Qty");
                                if GateEntryLine."Total Quantity" < 0 then GateEntryLine."Total Quantity" := 0;
                                GateEntryLine."Outstandiing Quantity" := GateEntryLine."Total Quantity";
                                GateEntryLine."Challan Quantity" := GateEntryLine."Total Quantity";
                                GateEntryLine.Insert;
                            end;
                        until SalesLine.Next = 0;
                    end;
                end;
        end;
    end;

    procedure DeleteGateLines(GateHeader: Record "SSD Gate Header")
    begin
        if Rec.Find('-') then Rec.DeleteAll;
    end;

    procedure ChangeEditableMode(var GateHeader: Record "SSD Gate Header")
    begin
        /*// *************Ankit CEN003***************************
            //IF GateHeader.GET("Document No.") THEN BEGIN
              CASE GateHeader."Ref. Document Type" OF
                GateHeader."Ref. Document Type"::"RGP Inbound":
                BEGIN
                  CurrForm.Type.EDITABLE:=TRUE;
                  CurrForm."No.".EDITABLE:=TRUE;
                  CurrForm."Challan Quantity".EDITABLE:=TRUE;
                  CurrForm."No. 2".EDITABLE:=FALSE;
                  CurrForm.Grade.EDITABLE:=FALSE;
                  CurrForm.Description.EDITABLE:=FALSE;
                  CurrForm."DESCRIPTION 2".EDITABLE:=FALSE;
                  CurrForm."Total Quantity".EDITABLE:=FALSE;
                  CurrForm."Outstandiing Quantity".EDITABLE:=FALSE;
                  CurrForm."Unit of Measure".EDITABLE:=FALSE;
                  CurrForm."Posted Actual Quantity".EDITABLE:=FALSE;
                END;
                ELSE BEGIN
                  CurrForm.Type.EDITABLE:=FALSE;
                  CurrForm."No.".EDITABLE:=FALSE;
                  CurrForm."Challan Quantity".EDITABLE:=FALSE;
                  CurrForm."No. 2".EDITABLE:=FALSE;
                  CurrForm.Grade.EDITABLE:=FALSE;
                  CurrForm.Description.EDITABLE:=FALSE;
                  CurrForm."DESCRIPTION 2".EDITABLE:=FALSE;
                  CurrForm."Total Quantity".EDITABLE:=FALSE;
                  CurrForm."Outstandiing Quantity".EDITABLE:=FALSE;
                  CurrForm."Unit of Measure".EDITABLE:=FALSE;
                  CurrForm."Posted Actual Quantity".EDITABLE:=FALSE;
                END;
              END;
            //END;
            // *************Ankit CEN003***************************
            */
    end;

    procedure CreateRGP(var GateHeader: Record "SSD Gate Header")
    var
        RGPHeader: Record "SSD RGP Header";
        RGPLine: Record "SSD RGP Line";
        NoSeriesMgt: Codeunit "No. Series";//IG_DS NoSeriesManagement;
        ResponsiblityCenter: Record "Responsibility Center";
        ItemLocal: Record Item;
        GateLine: Record "SSD Gate Line";
    begin
        //*********************CEN004.05*****************
        RGPHeader.Init;
        if ResponsiblityCenter.Get(GateHeader."Responsibility Center") then begin
            RGPHeader."No." := NoSeriesMgt.GetNextNo(ResponsiblityCenter."RGP In Nos", RGPHeader."Posting Date", true);
            RGPHeader."No. Series" := ResponsiblityCenter."RGP In Nos";
            RGPHeader."Posted Shpmt. No Series" := ResponsiblityCenter."Posted RGP IN Shipment Nos";
            RGPHeader."Posted Rect. No Series" := ResponsiblityCenter."Posted RGP IN Receipt Nos";
        end;
        RGPHeader."Document Type" := 0;
        RGPHeader."Party Type" := GateHeader."Party Type";
        RGPHeader.Validate(RGPHeader."Party No.", GateHeader."Party No.");
        RGPHeader."Posting Date" := RGPHeader."Posting Date";
        RGPHeader."Document Date" := RGPHeader."Posting Date";
        RGPHeader."Expected Shipment Date" := RGPHeader."Posting Date";
        RGPHeader."Shipment Date" := RGPHeader."Posting Date";
        RGPHeader."Responsibility Center" := GateHeader."Responsibility Center";
        RGPHeader."External Document No." := GateHeader."Bill No.";
        RGPHeader.Insert;
        GateLine.Copy(Rec);
        RGPLine.Reset;
        Rec.SetCurrentkey("Document No.", "Party Type", "Party No.");
        Rec.SetRange("Document No.", GateHeader."No.");
        Rec.SetRange("Party Type", GateHeader."Party Type");
        Rec.SetRange("Party No.", GateHeader."Party No.");
        if GateLine.Find('-') then begin
            repeat
                RGPLine.Init;
                RGPLine."Document Type" := RGPHeader."Document Type";
                RGPLine."Document No." := RGPHeader."No.";
                RGPLine.Type := RGPLine.Type::Item;
                RGPLine."Line No." := GateLine."Line No.";
                RGPLine."Expected Receipt Date" := RGPHeader."Receipt Date";
                RGPLine."Requested Receipt Date" := RGPHeader."Receipt Date";
                RGPLine."Expected Shipment Date" := RGPHeader."Expected Shipment Date";
                RGPLine."Requested Shipment Date" := RGPHeader."Expected Shipment Date";
                RGPLine."Party Type" := RGPHeader."Party Type";
                RGPLine."Party No." := RGPHeader."Party No.";
                RGPLine."Posting Date" := RGPHeader."Posting Date";
                RGPLine."Shortcut Dimension 1 Code" := RGPHeader."Shortcut Dimension 1 Code";
                RGPLine."Shortcut Dimension 2 Code" := RGPHeader."Shortcut Dimension 2 Code";
                RGPLine."Location Code" := RGPHeader."Location Code";
                RGPLine."Responsibility Center" := RGPHeader."Responsibility Center";
                RGPLine."Gate Entry No." := GateLine."Document No.";
                RGPLine."Gate Entry Line No." := GateLine."Line No.";
                if ItemLocal.Get(GateLine."No.") then begin
                    ItemLocal.TestField(Blocked, false);
                    ItemLocal.TestField("Inventory Posting Group");
                    ItemLocal.TestField("Gen. Prod. Posting Group");
                    RGPLine.Validate(RGPLine."No.", GateLine."No.");
                    RGPLine.Quantity := GateLine."Challan Quantity";
                    RGPLine."Quantity to Receive" := GateLine."Challan Quantity";
                    RGPLine."Quantity(Base)" := GateLine."Challan Quantity";
                    RGPLine."User ID" := GateHeader."User ID";
                    RGPLine."Item Category Code" := ItemLocal."Item Category Code";
                    RGPLine."Unit Of Measure Code" := ItemLocal."Sales Unit of Measure";
                    RGPLine."Base Unit Of Measure" := ItemLocal."Base Unit of Measure";
                end;
                RGPLine.Insert;
            until GateLine.Next = 0;
        end;
        //*********************CEN004.05*****************
        Message(Text000, RGPHeader."No.");
    end;

    procedure CreateSubconRGPLine(var GateHeader: Record "SSD Gate Header")
    var
        RGPHeader: Record "SSD RGP Header";
        RGPLine: Record "SSD RGP Line";
        NoSeriesMgt: Codeunit "No. Series";//IG_DS NoSeriesManagement;
        ResponsiblityCenter: Record "Responsibility Center";
        ItemLocal: Record Item;
        SubconVendor: Record Vendor;
    begin
        GateSetup.Get; //Subcontracting
        RGPHeader.Init;
        if ResponsiblityCenter.Get(GateHeader."Responsibility Center") then begin
            if Rec."Ref. Document Type" = Rec."ref. document type"::Subcontracting then //Subcontracting
 begin
                RGPHeader."No." := NoSeriesMgt.GetNextNo(GateSetup."Subcon MRN Nos", RGPHeader."Posting Date", true);
                RGPHeader."No. Series" := GateSetup."Subcon MRN Nos";
                RGPHeader."Posted Shpmt. No Series" := GateSetup."Subcon MRN Nos";
                RGPHeader."Posted Rect. No Series" := GateSetup."Subcon MRN Nos";
                //ALLEAA CML-033 230408 Start >>
                if SubconVendor.Get(Rec."Party No.") then begin
                    RGPHeader.Validate("Shortcut Dimension 1 Code", SubconVendor."Global Dimension 1 Code");
                    RGPHeader.Validate("Shortcut Dimension 2 Code", SubconVendor."Global Dimension 2 Code");
                    RGPHeader.Validate("Location Code", SubconVendor."Vendor Location");
                end;
                //ALLEAA CML-033 230408 End <<
            end;
        end;
        RGPHeader."Document Type" := RGPHeader."document type"::"RGP Inbound";
        RGPHeader.NRGP := true;
        RGPHeader."Party Type" := GateHeader."Party Type";
        RGPHeader.Validate(RGPHeader."Party No.", GateHeader."Party No.");
        RGPHeader."Posting Date" := RGPHeader."Posting Date";
        RGPHeader."Document Date" := RGPHeader."Posting Date";
        RGPHeader."Expected Shipment Date" := RGPHeader."Posting Date";
        RGPHeader."Shipment Date" := RGPHeader."Posting Date";
        RGPHeader."Responsibility Center" := GateHeader."Responsibility Center";
        RGPHeader."External Document No." := GateHeader."Bill No.";
        RGPHeader."Bill No." := GateHeader."Bill No.";
        RGPHeader."Bill Date" := GateHeader."Bill Date";
        RGPHeader.Subcontracting := true;
        RGPHeader."Gate Entry No." := GateHeader."No.";
        RGPHeader."Delivery Challan No." := GateHeader."Ref. Document No."; //ssd
        RGPHeader.Insert;
        RGPLine.Reset;
        Rec.SetCurrentkey("Document No.", "Party Type", "Party No.");
        Rec.SetRange("Document No.", GateHeader."No.");
        Rec.SetRange("Party Type", GateHeader."Party Type");
        Rec.SetRange("Party No.", GateHeader."Party No.");
        if Rec.Find('-') then begin
            repeat
                RGPLine.Init;
                RGPLine."Document Type" := RGPHeader."Document Type";
                RGPLine."Document No." := RGPHeader."No.";
                RGPLine.Type := RGPLine.Type::Item;
                RGPLine.Subcontracting := RGPHeader.Subcontracting;
                RGPLine."Line No." := Rec."Line No.";
                RGPLine."Expected Receipt Date" := RGPHeader."Receipt Date";
                RGPLine."Requested Receipt Date" := RGPHeader."Receipt Date";
                RGPLine."Expected Shipment Date" := RGPHeader."Expected Shipment Date";
                RGPLine."Requested Shipment Date" := RGPHeader."Expected Shipment Date";
                RGPLine."Party Type" := RGPHeader."Party Type";
                RGPLine."Party No." := RGPHeader."Party No.";
                RGPLine."Posting Date" := RGPHeader."Posting Date";
                RGPLine."Shortcut Dimension 1 Code" := RGPHeader."Shortcut Dimension 1 Code";
                RGPLine."Shortcut Dimension 2 Code" := RGPHeader."Shortcut Dimension 2 Code";
                RGPLine."Location Code" := RGPHeader."Location Code";
                RGPLine."Responsibility Center" := RGPHeader."Responsibility Center";
                RGPLine."Gate Entry No." := Rec."Document No.";
                RGPLine."Gate Entry Line No." := Rec."Line No.";
                RGPLine.Validate(RGPLine."Outstanding Ship Quantity", Rec."Challan Quantity"); //anil
                RGPLine.NRGP := RGPHeader.NRGP;
                if ItemLocal.Get(Rec."No.") then begin
                    ItemLocal.TestField(Blocked, false);
                    ItemLocal.TestField("Inventory Posting Group");
                    ItemLocal.TestField("Gen. Prod. Posting Group");
                    RGPLine.Validate(RGPLine."No.", Rec."No.");
                    RGPLine.Validate(RGPLine.Quantity, Rec."Challan Quantity");
                    RGPLine.Validate(RGPLine."Quantity to Ship", Rec."Challan Quantity");
                    RGPLine.Validate(RGPLine."Quantity(Base)", Rec."Challan Quantity");
                    RGPLine."User ID" := GateHeader."User ID";
                    RGPLine."Item Category Code" := ItemLocal."Item Category Code";
                    RGPLine."Unit Of Measure Code" := ItemLocal."Sales Unit of Measure";
                    RGPLine."Base Unit Of Measure" := ItemLocal."Base Unit of Measure";
                end;
                RGPLine.Insert;
            until Rec.Next = 0;
        end;
        //*********************CEN004.05*****************
        if Rec."Ref. Document Type" = Rec."ref. document type"::Subcontracting then //Subcontracting
            Message('Subcon MRN No. %1 has been created', RGPHeader."No."); //Subcontracting
    end;

    local procedure TypeOnBeforeInput()
    begin
        //ALLEAA SUBMRN 310308 Start >>
        // BIS 1145    CurrPage.Type.UPDATEEDITABLE
        if GateHeader.Get(Rec."Document No.") then begin
            case GateHeader."Ref. Document Type" of
                GateHeader."ref. document type"::"RGP Inbound":
                    CurrPage.Editable(true);
                GateHeader."ref. document type"::"Posted Delivery Challan":
                    CurrPage.Editable(true);
                GateHeader."ref. document type"::"Sales Returns":
                    CurrPage.Editable(true);
                GateHeader."ref. document type"::Other:
                    CurrPage.Editable(true);
                RecGateHeader."ref. document type"::Subcontracting:
                    CurrPage.Editable(true);
                else
                    CurrPage.Editable(false);
            end;
        end;
        // BIS 1145
        //ALLEAA SUBMRN 310308 End <<
    end;

    local procedure NoOnBeforeInput()
    begin
        /* // BIS 1145
            IF GateHeader.GET("Document No.") THEN BEGIN
              CASE GateHeader."Ref. Document Type" OF
                GateHeader."Ref. Document Type"::"RGP Inbound":
                  CurrPage."No.".UPDATEEDITABLE(TRUE);
                GateHeader."Ref. Document Type"::"Posted Delivery Challan":
                  CurrPage."No.".UPDATEEDITABLE(TRUE);
                GateHeader."Ref. Document Type"::"Sales Returns":
                  CurrPage."No.".UPDATEEDITABLE(TRUE);
                GateHeader."Ref. Document Type"::Other:
                  CurrPage."No.".UPDATEEDITABLE(TRUE);
                RecGateHeader."Ref. Document Type"::Subcontracting:
                  CurrPage."No.".UPDATEEDITABLE(TRUE);
                ELSE
                  CurrPage."No.".UPDATEEDITABLE(FALSE);
              END;
            END;
            */
        // BIS 1145
    end;

    local procedure No2OnBeforeInput()
    begin
        /* // BIS 1145
            IF GateHeader.GET("Document No.") THEN BEGIN
              CASE GateHeader."Ref. Document Type" OF
                RecGateHeader."Ref. Document Type"::Subcontracting:
                  CurrPage."No. 2".UPDATEEDITABLE(TRUE);
                ELSE
                  CurrPage."No. 2".UPDATEEDITABLE(FALSE);
              END;
            END;
            */
        // BIS 1145
    end;

    local procedure DescriptionOnBeforeInput()
    begin
        /* // BIS 1145
            IF GateHeader.GET("Document No.") THEN BEGIN
              CASE GateHeader."Ref. Document Type" OF
                GateHeader."Ref. Document Type"::"Posted Delivery Challan":
                  CurrPage.Description.UPDATEEDITABLE(TRUE);
                GateHeader."Ref. Document Type"::"Sales Returns":
                  CurrPage.Description.UPDATEEDITABLE(TRUE);
                GateHeader."Ref. Document Type"::Other:
                  CurrPage.Description.UPDATEEDITABLE(TRUE);
                RecGateHeader."Ref. Document Type"::Subcontracting:
                  CurrPage.Description.UPDATEEDITABLE(TRUE);
                ELSE
                  CurrPage.Description.UPDATEEDITABLE(FALSE);
              END;
            END;
            */
        // BIS 1145
    end;

    local procedure Description2C1000000004OnBefor()
    begin
        /* // BIS 1145
            IF GateHeader.GET("Document No.") THEN BEGIN
              CASE GateHeader."Ref. Document Type" OF
                RecGateHeader."Ref. Document Type"::Subcontracting:
                  CurrPage."Description 2".UPDATEEDITABLE(TRUE);
                ELSE
                  CurrPage."Description 2".UPDATEEDITABLE(FALSE);
              END;
            END;
            */
        // BIS 1145
    end;

    local procedure GradeOnBeforeInput()
    begin
        /* // BIS 1145
            IF GateHeader.GET("Document No.") THEN BEGIN
              CASE GateHeader."Ref. Document Type" OF
                RecGateHeader."Ref. Document Type"::Subcontracting:
                  CurrPage.Grade.UPDATEEDITABLE(TRUE);
                ELSE
                  CurrPage.Grade.UPDATEEDITABLE(FALSE);
              END;
            END;
            */
        // BIS 1145
    end;

    local procedure UnitofMeasureCodeOnBeforeInput()
    begin
        /* // BIS 1145
            IF GateHeader.GET("Document No.") THEN BEGIN
              CASE GateHeader."Ref. Document Type" OF
                GateHeader."Ref. Document Type"::"Posted Delivery Challan":
                  CurrPage."Unit of Measure".UPDATEEDITABLE(TRUE);
                GateHeader."Ref. Document Type"::"Sales Returns":
                  CurrPage."Unit of Measure".UPDATEEDITABLE(TRUE);
                GateHeader."Ref. Document Type"::Other:
                  CurrPage."Unit of Measure".UPDATEEDITABLE(TRUE);
                RecGateHeader."Ref. Document Type"::Subcontracting:
                  CurrPage."Unit of Measure".UPDATEEDITABLE(TRUE);
                ELSE
                  CurrPage."Unit of Measure".UPDATEEDITABLE(FALSE);
              END;
            END;
            */
        // BIS 1145
    end;

    local procedure PostedActualQuantityOnBeforeIn()
    begin
        /* // BIS 1145
            IF GateHeader.GET("Document No.") THEN BEGIN
              CASE GateHeader."Ref. Document Type" OF
                RecGateHeader."Ref. Document Type"::Subcontracting:
                  CurrPage."Posted Actual Quantity".UPDATEEDITABLE(TRUE);
                ELSE
                  CurrPage."Posted Actual Quantity".UPDATEEDITABLE(FALSE);
              END;
            END;
            */
        // BIS 1145
    end;
}
