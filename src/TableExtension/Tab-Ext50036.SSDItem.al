TableExtension 50036 "SSD Item" extends Item
{
    fields
    {
        modify("Lead Time Calculation")
        {
            trigger OnAfterValidate()
            begin
                EVALUATE(Text1, FORMAT("Lead Time Calculation"));
                Var2 := STRLEN(Text1);
                Var1 := COPYSTR(Text1, Var2, Var2);
                Var3 := COPYSTR(Text1, 1, Var2 - 1);
                EVALUATE(Int1, Var3);
                IF Var1 = 'D' THEN
                    "Tax Size Normal" := Int1 * 1
                ELSE IF Var1 = 'M' THEN
                    "Tax Size Normal" := Int1 * 30
                ELSE IF Var1 = 'Q' THEN
                    "Tax Size Normal" := Int1 * 90
                ELSE
                    "Tax Size Normal" := Int1 * 7;
            end;
        }
        modify(Blocked)
        {
            trigger OnBeforeValidate()
            begin
                IF Blocked = FALSE THEN BEGIN
                    CheckBlockItem;
                    UserSetupL.GET(USERID);
                    IF NOT UserSetupL."Item UnBlock Rights" THEN ERROR('YOU CANNOT BLOCK/UNBLOCK THIS ITEM, KINDLY CONTACT ADMINISTRATOR');
                END;
            end;
        }
        field(50001; "For Tool Room"; Boolean)
        {
            Description = 'CF003 For Tool Item Coming From Item category';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'For Tool Room';

            trigger OnValidate()
            var
                ItemCategoryLocal: Record "Item Category";
            begin
                TestField("Item Category Code");
                ItemCategoryLocal.Get("Item Category Code");
                //TESTFIELD("For Tool Room",ItemCategoryLocal."For Tool Room");
            end;
        }
        field(50002; "Item Specification"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Item Specification';
        }
        field(50003; "Drawing No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Drawing No.';
        }
        field(50004; "Phy. Bin Required"; Boolean)
        {
            Description = '//CORP';
            DataClassification = CustomerContent;
            Caption = 'Phy. Bin Required';

            trigger OnValidate()
            begin
                //Blocked :=TRUE;
            end;
        }
        field(50005; Grade; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Grade';
        }
        field(50006; "Target Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Target Cost';
        }
        field(50007; Finish; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Finish';
        }
        field(50008; Sync; Boolean)
        {
            Description = 'Alle 24032020';
            DataClassification = CustomerContent;
            Caption = 'Sync';
        }
        field(50014; "Reclassif. Code"; Code[20])
        {
            Caption = 'Reclassification Code';
            Description = 'QLT';
            TableRelation = "SSD Items Reclassification"."Reclass. Item No." where("Item No." = field("No."));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                CalcFields("Reclassif. Factor");
            end;
        }
        field(50015; "Reclassif. Factor"; Decimal)
        {
            CalcFormula = lookup("SSD Items Reclassification"."Reclassif. Factor" where("Item No." = field("No."), "Reclass. Item No." = field("Reclassif. Code")));
            Caption = 'Reclassification Factor';
            Description = 'QLT';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50016; "Reprocess Routing No."; Code[20])
        {
            Caption = 'Reprocess Routing No.';
            Description = 'QLT';
            TableRelation = "Routing Header";
            DataClassification = CustomerContent;
        }
        field(50017; "Reprocess BOM No."; Code[20])
        {
            Caption = 'Reprocess BOM No.';
            Description = 'QLT';
            TableRelation = "Production BOM Header";
            DataClassification = CustomerContent;
        }
        field(50018; "Manufac. Quality Qty."; Decimal)
        {
            //SSD Comment Start
            // CalcFormula = sum("Item Ledger Entry"."Remaining Quantity" where("Item No." = field("No."),
            //                                                                   "Variant Code" = field("Variant Filter"),
            //                                                                   "Location Code" = field("Location Filter"),
            //                                                                   "Quality Status" = const(Manufacturing)));
            //SSD Comment End
            Caption = 'Manuf. Quality Quantities';
            Description = 'QLT';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50019; "Purchase Quality Qty."; Decimal)
        {
            //SSD Comment Start
            // CalcFormula = sum("Item Ledger Entry"."Remaining Quantity" where("Item No." = field("No."),
            //                                                                   "Variant Code" = field("Variant Filter"),
            //                                                                   "Location Code" = field("Location Filter"),
            //                                                                   "Quality Status" = const(Purchase)));
            //SSD Comment End
            Caption = 'Purchase Quality Quantities';
            Description = 'QLT';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50020; "Location Quality Qty."; Decimal)
        {
            //SSD Comment Start
            // CalcFormula = sum("Item Ledger Entry"."Remaining Quantity" where("Item No." = field("No."),
            //                                                                   "Variant Code" = field("Variant Filter"),
            //                                                                   "Location Code" = field("Location Filter"),
            //                                                                   "Quality Status" = const("Location Insp.")));
            //SSD Comment End
            Caption = 'Location Quality Quantities';
            Description = 'QLT';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50021; "Scrap Quality Qty."; Decimal)
        {
            //SSD Comment Start
            // CalcFormula = sum("Item Ledger Entry"."Remaining Quantity" where("Item No." = field("No."),
            //                                                                   "Variant Code" = field("Variant Filter"),
            //                                                                   "Location Code" = field("Location Filter"),
            //                                                                   "Quality Status" = const(Scrap)));
            //SSD Comment End
            Caption = 'Scrap Quality Quantities';
            Description = 'QLT';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50022; "Quality Qty."; Decimal)
        {
            //SSD Comment Start
            // CalcFormula = sum("Item Ledger Entry"."Remaining Quantity" where("Item No." = field("No."),
            //                                                                   "Variant Code" = field("Variant Filter"),
            //                                                                   "Location Code" = field("Location Filter"),
            //                                                                   "Quality Status" = filter(<> " ")));
            //SSD Comment End
            Caption = 'Quality Quantity';
            Description = 'QLT';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50023; "Quality Required"; Boolean)
        {
            Description = 'QLT';
            DataClassification = CustomerContent;
            Caption = 'Quality Required';
        }
        field(50024; "BOM Consideration"; Boolean)
        {
            Description = 'ALLE-NM 290519';
            DataClassification = CustomerContent;
            Caption = 'BOM Consideration';
        }
        field(50050; "Responsibility Center"; Code[20])
        {
            Description = 'CF001';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center';
        }
        field(50052; "Sub. Comp. Bin Code"; Code[20])
        {
            Caption = 'Subcon. Company Bin Code>';
            Description = 'CF001 Sub Contractor Company Bin Code';
            TableRelation = Bin.Code where("Location Code" = field("Sub. Comp. Location"));
            DataClassification = CustomerContent;
        }
        field(50053; "Ammortization Amount"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'Added this field for Mould/Die Ammrotization**Vivek**';
            DataClassification = CustomerContent;
            Caption = 'Ammortization Amount';
        }
        field(50054; "FOC Value"; Decimal)
        {
            Description = 'Ashok sachdeva,CEN001';
            DataClassification = CustomerContent;
            Caption = 'FOC Value';
        }
        field(50055; "QR Code"; Blob)
        {
            DataClassification = CustomerContent;
            Caption = 'QR Code';
        }
        field(50056; PICTOGRAMS; Boolean)
        {
            CalcFormula = exist("SSD QR Prining info" where("Item No." = field("No."), "QR Printing Type" = filter(PICTOGRAMS)));
            FieldClass = FlowField;
            Caption = 'PICTOGRAMS';
        }
        field(50057; "PRECAUTIONARY STATEMENTS"; Boolean)
        {
            CalcFormula = exist("SSD QR Prining info" where("Item No." = field("No."), "QR Printing Type" = filter("PRECAUTIONARY STATEMENTS")));
            FieldClass = FlowField;
            Caption = 'PRECAUTIONARY STATEMENTS';
        }
        field(50058; CLASSIFICATIONS; Boolean)
        {
            CalcFormula = exist("SSD QR Prining info" where("Item No." = field("No."), "QR Printing Type" = filter(CLASSIFICATIONS)));
            FieldClass = FlowField;
            Caption = 'CLASSIFICATIONS';
        }
        field(50059; "UN NUMBER"; Text[250])
        {
            CalcFormula = lookup("SSD QR Prining info"."QR Description" where("QR Printing Type" = filter("UN NUMBER"), "Item No." = field("No.")));
            FieldClass = FlowField;
            Caption = 'UN NUMBER';
        }
        field(50060; "PRODUCT TYPE"; Text[250])
        {
            CalcFormula = lookup("SSD QR Prining info"."QR Description" where("QR Printing Type" = filter("PRODUCT TYPE"), "Item No." = field("No.")));
            FieldClass = FlowField;
            Caption = 'PRODUCT TYPE';
        }
        field(50061; crminsertflag; Boolean)
        {
            Description = 'TRI';
            DataClassification = CustomerContent;
            //Atul::01122025
            Caption = 'Insert Status';
            //Atul::01122025
        }
        field(50062; crmupdateflag; Boolean)
        {
            Description = 'TRI';
            DataClassification = CustomerContent;
            //Atul::01122025
            Caption = 'Update Status';
            //Atul::01122025
        }
        field(50063; isCRMexception; Boolean)
        {
            Description = 'TRI';
            DataClassification = CustomerContent;
            //Atul::01122025
            Caption = 'Exception Occurred';
            //Atul::01122025
        }
        field(50064; exceptionDetail; Text[200])
        {
            Description = 'TRI';
            DataClassification = CustomerContent;
            Caption = 'Exception Occurred';
        }
        field(50065; "Temp Product ID"; Text[30])
        {
            Description = 'TRI';
            DataClassification = CustomerContent;
            Caption = 'Temp Product ID';
        }
        field(50066; crmfgproduct; Boolean)
        {
            Description = 'TRI';
            DataClassification = CustomerContent;
            Caption = 'crmfgproduct';
        }
        field(50067; "Lead time in days"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Lead time in days';
        }
        field(50068; "Tax Size Normal"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Tax Size Normal';
        }
        field(50070; "Procurement Category"; Option)
        {
            Description = 'Alle';
            OptionCaption = ' ,Runner,Repeater,Stranger,NPD';
            OptionMembers = " ",Runner,"Repeater",Stranger,NPD;
            DataClassification = CustomerContent;
            Caption = 'Procurement Category';
        }
        field(50071; "Procurement Category 1"; Option)
        {
            Description = 'Alle 271120';
            OptionCaption = ' ,A,B,C';
            OptionMembers = " ",A,B,C;
            DataClassification = CustomerContent;
            Caption = 'Procurement Category 1';
        }
        field(50082; "Inventory Taging Person"; Code[20])
        {
            Description = 'ALLE 1.0';
            TableRelation = "Salesperson/Purchaser".Code;
            DataClassification = CustomerContent;
            Caption = 'Inventory Taging Person';
        }
        field(50083; "Inventory Taging Req."; Boolean)
        {
            Description = 'ALLE 1.0';
            DataClassification = CustomerContent;
            Caption = 'Inventory Taging Req.';
        }
        field(50084; "Purchase Group 1"; Option)
        {
            OptionMembers = " ",PACK,"DRUM & CAN","OTHER CON",MAINTCON,LABCON,"BASE OIL","SPECIALITY CHEM","SPECIALITY CHEM - DOM",SOLVENT,"KRAFT PAPER",DESSICANT,"PE FILM & LAMINATION","HD LAMINATION",AEROSOL,DISINFCTNT,HAKUPUR,HAKUFORM,"NEAT OIL",NIKUTEX,CONTROX,ISOGOL,HC360,FORMING,"SUMP CARE";
            DataClassification = CustomerContent;
            // Atul 01122025 Start
            Caption = 'Purchase Type';
            // Atul 01122025 End

            trigger OnValidate()
            begin
                //Blocked :=TRUE//Alle 07122021
            end;
        }
        field(50085; "Purchase Group 2"; Option)
        {
            OptionMembers = " ",Budgeted,"Non-Budgeted";
            DataClassification = CustomerContent;
            // Atul 01122025 Start
            Caption = 'Budget Status';
            // Atul 01122025 End
            trigger OnValidate()
            var
                ff: page 18605;
            begin
                //Blocked :=TRUE; //Alle 07122021
            end;
        }
        field(50086; "Purchase Group 3"; Option)
        {
            // Atul 01122025 Start
            OptionMembers = " ","No","Yes";
            DataClassification = CustomerContent;
            Caption = 'Part of the BOM';
            // Atul 01122025 End

            trigger OnValidate()
            begin
                //Blocked :=TRUE;  //Alle 07122021
            end;
        }
        field(50178; TotalPurchVolume; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'TotalPurchVolume';
        }
        field(50179; TotalPurchValue; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'TotalPurchValue';
        }
        field(50180; AvgUnitCost13_14; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'AvgUnitCost13_14';
        }
        field(50181; TotalTargetSavings; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'TotalTargetSavings';
        }
        field(54002; "Item Type"; Option)
        {
            Description = 'CF001 types are ,Indent,SIC';
            OptionCaption = ' ,Indent,SIC';
            OptionMembers = " ",Indent,SIC;
            DataClassification = CustomerContent;
            Caption = 'Item Type';
        }
        field(54003; "Tool Life"; Integer)
        {
            Description = 'For defining Life for Tool Life of toll item';
            DataClassification = CustomerContent;
            Caption = 'Tool Life';
        }
        field(54005; "Thick (mm)"; Decimal)
        {
            Description = 'CF_SC';
            DataClassification = CustomerContent;
            Caption = 'Thick (mm)';
        }
        field(54006; "Blank Width (mm)"; Decimal)
        {
            Description = 'CF_SC';
            DataClassification = CustomerContent;
            Caption = 'Blank Width (mm)';
        }
        field(54007; "Blank Length (mm)"; Decimal)
        {
            Description = 'CF_SC';
            DataClassification = CustomerContent;
            Caption = 'Blank Length (mm)';
        }
        field(54008; "WT Per Blank in KG"; Decimal)
        {
            Description = 'CF_SC';
            DataClassification = CustomerContent;
            Caption = 'WT Per Blank in KG';
        }
        field(54009; "Model No."; Code[20])
        {
            Description = 'CE001 For maintain Model No. of Different Customer (Case FG)**Ankit**';
            TableRelation = Bin;
            DataClassification = CustomerContent;
            Caption = 'Model No.';
        }
        field(54010; "Qty. Per Trolley"; Decimal)
        {
            Description = 'CE_AA002';
            DataClassification = CustomerContent;
            Caption = 'Qty. Per Trolley';
        }
        field(54011; "SINGLE SPOT"; Decimal)
        {
            Description = 'CE_AA002';
            DataClassification = CustomerContent;
            Caption = 'SINGLE SPOT';
        }
        field(54012; "DOUBLE SPOT"; Decimal)
        {
            Description = 'CE_AA002';
            DataClassification = CustomerContent;
            Caption = 'DOUBLE SPOT';
        }
        field(54013; STROKE; Decimal)
        {
            Description = 'CE_AA002';
            DataClassification = CustomerContent;
            Caption = 'STROKE';
        }
        field(54014; "Entry Type Filter"; Option)
        {
            Description = 'CE_MT003';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output;
            DataClassification = CustomerContent;
            Caption = 'Entry Type Filter';
        }
        field(54099; "Amortization Payable"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amortization Payable';
        }
        field(55000; "Description 3"; Text[300])
        {
            DataClassification = CustomerContent;
            Caption = 'Description 3';
        }
        field(55001; "Show RG 1"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Show RG 1';
        }
        field(55003; "Pack Size in Nos"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Pack Size in Nos';
        }
        field(55013; "Max. Inventory"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Max. Inventory';
        }
        field(55014; "Min. Inventory"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Min. Inventory';
        }
        field(55015; MOQ; Decimal)
        {
            Description = 'MOQ1.0';
            DataClassification = CustomerContent;
            Caption = 'MOQ';
        }
        field(55016; "Inventory Tracking"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inventory Tracking';
        }
        field(55018; "Pack Size"; Integer)
        {
            Description = '//Alle';
            DataClassification = CustomerContent;
            Caption = 'Pack Size';

            trigger OnValidate()
            begin
                //Blocked :=TRUE;
            end;
        }
        field(75000; "Lead Time Dispatch"; DateFormula)
        {
            Description = 'ALLE 3.11';
            DataClassification = CustomerContent;
            Caption = 'Lead Time Dispatch';

            trigger OnValidate()
            begin
                Evaluate(Text1, Format("Lead Time Dispatch"));
                Var2 := StrLen(Text1);
                Var1 := CopyStr(Text1, Var2, Var2);
                Var3 := CopyStr(Text1, 1, Var2 - 1);
                Evaluate(Int1, Var3);
                if Var1 = 'D' then
                    "Lead time in days" := Int1 * 1
                else if Var1 = 'M' then
                    "Lead time in days" := Int1 * 30
                else if Var1 = 'Q' then
                    "Lead time in days" := Int1 * 90
                else
                    "Lead time in days" := Int1 * 7;
            end;
        }
        // Atul 01122025 Start >>Commented
        // field(75001; "Self Life"; Option)
        // {
        //     Description = 'ALLE 6.01';
        //     OptionCaption = ' ,1 Month, 3 Month , 6 Month, 12 Month, Indefinite';
        //     OptionMembers = " ","1 Month"," 3 Month "," 6 Month"," 12 Month"," Indefinite";
        //     DataClassification = CustomerContent;
        //     Caption = 'Self Life';
        // }
        // Atul 01122025 End 
        field(75002; "Hazard material classification"; Option)
        {
            Description = 'ALLE 6.01';
            OptionMembers = " ",H1,H2,H3,H4,H5;
            DataClassification = CustomerContent;
            Caption = 'Hazard material classification';
        }
        field(75003; "Material Safety data sheet"; Boolean)
        {
            Description = 'ALLE 6.01';
            DataClassification = CustomerContent;
            Caption = 'Material Safety data sheet';
        }
        field(75004; "Technical data sheet"; Boolean)
        {
            Description = 'ALLE 6.01';
            DataClassification = CustomerContent;
            Caption = 'Technical data sheet';
        }
        field(75005; "Deviation %"; Integer)
        {
            Description = 'ALLE 6.01';
            DataClassification = CustomerContent;
            Caption = 'Deviation %';
        }
        //Atul::01122025
        // field(75006; "SQ. Meter"; Decimal)
        // {
        //     DecimalPlaces = 2 : 5;
        //     Description = 'Alle VPB (Asked for Reporting Purpose)';
        //     DataClassification = CustomerContent;
        //     Caption = 'SQ. Meter';
        // }
        //Atul::01122025
        field(75007; "Allow Shipping Variance"; Boolean)
        {
            Description = 'ALLE[551]';
            DataClassification = CustomerContent;
            Caption = 'Allow Shipping Variance';
        }
        field(75008; "Procurement Type"; Option)
        {
            Description = 'ALLE[551] required by Zavenir-2-2-14';
            OptionCaption = ' ,Import,Domestic';
            OptionMembers = " ",Import,Domestic;
            DataClassification = CustomerContent;
            Caption = 'Procurement Type';
        }
        field(75009; "Avg. Unit Cost 14_15"; Decimal)
        {
            Description = 'Alle[Z]';
            DataClassification = CustomerContent;
            Caption = 'Avg. Unit Cost 14_15';
        }
        //Atul::01122025
        // field(75010; "No. of Price Valadity in Days"; Code[10])
        // {
        //     Description = '//Alle';
        //     DataClassification = CustomerContent;
        //     Caption = 'No. of Price Valadity in Days';
        // }
        //Atul::01122025
        field(75020; "Cost Amount Actual"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Value Entry"."Cost Amount (Actual)" WHERE("Item Ledger Entry Type" = CONST(Purchase), "Item No." = FIELD("No."), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"), "Location Code" = FIELD("Location Filter"), "Drop Shipment" = FIELD("Drop Shipment Filter"), "Variant Code" = FIELD("Variant Filter"), "Posting Date" = FIELD("Date Filter")));
            Caption = 'Cost Amount Actual';
            Editable = false;
            FieldClass = FlowField;
        }
        //IG_DS
        field(75021; "Product Classification"; Enum "Product Classification")
        {
            Caption = 'Product Classification';
            DataClassification = ToBeClassified;
        }
        field(75022; "SKU Category"; Enum "SKU Category")
        {
            DataClassification = ToBeClassified;
        }
        //IG_DS
    }
    keys
    {
        key(SSD1; "Item Category Code", "No.")
        {
        }
    }
    fieldgroups
    {
        addlast(DropDown;
        "Description 2", "Item Category Code", "Base Unit of Measure")
        {
        }
    }
    trigger OnBeforeDelete()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."SSD Delete Administrator" then Error('You are not authorise to delete this record');
    end;

    trigger OnAfterModify()
    var
        UserSetupL: Record "User Setup";
        TextLocal50001: label 'You don''t have editing permission to modify this. Contact System Administrator ';
    begin
        UserSetupL.GET(USERID);
        IF NOT UserSetupL."Master Editing Permission" THEN ERROR(TextLocal50001);
        crmupdateflag := TRUE;
        Sync := FALSE;
    end;

    trigger OnInsert()
    begin
        Blocked := true;
    end;
    /// <summary>
    /// CheckBlockItem.
    /// </summary>
    procedure CheckBlockItem()
    var
        DefDim: Record "Default Dimension";
    begin
        TestField("No.");
        TestField(Description);
        TestField("Base Unit of Measure");
        if Type = Type::Inventory then begin
            TestField("Inventory Posting Group");
            TestField("Gross Weight");
            TestField("Net Weight");
            if "Quality Required" then begin
                TestField("Item Tracking Code");
                TestField("Lot Nos.");
                TestField("Expiration Calculation");
            end;
        end;
        TestField("Gen. Prod. Posting Group");
        TestField("Item Category Code");
        TestField("Sales Unit of Measure");
        if IsCriticalComponenet("Gen. Prod. Posting Group") then TestField("Pack Size");
        //SSDU Dimension validation check to be inserted
    end;

    var
        UserSetupL: Record "User Setup";
        TextLocal50001: label 'You don''t have editing permission to modify this. Contact System Administrator ';
        TotalPurchVolume: Decimal;
        Var1: Text;
        Var2: Integer;
        Var3: Text;
        Text1: Text;
        Int1: Integer;
    /// <summary>
    /// IsCriticalComponenet.
    /// </summary>
    /// <param name="ProdPostingGrpCode">Code[20].</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure IsCriticalComponenet(ProdPostingGrpCode: Code[20]): Boolean
    var
        GenProductPostingGroup: Record "Gen. Product Posting Group";
    begin
        if GenProductPostingGroup.Get(ProdPostingGrpCode) then if GenProductPostingGroup."Critical Components" then exit(true);
        exit(false);
    end;
}
