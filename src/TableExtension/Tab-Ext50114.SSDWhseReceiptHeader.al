TableExtension 50114 "SSD Whse Receipt Header" extends "Warehouse Receipt Header"
{
    fields
    {
        field(50001; IsMRN; Boolean)
        {
            Description = 'CF001.01';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'IsMRN';
        }
        field(50002; "Gate Entry no."; Code[20])
        {
            Description = 'CF001.01';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Gate Entry no.';
        }
        field(50003; "Gate Entry Date"; Date)
        {
            Description = 'CF001.01';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Gate Entry Date';
        }
        field(50004; Subcontracting; Boolean)
        {
            Description = 'CF001.02';
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'Subcontracting';
        }
        field(50005; "Quality Required"; Boolean)
        {
            CalcFormula = exist("Warehouse Receipt Line" where("No."=field("No."), "Quality Required"=filter(true)));
            Description = 'QLT -> Coming from Item card';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Quality Required';
        }
        field(50006; "QC Report Received"; Boolean)
        {
            Description = 'Alle VPB as per Manish Request Informative field only';
            DataClassification = CustomerContent;
            Caption = 'QC Report Received';
        }
        field(50007; "Transporter Copy Received"; Boolean)
        {
            Description = 'Alle VPB as per Manish Request Informative field only';
            DataClassification = CustomerContent;
            Caption = 'Transporter Copy Received';
        }
        field(50008; "Work Order No1"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Work Order No1';
        }
        field(50009; "Work Order No2"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Work Order No2';
        }
        field(50010; "Work Order No5"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Work Order No5';
        }
        field(50011; "Work Order No6"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Work Order No6';
        }
        field(50012; "Work Order No4"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Work Order No4';
        }
        field(50013; "Work Order No3"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Work Order No3';
        }
        field(50014; "Send For Quality"; Boolean)
        {
            CalcFormula = exist("Warehouse Receipt Line" where("No."=field("No."), "Quality Required"=filter(true), "Send For Quality"=filter(true)));
            Description = 'QLT -> After Creation of Quality Order From MRN';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Send For Quality';
        }
        field(50050; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Description = 'CF001.01';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
        }
        field(50051; "Party name"; Text[100])
        {
            CalcFormula = lookup("SSD Posted Gate Header".Name where("No."=field("Gate Entry no.")));
            Description = 'CGN 005';
            FieldClass = FlowField;
            Caption = 'Party name';
        }
        field(50052; Blocked; Boolean)
        {
            Description = 'CEN001';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Blocked';
        }
        field(50053; "Bill No."; Code[20])
        {
            CalcFormula = lookup("SSD Posted Gate Header"."Bill No." where("No."=field("Gate Entry no.")));
            Description = 'Cgn005';
            FieldClass = FlowField;
            Caption = 'Bill No.';
        }
        field(50054; "Subcontracting Transfer Order"; Boolean)
        {
            Description = 'ALLEAA CML-033 300408';
            DataClassification = CustomerContent;
            Caption = 'Subcontracting Transfer Order';
        }
        field(50055; "Bill Amount"; Decimal)
        {
            CalcFormula = lookup("SSD Posted Gate Header"."Bill Amount" where("No."=field("Gate Entry no.")));
            Description = 'CGN 005';
            FieldClass = FlowField;
            Caption = 'Bill Amount';
        }
        field(50056; "Supplier Batch No."; Code[20])
        {
            Description = 'ALLE-NM';
            DataClassification = CustomerContent;
            Caption = 'Supplier Batch No.';
        }
        field(50090; "Charge Item 1"; Option)
        {
            Caption = '''''';
            Description = 'ALLE-AT';
            OptionCaption = ' ,Shipping Line,Freight Forwarder,CHA,Local Logistic,Others,Transportation Charges';
            OptionMembers = " ", "Shipping Line", "Freight Forwarder", CHA, "Local Logistic", Others, "Transportation Charges";
            DataClassification = CustomerContent;
        }
        field(50091; "Charge Item 2"; Option)
        {
            Description = 'ALLE-AT';
            OptionCaption = ' ,Shipping Line,Freight Forwarder,CHA,Local Logistic,Others,Transportation Charges';
            OptionMembers = " ", "Shipping Line", "Freight Forwarder", CHA, "Local Logistic", Others, "Transportation Charges";
            DataClassification = CustomerContent;
            Caption = 'Charge Item 2';
        }
        field(50092; "Charge Item 3"; Option)
        {
            Description = 'ALLE-AT';
            OptionCaption = ' ,Shipping Line,Freight Forwarder,CHA,Local Logistic,Others,Transportation Charges';
            OptionMembers = " ", "Shipping Line", "Freight Forwarder", CHA, "Local Logistic", Others, "Transportation Charges";
            DataClassification = CustomerContent;
            Caption = 'Charge Item 3';
        }
        field(50093; "Charge Item 4"; Option)
        {
            Description = 'ALLE-AT';
            OptionCaption = ' ,Shipping Line,Freight Forwarder,CHA,Local Logistic,Others,Transportation Charges';
            OptionMembers = " ", "Shipping Line", "Freight Forwarder", CHA, "Local Logistic", Others, "Transportation Charges";
            DataClassification = CustomerContent;
            Caption = 'Charge Item 4';
        }
        field(50094; "Charge Item 5"; Option)
        {
            Description = 'ALLE-AT';
            OptionCaption = ' ,Shipping Line,Freight Forwarder,CHA,Local Logistic,Others,Transportation Charges';
            OptionMembers = " ", "Shipping Line", "Freight Forwarder", CHA, "Local Logistic", Others, "Transportation Charges";
            DataClassification = CustomerContent;
            Caption = 'Charge Item 5';
        }
        field(50095; "Charge Item 6"; Option)
        {
            Description = 'ALLE-AT';
            OptionCaption = ' ,Shipping Line,Freight Forwarder,CHA,Local Logistic,Others,Transportation Charges';
            OptionMembers = " ", "Shipping Line", "Freight Forwarder", CHA, "Local Logistic", Others, "Transportation Charges";
            DataClassification = CustomerContent;
            Caption = 'Charge Item 6';
        }
        field(50096; "Approval Required 1"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Approval Required 1';
        }
        field(50097; "Approval Required 2"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Approval Required 2';
        }
        field(50098; "Approval Required 3"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Approval Required 3';
        }
        field(50099; "Approval Required 4"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Approval Required 4';
        }
        field(50100; "Approval Required 5"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Approval Required 5';
        }
        field(50101; "Approval Required 6"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Approval Required 6';
        }
        field(50102; "No. Series 1"; Code[20])
        {
            Description = 'ALLE-AT';
            TableRelation = "Purchase Header"."No." where(Status=const(Released));
            DataClassification = CustomerContent;
            Caption = 'No. Series 1';
        }
        field(50103; "No. Series 2"; Code[20])
        {
            Description = 'ALLE-AT';
            TableRelation = "Purchase Header"."No." where(Status=const(Released));
            DataClassification = CustomerContent;
            Caption = 'No. Series 2';
        }
        field(50104; "No. Series 3"; Code[20])
        {
            Description = 'ALLE-AT';
            TableRelation = "Purchase Header"."No." where(Status=const(Released));
            DataClassification = CustomerContent;
            Caption = 'No. Series 3';
        }
        field(50105; "No. Series 4"; Code[20])
        {
            Description = 'ALLE-AT';
            TableRelation = "Purchase Header"."No." where(Status=const(Released));
            DataClassification = CustomerContent;
            Caption = 'No. Series 4';
        }
        field(50106; "No. Series 5"; Code[20])
        {
            Description = 'ALLE-AT';
            TableRelation = "Purchase Header"."No." where(Status=const(Released));
            DataClassification = CustomerContent;
            Caption = 'No. Series 5';
        }
        field(50107; "No. Series 6"; Code[20])
        {
            Description = 'ALLE-AT';
            TableRelation = "Purchase Header"."No." where(Status=const(Released));
            DataClassification = CustomerContent;
            Caption = 'No. Series 6';
        }
        field(50108; "Rem. Order Amount1"; Decimal)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Rem. Order Amount1';
        }
        field(50109; "Rem. Order Amount2"; Decimal)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Rem. Order Amount2';
        }
        field(50110; "Rem. Order Amount3"; Decimal)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Rem. Order Amount3';
        }
        field(50111; "Rem. Order Amount4"; Decimal)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Rem. Order Amount4';
        }
        field(50112; "Rem. Order Amount5"; Decimal)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Rem. Order Amount5';
        }
        field(50113; "Rem. Order Amount6"; Decimal)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Rem. Order Amount6';
        }
        field(50114; "Invoice Posted1"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Invoice Posted1';

            trigger OnValidate()
            begin
                CheckRecItemChargeModification() //ALLE-AT
            end;
        }
        field(50115; "Invoice Posted2"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Invoice Posted2';

            trigger OnValidate()
            begin
                CheckRecItemChargeModification() //ALLE-AT
            end;
        }
        field(50116; "Invoice Posted3"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Invoice Posted3';

            trigger OnValidate()
            begin
                CheckRecItemChargeModification() //ALLE-AT
            end;
        }
        field(50117; "Invoice Posted4"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Invoice Posted4';

            trigger OnValidate()
            begin
                CheckRecItemChargeModification() //ALLE-AT
            end;
        }
        field(50118; "Invoice Posted5"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Invoice Posted5';

            trigger OnValidate()
            begin
                CheckRecItemChargeModification() //ALLE-AT
            end;
        }
        field(50119; "Invoice Posted6"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Invoice Posted6';

            trigger OnValidate()
            begin
                CheckRecItemChargeModification() //ALLE-AT
            end;
        }
        field(50120; "Send By Purch1"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Send By Purch1';

            trigger OnValidate()
            begin
            //CheckItemChargeModification() //ALLE-AT
            end;
        }
        field(50121; "Send By Purch2"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Send By Purch2';

            trigger OnValidate()
            begin
            //CheckItemChargeModification() //ALLE-AT
            end;
        }
        field(50122; "Send By Purch3"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Send By Purch3';

            trigger OnValidate()
            begin
            //CheckItemChargeModification() //ALLE-AT
            end;
        }
        field(50123; "Send By Purch4"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Send By Purch4';

            trigger OnValidate()
            begin
            //CheckItemChargeModification() //ALLE-AT
            end;
        }
        field(50124; "Send By Purch5"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Send By Purch5';

            trigger OnValidate()
            begin
            //CheckItemChargeModification() //ALLE-AT
            end;
        }
        field(50125; "Send By Purch6"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Send By Purch6';

            trigger OnValidate()
            begin
            //CheckItemChargeModification() //ALLE-AT
            end;
        }
        field(50126; "Rec. By Fin1"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Rec. By Fin1';

            trigger OnValidate()
            begin
                CheckRecItemChargeModification() //ALLE-AT
            end;
        }
        field(50127; "Rec. By Fin2"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Rec. By Fin2';

            trigger OnValidate()
            begin
                CheckRecItemChargeModification() //ALLE-AT
            end;
        }
        field(50128; "Rec. By Fin3"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Rec. By Fin3';

            trigger OnValidate()
            begin
                CheckRecItemChargeModification() //ALLE-AT
            end;
        }
        field(50129; "Rec. By Fin4"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Rec. By Fin4';

            trigger OnValidate()
            begin
                CheckRecItemChargeModification() //ALLE-AT
            end;
        }
        field(50130; "Rec. By Fin5"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Rec. By Fin5';

            trigger OnValidate()
            begin
                CheckRecItemChargeModification() //ALLE-AT
            end;
        }
        field(50131; "Rec. By Fin6"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Rec. By Fin6';

            trigger OnValidate()
            begin
                CheckRecItemChargeModification() //ALLE-AT
            end;
        }
        field(50132; "Tentative Value1"; Decimal)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Tentative Value1';
        }
        field(50133; "Tentative Value2"; Decimal)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Tentative Value2';
        }
        field(50134; "Tentative Value3"; Decimal)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Tentative Value3';
        }
        field(50135; "Tentative Value4"; Decimal)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Tentative Value4';
        }
        field(50136; "Tentative Value5"; Decimal)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Tentative Value5';
        }
        field(50137; "Tentative Value6"; Decimal)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Tentative Value6';
        }
        field(60003; Trading; Boolean)
        {
            Caption = 'Trading';
            Description = 'CE_AA004';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60004; "Quality Done"; Boolean)
        {
            CalcFormula = exist("Warehouse Receipt Line" where("No."=field("No."), "Quality Required"=filter(true), "Quality Done"=filter(true)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Quality Done';
        }
        field(80001; "Actual Posted Date"; DateTime)
        {
            Description = 'ALLE-HG-16.09.20';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Actual Posted Date';
        }
        field(80003; "Create DateTime"; DateTime)
        {
            Description = 'ALLE-MK-08-10-20';
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'Create DateTime';
        }
        field(80005; "Quality Post date Time"; DateTime)
        {
            Description = 'ALLE-MK-08-10-20';
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'Quality Post date Time';
        }
    }
    keys
    {
        key(Key1; "Gate Entry no.")
        {
        }
    }
    trigger OnAfterInsert()
    begin
    //SSD "Responsibility Center":=UserMgt.GetRespCenterFilter;
    end;
    procedure OpenWhseRcptHeader(var WhseRcptHeader: Record "Warehouse Receipt Header")
    var
        WhseEmployee: Record "Warehouse Employee";
        WmsManagement: Codeunit "WMS Management";
        CurrentLocationCode: Code[10];
    begin
        if UserId <> '' then begin
            WhseEmployee.SetRange("User ID", UserId);
            if not WhseEmployee.Find('-')then Error(Text002, UserId);
            WhseEmployee.SetRange("Location Code", WhseRcptHeader."Location Code");
            if WhseEmployee.Find('-')then CurrentLocationCode:=WhseRcptHeader."Location Code"
            else
                CurrentLocationCode:=WmsManagement.GetDefaultLocation;
            WhseEmployee.SetRange("Location Code");
        end;
    end;
    local procedure CheckRecItemChargeModification()
    var
        RecUser: Record "User Setup";
    begin
        RecUser.Get(UserId);
        RecUser.TestField("Allow to Rec. Item Charge");
    end;
    var ResponsibilityCenter: Record "Responsibility Center";
    UserMgt: Codeunit "SSD User Setup Management";
    Text002: Label 'You must first set up user %1 as a warehouse employee.';
}
