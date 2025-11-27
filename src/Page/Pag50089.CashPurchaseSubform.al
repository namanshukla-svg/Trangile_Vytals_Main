Page 50089 "Cash Purchase Subform"
{
    // SM_MUA34 2005.07.29 New Form
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "SSD Gate Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Ref. Document No."; Rec."Ref. Document No.")
                {
                    ApplicationArea = All;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Total Quantity"; Rec."Total Quantity")
                {
                    ApplicationArea = All;
                }
                field("Balance Quantity"; Rec."Outstandiing Quantity")
                {
                    ApplicationArea = All;
                    DecimalPlaces = 1: 4;
                }
                field("Posted Actual Quantity"; Rec."Posted Actual Quantity")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Quantity Invoiced"; Rec."Challan Quantity")
                {
                    ApplicationArea = All;
                    DecimalPlaces = 1: 4;
                }
            }
        }
    }
    actions
    {
    }
    var "ShortageQty.": Decimal;
    procedure InsertGateLines(GateHeader: Record "SSD Gate Header")
    var
        PurchLine: Record "Purchase Line";
        GateEntryLine: Record "SSD Gate Line";
        RGPLine: Record "SSD RGP Line";
    begin
        //Purchase Invoice
        case GateHeader."Ref. Document Type" of GateHeader."ref. document type"::"Purchase Order": begin
            PurchLine.SetRange("Document Type", PurchLine."document type"::Order);
            PurchLine.SetRange("Document No.", GateHeader."Ref. Document No.");
            PurchLine.SetRange(Type, PurchLine.Type::Item);
            if PurchLine.Find('-')then begin
                repeat GateEntryLine.Init;
                    GateEntryLine."Document No.":=GateHeader."No.";
                    GateEntryLine."Line No.":=PurchLine."Line No.";
                    GateEntryLine."Party Type":=GateHeader."Party Type";
                    GateEntryLine."Party No.":=GateHeader."Party No.";
                    GateEntryLine."Ref. Document Type":=GateHeader."Ref. Document Type";
                    GateEntryLine."Ref. Document No.":=GateHeader."Ref. Document No.";
                    GateEntryLine.Type:=GateEntryLine.Type::Item;
                    GateEntryLine."No.":=PurchLine."No.";
                    GateEntryLine.Description:=PurchLine.Description;
                    GateEntryLine."Expected Receipt Date":=PurchLine."Expected Receipt Date";
                    GateEntryLine."Outstandiing Quantity":=PurchLine."Outstanding Quantity";
                    GateEntryLine."Unit of Measure Code":=PurchLine."Unit of Measure Code";
                    GateEntryLine."Total Quantity":=PurchLine.Quantity;
                    GateEntryLine.CalcFields("Posted Challan Quantity", "Posted Actual Quantity");
                    if GateEntryLine."Total Quantity" - GateEntryLine."Posted Actual Quantity" > 0 then GateEntryLine.Insert;
                until PurchLine.Next = 0;
            end;
        end;
        // RGP Outbound
        GateHeader."ref. document type"::"RGP Outbound": begin
            RGPLine.SetRange("Document Type", RGPLine."document type"::"RGP Outbound");
            RGPLine.SetRange("Document No.", GateHeader."Ref. Document No.");
            if PurchLine.Find('-')then begin
                repeat if RGPLine."Quantity Shipped" <> 0 then begin
                        GateEntryLine.Init;
                        GateEntryLine."Document No.":=GateHeader."No.";
                        GateEntryLine."Line No.":=RGPLine."Line No.";
                        GateEntryLine."Party Type":=GateHeader."Party Type";
                        GateEntryLine."Party No.":=GateHeader."Party No.";
                        GateEntryLine."Ref. Document Type":=GateHeader."Ref. Document Type";
                        GateEntryLine."Ref. Document No.":=GateHeader."Ref. Document No.";
                        case RGPLine.Type of RGPLine.Type::Item: GateEntryLine.Type:=GateEntryLine.Type::Item;
                        RGPLine.Type::"Item Description": GateEntryLine.Type:=GateEntryLine.Type::" ";
                        RGPLine.Type::"Fixed Asset": GateEntryLine.Type:=GateEntryLine.Type::"Fixed Asset";
                        end;
                        GateEntryLine."No.":=RGPLine."No.";
                        GateEntryLine.Description:=RGPLine.Description;
                        GateEntryLine."Outstandiing Quantity":=RGPLine."Outstanding Rcpt. Quantity";
                        GateEntryLine."Unit of Measure Code":=RGPLine."Unit Of Measure Code";
                        GateEntryLine."Total Quantity":=RGPLine.Quantity;
                        GateEntryLine.CalcFields("Posted Challan Quantity");
                        if GateEntryLine."Total Quantity" - GateEntryLine."Posted Challan Quantity" > 0 then GateEntryLine.Insert;
                    end;
                until RGPLine.Next = 0;
            end;
        end;
        end;
    end;
    procedure DeleteGateLines(GateHeader: Record "SSD Gate Header")
    begin
        //SETRANGE("Document Type", GateHeader."Document Type");
        //SETRANGE("Document No.", GateHeader."No.");
        if Rec.Find('-')then Rec.DeleteAll;
    end;
    procedure ChangeEditableMode(Mode: Boolean)
    begin
    end;
}
