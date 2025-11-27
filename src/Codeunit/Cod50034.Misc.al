codeunit 50034 Misc
{
    Permissions = tabledata "Requisition Line"=rmd,
        tabledata "Purch. Rcpt. Header"=rm,
        tabledata "Purch. Rcpt. Line"=rm,
        tabledata "Sales Invoice Header"=rm,
        tabledata "Value Entry"=rm,
        tabledata "Item Ledger Entry"=rm;

    trigger OnRun()
    begin
    end;
    procedure DeleteREQLine()
    var
        Reqline: Record "Requisition Line";
    begin
        Reqline.SetRange("Journal Batch Name", 'DEFAULT');
        if Reqline.FindSet()then Reqline.DeleteAll();
    end;
    procedure DeleteNotificationEntry()
    var
        NotificationEntry: Record "Notification Entry";
    begin
        NotificationEntry.SetFilter("Created Date-Time", '<%1', CreateDateTime(CalcDate('-3D', Today), Time));
        if NotificationEntry.FindSet()then NotificationEntry.DeleteAll();
    end;
    // procedure DeleteJobQueueEntry()
    // var
    //     JobQueueEntry: Record "Job Queue Entry";
    // begin
    //     if JobQueueEntry.FindSet() then
    //         JobQueueEntry.DeleteAll();
    // end;
    // procedure UpdateCUSTVendEmail()
    // var
    //     Customer: Record Customer;
    //     Vendor: Record Vendor;
    // begin
    // end;
    procedure UpdatepayVendor()
    var
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        ValueEntry: Record "Value Entry";
        Misc: Codeunit Misc;
    begin
        PurchRcptHeader.Get('ZDPPR2503781');
        PurchRcptHeader.Validate("Pay-to Vendor No.", 'V0614');
        PurchRcptHeader.Validate("Invoice Disc. Code", 'V0614');
        PurchRcptHeader.Modify;
        PurchRcptLine.SetRange("Document No.", 'ZDPPR2503781');
        if PurchRcptLine.FindSet()then repeat PurchRcptLine.Validate("Pay-to Vendor No.", 'V0614');
                PurchRcptLine.Modify;
            until PurchRcptLine.Next = 0;
        ValueEntry.SetRange("Document No.", 'ZDPPR2503781');
        if ValueEntry.FindSet()then repeat ValueEntry.Validate("Source No.", 'V0614');
                ValueEntry.Modify;
            until ValueEntry.Next = 0;
    end;
    procedure UpdateDelivery()
    var
        PSI: Record "Sales Invoice Header";
    begin
        PSI.get('ZDPSI2507885');
        //PSI.get('ZDPSI2510860');
        PSI."Actual Delivery Date":=0D;
        PSI.Modify;
    end;
    procedure DeleteLot()
    var
        ILE: Record "Item Ledger Entry";
    begin
        ILE.SetRange("Lot Blocked", true);
        ILE.SetFilter("Lot No.", '=%1', '');
        //ILE.SetFilter("Item No.", '%1|%2', 'CN0000693', 'CN0000044');
        if ILE.FindSet()then repeat ILE."Lot Blocked":=false;
                ILE.Modify;
            until ILE.Next = 0;
    end;
    procedure UpdatePOSO()
    var
        PurchaseHdr: Record "Purchase Header";
        PurchaseHdr2: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        SalesHeader: Record "Sales Header";
        SalesHeader2: Record "Sales Header";
        SalesLine: Record "Sales Line";
        D: page 5768;
        WHRequest: Record "Warehouse Request";
        WhseSalesRelease: Codeunit "Whse.-Sales Release";
        WhsePurchaseRelease: Codeunit "Whse.-Purch. Release";
    begin
        PurchaseHdr.Reset();
        PurchaseHdr.SetRange("Document Type", PurchaseHdr."Document Type"::Order);
        PurchaseHdr.SetFilter("Location Code", GetLocation());
        PurchaseHdr.SetRange("Order Date", 20240401D, Today);
        if PurchaseHdr.FindSet()then repeat PurchaseLine.Reset();
                PurchaseLine.SetRange("Document No.", PurchaseHdr."No.");
                PurchaseLine.SetRange("Short Closed", false);
                PurchaseLine.SetFilter("Outstanding Quantity", '<>%1', 0);
                if PurchaseLine.FindSet()then begin
                    repeat PurchaseHdr2.get(PurchaseHdr."Document Type"::Order, PurchaseHdr."No.");
                        PurchaseHdr2.Status:=PurchaseHdr2.Status::Open;
                        PurchaseHdr2.Modify();
                        PurchaseHdr2."Location Code":='STR_ZDB';
                        PurchaseLine."Location Code":='STR_ZDB';
                        PurchaseLine.Modify;
                        PurchaseHdr2.Status:=PurchaseHdr2.Status::Released;
                        PurchaseHdr2.Modify();
                        WhsePurchaseRelease.Release(PurchaseHdr2);
                    // WHRequest.Reset();
                    // WHRequest.SetRange("Source No.", PurchaseHdr2."No.");
                    // WHRequest.SetRange("Source Document", WHRequest."Source Document"::"Purchase Order");
                    // if WHRequest.FindSet() then
                    //     repeat
                    //         WHRequest.Rename(WHRequest.Type, 'STR_ZDB', WHRequest."Source Type", WHRequest."Source Subtype", WHRequest."Source No.");
                    //     until WHRequest.Next = 0;
                    until PurchaseLine.Next() = 0;
                end;
            until PurchaseHdr.Next = 0;
        SalesHeader.Reset();
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetFilter("Location Code", GetLocation());
        SalesHeader.SetRange("Order Date", 20240401D, Today);
        if SalesHeader.FindSet()then repeat SalesLine.Reset();
                SalesLine.SetRange("Document No.", SalesHeader."No.");
                SalesLine.SetRange("Short Close", false);
                SalesLine.SetFilter("Outstanding Quantity", '<>%1', 0);
                if SalesLine.FindSet()then begin
                    repeat SalesHeader2.get(SalesHeader."Document Type"::Order, SalesHeader."No.");
                        SalesHeader2.Status:=SalesHeader2.Status::Open;
                        SalesHeader2.Modify();
                        SalesHeader2."Location Code":='STR_ZDB';
                        SalesLine."Location Code":='STR_ZDB';
                        SalesLine.Modify;
                        SalesHeader2.Status:=SalesHeader2.Status::Released;
                        SalesHeader2.Modify();
                        WhseSalesRelease.Release(SalesHeader2);
                    // WHRequest.Reset();
                    // WHRequest.SetRange("Source No.", SalesHeader2."No.");
                    // WHRequest.SetRange("Source Document", WHRequest."Source Document"::"Sales Order");
                    // if WHRequest.FindSet() then
                    //     repeat
                    //         WHRequest.Rename(WHRequest.Type, 'STR_ZDB', WHRequest."Source Type", WHRequest."Source Subtype", WHRequest."Source No.");
                    //     until WHRequest.Next = 0;
                    until SalesLine.Next() = 0;
                end;
            until SalesHeader.Next = 0;
    end;
    procedure GetLocation()LocationCode: Text;
    begin
        LocationCode:='STR_D3|STR_FA|STR_FG|STR_MAIN|STR_REJ|STR_RM|STR_SCRAP|STR_BWH';
    end;
    procedure UpdateWHRequest()
    var
        WHRequest: Record "Warehouse Request";
        PurchHdr: Record "Purchase Header";
        SalesHdr: Record "Sales Header";
        WhseSalesRelease: Codeunit "Whse.-Sales Release";
        WhsePurchaseRelease: Codeunit "Whse.-Purch. Release";
    begin
        PurchHdr.Reset();
        PurchHdr.SetRange("Order Date", 20240401D, 20250228D);
        PurchHdr.SetRange("Location Code", 'STR_ZDB');
        //PurchHdr.SetRange(SystemModifiedBy. , UserId);
        if PurchHdr.FindSet()then repeat WHRequest.Reset();
                WHRequest.SetRange("Source No.", PurchHdr."No.");
                WHRequest.SetRange("Source Document", WHRequest."Source Document"::"Purchase Order");
                if WHRequest.FindSet()then repeat //WHRequest."Location Code" := 'STR_ZDB';
                        WHRequest.Rename(WHRequest.Type, 'STR_ZDB', WHRequest."Source Type", WHRequest."Source Subtype", WHRequest."Source No.");
                    //WHRequest.Modify(false);
                    until WHRequest.Next = 0;
                //     until PurchHdr.Next = 0;
                WhsePurchaseRelease.Release(PurchHdr);
            until PurchHdr.Next = 0;
        SalesHdr.Reset();
        SalesHdr.SetRange("Order Date", 20240401D, Today);
        SalesHdr.SetRange("Location Code", 'STR_ZDB');
        if SalesHdr.FindSet()then repeat WHRequest.Reset();
                WHRequest.SetRange("Source No.", SalesHdr."No.");
                WHRequest.SetRange("Source Document", WHRequest."Source Document"::"Sales Order");
                if WHRequest.FindSet()then repeat // WHRequest."Location Code" := 'STR_ZDB';
                    // WHRequest.Modify(false);
                    // WHRequest.Rename(WHRequest.Type, 'STR_ZDB', WHRequest."Source Type", WHRequest."Source Subtype", WHRequest."Source No.");
                    until WHRequest.Next = 0;
                WhseSalesRelease.Release(SalesHdr);
            until SalesHdr.Next = 0;
    end;
}
