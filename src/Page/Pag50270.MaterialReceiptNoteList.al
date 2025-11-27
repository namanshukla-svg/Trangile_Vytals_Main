Page 50270 "Material Receipt Note List"
{
    ApplicationArea = All;
    Caption = 'Material Receipt Note';
    CardPageID = "Material Receipt Note";
    PageType = List;
    Permissions = TableData "SSD Quality Setup"=ri;
    PopulateAllFields = true;
    RefreshOnActivate = true;
    SourceTable = "Warehouse Receipt Header";
    UsageCategory = Tasks;
    Editable = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';
                Editable = true;

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                }
                field("Gate Entry no."; Rec."Gate Entry no.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Party name"; Rec."Party name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bill No."; Rec."Bill No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bill Amount"; Rec."Bill Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Subcontracting; Rec.Subcontracting)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Vendor Shipment No."; Rec."Vendor Shipment No.")
                {
                    ApplicationArea = All;
                }
                field("Document Status"; Rec."Document Status")
                {
                    ApplicationArea = All;
                }
                field("Gate Entry Date"; Rec."Gate Entry Date")
                {
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                }
                field("Quality Required"; Rec."Quality Required")
                {
                    ApplicationArea = All;
                }
                field("Sorting Method"; Rec."Sorting Method")
                {
                    ApplicationArea = All;
                    OptionCaption = ' ,Item,Document,Shelf or Bin,Due Date ';
                    Visible = false;
                }
                field("Send For Quality"; Rec."Send For Quality")
                {
                    ApplicationArea = All;
                }
                field("Quality Done"; Rec."Quality Done")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    var WhseDocPrint: Codeunit "Warehouse Document-Print";
    UserMgt: Codeunit "SSD User Setup Management";
    Text001: label 'No Lines found for Quality Order Generation';
    Text002: label '%1 nos. of Quality Order Generated ';
    Text003: label 'Activate Quality Control Man. must be TRUE in Quality Setup ';
    Text004: label 'Lot No Information not found for Order No %1 Line No %2';
    Txt0005: label 'Normal Quality Order,Coil Type Quality Order';
    TXT0006: label 'MRN is Blocked.';
    TXT0007: label 'Please Define Posted MRN Series.';
    ItemJnlLine: Record "Item Journal Line";
    WhseLines: Record "Warehouse Receipt Line" temporary;
    SubconMRN: Boolean;
    BinContent: Record "Bin Content";
    CheckWhseLines: Record "Warehouse Receipt Line";
    Text50000: label 'Bin Contents does not exist for Item %1 , Location %2 and Bin %3.';
    Location: Record Location;
    UserSetup: Record "User Setup";
    Text0008: label 'Item tracking lines are not defined for item no. %1.';
    Text0009: label 'Do you want to create Quality Order?';
    RecSourceType: Option Purchase, Manufacturing, , Calibration;
    RecTemplateType: Option Receipt, Manufacturing, , Calibration;
    ReservationEntry1: Record "Reservation Entry";
    BarcodeReceipt: Report "BARCODE LEBEL RECEIPT 4x3";
}
