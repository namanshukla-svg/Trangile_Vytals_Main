table 50112 "SSD Requision Slip Header"
{
    // //ALLE-MSI
    LookupPageID = "Requision Slip List Form";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Req. Slip No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Req. Slip No.';
        }
        field(2; "Req. Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Req. Date';
        }
        field(3; "Req. Time"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Req. Time';
        }
        field(4; "Shortcut Dimension 1 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(1));
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 1 Code';
        }
        field(5; "Shortcut Dimension 2 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(2));
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 2 Code';
        }
        field(6; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center';
        }
        field(7; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
        }
        field(8; "Transfer-From Location"; Code[10])
        {
            TableRelation = Location where("Use As In-Transit"=const(false));
            DataClassification = CustomerContent;
            Caption = 'Transfer-From Location';
        }
        field(9; "User ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'User ID';
        }
        field(10; "Document Type"; Option)
        {
            OptionCaption = ' ,Material Issue,Material Return,Line Rejection,Floor Rejection,Offer,ReOffer';
            OptionMembers = " ", "Material Issue", "Material Return", "Line Rejection", "Floor Rejection", Offer, ReOffer;
            DataClassification = CustomerContent;
            Caption = 'Document Type';
        }
        field(11; "Document Sub Type"; Option)
        {
            OptionCaption = ' ,Requisition,Indent,Mannual,Material Offer,PDI';
            OptionMembers = " ", Requisition, Indent, Mannual, "Material Offer", PDI;
            DataClassification = CustomerContent;
            Caption = 'Document Sub Type';
        }
        field(12; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    //SSD NoSeriesMgt.TestManual(GetNoSeriesCode);
                    "No. Series":='';
                end;
            end;
        }
        field(65006; Departments; Option)
        {
            OptionCaption = ' ,PPC,AWP,WIP,Conveyor,ED,Store';
            OptionMembers = " ", PPC, AWP, WIP, Conveyor, ED, Store;
            DataClassification = CustomerContent;
            Caption = 'Departments';
        }
        field(85000; Status; Option)
        {
            OptionMembers = Open, Released;
            DataClassification = CustomerContent;
            Caption = 'Status';
        }
        field(85001; "Transfer-To Location"; Code[10])
        {
            TableRelation = Location where("Use As In-Transit"=const(false));
            DataClassification = CustomerContent;
            Caption = 'Transfer-To Location';
        }
        field(85002; "Prod. Order No."; Code[20])
        {
            TableRelation = "Production Order"."No.";
            DataClassification = CustomerContent;
            Caption = 'Prod. Order No.';
        }
        field(85003; "Source No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Source No.';
        }
        field(85004; "Source Description"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Source Description';
        }
        field(85005; "Manual Requisition"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Manual Requisition';

            trigger OnValidate()
            begin
                ReqSlipLine.Reset;
                ReqSlipLine.SetCurrentkey("Document Type", "Document No.", "Line No.");
                ReqSlipLine.SetRange("Document Type", "Document Type");
                ReqSlipLine.SetRange("Document No.", "No.");
                ReqSlipLine.SetFilter("Item No.", '<>%1', '');
                if ReqSlipLine.FindFirst then Error('Lines already Exist for Requision');
            end;
        }
    }
    keys
    {
        key(Key1; "Document Type", "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
    //ALLE Event start
    // ReqLineRec.RESET;
    // ReqLineRec.SETRANGE(ReqLineRec."Req. Slip Document No.","Req. Slip No.");
    // IF ReqLineRec.FINDFIRST THEN
    // REPEAT
    //  ReqLineRec.DELETE;
    // UNTIL ReqLineRec.NEXT=0;
    //ALLe event end
    end;
    trigger OnInsert()
    begin
        "Req. Date":=WorkDate;
        "Req. Time":=Time;
        if UserSet.Get(UserId)then if RespCent.Get(UserSet."Responsibility Center")then begin
                "Responsibility Center":=UserSet."Responsibility Center";
                "Shortcut Dimension 1 Code":=RespCent."Global Dimension 1 Code";
                "Shortcut Dimension 2 Code":=RespCent."Global Dimension 2 Code";
            end;
        if "No." = '' then begin
        //SSD NoSeriesMgt.InitSeries(GetNoSeriesCode, xRec."No. Series", WorkDate, "No.", "No. Series");
        end;
        "Document Sub Type":="document sub type"::Requisition;
        "Req. Slip No.":="No.";
        "User ID":=UserId;
    end;
    trigger OnRename()
    begin
        Error(TEXT002, TableCaption);
    end;
    var //SSD NoSeriesMgt: Codeunit NoSeriesManagement;
    ResponsibilityCenter: Record "Responsibility Center";
    UserSet: Record "User Setup";
    TEXT002: label ' You cannot rename a %1.';
    ReqLineRec: Record "SSD Requision Slip Line";
    RespCent: Record "Responsibility Center";
    ReqSlipLine: Record "SSD Requision Slip Line";
    procedure AssistEdit(OldReqSlipHeader: Record "SSD Quality Measurements"): Boolean begin
    //SSD Comment Start
    // if NoSeriesMgt.SelectSeries(GetNoSeriesCode, xRec."No. Series", "No. Series") then begin
    //     NoSeriesMgt.SetSeries("No.");
    //     exit(true);
    // end;
    //SSD Comment End
    end;
    local procedure GetNoSeriesCode(): Code[10]begin
        if "Responsibility Center" <> '' then begin
            ResponsibilityCenter.Get("Responsibility Center");
            if "Document Type" = "document type"::"Material Issue" then begin
                ResponsibilityCenter.TestField("Req. Slip No. Series");
                if ResponsibilityCenter."Req. Slip No. Series" <> '' then exit(ResponsibilityCenter."Req. Slip No. Series");
            end
            else if "Document Type" = "document type"::"Material Return" then begin
                    ResponsibilityCenter.TestField("Req. Slip Return No. Series");
                    if ResponsibilityCenter."Req. Slip Return No. Series" <> '' then exit(ResponsibilityCenter."Req. Slip Return No. Series");
                end;
        end;
    end;
}
