Report 50101 "Product Specification"
{
    // `
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Product Specification.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sampling Temp. Header"; "SSD Sampling Temp. Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";

            column(ReportForNavId_4759;4759)
            {
            }
            column(Remarks; SamplingTestHeader.Remarks)
            {
            }
            column(CompInfo__New_Logo1_; CompInfo."New Logo1")
            {
            }
            column(CompInfo__New_Logo2_; CompInfo."New Logo2")
            {
            }
            column(NosDesc; NosDesc)
            {
            }
            column(UserSetup_Name; UserSetup.Name)
            {
            }
            column(Today; Today)
            {
            }
            column(Sampling_Temp__Header__No__; "No.")
            {
            }
            column(Edition_______FORMAT__Sampling_Temp__Header___Approved_Date__; "Sampling Temp. Header".Review + ' & ' + Format("Sampling Temp. Header"."Last Date Modified"))
            {
            }
            column(Sampling_Temp__Header__Sampling_Temp__Header__Status; "Sampling Temp. Header".Status)
            {
            }
            column(Sampling_Temp__Header__No___Control1000000008; "No.")
            {
            }
            column(Description______Description_2_; Description + ' ' + "Description 2")
            {
            }
            column(DataItem1000000049;'This internally controlled document is the sole property of Zavenir Daubert India Private Limited. it is intended for limited and authorized distribution only.')
            {
            }
            column(Product_SpecificationCaption; Product_SpecificationCaptionLbl)
            {
            }
            column(CONFIDENTIALCaption; CONFIDENTIALCaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(User_IDCaption; User_IDCaptionLbl)
            {
            }
            column(Specification_No_Caption; Specification_No_CaptionLbl)
            {
            }
            column(Version_and_Effective_DateCaption; Version_and_Effective_DateCaptionLbl)
            {
            }
            column(Active_ObsoleteCaption; Active_ObsoleteCaptionLbl)
            {
            }
            column(Item_CodeCaption; Item_CodeCaptionLbl)
            {
            }
            column(Item_NameCaption; Item_NameCaptionLbl)
            {
            }
            column(ICC; Item."Item Category Code")
            {
            }
            column(ItemNo; Item."No.")
            {
            }
            column(ResultsRequiredCaption; ResultsRequiredCaptionLbl)
            {
            }
            column(ValueRequiredCaption; ValueRequiredCaptionLbl)
            {
            }
            dataitem("Sampling Temp. Line"; "SSD Sampling Temp. Line")
            {
                DataItemLink = "Document No."=field("No.");
                DataItemTableView = sorting("Document No.", "Line No.");

                column(ReportForNavId_7361;7361)
                {
                }
                column(FixedText; FixedText)
                {
                }
                column(TobePrint_SamplingTempLine; PrintYes)
                {
                }
                column(CheckComments; CheckComments)
                {
                }
                column(Sampling_Temp__Line_Description; Description)
                {
                }
                column(QualityMeasurements_Protocol; QualityMeasurements.Protocol)
                {
                }
                column(MinVal; MinVal)
                {
                }
                column(MaxVal; MaxVal)
                {
                }
                column(Sampling_Temp__Line__Unit_of_Measure_Code_; "Unit of Measure Code")
                {
                }
                column(Sampling_Temp__Line__Sampling_Temp__Line__Comments; "Sampling Temp. Line".Comments)
                {
                }
                column(Test_ParameterCaption; Test_ParameterCaptionLbl)
                {
                }
                column(ProtocolCaption; ProtocolCaptionLbl)
                {
                }
                column(Min__ValueCaption; Min__ValueCaptionLbl)
                {
                }
                column(Max__ValueCaption; Max__ValueCaptionLbl)
                {
                }
                column(UnitCaption; UnitCaptionLbl)
                {
                }
                column(RemarksCaption; RemarksCaptionLbl)
                {
                }
                column(Sampling_Temp__Line_Document_No_; "Document No.")
                {
                }
                column(Sampling_Temp__Line_Line_No_; "Line No.")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if "Minimum Value" = 0 then MinVal:='-'
                    else
                        MinVal:=Format("Minimum Value");
                    if "Maximum Value" = 0 then MaxVal:='-'
                    else
                        MaxVal:=Format("Maximum Value");
                    QualityMeasurements.Reset;
                    if QualityMeasurements.Get("Sampling Temp. Line"."Meas. Code")then;
                    CheckComments:='NO';
                    if "Sampling Temp. Line".Comments then CheckComments:='YES';
                    if "Sampling Temp. Line"."To be Print" = true then PrintYes:='Yes'
                    else
                        PrintYes:='-';
                end;
            }
            trigger OnAfterGetRecord()
            begin
                NosDesc:='';
                UserSetup.Reset;
                if UserSetup.Get(UserId)then;
                Item.Reset;
                if Item.Get("Sampling Temp. Header"."No.")then;
                //  NoSeries.RESET;
                //  NoSeries.SETRANGE(Code,Item."No. Series");
                //  IF NoSeries.FINDFIRST THEN BEGIN
                //    NosDesc := NoSeries.Description;
                //    END ELSE IF NoSeries.Description = 'WIP' THEN
                //      NosDesc := 'SF';
                ItemSamplingTemplate.Reset;
                ItemSamplingTemplate.SetRange(ItemSamplingTemplate."Sampling Temp. No.", "Sampling Temp. Header"."No.");
                if ItemSamplingTemplate.FindFirst then begin
                    Item.Reset;
                    Item.SetRange("No.", ItemSamplingTemplate."Item Code");
                    if Item.FindFirst then if Item."Item Category Code" = 'RAWMATRL' then begin
                            NosDesc:='Raw Material';
                        end
                        else if(Item."Item Category Code" = 'SEMIFINISH')then NosDesc:='SF/FG';
                end;
                RoutingLine.Reset;
                RoutingLine.SetRange(RoutingLine."Quality Sampling No.", "Sampling Temp. Header"."No.");
                //IF RoutingLine.FINDFIRST THEN BEGIN//Alle_121218
                if RoutingLine.FindSet then repeat //Alle_121218
 Item.Reset;
                        Item.SetRange(Item."Routing No.", RoutingLine."Routing No.");
                        if Item.FindFirst then if(Item."Gen. Prod. Posting Group" = 'FG')then begin
                                NosDesc:='SF/FG';
                            end
                            else if Item."Item Category Code" = 'RAWMATRL' then //Alle_121218
 NosDesc:='Raw Material'; //Alle_121218
                    until RoutingLine.Next = 0; //Alle_121218
                //END;//Alle_121218
                if SamplingTestHeader.Get("Sampling Temp. Header"."No.")then;
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnInitReport()
    begin
        FixedText:='FM-QA-07, Rev.No.00, Effective Date 01/12/2018';
    end;
    trigger OnPreReport()
    begin
        CompInfo.Get;
        CompInfo.CalcFields(CompInfo.Picture, CompInfo."New Logo1", CompInfo."New Logo2");
    end;
    var CompInfo: Record "Company Information";
    Item: Record Item;
    Vendor: Record Vendor;
    AverageTestValue: Text[30];
    UserSetup: Record "User Setup";
    QualityMeasurements: Record "SSD Quality Measurements";
    MinVal: Text[30];
    MaxVal: Text[30];
    Product_SpecificationCaptionLbl: label 'Product Specification';
    CONFIDENTIALCaptionLbl: label 'CONFIDENTIAL';
    DateCaptionLbl: label 'Date';
    User_IDCaptionLbl: label 'User ID';
    Specification_No_CaptionLbl: label 'Specification No.';
    Version_and_Effective_DateCaptionLbl: label 'Issue No. and Effective Date';
    Active_ObsoleteCaptionLbl: label 'Active/Obsolete';
    Item_CodeCaptionLbl: label 'Item Code';
    Item_NameCaptionLbl: label 'Item Name';
    Test_ParameterCaptionLbl: label 'Test Parameter';
    ProtocolCaptionLbl: label 'Protocol';
    Min__ValueCaptionLbl: label 'Min. Value';
    Max__ValueCaptionLbl: label 'Max. Value';
    UnitCaptionLbl: label 'Unit';
    RemarksCaptionLbl: label 'Remarks';
    CheckComments: Text;
    SamplingTestHeader: Record "SSD Sampling Test Header";
    ResultsRequiredCaptionLbl: label 'Results Required by Supplier';
    ValueRequiredCaptionLbl: label 'Value to Print in Customer TC';
    NoSeries: Record "No. Series";
    NosDesc: Text[30];
    NosDesc2: Text[5];
    ItemSamplingTemplate: Record "Item Sampling Template";
    RoutingLine: Record "Routing Line";
    PrintYes: Text;
    FixedText: Text;
    InventoryPeriod: Record "Inventory Period";
}
