TableExtension 50041 "SSD Item Journal Line" extends "Item Journal Line"
{
    fields
    {
        modify("Item No.")
        {
            trigger OnAfterValidate()
            begin
                if Item.Get("Item No.") then begin
                    "Description 2" := Item."Description 2";
                    if not Item."Quality Required" then "Quality Status" := "Quality Status"::" ";
                end;
                UpdateRespCenter();
            end;
        }
        modify("Location Code")
        {
            trigger OnAfterValidate()
            begin
                UpdateRespCenter();
            end;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                UpdateRespCenter();
            end;
        }
        modify("Order No.")
        {
            trigger OnAfterValidate()
            var
                ProdOrder: Record "Production Order";
            begin
                case "Order Type" OF
                    "Order Type"::Production:
                        begin
                            if "Order No." <> '' then begin
                                ProdOrder.GET(ProdOrder.Status::Released, "Order No.");
                                "Description 2" := ProdOrder."Description 2";
                            end;
                        end;
                end;
            end;
        }
        modify("Variant Code")
        {
            trigger OnAfterValidate()
            begin
                if "Variant Code" <> '' then begin
                    ItemVariant.Get("Item No.", "Variant Code");
                    "Description 2" := ItemVariant."Description 2";
                end;
            end;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                case Type of
                    Type::"Work Center":
                        begin
                            if WorkCenter.Get("No.") then "Description 2" := WorkCenter."Name 2";
                        end;
                    Type::"Machine Center":
                        begin
                            if MachineCenter.Get("No.") then "Description 2" := MachineCenter."Name 2";
                        end;
                end;
            end;
        }
        field(50000; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
            Description = 'Alle VPB';
            DataClassification = CustomerContent;
        }
        field(50002; "Posted Quality Order No."; Code[20])
        {
            Description = 'Posted Quality Order No.';
            TableRelation = "SSD Posted Quality Order Hdr"."No.";
            DataClassification = CustomerContent;
            Caption = 'Posted Quality Order No.';
        }
        field(50003; "Concerted Quality"; Boolean)
        {
            Description = 'QLT';
            DataClassification = CustomerContent;
            Caption = 'Concerted Quality';
        }
        field(50004; "Part No."; Code[20])
        {
            CalcFormula = lookup(Item."No. 2" where("No." = field("Item No.")));
            FieldClass = FlowField;
            Caption = 'Part No.';
        }
        field(50005; "Vendor Claim Code"; Code[10])
        {
            Description = 'QLT';
            DataClassification = CustomerContent;
            Caption = 'Vendor Claim Code';
        }
        field(50006; "Reclassif. Entry No."; Integer)
        {
            Caption = 'Reclassification Entry No.';
            Description = 'QLT';
            DataClassification = CustomerContent;
        }
        field(50007; "Reprocess PO"; Boolean)
        {
            Description = 'QLT';
            DataClassification = CustomerContent;
            Caption = 'Reprocess PO';
        }
        field(50008; "Quality Defect Code"; Code[10])
        {
            Caption = 'Quality Defect Code';
            Description = 'QLT';
            DataClassification = CustomerContent;
        }
        field(50010; "Responsibility Center"; Code[20])
        {
            Description = 'MSI.RC';
            Editable = false;
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center';
        }
        field(50011; "Order No.1"; Code[20])
        {
            Description = 'QLT';
            DataClassification = CustomerContent;
            Caption = 'Order No.1';
        }
        field(50012; "Quality Status"; Option)
        {
            Caption = 'Quality Status';
            Description = 'QLT -> Current Status of Quality Order';
            Editable = false;
            OptionCaption = ' ,Purchase,Manufacturing,Location Insp.,Scrap,MRN';
            OptionMembers = " ",Purchase,Manufacturing,"Location Insp.",Scrap,MRN;
            DataClassification = CustomerContent;
        }
        field(50013; "Quality Order Status"; Option)
        {
            Description = 'QLT -> Status of Source Quality Order';
            OptionCaption = ' ,Purchase,Manufacturing,Location Insp.,Scrap,MRN';
            OptionMembers = " ",Purchase,Manufacturing,"Location Insp.",Scrap,MRN;
            DataClassification = CustomerContent;
            Caption = 'Quality Order Status';
        }
        field(50014; "Date Filter"; Date)
        {
            Description = 'QLT';
            FieldClass = FlowFilter;
            Caption = 'Date Filter';
        }
        field(50015; "Pre. Operation No."; Code[10])
        {
            Description = 'QLT';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Pre. Operation No.';
        }
        field(50016; "Pre. Op. Posted Qty."; Decimal)
        {
            CalcFormula = sum("Capacity Ledger Entry"."Output Quantity" where("Order No." = field("Order No."), "Order Line No." = field("Order Line No."), "Routing No." = field("Routing No."), "Routing Reference No." = field("Routing Reference No."), "Operation No." = field("Pre. Operation No.")));
            Description = 'QLT';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Pre. Op. Posted Qty.';
        }
        field(50017; "Prod. Order Line Qty"; Decimal)
        {
            Description = 'QLT';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Prod. Order Line Qty';
        }
        field(50018; "Current Op. Posted Qty."; Decimal)
        {
            CalcFormula = sum("Capacity Ledger Entry"."Output Quantity" where("Order No." = field("Order No."), "Order Line No." = field("Order Line No."), "Routing No." = field("Routing No."), "Routing Reference No." = field("Routing Reference No."), "Operation No." = field("Operation No.")));
            Description = 'QLT';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Current Op. Posted Qty.';
        }
        field(50052; "For Maintenance"; Boolean)
        {
            Description = 'MT -> True for Maintenance';
            DataClassification = CustomerContent;
            Caption = 'For Maintenance';
        }
        field(50053; "Mnt Doc. Type"; Option)
        {
            Description = 'MT -> WorkOrder,Breakdown Intimation Slip';
            OptionCaption = 'WO,BIS';
            OptionMembers = WO,BIS;
            DataClassification = CustomerContent;
            Caption = 'Mnt Doc. Type';
        }
        field(50054; "Machine Type"; Option)
        {
            Description = 'MT -> Machine,Tool';
            OptionCaption = 'Machine,Tool';
            OptionMembers = Machine,Tool;
            DataClassification = CustomerContent;
            Caption = 'Machine Type';
        }
        field(50055; "Machine No."; Code[20])
        {
            Description = 'MT';
            DataClassification = CustomerContent;
            Caption = 'Machine No.';
        }
        field(50056; "Ledger Source Type"; Option)
        {
            Description = 'CF001 ->  ,Maintenance,Scrap,Rework,Line Rejection,Material Issue';
            OptionCaption = ' ,Maintenance,Scrap,Rework,Line Rejection,Material Issue';
            OptionMembers = " ",Maintenance,Scrap,Rework,"Line Rejection","Material Issue";
            DataClassification = CustomerContent;
            Caption = 'Ledger Source Type';
        }
        field(50057; "Suplementary Invoice"; Boolean)
        {
            Description = 'CF001.02 ->';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Suplementary Invoice';
        }
        field(50058; "Rework Qty"; Integer)
        {
            Description = 'Kapil added to flow in ILE,Value Entry,Cap Led Entry (Check Codeunit 22)';
            DataClassification = CustomerContent;
            Caption = 'Rework Qty';

            trigger OnValidate()
            begin
                if Type = Type::"Machine Center" then begin
                    ILE.SetRange(ILE."Order No.", "Order No.");
                    ILE.SetRange(ILE."Order Line No.", "Order Line No.");
                    //SSD Comment Start
                    // if ILE.Find('-') then begin
                    //     if "Rework Qty" > ILE."Rework Qty" then
                    //         Error(Text038);
                    // end else
                    //     if "Rework Qty" > 0 then
                    //         Error(Text038);
                    //SSD Comment End;
                end;
            end;
        }
        field(50059; "Rejected Qty"; Integer)
        {
            Description = 'Kapil added to flow in ILE,Value Entry,Cap Led Entry (Check Codeunit 22)';
            DataClassification = CustomerContent;
            Caption = 'Rejected Qty';
        }
        field(50060; "Subcon Output Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Subcon Output Quantity';
        }
        field(50061; "RGP Consumption"; Boolean)
        {
            Description = 'CML-034';
            DataClassification = CustomerContent;
            Caption = 'RGP Consumption';
        }
        field(50062; "RGP Output"; Boolean)
        {
            Description = 'CML-034';
            DataClassification = CustomerContent;
            Caption = 'RGP Output';
        }
        field(50063; "RGP Customer No."; Code[20])
        {
            Description = 'CML-034';
            DataClassification = CustomerContent;
            Caption = 'RGP Customer No.';
        }
        field(50064; "RGP Applied Qty."; Decimal)
        {
            CalcFormula = sum("SSD Item Ledger Entry Buffer"."Consumption Qty." where("Consumption Template Name" = field("Journal Template Name"), "Consumption Batch Name" = field("Journal Batch Name"), "Consumption Line No." = field("Line No."), Apply = filter(true)));
            Description = 'CML-034';
            FieldClass = FlowField;
            Caption = 'RGP Applied Qty.';
        }
        field(50065; Rejected; Boolean)
        {
            Caption = 'Rejected';
            Description = 'SR-QLT';
            DataClassification = CustomerContent;
        }
        field(50066; "Quality Required"; Boolean)
        {
            Caption = 'Quality Required';
            Description = 'QA-013/014';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50067; "Sent for Quality"; Boolean)
        {
            Caption = 'Sent for Quality';
            Description = 'QA-013/014';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50068; "Quality Done"; Boolean)
        {
            Caption = 'Quality Done';
            Description = 'QA-013/014';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50069; "Sample Quantity"; Decimal)
        {
            Caption = 'Sample Quantity';
            DecimalPlaces = 0 : 5;
            Description = 'QA-013/014';
            DataClassification = CustomerContent;
        }
        field(50070; "Quality Template Master"; Code[20])
        {
            Caption = 'Quality Template Master';
            Description = 'QA-013/014';
            Editable = false;
            TableRelation = "SSD Sampling Temp. Header" where("Template Type" = const(Manufacturing));
            DataClassification = CustomerContent;
        }
        field(50071; "Posted Quantity"; Decimal)
        {
            Caption = 'Posted Quantity';
            Description = 'QA-013/014';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50072; "Sample Qty. Sent to QC"; Decimal)
        {
            Caption = 'Sample Qty. Sent to QC';
            Description = 'QA-013/014';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50073; "Rejected Qty."; Decimal)
        {
            Caption = 'Rejected Qty.';
            Description = 'PQA-003';
            DataClassification = CustomerContent;
        }
        field(50074; Sample; Boolean)
        {
            Caption = 'Sample';
            Description = 'PQA-003';
            DataClassification = CustomerContent;
        }
        field(50075; "Sampled By"; Code[20])
        {
            Caption = 'Sampled By';
            Description = 'PQA-003';
            DataClassification = CustomerContent;
        }
        field(50076; "Sampling Date"; Date)
        {
            Caption = 'Sampling Date';
            Description = 'PQA-003';
            DataClassification = CustomerContent;
        }
        field(50077; "MRN No."; Code[20])
        {
            Caption = 'MRN No.';
            Description = 'PQA-003';
            DataClassification = CustomerContent;
        }
        field(50078; "MRN Line No."; Integer)
        {
            Caption = 'MRN Line No.';
            Description = 'PQA-003';
            DataClassification = CustomerContent;
        }
        field(50079; "No. of Container"; Integer)
        {
            Caption = 'No. of Container';
            Description = 'PQA-003';
            DataClassification = CustomerContent;
        }
        field(50080; "Pack Quantity"; Decimal)
        {
            Caption = 'Pack Quantity';
            Description = 'PQA-003';
            DataClassification = CustomerContent;
        }
        field(50081; "Manufacturing date"; Date)
        {
            Caption = 'Manufacturing date';
            Description = 'PQA-003';
            DataClassification = CustomerContent;
        }
        field(50082; "Unused Field 1"; Code[1])
        {
            Caption = 'Unused Field 1';
            Description = 'PQA-003 UNUSED FIELDS : ADDED FOR FUTURE REQUIRMENT : REASON - ADDING FIELD FOR THIS FUNCTIONALITY TAKES TIME';
            DataClassification = CustomerContent;
        }
        field(50083; "Unused Field 2"; Code[1])
        {
            Caption = 'Unused Field 2';
            Description = 'PQA-003 UNUSED FIELDS : ADDED FOR FUTURE REQUIRMENT : REASON - ADDING FIELD FOR THIS FUNCTIONALITY TAKES TIME';
            DataClassification = CustomerContent;
        }
        field(50084; "Unused Field 3"; Code[1])
        {
            Caption = 'Unused Field 3';
            Description = 'PQA-003 UNUSED FIELDS : ADDED FOR FUTURE REQUIRMENT : REASON - ADDING FIELD FOR THIS FUNCTIONALITY TAKES TIME';
            DataClassification = CustomerContent;
        }
        field(50085; "Unused Field 4"; Code[1])
        {
            Caption = 'Unused Field 4';
            Description = 'PQA-003 UNUSED FIELDS : ADDED FOR FUTURE REQUIRMENT : REASON - ADDING FIELD FOR THIS FUNCTIONALITY TAKES TIME';
            DataClassification = CustomerContent;
        }
        field(50086; "Unused Field 5"; Code[1])
        {
            Caption = 'Unused Field 5';
            Description = 'PQA-003 UNUSED FIELDS : ADDED FOR FUTURE REQUIRMENT : REASON - ADDING FIELD FOR THIS FUNCTIONALITY TAKES TIME';
            DataClassification = CustomerContent;
        }
        field(50087; "Send for Approval"; Boolean)
        {
            Description = 'Alle Workflow Item Journal';
            DataClassification = CustomerContent;
            Caption = 'Send for Approval';
        }
        field(50088; Approval; Boolean)
        {
            Description = 'Alle Workflow Item Journal';
            DataClassification = CustomerContent;
            Caption = 'Approval';
        }
        field(50089; "Sender ID"; Code[30])
        {
            Description = 'Alle Workflow Item Journal';
            DataClassification = CustomerContent;
            Caption = 'Sender ID';
        }
        field(50090; "Approval ID"; Code[30])
        {
            Description = 'Alle Workflow Item Journal';
            DataClassification = CustomerContent;
            Caption = 'Approval ID';
        }
        field(50091; "Manufacturing Date New"; Date)
        {
            Description = 'Alle- AT field added for Production Journal Posting';
            DataClassification = CustomerContent;
            Caption = 'Manufacturing Date New';
        }
        field(60001; "OutPut Item Unit Of Measure"; Decimal)
        {
            Description = 'ALLEAA CML-033 280308';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'OutPut Item Unit Of Measure';
        }
        field(60002; "Output Item Code"; Code[20])
        {
            Description = 'ALLEAA CML-033 280308';
            Editable = false;
            TableRelation = Item;
            DataClassification = CustomerContent;
            Caption = 'Output Item Code';
        }
        field(60003; "RG23D Entry No."; Integer)
        {
            Description = 'CE_AA006';
            DataClassification = CustomerContent;
            Caption = 'RG23D Entry No.';
        }
        field(60004; "Detail RG23D Entry No."; Integer)
        {
            Description = 'CE_AA006';
            DataClassification = CustomerContent;
            Caption = 'Detail RG23D Entry No.';
        }
        field(60005; "Prod. BOM No."; Code[20])
        {
            Description = 'ALLEAA CML-033 280308';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Prod. BOM No.';
        }
        field(60006; "Production BOM Quantity"; Decimal)
        {
            Description = 'ALLEAA CML-033 280308';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Production BOM Quantity';
        }
        field(60007; "Parent Document No."; Code[20])
        {
            Description = 'ALLEAA CML-033 280308';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Parent Document No.';
        }
        field(60008; "Party No."; Code[20])
        {
            Description = 'ALLEAA CML-033 280308';
            TableRelation = Vendor;
            DataClassification = CustomerContent;
            Caption = 'Party No.';
        }
        field(60009; "Party Location"; Code[20])
        {
            Description = 'ALLEAA CML-033 280308';
            TableRelation = Location;
            DataClassification = CustomerContent;
            Caption = 'Party Location';
        }
        field(60010; "Template Name"; Code[20])
        {
            Description = 'ALLEAA CML-033 280308';
            DataClassification = CustomerContent;
            Caption = 'Template Name';
        }
        field(60011; "Batch Name"; Code[20])
        {
            Description = 'ALLEAA CML-033 280308';
            DataClassification = CustomerContent;
            Caption = 'Batch Name';
        }
        field(60012; "OutPut Item UOM"; Code[20])
        {
            Description = 'ALLEAA CML-033 280308';
            Editable = false;
            TableRelation = "Unit of Measure";
            DataClassification = CustomerContent;
            Caption = 'OutPut Item UOM';
        }
        field(60013; "OutPut Item Quantity"; Decimal)
        {
            Description = 'ALLEAA CML-033 280308';
            MinValue = 0;
            DataClassification = CustomerContent;
            Caption = 'OutPut Item Quantity';
        }
        field(60014; "Parent Document Line No."; Integer)
        {
            Description = 'ALLEAA CML-033 280308';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Parent Document Line No.';
        }
        field(60015; "Scrap Received"; Boolean)
        {
            Description = 'ALLEAA CML-033 280308';
            DataClassification = CustomerContent;
            Caption = 'Scrap Received';
        }
        field(60016; "BOM Quantity"; Decimal)
        {
            Description = 'ALLEAA CML-033 280308';
            Editable = false;
            MinValue = 0;
            DataClassification = CustomerContent;
            Caption = 'BOM Quantity';
        }
        field(60017; "Scrap Generated"; Decimal)
        {
            Description = 'ALLEAA CML-033 280308';
            DataClassification = CustomerContent;
            Caption = 'Scrap Generated';
        }
        field(60018; "SUBCON Consumption"; Boolean)
        {
            Description = 'ALLEAA CML-033 210408';
            DataClassification = CustomerContent;
            Caption = 'SUBCON Consumption';
        }
        field(60019; "Qty Main Store"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Qty Main Store';
        }
        field(65000; "Production Doc. No."; Text[50])
        {
            Description = 'ISS-007';
            DataClassification = CustomerContent;
            Caption = 'Production Doc. No.';
        }
        field(65001; "Production Doc. Type"; Option)
        {
            Description = 'ISS-007';
            OptionCaption = ' ,Coating Log,Blending Log,Job Work Log,I/O Slip,Issue Slip,Others,Prod-Check';
            OptionMembers = " ","Coating Log","Blending Log","Job Work Log","I/O Slip","Issue Slip",Others,"Prod-Check";
            DataClassification = CustomerContent;
            Caption = 'Production Doc. Type';
        }
        field(65002; "Phy. Bin Code"; Code[20])
        {
            TableRelation = "SSD Phy. Bin Details"."Phy. Bin Code" where("Location Code" = field("Location Code"), "Bin Code" = field("Bin Code"));
            DataClassification = CustomerContent;
            Caption = 'Phy. Bin Code';
        }
        field(65003; "New Phy. Bin Code"; Code[20])
        {
            TableRelation = "SSD Phy. Bin Details"."Phy. Bin Code" where("Location Code" = field("New Location Code"), "Bin Code" = field("New Bin Code"));
            DataClassification = CustomerContent;
            Caption = 'New Phy. Bin Code';
        }
        field(65004; "Pack Size"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Pack Size';
        }
        //IG_DS>>
        field(65005; "From Package"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(65006; "To Package"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        //IG_DS<<
    }
    //SSDU
    // trigger OnAfterInsert()
    // begin
    //     UpdateRespCenter();
    // end;
    //SSDU
    /// <summary>
    /// CheckingOutputQty.
    /// </summary>
    /// <param name="RecItemJnlLine">Record "Item Journal Line".</param>
    procedure CheckingOutputQty(RecItemJnlLine: Record "Item Journal Line")
    begin
        if RecItemJnlLine."Output Quantity" <> 0 then begin
            CalcPreOpeTotalOutputQty(RecItemJnlLine);
            if RecItemJnlLine."Pre. Operation No." <> '' then begin
                if RecItemJnlLine."Output Quantity" > (RecItemJnlLine."Pre. Op. Posted Qty." - RecItemJnlLine."Current Op. Posted Qty.") then Error(Error001, RecItemJnlLine.FieldCaption("Output Quantity"), (RecItemJnlLine."Pre. Op. Posted Qty." - RecItemJnlLine."Current Op. Posted Qty."));
            end
            else begin
                if RecItemJnlLine."Output Quantity" > (RecItemJnlLine."Prod. Order Line Qty" - RecItemJnlLine."Current Op. Posted Qty.") then Error(Error001, RecItemJnlLine.FieldCaption("Output Quantity"), (RecItemJnlLine."Prod. Order Line Qty" - RecItemJnlLine."Current Op. Posted Qty."));
            end;
        end;
    end;
    /// <summary>
    /// SetUpNewLine1.
    /// </summary>
    /// <param name="LastItemJnlLine">Record "Item Journal Line".</param>
    procedure SetUpNewLine1(LastItemJnlLine: Record "Item Journal Line")
    begin
        MfgSetup.Get;
        ItemJnlTemplate.Get("Journal Template Name");
        ItemJnlBatch.Get("Journal Template Name", "Journal Batch Name");
        "Posting Date" := WorkDate;
        "Document Date" := WorkDate;
        if ItemJnlBatch."No. Series" <> '' then begin
            Clear(NoSeries);
            //IG_DS_Before  "Document No." := NoSeriesMgt.TryGetNextNo(ItemJnlBatch."No. Series", "Posting Date");
            "Document No." := NoSeries.PeekNextNo(ItemJnlBatch."No. Series", "Posting Date");
        end;
        "Recurring Method" := LastItemJnlLine."Recurring Method";
        "Entry Type" := LastItemJnlLine."Entry Type";
        "Source Code" := ItemJnlTemplate."Source Code";
        "Reason Code" := ItemJnlBatch."Reason Code";
        "Posting No. Series" := ItemJnlBatch."Posting No. Series";
        UpdateRespCenter; //Alle VPB
    end;
    /// <summary>
    /// CheckMaterialIssueQty.
    /// </summary>
    procedure CheckMaterialIssueQty()
    var
        MaterialIssueJournal: Record "SSD Mat. Issue Journal Line";
    begin
        MaterialIssueJournal.Reset;
        if MaterialIssueJournal.Get("Document No.", "Line No.") then if Quantity > MaterialIssueJournal.Quantity then Error('Quantity Can Not be more than Issue Quantity');
    end;
    /// <summary>
    /// CalcPreOpeTotalOutputQty.
    /// </summary>
    /// <param name="RecItemJournalLine">VAR Record "Item Journal Line".</param>
    procedure CalcPreOpeTotalOutputQty(var RecItemJournalLine: Record "Item Journal Line")
    begin
        //CF001 St
        //**** For Calculation of Previous Operation Total Output Qty and current operation total output qty
        if RecItemJournalLine."Pre. Operation No." <> '' then begin
            RecItemJournalLine.SetFilter("Date Filter", '<=%1', RecItemJournalLine."Posting Date");
            RecItemJournalLine.CalcFields("Pre. Op. Posted Qty.");
        end;
        if RecItemJournalLine."Operation No." <> '' then begin
            RecItemJournalLine.CalcFields("Current Op. Posted Qty.");
        end;
        //CF001 En
    end;
    /// <summary>
    /// GetBatchNo.
    /// </summary>
    /// <param name="ProdNo">Code[20].</param>
    /// <returns>Return value of type Code[20].</returns>
    procedure GetBatchNo(ProdNo: Code[20]): Code[20]
    var
        ReservationEntry: Record "Reservation Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        BatchProdOrderLine: Record "Prod. Order Line";
    begin
        // QA-013/014
        BatchProdOrderLine.Reset;
        BatchProdOrderLine.SetRange(BatchProdOrderLine."Prod. Order No.", ProdNo);
        if BatchProdOrderLine.FindFirst then begin
            if BatchProdOrderLine."Finished Quantity" = 0 then begin
                ReservationEntry.Reset;
                ReservationEntry.SetRange("Source ID", ProdNo);
                if ReservationEntry.FindFirst then exit(ReservationEntry."Lot No.");
            end
            else begin
                ItemLedgerEntry.Reset;
                ItemLedgerEntry.SetRange("Order No.", ProdNo);
                ItemLedgerEntry.SetRange(ItemLedgerEntry."Entry Type", ItemLedgerEntry."entry type"::Output);
                if ItemLedgerEntry.FindFirst then exit(ItemLedgerEntry."Lot No.");
            end;
        end;
        // QA-013/014
    end;
    /// <summary>
    /// UpdateRespCenter.
    /// </summary>
    procedure UpdateRespCenter()
    begin
        //SSDU
        //MSI.RC
        // usersetup.Get(UserId);
        // usersetup.TestField("Responsibility Center");
        // if RespCent.Get(usersetup."Responsibility Center") then
        //     "Responsibility Center" := RespCent.Code;
        //MSI.RC
        //SSDU
    end;

    var
        usersetup: Record "User Setup";
        RespCent: Record "Responsibility Center";
        Item: Record Item;
        ItemUOM: Record "Item Unit of Measure";
        ILE: Record "Item Ledger Entry";
        ItemJnlTemplate: Record "Item Journal Template";
        ItemJnlBatch: Record "Item Journal Batch";
        ItemVariant: Record "Item Variant";
        WorkCenter: Record "Work Center";
        MachineCenter: Record "Machine Center";
        MfgSetup: Record "Manufacturing Setup";
        //IG_DS_Before  NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeries: Codeunit "No. Series";
        Error001: label '%1 must be <= %2';
}
