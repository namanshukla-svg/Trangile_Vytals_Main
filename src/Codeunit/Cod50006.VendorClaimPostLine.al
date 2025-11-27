Codeunit 50006 "Vendor Claim -Post Line"
{
    // //GetIncidenciaProveedor==>Vendor Claim -Post Line
    trigger OnRun()
    begin
    end;
    var SetupQuality: Record "SSD Quality Setup";
    Txt00001: label 'Posting Vendor Claim Journal';
    UserMgt: Codeunit "SSD User Setup Management";
    Txt00002: label 'Unknown QualityType (%1)  is mention ';
    procedure CreateVendorClaimFromPurchLine(RecPurchaseHeader: Record "Purchase Header"; RecPurchaseLine: Record "Purchase Line"; VAffectedQty: Decimal)
    var
        VendorClaimLinesLocal: Record "SSD G/L Group Code";
    begin
        //////**************CreaLinDesdeCompra***********************
        if RecPurchaseLine."Receipt No." <> '' then exit;
        /*
        IF NOT RecPurchaseHeader.Invoice THEN
          EXIT;
        */
        VendorClaimLinesLocal.Init;
        VendorClaimLinesLocal.Description:=RecPurchaseHeader."Buy-from Vendor No.";
        //SSD Comment Start
        // VendorClaimLinesLocal."No." := RecPurchaseLine."No.";
        // VendorClaimLinesLocal."Posting Date" := RecPurchaseHeader."Posting Date";
        // if RecPurchaseLine."Document Type" = RecPurchaseLine."document type"::Order then begin
        //     VendorClaimLinesLocal."Entry Source Type" := VendorClaimLinesLocal."entry source type"::"0";
        //     VendorClaimLinesLocal."External Doc. No." := RecPurchaseHeader."Vendor Shipment No.";
        //     VendorClaimLinesLocal."Internal Doc. No." := RecPurchaseHeader."Receiving No.";
        // end
        // else begin
        //     VendorClaimLinesLocal."External Doc. No." := RecPurchaseHeader."Vendor Cr. Memo No.";
        //     VendorClaimLinesLocal."Internal Doc. No." := RecPurchaseHeader."Posting No.";
        //     VendorClaimLinesLocal."Entry Source Type" := VendorClaimLinesLocal."entry source type"::"1";
        //     VendorClaimLinesLocal."Item Entry No." := RecPurchaseLine."Appl.-to Item Entry";
        // end;
        // VendorClaimLinesLocal."Source Code" := RecPurchaseHeader."No.";
        // VendorClaimLinesLocal.Validate("Vendor Claim Code", RecPurchaseLine."Vendor Claim Code");
        // VendorClaimLinesLocal."Affected Quantity" := VAffectedQty;
        // VendorClaimLinesLocal.Validate(Price, RecPurchaseLine."Unit Cost (LCY)");
        // if RecPurchaseLine."Prod. Order Line No." = 0 then
        //     VendorClaimLinesLocal."Entry Type" := VendorClaimLinesLocal."entry type"::"0"
        // else
        //     VendorClaimLinesLocal."Entry Type" := VendorClaimLinesLocal."entry type"::"1";
        //SSD Comment End
        CreateClaimToVendorLine(VendorClaimLinesLocal);
    end;
    procedure CreateVendorClaimFromQuality(var RecQualityOrderHeader: Record "SSD Quality Order Header"; vQualityType: Option Scrap, Reclassification, Reprocess, Wrong; vVendorNo: Code[20]; vAffectedQty: Decimal)
    var
        VendorClaimLinesLocal: Record "SSD G/L Group Code";
    begin
        ///******************CreaLinDesdeParte**>>>>>CreateVendorClaimFromSampling*****************************
        if vVendorNo = '' then exit;
        SetupQuality.Get(UserMgt.GetRespCenterFilter);
        VendorClaimLinesLocal.Init;
        VendorClaimLinesLocal.Description:=vVendorNo;
    //SSD Comment Start
    // VendorClaimLinesLocal."No." := RecQualityOrderHeader."Item No.";
    // VendorClaimLinesLocal."Entry Source Type" := VendorClaimLinesLocal."entry source type"::"0";
    // VendorClaimLinesLocal."Source Code" := RecQualityOrderHeader."Order No.";
    // VendorClaimLinesLocal.Validate("Affected Quantity", vAffectedQty);
    // VendorClaimLinesLocal."Internal Doc. No." := RecQualityOrderHeader."Source Code";
    // VendorClaimLinesLocal."Posting Date" := RecQualityOrderHeader."Posting Date";
    // //VendorClaimLinesLocal."Item Entry No." := RecSamplingDocHeader."Item Entry No.";
    // case vQualityType of
    //     Vqualitytype::Scrap:
    //         begin
    //             SetupQuality.TestField("Units to Scrapping");
    //             VendorClaimLinesLocal.Validate("Vendor Claim Code", SetupQuality."Units to Scrapping");
    //         end;
    //     Vqualitytype::Reclassification:
    //         begin
    //             SetupQuality.TestField("Units to Reclass.");
    //             VendorClaimLinesLocal.Validate("Vendor Claim Code", SetupQuality."Units to Reclass.");
    //         end;
    //     Vqualitytype::Reprocess:
    //         begin
    //             SetupQuality.TestField("Units to Reprocess");
    //             VendorClaimLinesLocal.Validate("Vendor Claim Code", SetupQuality."Units to Reprocess");
    //         end;
    //     Vqualitytype::Wrong:
    //         begin
    //             SetupQuality.TestField("Units to Wrongs");
    //             VendorClaimLinesLocal.Validate("Vendor Claim Code", SetupQuality."Units to Wrongs");
    //         end;
    //     else
    //         Error(Txt00002, Format(vQualityType));
    // end;
    // VendorClaimLinesLocal."External Doc. No." := RecQualityOrderHeader."External Document No.";
    // if RecQualityOrderHeader."Entry Source Type" = RecQualityOrderHeader."entry source type"::Purchase then
    //     VendorClaimLinesLocal."Entry Type" := VendorClaimLinesLocal."entry type"::"0"
    // else
    //     VendorClaimLinesLocal."Entry Type" := VendorClaimLinesLocal."entry type"::"1";
    // CreateClaimToVendorLine(VendorClaimLinesLocal);
    end;
    procedure CreateClaimToVendorLine(var RecVendorClaimLines: Record "SSD G/L Group Code")
    var
        ClaimToVendorLinLocal: Record "SSD BS Budget";
        NextEntryNo: Integer;
    begin
        /////**************RegLinDiaIncidencia***************************
        NextEntryNo:=0;
        if not ClaimToVendorLinLocal.Find('+')then ClaimToVendorLinLocal.Init;
        //SSD Comment Start
        // NextEntryNo := ClaimToVendorLinLocal."BS Code";
        // ClaimToVendorLinLocal.TransferFields(RecVendorClaimLines);
        // ClaimToVendorLinLocal."BS Code" := NextEntryNo + 1;
        // ClaimToVendorLinLocal."Claim Date" := WorkDate;
        // ClaimToVendorLinLocal."Claim User" := UserId;
        //SSD Comment End
        ClaimToVendorLinLocal.Insert;
    end;
    procedure CreateVendorClaim(var RecVendorClaimLines: Record "SSD G/L Group Code")
    var
        VendorClaimLinesLocal: Record "SSD G/L Group Code";
    begin
        ///**************RegDiaIncidencia*********************
        if not Confirm(Txt00001)then exit;
        if RecVendorClaimLines.Find('-')then repeat VendorClaimLinesLocal:=RecVendorClaimLines;
                //SSD RecVendorClaimLines.TestField("Source Code");
                //SSD RecVendorClaimLines.TestField("Vendor Claim Code");
                CreateClaimToVendorLine(VendorClaimLinesLocal);
                VendorClaimLinesLocal.Delete;
            until RecVendorClaimLines.Next = 0;
    end;
}
