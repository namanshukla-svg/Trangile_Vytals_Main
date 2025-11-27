TableExtension 50088 "SSD Sales Line" extends "Sales Line"
{
    fields
    {
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                SalesHeader: Record "Sales Header";
                Item: Record Item;
                ItemCategory: Record "Item Category";
            begin
                SalesHeader := GetSalesHeader();
                "Document Subtype" := SalesHeader."Document Subtype";
                if Item.Get("No.") then begin
                    //ItemCategory.Reset();
                    //ItemCategory.SetRange(Code, Item."Item Category Code");
                    //if ItemCategory.FindFirst() then begin
                    //if ItemCategory."Parent Category" = 'VCI FILM' then
                    "MOQ Quantity" := Item.MOQ;
                    //end;
                    if "Sell-to Customer No." = 'C0137' then
                        FOC := true
                    else
                        FOC := false;
                end;
            end;
        }
        //SSDU
        modify(Type)
        {
            trigger OnAfterValidate()
            begin
                CheckTypeofInvoice();
            end;
        }
        //SSDU
        modify("Shipment Date")
        {
            trigger OnAfterValidate()
            var
                PlannedShipmentDateCalculated: Boolean;
                PlannedDeliveryDateCalculated: Boolean;
            begin
                IF "Planned Shipment Date" <> 0D THEN BEGIN
                    IF "Shipment Date" < "Planned Shipment Date" THEN "Shipment Date" := "Planned Shipment Date";
                    PlannedShipmentDateCalculated := TRUE;
                END;
                CustomerLocal.RESET;
                IF CustomerLocal.GET("Sell-to Customer No.") THEN
                    IF FORMAT(CustomerLocal."Shipping Time") <> '' THEN BEGIN
                        "Planned Delivery Date" := CALCDATE(CustomerLocal."Shipping Time", "Shipment Date");
                        PlannedDeliveryDateCalculated := TRUE;
                    END;
                IF NOT PlannedShipmentDateCalculated THEN "Planned Shipment Date" := CalcPlannedShptDate(FIELDNO("Shipment Date"));
                IF NOT PlannedDeliveryDateCalculated THEN "Planned Delivery Date" := CalcPlannedDeliveryDate(FIELDNO("Shipment Date"));
                if "Shipment Date" < xRec."Shipment Date" then "Shipment Date" := xRec."Shipment Date";
            end;
        }
        modify("Unit Price")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                if (Rec."Unit Price" <> 0) and (Rec."Unit Price 2" = 0) then
                    Rec."Unit Price 2" := Rec."Unit Price"; //IG_DS
            end;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                TESTFIELD("Short Close", FALSE);
                //SSD Sunil
                SampleDiscount();
                //SSD Sunil
                if Rec."Unit Price" = 0 then  //IG_DS
                    Rec.Validate(Rec."Unit Price", Rec."Unit Price 2");

            end;
        }
        modify("Variant Code")
        {
            trigger OnAfterValidate()
            begin
                SampleDiscount();
            end;
        }
        modify("Outstanding Quantity")
        {
            trigger OnAfterValidate()
            begin
                IF xRec."Outstanding Quantity" <> Rec."Outstanding Quantity" THEN crmupdateflag := TRUE;
            end;
        }
        modify("Qty. to Invoice")
        {
            trigger OnAfterValidate()
            begin
                TESTFIELD("Short Close", FALSE);
            end;
        }
        modify("Quantity Shipped")
        {
            trigger OnAfterValidate()
            begin
                IF xRec."Outstanding Quantity" <> Rec."Outstanding Quantity" THEN crmupdateflag := TRUE;
            end;
        }
        modify("Quantity Invoiced")
        {
            trigger OnAfterValidate()
            begin
                IF xRec."Outstanding Quantity" <> Rec."Outstanding Quantity" THEN crmupdateflag := TRUE;
            end;
        }
        modify("Planned Delivery Date")
        {
            trigger OnBeforeValidate()
            begin
                IF CurrFieldNo = FIELDNO("Planned Delivery Date") THEN IF "Planned Delivery Date" <> 0D THEN IF "Planned Delivery Date" < "Shipment Date" THEN ERROR('Planned Delivery Date cannot be less than Shipment Date');
                IF FORMAT("Shipping Time") <> '' THEN
                    VALIDATE("Planned Shipment Date", CalcPlannedDeliveryDate(FIELDNO("Planned Delivery Date")))
                ELSE
                    VALIDATE("Planned Shipment Date", CalcPlannedShptDate(FIELDNO("Planned Delivery Date")));
            end;
        }
        modify("Planned Shipment Date")
        {
            trigger OnBeforeValidate()
            var
                ItemTabl: Record Item;
                NoOfDays: Integer;
                Basedate: Date;
                BaseCalander: Record "Base Calendar";
                I: Integer;
                NoOfNonWorkingDays: Integer;
                CalendarMgmt: Codeunit "Calendar Management";
                desc: Text[250];
            begin
                IF ItemTabl.GET("No.") THEN ItemTabl.TESTFIELD("Lead Time Dispatch");
                //"Planned Shipment Date" := CALCDATE(ItemTabl."Lead Time Dispatch","Planned Shipment Date");
                //<<<ALLE[551]
                // NoOfDays := 0;
                // Basedate := "Planned Shipment Date";
                // BaseCalander.RESET;
                // IF BaseCalander.FINDFIRST THEN;
                // IF EVALUATE(NoOfDays, DELCHR(FORMAT(ItemTabl."Lead Time Dispatch"), '=', 'D')) THEN;
                //FOR I:=1 TO NoOfDays DO BEGIN
                // I := 0;
                // NoOfNonWorkingDays := NoOfDays;
                //ERROR('...%1...',NoOfNonWorkingDays);  //1114
                //"Planned Shipment Date":=CALCDATE(FORMAT(NoOfNonWorkingDays)+'D',Basedate);
                //<<<NEW
                // "Planned Shipment Date" := "Planned Shipment Date" + NoOfNonWorkingDays;
                // "Shipment Date" := "Shipment Date" + NoOfNonWorkingDays;
                "Planned Shipment Date" := CalcDate(ItemTabl."Lead Time Dispatch", "Planned Shipment Date");
                "Shipment Date" := CalcDate(ItemTabl."Lead Time Dispatch", "Shipment Date");
                IF xRec."No." = "No." THEN IF xRec."Planned Shipment Date" <> 0D THEN "Planned Shipment Date" := xRec."Planned Shipment Date";
            end;
        }
        field(50003; "Enquiry No."; Code[20])
        {
            Description = 'CF002';
            DataClassification = CustomerContent;
            Caption = 'Enquiry No.';
        }
        field(50004; "Enquiry Line No."; Integer)
        {
            Description = 'CF002';
            DataClassification = CustomerContent;
            Caption = 'Enquiry Line No.';
        }
        field(50005; crminsertflag; Boolean)
        {
            Description = 'TRI';
            DataClassification = CustomerContent;
            Caption = 'crminsertflag';
        }
        field(50006; crmupdateflag; Boolean)
        {
            Description = 'TRI';
            DataClassification = CustomerContent;
            Caption = 'crmupdateflag';
        }
        field(50007; isCRMexception; Boolean)
        {
            Description = 'TRI';
            DataClassification = CustomerContent;
            Caption = 'isCRMexception';
        }
        field(50008; exceptiondetail; Text[200])
        {
            Description = 'TRI';
            DataClassification = CustomerContent;
            Caption = 'exceptiondetail';
        }
        field(50009; "Unit Price Dup."; Decimal)
        {
            //IG_DS_Before DecimalPlaces = 4 : 4;
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 2;
            Description = 'Alle';
            DataClassification = CustomerContent;
            Caption = 'Unit Price Dup.';
        }
        field(50012; Month; Date)
        {
            Description = 'Alle_240119';
            DataClassification = CustomerContent;
            Caption = 'Month';
        }
        field(50013; Ismrpupdated; Boolean)
        {
            Description = 'Alle_240119';
            DataClassification = CustomerContent;
            Caption = 'Ismrpupdated';
        }
        field(50014; Ismrpexception; Boolean)
        {
            Description = 'Alle_240119';
            DataClassification = CustomerContent;
            Caption = 'Ismrpexception';
        }
        field(50015; MrpExceptiondetails; Code[10])
        {
            Description = 'Alle_240119';
            DataClassification = CustomerContent;
            Caption = 'MrpExceptiondetails';
        }
        field(50016; "Forecast Name"; Code[30])
        {
            Description = 'Alle_240119';
            DataClassification = CustomerContent;
            Caption = 'Forecast Name';
        }
        field(50017; "SP Order No."; Code[30])
        {
            Description = 'Alle_240119';
            DataClassification = CustomerContent;
            Caption = 'SP Order No.';
        }
        field(50018; "Suggested Quantity"; Decimal)
        {
            Description = 'Alle_240119';
            DataClassification = CustomerContent;
            Caption = 'Suggested Quantity';
        }
        field(50019; "Required Receipt Date"; Date)
        {
            Description = 'Alle_240119';
            DataClassification = CustomerContent;
            Caption = 'Required Receipt Date';
        }
        field(50020; "Suggested Receipt Date"; Date)
        {
            Description = 'Alle_240119';
            DataClassification = CustomerContent;
            Caption = 'Suggested Receipt Date';
        }
        field(50021; "SP Price"; Decimal)
        {
            Description = 'Alle_240119';
            DataClassification = CustomerContent;
            Caption = 'SP Price';
        }
        field(50022; Stock; Decimal)
        {
            Description = 'Alle_240119';
            DataClassification = CustomerContent;
            Caption = 'Stock';
        }
        field(50023; "MRP No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'MRP No.';
        }
        field(50030; "Revised Shipment Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Revised Shipment Date';
        }
        field(50067; "Change After Archieve"; Boolean)
        {
            Description = 'CF003 TRUE -> change after Archieve FALSE -> initial and after Archive';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Change After Archieve';
        }
        field(50081; "Unit Price (Revalued)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price (Revalued)';
            Description = 'CF001.05';
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //CF001.05 St
                TestField("Document Subtype", "document subtype"::"Suplementary Invoice");
                if "Document Subtype" = "document subtype"::"Suplementary Invoice" then begin
                    Validate("Unit Price", ("Unit Price (Revalued)" - "Unit Price (Actual)"));
                end;
                //CF001.05 En
            end;
        }
        field(50083; "Unit Price (Actual)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price (Actual)';
            Description = 'CF001.05';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //CF001.05 St
                TestField("Document Subtype", "document subtype"::"Suplementary Invoice");
                if "Document Subtype" = "document subtype"::"Suplementary Invoice" then begin
                    Validate("Unit Price", ("Unit Price (Revalued)" - "Unit Price (Actual)"));
                end;
                //CF001.05 En
            end;
        }
        field(50084; "Old Document No."; Code[20])
        {
            Description = 'CF001.05 -> Sales Invoice Doc No from where suple. Invoice is copied';
            Editable = false;
            TableRelation = if ("Document Subtype" = const("Suplementary Invoice")) "Sales Invoice Line"."Document No.";
            DataClassification = CustomerContent;
            Caption = 'Old Document No.';
        }
        field(50085; "Old Document Line No."; Integer)
        {
            Description = 'CF001.05 -> Sales Invoice Line No from where suple. Invoice is copied';
            Editable = false;
            TableRelation = if ("Document Subtype" = const("Suplementary Invoice")) "Sales Invoice Line"."Line No." where("Document No." = field("Old Document No."));
            DataClassification = CustomerContent;
            Caption = 'Old Document Line No.';
        }
        field(50086; "Price Match/Mismatch"; Boolean)
        {
            Description = 'Alle';
            DataClassification = CustomerContent;
            Caption = 'Price Match/Mismatch';
        }
        field(50087; "Sales Line No."; Code[30])
        {
            Description = 'ALLE-NM';
            DataClassification = CustomerContent;
            Caption = 'Sales Line No.';
        }
        field(50088; "SP Remarks"; Text[80])
        {
            Description = 'ALLE-NM';
            DataClassification = CustomerContent;
            Caption = 'SP Remarks';
        }
        field(50089; "Internal Remarks"; Text[80])
        {
            Description = 'ALLE-NM';
            DataClassification = CustomerContent;
            Caption = 'Internal Remarks';
        }
        field(50090; "Short Close DateTime"; DateTime)
        {
            Description = 'ALLE-NM 15072019';
            DataClassification = CustomerContent;
            Caption = 'Short Close DateTime';
        }
        field(50091; "Released DateTime"; DateTime)
        {
            Description = 'ALLE-NM 15072019';
            DataClassification = CustomerContent;
            Caption = 'Released DateTime';
        }
        field(50092; "Mail Send for Short Close"; Boolean)
        {
            Description = 'ALLE-NM 19082019';
            DataClassification = CustomerContent;
            Caption = 'Mail Send for Short Close';
        }
        field(50100; "Manual Excise"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Manual Excise';
        }
        field(52006; "Document Subtype"; Option)
        {
            Description = 'CF001,CF001.05';
            OptionCaption = ' ,Sales,Contract,Service Contract,Order,Schedule,Invoice,Despatch,Suplementary Invoice';
            OptionMembers = " ",Sales,Contract,"Service Contract","Order",Schedule,Invoice,Despatch,"Suplementary Invoice";
            DataClassification = CustomerContent;
            Caption = 'Document Subtype';
        }
        field(53011; "Order No."; Code[20])
        {
            Description = 'CF002';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Order No.';
        }
        field(53012; "Order Line No."; Integer)
        {
            Description = 'CF002';
            DataClassification = CustomerContent;
            Caption = 'Order Line No.';
        }
        field(54005; "Gate Entry no."; Code[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Gate Entry no.';
        }
        field(54006; "Gate Entry Date"; Date)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Gate Entry Date';
        }
        field(54007; "Gate Line No."; Integer)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Gate Line No.';
        }
        field(54010; "Total Posted Gate Challan Qty"; Decimal)
        {
            CalcFormula = sum("SSD Posted Gate Line"."Challan Quantity" where("Party Type" = const(Customer), "Party No." = field("Sell-to Customer No."), "Ref. Document Type" = const("Sales Returns"), "Ref. Document No." = field("Document No."), Type = field(Type), "No." = field("No."), "Ref. Document Line No." = field("Line No.")));
            Description = 'CF001';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Total Posted Gate Challan Qty';
        }
        field(54017; "Total Gate Challan Qty"; Decimal)
        {
            CalcFormula = sum("SSD Gate Line"."Challan Quantity" where("Party Type" = const(Customer), "Party No." = field("Sell-to Customer No."), "Ref. Document Type" = const("Sales Returns"), "Ref. Document No." = field("Document No."), Type = field(Type), "No." = field("No."), "Ref. Document Line No." = field("Line No.")));
            Description = 'CF003';
            Editable = true;
            FieldClass = FlowField;
            Caption = 'Total Gate Challan Qty';
        }
        field(54050; "Budgeted Cost Amount"; Decimal)
        {
            Description = 'ALLE-BUDG';
            DataClassification = CustomerContent;
            Caption = 'Budgeted Cost Amount';

            trigger OnValidate()
            begin
                //Difference := ("Budgeted Cost Amount" - "Unit Cost (LCY)") * Quantity;//Alle_190417
            end;
        }
        field(54060; "Schedule Quantity"; Decimal)
        {
            CalcFormula = sum("SSD Sales Schedule Buffer"."Schedule Quantity" where("Document Type" = field("Document Type"), "Document No." = field("Document No."), "Sell-to Customer No." = field("Sell-to Customer No."), "Item No." = field("No."), "Order Line No." = field("Line No.")));
            Description = 'CF001 For Sch Qty During  Blanket Order';
            FieldClass = FlowField;
            Caption = 'Schedule Quantity';

            trigger OnLookup()
            var
                SalesScheduleBufferLocal: Record "SSD Sales Schedule Buffer";
            begin
                //CF001 St
                /*IF Type=Type::Item THEN
                      BEGIN
                        SalesScheduleBufferLocal.RESET;
                        SalesScheduleBufferLocal.SETRANGE("Document Type","Document Type");
                        SalesScheduleBufferLocal.SETRANGE("Document No.","Document No.");
                        SalesScheduleBufferLocal.SETRANGE("Sell-to Customer No.","Sell-to Customer No.");
                        SalesScheduleBufferLocal.SETRANGE("Item No.","No.");
                        SalesScheduleBufferLocal.SETRANGE("Order Line No.","Line No.");
                        SalesScheduleBufferLocal.SETFILTER("Schedule Quantity",'<>0',0);

                        CLEAR(BlanketScheduleBufferForm);
                        BlanketScheduleBufferForm.SETRECORD(SalesScheduleBufferLocal);
                        BlanketScheduleBufferForm.SETTABLEVIEW(SalesScheduleBufferLocal);
                        BlanketScheduleBufferForm.LOOKUPMODE:=TRUE;
                        BlanketScheduleBufferForm.EDITABLE:=FALSE;
                        BlanketScheduleBufferForm.RUNMODAL;
                      END;
                    */
                //CF001 En
            end;
        }
        field(54061; "No of Pack"; Decimal)
        {
            CalcFormula = sum("SSD Sales Schedule Buffer"."No. of Box" where("Document Type" = field("Document Type"), "Document No." = field("Document No."), "Sell-to Customer No." = field("Sell-to Customer No."), "Item No." = field("No."), "Order Line No." = field("Line No.")));
            Description = 'CF002 For No of Packet';
            FieldClass = FlowField;
            Caption = 'No of Pack';

            trigger OnLookup()
            var
                SalesScheduleBufferLocal: Record "SSD Sales Schedule Buffer";
                SalesPacketDetailsForm: Page "Sales Packet Details";
            begin
                //CF002 St
                if Type = Type::Item then begin
                    SalesScheduleBufferLocal.Reset;
                    SalesScheduleBufferLocal.SetRange("Document Type", "Document Type");
                    SalesScheduleBufferLocal.SetRange("Document No.", "Document No.");
                    SalesScheduleBufferLocal.SetRange("Sell-to Customer No.", "Sell-to Customer No.");
                    SalesScheduleBufferLocal.SetRange("Item No.", "No.");
                    SalesScheduleBufferLocal.SetRange("Order Line No.", "Line No.");
                    SalesScheduleBufferLocal.SetFilter("No. of Box", '<>0', 0);
                    Clear(SalesPacketDetailsForm);
                    SalesPacketDetailsForm.SetRecord(SalesScheduleBufferLocal);
                    SalesPacketDetailsForm.SetTableview(SalesScheduleBufferLocal);
                    SalesPacketDetailsForm.LookupMode := true;
                    SalesPacketDetailsForm.Editable := false;
                    SalesPacketDetailsForm.RunModal;
                end;
                //CF002 En
            end;
        }
        field(54062; "Qty Per Pack"; Decimal)
        {
            Description = 'CF001-Item Qty per packet';
            DataClassification = CustomerContent;
            Caption = 'Qty Per Pack';
        }
        field(54063; "Total Schedule Quantity"; Decimal)
        {
            Description = 'CF001 Total Schedule Quantity during Despatch';
            DataClassification = CustomerContent;
            Caption = 'Total Schedule Quantity';

            trigger OnValidate()
            begin
                Validate(Quantity, "Total Schedule Quantity"); //5.51
            end;
        }
        field(54064; "Despatch Slip No."; Code[20])
        {
            Description = 'CF002';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Despatch Slip No.';
        }
        field(54065; "Despatch Slip Line No."; Integer)
        {
            Description = 'CF002';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Despatch Slip Line No.';
        }
        field(54066; "Quatation No."; Code[20])
        {
            Description = 'CF002';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Quatation No.';
        }
        field(54067; "Quotation Line No."; Integer)
        {
            Description = 'CF002';
            DataClassification = CustomerContent;
            Caption = 'Quotation Line No.';
        }
        field(54068; "Quotation Date"; Date)
        {
            Description = 'CF002';
            DataClassification = CustomerContent;
            Caption = 'Quotation Date';
        }
        field(54069; "Customer Document No."; Code[20])
        {
            CalcFormula = lookup("Sales Header"."External Document No." where("Document Type" = const(Order), "No." = field("Order No."), "Sell-to Customer No." = field("Sell-to Customer No.")));
            Caption = 'Customer Document No.';
            Description = 'CF002 -> Flow from Orginal Order External Doc No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(54070; "Customer Document Date"; Date)
        {
            CalcFormula = lookup("Sales Header"."External Doc. Date" where("Document Type" = const(Order), "No." = field("Order No."), "Sell-to Customer No." = field("Sell-to Customer No.")));
            Description = 'CF002 -> Flow from Orginal Order External Doc Date';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Customer Document Date';
        }
        field(54071; "Cross-Reference Desc."; Text[100]) //IG_DS Text[50])
        {
            //IG_DS lookup comment due to avoid yellow warning
            // CalcFormula = lookup("Item Cross Reference".Description where("Item No." = field("No."), "Cross-Reference Type" = const(Customer), "Cross-Reference Type No." = field("Sell-to Customer No."), "Cross-Reference No." = field("Item Reference No.")));
            CalcFormula = lookup("Item Reference".Description where("Item No." = field("No.")));
            Caption = 'Cross-Reference Description';
            Description = 'CF001.04 -> Flow from Orginal Item Cross Reff. No';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60009; "Applied Trading Entry No."; Integer)
        {
            Description = 'CE_AA003';
            DataClassification = CustomerContent;
            Caption = 'Applied Trading Entry No.';
        }
        field(60044; "Supplementary Rate"; Decimal)
        {
            Description = 'ALLE_AA';
            DataClassification = CustomerContent;
            Caption = 'Supplementary Rate';
        }
        field(60045; "Supplementary Item"; Code[20])
        {
            Description = 'ALLE_AA';
            TableRelation = Item;
            DataClassification = CustomerContent;
            Caption = 'Supplementary Item';
        }
        field(60046; "Supplementary Start Date"; Date)
        {
            Description = 'ALLE_AA';
            DataClassification = CustomerContent;
            Caption = 'Supplementary Start Date';
        }
        field(60047; "Supplementary End Date"; Date)
        {
            Description = 'ALLE_AA';
            DataClassification = CustomerContent;
            Caption = 'Supplementary End Date';
        }
        field(60048; "Last Updated Cost"; Decimal)
        {
            Description = 'ALLE_AA';
            DataClassification = CustomerContent;
            Caption = 'Last Updated Cost';
        }
        field(60049; "Effective Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Effective Date';

            trigger OnValidate()
            begin
                //>> BS20122016
                if "Document Type" = "document type"::Order then CheckSPDate("Effective Date", "Document Type", "Document No.");
                //<< BS20122016
            end;
        }
        field(60050; "Expiry Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Expiry Date';
        }
        field(70000; "Schedule Month"; Option)
        {
            OptionCaption = ', ,JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC';
            OptionMembers = ," ",JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC;
            DataClassification = CustomerContent;
            Caption = 'Schedule Month';
        }
        field(70001; "Drawing No."; Code[50])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Drawing No.';
        }
        field(70002; "MOQ/MBQ/MDQ"; Code[50])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'MOQ/MBQ/MDQ';
        }
        field(70003; "Terms (Ex-Choupanki)"; Text[50])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Terms (Ex-Choupanki)';
        }
        field(70004; "Revised Date"; Date)
        {
            Description = 'Kapil added as per Mr. Mukesh';
            DataClassification = CustomerContent;
            Caption = 'Revised Date';
        }
        field(70005; "Target Price"; Decimal)
        {
            Description = 'Kapil added as per Mr. Mukesh';
            DataClassification = CustomerContent;
            Caption = 'Target Price';
        }
        field(70006; "Lead Time"; DateFormula)
        {
            Description = 'Kapil added as per Mr. Mukesh';
            DataClassification = CustomerContent;
            Caption = 'Lead Time';
        }
        field(70007; "No.2"; Code[20])
        {
            CalcFormula = lookup(Item."No. 2" where("No." = field("No.")));
            FieldClass = FlowField;
            Caption = 'No.2';
        }
        field(70008; "Ammortization Amount"; Decimal)
        {
            Description = 'Ashok Sachdeva for Prinitng in the sales invoice 09/03/07';
            FieldClass = Normal;
            MinValue = 0;
            DataClassification = CustomerContent;
            Caption = 'Ammortization Amount';
        }
        field(70009; "FOC Value"; Decimal)
        {
            Description = 'Ashok Sachdeva for Prinitng in the sales invoice 09/03/07';
            MinValue = 0;
            DataClassification = CustomerContent;
            Caption = 'FOC Value';
        }
        field(70010; "Despatch Time"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Despatch Time';
        }
        field(70011; "Invoice Created"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Created';
        }
        field(70012; Inactive; Boolean)
        {
            Description = 'For Uploading Enagare';
            DataClassification = CustomerContent;
            Caption = 'Inactive';
        }
        field(70013; "Part No."; Code[20])
        {
            Description = 'ssd';
            DataClassification = CustomerContent;
            Caption = 'Part No.';
        }
        field(75000; "Short Close"; Boolean)
        {
            Description = 'ALLE 3.29';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Short Close';

            trigger OnValidate()
            begin
                // <<<< Alle 18062020
                if xRec."Short Close" <> Rec."Short Close" then crmupdateflag := true;
                // >>>> Alle 18062020
            end;
        }
        field(75001; "Short Close Qty."; Decimal)
        {
            Description = 'Alle VPB';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Short Close Qty.';
        }
        field(85002; "Excise Bus Posting Group(ARE)"; Code[10])
        {
            Description = 'ALLE 3.14';
            DataClassification = CustomerContent;
            Caption = 'Excise Bus Posting Group(ARE)';
        }
        field(85003; "Excise Amount(ARE)"; Decimal)
        {
            Description = 'ALLE 3.14';
            DataClassification = CustomerContent;
            Caption = 'Excise Amount(ARE)';
        }
        field(85004; "BED Amount(ARE)"; Decimal)
        {
            Description = 'ALLE 3.14';
            DataClassification = CustomerContent;
            Caption = 'BED Amount(ARE)';
        }
        field(85005; "AED(GSI) Amount(ARE)"; Decimal)
        {
            Description = 'ALLE 3.14';
            DataClassification = CustomerContent;
            Caption = 'AED(GSI) Amount(ARE)';
        }
        field(85006; "AED(TTA) Amount(ARE)"; Decimal)
        {
            Description = 'ALLE 3.14';
            DataClassification = CustomerContent;
            Caption = 'AED(TTA) Amount(ARE)';
        }
        field(85007; "SED Amount(ARE)"; Decimal)
        {
            Description = 'ALLE 3.14';
            DataClassification = CustomerContent;
            Caption = 'SED Amount(ARE)';
        }
        field(85008; "SAED Amount(ARE)"; Decimal)
        {
            Description = 'ALLE 3.14';
            DataClassification = CustomerContent;
            Caption = 'SAED Amount(ARE)';
        }
        field(85009; "Cess Amount(ARE)"; Decimal)
        {
            Description = 'ALLE 3.14';
            DataClassification = CustomerContent;
            Caption = 'Cess Amount(ARE)';
        }
        field(85010; "NCCD Amount(ARE)"; Decimal)
        {
            Description = 'ALLE 3.14';
            DataClassification = CustomerContent;
            Caption = 'NCCD Amount(ARE)';
        }
        field(85011; "eCess Amount(ARE)"; Decimal)
        {
            Description = 'ALLE 3.14';
            DataClassification = CustomerContent;
            Caption = 'eCess Amount(ARE)';
        }
        field(85012; "ADET Amount(ARE)"; Decimal)
        {
            Description = 'ALLE 3.14';
            DataClassification = CustomerContent;
            Caption = 'ADET Amount(ARE)';
        }
        field(85013; "ADE Amount(ARE)"; Decimal)
        {
            Description = 'ALLE 3.14';
            DataClassification = CustomerContent;
            Caption = 'ADE Amount(ARE)';
        }
        field(85014; "SHE Cess Amount(ARE)"; Decimal)
        {
            Description = 'ALLE 3.14';
            DataClassification = CustomerContent;
            Caption = 'SHE Cess Amount(ARE)';
        }
        field(85015; "Custom eCess Amount(ARE)"; Decimal)
        {
            Description = 'ALLE 3.14';
            DataClassification = CustomerContent;
            Caption = 'Custom eCess Amount(ARE)';
        }
        field(85016; "Custom SHECess Amount(ARE)"; Decimal)
        {
            Description = 'ALLE 3.14';
            DataClassification = CustomerContent;
            Caption = 'Custom SHECess Amount(ARE)';
        }
        field(85017; "ADC VAT Amount(ARE)"; Decimal)
        {
            Description = 'ALLE 3.14';
            DataClassification = CustomerContent;
            Caption = 'ADC VAT Amount(ARE)';
        }
        field(85018; "Excise Effective Rate(ARE)"; Decimal)
        {
            Description = 'ALLE 3.14';
            DataClassification = CustomerContent;
            Caption = 'Excise Effective Rate(ARE)';
        }
        field(85019; "Amount Including Excise(ARE)"; Decimal)
        {
            Description = 'ALLE 3.14';
            DataClassification = CustomerContent;
            Caption = 'Amount Including Excise(ARE)';
        }
        field(85020; "CT2 Form"; Code[20])
        {
            Description = 'ALLE 3.15';
            DataClassification = CustomerContent;
            Caption = 'CT2 Form';
        }
        field(85021; "CT2 Form Line No."; Integer)
        {
            Description = 'ALLE 3.15';
            DataClassification = CustomerContent;
            Caption = 'CT2 Form Line No.';
        }
        field(85022; "CT3 Form"; Code[20])
        {
            Description = 'ALLE 3.16';
            DataClassification = CustomerContent;
            Caption = 'CT3 Form';
        }
        field(85023; "CT3 Form Line No."; Integer)
        {
            Description = 'ALLE 3.16';
            DataClassification = CustomerContent;
            Caption = 'CT3 Form Line No.';
        }
        field(85024; "Actual Wt"; Decimal)
        {
            CalcFormula = sum("SSD Sales Schedule Buffer"."Actual Weight" where("Document Type" = field("Document Type"), "Document No." = field("Document No."), "Sell-to Customer No." = field("Sell-to Customer No."), "Item No." = field("No."), "Order Line No." = field("Line No.")));
            Description = 'ALLE 3.08';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Actual Wt';

            trigger OnLookup()
            var
                SalesScheduleBufferLocal: Record "SSD Sales Schedule Buffer";
                SalesPacketDetailsForm: Page "Sales Packet Details";
            begin
                //ALLE 3.08
                if Type = Type::Item then begin
                    SalesScheduleBufferLocal.Reset;
                    SalesScheduleBufferLocal.SetRange("Document Type", "Document Type");
                    SalesScheduleBufferLocal.SetRange("Document No.", "Document No.");
                    SalesScheduleBufferLocal.SetRange("Sell-to Customer No.", "Sell-to Customer No.");
                    SalesScheduleBufferLocal.SetRange("Item No.", "No.");
                    SalesScheduleBufferLocal.SetRange("Order Line No.", "Line No.");
                    SalesScheduleBufferLocal.SetFilter("No. of Box", '<>0', 0);
                    Clear(SalesPacketDetailsForm);
                    SalesPacketDetailsForm.SetRecord(SalesScheduleBufferLocal);
                    SalesPacketDetailsForm.SetTableview(SalesScheduleBufferLocal);
                    SalesPacketDetailsForm.LookupMode := true;
                    SalesPacketDetailsForm.Editable := false;
                    SalesPacketDetailsForm.RunModal;
                end;
                //ALLE 3.08
            end;
        }
        field(85025; "Gross Wt"; Decimal)
        {
            CalcFormula = sum("SSD Sales Schedule Buffer"."Gross Weight" where("Document Type" = field("Document Type"), "Document No." = field("Document No."), "Sell-to Customer No." = field("Sell-to Customer No."), "Item No." = field("No."), "Order Line No." = field("Line No.")));
            Description = 'Alle VPB';
            FieldClass = FlowField;
            Caption = 'Gross Wt';
        }
        field(85026; "Qty Invoiced"; Decimal)
        {
            CalcFormula = sum("Sales Invoice Line".Quantity where("Order No." = field("Document No."), "Order Line No." = field("Line No.")));
            Description = 'temporary';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Qty Invoiced';
        }
        field(85027; "Credit Note Unit Price"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Note Unit Price';
        }
        field(85029; MRNLINENO; Integer)
        {
            Description = 'ALLE[5.51]';
            DataClassification = CustomerContent;
            Caption = 'MRNLINENO';
        }
        field(85030; MRNNO; Code[20])
        {
            Description = 'ALLE[5.51]';
            DataClassification = CustomerContent;
            Caption = 'MRNNO';
        }
        field(85031; "Comments CC"; Text[250])
        {
            CalcFormula = lookup("SSD SalesDashBoardCommentLine".Comment where("Document Type" = field("Document Type"), "No." = field("Document No."), "Document Line No." = field("Line No."), Code = filter('CC')));
            Description = 'ALLE[5.51]';
            FieldClass = FlowField;
            Caption = 'Comments CC';
        }
        field(85032; "Comments SCM"; Text[250])
        {
            CalcFormula = lookup("SSD SalesDashBoardCommentLine".Comment where("Document Type" = field("Document Type"), "No." = field("Document No."), "Document Line No." = field("Line No."), Code = const('SCM')));
            Description = 'ALLE[5.51]';
            FieldClass = FlowField;
            Caption = 'Comments SCM';
        }
        field(85033; "Comments PPC"; Text[250])
        {
            CalcFormula = lookup("SSD SalesDashBoardCommentLine".Comment where("Document Type" = field("Document Type"), "No." = field("Document No."), "Document Line No." = field("Line No."), Code = const('PPC')));
            Description = 'ALLE[5.51]';
            FieldClass = FlowField;
            Caption = 'Comments PPC';
        }
        field(85034; "Comments Management"; Text[250])
        {
            CalcFormula = lookup("SSD SalesDashBoardCommentLine".Comment where("Document Type" = field("Document Type"), "No." = field("Document No."), "Document Line No." = field("Line No."), Code = const('MGMT')));
            Description = 'ALLE[5.51]';
            FieldClass = FlowField;
            Caption = 'Comments Management';
        }
        field(85035; Open; Boolean)
        {
            CalcFormula = exist("Sales Header" where("No." = field("Document No."), Status = const(Open)));
            Description = 'ALLE[5.51]';
            FieldClass = FlowField;
            Caption = 'Open';
        }
        field(85036; "Sales Area"; Boolean)
        {
            CalcFormula = exist("Document Entry" where("Table ID" = const(37), "Document Type" = const(Order)));
            Description = 'ALLE[5.51]';
            FieldClass = FlowField;
            Caption = 'Sales Area';
        }
        field(85037; Remarks; Text[100])
        {
            Description = 'Alle[Z]-Field required by SB';
            DataClassification = CustomerContent;
            Caption = 'Remarks';
        }
        field(85038; "PMM Remarks"; Option)
        {
            Description = 'ALLE';
            OptionCaption = ' ,D,ND-S,ND-PPC,ND-F,SD Late / Late scheduled';
            OptionMembers = " ",D,"ND-S","ND-PPC","ND-F","SD Late / Late scheduled";
            DataClassification = CustomerContent;
            Caption = 'PMM Remarks';
        }
        field(85039; "Dispatch Date Time"; DateTime)
        {
            Description = 'ALLE-NM 29112019';
            DataClassification = CustomerContent;
            Caption = 'Dispatch Date Time';
        }
        field(85040; "Amazon SKU"; Code[10])
        {
            Description = 'Alle-[Amazon-HG]';
            DataClassification = CustomerContent;
            Caption = 'Amazon SKU';
        }
        field(85041; "Amazon Ship Promo Discount"; Decimal)
        {
            Description = 'Alle-[Amazon-HG]';
            DataClassification = CustomerContent;
            Caption = 'Amazon Ship Promo Discount';
        }
        field(85043; "Amazon Shipping Price"; Decimal)
        {
            Description = 'Alle-[Amazon-HG]';
            DataClassification = CustomerContent;
            Caption = 'Amazon Shipping Price';
        }
        field(85044; "Amazon Invoice/Credit Memo"; Boolean)
        {
            Description = 'Alle-[Amazon-HG]';
            DataClassification = CustomerContent;
            Caption = 'Amazon Invoice/Credit Memo';
        }
        field(85045; "MOQ Quantity"; Decimal)
        {
            Description = 'Alle-[Amazon-HG]';
            DataClassification = CustomerContent;
            Caption = 'MOQ Quantity';
            Editable = false;
        }
        field(85046; "Unit Price 2"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        //IG_DS
        field(85047; "Hold-Dispatch"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(85048; "Inventory Available"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(85049; "Output Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(85050; "SalesPerson Code"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."Salesperson Code" where("Document Type" = field("Document Type"), "No." = field("Document No.")));
        }
        field(85051; "Order Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."Order Date" where("Document Type" = field("Document Type"), "No." = field("Document No.")));
        }
        //IG_DS
    }
    trigger OnDelete()
    begin
        SalesPacketBufferLocal.RESET;
        SalesPacketBufferLocal.SETRANGE("Document Type", "Document Type");
        SalesPacketBufferLocal.SETRANGE("Document No.", "Document No.");
        SalesPacketBufferLocal.SETRANGE("Sell-to Customer No.", "Sell-to Customer No.");
        SalesPacketBufferLocal.SETRANGE("Item No.", "No.");
        SalesPacketBufferLocal.SETRANGE("Order Line No.", "Line No.");
        IF SalesPacketBufferLocal.FINDFIRST THEN SalesPacketBufferLocal.DELETEALL;
    end;

    trigger OnAfterInsert()
    begin
        "Change After Archieve" := TRUE;
        IF RecSalesheader.GET("Document Type", "Document No.") THEN BEGIN
            "Effective Date" := RecSalesheader."Effective Date";
            "Expiry Date" := RecSalesheader."Expiry Date";
        END;
    end;

    procedure InsertInvLineFromDespLine(var SalesLine: Record "Sales Line")
    var
        SalesInvHeader: Record "Sales Header";
        SalesOrderHeader: Record "Sales Header";
        SalesOrderLine: Record "Sales Line";
        Currency: Record Currency;
        TempSalesLine: Record "Sales Line" temporary;
        TransferOldExtLines: Codeunit "Transfer Old Ext. Text Lines";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        ExtTextLine: Boolean;
        NextLineNo: Integer;
        SalesHeaderLocal: Record "Sales Header";
        SalesPacketBufferLocal: Record "SSD Sales Schedule Buffer";
        SalesPacketBuffer: Record "SSD Sales Schedule Buffer";
        RecSalesHeader: Record "Sales Header";
        RecSalesLine: Record "Sales Line";
        RecLoaction: Record Location;
        FirstLine: Boolean;
        ReservationEntry1: Record "Reservation Entry";
        ReservationEntry2: Record "Reservation Entry";
        ReservationEntry3: Record "Reservation Entry";
        Text038: Label 'You cannot change %1 when %2 is %3 and %4 is negative.';
    begin
        //CF002 St
        SetRange("Document Type", "Document Type");
        SetRange("Document No.", "Document No.");
        SetFilter("Qty. to Ship", '<>%1', 0); //MSI
        TempSalesLine := SalesLine;
        if SalesLine.Find('+') then
            NextLineNo := SalesLine."Line No." + 10000
        else
            NextLineNo := 10000;
        if SalesInvHeader."No." <> TempSalesLine."Document No." then SalesInvHeader.Get(TempSalesLine."Document Type", TempSalesLine."Document No.");
        if SalesLine."Despatch Slip No." <> "Document No." then begin
            SalesLine.Init;
            SalesLine."Line No." := NextLineNo;
            SalesLine."Document Type" := TempSalesLine."Document Type";
            SalesLine."Document No." := TempSalesLine."Document No.";
            //SalesLine.Description := STRSUBSTNO(TEXT037,"Document No."); //CMLTEST-026 AA 180108
            SalesLine.Description := StrSubstNo(TEXT50000, "Document No."); //CMLTEST-026 AA 180108
            SalesLine.Insert;
            NextLineNo := NextLineNo + 10000;
        end;
        TransferOldExtLines.ClearLineNumbers;
        repeat
            ExtTextLine := (TransferOldExtLines.GetNewLineNumber("Attached to Line No.") <> 0);
            SalesOrderLine.Reset;
            SalesOrderLine.SetRange("Document Type", SalesOrderLine."document type"::Order);
            SalesOrderLine.SetRange("Document No.", "Order No.");
            SalesOrderLine.SetRange("Line No.", "Order Line No."); //Alle VPB
            SalesOrderLine.SetRange(Type, Type);
            SalesOrderLine.SetRange("No.", "No.");
            if SalesOrderLine.FindSet then
                repeat
                    if (SalesOrderHeader."Document Type" <> SalesOrderLine."document type"::Order) or (SalesOrderHeader."No." <> SalesOrderLine."Document No.") then SalesOrderHeader.Get(SalesOrderLine."document type"::Order, "Order No.");
                    if SalesInvHeader."Prices Including VAT" <> SalesOrderHeader."Prices Including VAT" then
                        if "Currency Code" <> '' then
                            Currency.Get("Currency Code")
                        else
                            Currency.InitRoundingPrecision;
                    if SalesInvHeader."Prices Including VAT" then begin
                        if not SalesOrderHeader."Prices Including VAT" then SalesOrderLine."Unit Price" := ROUND(SalesOrderLine."Unit Price" * (1 + SalesOrderLine."VAT %" / 100), Currency."Unit-Amount Rounding Precision");
                    end
                    else begin
                        if SalesOrderHeader."Prices Including VAT" then SalesOrderLine."Unit Price" := ROUND(SalesOrderLine."Unit Price" / (1 + SalesOrderLine."VAT %" / 100), Currency."Unit-Amount Rounding Precision");
                    end;
                until SalesOrderLine.Next = 0
            else begin
                SalesOrderHeader.Init;
                if ExtTextLine then begin
                    SalesOrderLine.Init;
                    SalesOrderLine."Line No." := "Order Line No.";
                    SalesOrderLine.Description := Description;
                    SalesOrderLine."Description 2" := "Description 2";
                end
                else
                    Error(Text038);
            end;
            SalesLine := Rec;
            SalesLine."Line No." := NextLineNo;
            SalesLine."Document Type" := TempSalesLine."Document Type";
            SalesLine."Document No." := TempSalesLine."Document No.";
            SalesLine."Variant Code" := "Variant Code";
            SalesLine."Location Code" := "Location Code";
            //SalesLine."Outstanding Qty. (Base)" := 0;
            //SalesLine."Outstanding Quantity" := 0;
            SalesLine."Quantity Shipped" := 0;
            SalesLine."Qty. Shipped (Base)" := 0;
            SalesLine."Quantity Invoiced" := 0;
            SalesLine."Qty. Invoiced (Base)" := 0;
            SalesLine."Purchase Order No." := '';
            SalesLine."Purch. Order Line No." := 0;
            SalesLine."Drop Shipment" := "Drop Shipment";
            SalesLine."Special Order Purchase No." := '';
            SalesLine."Special Order Purch. Line No." := 0;
            SalesLine."Special Order" := false;
            SalesLine."Despatch Slip No." := "Document No.";
            SalesLine."Despatch Slip Line No." := "Line No.";
            //ALLE 3.08
            CalcFields("Actual Wt");
            SalesLine."Actual Wt" := "Actual Wt";
            //ALLE 3.08
            SalesLine."Order No." := "Order No.";
            SalesLine."Order Line No." := "Order Line No.";
            SalesHeaderLocal.Get(SalesLine."Document Type", SalesLine."Document No.");
            SalesLine."Document Subtype" := SalesHeaderLocal."Document Subtype";
            SalesLine."Blanket Order No." := "Blanket Order No.";
            SalesLine."Blanket Order Line No." := "Blanket Order Line No.";
            SalesLine."Planned Delivery Date" := "Planned Shipment Date";
            SalesLine."Planned Shipment Date" := "Planned Shipment Date";
            SalesLine."Quatation No." := "Quatation No.";
            SalesLine."Quotation Line No." := "Quotation Line No.";
            SalesLine."Quotation Date" := "Quotation Date";
            SalesLine."Last Updated Cost" := "Last Updated Cost"; //Alle_AA
            SalesLine."Sales Line No." := "Sales Line No."; //ALLE-NM 05072019
            SalesLine."MRP No." := "MRP No."; //ALLE-NM 05072019
            if not ExtTextLine then begin
                SalesLine.Validate(Quantity, Quantity - "Quantity Invoiced");
                SalesLine."Quantity Shipped" := SalesLine."Qty. Shipped Not Invoiced";
                SalesLine."Qty. Shipped (Base)" := SalesLine."Qty. Shipped Not Invd. (Base)";
                SalesLine.Validate("Unit Price", SalesOrderLine."Unit Price");
                SalesLine."Allow Line Disc." := SalesOrderLine."Allow Line Disc.";
                SalesLine."Allow Invoice Disc." := SalesOrderLine."Allow Invoice Disc.";
                SalesLine.Validate("Line Discount %", SalesOrderLine."Line Discount %");
            end;
            SalesLine."Attached to Line No." := TransferOldExtLines.TransferExtendedText(SalesOrderLine."Line No.", NextLineNo, SalesOrderLine."Attached to Line No.");
            SalesLine."Shortcut Dimension 1 Code" := SalesOrderLine."Shortcut Dimension 1 Code";
            SalesLine."Shortcut Dimension 2 Code" := SalesOrderLine."Shortcut Dimension 2 Code";
            SalesLine."Dimension Set ID" := SalesOrderLine."Dimension Set ID"; //ALLE NK
            SalesLine."Total Schedule Quantity" := SalesLine.Quantity;
            SalesLine.Insert;
            ReservationEntry1.Reset;
            ReservationEntry1.SetRange(ReservationEntry1."Source ID", "Document No.");
            ReservationEntry1.SetRange(ReservationEntry1."Item No.", "No.");
            if ReservationEntry1.FindFirst then
                repeat begin
                    ReservationEntry2.Init;
                    ReservationEntry2.Copy(ReservationEntry1);
                    ReservationEntry3.Reset;
                    if ReservationEntry3.FindLast then ReservationEntry2."Entry No." := ReservationEntry3."Entry No." + 1;
                    ReservationEntry2."Source ID" := SalesLine."Document No.";
                    ReservationEntry2."Source Ref. No." := SalesLine."Line No.";
                    ReservationEntry2."Source Subtype" := 2;
                    ReservationEntry2."Reservation Status" := ReservationEntry2."reservation status"::Prospect; //ALLE-NM 29082019
                    ReservationEntry2.Insert;
                    Commit;
                end;
                until ReservationEntry1.Next = 0;
            //>>>> ALLE[5.51]
            ////**** Insert of Packet Information ***********////
            if SalesLine.Type = SalesLine.Type::Item then begin
                SalesPacketBufferLocal.Reset;
                SalesPacketBufferLocal.SetRange("Document Type", "Document Type");
                SalesPacketBufferLocal.SetRange("Document No.", "Document No.");
                SalesPacketBufferLocal.SetRange("Sell-to Customer No.", "Sell-to Customer No.");
                SalesPacketBufferLocal.SetRange("Item No.", "No.");
                SalesPacketBufferLocal.SetRange("Order Line No.", "Line No.");
                if SalesPacketBufferLocal.FindSet then
                    repeat
                        SalesPacketBuffer.Init;
                        SalesPacketBuffer := SalesPacketBufferLocal;
                        SalesPacketBuffer."Document Type" := SalesLine."Document Type";
                        SalesPacketBuffer."Document No." := SalesLine."Document No.";
                        SalesPacketBuffer."Order Line No." := SalesLine."Line No.";
                        SalesPacketBuffer.Insert;
                    until SalesPacketBufferLocal.Next = 0;
            end;
            ///*************************************************
            ItemTrackingMgt.CopyHandledItemTrkgToInvLine(Rec, SalesLine);
            /*//bis 1145
            FromDocDim.SETRANGE("Table ID",DATABASE::"Sales Line");
            FromDocDim.SETRANGE("Document Type","Document Type"::Order);
            FromDocDim.SETRANGE("Document No.","Document No.");
            FromDocDim.SETRANGE("Line No.","Line No.");

            ToDocDim.SETRANGE("Table ID",DATABASE::"Sales Line");
            ToDocDim.SETRANGE("Document Type",SalesLine."Document Type");
            ToDocDim.SETRANGE("Document No.",SalesLine."Document No.");
            ToDocDim.SETRANGE("Line No.", SalesLine."Line No.");
            ToDocDim.DELETEALL;

            IF FromDocDim.FINDSET THEN
              REPEAT
                TempFromDocDim.INIT;
                TempFromDocDim := FromDocDim;
                TempFromDocDim."Table ID" := DATABASE::"Sales Line";
                TempFromDocDim."Document Type" := SalesLine."Document Type";
                TempFromDocDim."Document No." := SalesLine."Document No.";
                TempFromDocDim."Line No." := SalesLine."Line No.";
                TempFromDocDim.INSERT;
              UNTIL FromDocDim.NEXT = 0;
            */
            //bis 1145
            NextLineNo := NextLineNo + 10000;
            if "Attached to Line No." = 0 then SetRange("Attached to Line No.", "Line No.");
        until (Next = 0) or ("Attached to Line No." = 0);
        //CMLTEST-026 AA 100208 Start
        /*
            ////For Invoice ///////
            IF SalesOrderHeader.GET(SalesOrderHeader."Document Type"::Invoice,SalesLine."Document No.") THEN
              BEGIN
                SalesOrderHeader."Get Despatch Used" := TRUE;
                SalesOrderHeader."Order/Scd. No.":="Order No.";
                SalesOrderHeader.MODIFY;
              END;

            ////For Despatch Order ///////
            IF SalesOrderHeader.GET(SalesOrderHeader."Document Type"::Order,"No.") THEN
              BEGIN
                SalesOrderHeader."Get Despatch Used" := TRUE;
                SalesOrderHeader.MODIFY;
              END;

            ////For Ref Doc Order ///////
            IF SalesOrderHeader.GET(SalesOrderHeader."Document Type"::Order,"Order No.") THEN
              BEGIN
                SalesOrderHeader."Get Despatch Used" := TRUE;
                SalesOrderHeader.MODIFY;
              END;
            //CF002 En
            */
        //CMLTEST-026 AA 100208 Finish
    end;

    procedure TestThirdPartyCode()
    begin
        //ALLE 3.08 >>
        if userSet.Get(UserId) then begin
            if RespCent.Get(userSet."Responsibility Center") then RespCent.TestField(RespCent."Third Party Code");
        end;
    end;

    procedure ShowLineCommentsCC()
    var
        SalesCommentLine: Record "SSD SalesDashBoardCommentLine";
        SalesCommentSheet: Page "Sales Dashboard Comment Sheet";
    begin
        //<<<<ALLE[551]
        TestField("Document No.");
        TestField("Line No.");
        SalesCommentLine.SetRange("Document Type", "Document Type");
        SalesCommentLine.SetRange("No.", "Document No.");
        SalesCommentLine.SetRange("Document Line No.", "Line No.");
        SalesCommentLine.SetFilter(SalesCommentLine.Code, '%1', 'CC');
        SalesCommentSheet.SetTableview(SalesCommentLine);
        SalesCommentSheet.CommentsDept('CC');
        SalesCommentSheet.RunModal;
        //<<<<ALLE[551]
    end;

    procedure ShowLineCommentsSCM()
    var
        SalesCommentLine: Record "SSD SalesDashBoardCommentLine";
        SalesCommentSheet: Page "Sales Dashboard Comment Sheet";
    begin
        //<<<<ALLE[551]
        TestField("Document No.");
        TestField("Line No.");
        SalesCommentLine.SetRange("Document Type", "Document Type");
        SalesCommentLine.SetRange("No.", "Document No.");
        SalesCommentLine.SetRange("Document Line No.", "Line No.");
        SalesCommentLine.SetFilter(SalesCommentLine.Code, '%1', 'SCM');
        SalesCommentSheet.SetTableview(SalesCommentLine);
        SalesCommentSheet.CommentsDept('SCM');
        SalesCommentSheet.RunModal;
        //>>>>ALLE[551]
    end;

    procedure ShowLineCommentsPPC()
    var
        SalesCommentLine: Record "SSD SalesDashBoardCommentLine";
        SalesCommentSheet: Page "Sales Dashboard Comment Sheet";
    begin
        //<<<<ALLE[551]
        TestField("Document No.");
        TestField("Line No.");
        SalesCommentLine.SetRange("Document Type", "Document Type");
        SalesCommentLine.SetRange("No.", "Document No.");
        SalesCommentLine.SetRange("Document Line No.", "Line No.");
        SalesCommentLine.SetFilter(SalesCommentLine.Code, '%1', 'PPC');
        SalesCommentSheet.SetTableview(SalesCommentLine);
        SalesCommentSheet.CommentsDept('PPC');
        SalesCommentSheet.RunModal;
        //<<<<ALLE[551]
    end;

    procedure ShowLineCommentsMGMT()
    var
        SalesCommentLine: Record "SSD SalesDashBoardCommentLine";
        SalesCommentSheet: Page "Sales Dashboard Comment Sheet";
    begin
        //<<<<ALLE[551]
        TestField("Document No.");
        TestField("Line No.");
        SalesCommentLine.SetRange("Document Type", "Document Type");
        SalesCommentLine.SetRange("No.", "Document No.");
        SalesCommentLine.SetRange("Document Line No.", "Line No.");
        SalesCommentLine.SetFilter(SalesCommentLine.Code, '%1', 'MGMT');
        SalesCommentSheet.SetTableview(SalesCommentLine);
        SalesCommentSheet.CommentsDept('MGMT');
        SalesCommentSheet.RunModal;
        //<<<<ALLE[551]
    end;

    procedure CheckSPDate(SPDate: Date; DocType: Option; DocNo: Code[20])
    var
        SalesHeader: Record "Sales Header";
        SAMPPosition: Integer;
    begin
        // BS20122016 New function added to identify  SPD/Sample Order.
        if SalesHeader.Get(DocType, DocNo) then begin
            if SPDate <> 0D then begin
                SalesHeader."SPD/Sample Order" := true;
                SalesHeader.Modify;
            end;
            if SPDate = 0D then begin
                SAMPPosition := StrPos(DocNo, 'SAMP');
                if SAMPPosition = 0 then SalesHeader."SPD/Sample Order" := false;
                if SAMPPosition > 0 then SalesHeader."SPD/Sample Order" := true;
                SalesHeader.Modify;
            end;
        end;
    end;

    var
        CustomerLocal: Record Customer;
        RecSalesheader: Record "Sales Header";
        SalesPacketBufferLocal: Record "SSD Sales Schedule Buffer";
        TEXT50000: label 'Despatch No. %1.';
        userSet: Record "User Setup";
        RespCent: Record "Responsibility Center";
    //SSDU
    procedure CheckTypeofInvoice()
    var
        SalesHeader: Record "Sales Header";
        NormalInv: Label 'You can select only Item and Fixed Asset on type field in sales line.';
        SuppleError: Label 'You can select only Charge (item) on type field in sales line.';
        CommercialError: Label 'You can select only G/L Account on type field in sales line.';
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SetRange("System-Created Entry", false);
        IF SalesLine.get("Document Type", "Document No.", "Line No.") then begin
            if SalesHeader.get("Document Type", "Document No.") then
                if (SalesHeader."Type of Invoice" = SalesHeader."Type of Invoice"::Normal) then begin
                    if SalesHeader."Currency Code" = '' then begin
                        if Type in [Type::"Charge (Item)", Type::Resource] then //Add GL
                            Error(NormalInv);
                    end
                    else begin
                        if Type in [Type::"Charge (Item)", Type::Resource] then Error(NormalInv);
                    end;
                end
                else if (SalesHeader."Type of Invoice" = SalesHeader."Type of Invoice"::Supplementary) then begin
                    if Type in [Type::"Fixed Asset", Type::"G/L Account", Type::Item, Type::Resource] then Error(SuppleError);
                end
                else if (SalesHeader."Type of Invoice" = SalesHeader."Type of Invoice"::Commercial) then begin
                    if Type in [Type::"Charge (Item)", Type::"Fixed Asset", Type::Item, Type::Resource] then Error(CommercialError);
                end;
        end;
    end;
    //SSDU
    procedure SampleDiscount()
    begin
        if ("Document Type" = "Document Type"::Order) or ("Document Type" = "Document Type"::Invoice) then begin
            if "Gen. Bus. Posting Group" = 'SAMPLE' then "Line Discount %" := 100; //IG_DS_Before
                                                                                   // if "Gen. Bus. Posting Group" = 'SAMPLE' then Rec.Validate(FOC);
        end;
    end;
}
