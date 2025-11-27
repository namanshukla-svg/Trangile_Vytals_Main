TableExtension 50008 "SSD Delivery Challan Header" extends "Delivery Challan Header"
{
    fields
    {
        //Unsupported feature: Property Modification (Data type) on ""Debit Note No."(Field 15)".
        field(50100; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
            //UpdateSalesLines(FIELDCAPTION("Transport Method"),FALSE);
            end;
        }
        field(50101; "Shipping Agent Code"; Code[10])
        {
            AccessByPermission = TableData "Shipping Agent Services"=R;
            Caption = 'Shipping Agent Code';
            Description = 'Alle-[E-Way API]';
            TableRelation = "Shipping Agent";
            DataClassification = CustomerContent;
        }
        field(50102; "LR/RR No."; Code[20])
        {
            Caption = 'LR/RR No.';
            DataClassification = CustomerContent;
        }
        field(50103; "LR/RR Date"; Date)
        {
            Caption = 'LR/RR Date';
            DataClassification = CustomerContent;
        }
        field(50001; DateOfIssue; Date)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'DateOfIssue';
        }
        field(50002; TimeOfIssue; Time)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'TimeOfIssue';
        }
        field(50003; DateOfRemoval; Date)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'DateOfRemoval';
        }
        field(50004; TimeOfRemoval; Time)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'TimeOfRemoval';
        }
        field(50005; "Old Delivery Challan No"; Code[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Old Delivery Challan No';
        }
        field(50050; "Responsibility Center"; Code[20])
        {
            Description = 'CF001';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center';
        }
        field(50051; "Estimated Value"; Decimal)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Estimated Value';
        }
        field(50052; "Expected Duration"; Text[30])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Expected Duration';
        }
        field(50053; "Plant Sl No."; Code[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Plant Sl No.';
        }
        field(50054; "Nature of Process"; Option)
        {
            Description = 'CF001';
            OptionMembers = Jobwork, "Decoiling & Cutting", Sharing;
            DataClassification = CustomerContent;
            Caption = 'Nature of Process';
        }
        field(55000; "Gate Out Date"; Date)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Gate Out Date';
        }
        field(55001; "Gate Out Time"; Time)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Gate Out Time';
        }
        field(55002; "Gate Out Remarks"; Text[200])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Gate Out Remarks';
        }
        field(55003; "Gate Out User ID"; Code[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Gate Out User ID';
        }
        field(55004; "Gate Out No."; Code[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Gate Out No.';
        }
        field(55005; "Gate Out Posted"; Boolean)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Gate Out Posted';
        }
        field(55006; "Identification Marks or No."; Text[60])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Identification Marks or No.';
        }
        field(55007; "Expected Date of receipt"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Expected Date of receipt';
        }
        field(55008; "Vendor Name"; Text[100])
        {
            CalcFormula = lookup(Vendor.Name where("No."=field("Vendor No.")));
            Description = 'CGN005';
            FieldClass = FlowField;
            Caption = 'Vendor Name';
        }
        field(55009; "Vehical No."; Text[50])
        {
            Description = 'CEN004.06';
            DataClassification = CustomerContent;
            Caption = 'Vehical No.';
        }
        field(55010; "Expected Receipt Days"; DateFormula)
        {
            Description = 'CEN004.06';
            DataClassification = CustomerContent;
            Caption = 'Expected Receipt Days';
        }
        field(55011; "Gross Weight"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Gross Weight';
        }
        field(55012; Packing; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Packing';
        }
        field(55013; "Net Weight"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Net Weight';
        }
        field(55014; "Duty Debited"; Boolean)
        {
            Description = 'CML-009';
            DataClassification = CustomerContent;
            Caption = 'Duty Debited';
        }
        field(55015; "Gate Pass"; Boolean)
        {
            CalcFormula = exist("SSD Gate Pass Line" where("Invoice No."=field("No.")));
            Description = 'ALLE-GP001';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Gate Pass';
        }
        field(55016; "E-Way Bill No."; Text[30])
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'E-Way Bill No.';
        }
        field(55017; "E-Way Bill Date"; Text[30])
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'E-Way Bill Date';
        }
        field(55018; "E-Way Bill Validity"; Text[30])
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'E-Way Bill Validity';
        }
        field(55019; "E-Way-to generate"; Boolean)
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'E-Way-to generate';
        }
        field(55020; "E-Way Generated"; Boolean)
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'E-Way Generated';
        }
        field(55021; "E-Way Canceled"; Boolean)
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'E-Way Canceled';
        }
        field(55022; "Transportation Distance"; Integer)
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'Transportation Distance';
        }
        field(70000; "Responsible Employee"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code"=filter('EMPLOYEE'));
            DataClassification = CustomerContent;
            Caption = 'Responsible Employee';
        }
    }
    trigger OnBeforeInsert()
    var
    //SSD UserSetupManagement: Codeunit "User Setup Management";
    begin
    //SSD "Responsibility Center" := UserSetupManagement.GetPurchasesFilter;
    end;
}
