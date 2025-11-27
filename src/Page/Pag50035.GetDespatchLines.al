Page 50035 "Get Despatch Lines"
{
    //             //******CE001*****for Despatch Information
    // CEN004.06 For Flow RGp Receipt No.
    // CML-026 Ashish 150108
    // CMLTEST-026 AA 250108
    //   - Validate Location and Structure
    // CML-034 ALLEAG 240408 :
    //   - Written code to flow the value of Subcontracting.
    // ALLE 3.08 Written code for Freight Zone
    // ALLE 1.07 Document Attachment
    // ALLE 3.14....ARE1
    // ALLE 3.15....ARE3
    // ALLE 3.16....ARE3
    Editable = false;
    PageType = List;
    SourceTable = "Sales Line";
    SourceTableView = sorting("Document Type", "Document No.", "Line No.")order(descending)where("Document Type"=const(Order), "Document Subtype"=const(Despatch));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Cross-Reference No."; Rec."Item Reference No.")
                {
                    ApplicationArea = All;
                }
                field("No.2"; Rec."No.2")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Ship"; Rec."Qty. to Ship")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Qty. to Invoice"; Rec."Qty. to Invoice")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Quantity Shipped"; Rec."Quantity Shipped")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Order No."; Rec."Order No.")
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
            action(OK)
            {
                ApplicationArea = All;
                Caption = 'OK';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    CurrPage.SetSelectionFilter(Rec);
                    CreateInvLines(Rec, SalesHeader);
                    CurrPage.Close;
                end;
            }
        }
    }
    var SalesHeader: Record "Sales Header";
    Text001: label 'The %1 on the %2 %3 and the %4 %5 must be the same.';
    Text002: label 'Creating Sales Invoice Lines\';
    Text003: label 'Inserted lines             #1######';
    TotGrossWt: Decimal;
    Document: Record "SSD Document";
    DocumentRec: Record "SSD Document";
    DocAccMgt: Report "Document Access Management";
    procedure SetSalesHeader(var SalesHeader2: Record "Sales Header")
    begin
        SalesHeader.Get(SalesHeader2."Document Type", SalesHeader2."No.");
        SalesHeader.TestField("Document Type", SalesHeader."document type"::Invoice);
    end;
    procedure CreateInvLines(var SalesDespLine2: Record "Sales Line"; var SalesHeader2: Record "Sales Header")
    var
        DifferentCurrencies: Boolean;
        DimMgt: Codeunit DimensionManagement;
        LineCount: Integer;
        SalesLineLocal: Record "Sales Line";
        SalesDespHeaderLocal: Record "Sales Header";
        SalesDespLineLocal: Record "Sales Line";
        RecLoaction: Record Location;
        RecSalesHeader: Record "Sales Header";
    begin
        Rec.SetSalesHeader(SalesHeader2);
        DeleteInvoiceLines(SalesHeader2);
        SalesDespLine2.SetRange("Document Type", SalesDespLine2."document type"::Order);
        SalesDespLine2.SetRange("Document Subtype", SalesDespLine2."document subtype"::Despatch);
        SalesDespLine2.SetFilter("Qty. to Ship", '<>0');
        if SalesDespLine2.Find('-')then begin
            SalesLineLocal.LockTable;
            SalesLineLocal.SetRange("Document Type", SalesHeader."Document Type");
            SalesLineLocal.SetRange("Document No.", SalesHeader."No.");
            SalesLineLocal."Document Type":=SalesHeader."Document Type";
            SalesLineLocal."Document No.":=SalesHeader."No.";
            TotGrossWt:=0; //ALLE 3.08
            repeat LineCount:=LineCount + 1;
                if(SalesDespHeaderLocal."No." <> SalesDespLine2."Document No.")then begin
                    SalesDespHeaderLocal.Get(SalesDespLine2."Document Type", SalesDespLine2."Document No.");
                    SalesDespHeaderLocal.TestField("Bill-to Customer No.", SalesDespLine2."Bill-to Customer No.");
                    DifferentCurrencies:=false;
                    if SalesDespHeaderLocal."Currency Code" <> SalesHeader."Currency Code" then begin
                        Message(Text001, SalesHeader.FieldCaption("Currency Code"), SalesHeader.TableCaption, SalesHeader."No.", SalesDespHeaderLocal.TableCaption, SalesDespHeaderLocal."No.");
                        DifferentCurrencies:=true end;
                end;
                if not DifferentCurrencies then begin
                    SalesDespLineLocal:=SalesDespLine2;
                    //SalesDespLineLocal.InsertInvLineFromDespLine(SalesLineLocal,TempFromLineDim); // BIS 1145
                    SalesDespLineLocal.InsertInvLineFromDespLine(SalesLineLocal); // BIS 1145
                    //ALLE 3.08
                    SalesDespLine2.CalcFields("Actual Wt");
                    //TotGrossWt += "Gross Weight"*Quantity;//ALLE 3.08
                    TotGrossWt+=SalesDespLine2."Actual Wt";
                //ALLE 3.08
                //DimMgt.MoveTempFromDimToTempToDim(TempFromLineDim,TempToLineDim); // BIS 1145
                end;
            until SalesDespLine2.Next = 0;
        //GetItemChargeAssgnt(SalesDespLine2);
        //DimMgt.TransferTempToDimToDocDim(TempToLineDim); // BIS 1145
        end;
        SalesDespHeaderLocal.Get(SalesDespLine2."Document Type", SalesDespLine2."Document No.");
        SalesHeader."External Document No.":=SalesDespHeaderLocal."External Document No.";
        SalesHeader."External Doc. Date":=SalesDespHeaderLocal."External Doc. Date";
        //ALLE 3.14 >>
        SalesHeader.ARE1:=SalesDespHeaderLocal.ARE1;
        //ALLE 3.14 <<
        //ALLE 3.15 >>
        SalesHeader."Customer Order No.":=SalesDespHeaderLocal."Customer Order No.";
        SalesHeader."Customer Order Date":=SalesDespHeaderLocal."Customer Order Date";
        SalesHeader.CT2:=SalesDespHeaderLocal.CT2;
        SalesHeader."Excise Bus Posting Group(ADE)":=SalesDespHeaderLocal."Excise Bus Posting Group(ADE)";
        SalesHeader."CT2 Form":=SalesDespHeaderLocal."CT2 Form";
        //ALLE 3.15 <<
        //ALLE 3.16
        SalesHeader.CT3:=SalesDespHeaderLocal.CT3;
        SalesHeader."CT3 Form":=SalesDespHeaderLocal."CT3 Form";
        //ALLE 3.16       
        SalesHeader."Total Packed Wt.":=SalesDespHeaderLocal."Total Packed Wt.";
        SalesHeader."Ref. Doc. Subtype":=SalesDespHeaderLocal."Ref. Doc. Subtype";
        SalesHeader."Order/Scd. No.":=SalesDespHeaderLocal."Order/Scd. No.";
        SalesHeader.Subcontracting:=SalesDespHeaderLocal.Subcontracting; //CML-034 ALLEAG 240408
        //************************CE001*************************************
        //  SalesHeader."Export Shipment Type":=SalesDespHeaderLocal."Export Shipment Type"; //CML-026 Ashish 150108
        SalesHeader."Vessel/Flight No.":=SalesDespHeaderLocal."Vessel/Flight No.";
        SalesHeader."RGP Receipt No.":=SalesDespHeaderLocal."RGP Receipt No."; //CEN004.06
        //******************************************************************
        //>>CE_AA002
        SalesHeader."DI No.":=SalesDespHeaderLocal."DI No.";
        SalesHeader."DI Date":=SalesDespHeaderLocal."DI Date";
        SalesHeader."Delivery Location":=SalesDespHeaderLocal."Delivery Location";
        SalesHeader."Delivery Time":=SalesDespHeaderLocal."Delivery Time";
        SalesHeader."Usage Location":=SalesDespHeaderLocal."Usage Location";
        SalesHeader."Nagare Item Type":=SalesDespHeaderLocal."Nagare Item Type";
        //<<CE_AA002
        //ALLE-NM >>
        SalesHeader."Shortcut Dimension 1 Code":=SalesDespHeaderLocal."Shortcut Dimension 1 Code";
        SalesHeader."Shortcut Dimension 2 Code":=SalesDespHeaderLocal."Shortcut Dimension 2 Code";
        SalesHeader."Dimension Set ID":=SalesDespHeaderLocal."Dimension Set ID";
        //ALLE-NM <<
        //>>CE_AA005
        if RecSalesHeader.Get(RecSalesHeader."document type"::Order, SalesDespHeaderLocal."Order/Scd. No.")then begin
            SalesHeader."Location Code":=RecSalesHeader."Location Code";
            //SSD
            SalesHeader."Transaction Type":=RecSalesHeader."Transaction Type";
            SalesHeader."Exit Point":=RecSalesHeader."Exit Point";
            SalesHeader."Shipping Agent Code":=RecSalesHeader."Shipping Agent Code";
            SalesHeader."Payment Method Code":=RecSalesHeader."Payment Method Code";
            SalesHeader.Insurance:=RecSalesHeader.Insurance;
            SalesHeader.Freight:=RecSalesHeader.Freight;
            SalesHeader."Salesperson Code":=RecSalesHeader."Salesperson Code"; //ALLE NK
            //SSD
            SalesHeader."Shipment Method Code":=RecSalesHeader."Shipment Method Code"; //Alle VPB 130910
            SalesHeader.Validate("Ship-to Code", RecSalesHeader."Ship-to Code");
            if RecLoaction.Get(RecSalesHeader."Location Code")then begin
                if RecLoaction."Trading Location" = true then SalesHeader."Excise Invoice No. Series":=RecLoaction."Trading Sale Excise No. Series";
                SalesHeader.Trading:=RecLoaction."Trading Location";
            end;
        end;
        //<<CE_AA005
        SalesHeader."Get Despatch Used":=true;
        //SalesHeader."Expected Delivery Date" := RecSalesHeader."Expected Delivery Date";  // Alle-MS
        SalesHeader."Actual Delivery Date":=RecSalesHeader."Actual Delivery Date"; // Alle-MS
        //ALLE-AT Start
        SalesHeader."Place of Receipt by Pre-carr":=SalesDespHeaderLocal."Place of Receipt by Pre-carr";
        SalesHeader."Port of Lading":=SalesDespHeaderLocal."Port of Lading";
        SalesHeader."Port of Discharge":=SalesDespHeaderLocal."Port of Discharge";
        SalesHeader."Final Destination":=SalesDespHeaderLocal."Final Destination";
        SalesHeader.Modify;
        //ALLE 3.08 >>
        /*IF SalesHeader2."Freight Zone" <> '' THEN
        BEGIN
          //InsertInvLineFrmGrtZone(SalesHeader2,TotGrossWt);
          //ALLEMSI
          StrOrderDet.RESET;
          StrOrderDet.SETCURRENTKEY(Type,"Calculation Order","Document Type","Document No.",
                                    "Structure Code","Tax/Charge Type","Tax/Charge Group",
                                    "Tax/Charge Code","Document Line No.");
          StrOrderDet.SETRANGE(Type,StrOrderDet.Type::Sale);
          StrOrderDet.SETRANGE("Document Type",StrOrderDet."Document Type"::Invoice);
          StrOrderDet.SETRANGE("Document No.",SalesHeader2."No.");
          StrOrderDet.SETRANGE("Structure Code",SalesHeader2.Structure);
          StrOrderDet.SETRANGE("Tax/Charge Type",StrOrderDet."Tax/Charge Type"::Charges);
          StrOrderDet.SETFILTER("Tax/Charge Group",'%1','FREIGHT');
          StrOrderDet.SETFILTER("Tax/Charge Code",'%1','FREIGHT');
          StrOrderDet.SETRANGE("Calculation Type",StrOrderDet."Calculation Type"::"Fixed Value");
          IF StrOrderDet.FINDFIRST THEN
          BEGIN
            IF FrtZone.GET(SalesHeader2."Freight Zone") THEN BEGIN
              MESSAGE('TotGrossWt=%1',TotGrossWt);
              MESSAGE('Freight Zone Rate=%1',FrtZone."Freight Zone Rate");
              StrOrderDet.VALIDATE("Calculation Value",TotGrossWt*FrtZone."Freight Zone Rate");
              StrOrderDet.MODIFY;
            END;
          END
          ELSE ERROR('Freight Must be defined in the Structure');
        END;  */
        //ALLE 3.08 >>
        //ALLE 1.07 >>
        Document.Reset;
        Document.SetCurrentkey("Table No.", "Reference No. 1", "Reference No. 2", "Reference No. 3");
        Document.SetRange("Table No.", Database::"Sales Header");
        Document.SetRange("Reference No. 2", SalesDespHeaderLocal."Order/Scd. No.");
        if Document.FindFirst then repeat if Document.HasContent(true)then begin
                    DocumentRec.Copy(Document);
                    DocumentRec."In Use By":='';
                    DocumentRec."Modified Date":=0D;
                    DocumentRec."Modified By":='';
                    if Document."Document Type" = Document."document type"::Document then begin
                        DocumentRec."No.":='';
                        DocumentRec."Reference No. 2":=SalesHeader."No.";
                        DocumentRec.Insert(true);
                    end
                    else
                    begin
                        DocumentRec."No.":=IncStr(Document."No.");
                        if DocumentRec."No." = '' then DocumentRec."No.":=Document."No." + '01';
                        while not DocumentRec.Insert do DocumentRec."No.":=IncStr(DocumentRec."No.");
                    // Clone template fields as well
                    //IF DocumentRec."Table No." <> 0 THEN
                    //  TmplField.CloneTemplate("No.",DocumentRec."No.");
                    end;
                    if not DocAccMgt.RecInDB(Document)then DocAccMgt.Copy(Document, DocumentRec);
                end;
            until Document.Next = 0;
        //ALLE 1.07 <<
        //CMLTEST-026 AA 250108 Start
        SalesHeader.Validate(SalesHeader."Location Code", SalesHeader."Location Code");
    //CMLTEST-026 AA 250108 Finish
    //ALLE 3.08 >>
    //ALLE 3.08 >>
    end;
    procedure DeleteInvoiceLines(var RecToSalesHeader: Record "Sales Header")
    var
        SalesLineLocal: Record "Sales Line";
        SalesPacketBufferLocal: Record "SSD Sales Schedule Buffer";
    begin
        //CF001 St
        SalesLineLocal.Reset;
        SalesLineLocal.SetRange("Document Type", RecToSalesHeader."Document Type");
        SalesLineLocal.SetRange("Document No.", RecToSalesHeader."No.");
        if SalesLineLocal.Find('-')then repeat SalesLineLocal.Delete;
                SalesPacketBufferLocal.Reset;
                SalesPacketBufferLocal.SetRange("Document Type", SalesLineLocal."Document Type");
                SalesPacketBufferLocal.SetRange("Document No.", SalesLineLocal."Document No.");
                SalesPacketBufferLocal.SetRange("Sell-to Customer No.", SalesLineLocal."Sell-to Customer No.");
                SalesPacketBufferLocal.SetRange("Item No.", SalesLineLocal."No.");
                SalesPacketBufferLocal.SetRange("Order Line No.", SalesLineLocal."Line No.");
                if SalesPacketBufferLocal.Find('-')then SalesPacketBufferLocal.DeleteAll;
            until SalesLineLocal.Next = 0;
    //CF001 En
    end;
    procedure InsertInvLineFrmGrtZone(SalesInvHeader: Record "Sales Header"; GrossWtTot: Decimal)
    var
        SalesInvLine: Record "Sales Line";
        LineNoGL: Integer;
        SInvLine: Record "Sales Line";
        UserSet: Record "User Setup";
        RespCent: Record "Responsibility Center";
        FrtZone: Record "SSD Freight Zone";
    begin
        //ALLE 3.08 >>
        SalesInvLine.Reset;
        SalesInvLine.SetRange("Document Type", SalesInvHeader."Document Type");
        SalesInvLine.SetRange("Document No.", SalesInvHeader."No.");
        if SalesInvLine.FindLast then LineNoGL:=SalesInvLine."Line No."
        else
            LineNoGL:=0;
        if UserSet.Get(UserId)then begin
            if RespCent.Get(UserSet."Responsibility Center")then RespCent.TestField("Freight Zone Account");
        end;
        if FrtZone.Get(SalesInvHeader."Freight Zone")then;
        LineNoGL+=10000;
        SInvLine.Init;
        SInvLine."Document Type":=SalesInvHeader."Document Type";
        SInvLine."Document No.":=SalesInvHeader."No.";
        SInvLine."Line No.":=LineNoGL;
        SInvLine."Sell-to Customer No.":=SalesInvHeader."Sell-to Customer No.";
        SInvLine.Validate(Type, SInvLine.Type::"G/L Account");
        SInvLine.Validate("No.", RespCent."Freight Zone Account");
        SInvLine.Validate("Location Code", SalesInvHeader."Location Code");
        SInvLine.Validate(Quantity, 1);
        SInvLine.Validate("Unit Price", GrossWtTot * FrtZone."Freight Zone Rate");
        SInvLine."Order No.":=Rec."Order No.";
        SInvLine.Insert;
    end;
}
