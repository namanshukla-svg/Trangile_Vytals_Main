TableExtension 50099 "SSD Transfer Header" extends "Transfer Header"
{
    fields
    {
        field(50050; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Description = 'CF001';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
        }
        field(50052; "Inventory P Group"; Code[10])
        {
            Description = 'TableRelation="Inventory Posting Group"';
            DataClassification = CustomerContent;
            Caption = 'Inventory P Group';
        }
        field(50053; "Subcontracting Transfer Order"; Boolean)
        {
            Description = 'ALLEAA CML-033 230408';
            DataClassification = CustomerContent;
            Caption = 'Subcontracting Transfer Order';
        }
        field(50054; "Shipment Posted"; Boolean)
        {
            Description = 'ALLEAA CML-033 250408';
            DataClassification = CustomerContent;
            Caption = 'Shipment Posted';
        }
        field(50055; "Applied to Insurance Policy"; Code[30])
        {
            Description = 'ALLE-NM 01112019';
            DataClassification = CustomerContent;
            Caption = 'Applied to Insurance Policy';

            trigger OnLookup()
            begin
                //ALLE-NM 01112019
                InsuranceRec.Reset;
                InsuranceRec.SetCurrentkey("Policy Status", "Insurance Starting Date", "Insurance Expiry Date");
                InsuranceRec.SetRange("Policy Status", InsuranceRec."policy status"::Active);
                InsuranceRec.SetFilter(InsuranceRec."Insurance Starting Date", '<=%1', "Posting Date");
                InsuranceRec.SetFilter(InsuranceRec."Insurance Expiry Date", '>=%1', "Posting Date");
                if InsuranceRec.FindFirst then begin
                    if Page.RunModal(Page::"SSD Insurance Card Form", InsuranceRec, InsuranceRec."Insurance Policy No.") = Action::LookupOK then Validate("Applied to Insurance Policy", InsuranceRec."Insurance Policy No.");
                end;
            //ALLE-NM 01112019
            end;
        }
        field(54040; "Order Created from MRP"; Boolean)
        {
            Description = 'ALLE';
            DataClassification = CustomerContent;
            Caption = 'Order Created from MRP';
        }
        field(65000; "Slip No."; Code[20])
        {
            Description = 'ALLE3.26';
            DataClassification = CustomerContent;
            Caption = 'Slip No.';
        }
        field(65001; "Document Type"; Option)
        {
            Description = 'ALLE3.26';
            OptionCaption = ' ,Material Issue,Material Return,Line Rejection,Floor Rejection,Offer,ReOffer';
            OptionMembers = " ", "Material Issue", "Material Return", "Line Rejection", "Floor Rejection", Offer, ReOffer;
            DataClassification = CustomerContent;
            Caption = 'Document Type';
        }
        field(65006; Departments; Option)
        {
            Description = 'ALLE3.26';
            OptionCaption = ' ,PPC,AWP,WIP,Conveyor,ED,Store';
            OptionMembers = " ", PPC, AWP, WIP, Conveyor, ED, Store;
            DataClassification = CustomerContent;
            Caption = 'Departments';
        }
        field(65007; "Prod. Order Source No."; Code[20])
        {
            Description = 'ALLE3.26';
            DataClassification = CustomerContent;
            Caption = 'Prod. Order Source No.';
        }
        field(65008; "Prod. Order Source Description"; Text[50])
        {
            Description = 'ALLE3.26';
            DataClassification = CustomerContent;
            Caption = 'Prod. Order Source Description';
        }
        field(65009; "Prod. Order No."; Code[20])
        {
            Description = 'ALLE3.26';
            DataClassification = CustomerContent;
            Caption = 'Prod. Order No.';
        }
        field(65070; "Gate In"; Code[20])
        {
            Description = 'ALLE GI 291015';
            TableRelation = "SSD Posted Gate Header"."No." where("Ref. Document No."=field("No."));
            DataClassification = CustomerContent;
            Caption = 'Gate In';

            trigger OnValidate()
            var
                TransferLine: Record "Transfer Line";
                PostedGateLine: Record "SSD Posted Gate Line";
            begin
                //ALLE-SS Start
                TransferLine.SetRange("Document Type", "Document Type");
                TransferLine.SetRange("Document No.", "No.");
                if TransferLine.Find('-')then repeat PostedGateLine.SetFilter("Ref. Document Type", '%1', PostedGateLine."ref. document type"::"Transfer Order");
                        PostedGateLine.SetRange("Ref. Document No.", TransferLine."Document No.");
                        PostedGateLine.SetRange("Line No.", TransferLine."Line No.");
                        if PostedGateLine.FindFirst then begin
                            TransferLine.Validate(TransferLine."Qty. to Receive", PostedGateLine."Challan Quantity");
                            TransferLine.Modify;
                        end;
                    until TransferLine.Next = 0;
            //ALLE-SS End
            end;
        }
    }
    var UserMgt: Codeunit "SSD User Setup Management";
    ResponsibilityCenter: Record "Responsibility Center";
    InsuranceRec: Record "SSD Insurance Setup";
}
