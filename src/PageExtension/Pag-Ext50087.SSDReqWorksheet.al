PageExtension 50087 "SSD Req. Worksheet" extends "Req. Worksheet"
{
    layout
    {
        addfirst(Control1)
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
        addafter(Type)
        {
            field("Indent No."; Rec."Indent No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("No.")
        {
            field("Create SOB"; Rec."Create SOB")
            {
                ApplicationArea = All;
            }
            field("SOB Entry"; Rec."SOB Entry")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Vendor Name"; Rec."Vendor Name")
            {
                ApplicationArea = All;
            }
        }
        addafter("Unit of Measure Code")
        {
            field("Unit Cost"; Rec."Unit Cost")
            {
                ApplicationArea = All;
            }
        }
        addafter("Direct Unit Cost")
        {
            field("Expected Cost"; Rec."Expected Cost")
            {
                ApplicationArea = All;
            }
        }
        addafter("Ref. Order No.")
        {
            field("Created PO Doc. type"; Rec."Created PO Doc. type")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    if(Rec."Replenishment System" = Rec."replenishment system"::Purchase) and (Rec."Action Message" = Rec."action message"::New) and (Rec."Created PO Doc. type" = Rec."created po doc. type"::"Sch. Order")then begin
                        ///Find Out Purchase Rate Contract No.
                        FindPurchRateContract(Rec);
                    end;
                end;
            }
            field("Created PO No. Series"; Rec."Created PO No. Series")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
    }
    actions
    {
        addfirst(Processing)
        {
            action("&Create SOB")
            {
                ApplicationArea = All;
                Caption = '&Create SOB';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //SOB ALLEAG 300108 Start
                    if Confirm('Do you want to Create SOB')then begin
                        Reqlinerec.Reset;
                        Reqlinerec.SetRange("Worksheet Template Name", Rec."Worksheet Template Name");
                        Reqlinerec.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                        Reqlinerec.SetRange("Create SOB", true);
                        if Reqlinerec.FindSet then repeat ItemVendorRec.Reset;
                                ItemVendorRec.SetFilter("Item No.", Reqlinerec."No.");
                                ItemVendorRec.SetFilter("Item %", '>%1', 0);
                                if ItemVendorRec.Find('-')then repeat Reqline.Reset;
                                        Reqline.SetRange("Worksheet Template Name", Rec."Worksheet Template Name");
                                        Reqline.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                                        if Reqline.Find('+')then linenumber:=Reqline."Line No." + 10000
                                        else
                                            linenumber:=10000;
                                        Reqlinerec2.Reset;
                                        Reqlinerec2.Init;
                                        Reqlinerec2."Worksheet Template Name":=Rec."Worksheet Template Name";
                                        Reqlinerec2."Journal Batch Name":=Rec."Journal Batch Name";
                                        Reqlinerec2."Line No.":=linenumber;
                                        Reqlinerec2.Type:=Reqlinerec.Type;
                                        Reqlinerec2."No.":=Reqlinerec."No.";
                                        Reqlinerec2.Validate("No.");
                                        Reqlinerec2."Action Message":=Reqlinerec2."action message"::New;
                                        Reqlinerec2."Due Date":=Reqlinerec."Due Date";
                                        Reqlinerec2.Quantity:=Reqlinerec.Quantity * (ItemVendorRec."Item %" / 100);
                                        Reqlinerec2.Validate(Quantity);
                                        Reqlinerec2."Vendor No.":=ItemVendorRec."Vendor No.";
                                        Reqlinerec."Replenishment System":=Reqlinerec."replenishment system"::Purchase;
                                        Reqlinerec2."Location Code":=Reqlinerec."Location Code";
                                        Reqlinerec2."SOB Entry":=true;
                                        VendorRec.Reset;
                                        VendorRec.Get(Reqlinerec2."Vendor No.");
                                        Reqlinerec2."Vendor Name":=VendorRec.Name;
                                        Reqlinerec2.Insert;
                                    until ItemVendorRec.Next = 0;
                                Reqlinerec.Delete;
                            until Reqlinerec.Next = 0;
                    end;
                end;
            }
        }
        addafter("Order &Tracking")
        {
            action("Update Sch. PO Type")
            {
                ApplicationArea = All;
                Caption = 'Update Sch. PO Type';

                trigger OnAction()
                begin
                //SSDU Start
                //UpdateSchorderType.RunModal;
                //Clear(UpdateSchorderType);
                //SSDU Finish
                end;
            }
        }
    }
    var RequisitionLineLocal: Record "Requisition Line";
    var ReqJnlBatchLocal: Record "Requisition Wksh. Name";
    var Text001: label 'Deletion is not possible';
    UserMgt: Codeunit "SSD User Setup Management";
    Text002: label 'No Rate Contract found for\  Vendor No. %1\  Item No. %2\  Line No. %3';
    Reqlinerec: Record "Requisition Line";
    ItemVendorRec: Record "Item Vendor";
    Reqlinerec2: Record "Requisition Line";
    Reqline: Record "Requisition Line";
    linenumber: Integer;
    VendorRec: Record Vendor;
    //SSDU UpdateSchorderType: Report "Update Req. line with sch. ord";
    trigger OnAfterGetRecord()
    begin
        IF(Rec."Replenishment System" = Rec."Replenishment System"::Purchase) AND (Rec."Action Message" = Rec."Action Message"::New) AND (Rec."Created PO Doc. type" = Rec."Created PO Doc. type"::"Sch. Order") AND (Rec."Vendor No." <> '') AND (Rec.Type = Rec.Type::Item) AND (Rec."No." <> '')THEN ItemVendorRec.RESET;
        ItemVendorRec.SETFILTER("Item No.", Rec."No.");
        ItemVendorRec.SETFILTER("Item %", '>%1', 0);
        IF ItemVendorRec.COUNT > 0 THEN Rec."Create SOB":=TRUE;
    end;
    trigger OnDeleteRecord(): Boolean begin
        IF Rec."Indent No." <> '' THEN ERROR(Text001);
    end;
    procedure FindPurchRateContract(RecRequisitionLine: Record "Requisition Line")
    var
        PurchaseLineLocal: Record "Purchase Line";
    begin
        //IND St
        RecRequisitionLine.TestField("Replenishment System", RecRequisitionLine."replenishment system"::Purchase);
        RecRequisitionLine.TestField("Action Message", RecRequisitionLine."action message"::New);
        RecRequisitionLine.TestField("Created PO Doc. type", RecRequisitionLine."created po doc. type"::"Sch. Order");
        RecRequisitionLine.TestField("Vendor No.");
        RecRequisitionLine.TestField(Type, RecRequisitionLine.Type::Item);
        RecRequisitionLine.TestField("No.");
        PurchaseLineLocal.Reset;
        PurchaseLineLocal.SetRange("Document Type", PurchaseLineLocal."document type"::"Blanket Order");
        PurchaseLineLocal.SetRange("Buy-from Vendor No.", RecRequisitionLine."Vendor No.");
        PurchaseLineLocal.SetRange(Type, PurchaseLineLocal.Type::Item);
        PurchaseLineLocal.SetRange("No.", RecRequisitionLine."No.");
        if not PurchaseLineLocal.Find('-')then Error(Text002, RecRequisitionLine."Vendor No.", RecRequisitionLine."No.", RecRequisitionLine."Line No.");
    //IND En
    end;
    local procedure VendorNoOnAfterValidate()
    begin
        if(Rec."Replenishment System" = Rec."replenishment system"::Purchase) and (Rec."Action Message" = Rec."action message"::New) and (Rec."Created PO Doc. type" = Rec."created po doc. type"::"Sch. Order")then begin
            ///Find Out Purchase Rate Contract No.
            FindPurchRateContract(Rec);
        end;
    end;
}
