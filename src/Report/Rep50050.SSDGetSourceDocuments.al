Report 50050 "SSD Get Source Documents"
{
    Caption = 'Get Source Documents';
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Warehouse Request"; "Warehouse Request")
        {
            DataItemTableView = where("Document Status" = const(Released), "Completely Handled" = filter(false));
            RequestFilterFields = "Source Document", "Source No.";

            column(ReportForNavId_1170000000; 1170000000)
            {
            }
            dataitem("Sales Header"; "Sales Header")
            {
                DataItemLink = "Document Type" = field("Source Subtype"), "No." = field("Source No.");
                DataItemTableView = sorting("Document Type", "No.");

                column(ReportForNavId_6640; 6640)
                {
                }
                dataitem("Sales Line"; "Sales Line")
                {
                    DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");

                    column(ReportForNavId_2844; 2844)
                    {
                    }
                    trigger OnAfterGetRecord()
                    var
                        GateLineLocal: Record "SSD Gate Line";
                    begin
                        //BEGIN
                        //CF001.02 St
                        if (WhseReceiptHeader."Gate Entry no." <> '') and (WhseReceiptHeader.IsMRN) then begin
                            GateLineLocal.Reset;
                            GateLineLocal.SetRange("Document No.", WhseReceiptHeader."Gate Entry no.");
                            GateLineLocal.SetFilter("Ref. Document Type", '%1', GateLineLocal."ref. document type"::"Sales Returns");
                            GateLineLocal.SetRange("Ref. Document No.", "Document No.");
                            GateLineLocal.SetRange("Ref. Document Line No.", "Line No.");
                            if not GateLineLocal.Find('-') then exit;
                        end;
                        //CF001.02 En
                        if "Location Code" = "Warehouse Request"."Location Code" then
                            case RequestType of
                                Requesttype::Receive:
                                    // if WhseActivityCreate.CheckIfSalesLine2ReceiptLine("Sales Line") then begin //IG_DS_Before
                                    if SalesWhseMgt.CheckIfSalesLine2ReceiptLine("Sales Line") then begin
                                        if not OneHeaderCreated and not WhseHeaderCreated then CreateReceiptHeader;
                                        //  WhseActivityCreate.SalesLine2ReceiptLine(WhseReceiptHeader, "Sales Line"); //IG_DS_Before
                                        SalesWhseMgt.SalesLine2ReceiptLine(WhseReceiptHeader, "Sales Line");
                                        LineCreated := true;
                                    end;
                                Requesttype::Ship:
                                    //  if WhseActivityCreate.CheckIfFromSalesLine2ShptLine("Sales Line") then begin
                                    if SalesWhseMgt.CheckIfFromSalesLine2ShptLine("Sales Line") then begin //IG_DS_before
                                        if not OneHeaderCreated and not WhseHeaderCreated then CreateShptHeader;
                                        //  WhseActivityCreate.FromSalesLine2ShptLine(WhseShptHeader, "Sales Line"); //IG_DS_before
                                        SalesWhseMgt.FromSalesLine2ShptLine(WhseShptHeader, "Sales Line");
                                        LineCreated := true;
                                    end;
                            end;
                    end;

                    trigger OnPreDataItem()
                    begin
                        SetRange(Type, Type::Item);
                        if (("Warehouse Request".Type = "Warehouse Request".Type::Outbound) and ("Warehouse Request"."Source Document" = "Warehouse Request"."source document"::"Sales Order")) or (("Warehouse Request".Type = "Warehouse Request".Type::Inbound) and ("Warehouse Request"."Source Document" = "Warehouse Request"."source document"::"Sales Return Order")) then
                            SetFilter("Outstanding Quantity", '>0')
                        else
                            SetFilter("Outstanding Quantity", '<0');
                        SetRange("Drop Shipment", false);
                        SetRange("Job No.", '');
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    TestField("Sell-to Customer No.");
                    Cust.Get("Sell-to Customer No.");
                    if not SkipBlockedCustomer then
                        Cust.CheckBlockedCustOnDocs(Cust, "Document Type", false, false)
                    else if Cust.Blocked <> Cust.Blocked::" " then CurrReport.Skip;
                end;

                trigger OnPreDataItem()
                begin
                    if "Warehouse Request"."Source Type" <> Database::"Sales Line" then CurrReport.Break;
                end;
            }
            dataitem("Purchase Header"; "Purchase Header")
            {
                DataItemLink = "Document Type" = field("Source Subtype"), "No." = field("Source No.");
                DataItemTableView = sorting("Document Type", "No.");

                column(ReportForNavId_4458; 4458)
                {
                }
                dataitem("Purchase Line"; "Purchase Line")
                {
                    DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");

                    column(ReportForNavId_6547; 6547)
                    {
                    }
                    trigger OnAfterGetRecord()
                    var
                        GateLineLocal: Record "SSD Gate Line";
                    begin
                        //CF001.01 St
                        /*IF (WhseReceiptHeader."Gate Entry no."<>'') AND (WhseReceiptHeader.IsMRN) THEN
                          BEGIN
                            GateLineLocal.RESET;
                            GateLineLocal.SETRANGE("Document No.",WhseReceiptHeader."Gate Entry no.");
                            GateLineLocal.SETFILTER("Ref. Document Type",'%1|%2',
                                                    GateLineLocal."Ref. Document Type"::"Purchase Order",
                                                    GateLineLocal."Ref. Document Type"::"Purchase Schedule" );
                            GateLineLocal.SETRANGE("Ref. Document No.","Document No.");
                            GateLineLocal.SETRANGE("Ref. Document Line No.","Line No.");
                            IF NOT GateLineLocal.FIND('-') THEN
                              EXIT;
                          END;*/
                        //CF001.01 En
                        if "Location Code" = "Warehouse Request"."Location Code" then
                            case RequestType of
                                Requesttype::Receive:
                                    if PurchaseWhseMgt.CheckIfPurchLine2ReceiptLine("Purchase Line") then begin
                                        if not OneHeaderCreated and not WhseHeaderCreated then CreateReceiptHeader;
                                        //CMLTEST-026 AA 020208 Start
                                        if (WhseReceiptHeader."Gate Entry no." <> '') and (WhseReceiptHeader.IsMRN) then begin
                                            GateLineLocal.Reset;
                                            GateLineLocal.SetRange("Document No.", WhseReceiptHeader."Gate Entry no.");
                                            GateLineLocal.SetFilter("Ref. Document Type", '%1|%2', GateLineLocal."ref. document type"::"Purchase Order", GateLineLocal."ref. document type"::"Purchase Schedule");
                                            GateLineLocal.SetRange("Ref. Document No.", "Document No.");
                                            GateLineLocal.SetRange("Ref. Document Line No.", "Line No.");
                                            if not GateLineLocal.Find('-') then exit;
                                        end;
                                        //CMLTEST-026 AA 020208 Finish
                                        PurchaseWhseMgt.PurchLine2ReceiptLine(WhseReceiptHeader, "Purchase Line");
                                        LineCreated := true;
                                    end;
                                Requesttype::Ship:
                                    if PurchaseWhseMgt.CheckIfFromPurchLine2ShptLine("Purchase Line") then begin
                                        if not OneHeaderCreated and not WhseHeaderCreated then CreateShptHeader;
                                        //CMLTEST-026 AA 020208 Start
                                        if (WhseReceiptHeader."Gate Entry no." <> '') and (WhseReceiptHeader.IsMRN) then begin
                                            GateLineLocal.Reset;
                                            GateLineLocal.SetRange("Document No.", WhseReceiptHeader."Gate Entry no.");
                                            GateLineLocal.SetFilter("Ref. Document Type", '%1|%2', GateLineLocal."ref. document type"::"Purchase Order", GateLineLocal."ref. document type"::"Purchase Schedule");
                                            GateLineLocal.SetRange("Ref. Document No.", "Document No.");
                                            GateLineLocal.SetRange("Ref. Document Line No.", "Line No.");
                                            if not GateLineLocal.Find('-') then exit;
                                        end;
                                        //CMLTEST-026 AA 020208 Finish
                                        PurchaseWhseMgt.FromPurchLine2ShptLine(WhseShptHeader, "Purchase Line");
                                        LineCreated := true;
                                    end;
                            end;
                    end;

                    trigger OnPreDataItem()
                    begin
                        SetRange(Type, Type::Item);
                        if (("Warehouse Request".Type = "Warehouse Request".Type::Inbound) and ("Warehouse Request"."Source Document" = "Warehouse Request"."source document"::"Purchase Order")) or (("Warehouse Request".Type = "Warehouse Request".Type::Outbound) and ("Warehouse Request"."Source Document" = "Warehouse Request"."source document"::"Purchase Return Order")) then
                            SetFilter("Outstanding Quantity", '>0')
                        else
                            SetFilter("Outstanding Quantity", '<0');
                        SetRange("Drop Shipment", false);
                        SetRange("Job No.", '');
                    end;
                }
                trigger OnPreDataItem()
                begin
                    if "Warehouse Request"."Source Type" <> Database::"Purchase Line" then CurrReport.Break;
                end;
            }
            dataitem("Transfer Header"; "Transfer Header")
            {
                DataItemLink = "No." = field("Source No.");
                DataItemTableView = sorting("No.");

                column(ReportForNavId_2957; 2957)
                {
                }
                dataitem("Transfer Line"; "Transfer Line")
                {
                    DataItemLink = "Document No." = field("No.");

                    column(ReportForNavId_9370; 9370)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        case RequestType of
                            Requesttype::Receive:
                                if TransferWhseMgt.CheckIfTransLine2ReceiptLine("Transfer Line") then begin
                                    if not OneHeaderCreated and not WhseHeaderCreated then CreateReceiptHeader;
                                    TransferWhseMgt.TransLine2ReceiptLine(WhseReceiptHeader, "Transfer Line");
                                    LineCreated := true;
                                end;
                            Requesttype::Ship:
                                if TransferWhseMgt.CheckIfFromTransLine2ShptLine("Transfer Line") then begin
                                    if not OneHeaderCreated and not WhseHeaderCreated then CreateShptHeader;
                                    TransferWhseMgt.FromTransLine2ShptLine(WhseShptHeader, "Transfer Line");
                                    LineCreated := true;
                                end;
                        end;
                    end;

                    trigger OnPreDataItem()
                    begin
                        case "Warehouse Request"."Source Subtype" of
                            0:
                                SetFilter("Outstanding Quantity", '>0');
                            1:
                                SetFilter("Qty. in Transit", '>0');
                        end;
                    end;
                }
                trigger OnPreDataItem()
                begin
                    if "Warehouse Request"."Source Type" <> Database::"Transfer Line" then CurrReport.Break;
                end;
            }
            trigger OnAfterGetRecord()
            var
                WhseSetup: Record "Warehouse Setup";
                GateHeaderLocal: Record "SSD Gate Header";
            begin
                WhseHeaderCreated := false;
                case Type of
                    Type::Inbound:
                        begin
                            if not Location.RequireReceive("Location Code") then begin
                                if "Location Code" = '' then WhseSetup.TestField("Require Receive");
                                Location.Get("Location Code");
                                Location.TestField("Require Receive");
                            end;
                            if not OneHeaderCreated then RequestType := Requesttype::Receive;
                            //CF001.01 St
                            if ("Source Document" = "source document"::"Purchase Order") or ("Source Document" = "source document"::"Purchase Return Order") or ("Source Document" = "source document"::"Sales Return Order") then UpdateIsMRN := true;
                            //CML-026 AA 190108 Start
                            /*
                                        IF GateHeaderNo <>'' THEN
                                            IF GateHeaderLocal.GET(GateHeaderNo) THEN
                                              BEGIN
                                                WhseReceiptHeader."Gate Entry no.":=GateHeaderLocal."No.";
                                                WhseReceiptHeader."Gate Entry Date":=GateHeaderLocal."Posting Date";
                                                WhseReceiptHeader.Subcontracting:=GateHeaderLocal.Subcontracting;
                                                WhseReceiptHeader.Trading:=GateHeaderLocal.Trading;//CE_AA004
                                              END;
                                        */
                            //CML-026 AA 190108 Finish
                            //CF001.01 En
                        end;
                    Type::Outbound:
                        begin
                            if not Location.RequireShipment("Location Code") then begin
                                if "Location Code" = '' then WhseSetup.TestField("Require Shipment");
                                Location.Get("Location Code");
                                Location.TestField("Require Shipment");
                            end;
                            if not OneHeaderCreated then RequestType := Requesttype::Ship;
                        end;
                end;
            end;

            trigger OnPostDataItem()
            var
                WHReceiptLineLocal: Record "Warehouse Receipt Line";
                PostedGateHeaderLocal: Record "SSD Posted Gate Header";
            begin
            end;

            trigger OnPreDataItem()
            begin
                if OneHeaderCreated then begin
                    case RequestType of
                        Requesttype::Receive:
                            "Warehouse Request".Type := "Warehouse Request".Type::Inbound;
                        Requesttype::Ship:
                            "Warehouse Request".Type := "Warehouse Request".Type::Outbound;
                    end;
                    SetRange(Type, "Warehouse Request".Type);
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(DoNotFillQtytoHandle; DoNotFillQtytoHandle)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Do Not Fill Qty. to Handle';
                    }
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPostReport()
    begin
        case RequestType of
            Requesttype::Receive:
                begin
                    if DoNotFillQtytoHandle then begin
                        WhseReceiptLine.Reset;
                        WhseReceiptLine.SetRange("No.", WhseReceiptHeader."No.");
                        WhseReceiptLine.DeleteQtyToReceive(WhseReceiptLine);
                    end;
                    if not HideDialog then begin
                        if not LineCreated then Error(Text000);
                        if ActivitiesCreated = 1 then Message(Text001, ActivitiesCreated, WhseReceiptHeader.TableCaption);
                        if ActivitiesCreated > 1 then Message(Text002, ActivitiesCreated);
                    end;
                end;
            Requesttype::Ship:
                begin
                    if not HideDialog then begin
                        if not LineCreated then Error(Text003);
                        if ActivitiesCreated = 1 then Message(Text001, ActivitiesCreated, WhseShptHeader.TableCaption);
                        if ActivitiesCreated > 1 then Message(Text004, ActivitiesCreated);
                    end;
                end;
        end;
        Completed := true;
    end;

    trigger OnPreReport()
    begin
        ActivitiesCreated := 0;
        LineCreated := false;
    end;

    var
        Text000: label 'There are no Warehouse Receipt Lines created.';
        Text001: label '%1 %2 has been created.';
        WhseReceiptHeader: Record "Warehouse Receipt Header";
        WhseReceiptLine: Record "Warehouse Receipt Line";
        WhseShptHeader: Record "Warehouse Shipment Header";
        WhseShptLine: Record "Warehouse Shipment Line";
        Location: Record Location;
        Cust: Record Customer;
        WhseActivityCreate: Codeunit "Whse.-Create Source Document"; //IG_DS_before
        //IG_DS_after>>
        SalesWhseMgt: Codeunit "Sales Warehouse Mgt.";
        PurchaseWhseMgt: Codeunit "Purchases Warehouse Mgt.";
        TransferWhseMgt: Codeunit "Transfer Warehouse Mgt.";
        //IG_DS_after<<
        ActivitiesCreated: Integer;
        OneHeaderCreated: Boolean;
        Completed: Boolean;
        LineCreated: Boolean;
        WhseHeaderCreated: Boolean;
        DoNotFillQtytoHandle: Boolean;
        HideDialog: Boolean;
        SkipBlockedCustomer: Boolean;
        RequestType: Option Receive,Ship;
        Text002: label '%1 Warehouse Receipts have been created.';
        Text003: label 'There are no Warehouse Shipment Lines created.';
        Text004: label '%1 Warehouse Shipments have been created.';
        GateHeaderNo: Code[20];
        UpdateIsMRN: Boolean;
        RGPHeader: Record "SSD RGP Header";
        PostedGateHeader: Record "SSD Posted Gate Header";
        ErrorOccured: Boolean;
        Text005: label 'One or more of the lines on this %1 require special warehouse handling. The %2 for such lines has been set to blank.';
        CustomerIsBlockedMsg: label '%1 source documents were not included because the customer is blocked.';
        SkipBlockedItem: Boolean;
        SalesHeaderCounted: Boolean;
        SkippedSourceDoc: Integer;
        RecPurchHeader: Record "Purchase Header";

    procedure SetHideDialog(NewHideDialog: Boolean)
    begin
        HideDialog := NewHideDialog;
    end;

    procedure SetOneCreatedShptHeader(WhseShptHeader2: Record "Warehouse Shipment Header")
    begin
        RequestType := Requesttype::Ship;
        WhseShptHeader := WhseShptHeader2;
        if WhseShptHeader.Find then OneHeaderCreated := true;
    end;

    procedure SetOneCreatedReceiptHeader(WhseReceiptHeader2: Record "Warehouse Receipt Header")
    begin
        RequestType := Requesttype::Receive;
        WhseReceiptHeader := WhseReceiptHeader2;
        if WhseReceiptHeader.Find then OneHeaderCreated := true;
    end;

    procedure SetDoNotFillQtytoHandle(DoNotFillQtytoHandle2: Boolean)
    begin
        DoNotFillQtytoHandle := DoNotFillQtytoHandle2;
    end;

    procedure GetLastShptHeader(var WhseShptHeader2: Record "Warehouse Shipment Header")
    begin
        RequestType := Requesttype::Ship;
        WhseShptHeader2 := WhseShptHeader;
    end;

    procedure GetLastReceiptHeader(var WhseReceiptHeader2: Record "Warehouse Receipt Header")
    begin
        RequestType := Requesttype::Receive;
        WhseReceiptHeader2 := WhseReceiptHeader;
    end;

    procedure NotCancelled(): Boolean
    begin
        exit(Completed);
    end;

    local procedure CreateShptHeader()
    begin
        WhseShptHeader.Init;
        WhseShptHeader."No." := '';
        WhseShptHeader."Location Code" := "Warehouse Request"."Location Code";
        WhseShptLine.LockTable;
        WhseShptHeader.Insert(true);
        ActivitiesCreated := ActivitiesCreated + 1;
        WhseHeaderCreated := true;
        Commit;
    end;

    local procedure CreateReceiptHeader()
    var
        GateHeaderLocal: Record "SSD Gate Header";
    begin
        WhseReceiptHeader.Init;
        WhseReceiptHeader."No." := '';
        WhseReceiptHeader."Location Code" := "Warehouse Request"."Location Code";
        //CML-026 AA 190108 Start
        WhseReceiptHeader.IsMRN := UpdateIsMRN;
        if GateHeaderNo <> '' then
            if GateHeaderLocal.Get(GateHeaderNo) then begin
                WhseReceiptHeader."Gate Entry no." := GateHeaderLocal."No.";
                WhseReceiptHeader."Gate Entry Date" := GateHeaderLocal."Posting Date";
                WhseReceiptHeader."Vendor Shipment No." := GateHeaderLocal."Bill No.";
                WhseReceiptHeader.Subcontracting := GateHeaderLocal.Subcontracting;
                if RecPurchHeader.Get(RecPurchHeader."document type"::Order, GateHeaderLocal."Ref. Document No.") then;
                WhseReceiptHeader."Work Order No1" := GateHeaderLocal."Work Order No1";
                WhseReceiptHeader."Work Order No2" := GateHeaderLocal."Work Order No2";
                WhseReceiptHeader."Work Order No3" := GateHeaderLocal."Work Order No3";
                WhseReceiptHeader."Work Order No4" := GateHeaderLocal."Work Order No4";
                WhseReceiptHeader."Work Order No5" := GateHeaderLocal."Work Order No5";
                WhseReceiptHeader."Work Order No6" := GateHeaderLocal."Work Order No6";
                //ALLE-AT START
                WhseReceiptHeader."No. Series 1" := RecPurchHeader."No. Series 1";
                WhseReceiptHeader."No. Series 2" := RecPurchHeader."No. Series 2";
                WhseReceiptHeader."No. Series 3" := RecPurchHeader."No. Series 3";
                WhseReceiptHeader."No. Series 4" := RecPurchHeader."No. Series 4";
                WhseReceiptHeader."No. Series 5" := RecPurchHeader."No. Series 5";
                WhseReceiptHeader."No. Series 6" := RecPurchHeader."No. Series 6";
                WhseReceiptHeader."Charge Item 1" := RecPurchHeader."Charge Item 1";
                WhseReceiptHeader."Charge Item 2" := RecPurchHeader."Charge Item 2";
                WhseReceiptHeader."Charge Item 3" := RecPurchHeader."Charge Item 3";
                WhseReceiptHeader."Charge Item 4" := RecPurchHeader."Charge Item 4";
                WhseReceiptHeader."Charge Item 5" := RecPurchHeader."Charge Item 5";
                WhseReceiptHeader."Charge Item 6" := RecPurchHeader."Charge Item 6";
                WhseReceiptHeader."Approval Required 1" := RecPurchHeader."Approval Required 1";
                WhseReceiptHeader."Approval Required 2" := RecPurchHeader."Approval Required 2";
                WhseReceiptHeader."Approval Required 3" := RecPurchHeader."Approval Required 3";
                WhseReceiptHeader."Approval Required 4" := RecPurchHeader."Approval Required 4";
                WhseReceiptHeader."Approval Required 5" := RecPurchHeader."Approval Required 5";
                WhseReceiptHeader."Approval Required 6" := RecPurchHeader."Approval Required 6";
                WhseReceiptHeader."Rem. Order Amount1" := RecPurchHeader."Rem. Order Amount1";
                WhseReceiptHeader."Rem. Order Amount2" := RecPurchHeader."Rem. Order Amount2";
                WhseReceiptHeader."Rem. Order Amount3" := RecPurchHeader."Rem. Order Amount3";
                WhseReceiptHeader."Rem. Order Amount4" := RecPurchHeader."Rem. Order Amount4";
                WhseReceiptHeader."Rem. Order Amount5" := RecPurchHeader."Rem. Order Amount5";
                WhseReceiptHeader."Rem. Order Amount6" := RecPurchHeader."Rem. Order Amount6";
                WhseReceiptHeader."Invoice Posted1" := RecPurchHeader."Invoice Posted1";
                WhseReceiptHeader."Invoice Posted2" := RecPurchHeader."Invoice Posted2";
                WhseReceiptHeader."Invoice Posted3" := RecPurchHeader."Invoice Posted3";
                WhseReceiptHeader."Invoice Posted4" := RecPurchHeader."Invoice Posted4";
                WhseReceiptHeader."Invoice Posted5" := RecPurchHeader."Invoice Posted5";
                WhseReceiptHeader."Invoice Posted6" := RecPurchHeader."Invoice Posted6";
                WhseReceiptHeader."Send By Purch1" := RecPurchHeader."Send By Purch1";
                WhseReceiptHeader."Send By Purch2" := RecPurchHeader."Send By Purch2";
                WhseReceiptHeader."Send By Purch3" := RecPurchHeader."Send By Purch3";
                WhseReceiptHeader."Send By Purch4" := RecPurchHeader."Send By Purch4";
                WhseReceiptHeader."Send By Purch5" := RecPurchHeader."Send By Purch5";
                WhseReceiptHeader."Send By Purch6" := RecPurchHeader."Send By Purch6";
                WhseReceiptHeader."Rec. By Fin1" := RecPurchHeader."Rec. By Fin1";
                WhseReceiptHeader."Rec. By Fin2" := RecPurchHeader."Rec. By Fin2";
                WhseReceiptHeader."Rec. By Fin3" := RecPurchHeader."Rec. By Fin3";
                WhseReceiptHeader."Rec. By Fin4" := RecPurchHeader."Rec. By Fin4";
                WhseReceiptHeader."Rec. By Fin5" := RecPurchHeader."Rec. By Fin5";
                WhseReceiptHeader."Rec. By Fin6" := RecPurchHeader."Rec. By Fin6";
                WhseReceiptHeader."Tentative Value1" := RecPurchHeader."Tentative Value1";
                WhseReceiptHeader."Tentative Value2" := RecPurchHeader."Tentative Value2";
                WhseReceiptHeader."Tentative Value3" := RecPurchHeader."Tentative Value3";
                WhseReceiptHeader."Tentative Value4" := RecPurchHeader."Tentative Value4";
                WhseReceiptHeader."Tentative Value5" := RecPurchHeader."Tentative Value5";
                WhseReceiptHeader."Tentative Value6" := RecPurchHeader."Tentative Value6";
                WhseReceiptHeader.Trading := GateHeaderLocal.Trading; //CE_AA004
            end;
        // ssd
        if RGPHeader.Get(RGPHeader."document type"::"RGP Inbound", "Transfer Line"."Document No.") then
            if PostedGateHeader.Get(RGPHeader."Gate Entry No.") then begin
                WhseReceiptHeader."Gate Entry no." := PostedGateHeader."No.";
                WhseReceiptHeader."Gate Entry Date" := PostedGateHeader."Posting Date";
                WhseReceiptHeader.Subcontracting := PostedGateHeader.Subcontracting;
                WhseReceiptHeader.Trading := PostedGateHeader.Trading; //CE_AA004
            end;
        // ssd
        //WhseReceiptHeader."Subcontracting Transfer Order" := "Transfer Header"."Subcontracting Transfer Order"; //ALLEAA CML-033 300408
        WhseReceiptLine.LockTable;
        WhseReceiptHeader.Insert(true);
        ActivitiesCreated := ActivitiesCreated + 1;
        WhseHeaderCreated := true;
        //COMMIT;
    end;

    procedure SetSkipBlocked(Skip: Boolean)
    begin
        SkipBlockedCustomer := Skip;
    end;

    procedure SetGateEntry(var RecGateHeader: Record "SSD Gate Header")
    begin
        //CF001 St
        GateHeaderNo := RecGateHeader."No.";
        //CF001 En
    end;

    procedure ShowReceiptDialog()
    var
        SpecialHandlingMessage: Text[1024];
    begin
        if not LineCreated then Error(Text000);
        if ErrorOccured then SpecialHandlingMessage := ' ' + StrSubstNo(Text005, WhseReceiptHeader.TableCaption, WhseReceiptLine.FieldCaption("Bin Code"));
        if (ActivitiesCreated = 0) and LineCreated and ErrorOccured then Message(SpecialHandlingMessage);
        if ActivitiesCreated = 1 then Message(StrSubstNo(Text001, ActivitiesCreated, WhseReceiptHeader.TableCaption) + SpecialHandlingMessage);
        if ActivitiesCreated > 1 then Message(StrSubstNo(Text002, ActivitiesCreated) + SpecialHandlingMessage);
    end;

    procedure ShowShipmentDialog()
    var
        SpecialHandlingMessage: Text[1024];
    begin
        if not LineCreated then Error(Text003);
        if ErrorOccured then SpecialHandlingMessage := ' ' + StrSubstNo(Text005, WhseShptHeader.TableCaption, WhseShptLine.FieldCaption("Bin Code"));
        if (ActivitiesCreated = 0) and LineCreated and ErrorOccured then Message(SpecialHandlingMessage);
        if ActivitiesCreated = 1 then Message(StrSubstNo(Text001, ActivitiesCreated, WhseShptHeader.TableCaption) + SpecialHandlingMessage);
        if ActivitiesCreated > 1 then Message(StrSubstNo(Text004, ActivitiesCreated) + SpecialHandlingMessage);
    end;

    procedure SetSkipBlockedItem(Skip: Boolean)
    begin
        SkipBlockedItem := Skip;
    end;
}
