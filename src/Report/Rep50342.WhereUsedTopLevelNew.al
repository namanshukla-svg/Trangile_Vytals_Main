Report 50342 "Where-Used (Top Level) New"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Where-Used (Top Level).rdl';
    Caption = 'Where-Used (Top Level) New';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = sorting("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Description";

            column(ReportForNavId_8129;8129)
            {
            }
            column(FormattedToday; Format(Today, 0, 4))
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(CalcDateFormatted; Text000 + Format(CalculateDate))
            {
            }
            column(ItemTableCaptionItemFilter; TableCaption + ': ' + ItemFilter)
            {
            }
            column(ItemFilter; ItemFilter)
            {
            }
            column(No_Item; "No.")
            {
            IncludeCaption = true;
            }
            column(Description_Item; Description)
            {
            IncludeCaption = true;
            }
            column(WhereUsedListTopLevelCapt; WhereUsedListTopLevelCaptLbl)
            {
            }
            column(CurrReportPageNoCapt; CurrReportPageNoCaptLbl)
            {
            }
            column(LevelCodeCaption; LevelCodeCaptionLbl)
            {
            }
            column(WhereUsedListItemNoCapt; WhereUsedListItemNoCaptLbl)
            {
            }
            column(WhereUsedListDescCapt; WhereUsedListDescCaptLbl)
            {
            }
            column(WhereUsedListQtyNeededCapt; WhereUsedListQtyNeededCaptLbl)
            {
            }
            dataitem(BOMLoop; "Integer")
            {
                DataItemTableView = sorting(Number);

                column(ReportForNavId_8778;8778)
                {
                }
                column(WhereUsedListItemNo; WhereUsedList."Item No.")
                {
                }
                column(WhereUsedListDesc; WhereUsedList.Description)
                {
                }
                column(WhereUsedListQtyNeeded; WhereUsedList."Quantity Needed")
                {
                DecimalPlaces = 0: 5;
                }
                column(WhereUsedListLevelCode; PadStr('', WhereUsedList."Level Code", ' ') + Format(WhereUsedList."Level Code"))
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if First then begin
                        if not WhereUsedMgt.FindRecord('-', WhereUsedList)then CurrReport.Break;
                        First:=false;
                    end
                    else if WhereUsedMgt.NextRecord(1, WhereUsedList) = 0 then CurrReport.Break;
                end;
                trigger OnPreDataItem()
                begin
                    if Level = Level::"Single Level" then First:=false
                    else
                        First:=true;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                if Level = Level::"Single Level" then WhereUsedMgt.WhereUsedFromItem(Item, CalculateDate, false)
                else
                    WhereUsedMgt.WhereUsedFromItem(Item, CalculateDate, true);
            end;
            trigger OnPreDataItem()
            begin
                ItemFilter:=GetFilters;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(CalculateDate; CalculateDate)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Calculation Date';
                    }
                    field(Level; Level)
                    {
                        ApplicationArea = Basic;
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnInit()
        begin
            CalculateDate:=WorkDate;
        end;
    }
    labels
    {
    }
    var asdqw: Report 99000757;
    Text000: label 'As of ';
    WhereUsedList: Record "Where-Used Line";
    WhereUsedMgt: Codeunit "Where-Used Management";
    ItemFilter: Text;
    CalculateDate: Date;
    First: Boolean;
    WhereUsedListTopLevelCaptLbl: label 'Where-Used List (Top Level)';
    CurrReportPageNoCaptLbl: label 'Page';
    LevelCodeCaptionLbl: label 'Level';
    WhereUsedListItemNoCaptLbl: label 'No.';
    WhereUsedListDescCaptLbl: label 'Description';
    WhereUsedListQtyNeededCaptLbl: label 'Exploded Quantity.';
    Level: Option "Single Level", "Multi Level";
}
