TableExtension 50043 "SSD Item Ledger Entry" extends "Item Ledger Entry"
{
    fields
    {
        field(50001; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Description = 'MSI.RC';
            Editable = false;
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
        }
        field(50002; "Posted Quality Order No."; Code[20])
        {
            CalcFormula = lookup("SSD Posted Quality Order Hdr"."No." where("Lot No." = field("Lot No.")));
            Description = 'QLT';
            FieldClass = FlowField;
            Caption = 'Posted Quality Order No.';
        }
        field(50003; "Concerted Quality"; Boolean)
        {
            Caption = 'Concerted Quality';
            Description = 'QLT';
            DataClassification = CustomerContent;
        }
        field(50005; "Vendor Claim Code"; Code[10])
        {
            Caption = 'Vendor Claim Code';
            Description = 'QLT';
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(50006; "Quality Status"; Option)
        {
            Description = 'QLT -> Current Status of Quality Order';
            OptionCaption = ' ,Purchase,Manufacturing,Location Insp.,Scrap,MRN';
            OptionMembers = " ",Purchase,Manufacturing,"Location Insp.",Scrap,MRN;
            DataClassification = CustomerContent;
            Caption = 'Quality Status';
        }
        field(50007; "Quality Order Status"; Option)
        {
            Description = 'QLT -> Status of Source Quality Order';
            OptionCaption = ' ,Purchase,Manufacturing,Location Insp.,Scrap,MRN';
            OptionMembers = " ",Purchase,Manufacturing,"Location Insp.",Scrap,MRN;
            DataClassification = CustomerContent;
            Caption = 'Quality Order Status';
        }
        field(50008; "Reclass. Item Entry Source No."; Integer)
        {
            Caption = 'Reclass. Item Entry Source No.';
            Description = 'QLT';
            DataClassification = CustomerContent;
        }
        field(50009; "Reprocess PO"; Boolean)
        {
            Caption = 'Reprocess PO';
            Description = 'QLT';
            DataClassification = CustomerContent;
        }
        field(50010; "Quality Defect Code"; Code[10])
        {
            Caption = 'Quality Defect Code';
            Description = 'QLT';
            TableRelation = "SSD Quality Defects";
            DataClassification = CustomerContent;
        }
        field(50014; Returning; Boolean)
        {
            Caption = 'Returning';
            Description = 'QLT';
            DataClassification = CustomerContent;
        }
        field(50015; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            TableRelation = Bin.Code where("Location Code" = field("Location Code"));
            DataClassification = CustomerContent;
        }
        field(50050; "Export Document"; Boolean)
        {
            Description = 'EXIM';
            DataClassification = CustomerContent;
            Caption = 'Export Document';
        }
        field(50051; "Import Document"; Boolean)
        {
            Description = 'EXIM';
            DataClassification = CustomerContent;
            Caption = 'Import Document';
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
            Enabled = false;
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
            Description = 'Kapil added this field (Check Table 83)';
            DataClassification = CustomerContent;
            Caption = 'Rework Qty';
        }
        field(50059; "Rejected Qty"; Integer)
        {
            Description = 'Kapil added this field (Check Table 83)';
            DataClassification = CustomerContent;
            Caption = 'Rejected Qty';
        }
        field(50060; "Subcon Output Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Subcon Output Quantity';
        }
        field(50063; "RGP Customer No."; Code[20])
        {
            Description = 'CML-034';
            DataClassification = CustomerContent;
            Caption = 'RGP Customer No.';
        }
        field(50064; "Consumption Line No."; Integer)
        {
            Caption = 'Consumption Line No.';
            Description = 'QA-013/014';
            DataClassification = CustomerContent;
        }
        field(50065; "Rejected Qty."; Decimal)
        {
            Caption = 'Rejected Qty.';
            Description = 'PQA-003';
            DataClassification = CustomerContent;
        }
        field(50066; Sample; Boolean)
        {
            Caption = 'Sample';
            Description = 'PQA-003';
            DataClassification = CustomerContent;
        }
        field(50067; "Sample Quantity"; Decimal)
        {
            Caption = 'Sample Quantity';
            Description = 'PQA-003';
            DataClassification = CustomerContent;
        }
        field(50068; "Sampled By"; Code[20])
        {
            Caption = 'Sampled By';
            Description = 'PQA-003';
            DataClassification = CustomerContent;
        }
        field(50069; "Sampling Date"; Date)
        {
            Caption = 'Sampling Date';
            Description = 'PQA-003';
            DataClassification = CustomerContent;
        }
        field(50070; "MRN No."; Code[20])
        {
            Caption = 'MRN No.';
            Description = 'PQA-003';
            DataClassification = CustomerContent;
        }
        field(50071; "MRN Line No."; Integer)
        {
            Caption = 'MRN Line No.';
            Description = 'PQA-003';
            DataClassification = CustomerContent;
        }
        field(50072; "No. of Container"; Integer)
        {
            Caption = 'No. of Container';
            Description = 'PQA-003';
            DataClassification = CustomerContent;
        }
        field(50073; "Pack Quantity"; Decimal)
        {
            Caption = 'Pack Quantity';
            Description = 'PQA-003';
            DataClassification = CustomerContent;
        }
        field(50074; "Manufacturing date"; Date)
        {
            Caption = 'Manufacturing date';
            Description = 'PQA-003';
            DataClassification = CustomerContent;
        }
        field(50075; "Unused Field 1"; Code[1])
        {
            Caption = 'Unused Field 1';
            Description = 'PQA-003 UNUSED FIELDS : ADDED FOR FUTURE REQUIRMENT : REASON - ADDING FIELD FOR THIS FUNCTIONALITY TAKES TIME';
            DataClassification = CustomerContent;
        }
        field(50076; "Unused Field 2"; Code[1])
        {
            Caption = 'Unused Field 2';
            Description = 'PQA-003 UNUSED FIELDS : ADDED FOR FUTURE REQUIRMENT : REASON - ADDING FIELD FOR THIS FUNCTIONALITY TAKES TIME';
            DataClassification = CustomerContent;
        }
        field(50077; "Unused Field 3"; Code[1])
        {
            Caption = 'Unused Field 3';
            Description = 'PQA-003 UNUSED FIELDS : ADDED FOR FUTURE REQUIRMENT : REASON - ADDING FIELD FOR THIS FUNCTIONALITY TAKES TIME';
            DataClassification = CustomerContent;
        }
        field(50078; "Unused Field 4"; Code[1])
        {
            Caption = 'Unused Field 4';
            Description = 'PQA-003 UNUSED FIELDS : ADDED FOR FUTURE REQUIRMENT : REASON - ADDING FIELD FOR THIS FUNCTIONALITY TAKES TIME';
            DataClassification = CustomerContent;
        }
        field(50079; "Unused Field 5"; Code[1])
        {
            Caption = 'Unused Field 5';
            Description = 'PQA-003 UNUSED FIELDS : ADDED FOR FUTURE REQUIRMENT : REASON - ADDING FIELD FOR THIS FUNCTIONALITY TAKES TIME';
            DataClassification = CustomerContent;
        }
        field(50080; "Lot Blocked"; Boolean)
        {
            Description = 'AlleZav1.03/070815 Lot Blocked';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Lot Blocked';
        }
        field(50081; "Unblock Date"; Date)
        {
            Description = 'AlleZav1.03/070815 Lot Blocked';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Unblock Date';
        }
        field(50082; "Inventory Taging Person"; Code[20])
        {
            Description = 'ALLE 1.0';
            DataClassification = CustomerContent;
            Caption = 'Inventory Taging Person';
        }
        field(50083; "Manufacturing Date New"; Date)
        {
            Description = 'ALLE - 221020';
            DataClassification = CustomerContent;
            Caption = 'Manufacturing Date New';
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
        field(65002; "Inv. Lot Scanned"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inv. Lot Scanned';
        }
        //IG_DS>>
        field(90000; "Quality Status Released"; Boolean)
        {
            CalcFormula = exist("SSD Quality Order Header" where("Lot No." = field("Lot No."), "Lot No." = filter(<> ''), Status = filter(Open)));
            FieldClass = FlowField;
        }
        //IG_DS<<
    }
}
