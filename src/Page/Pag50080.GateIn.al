Page 50080 "Gate In"
{
    // //CF001.01 07.01.2006 added for responsibility center
    // //CF001.02 09.01.2006 During Post, automatically warehouse receipt will be created
    // //CF001.03 30.05.2006 For Subcontracting
    // //CF001.04 20.06.2006 For Sales Return
    // //CE001 04.12.06 For Same Invoice No. against Differtent PO.
    // CML-023 ALLEAG 220208 Start :
    //   - Created functions ReceiveBackRawMaterial,GetApplicationLinesMes,InsertRG23APartI,InsertRG23CPartI.
    //   - In the above mentioned functions code has been written to create the gate entries against the posted delivery challan.
    // ALLEAA CML-033 280308
    //   - Code Added for Subcontracting MRN
    // CML-034 ALLEAG 210408 :
    //   - Displayed Field "Customer RGP No.".
    // 
    // CML 50 check for Bill date also
    DeleteAllowed = true;
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "SSD Gate Header";
    SourceTableView = sorting("No.")order(ascending)where("Ref. Document Type"=filter(<>"Cash Purchase"));
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
                    AssistEdit = true;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(Rec)then CurrPage.Update;
                    end;
                }
                field(Scan; Rec.Scan)
                {
                    ApplicationArea = All;
                }
                field("Party Type"; Rec."Party Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Subfrm.Page.DeleteGateLines(Rec);
                        PartyTypeOnAfterValidate;
                    end;
                }
                field("Party No."; Rec."Party No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Subfrm.Page.DeleteGateLines(Rec);
                        PartyNoOnAfterValidate;
                    end;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field(Address2; Rec.Address2)
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("GST Reg.No.Last Four Digit"; Rec."GST Registration No. Manual")
                {
                    ApplicationArea = All;
                    Caption = 'GST Reg.No.Last Four Digit';
                }
                field("In Time"; Rec."In Time")
                {
                    ApplicationArea = All;
                }
                field("Register No."; Rec."Register No.")
                {
                    ApplicationArea = All;
                    Caption = 'Register Entry No.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field(RDT; Rec."Ref. Document Type")
                {
                    ApplicationArea = All;
                    Caption = 'Ref. Document Type';
                    Editable = true;
                    Enabled = true;

                    trigger OnValidate()
                    begin
                        CurrPage.Subfrm.Page.DeleteGateLines(Rec);
                        //************* CEN003 ***************
                        /*
                        IF "Ref. Document Type"= 3 THEN
                           "Ref. Document No.Editable" := FALSE
                        ELSE
                           "Ref. Document No.Editable" := TRUE;
                        */
                        CurrPage.Subfrm.Page.ChangeEditableMode(Rec);
                    //CurrPage.Subfrm.FORM.UPDATECONTROLS; //BIS 1145
                    //************* CEN003 ***************
                    end;
                }
                field("Ref. Document No."; Rec."Ref. Document No.")
                {
                    ApplicationArea = All;
                    Editable = "Ref. Document No.Editable";

                    trigger OnValidate()
                    begin
                        CurrPage.Subfrm.Page.DeleteGateLines(Rec);
                        CurrPage.Subfrm.Page.InsertGateLines(Rec);
                        //ssd
                        //check removed
                        //IF "Ref. Document Type" = "Ref. Document Type"::"Posted Delivery Challan" THEN
                        // ERROR('Please select Subcontracting');
                        //ssd
                        RefDocumentNoOnAfterValidate;
                    end;
                }
                //SSD Sunil_Not required and confirmed by Hemant
                /*
                field("ST38 No."; Rec."ST38 No.")
                {
                    ApplicationArea = All;
                    Caption = 'Page 31';
                }
                */
                field("Bill No."; Rec."Bill No.")
                {
                    ApplicationArea = All;
                }
                field("Bill Date"; Rec."Bill Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if Rec."Bill Date" > Rec."Posting Date" then Error('Bill Date Cant be Greater than Posting Date');
                    end;
                }
                field("Bill Amount"; Rec."Bill Amount")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    Caption = 'Department';
                }
                field("Register Entry Date"; Rec."Register Entry Date")
                {
                    ApplicationArea = All;
                }
                field("Customer RGP No."; Rec."Customer RGP No.")
                {
                    ApplicationArea = All;
                }
                field(Trading; Rec.Trading)
                {
                    ApplicationArea = All;
                }
            }
            part(Subfrm; "Gate In Subform")
            {
                SubPageLink = "Document No."=field("No.");
                SubPageView = sorting("Document No.", "Line No.");
                ApplicationArea = All;
            }
            group(Others)
            {
                Caption = 'Others';

                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ApplicationArea = All;
                }
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
            group("&Post")
            {
                Caption = '&Post';

                action(Post)
                {
                    ApplicationArea = All;
                    Caption = '&Post';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    var
                        PurchaseHeader: Record "Purchase Header";
                        Text50000: label 'Purchase header date should not be grater than Gate Entry date .';
                    begin
                        // Alle 041016 <<
                        if PurchaseHeader.Get(PurchaseHeader."document type"::Order, Rec."Ref. Document No.")then if(PurchaseHeader."Document Date" > Rec."Posting Date") or (PurchaseHeader."Posting Date" > Rec."Posting Date")then Error(Text50000);
                        // Alle 041016 >>
                        //ALLE-NM 07082019
                        if CopyStr(Rec."GST Registration No.", 12, 4) <> Rec."GST Registration No. Manual" then Error('GST Registration No. must be same');
                        //ALLE-NM 07082019
                        PostGateEntry(Rec);
                    end;
                }
            }
        }
    }
    trigger OnInit()
    begin
        "Ref. Document No.Editable":=true;
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //CF001.01 St
        Rec."Responsibility Center":=UserMgt.GetRespCenterFilter;
    end;
    trigger OnOpenPage()
    begin
    //CF001.01 St
    // if UserMgt.GetRespCenterFilter <> '' then begin
    //     Rec.FilterGroup(2);
    //     Rec.SetRange("Responsibility Center", UserMgt.GetRespCenterFilter);
    //     Rec.FilterGroup(0);
    // end;
    //CF001.01 En
    end;
    var Text000: label 'Do you want to post the gate entry?';
    GateEntryLine: Record "SSD Gate Line";
    Text001: label 'is not within your range of allowed posting dates';
    AllowPostingFrom: Date;
    AllowPostingTo: Date;
    UserSetup: Record "User Setup";
    GLSetup: Record "General Ledger Setup";
    GateLine: Record "SSD Gate Line";
    PostedGateHeader: Record "SSD Posted Gate Header";
    PostedGateLine: Record "SSD Posted Gate Line";
    GateRegister: Record "SSD Gate Register";
    LastEntryNo: Integer;
    "-MeS-": Integer;
    UserMgt: Codeunit "SSD User Setup Management";
    Text002: label 'Gate Entry %1 has posted successfully';
    Text003: label '%1 - %2 already exit for %3 - %4 ';
    Text004: label '%1 cannot be zero at Line No. %2';
    "-ALLEAG-": Integer;
    CompItem: Record Item;
    ItemJnlLine: Record "Item Journal Line";
    RemQtytoPost: Decimal;
    TotalQtyToPost: Decimal;
    Text005: label 'In case of RGP Inbound, Customer RGP No. must be filled.';
    DeliveryChallanHeader: Record "Delivery Challan Header";
    item: Record Item;
    ItemSamplingTemplate: Record "Item Sampling Template";
    "Ref. Document No.Editable": Boolean;
    procedure PostGateEntry(var GateHeader: Record "SSD Gate Header")
    var
        PurchaseLineLocal: Record "Purchase Line";
        GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
        PurchaseHeaderLocal: Record "Purchase Header";
        SalesHeaderLocal: Record "Sales Header";
        SalesLineLocal: Record "Sales Line";
    begin
        if not Confirm(Text000, false)then exit;
        Rec.TestField("Register No.");
        Rec.TestField("Register Entry Date");
        if Rec."Ref. Document Type" = Rec."ref. document type"::"Posted Delivery Challan" then ReceiveBackRawMaterial();
        CheckGateEntry(GateHeader);
        //Insert Posted Header
        PostedGateHeader.Init;
        PostedGateHeader.TransferFields(GateHeader);
        PostedGateHeader.Insert;
        //Insert Posted Lines
        GateLine.Reset;
        GateLine.SetRange("Document No.", GateHeader."No.");
        GateLine.Find('-');
        GateRegister.LockTable;
        if GateRegister.Find('+')then LastEntryNo:=GateRegister."Entry No."
        else
            LastEntryNo:=0;
        repeat PostedGateLine.Init;
            PostedGateLine.TransferFields(GateLine);
            PostedGateLine."Responsibility Center":=GateHeader."Responsibility Center";
            PostedGateLine.Date:=GateHeader."Posting Date";
            PostedGateLine.Insert;
            InsertGateRegister(GateLine, GateHeader); //Insert Gate Register
            if GateHeader."Ref. Document Type" in[GateHeader."ref. document type"::"Purchase Order", GateHeader."ref. document type"::"Purchase Schedule", GateHeader."ref. document type"::Subcontracting]then begin
                PurchaseLineLocal.Reset;
                PurchaseLineLocal.SetRange("Document Type", PurchaseLineLocal."document type"::Order);
                if GateHeader."Ref. Document Type" = GateHeader."ref. document type"::Subcontracting then begin
                    if DeliveryChallanHeader.Get(GateHeader."Ref. Document No.")then PurchaseLineLocal.SetRange("Document No.", DeliveryChallanHeader."Sub. order No.");
                end
                else
                begin
                    PurchaseLineLocal.SetRange("Document No.", GateHeader."Ref. Document No.");
                end;
                PurchaseLineLocal.SetRange("Line No.", GateLine."Ref. Document Line No.");
                PurchaseLineLocal.SetRange(Type, PurchaseLineLocal.Type::Item, PurchaseLineLocal.Type::"Fixed Asset"); //5.51
                PurchaseLineLocal.SetRange("No.", GateLine."No.");
                if PurchaseLineLocal.Find('-')then begin
                    PurchaseLineLocal."Gate Entry no.":=PostedGateHeader."No.";
                    PurchaseLineLocal."Gate Entry Date":=GateHeader."Posting Date";
                    PurchaseLineLocal."Gate Line No.":=GateLine."Line No.";
                    //IF GateLine.Type = GateLine.Type::"Fixed Asset" THEN BEGIN //allE 5.51
                    PurchaseLineLocal.Validate("Qty. to Receive", GateLine."Challan Quantity"); //5.51vK
                    PurchaseLineLocal."Gate Entry no.":=PostedGateHeader."No.";
                    //END;
                    if GateHeader."Ref. Document Type" = GateHeader."ref. document type"::Subcontracting then begin //5.51VK
                        PurchaseLineLocal.Validate(PurchaseLineLocal."Qty. to Receive", GateLine."Challan Quantity"); //5.5
                        if item.Get(GateLine."No.")then;
                        PurchaseLineLocal."Quality Required":=item."Quality Required";
                        ItemSamplingTemplate.Reset;
                        ItemSamplingTemplate.SetRange(ItemSamplingTemplate."Item Code", GateLine."No.");
                        ItemSamplingTemplate.SetRange(ItemSamplingTemplate.Active, true);
                        if ItemSamplingTemplate.FindFirst then PurchaseLineLocal."Quality Rcpt Template":=ItemSamplingTemplate."Sampling Temp. No.";
                        PurchaseLineLocal."Quality Done":=false;
                        PurchaseLineLocal."Quality Send":=false;
                    end;
                    PurchaseLineLocal.Modify;
                end;
            end
            else if GateHeader."Ref. Document Type" in[GateHeader."ref. document type"::"Sales Returns"]then begin
                    SalesLineLocal.Reset;
                    SalesLineLocal.SetRange("Document Type", SalesLineLocal."document type"::"Return Order");
                    SalesLineLocal.SetRange("Document No.", GateHeader."Ref. Document No.");
                    SalesLineLocal.SetRange("Line No.", GateLine."Ref. Document Line No.");
                    SalesLineLocal.SetRange(Type, SalesLineLocal.Type::Item);
                    SalesLineLocal.SetRange("No.", GateLine."No.");
                    if SalesLineLocal.Find('-')then begin
                        SalesLineLocal."Gate Entry no.":=PostedGateHeader."No.";
                        SalesLineLocal."Gate Entry Date":=GateHeader."Posting Date";
                        SalesLineLocal."Gate Line No.":=GateLine."Line No.";
                        SalesLineLocal.Modify;
                    end;
                end;
        until GateLine.Next = 0;
        //Automatically creation of WH Receipt
        if GateHeader."Ref. Document Type" in[GateHeader."ref. document type"::"Purchase Order", GateHeader."ref. document type"::"Purchase Schedule"]then begin
            PurchaseHeaderLocal.Get(PurchaseHeaderLocal."document type"::Order, GateHeader."Ref. Document No.");
            if CheckingForWHRcvdReqn(GateHeader)then //Checking For "Warehouse Receive Required" at Location Card
 CreateWHRFromPurchOrder(PurchaseHeaderLocal);
        end
        else if GateHeader."Ref. Document Type" in[GateHeader."ref. document type"::"Sales Returns"]then begin
                SalesHeaderLocal.Get(SalesHeaderLocal."document type"::"Return Order", GateHeader."Ref. Document No.");
                CheckingForWHRcvdReqn(GateHeader); //Checking For "Warehouse Receive Required" at Location Card
                CreateWHRFromSalesOrder(SalesHeaderLocal);
            end;
        //ALLE-SS 261015 Start
        /*
        IF GateHeader."Ref. Document Type" IN [GateHeader."Ref. Document Type"::"RGP Inbound"] THEN
        CurrPage.Subfrm.PAGE.CreateRGP(Rec);
        */
        //ALLE-SS 261015 End
        /*
        IF GateHeader."Ref. Document Type" IN [GateHeader."Ref. Document Type"::Subcontracting] THEN
            CurrForm.Subfrm.PAGE.CreateSubconRGPLine(Rec);
        */
        //commented 5.51
        GateLine.DeleteAll;
        GateHeader.Delete;
        Message(Text002, PostedGateHeader."No.");
        CurrPage.Update;
        Commit; //5.51
    end;
    procedure CheckGateEntry(GateHeader: Record "SSD Gate Header")
    var
        PostedGateHeaderLocal: Record "SSD Posted Gate Header";
        AccPerStDate: Date;
        AccoutingPeriod: Record "Accounting Period";
    begin
        if DateNotAllowed(Rec."Posting Date")then Rec.FieldError("Posting Date", Text001);
        GateHeader.TestField("No.");
        GateHeader.TestField("Party No.");
        GateHeader.TestField("Bill No.");
        GateHeader.TestField("Bill Date");
        if GateHeader."Ref. Document Type" <> 3 then begin //***********CEN003*****
            PostedGateHeaderLocal.Reset;
            PostedGateHeaderLocal.SetCurrentkey("Party Type", "Party No.", "Bill No.", Blocked);
            PostedGateHeaderLocal.SetRange("Party Type", GateHeader."Party Type");
            PostedGateHeaderLocal.SetRange("Party No.", GateHeader."Party No.");
            PostedGateHeaderLocal.SetRange("Bill No.", GateHeader."Bill No.");
            if AccoutingPeriod.FindLast then AccPerStDate:=CalcDate('-12M', AccoutingPeriod."Starting Date");
            PostedGateHeaderLocal.SetRange("Bill Date", AccPerStDate, GateHeader."Bill Date"); // CML 50 check for Bill date also
            // PostedGateHeaderLocal.SETRANGE("Bill Date",GateHeader."Bill Date");// CML 50 check for Bill date also
            PostedGateHeaderLocal.SetRange(Blocked, false); //In case of Blocked Gate entry Same Bill No. is Allowed.//CEN005
            //******************** CE001 Start *******************************
            if PostedGateHeaderLocal.Find('-')then Error(Text003, GateHeader.FieldCaption("Bill No."), GateHeader."Bill No.", Format(GateHeader."Party Type"), GateHeader."Party No.");
            //******************** CE001 End   *******************************
            //ALLEAA CML-033 280308 Start >>
            if(GateHeader."Ref. Document Type" = GateHeader."ref. document type"::"Sales Returns") or (GateHeader."Ref. Document Type" = GateHeader."ref. document type"::"RGP Inbound") or (GateHeader."Ref. Document Type" = GateHeader."ref. document type"::Subcontracting) or (GateHeader."Ref. Document Type" = GateHeader."ref. document type"::Other)then begin
            end
            else
                GateHeader.TestField("Ref. Document No.");
        //ALLEAA CML-033 280308 End <<
        end;
        GateLine.SetRange("Document No.", GateHeader."No.");
        if GateLine.Find('-')then repeat if GateLine."Challan Quantity" = 0 then Error(Text004, GateLine.FieldCaption("Challan Quantity"), GateLine."Line No.");
            until GateLine.Next = 0
        else
            Error('There is nothing to post')end;
    procedure DateNotAllowed(PostingDate: Date): Boolean begin
        if(AllowPostingFrom = 0D) and (AllowPostingTo = 0D)then begin
            if UserId <> '' then if UserSetup.Get(UserId)then begin
                    AllowPostingFrom:=UserSetup."Allow Posting From";
                    AllowPostingTo:=UserSetup."Allow Posting To";
                end;
            if(AllowPostingFrom = 0D) and (AllowPostingTo = 0D)then begin
                GLSetup.Get;
                AllowPostingFrom:=GLSetup."Allow Posting From";
                AllowPostingTo:=GLSetup."Allow Posting To";
            end;
            if AllowPostingTo = 0D then AllowPostingTo:=99991231D;
        end;
        exit((PostingDate < AllowPostingFrom) or (PostingDate > AllowPostingTo));
    end;
    procedure InsertGateRegister(GateLine: Record "SSD Gate Line"; GateHeader: Record "SSD Gate Header")
    begin
        LastEntryNo+=1;
        GateRegister.Init;
        GateRegister."Entry No.":=LastEntryNo;
        GateRegister."Gate Entry Type":=GateRegister."gate entry type"::Inbound;
        GateRegister."Gate Entry No.":=GateLine."Document No.";
        GateRegister."Gate Entry Date":=WorkDate;
        GateRegister."Gate Entry Time":=GateHeader."In Time";
        case GateLine."Ref. Document Type" of GateLine."ref. document type"::"Sales Returns": GateRegister."Document Type":=GateRegister."document type"::"Sales Return";
        GateLine."ref. document type"::"Purchase Order": GateRegister."Document Type":=GateRegister."document type"::"Purchase Order";
        GateLine."ref. document type"::"RGP Outbound": GateRegister."Document Type":=GateRegister."document type"::"RGP Outbound";
        GateLine."ref. document type"::"Purchase Schedule": GateRegister."Document Type":=GateRegister."document type"::"Purchase Schedule";
        end;
        GateRegister."Document No.":=GateLine."Ref. Document No.";
        GateRegister.NRGP:=false;
        GateRegister."Document Line No.":=GateLine."Line No.";
        GateRegister."Party Type":=GateLine."Party Type";
        GateRegister."Party No.":=GateLine."Party No.";
        GateRegister."Party Name":=GateHeader.Name;
        GateRegister."Challan/Bill No.":=GateHeader."Bill No.";
        GateRegister."Challan/Bill Date":=GateHeader."Bill Date";
        GateRegister."User ID":=UserId;
        GateRegister.Remarks:=GateHeader.Remarks;
        GateRegister.Type:=GateRegister.Type::Item;
        GateRegister."No.":=GateLine."No.";
        GateRegister.Quantity:=GateLine."Challan Quantity";
        GateRegister."Vechile No.":=GateHeader."Vehicle No.";
        GateRegister.Description:=GateLine.Description;
        GateRegister."Unit of Measure Code":=GateLine."Unit of Measure Code";
        GateRegister."Responsibility Center":=GateHeader."Responsibility Center";
        //>>CEN004.05
        GateRegister."Register No.":=GateHeader."Register No.";
        GateRegister."Register Entry Date":=GateHeader."Register Entry Date";
        //<<CEN004.05
        GateRegister.Insert;
    end;
    procedure CreateWHRFromPurchOrder(PurchHeader: Record "Purchase Header")
    var
        WhseRqst: Record "Warehouse Request";
        WhseRcptHeader: Record "Warehouse Receipt Header";
        GetSourceDocuments: Report "SSD Get Source Documents";
    begin
        //CF001.02 St
        //***** Create Warehouse Recipt from Purch. Line
        with PurchHeader do begin
            PurchHeader.TestField(Status, PurchHeader.Status::Released);
            WhseRqst.SetRange(Type, WhseRqst.Type::Inbound);
            WhseRqst.SetRange("Source Type", Database::"Purchase Line");
            WhseRqst.SetRange("Source Subtype", PurchHeader."Document Type");
            WhseRqst.SetRange("Source No.", PurchHeader."No.");
            WhseRqst.SetRange("Document Status", WhseRqst."document status"::Released);
            if WhseRqst.Find('-')then begin
                GetSourceDocuments.UseRequestPage(false);
                GetSourceDocuments.SetTableview(WhseRqst);
                GetSourceDocuments.SetGateEntry(Rec); //SSDU _Uncomment
                GetSourceDocuments.RunModal;
                GetSourceDocuments.GetLastReceiptHeader(WhseRcptHeader);
            end;
        end;
    //CF001.02 En
    end;
    procedure CheckingForWHRcvdReqn(RecGateHeader: Record "SSD Gate Header")Receive: Boolean var
        GateLineLocal: Record "SSD Gate Line";
        PurchaseLineLocal: Record "Purchase Line";
        LocationLocal: Record Location;
        SalesLineLocal: Record "Sales Line";
    begin
        //CF001.03 St
        GateLineLocal.Reset;
        GateLineLocal.SetRange("Document No.", RecGateHeader."No.");
        if GateLineLocal.Find('-')then repeat if GateLineLocal."Ref. Document Type" in[GateLineLocal."ref. document type"::"Purchase Order", GateLineLocal."ref. document type"::"Purchase Schedule"]then begin
                    PurchaseLineLocal.Get(PurchaseLineLocal."document type"::Order, GateLineLocal."Ref. Document No.", GateLineLocal."Ref. Document Line No.");
                    PurchaseLineLocal.TestField("Location Code");
                    if LocationLocal.Get(PurchaseLineLocal."Location Code")then Receive:=LocationLocal."Require Receive";
                    if LocationLocal."Bin Mandatory" then PurchaseLineLocal.TestField("Bin Code");
                end
                else if GateLineLocal."Ref. Document Type" in[GateLineLocal."ref. document type"::"Sales Returns"]then begin
                        //CF001.04 St
                        SalesLineLocal.Get(SalesLineLocal."document type"::"Return Order", GateLineLocal."Ref. Document No.", GateLineLocal."Ref. Document Line No.");
                        SalesLineLocal.TestField("Location Code");
                        if LocationLocal.Get(SalesLineLocal."Location Code")then Receive:=LocationLocal."Require Receive";
                        if LocationLocal."Bin Mandatory" then SalesLineLocal.TestField("Bin Code");
                    //CF001.04 en
                    end until GateLineLocal.Next = 0;
    //CF001.03 En
    end;
    procedure CreateWHRFromSalesOrder(RecSalesHeader: Record "Sales Header")
    var
        WhseRqst: Record "Warehouse Request";
        WhseRcptHeader: Record "Warehouse Receipt Header";
        GetSourceDocuments: Report "SSD Get Source Documents";
    begin
        //CF001.04 St
        //***** Create Warehouse Recipt from Purch. Line
        RecSalesHeader.TestField(Status, RecSalesHeader.Status::Released);
        WhseRqst.SetRange(Type, WhseRqst.Type::Inbound);
        WhseRqst.SetRange("Source Type", Database::"Sales Line");
        WhseRqst.SetRange("Source Subtype", RecSalesHeader."Document Type");
        WhseRqst.SetRange("Source No.", RecSalesHeader."No.");
        WhseRqst.SetRange("Document Status", WhseRqst."document status"::Released);
        if WhseRqst.Find('-')then begin
            GetSourceDocuments.UseRequestPage(false);
            GetSourceDocuments.SetTableview(WhseRqst);
            GetSourceDocuments.SetGateEntry(Rec);
            GetSourceDocuments.RunModal;
            GetSourceDocuments.GetLastReceiptHeader(WhseRcptHeader);
        end;
    //CF001.04 En
    end;
    procedure "---ALLEAG---"()
    begin
    end;
    procedure ReceiveBackRawMaterial()
    var
        CompItem: Record Item;
        CalcBasedOn: Option "Actual Output", "Expected Output";
        ILE: Record "Item Ledger Entry";
        Completed: Boolean;
        TempILE: Record "Item Ledger Entry";
        AvailableQty: Decimal;
        SourceCodeSetup: Record "Source Code Setup";
        DeliveryChallanLine: Record "Delivery Challan Line";
        WMSMgmt: Codeunit "WMS Management";
        LocationLocal: Record Location;
        WhseJnlLine: Record "Warehouse Journal Line";
        WhseJnlPostLine: Codeunit "Whse. Jnl.-Register Line";
    begin
        //CML-023 ALLEAG 220208 Start
        GateLine.Reset;
        GateLine.SetRange("Document No.", Rec."No.");
        if GateLine.Find('-')then repeat SourceCodeSetup.Get;
                DeliveryChallanLine.Get(Rec."Ref. Document No.", GateLine."Line No.");
                CompItem.Get(GateLine."No.");
                CompItem.TestField("Rounding Precision");
                TotalQtyToPost:=ROUND(GateLine."Challan Quantity", 0.00001);
                TotalQtyToPost:=ROUND(TotalQtyToPost, CompItem."Rounding Precision", '>');
                RemQtytoPost:=TotalQtyToPost;
                ILE.Reset;
                GetApplicationLinesMes(DeliveryChallanLine, ILE, TotalQtyToPost); //mes
                if ILE.Find('-')then;
                if RemQtytoPost <> 0 then repeat ItemJnlLine.Init;
                        ItemJnlLine.Subcontracting:=true;
                        ItemJnlLine.Validate("Entry Type", ItemJnlLine."entry type"::Transfer);
                        ItemJnlLine.Validate("Item No.", GateLine."No.");
                        ItemJnlLine.Validate("Unit of Measure Code", GateLine."Unit of Measure Code");
                        ItemJnlLine.Description:=GateLine.Description;
                        if ILE."Remaining Quantity" <> 0 then begin
                            if RemQtytoPost > ILE."Remaining Quantity" then begin
                                RemQtytoPost-=ILE."Remaining Quantity";
                                ItemJnlLine.Validate(Quantity, ILE."Remaining Quantity");
                            end
                            else
                            begin
                                ItemJnlLine.Validate(Quantity, RemQtytoPost);
                                Completed:=true;
                            end;
                            ItemJnlLine."Quantity (Base)":=ItemJnlLine.Quantity;
                            ItemJnlLine."Invoiced Quantity":=ItemJnlLine.Quantity;
                            ItemJnlLine."Invoiced Qty. (Base)":=ItemJnlLine.Quantity;
                            ItemJnlLine.Validate("Applies-to Entry", ILE."Entry No.");
                            ILE.CalcFields(ILE."Cost Amount (Actual)");
                            if ILE."Cost Amount (Actual)" <> 0 then begin
                                ItemJnlLine.Validate("Unit Cost", ILE."Cost Amount (Actual)" / ILE.Quantity * ItemJnlLine.Quantity);
                            end;
                            ItemJnlLine.Validate("Location Code", DeliveryChallanLine."Vendor Location");
                            ItemJnlLine.Validate("New Location Code", DeliveryChallanLine."Company Location");
                            ItemJnlLine."Gen. Prod. Posting Group":=CompItem."Gen. Prod. Posting Group";
                            ItemJnlLine."Item Category Code":=CompItem."Item Category Code";
                            ItemJnlLine."Inventory Posting Group":=CompItem."Inventory Posting Group";
                            ItemJnlLine."Bin Code":=DeliveryChallanLine."Vendor Bin Code";
                            ItemJnlLine."New Bin Code":=DeliveryChallanLine."Company Bin Code";
                            ItemJnlLine.Validate("Shortcut Dimension 1 Code", DeliveryChallanLine."Shortcut Dimension 1 Code");
                            ItemJnlLine.Validate("Shortcut Dimension 2 Code", DeliveryChallanLine."Shortcut Dimension 2 Code");
                            ItemJnlLine."External Document No.":=Rec."Delivery Challan No.";
                            ItemJnlLine."Source Code":=SourceCodeSetup."Item Journal";
                            ItemJnlLine.Validate("Posting Date", Rec."Posting Date");
                            ItemJnlLine."Document Date":=Rec."Posting Date";
                            ItemJnlLine."Document No.":=GateLine."Document No.";
                            ItemJnlLine.Subcontracting:=true;
                            Codeunit.Run(22, ItemJnlLine);
                            //Creating Warehouse Entry
                            if LocationLocal.Get(ItemJnlLine."Location Code")then if LocationLocal."Bin Mandatory" then begin
                                    WMSMgmt.CreateWhseJnlLine(ItemJnlLine, 1, WhseJnlLine, false); // BIS 1145
                                    WMSMgmt.CheckWhseJnlLine(WhseJnlLine, 2, 0, false);
                                    WhseJnlPostLine.Run(WhseJnlLine);
                                end;
                        end;
                    until(ILE.Next = 0) or Completed;
            until GateLine.Next = 0;
    //CML-023 ALLEAG 220208 Finish 
    end;
    procedure GetApplicationLinesMes(DeliveryChallanLineLocal: Record "Delivery Challan Line"; var ILE: Record "Item Ledger Entry"; TotalQtyToPost: Decimal)
    var
        TempILE: Record "Item Ledger Entry";
        AvailableQty: Decimal;
    begin
        //CML-023 ALLEAG 220208 Start
        ILE.Reset;
        ILE.SetCurrentkey("Item No.", "Location Code");
        ILE.SetRange("Item No.", DeliveryChallanLineLocal."Item No.");
        ILE.SetRange("Location Code", DeliveryChallanLineLocal."Vendor Location");
        ILE.SetRange("External Document No.", DeliveryChallanLineLocal."Delivery Challan No.");
        TempILE.Reset;
        TempILE.Copy(ILE);
        if TempILE.Find('-')then repeat AvailableQty+=TempILE."Remaining Quantity";
            until TempILE.Next = 0;
        if not(AvailableQty >= TotalQtyToPost)then Error('Item %1 is not in Inventory!!!', DeliveryChallanLineLocal."Item No.");
    //CML-023 ALLEAG 220208 Finish
    end;
    procedure GateHeader()GateHeader: Code[20]begin
        exit(Rec."No.");
    end;
    local procedure PartyTypeOnAfterValidate()
    begin
        CurrPage.Update;
    //CurrPage.Subfrm.FORM.UPDATECONTROLS; //BIS 1145
    end;
    local procedure PartyNoOnAfterValidate()
    begin
        CurrPage.Update;
    //CurrPage.Subfrm.FORM.UPDATECONTROLS; //BIS 1145
    end;
    local procedure RefDocumentNoOnAfterValidate()
    begin
        CurrPage.Update;
    //CurrPage.Subfrm.FORM.UPDATECONTROLS; //BIS 1145
    end;
}
