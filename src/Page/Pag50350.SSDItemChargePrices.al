page 50350 "SSD Item Charge Prices"
{
    ApplicationArea = All;
    Caption = 'Item Charge Prices';
    PageType = Worksheet;
    SourceTable = "SSD Item Charge Price";
    UsageCategory = Administration;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(VendNoFilterCtrl; VendNoFilter)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor No. Filter';
                    ToolTip = 'Specifies a filter for which purchase prices display.';

                    trigger OnLookup(var Text: Text): Boolean var
                        VendList: Page "Vendor List";
                    begin
                        VendList.LookupMode:=true;
                        if VendList.RunModal() = ACTION::LookupOK then Text:=VendList.GetSelectionFilter()
                        else
                            exit(false);
                        exit(true);
                    end;
                    trigger OnValidate()
                    begin
                        VendNoFilterOnAfterValidate();
                    end;
                }
                field(ChargeItemNoFilterCtrl; ChargeItemNoFilter)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Charge Item No. Filter';
                    ToolTip = 'Specifies a filter for which purchase prices to display.';
                    TableRelation = "Item Charge";

                    trigger OnValidate()
                    begin
                        ChargeItemNoFilterOnAfterValidate();
                    end;
                }
                field(StartingDateFilter; StartingDateFilter)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Starting Date Filter';
                    ToolTip = 'Specifies a filter for which purchase prices to display.';

                    trigger OnValidate()
                    var
                        FilterTokens: Codeunit "Filter Tokens";
                    begin
                        FilterTokens.MakeDateFilter(StartingDateFilter);
                        StartingDateFilterOnAfterValid();
                    end;
                }
            }
            repeater(Control1)
            {
                field("Vendor No."; Rec."Vendor No.")
                {
                    ToolTip = 'Specifies the value of the Vendor No. field.';
                }
                field("Charge No."; Rec."Charge No.")
                {
                    ToolTip = 'Specifies the value of the Charge No. field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ToolTip = 'Specifies the value of the Direct Unit Cost field.';
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ToolTip = 'Specifies the value of the Starting Date field.';
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ToolTip = 'Specifies the value of the Ending Date field.';
                }
            }
        }
    }
    local procedure ChargeItemNoFilterOnAfterValidate()
    begin
        CurrPage.SaveRecord();
        SetRecFilters();
    end;
    /// <summary>
    /// SetRecFilters.
    /// </summary>
    procedure SetRecFilters()
    begin
        if VendNoFilter <> '' then Rec.SetFilter("Vendor No.", VendNoFilter)
        else
            Rec.SetRange("Vendor No.");
        if StartingDateFilter <> '' then Rec.SetFilter("Starting Date", StartingDateFilter)
        else
            Rec.SetRange("Starting Date");
        if ChargeItemNoFilter <> '' then Rec.SetFilter("Charge No.", ChargeItemNoFilter)
        else
            Rec.SetRange("Charge No.");
        CheckFilters(DATABASE::Vendor, VendNoFilter);
        CheckFilters(DATABASE::"Item Charge", ChargeItemNoFilter);
        CurrPage.Update(false);
    end;
    /// <summary>
    /// CheckFilters.
    /// </summary>
    /// <param name="TableNo">Integer.</param>
    /// <param name="FilterTxt">Text.</param>
    procedure CheckFilters(TableNo: Integer; FilterTxt: Text)
    var
        FilterRecordRef: RecordRef;
        FilterFieldRef: FieldRef;
    begin
        if FilterTxt = '' then exit;
        Clear(FilterRecordRef);
        Clear(FilterFieldRef);
        FilterRecordRef.Open(TableNo);
        FilterFieldRef:=FilterRecordRef.Field(1);
        FilterFieldRef.SetFilter(FilterTxt);
        if FilterRecordRef.IsEmpty()then Error(NoDataWithinFilterErr, FilterRecordRef.Caption, FilterTxt);
    end;
    local procedure VendNoFilterOnAfterValidate()
    var
        ItemCharge: Record "Item Charge";
    begin
        if ItemCharge.Get(Rec."Charge No.")then CurrPage.SaveRecord();
        SetRecFilters();
    end;
    local procedure StartingDateFilterOnAfterValid()
    begin
        CurrPage.SaveRecord();
        SetRecFilters();
    end;
    var //Vend: Record Vendor;
    VendNoFilter: Text;
    ChargeItemNoFilter: Text;
    StartingDateFilter: Text;
    NoDataWithinFilterErr: Label 'There is no %1 within the filter %2.', Comment = '%1: Field(Code), %2: GetFilter(Code)';
//MultipleVendorsSelectedErr: Label 'More than one vendor uses these purchase prices. To copy prices, the Vendor No. Filter field must contain one vendor only.';
//IsLookupMode: Boolean;
}
