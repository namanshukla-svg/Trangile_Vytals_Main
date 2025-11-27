Report 50301 "Carry Out Action Msg. - Plan1"
{
    // ALLE NV 110216 -- Code Added to bypass Request from from Planning Worksheet.
    Caption = 'Carry Out Action Msg. - Plan.';
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Requisition Line"; "Requisition Line")
        {
            RequestFilterHeading = 'Planning Line';

            column(ReportForNavId_3754;3754)
            {
            }
            trigger OnAfterGetRecord()
            begin
                WindowUpdate;
                if not "Accept Action Message" then CurrReport.Skip;
                LockTable;
                Commit;
                // ALLE NV 110216 >>
                TempReqLine.Init;
                TempReqLine.TransferFields("Requisition Line");
                TempReqLine.Insert;
                // ALLE NV 110216 <<
                if not CreateOrders2 then // ALLE NV 110216.
 begin
                    case "Ref. Order Type" of "ref. order type"::"Prod. Order": if ProdOrderChoice <> Prodorderchoice::" " then CarryOutActions(2, ProdOrderChoice, ProdWkshTempl, ProdWkshName);
                    "ref. order type"::Purchase: if PurchOrderChoice = Purchorderchoice::"Copy to Req. Wksh" then CarryOutActions(0, PurchOrderChoice, ReqWkshTemp, ReqWksh);
                    "ref. order type"::Transfer: if TransOrderChoice <> Transorderchoice::" " then CarryOutActions(1, TransOrderChoice, TransWkshTemp, TransWkshName);
                    else
                        CurrReport.Skip;
                    end;
                end
                else
                begin
                    // ALLE NV 110216 >>.
                    case "Ref. Order Type" of "ref. order type"::"Prod. Order": begin
                        ProdOrderChoice:="Ref. Order Status";
                        CarryOutActions(2, ProdOrderChoice, ProdWkshTempl, ProdWkshName);
                    end;
                    "ref. order type"::Purchase: begin
                        PurchOrderChoice:="Ref. Order Status";
                        CarryOutActions(0, PurchOrderChoice, ReqWkshTemp, ReqWksh);
                    end;
                    "ref. order type"::Transfer: begin
                        TransOrderChoice:="Ref. Order Status";
                        CarryOutActions(1, TransOrderChoice, TransWkshTemp, TransWkshName);
                    end
                    else
                        CurrReport.Skip;
                    end;
                // ALLE NV 110216 <<
                end;
                Commit;
            end;
            trigger OnPostDataItem()
            begin
                Window.Close;
                if PurchOrderChoice in[Purchorderchoice::"Make Purch. Orders", Purchorderchoice::"Make Purch. Orders & Print"]then begin
                    SetRange("Ref. Order Type", "ref. order type"::Purchase);
                    SetRange("Accept Action Message", true);
                    if Find('-')then begin
                        PurchOrderHeader."Order Date":=WorkDate;
                        PurchOrderHeader."Posting Date":=WorkDate;
                        PurchOrderHeader."Expected Receipt Date":=WorkDate;
                        EndOrderDate:=WorkDate;
                        PrintOrders:=(PurchOrderChoice = Purchorderchoice::"Make Purch. Orders & Print");
                        Clear(ReqWkshMakeOrders);
                        ReqWkshMakeOrders.Set(PurchOrderHeader, EndOrderDate, PrintOrders);
                        if not NoPlanningResiliency then ReqWkshMakeOrders.SetPlanningResiliency;
                        ReqWkshMakeOrders.CarryOutBatchAction("Requisition Line");
                        CounterFailed:=CounterFailed + ReqWkshMakeOrders.GetFailedCounter;
                    end;
                end;
                SuccessReserve:=ReserveforPlannedProd; // ALLE NV 110216.
                if SuccessReserve then Message(Text010);
                if CounterFailed > 0 then Message(Text013 + Text014, CounterFailed);
                // ALLE NV 110216 >>
                if CreateOrders2 then begin
                    Window.Open('Sending Mail..');
                    TempReqLine.Reset;
                    if TempReqLine.FindSet then if TempReqLine.Count > 0 then MailSend(TempReqLine);
                    Window.Close;
                end;
            // ALLE NV 110216 <<
            end;
            trigger OnPreDataItem()
            begin
                LockTable;
                TempReqLine.DeleteAll; // ALLE NV 110216;
                SetReqLineFilters;
                //ReqWkshMakeOrders.FromPlanning(FALSE);
                if not "Requisition Line".Find('-')then Error(Text000);
                if PurchOrderChoice = Purchorderchoice::"Copy to Req. Wksh" then CheckCopyToWksh(ReqWkshTemp, ReqWksh);
                if TransOrderChoice = Transorderchoice::"Copy to Req. Wksh" then CheckCopyToWksh(TransWkshTemp, TransWkshName);
                if ProdOrderChoice = Prodorderchoice::"Copy to Req. Wksh" then CheckCopyToWksh(ProdWkshTempl, ProdWkshName);
                Window.Open(Text012);
                CheckPreconditions;
                CounterTotal:=Count;
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(ProdOrderChoice; ProdOrderChoice)
                    {
                        ApplicationArea = All;
                        Caption = 'Production Order';
                        OptionCaption = ' ,Planned,Firm Planned,Firm Planned & Print';
                    }
                    field(PurchOrderChoice; PurchOrderChoice)
                    {
                        ApplicationArea = All;
                        Caption = 'Purchase Order';
                        OptionCaption = ' ,Make Purch. Orders,Make Purch. Orders & Print,Copy to Req. Wksh';

                        trigger OnValidate()
                        begin
                            ReqTempEnable:=PurchOrderChoice = Purchorderchoice::"Copy to Req. Wksh";
                            ReqNameEnable:=PurchOrderChoice = Purchorderchoice::"Copy to Req. Wksh";
                        end;
                    }
                    group("Copy to Req. Worksheet")
                    {
                        Caption = 'Copy to Req. Worksheet';

                        field(ReqTemp; ReqWkshTemp)
                        {
                            ApplicationArea = All;
                            Caption = 'Template Name';
                            Enabled = ReqTempEnable;
                            TableRelation = "Req. Wksh. Template";

                            trigger OnLookup(var Text: Text): Boolean begin
                                if Page.RunModal(Page::"Req. Worksheet Templates", ReqWkshTmpl) = Action::LookupOK then begin
                                    Text:=ReqWkshTmpl.Name;
                                    exit(true);
                                end
                                else
                                    exit(false);
                            end;
                            trigger OnValidate()
                            begin
                                ReqWksh:='';
                            end;
                        }
                        field(ReqName; ReqWksh)
                        {
                            ApplicationArea = All;
                            Caption = 'Worksheet Name';
                            Enabled = ReqNameEnable;
                            TableRelation = "Requisition Wksh. Name".Name;

                            trigger OnLookup(var Text: Text): Boolean begin
                                ReqWkshName.SetFilter("Worksheet Template Name", ReqWkshTemp);
                                if Page.RunModal(Page::"Req. Wksh. Names", ReqWkshName) = Action::LookupOK then begin
                                    Text:=ReqWkshName.Name;
                                    exit(true);
                                end
                                else
                                    exit(false);
                            end;
                        }
                    }
                    field(TransOrderChoice; TransOrderChoice)
                    {
                        ApplicationArea = All;
                        Caption = 'Transfer Order';
                        OptionCaption = ' ,Make Trans. Orders,Make Trans. Orders & Print,Copy to Req. Wksh';

                        trigger OnValidate()
                        begin
                            TransTempEnable:=TransOrderChoice = Transorderchoice::"Copy to Req. Wksh";
                            TransNameEnable:=TransOrderChoice = Transorderchoice::"Copy to Req. Wksh";
                        end;
                    }
                    group(Control13)
                    {
                        Caption = 'Copy to Req. Worksheet';

                        field(TransTemp; TransWkshTemp)
                        {
                            ApplicationArea = All;
                            Caption = 'Template Name';
                            Enabled = TransTempEnable;
                            TableRelation = "Req. Wksh. Template";

                            trigger OnLookup(var Text: Text): Boolean begin
                                if Page.RunModal(Page::"Req. Worksheet Templates", ReqWkshTmpl) = Action::LookupOK then begin
                                    Text:=ReqWkshTmpl.Name;
                                    exit(true);
                                end
                                else
                                    exit(false);
                            end;
                            trigger OnValidate()
                            begin
                                TransWkshName:='';
                            end;
                        }
                        field(TransName; TransWkshName)
                        {
                            ApplicationArea = All;
                            Caption = 'Worksheet Name';
                            Enabled = TransNameEnable;
                            TableRelation = "Requisition Wksh. Name".Name;

                            trigger OnLookup(var Text: Text): Boolean begin
                                ReqWkshName.SetFilter("Worksheet Template Name", TransWkshTemp);
                                if Page.RunModal(Page::"Req. Wksh. Names", ReqWkshName) = Action::LookupOK then begin
                                    Text:=ReqWkshName.Name;
                                    exit(true);
                                end
                                else
                                    exit(false);
                            end;
                        }
                    }
                    field(NoPlanningResiliency; NoPlanningResiliency)
                    {
                        ApplicationArea = All;
                        Caption = 'Stop and Show First Error';
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnInit()
        begin
            TransNameEnable:=true;
            TransTempEnable:=true;
            ReqNameEnable:=true;
            ReqTempEnable:=true;
        end;
        trigger OnOpenPage()
        begin
            ReqTempEnable:=PurchOrderChoice = Purchorderchoice::"Copy to Req. Wksh";
            ReqNameEnable:=PurchOrderChoice = Purchorderchoice::"Copy to Req. Wksh";
            TransTempEnable:=TransOrderChoice = Transorderchoice::"Copy to Req. Wksh";
            TransNameEnable:=TransOrderChoice = Transorderchoice::"Copy to Req. Wksh";
        end;
    }
    labels
    {
    }
    var Text000: label 'There are no planning lines to make orders for.';
    Text007: label 'This template and worksheet are currently active. ';
    Text008: label 'You must select a different template name or worksheet name to copy to.';
    PurchOrderHeader: Record "Purchase Header";
    ReqWkshTmpl: Record "Req. Wksh. Template";
    ReqWkshName: Record "Requisition Wksh. Name";
    ReqLineFilters: Record "Requisition Line";
    CarryOutAction: Codeunit "Carry Out Action";
    ReqWkshMakeOrders: Codeunit "Req. Wksh.-Make Order";
    Window: Dialog;
    ReqWkshTemp: Code[10];
    ReqWksh: Code[10];
    TransWkshTemp: Code[10];
    TransWkshName: Code[10];
    ProdWkshTempl: Code[10];
    ProdWkshName: Code[10];
    CurrReqWkshTemp: Code[10];
    CurrReqWkshName: Code[10];
    ProdOrderChoice: Option " ", Planned, "Firm Planned", "Firm Planned & Print", "Copy to Req. Wksh";
    PurchOrderChoice: Option " ", "Make Purch. Orders", "Make Purch. Orders & Print", "Copy to Req. Wksh";
    TransOrderChoice: Option " ", "Make Trans. Orders", "Make Trans. Orders & Print", "Copy to Req. Wksh";
    Text009: label 'You must select a worksheet to copy to';
    PrintOrders: Boolean;
    ReserveforPlannedProd: Boolean;
    NoPlanningResiliency: Boolean;
    Text010: label 'Components were not reserved for orders with status Planned.';
    Text011: label 'You must make order for both line %1 and %2 because they are associated.';
    Text012: label 'Carrying Out Actions  #1########## @2@@@@@@@@@@@@@';
    Counter: Integer;
    CounterTotal: Integer;
    CounterFailed: Integer;
    Text013: label 'Not all Requistion Lines were carried out.\';
    Text014: label 'A total of %1 lines were not carried out due to errors encountered.';
    EndOrderDate: Date;
    ReqTempEnable: Boolean;
    ReqNameEnable: Boolean;
    TransTempEnable: Boolean;
    TransNameEnable: Boolean;
    "--ALLENV-": Integer;
    CreateOrders2: Boolean;
    TempReqLine: Record "Requisition Line" temporary;
    SuccessReserve: Boolean;
    procedure CarryOutActions(SourceType: Option Purchase, Transfer, Production; Choice: Option; WkshTempl: Code[10]; WkshName: Code[10]): Boolean begin
        if NoPlanningResiliency then begin
            CarryOutAction.SetParameters(SourceType, Choice, WkshTempl, WkshName);
            CarryOutAction.Run("Requisition Line");
        end
        else if not CarryOutAction.TryCarryOutAction(SourceType, "Requisition Line", Choice, WkshTempl, WkshName)then CounterFailed:=CounterFailed + 1;
    end;
    procedure SetReqWkshLine(var CurrentReqLine: Record "Requisition Line")
    begin
        CurrReqWkshTemp:=CurrentReqLine."Worksheet Template Name";
        CurrReqWkshName:=CurrentReqLine."Journal Batch Name";
        ReqLineFilters.Copy(CurrentReqLine);
    end;
    procedure SetDemandOrder(var ReqLine: Record "Requisition Line"; MfgUserTempl: Record "Manufacturing User Template")
    begin
        SetReqWkshLine(ReqLine);
        InitializeRequest(MfgUserTempl."Create Production Order", MfgUserTempl."Create Purchase Order", MfgUserTempl."Create Transfer Order");
        ReqWkshTemp:=MfgUserTempl."Purchase Req. Wksh. Template";
        ReqWksh:=MfgUserTempl."Purchase Wksh. Name";
        ProdWkshTempl:=MfgUserTempl."Prod. Req. Wksh. Template";
        ProdWkshName:=MfgUserTempl."Prod. Wksh. Name";
        TransWkshTemp:=MfgUserTempl."Transfer Req. Wksh. Template";
        TransWkshName:=MfgUserTempl."Transfer Wksh. Name";
        case MfgUserTempl."Make Orders" of MfgUserTempl."make orders"::"The Active Line": begin
            ReqLineFilters:=ReqLine;
            ReqLineFilters.SetRecfilter;
        end;
        MfgUserTempl."make orders"::"The Active Order": begin
            ReqLineFilters.SetCurrentkey("User ID", "Demand Type", "Demand Subtype", "Demand Order No.", "Demand Line No.", "Demand Ref. No.");
            ReqLineFilters.CopyFilters(ReqLine);
            ReqLineFilters.SetRange("Demand Type", ReqLine."Demand Type");
            ReqLineFilters.SetRange("Demand Subtype", ReqLine."Demand Subtype");
            ReqLineFilters.SetRange("Demand Order No.", ReqLine."Demand Order No.");
        end;
        MfgUserTempl."make orders"::"All Lines": ReqLineFilters.Copy(ReqLine);
        end;
    end;
    procedure InitializeRequest(NewProdOrderChoice: Option; NewPurchOrderChoice: Option; NewTransOrderChoice: Option)
    begin
        ProdOrderChoice:=NewProdOrderChoice;
        PurchOrderChoice:=NewPurchOrderChoice;
        TransOrderChoice:=NewTransOrderChoice;
    end;
    procedure SetReqLineFilters()
    begin
        if ReqLineFilters.GetFilters <> '' then "Requisition Line".Copy(ReqLineFilters);
        "Requisition Line".SetRange("Worksheet Template Name", CurrReqWkshTemp);
        "Requisition Line".SetRange("Journal Batch Name", CurrReqWkshName);
        "Requisition Line".SetRange(Type, "Requisition Line".Type::Item);
        "Requisition Line".SetFilter("Action Message", '<>%1', "Requisition Line"."action message"::" ");
    end;
    procedure CheckCopyToWksh(ToReqWkshTempl: Code[10]; ToReqWkshName: Code[10])
    var
        ReqLine: Record "Requisition Line";
    begin
        if(ToReqWkshTempl <> '') and (CurrReqWkshTemp = ToReqWkshTempl) and (CurrReqWkshName = ToReqWkshName)then Error(Text007 + Text008);
        if(ToReqWkshTempl = '') or (ToReqWkshName = '')then Error(Text009);
        if "Requisition Line"."Planning Line Origin" = ReqLine."planning line origin"::"Order Planning" then exit;
        ReqLine.SetRange("Worksheet Template Name", ToReqWkshTempl);
        ReqLine.SetRange("Journal Batch Name", ToReqWkshName);
        ReqLine.DeleteAll(true);
    end;
    procedure CheckPreconditions()
    begin
        repeat CheckLine;
        until "Requisition Line".Next = 0;
    end;
    procedure CheckLine()
    var
        SalesLine: Record "Sales Line";
        ProdOrderComp: Record "Prod. Order Component";
        ReqLine2: Record "Requisition Line";
        DimMgt: Codeunit DimensionManagement;
    begin
        if not(PurchOrderChoice in[Purchorderchoice::"Make Purch. Orders", Purchorderchoice::"Make Purch. Orders & Print"])then begin
        /* // BIS 1145
            JnlLineDim.SETRANGE("Table ID",DATABASE::"Requisition Line");
            JnlLineDim.SETRANGE("Journal Template Name","Worksheet Template Name");
            JnlLineDim.SETRANGE("Journal Batch Name","Journal Batch Name");
            JnlLineDim.SETRANGE("Journal Line No.","Line No.");
            JnlLineDim.SETRANGE("Allocation Line No.",0);

            DimMgt.CopyJnlLineDimToJnlLineDim(JnlLineDim,TempJnlLineDim);
            */
        // BIS 1145
        end;
        if "Requisition Line"."Planning Line Origin" <> "Requisition Line"."planning line origin"::"Order Planning" then exit;
        CheckAssociations("Requisition Line");
        if "Requisition Line"."Planning Level" > 0 then exit;
        if "Requisition Line"."Replenishment System" <> "Requisition Line"."replenishment system"::"Prod. Order" then "Requisition Line".TestField("Supply From");
        if "Requisition Line"."Demand Type" = Database::"Sales Line" then begin
            SalesLine.Get("Requisition Line"."Demand Subtype", "Requisition Line"."Demand Order No.", "Requisition Line"."Demand Line No.");
            SalesLine.TestField(Type, SalesLine.Type::Item);
            if not(("Requisition Line"."Demand Date" = WorkDate) and (SalesLine."Shipment Date" in[0D, WorkDate]))then "Requisition Line".TestField("Demand Date", SalesLine."Shipment Date");
            "Requisition Line".TestField("No.", SalesLine."No.");
            "Requisition Line".TestField("Qty. per UOM (Demand)", SalesLine."Qty. per Unit of Measure");
            "Requisition Line".TestField("Variant Code", SalesLine."Variant Code");
            "Requisition Line".TestField("Location Code", SalesLine."Location Code");
            SalesLine.CalcFields("Reserved Qty. (Base)");
            "Requisition Line".TestField("Demand Quantity (Base)", -SalesLine.SignedXX(SalesLine."Outstanding Qty. (Base)" - SalesLine."Reserved Qty. (Base)"))end;
        if "Requisition Line"."Demand Type" = Database::"Prod. Order Component" then begin
            ProdOrderComp.Get("Requisition Line"."Demand Subtype", "Requisition Line"."Demand Order No.", "Requisition Line"."Demand Line No.", "Requisition Line"."Demand Ref. No.");
            "Requisition Line".TestField("No.", ProdOrderComp."Item No.");
            if not(("Requisition Line"."Demand Date" = WorkDate) and (ProdOrderComp."Due Date" in[0D, WorkDate]))then "Requisition Line".TestField("Demand Date", ProdOrderComp."Due Date");
            "Requisition Line".TestField("Qty. per UOM (Demand)", ProdOrderComp."Qty. per Unit of Measure");
            "Requisition Line".TestField("Variant Code", ProdOrderComp."Variant Code");
            "Requisition Line".TestField("Location Code", ProdOrderComp."Location Code");
            ProdOrderComp.CalcFields("Reserved Qty. (Base)");
            "Requisition Line".TestField("Demand Quantity (Base)", ProdOrderComp."Remaining Qty. (Base)" - ProdOrderComp."Reserved Qty. (Base)");
            if(ProdOrderChoice = Prodorderchoice::Planned) and "Requisition Line".Reserve then ReserveforPlannedProd:=true;
        end;
        ReqLine2.SetCurrentkey("User ID", "Demand Type", "Demand Subtype", "Demand Order No.", "Demand Line No.", "Demand Ref. No.");
        ReqLine2.SetFilter("User ID", '<>%1', UserId);
        ReqLine2.SetRange("Demand Type", "Requisition Line"."Demand Type");
        ReqLine2.SetRange("Demand Subtype", "Requisition Line"."Demand Subtype");
        ReqLine2.SetRange("Demand Order No.", "Requisition Line"."Demand Order No.");
        ReqLine2.SetRange("Demand Line No.", "Requisition Line"."Demand Line No.");
        ReqLine2.SetRange("Demand Ref. No.", "Requisition Line"."Demand Ref. No.");
        ReqLine2.DeleteAll(true);
    end;
    procedure CheckAssociations(var ReqLine: Record "Requisition Line")
    var
        ReqLine2: Record "Requisition Line";
        ReqLine3: Record "Requisition Line";
    begin
        ReqLine3.Copy(ReqLine);
        ReqLine2:=ReqLine;
        if ReqLine2."Planning Level" > 0 then while(ReqLine2.Next(-1) <> 0) and (ReqLine2."Planning Level" > 0)do;
        repeat ReqLine3:=ReqLine2;
            if not ReqLine3.Find then Error(Text011, ReqLine."Line No.", ReqLine2."Line No.");
        until(ReqLine2.Next = 0) or (ReqLine2."Planning Level" = 0)end;
    procedure WindowUpdate()
    begin
        Counter:=Counter + 1;
        Window.Update(1, "Requisition Line"."No.");
        Window.Update(2, ROUND(Counter / CounterTotal * 10000, 1));
    end;
    procedure "--ALLENV"()
    begin
    end;
    procedure SetCarryOut(CreateOrders: Boolean)
    begin
        CreateOrders2:=CreateOrders;
    end;
    procedure MailSend(var TempReqLine2: Record "Requisition Line" temporary)
    var
        //SSDU SMTPMailSetup: Record "SMTP Mail Setup";
        //SSDU SMTPMail: Codeunit "SMTP Mail";
        UserSetup: Record "User Setup";
        EmailId: Text;
        UserEmail: Text[100];
        Text001: label 'Zavenir Daubert Planning Acknowledgement';
        Text002: label 'Planning Acknowledgement Details';
        Text003: label 'Dear Sir/Madam,<br><br>';
        Text004: label '.<br>';
        Item2: Record Item;
    begin
        Clear(EmailId);
        TempReqLine2.Reset;
        if TempReqLine2.FindSet then repeat if Item2.Get(TempReqLine2."No.")then begin
                    if Item2."Replenishment System" = Item2."replenishment system"::Purchase then begin
                        UserSetup.Reset;
                        UserSetup.SetRange("Department Planning Mail", UserSetup."department planning mail"::Purchase);
                        UserSetup.SetFilter("E-Mail", '<>%1', '');
                        if UserSetup.FindSet then repeat if EmailId = '' then EmailId:=UserSetup."E-Mail"
                                else
                                    EmailId+=';' + UserSetup."E-Mail";
                            until UserSetup.Next = 0;
                    end;
                end;
            until TempReqLine2.Next = 0;
    //SSDU Comment Start
    // Clear(SMTPMail);
    // Clear(EmailId);
    // if EmailId <> '' then begin
    //     SMTPMailSetup.Get;
    //     SMTPMailSetup.TestField("SMTP Server");
    //     SMTPMailSetup.TestField("User ID");
    //     SMTPMailSetup.TestField(Password);
    //     SMTPMail.CreateMessage(Text001, SMTPMailSetup."User ID", EmailId, Text002, Text003, true);
    //     TempReqLine2.Reset;
    //     if TempReqLine2.FindSet then
    //         repeat
    //             SMTPMail.AppendBody(TempReqLine2.Description + ' ' + TempReqLine2."Vendor No." + ' ' + Format(TempReqLine2.Quantity) + ' ' + Format(TempReqLine2."Ref. Order Status") + Text004);
    //         until TempReqLine2.Next = 0;
    //     SMTPMail.Send;
    //     Commit;
    // end;
    // Clear(SMTPMail);
    // Clear(EmailId);
    // TempReqLine2.Reset;
    // if TempReqLine2.FindSet then
    //     repeat
    //         if Item2.Get(TempReqLine2."No.") then begin
    //             if Item2."Replenishment System" = Item2."replenishment system"::"Prod. Order" then begin
    //                 UserSetup.Reset;
    //                 UserSetup.SetRange("Department Planning Mail", UserSetup."department planning mail"::Production);
    //                 UserSetup.SetFilter("E-Mail", '<>%1', '');
    //                 if UserSetup.FindSet then
    //                     repeat
    //                         if EmailId = '' then
    //                             EmailId := UserSetup."E-Mail"
    //                         else
    //                             EmailId += ';' + UserSetup."E-Mail";
    //                     until UserSetup.Next = 0;
    //             end;
    //         end;
    //     until TempReqLine2.Next = 0;
    // if EmailId <> '' then begin
    //     SMTPMailSetup.Get;
    //     SMTPMailSetup.TestField("SMTP Server");
    //     SMTPMailSetup.TestField("User ID");
    //     SMTPMailSetup.TestField(Password);
    //     SMTPMail.CreateMessage(Text001, SMTPMailSetup."User ID", EmailId, Text002, Text003, true);
    //     TempReqLine2.Reset;
    //     if TempReqLine2.FindSet then
    //         repeat
    //             SMTPMail.AppendBody(TempReqLine2.Description + ',' + TempReqLine2."Vendor No." + ',' + Format(TempReqLine2.Quantity) + ',' + Format(TempReqLine2."Ref. Order Status") + Text004);
    //         until TempReqLine2.Next = 0;
    //     SMTPMail.Send;
    //     Commit;
    // end;
    //SSDU Comment End
    end;
}
