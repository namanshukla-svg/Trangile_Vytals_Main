TableExtension 50098 "SSD Tracking Specification" extends "Tracking Specification"
{
    fields
    {
        modify("Location Code")
        {
            Caption = 'Location Code';
        }
        //Unsupported feature: Property Modification (DecimalPlaces) on ""Quantity (Base)"(Field 4)".
        //Unsupported feature: Property Modification (Editable) on ""Qty. per Unit of Measure"(Field 29)".
        //Unsupported feature: Property Modification (DecimalPlaces) on ""Qty. to Handle (Base)"(Field 50)".
        //Unsupported feature: Property Modification (DecimalPlaces) on ""Qty. to Invoice (Base)"(Field 51)".
        //Unsupported feature: Property Modification (DecimalPlaces) on ""Quantity Handled (Base)"(Field 52)".
        //Unsupported feature: Property Modification (Editable) on ""Quantity Handled (Base)"(Field 52)".
        //Unsupported feature: Property Modification (DecimalPlaces) on ""Quantity Invoiced (Base)"(Field 53)".
        //Unsupported feature: Property Modification (Editable) on ""Quantity Invoiced (Base)"(Field 53)".
        //Unsupported feature: Code Insertion (VariableCollection) on ""Quantity (Base)"(Field 4).OnValidate".
        //trigger (Variable: SalesLineLocal1)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;
        //Unsupported feature: Code Modification on ""Quantity (Base)"(Field 4).OnValidate".
        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Quantity (Base)" * "Quantity Handled (Base)" < 0) OR
           (ABS("Quantity (Base)") < ABS("Quantity Handled (Base)"))
        THEN
        #4..8

        IF NOT QuantityToInvoiceIsSufficient THEN
          VALIDATE("Appl.-to Item Entry",0);
        
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..11
        //<<<< ALLE[5.51]
        IF ("Source Type"=37) AND ("Source Subtype"=5) THEN
          BEGIN
           SalesLineLocal1.SETRANGE(SalesLineLocal1."Document No.","Source ID");
           SalesLineLocal1.SETRANGE(SalesLineLocal1."No.","Item No.");
           IF SalesLineLocal1.FINDFIRST THEN BEGIN
              "MRN No.":=SalesLineLocal1.MRNNO;
              "MRN Line No.":=SalesLineLocal1.MRNLINENO;
           END;
          END;
        //>>>> ALLE[5.51]
        
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on ""Lot No."(Field 5400).OnValidate".

        //trigger (Variable: ILE)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;
        //Unsupported feature: Code Modification on ""Lot No."(Field 5400).OnValidate".
        //trigger "(Field 5400)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Lot No." <> xRec."Lot No." THEN BEGIN
          TESTFIELD("Quantity Handled (Base)",0);
          TESTFIELD("Appl.-from Item Entry",0);
          IF IsReclass THEN
            "New Lot No." := "Lot No.";
          WMSManagement.CheckItemTrackingChange(Rec,xRec);
          InitExpirationDate;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //AlleZav1.03/070815 Begin
        ILE.RESET;
        ILE.SETRANGE("Lot No.","Lot No.");
        IF ILE.FINDSET THEN REPEAT
          IF ILE."Lot Blocked" = TRUE THEN
            ERROR('%1 Lot is Blocked',"Lot No.");
        UNTIL ILE.NEXT = 0;
        //AlleZav1.03/070815 End

        #1..8
        */
        //end;
        field(50056; "Rejected Qty."; Decimal)
        {
            Description = 'PQA-003';
            DataClassification = CustomerContent;
            Caption = 'Rejected Qty.';
        }
        field(50057; Sample; Boolean)
        {
            Description = 'PQA-003';
            DataClassification = CustomerContent;
            Caption = 'Sample';
        }
        field(50058; "Sample Quantity"; Decimal)
        {
            Description = 'PQA-003';
            DataClassification = CustomerContent;
            Caption = 'Sample Quantity';
        }
        field(50059; "Sampled By"; Code[20])
        {
            Description = 'PQA-003';
            DataClassification = CustomerContent;
            Caption = 'Sampled By';
        }
        field(50060; "Sampling Date"; Date)
        {
            Description = 'PQA-003';
            DataClassification = CustomerContent;
            Caption = 'Sampling Date';
        }
        field(50061; "MRN No."; Code[20])
        {
            Description = 'PQA-003';
            DataClassification = CustomerContent;
            Caption = 'MRN No.';
        }
        field(50062; "MRN Line No."; Integer)
        {
            Description = 'PQA-003';
            DataClassification = CustomerContent;
            Caption = 'MRN Line No.';
        }
        field(50063; "No. of Container"; Integer)
        {
            Description = 'PQA-003';
            DataClassification = CustomerContent;
            Caption = 'No. of Container';
        }
        field(50064; "Pack Quantity"; Decimal)
        {
            Description = 'PQA-003';
            DataClassification = CustomerContent;
            Caption = 'Pack Quantity';
        }
        field(50065; "Manufacturing date"; Date)
        {
            Description = 'PQA-003';
            DataClassification = CustomerContent;
            Caption = 'Manufacturing date';
        }
        field(50066; "Unused Field 1"; Code[1])
        {
            Description = 'PQA-003 UNUSED FIELDS : ADDED FOR FUTURE REQUIRMENT : REASON - ADDING FIELD FOR THIS FUNCTIONALITY TAKES TIME';
            DataClassification = CustomerContent;
            Caption = 'Unused Field 1';
        }
        field(50067; "Unused Field 2"; Code[1])
        {
            Description = 'PQA-003 UNUSED FIELDS : ADDED FOR FUTURE REQUIRMENT : REASON - ADDING FIELD FOR THIS FUNCTIONALITY TAKES TIME';
            DataClassification = CustomerContent;
            Caption = 'Unused Field 2';
        }
        field(50068; "Unused Field 3"; Code[1])
        {
            Description = 'PQA-003 UNUSED FIELDS : ADDED FOR FUTURE REQUIRMENT : REASON - ADDING FIELD FOR THIS FUNCTIONALITY TAKES TIME';
            DataClassification = CustomerContent;
            Caption = 'Unused Field 3';
        }
        field(50069; "Unused Field 4"; Code[1])
        {
            Description = 'PQA-003 UNUSED FIELDS : ADDED FOR FUTURE REQUIRMENT : REASON - ADDING FIELD FOR THIS FUNCTIONALITY TAKES TIME';
            DataClassification = CustomerContent;
            Caption = 'Unused Field 4';
        }
        field(50070; "Unused Field 5"; Code[1])
        {
            Description = 'PQA-003 UNUSED FIELDS : ADDED FOR FUTURE REQUIRMENT : REASON - ADDING FIELD FOR THIS FUNCTIONALITY TAKES TIME';
            DataClassification = CustomerContent;
            Caption = 'Unused Field 5';
        }
        //IG_DS>>
        field(50072; "From Package"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50073; "To Package"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        //IG_DS<<
        //SSDU
        modify("Quantity (Base)")
        {
            trigger OnAfterValidate()
            begin
                IF ("Source Type" = 37) AND ("Source Subtype" = 5) THEN BEGIN
                    SalesLineLocal1.SETRANGE(SalesLineLocal1."Document No.", "Source ID");
                    SalesLineLocal1.SETRANGE(SalesLineLocal1."No.", "Item No.");
                    IF SalesLineLocal1.FINDFIRST THEN BEGIN
                        "MRN No." := SalesLineLocal1.MRNNO;
                        "MRN Line No." := SalesLineLocal1.MRNLINENO;
                    END;
                END;
                // IF ("Source Type" = 39) AND ("Source Subtype" = 1) THEN BEGIN
                //     PurchLine.SETRANGE(PurchLine."Document No.", "Source ID");
                //     PurchLine.SETRANGE(PurchLine."No.", "Item No.");
                //     IF PurchLine.FINDFIRST THEN BEGIN
                //         "MRN No." := PurchLine."Document No.";
                //         "MRN Line No." := PurchLine."Line No.";
                //         ReservationEntry.SetRange("Source ID", PurchLine."Document No.");
                //         ReservationEntry.SetRange("Source Ref. No.", PurchLine."Line No.");
                //         if ReservationEntry.FindFirst() then begin
                //             ReservationEntry."MRN No." := PurchLine."Document No.";
                //             ReservationEntry."MRN Line No." := PurchLine."Line No.";
                //             ReservationEntry.Modify();
                //         end;
                //     END;
                // END;
            end;
        }
        modify("Lot No.")
        {
            trigger OnBeforeValidate()
            begin
                //IG_DS_Before
                // ILE.RESET;
                // ILE.SETRANGE("Lot No.", "Lot No.");
                // IF ILE.FINDSET THEN
                //     REPEAT
                //         IF (ILE."Lot Blocked" = TRUE) THEN ERROR('%1 Lot is Blocked', "Lot No.");
                //     UNTIL ILE.NEXT = 0;
                //IG_DS_After
                ILE.RESET;
                ILE.SETRANGE("Lot No.", "Lot No.");
                ILE.SetRange("Lot Blocked", true);
                IF ILE.FindFirst() THEN
                    IF (ILE."Lot Blocked" = TRUE) THEN ERROR('%1 Lot is Blocked', "Lot No.");
            end;
        }
    }
    keys
    {
        // Unsupported feature: Key containing base fields
        // key(Key1;"Appl.-to Item Entry")
        // {
        // }
    }
    //Unsupported feature: Code Modification on "CheckItemTrackingQuantity(PROCEDURE 6)".
    //procedure CheckItemTrackingQuantity();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF QtyToHandleBase = 0 THEN
      Handle := FALSE;
    IF QtyToInvoiceBase = 0 THEN
    #4..8
    ReservationEntry.SETRANGE("Source Subtype",DocumentType);
    ReservationEntry.SETRANGE("Source ID",DocumentNo);
    ReservationEntry.SETRANGE("Source Ref. No.",LineNo);
    ReservationEntry.SETFILTER("Item Tracking",'%1|%2',
      ReservationEntry."Item Tracking"::"Lot and Serial No.",
      ReservationEntry."Item Tracking"::"Serial No.");
    CheckItemTrackingByType(ReservationEntry,QtyToHandleBase,QtyToInvoiceBase,FALSE,Handle,Invoice);
    ReservationEntry.SETRANGE("Item Tracking",ReservationEntry."Item Tracking"::"Lot No.");
    CheckItemTrackingByType(ReservationEntry,QtyToHandleBase,QtyToInvoiceBase,TRUE,Handle,Invoice);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..11
    //ReservationEntry.SETFILTER("Item Tracking",'%1|%2', //bis 1145 13-04-2015
    //  ReservationEntry."Item Tracking"::"Lot and Serial No.",
    //  ReservationEntry."Item Tracking"::"Serial No.");
    ReservationEntry.SETRANGE(ReservationEntry."Lot No.","Lot No."); //bis 1145 13-04-2015
    #15..17
    */
    //end;
    var
        SalesLineLocal1: Record "Sales Line";
        PurchLine: Record "Purchase Line";
        ILE: Record "Item Ledger Entry";
        ReservationEntry: Record "Reservation Entry";
}
