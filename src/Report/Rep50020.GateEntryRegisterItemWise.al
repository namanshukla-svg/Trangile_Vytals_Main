Report 50020 "Gate Entry Register Item Wise"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Gate Entry Register Item Wise.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Gate Register"; "SSD Gate Register")
        {
            DataItemTableView = sorting("Gate Entry Date", "Gate Entry Time", "No.")order(descending);
            RequestFilterFields = "Entry No.", "Gate Entry Date", "Party Type", "Party No.";

            column(ReportForNavId_1171;1171)
            {
            }
            column(SummaryOnly; SummaryOnly)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(UserId; UserId)
            {
            }
            column(ResCen__Country_Region_Code_; ResCen."Country/Region Code")
            {
            }
            column(ResCen__Post_Code_; ResCen."Post Code")
            {
            }
            column(ResCen_City; ResCen.City)
            {
            }
            column(ResCen__Address_2_; ResCen."Address 2")
            {
            }
            column(ResCen_State; ResCen.State)
            {
            }
            column(ResCen_Address; ResCen.Address)
            {
            }
            column(ResCen_Name; ResCen.Name)
            {
            }
            column(Gate_Register__Gate_Entry_No__; "Gate Entry No.")
            {
            }
            column(Gate_Register__Gate_Entry_Date_; "Gate Entry Date")
            {
            }
            column(Gate_Register__Document_No__; "Document No.")
            {
            }
            column(Gate_Register__Party_Name_; "Party Name")
            {
            }
            column(Gate_Register__Challan_Bill_No__; "Challan/Bill No.")
            {
            }
            column(Gate_Register__Challan_Bill_Date_; "Challan/Bill Date")
            {
            }
            column(Gate_Register__No__; "No.")
            {
            }
            column(Gate_Register_Quantity; Quantity)
            {
            }
            column(Gate_Register__Unit_of_Measure_Code_; "Unit of Measure Code")
            {
            }
            column(Gate_Register_Description; "Gate Register".Description)
            {
            }
            column(Gate_Register__No_2_; "No.2")
            {
            }
            column(Gate_Register__Vechile_No__; "Vechile No.")
            {
            }
            column(Gate_Register__Gate_Entry_Time_; "Gate Entry Time")
            {
            }
            column(Gate_Register__No___Control1000000025; "No.")
            {
            }
            column(Gate_Register__No_2__Control1000000026; "No.2")
            {
            }
            column(Gate_Register_Description_Control1000000028; Description)
            {
            }
            column(Gate_Register__Unit_of_Measure_Code__Control1000000029; "Unit of Measure Code")
            {
            }
            column(Gate_Register_Quantity_Control1000000030; Quantity)
            {
            }
            column(Inward_RegisterCaption; Inward_RegisterCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Gate_Register__Gate_Entry_No__Caption; FieldCaption("Gate Entry No."))
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(Doc__No__Caption; Doc__No__CaptionLbl)
            {
            }
            column(Gate_Register__Party_Name_Caption; FieldCaption("Party Name"))
            {
            }
            column(Ch__Bill_No_Caption; Ch__Bill_No_CaptionLbl)
            {
            }
            column(Bill_DateCaption; Bill_DateCaptionLbl)
            {
            }
            column(Gate_Register__No__Caption; FieldCaption("No."))
            {
            }
            column(Gate_Register_QuantityCaption; FieldCaption(Quantity))
            {
            }
            column(UOMCaption; UOMCaptionLbl)
            {
            }
            column(Gate_Register_DescriptionCaption; FieldCaption(Description))
            {
            }
            column(No_2Caption; No_2CaptionLbl)
            {
            }
            column(Gate_Register__Vechile_No__Caption; FieldCaption("Vechile No."))
            {
            }
            column(In_TimeCaption; In_TimeCaptionLbl)
            {
            }
            column(Gate_Register_Entry_No_; "Entry No.")
            {
            }
            trigger OnAfterGetRecord()
            var
                Item: Record Item;
            begin
                ItemDes:='';
                if Item.Get("Gate Register"."No.")then;
                ItemDes:=Item.Description;
            end;
            trigger OnPreDataItem()
            begin
                Address:=ResCen.Address + ',' + ResCen."Address 2" + ',' + ResCen.City + ',' + ResCen."Post Code";
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field("Item Category"; CategoryFilter)
                {
                    ApplicationArea = All;
                    TableRelation = "Item Category";
                }
                field("Summary Only"; SummaryOnly)
                {
                    ApplicationArea = All;
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        ResCen.Get(UserMgt.GetRespCenterFilter);
    end;
    var Item: Record Item;
    ItemCatCode: Record "Item Category";
    CategoryCode: Code[30];
    CategoryFilter: Code[30];
    ResCen: Record "Responsibility Center";
    UserMgt: Codeunit "SSD User Setup Management";
    Address: Code[120];
    SummaryOnly: Boolean;
    Inward_RegisterCaptionLbl: label 'Inward Register';
    CurrReport_PAGENOCaptionLbl: label 'Page';
    DateCaptionLbl: label 'Date';
    Doc__No__CaptionLbl: label 'Doc. No. ';
    Ch__Bill_No_CaptionLbl: label 'Ch./Bill No.';
    Bill_DateCaptionLbl: label 'Bill Date';
    UOMCaptionLbl: label 'UOM';
    No_2CaptionLbl: label 'No.2';
    In_TimeCaptionLbl: label 'In Time';
    ItemDes: Text;
}
