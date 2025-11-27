TableExtension 50107 "SSD User Setup" extends "User Setup"
{
    fields
    {
        field(50000; "Responsibility Center"; Code[10])
        {
            Description = 'CF001';
            TableRelation = "Responsibility Center".Code;
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center';
        }
        field(50001; "Indent Access"; Option)
        {
            Description = 'CF001';
            OptionCaption = 'Limited,Full';
            OptionMembers = Limited,Full;
            DataClassification = CustomerContent;
            Caption = 'Indent Access';
        }
        field(50020; "Undo Gate Receipt"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Undo Gate Receipt';
        }
        field(50023; "Undo Challan"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Undo Challan';
        }
        field(50024; "Item UnBlock Rights"; Boolean)
        {
            Description = 'ALLE 6.02';
            DataClassification = CustomerContent;
            Caption = 'Item UnBlock Rights';
        }
        field(50025; "Customer UnBlock Rights"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Customer UnBlock Rights';
        }
        field(50026; "Vendor UnBlock Rights"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor UnBlock Rights';
        }
        field(50027; "Bank UnBlock Rights"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Bank UnBlock Rights';
        }
        field(50028; "G/L UnBlock Rights"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'G/L UnBlock Rights';
        }
        field(50029; Name; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Name';
        }
        field(50030; "View GP%"; Boolean)
        {
            Description = 'ALLE[551]';
            DataClassification = CustomerContent;
            Caption = 'View GP%';
        }
        field(50031; "Allow Current Date Posting"; Boolean)
        {
            Description = 'ALLE[551]-01-05-13';
            DataClassification = CustomerContent;
            Caption = 'Allow Current Date Posting';
        }
        field(50032; "Prod.BOM Approval Permission"; Boolean)
        {
            Description = 'ALLE[551]-14-06-13';
            DataClassification = CustomerContent;
            Caption = 'Prod.BOM Approval Permission';
        }
        field(50033; "Comments Dept"; Option)
        {
            Description = 'ALLE[551]';
            OptionCaption = ' ,CC,SCM,PPC,MGMT,ALL';
            OptionMembers = " ",CC,SCM,PPC,MGMT,ALL;
            DataClassification = CustomerContent;
            Caption = 'Comments Dept';
        }
        field(50034; "Quality Approval Permission"; Boolean)
        {
            Description = 'ALLE[551]';
            DataClassification = CustomerContent;
            Caption = 'Quality Approval Permission';
        }
        field(50035; "Item Journal Permission"; Boolean)
        {
            Description = 'ALLE[551]';
            DataClassification = CustomerContent;
            Caption = 'Item Journal Permission';
        }
        field(50036; "Master Editing Permission"; Boolean)
        {
            Description = 'Alle[Z]';
            DataClassification = CustomerContent;
            Caption = 'Master Editing Permission';
        }
        field(50037; "Firm Freight Permission"; Boolean)
        {
            Description = 'Alle[Z]';
            DataClassification = CustomerContent;
            Caption = 'Firm Freight Permission';
        }
        field(50038; "Navigate Visible"; Boolean)
        {
            Description = 'Alle NV.DP.1.00';
            DataClassification = CustomerContent;
            Caption = 'Navigate Visible';
        }
        field(50039; "SCM Drilldown Permission"; Boolean)
        {
            Description = 'Alle NV.DP.1.00';
            DataClassification = CustomerContent;
            Caption = 'SCM Drilldown Permission';
        }
        field(50040; "Hold Vend. Payment Permission"; Boolean)
        {
            Description = 'HP1.0';
            DataClassification = CustomerContent;
            Caption = 'Hold Vend. Payment Permission';
        }
        field(50041; "UnHold Vend Payment Permission"; Boolean)
        {
            Description = 'HP1.0';
            DataClassification = CustomerContent;
            Caption = 'UnHold Vend Payment Permission';
        }
        field(50042; "HO Drilldown Permission"; Boolean)
        {
            Description = 'Alle NV.DP.1.00';
            DataClassification = CustomerContent;
            Caption = 'HO Drilldown Permission';
        }
        field(50043; "Plant Drilldown Permission"; Boolean)
        {
            Description = 'Alle NV.DP.1.00';
            DataClassification = CustomerContent;
            Caption = 'Plant Drilldown Permission';
        }
        field(50044; "Avg. Cost Calc."; Boolean)
        {
            Description = 'Alle NV.DP.1.00';
            DataClassification = CustomerContent;
            Caption = 'Avg. Cost Calc.';
        }
        field(50045; "Bom & Routing"; Boolean)
        {
            Description = 'Alle NV.DP.1.00';
            DataClassification = CustomerContent;
            Caption = 'Bom & Routing';
        }
        field(50046; "Invoice Received by Finanace"; Boolean)
        {
            Description = 'ZD RS';
            DataClassification = CustomerContent;
            Caption = 'Invoice Received by Finanace';
        }
        field(50047; "Department Planning Mail"; Option)
        {
            Description = 'ALLE NV';
            OptionCaption = ' ,Purchase,Production';
            OptionMembers = " ",Purchase,Production;
            DataClassification = CustomerContent;
            Caption = 'Department Planning Mail';
        }
        field(50048; "Indent Approval"; Boolean)
        {
            Description = 'BS14122016 ByPass the Indent Approval and direct release.';
            DataClassification = CustomerContent;
            Caption = 'Indent Approval';
        }
        field(50049; "Generate E-Way Bill"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Generate E-Way Bill';
        }
        field(50050; "IJL Send For Approval"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'IJL Send For Approval';
        }
        field(50051; "IJL Approval"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'IJL Approval';
        }
        field(50052; "RGP Send For Approval"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'RGP Send For Approval';
        }
        field(50053; "RGP Approval"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'RGP Approval';
        }
        field(50054; "NRGP Send For Approval"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'NRGP Send For Approval';
        }
        field(50055; "NRGP Approval"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'NRGP Approval';
        }
        field(50056; "Indent Costcen Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Indent Costcen Code';
        }
        field(50057; "Sales Price Approval"; Boolean)
        {
            Description = 'Alle';
            DataClassification = CustomerContent;
            Caption = 'Sales Price Approval';
        }
        field(50058; "Purchase Price Approval"; Boolean)
        {
            Description = 'Alle';
            DataClassification = CustomerContent;
            Caption = 'Purchase Price Approval';
        }
        field(50059; "HSN Change"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'HSN Change';
        }
        field(50060; "Short Close"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Short Close';
        }
        field(50061; "Machine Center Editable"; Boolean)
        {
            Description = 'ALLE-NM 27092019';
            DataClassification = CustomerContent;
            Caption = 'Machine Center Editable';
        }
        field(50062; "57F4 Edit"; Boolean)
        {
            Description = 'ALLE-NM 31102019';
            DataClassification = CustomerContent;
            Caption = '57F4 Edit';
        }
        field(50063; AccessPermisson; Boolean)
        {
            Description = 'ALLE-AU 11022020';
            DataClassification = CustomerContent;
            Caption = 'AccessPermisson';
        }
        field(50064; "Receipt sendbyStore Permis"; Boolean)
        {
            Caption = 'Receipt send by Store Permission';
            Description = 'ALLE-HG-16.09.20';
            DataClassification = CustomerContent;
        }
        field(50065; "Receipt receivedby Fin Permis"; Boolean)
        {
            Caption = 'Receipt received by Finance Permission';
            Description = 'ALLE-HG-16.09.20';
            DataClassification = CustomerContent;
        }
        field(50066; "Receipt receivedby Fin Admin"; Boolean)
        {
            Description = 'ALLE-HG-16.09.20';
            DataClassification = CustomerContent;
            Caption = 'Receipt receivedby Fin Admin';
        }
        field(50067; "Allow to Rec. Item Charge"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Allow to Rec. Item Charge';
        }
        field(50069; "Allow Requisition Issue Qty"; Boolean)
        {
            Description = 'Alle 26112021';
            DataClassification = CustomerContent;
            Caption = 'Allow Requisition Issue Qty';
        }
        field(50070; "ALLow LR No."; Boolean)
        {
            Description = 'Alle 08032021';
            DataClassification = CustomerContent;
            Caption = 'ALLow LR No.';
        }
        field(50071; "Issue Slip Approver Mail Id"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Issue Slip Approver Mail Id';
        }
        field(50072; "Approver ID Issue Slip"; Code[50])
        {
            Caption = 'Approver ID';
            TableRelation = "User Setup"."User ID";
            DataClassification = CustomerContent;

            trigger OnLookup()
            var
                UserSetup: Record "User Setup";
            begin
                UserSetup.SetFilter("User ID", '<>%1', "User ID");
                if Page.RunModal(Page::"Approval User Setup", UserSetup) = Action::LookupOK then Validate("Approver ID", UserSetup."User ID");
            end;
        }
        field(50073; "Sales Order Delete"; Boolean)
        {
            Description = 'Alle 06042021';
            DataClassification = CustomerContent;
            Caption = 'Sales Order Delete';
        }
        field(50074; "HRMS Permission"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'HRMS Permission';
        }
        field(50075; "Close Indent"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Close Indent';
        }
        field(50076; "Close PO"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Close PO';
        }
        field(50078; "Type of Invoice"; Enum "Type Of Invoice Sales")
        {
            Caption = 'Type of Invoice';
        }
        field(50079; "Item Vendor Permission"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Item Vendor Permission';
        }
        field(50080; "Sepecial Permission"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Sepecial Permission';
        }
        field(50350; "Attachment Admin"; Boolean)
        {
            Caption = 'Attachment Admin';
            DataClassification = CustomerContent;
        }
        field(50351; "Service Receipts"; Boolean)
        {
            Caption = 'Service Receipts';
            DataClassification = CustomerContent;
        }
        field(50352; "SSD PO Grace Period"; Boolean)
        {
            Caption = 'PO Grace Period';
            DataClassification = CustomerContent;
        }
        field(50353; "SSD PO Confirmation"; Boolean)
        {
            Caption = 'PO Confirmation';
            DataClassification = CustomerContent;
        }
        field(50354; "SSD SRN Approver"; Code[50])
        {
            Caption = 'SRN Approver';
            TableRelation = "User Setup"."User ID";
            DataClassification = CustomerContent;

            trigger OnLookup()
            var
                UserSetup: Record "User Setup";
            begin
                UserSetup.SetFilter("User ID", '<>%1', "User ID");
                if Page.RunModal(Page::"Approval User Setup", UserSetup) = Action::LookupOK then Validate("Approver ID", UserSetup."User ID");
            end;
        }
        field(50355; "SSD TC Admin"; Boolean)
        {
            Caption = 'TC Admin';
            DataClassification = CustomerContent;
        }
        field(50356; "SSD Delete Administrator"; Boolean)
        {
            Caption = 'Delete Administrator';
            DataClassification = CustomerContent;
        }
        field(50357; "SSD Incoming Admin"; Boolean)
        {
            Caption = 'Incoming Document Admin';
            DataClassification = CustomerContent;
        }
        field(50358; "SSD Sales Distribution Admin"; Boolean)
        {
            Caption = 'Sales Distribution Admin';
            DataClassification = CustomerContent;
        }
        field(50359; "SSD Insert Allowed Narration"; Boolean)
        {
            Caption = 'Insert Allowed Narration';
            DataClassification = ToBeClassified;
        }
        field(50360; "Approval Required"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
}
