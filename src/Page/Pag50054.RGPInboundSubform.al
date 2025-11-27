Page 50054 "RGP Inbound Subform"
{
    // CEN004.06 function Create
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "SSD RGP Line";
    SourceTableView = where("Document Type" = filter("RGP Inbound"));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("No. 2"; Rec."No. 2")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Write Off"; Rec."Write Off")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field(NRGP; Rec.NRGP)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                }
                field("Unit Of Measure Code"; Rec."Unit Of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                }
                field("Quantity(Base)"; Rec."Quantity(Base)")
                {
                    ApplicationArea = All;
                }
                field("Quantity Shipped(Base)"; Rec."Quantity Shipped(Base)")
                {
                    ApplicationArea = All;
                }
                field("Quantity Received(Base)"; Rec."Quantity Received(Base)")
                {
                    ApplicationArea = All;
                }
                field("Quantity to Receive"; Rec."Quantity to Receive")
                {
                    ApplicationArea = All;
                }
                field("Quantity to Ship"; Rec."Quantity to Ship")
                {
                    ApplicationArea = All;
                }
                field("Quantity Shipped"; Rec."Quantity Shipped")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Party Type"; Rec."Party Type")
                {
                    ApplicationArea = All;
                }
                field("Party No."; Rec."Party No.")
                {
                    ApplicationArea = All;
                }
                field("In-Transit Code"; Rec."In-Transit Code")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Ship Quantity"; Rec."Outstanding Ship Quantity")
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                }
                field("Expected Shipment Date"; Rec."Expected Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Requested Shipment Date"; Rec."Requested Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Completely Shipped"; Rec."Completely Shipped")
                {
                    ApplicationArea = All;
                }
                field("Shipping Date"; Rec."Shipping Date")
                {
                    ApplicationArea = All;
                }
                field("Receipt Time"; Rec."Receipt Time")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Write Off"; Rec."Qty. to Write Off")
                {
                    ApplicationArea = All;
                }
                field("Quantity Write Off"; Rec."Quantity Write Off")
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
            group("&Line")
            {
                Caption = '&Line';

                action("Line Detail")
                {
                    ApplicationArea = All;
                    Caption = 'Line Detail';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50052. Unsupported part was commented. Please check it.
                        /*CurrPage.SubRGPHeader.PAGE.*/
                        RGPDetail;
                    end;
                }
                group("Item &Tracking Line")
                {
                    Caption = 'Item &Tracking Line';

                    action("&Shipment")
                    {
                        ApplicationArea = All;
                        Caption = '&Shipment';

                        trigger OnAction()
                        begin
                            //ALLE[551]
                            //This functionality was copied from page #50052. Unsupported part was commented. Please check it.
                            /*CurrPage.SubRGPHeader.PAGE.*/
                            _OpenItemTrackingLines(0);
                        end;
                    }
                    action("&Receipt")
                    {
                        ApplicationArea = All;
                        Caption = '&Receipt';

                        trigger OnAction()
                        begin
                            //ALLE[551]
                            //This functionality was copied from page #50052. Unsupported part was commented. Please check it.
                            /*CurrPage.SubRGPHeader.PAGE.*/
                            _OpenItemTrackingLines(1);
                        end;
                    }
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        UserSetup: Record "User Setup";
    begin
        Rec.Type := xRec.Type;
        //MUA01 Starts
        if UserSetup.Get(UserId) then Rec."Responsibility Center" := UserSetup."Responsibility Center";
        //MUA01 Ends
    end;

    var
        Text001: label 'You can''t Reopen the Document. Document is writeOff.';

    procedure CheckWriteOff()
    begin
        //*********CEN004.06*********
        if Rec."Write Off" = true then Error(Text001);
    end;

    procedure RGPDetail()
    var
        RecRGPDetail: Record "SSD RGP Line Detail";
        FrmRGPdetails: Page "RGP Line Details";
    begin
        //***********CEN006***************
        if Rec."No." <> '' then begin
            RecRGPDetail.Reset;
            RecRGPDetail.SetRange(RecRGPDetail."Document Type", Rec."Document Type");
            RecRGPDetail.SetRange(RecRGPDetail."Document No.", Rec."Document No.");
            RecRGPDetail.SetRange(RecRGPDetail."Item No.", Rec."No.");
            RecRGPDetail.SetRange(RecRGPDetail."Line No.", Rec."Line No.");
            Clear(FrmRGPdetails);
            FrmRGPdetails.InitialValues(Rec."Document Type", Rec."Document No.", Rec."No.", Rec."Line No.");
            FrmRGPdetails.SetRecord(RecRGPDetail);
            FrmRGPdetails.SetTableview(RecRGPDetail);
            FrmRGPdetails.RunModal;
        end;
    end;

    procedure CreateNRGP(var RGPHeader: Record "SSD RGP Header")
    var
        ItemLocal: Record Item;
        NRGPHeader: Record "SSD RGP Header";
        NRGPLine: Record "SSD RGP Line";
        ResponsibilityCenter: Record "Responsibility Center";
        NoSeriesMgt: Codeunit "No. Series";//IG_DS NoSeriesManagement;
        DocNo: Code[20];
        RGPLine: Record "SSD RGP Line";
    begin
        //>>CEN004.06
        NRGPHeader.Init;
        if ResponsibilityCenter.Get(RGPHeader."Responsibility Center") then begin
            NRGPHeader."No." := NoSeriesMgt.GetNextNo(ResponsibilityCenter."NRGP In Nos", NRGPHeader."Posting Date", true);
            DocNo := NRGPHeader."No.";
            NRGPHeader."No. Series" := ResponsibilityCenter."NRGP In Nos";
            NRGPHeader."Posted Shpmt. No Series" := ResponsibilityCenter."Posted RGP IN Shipment Nos";
        end;
        NRGPHeader."Document Type" := Rec."document type"::"RGP Outbound";
        NRGPHeader."Party Type" := RGPHeader."Party Type";
        NRGPHeader."Reference No." := RGPHeader."No.";
        NRGPHeader.Validate(NRGPHeader."Party No.", RGPHeader."Party No.");
        NRGPHeader."Posting Date" := WorkDate;
        NRGPHeader."Document Date" := WorkDate;
        NRGPHeader."Expected Shipment Date" := WorkDate;
        NRGPHeader."Shipment Date" := WorkDate;
        NRGPHeader."Responsibility Center" := RGPHeader."Responsibility Center";
        NRGPHeader."External Document No." := RGPHeader."External Document No.";
        NRGPHeader.NRGP := true;
        NRGPHeader."Location Code" := RGPHeader."Location Code";
        NRGPHeader."Shortcut Dimension 1 Code" := RGPHeader."Shortcut Dimension 1 Code";
        NRGPHeader."Shortcut Dimension 2 Code" := RGPHeader."Shortcut Dimension 2 Code";
        NRGPHeader."Purpose Code" := RGPHeader."Purpose Code";
        NRGPHeader."Purpose Description" := RGPHeader."Purpose Description";
        NRGPHeader."Advising Employee" := RGPHeader."Advising Employee";
        NRGPHeader."Party Shipment/Rect. No." := RGPHeader."Party Shipment/Rect. No.";
        NRGPHeader."Party Shipment/Rect. Date" := RGPHeader."Party Shipment/Rect. Date";
        NRGPHeader."Receipt Date" := RGPHeader."Receipt Date";
        NRGPHeader."Advising Department" := RGPHeader."Advising Department";
        NRGPHeader.Validate("Advising Department");
        NRGPHeader."Advising Employee" := RGPHeader."Advising Employee";
        NRGPHeader."Delivery Mode" := RGPHeader."Delivery Mode";
        NRGPHeader."Vehical No." := RGPHeader."Vehical No.";
        NRGPHeader."Transporter No." := RGPHeader."Transporter No.";
        NRGPHeader."Transporter Name" := RGPHeader."Transporter Name";
        NRGPHeader."LR No." := RGPHeader."LR No.";
        NRGPHeader."GR No." := RGPHeader."GR No.";
        NRGPHeader."Bearer Name" := RGPHeader."Bearer Name";
        NRGPHeader."Bearer Department" := RGPHeader."Bearer Department";
        NRGPHeader."MRR No." := RGPHeader."MRR No.";
        NRGPHeader."Ship Remarks" := RGPHeader."Ship Remarks";
        NRGPHeader."Expected Shipment Date" := RGPHeader."Expected Shipment Date";
        NRGPHeader."Receipt Remarks" := RGPHeader."Receipt Remarks";
        NRGPHeader."Bin Code" := RGPHeader."Bin Code";
        NRGPHeader.Remark2 := RGPHeader.Remark2;
        NRGPHeader.Insert;
        Clear(RGPLine);
        RGPLine.Copy(Rec);
        if RGPLine.Find('-') then begin
            repeat
                NRGPLine.Init;
                NRGPLine."Document No." := NRGPHeader."No.";
                NRGPLine."Document Type" := NRGPLine."document type"::"RGP Outbound";
                NRGPLine.NRGP := true;
                NRGPLine.Type := RGPLine.Type::Item;
                NRGPLine."Line No." := RGPLine."Line No.";
                NRGPLine."Expected Receipt Date" := RGPLine."Expected Receipt Date";
                NRGPLine."Requested Receipt Date" := RGPLine."Requested Receipt Date";
                NRGPLine."Expected Shipment Date" := RGPLine."Expected Shipment Date";
                NRGPLine."Requested Shipment Date" := RGPLine."Expected Shipment Date";
                NRGPLine."In-Transit Code" := RGPLine."In-Transit Code";
                NRGPLine."Bin Code" := RGPLine."Bin Code";
                NRGPLine."Party Type" := RGPLine."Party Type";
                NRGPLine."Party No." := RGPLine."Party No.";
                NRGPLine."Posting Date" := RGPLine."Posting Date";
                NRGPLine."Shortcut Dimension 1 Code" := RGPLine."Shortcut Dimension 1 Code";
                NRGPLine."Shortcut Dimension 2 Code" := RGPLine."Shortcut Dimension 2 Code";
                NRGPLine."Location Code" := RGPLine."Location Code";
                NRGPLine."Responsibility Center" := RGPLine."Responsibility Center";
                if ItemLocal.Get(RGPLine."No.") then begin
                    ItemLocal.TestField(Blocked, false);
                    ItemLocal.TestField("Inventory Posting Group");
                    ItemLocal.TestField("Gen. Prod. Posting Group");
                    NRGPLine."No." := RGPLine."No.";
                    NRGPLine.Validate("No.");
                    NRGPLine.Validate("No.");
                    NRGPLine.Quantity := RGPLine.Quantity;
                    NRGPLine."Direct Unit Cost" := RGPLine."Direct Unit Cost";
                    NRGPLine.Validate(Quantity);
                    NRGPLine.Validate("Direct Unit Cost");
                    NRGPLine.Validate("Quantity to Ship");
                    NRGPLine.Validate("Quantity(Base)");
                    NRGPLine."User ID" := RGPLine."User ID";
                    NRGPLine."Item Category Code" := ItemLocal."Item Category Code";
                    //SSDU NRGPLine."Product Group Code" := ItemLocal."Product Group Code";
                    NRGPLine."Unit Of Measure Code" := ItemLocal."Sales Unit of Measure";
                    NRGPLine."Base Unit Of Measure" := ItemLocal."Base Unit of Measure";
                end;
                NRGPLine.Insert;
            until RGPLine.Next = 0;
            Message('%1 has been created', NRGPHeader."No.");
            RGPHeader."NRGP Created From RGP" := true;
            RGPHeader.Modify;
        end;
        //*********************CEN004.05*****************
        //<<CEN004.06
    end;

    procedure LineWriteOff()
    var
        RGPLine: Record "SSD RGP Line";
    begin
        RGPLine.Copy(Rec);
        RGPLine.SetRange("Document Type", Rec."Document Type");
        RGPLine.SetRange("Document No.", Rec."Document No.");
        RGPLine.SetRange("Write Off", true);
        RGPLine.SetFilter("Qty. to Write Off", '<>%1', 0);
        if RGPLine.FindFirst then begin
            Rec.PostWriteOff(RGPLine);
            Commit;
        end;
    end;

    procedure _OpenItemTrackingLines(Direction: Option Outbound,Inbound)
    begin
        //ALLE[551]
        if Direction = 0 then
            Rec.TestField("Quantity to Ship")
        else
            Rec.TestField("Quantity to Receive");
        Rec.OpenItemTrackingLines(Direction);
    end;
}
