report 50650 "SSD SPO Alert"
{
    Caption = 'SPO Alert';
    DefaultLayout = Word;
    WordLayout = './Layouts/SPOAlert.docx';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Salesperson/Purchaser"; "Salesperson/Purchaser")
        {
            RequestFilterFields = Code;

            column(Code; Code)
            {
            }
            column(Name; Name)
            {
            }
            dataitem(PurchaseHeader; "Purchase Header")
            {
                DataItemTableView = sorting("Document Type", "No.")where("Document Type"=const("Document Type"::Order));
                DataItemLink = "Purchaser Code"=field(Code);

                column(SSDOrderType; "SSD Order Type")
                {
                }
                column(No; "No.")
                {
                }
                column(PurchaserCode; "Purchaser Code")
                {
                }
                column(BuyfromVendorNo; "Buy-from Vendor No.")
                {
                }
                column(BuyfromVendorName; "Buy-from Vendor Name")
                {
                }
                column(ValidFrom; format("Valid From", 0, '<Day,2>-<Month,2>-<Year4>'))
                {
                }
                column(ValidTo; format("Valid To", 0, '<Day,2>-<Month,2>-<Year4>'))
                {
                }
                column(Amount; Amount)
                {
                }
                column(Status; Status)
                {
                }
                column(NoOfDays; NoOfDays)
                {
                }
                trigger OnPreDataItem()
                begin
                    PurchaseHeader.SetRange("No.", OrderNo);
                end;
            }
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field(OrderNo; OrderNo)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Order No.';
                    }
                    field(NoOfDays; NoOfDays)
                    {
                        ApplicationArea = All;
                        Caption = 'No. of Days';
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var NoOfDays: Integer;
    OrderNo: Code[20];
}
