Page 50267 "Rcpt. Quality Order List"
{
    ApplicationArea = All;
    Caption = 'Quality Order List';
    CardPageID = "Rcpt. Quality Order Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "SSD Quality Order Header";
    SourceTableView = sorting("Template Type")order(ascending)where("Template Type"=const(Receipt));
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("No.2"; Rec."No.2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ToolTip = 'Specifies the value of the Lot No. field.', Comment = '%';
                }
                field("Sampling Temp. No."; Rec."Sampling Temp. No.")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean var
                        FrmItemSamplingTemp: Page "Item Sampling Templates";
                        ItemSamplingTempocal: Record "Item Sampling Template";
                    begin
                    end;
                }
                field("Kind of Sampling"; Rec."Kind of Sampling")
                {
                    ApplicationArea = All;
                }
                field("Sampling Method"; Rec."Sampling Method")
                {
                    ApplicationArea = All;
                }
                field("Percentage / Fixed Quantity"; Rec."Percentage / Fixed Quantity")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Lot Size"; Rec."Lot Size")
                {
                    ApplicationArea = All;
                }
                field("Sample Size"; Rec."Sample Size")
                {
                    ApplicationArea = All;
                    Editable = "Sample SizeEditable";
                }
                field("Accepted Qty."; Rec."Accepted Qty.")
                {
                    ApplicationArea = All;
                    Editable = "Accepted Qty.Editable";
                }
                field("Rejected Qty."; Rec."Rejected Qty.")
                {
                    ApplicationArea = All;
                }
                field("Decision For Quality Pass"; Rec."Decision For Quality Pass")
                {
                    ApplicationArea = All;
                    Editable = DecisionForQualityPassEditable;
                }
                field("No. Of Coil"; Rec."No. Of Coil")
                {
                    ApplicationArea = All;
                }
                field("Total Qty. Sent For Inspection"; Rec."Total Qty. Sent For Inspection")
                {
                    ApplicationArea = All;
                }
                field("Accepted Under Deviation"; Rec."Accepted Under Deviation")
                {
                    ApplicationArea = All;
                }
                field("PPC Dev. Req. Ref. No."; Rec."PPC Dev. Req. Ref. No.")
                {
                    ApplicationArea = All;
                }
                field("Source Document No."; Rec."Source Document No.")
                {
                    ApplicationArea = All;
                }
                field("Time of Creation"; Rec."Time of Creation")
                {
                    ApplicationArea = All;
                }
                field("Supplier Batch No."; Rec."Supplier Batch No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    var ItemsReclass: Record "SSD Items Reclassification";
    UserMgt: Codeunit "SSD User Setup Management";
    QualityOrderPostLine: Codeunit "Quality Order -Post Line";
    Text001: label '%1 must be > zero';
    Txt0002: label '%1 cannot be more than %2';
    WarehouseHeader: Record "Warehouse Receipt Header";
    QualityOrderLine1: Record "SSD Quality Order Line";
    DecisionForQualityPassEditable: Boolean;
    "Sample SizeEditable": Boolean;
    "Accepted Qty.Editable": Boolean;
    "Vendor Claim CodeEditable": Boolean;
}
