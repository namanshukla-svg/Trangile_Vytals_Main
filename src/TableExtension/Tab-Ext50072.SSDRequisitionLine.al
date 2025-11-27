TableExtension 50072 "SSD Requisition Line" extends "Requisition Line"
{
    fields
    {
        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
                lrec_PostedIndentLine: Record 50006;
                lText50000: Label 'Qunatity cannot be greater than %1 from Indent No. %2';
                lText50001: Label '"Do You want to delete the Line "';
            begin
                IF "Indent No." <> '' THEN BEGIN
                    TESTFIELD(Posted, FALSE);
                    lrec_PostedIndentLine.GET("Indent No.", "Indent Line No.", 2, "No.");
                    IF Quantity > lrec_PostedIndentLine.Quantity THEN ERROR(lText50000, lrec_PostedIndentLine.Quantity, lrec_PostedIndentLine."Document No.")
                END;
            end;
        }
        field(50001; "Responsibility Center"; Code[20])
        {
            CalcFormula = lookup("Req. Wksh. Template"."Responsibility Center" where(Name = field("Worksheet Template Name")));
            Description = 'CF001';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Responsibility Center';
        }
        field(50002; "Created PO Doc. type"; Option)
        {
            Description = 'IND for Purchase(New) -> Euote/Order/Sch. Order';
            Editable = true;
            OptionCaption = ' ,Quote,Order,Sch. Order';
            OptionMembers = " ",Quote,"Order","Sch. Order";
            DataClassification = CustomerContent;
            Caption = 'Created PO Doc. type';
        }
        field(50003; "Created PO No. Series"; Code[10])
        {
            Description = 'IND For selection of Particular No series';
            TableRelation = "No. Series".Code;
            DataClassification = CustomerContent;
            Caption = 'Created PO No. Series';

            trigger OnLookup()
            var
                PurchSetup: Record "Purchases & Payables Setup";
                ResponsibilityCenterLocal: Record "Responsibility Center";
            begin
                if ("Replenishment System" = "replenishment system"::Purchase) and ("Action Message" = "action message"::New) then begin
                    TestField("Created PO Doc. type");
                    PurchSetup.Get;
                    case "Created PO Doc. type" of
                        "created po doc. type"::Quote:
                            begin
                                if "Responsibility Center" <> '' then begin
                                    ResponsibilityCenterLocal.Get("Responsibility Center");
                                    ResponsibilityCenterLocal.TestField("Purchase Quote Nos.");
                                    //IG_DS_Before NoSeriesMgt.SelectSeries(ResponsibilityCenterLocal."Purchase Quote Nos.", "Created PO No. Series", "Created PO No. Series");
                                    NoSeriesMgt.LookupRelatedNoSeries(ResponsibilityCenterLocal."Purchase Quote Nos.", "Created PO No. Series", "Created PO No. Series")
                                end
                                else begin
                                    PurchSetup.TestField("Quote Nos.");
                                    //IG_DS_Before   NoSeriesMgt.SelectSeries(PurchSetup."Quote Nos.", "Created PO No. Series", "Created PO No. Series");
                                    NoSeriesMgt.LookupRelatedNoSeries(PurchSetup."Quote Nos.", "Created PO No. Series", "Created PO No. Series")
                                end;
                            end;
                        "created po doc. type"::Order:
                            begin
                                if "Responsibility Center" <> '' then begin
                                    ResponsibilityCenterLocal.Get("Responsibility Center");
                                    ResponsibilityCenterLocal.TestField("Purchase Order Nos.");
                                    //IG_DS_Before   NoSeriesMgt.SelectSeries(ResponsibilityCenterLocal."Purchase Order Nos.", "Created PO No. Series", "Created PO No. Series");
                                    NoSeriesMgt.LookupRelatedNoSeries(ResponsibilityCenterLocal."Purchase Order Nos.", "Created PO No. Series", "Created PO No. Series")
                                end
                                else begin
                                    PurchSetup.TestField("Order Nos.");
                                    //IG_DS_Before    NoSeriesMgt.SelectSeries(PurchSetup."Order Nos.", "Created PO No. Series", "Created PO No. Series");
                                    NoSeriesMgt.LookupRelatedNoSeries(PurchSetup."Order Nos.", "Created PO No. Series", "Created PO No. Series")
                                end;
                            end;
                    end;
                end;
            end;
        }
        field(50004; Posted; Boolean)
        {
            Description = 'IND';
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'Posted';
        }
        field(50005; "Pending PO"; Boolean)
        {
            Description = 'IND';
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'Pending PO';
        }
        field(50006; "Pending PO Qty"; Decimal)
        {
            Description = 'IND';
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'Pending PO Qty';
        }
        field(50007; "Requested PO Qty"; Decimal)
        {
            Description = 'IND required at the time of Po creation';
            DataClassification = CustomerContent;
            Caption = 'Requested PO Qty';

            trigger OnValidate()
            begin
                if "Pending PO" = false then
                    Error('')
                else if "Requested PO Qty" > "Pending PO Qty" then Error(POQtyErr, "Requested PO Qty", "Pending PO Qty");
            end;
        }
        field(50008; "For Tool Room"; Boolean)
        {
            Description = 'TR coming from Item';
            DataClassification = CustomerContent;
            Caption = 'For Tool Room';
        }
        field(50010; "Create SOB"; Boolean)
        {
            Description = 'SOB';
            DataClassification = CustomerContent;
            Caption = 'Create SOB';
        }
        field(50011; "SOB Entry"; Boolean)
        {
            Description = 'SOB';
            DataClassification = CustomerContent;
            Caption = 'SOB Entry';
        }
        field(50012; "Vendor Name"; Text[30])
        {
            Description = 'SOB';
            DataClassification = CustomerContent;
            Caption = 'Vendor Name';
        }
        field(50017; "No. of Archived Versions"; Integer)
        {
            CalcFormula = max("SSD Requisition Line Archive"."Version No." where("Worksheet Template Name" = field("Worksheet Template Name"), "Journal Batch Name" = field("Journal Batch Name"), "Line No." = field("Line No.")));
            Description = 'ALLE NV';
            FieldClass = FlowField;
            Caption = 'No. of Archived Versions';
        }
        field(50018; "Description 3"; Text[300])
        {
            Description = 'ALLE-070121';
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(54001; "Shelf No."; Code[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Shelf No.';
        }
        field(54002; "Indent No."; Code[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Indent No.';
        }
        field(54003; "Indent Line No."; Integer)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Indent Line No.';
        }
        field(54004; Remarks; Text[200])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Remarks';
        }
        field(54005; "Expected Cost"; Decimal)
        {
            CalcFormula = lookup("SSD Posted Indent Line"."Expected Cost" where("Document No." = field("Indent No."), Type = field(Type), "No." = field("No.")));
            FieldClass = FlowField;
            Caption = 'Expected Cost';
        }
        field(54006; "No. 2"; Code[20])
        {
            CalcFormula = lookup(Item."No. 2" where("No." = field("No.")));
            Description = 'CE001- Edit no. 2 field from item master';
            FieldClass = FlowField;
            Caption = 'No. 2';
        }
        field(54007; "MRP Qty."; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MRP Qty.';
        }
        field(54008; "MRP Remark"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'MRP Remark';
        }
        field(54009; "Vendor Name1"; Text[100])
        {
            CalcFormula = lookup(Vendor.Name where("No." = field("Vendor No.")));
            Description = 'ALLE';
            FieldClass = FlowField;
            Caption = 'Vendor Name1';
        }
        field(54010; "Item Procurement Category"; Option)
        {
            CalcFormula = lookup(Item."Procurement Category" where("No." = field("No.")));
            Description = 'ALLE';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = ' ,Runner,Repeater,Stranger,NPD,A,B,C';
            OptionMembers = " ",Runner,"Repeater",Stranger,NPD,A,B,C;
            Caption = 'Item Procurement Category';
        }
    }
    keys
    {
        key(Key2; "Indent No.", "Indent Line No.", Posted)
        {
        }
    }
    procedure ArchiveCalcPlanLines(TemplateName: Code[10]; BatchName: Code[10])
    var
        RequisitionLine: Record "Requisition Line";
        RequisitionLineArchive: Record "SSD Requisition Line Archive";
        Window: Dialog;
        Text0001: label 'Archiving       #1############';
        OrderStatus: Option;
    begin
        Window.Open(Text0001);
        RequisitionLine.Reset;
        RequisitionLine.SetRange("Worksheet Template Name", TemplateName);
        RequisitionLine.SetRange("Journal Batch Name", BatchName);
        if RequisitionLine.FindSet then
            repeat
                Window.Update(1, RequisitionLine."No." + ' ' + Format("Starting Date"));
                RequisitionLineArchive.Init;
                RequisitionLineArchive.TransferFields(RequisitionLine);
                RequisitionLineArchive."Version No." := GetArchiveVersoins(Database::"SSD Requisition Line Archive", RequisitionLineArchive."Worksheet Template Name", RequisitionLineArchive."Journal Batch Name", RequisitionLineArchive."Line No.", OrderStatus, '');
                RequisitionLineArchive."Archived by" := UserId;
                RequisitionLineArchive."Date Archived" := WorkDate;
                RequisitionLineArchive."Time Archived" := Time;
                RequisitionLineArchive.CopyLinks(RequisitionLine);
                RequisitionLineArchive.Insert;
            until RequisitionLine.Next = 0;
        Window.Close;
    end;

    procedure GetArchiveVersoins(TableID: Integer; TemplateName: Code[10]; BatchName: Code[10]; LineNo: Integer; OrderStatus: Option Simulated,Planned,"Firm Planned",Released,Finished; OrderNo: Code[20]) versionno: Integer
    var
        RequisitionLineArchive2: Record "SSD Requisition Line Archive";
        ProductionOrderArchive: Record "SSD Production Order Archive";
    begin
        case TableID of
            Database::"SSD Requisition Line Archive":
                begin
                    RequisitionLineArchive2.Reset;
                    RequisitionLineArchive2.SetRange("Worksheet Template Name", TemplateName);
                    RequisitionLineArchive2.SetRange("Journal Batch Name", BatchName);
                    RequisitionLineArchive2.SetRange("Line No.", LineNo);
                    if RequisitionLineArchive2.FindLast then
                        versionno := RequisitionLineArchive2."Version No." + 1
                    else
                        versionno := 1;
                end;
            Database::"SSD Production Order Archive":
                begin
                    ProductionOrderArchive.Reset;
                    ProductionOrderArchive.SetRange(Status, OrderStatus);
                    ProductionOrderArchive.SetRange("No.", OrderNo);
                    if ProductionOrderArchive.FindLast then
                        versionno := ProductionOrderArchive."Version No." + 1
                    else
                        versionno := 1;
                end;
        end;
    end;

    procedure ArchivePlannedProdOrder(ProductionOrder: Record "Production Order")
    var
        ProductionOrderArchive: Record "SSD Production Order Archive";
        ProdOrderLine: Record "Prod. Order Line";
        ProdOrderLineArchive: Record "SSD Prod. Ord Line Archive";
    begin
        ProductionOrderArchive.Init;
        ProductionOrderArchive.TransferFields(ProductionOrder);
        ProductionOrderArchive."Version No." := GetArchiveVersoins(Database::"SSD Production Order Archive", '', '', 0, ProductionOrder.Status, ProductionOrder."No.");
        ProductionOrderArchive."Archived by" := UserId;
        ProductionOrderArchive."Date Archived" := WorkDate;
        ProductionOrderArchive."Time Archived" := Time;
        ProductionOrderArchive.CopyLinks(ProductionOrder);
        ProductionOrderArchive.Insert;
        ProdOrderLine.SetRange(Status, ProductionOrder.Status);
        ProdOrderLine.SetRange("Prod. Order No.", ProductionOrder."No.");
        if ProdOrderLine.FindSet then
            repeat
                ProdOrderLineArchive.Init;
                ProdOrderLineArchive.TransferFields(ProdOrderLine);
                ProdOrderLineArchive."Version No." := ProductionOrderArchive."Version No.";
                ProdOrderLineArchive.CopyLinks(ProdOrderLine);
                ProdOrderLineArchive.Insert;
            until ProdOrderLine.Next = 0;
    end;

    var //IG_DS_Before NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        POQtyErr: Label 'Requested PO Qty %1 should not be greater then Pending PO Qty %2';
}
