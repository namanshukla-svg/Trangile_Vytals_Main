PageExtension 50034 "SSD General Ledger Setup" extends "General Ledger Setup"
{
    layout
    {
        addlast(General)
        {
            field("Amazon Freight GL"; Rec."Amazon Freight GL")
            {
                ApplicationArea = All;
            }
            field("Sandbox Mobile No."; Rec."Sandbox Mobile No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sandbox Mobile No. field.';
            }
            field("Sandbox Email Id"; Rec."Sandbox Email Id")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sandbox Email Id field.';
            }
            field("SSD Activate Item Vendor"; Rec."SSD Activate Item Vendor")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Activate Item Vendor field.';
            }
        }
    }
    actions
    {
        addafter("VAT Posting Setup")
        {
            action("Update Gate Entry In Receipt Line")
            {
                ApplicationArea = All;
                Caption = 'Update Gate Entry In Receipt Line';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = UpdateShipment;

                trigger OnAction()
                var
                    C: Codeunit 50032;
                begin
                    c.UpdateRcptLine();
                end;
            }
            action("Remove Item Tracking")
            {
                ApplicationArea = All;
                Caption = 'Remove Item Tracking';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Delete;

                trigger OnAction()
                var
                    C: Codeunit 50032;
                begin
                    c.RemoveitemTracking();
                end;
            }
            action("Update Gate Entry in PI")
            {
                ApplicationArea = All;
                Caption = 'Update Gate Entry in PI';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = UpdateShipment;

                trigger OnAction()
                var
                    C: Codeunit 50032;
                begin
                    c.UpdateGateEntryInPI();
                end;
            }
            action("Delete Blank Line from Receipt")
            {
                ApplicationArea = All;
                Caption = 'Delete Blank Line from Receipt';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Delete;

                trigger OnAction()
                var
                    C: Codeunit 50032;
                begin
                    c.DeleteBlankLinePR();
                end;
            }
            action("Remove VAT Posted Sales Invoice")
            {
                ApplicationArea = All;
                Caption = 'Remove VAT';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Delete;

                trigger OnAction()
                var
                    C: Codeunit 50032;
                begin
                    c.updatePOVAT();
                end;
            }
            action("Remove VAT Master")
            {
                ApplicationArea = All;
                Caption = 'Remove VAT Master';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Delete;

                trigger OnAction()
                var
                    C: Codeunit 50032;
                begin
                    c.RemoveVATMaster();
                end;
            }
            action("Create Distributor Order")
            {
                ApplicationArea = All;
                Caption = 'Create Distributor Order';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Create;
                RunObject = report "Batch Update Sales H & Line_2";
            }
            action("Update Post Code")
            {
                ApplicationArea = All;
                Caption = 'Update Post Code';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = UpdateShipment;

                trigger OnAction()
                var
                    C: Codeunit 50032;
                begin
                    c.UpdateSalesInvHeader();
                end;
            }
            action("Update Currency Code")
            {
                ApplicationArea = All;
                Caption = 'Update Currency Code';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = UpdateUnitCost;

                trigger OnAction()
                var
                    PostedSalesInv: Record "Sales Invoice Header";
                    CustLedgerEntry: Record "Cust. Ledger Entry";
                    C: Codeunit 50032;
                begin
                    C.UpdateCurrencyCode();
                end;
            }
            action("Update Req Line")
            {
                ApplicationArea = All;
                Caption = 'Update Req Line';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = UpdateUnitCost;

                trigger OnAction()
                var
                    Misc: Codeunit Misc;
                begin
                    Misc.DeleteREQLine();
                end;
            }
            action("Delete Notification Entry")
            {
                ApplicationArea = All;
                Caption = 'Delete Notification Entry';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                //Image = UpdateUnitCost;
                trigger OnAction()
                var
                    Misc: Codeunit Misc;
                begin
                    Misc.DeleteNotificationEntry();
                end;
            }
            // action("Delete Job Queue Entry")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Delete Job Queue Entry';
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     //Image = UpdateUnitCost;
            //     trigger OnAction()
            //     var
            //         Misc: Codeunit Misc;
            //     begin
            //         Misc.DeleteJobQueueEntry();
            //     end;
            // }
            // action("Delete Forcast")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Delete Forcast';
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     Image = Image;
            //     trigger OnAction()
            //     var
            //         ForcastArchive: Record "SSD Prod Forecast Archive";
            //     begin
            //         ForcastArchive.Reset();
            //         ForcastArchive.SetRange("Production Forecast Name", 'KEYPRDFORC');
            //         ForcastArchive.SetRange("Forecast Date", 20230501D, 20230731D);
            //         ForcastArchive.SetRange("Version No.", 4);
            //         if ForcastArchive.FindSet() then
            //             ForcastArchive.DeleteAll();
            //     end;
            // }
            // action("Check Distrbution")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Check Distrbution';
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     Image = UpdateUnitCost;
            //     RunObject = report "Batch Update Sales H & Line II";
            // }
            action("Update PayVendor")
            {
                ApplicationArea = All;
                Caption = 'Update payVendor';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Image;

                trigger OnAction()
                var
                    Misc: Codeunit Misc;
                begin
                    Misc.UpdatepayVendor();
                end;
            }
            action("Update Delivery Date")
            {
                ApplicationArea = All;
                Caption = 'Update Delivery Date';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Image;

                trigger OnAction()
                var
                    Misc: Codeunit Misc;
                begin
                    Misc.UpdateDelivery();
                end;
            }
            action("Remove Lot Blocked")
            {
                ApplicationArea = All;
                Caption = 'Remove Lot Blocked';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Image;

                trigger OnAction()
                var
                    Misc: Codeunit Misc;
                begin
                    Misc.DeleteLot();
                end;
            }
            action("Update POSO")
            {
                ApplicationArea = All;
                Caption = 'Update POSO';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Image;

                trigger OnAction()
                var
                    Misc: Codeunit Misc;
                begin
                    Misc.UpdatePOSO();
                end;
            }
            action("Update WHPOSO")
            {
                ApplicationArea = All;
                Caption = 'Update WHPOSO';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Image;

                trigger OnAction()
                var
                    Misc: Codeunit Misc;
                begin
                    Misc.UpdateWHRequest();
                end;
            }
            action("DeletePayrollStaging")
            {
                ApplicationArea = All;
                Caption = 'DeletePayrollStaging';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Image;

                trigger OnAction()
                var
                    SalaryUploadStaging: Record "SSD Salary Upload Staging";
                begin
                    SalaryUploadStaging.Reset();
                    SalaryUploadStaging.SetRange("Posting Date", 20250228D);
                    if SalaryUploadStaging.FindSet()then SalaryUploadStaging.DeleteAll();
                    Message('Done');
                end;
            }
            //SSDDD
            action(UpdateLocation)
            {
                Caption = 'Update Location';
                ApplicationArea = All;

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    PurchaseHeader: Record "Purchase Header";
                    SalesHeader2: Record "Sales Header";
                    PurchaseHeader2: Record "Purchase Header";
                    SalesLine: Record "Sales Line";
                    PurchaseLine: Record "Purchase Line";
                    WhseSalesRelease: Codeunit "Whse.-Sales Release";
                    WhsePurchaseRelease: Codeunit "Whse.-Purch. Release";
                begin
                    SalesHeader.SetRange("Location Code", 'BLUE');
                    SalesHeader.SetRange(Status, SalesHeader.Status::Released);
                    if SalesHeader.FindSet()then repeat SalesHeader2.Get(SalesHeader."Document Type", SalesHeader."No.");
                            SalesHeader2."Location Code":='TEST';
                            SalesHeader2.Modify();
                            SalesLine.SetRange("Document Type", SalesHeader."Document Type");
                            SalesLine.SetRange("Document No.", SalesHeader."No.");
                            if SalesLine.FindSet()then repeat SalesLine."Location Code":=SalesHeader2."Location Code";
                                    SalesLine.Modify();
                                until SalesLine.Next() = 0;
                            WhseSalesRelease.Release(SalesHeader2);
                        until SalesHeader.Next() = 0;
                    PurchaseHeader.SetRange("Location Code", 'BLUE');
                    PurchaseHeader.SetRange(Status, PurchaseHeader.Status::Released);
                    if PurchaseHeader.FindSet()then repeat PurchaseHeader2.Get(PurchaseHeader."Document Type", PurchaseHeader."No.");
                            PurchaseHeader2."Location Code":='TEST';
                            PurchaseHeader2.Modify();
                            PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
                            PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
                            if PurchaseLine.FindSet()then repeat PurchaseLine."Location Code":=PurchaseHeader2."Location Code";
                                    PurchaseLine.Modify();
                                until PurchaseLine.Next() = 0;
                            WhsePurchaseRelease.Release(PurchaseHeader2);
                        until PurchaseHeader.Next() = 0;
                end;
            }
        }
    }
}
