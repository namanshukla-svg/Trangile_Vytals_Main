Report 50181 "Delivery Challan 57F4"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Delivery Challan 57F4.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Delivery Challan Header"; "Delivery Challan Header")
        {
            RequestFilterFields = "No.", "Vendor No.";

            column(ReportForNavId_4640;4640)
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
            column(rescen__Country_Region_Code_; rescen."Country/Region Code")
            {
            }
            column(rescen_State; rescen.State)
            {
            }
            column(rescen_City; rescen.City)
            {
            }
            column(rescen__Post_Code_; rescen."Post Code")
            {
            }
            column(rescen__Address_2_; rescen."Address 2")
            {
            }
            column(rescen_Address; rescen.Address)
            {
            }
            column(rescen_Name; rescen.Name)
            {
            }
            column(Delivery_Challan_Header__No__; "No.")
            {
            }
            column(Delivery_Challan_Header__Challan_Date_; "Challan Date")
            {
            }
            column(Today; Today)
            {
            }
            column(Time; Time)
            {
            }
            column(VendorName; VendorName)
            {
            }
            column(Delivery_Challan_Header__Gate_Out_Remarks_; "Gate Out Remarks")
            {
            }
            column(Delivery_Challan_Header__Process_Description_; "Process Description")
            {
            }
            column(VendorAdd1; VendorAdd1)
            {
            }
            column(VendorAdd2; VendorAdd2)
            {
            }
            column(OUTWARD__GATE__PASSCaption; OUTWARD__GATE__PASSCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Challan_No_Caption; Challan_No_CaptionLbl)
            {
            }
            column(Delivery_Challan_Header__Challan_Date_Caption; FieldCaption("Challan Date"))
            {
            }
            column(Gate_Out_DateCaption; Gate_Out_DateCaptionLbl)
            {
            }
            column(TimeCaption; TimeCaptionLbl)
            {
            }
            column(VendorCaption; VendorCaptionLbl)
            {
            }
            column(Delivery_Challan_Header__Gate_Out_Remarks_Caption; FieldCaption("Gate Out Remarks"))
            {
            }
            column(Delivery_Challan_Header__Process_Description_Caption; FieldCaption("Process Description"))
            {
            }
            column(Received_By_Caption; Received_By_CaptionLbl)
            {
            }
            column(Prepared_By_Caption; Prepared_By_CaptionLbl)
            {
            }
            column(Security_Sign__Caption; Security_Sign__CaptionLbl)
            {
            }
            column(Authorised_Signatory_Caption; Authorised_Signatory_CaptionLbl)
            {
            }
            dataitem("Delivery Challan Line"; "Delivery Challan Line")
            {
                DataItemLink = "Delivery Challan No."=field("No.");

                column(ReportForNavId_1280;1280)
                {
                }
                column(Delivery_Challan_Line__Item_No__; "Item No.")
                {
                }
                column(Delivery_Challan_Line__Unit_of_Measure_; "Unit of Measure")
                {
                }
                column(Delivery_Challan_Line_Description; Description)
                {
                }
                column(Delivery_Challan_Line__Quantity_at_Vendor_Location_; "Quantity at Vendor Location")
                {
                }
                column(Delivery_Challan_Line_Quantity; Quantity)
                {
                }
                column(var1; var1)
                {
                }
                column(Delivery_Challan_Line__No_2_; "No.2")
                {
                }
                column(Item_code___nameCaption; Item_code___nameCaptionLbl)
                {
                }
                column(Delivery_Challan_Line__Unit_of_Measure_Caption; FieldCaption("Unit of Measure"))
                {
                }
                column(Delivery_Challan_Line__Quantity_at_Vendor_Location_Caption; FieldCaption("Quantity at Vendor Location"))
                {
                }
                column(Delivery_Challan_Line_QuantityCaption; FieldCaption(Quantity))
                {
                }
                column(S_No_Caption; S_No_CaptionLbl)
                {
                }
                column(Delivery_Challan_Line__No_2_Caption; FieldCaption("No.2"))
                {
                }
                column(Delivery_Challan_Line_Deliver_Challan_No_; "Delivery Challan No.")
                {
                }
                column(Delivery_Challan_Line_Line_No_; "Line No.")
                {
                }
            }
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
    trigger OnPreReport()
    begin
        rescen.Get(UserMgt.GetRespCenterFilter);
    end;
    var rescen: Record "Responsibility Center";
    UserMgt: Codeunit "SSD User Setup Management";
    var1: Integer;
    VendorMaster: Record Vendor;
    VendorName: Text[50];
    VendorAdd2: Text[50];
    VendorAdd1: Text[50];
    "No.2": Text[50];
    Item: Record Item;
    OUTWARD__GATE__PASSCaptionLbl: label 'OUTWARD  GATE  PASS';
    CurrReport_PAGENOCaptionLbl: label 'Page';
    Challan_No_CaptionLbl: label 'Challan No.';
    Gate_Out_DateCaptionLbl: label 'Gate Out Date';
    TimeCaptionLbl: label 'Time';
    VendorCaptionLbl: label 'Vendor';
    Received_By_CaptionLbl: label 'Received By:';
    Prepared_By_CaptionLbl: label 'Prepared By:';
    Security_Sign__CaptionLbl: label 'Security Sign :';
    Authorised_Signatory_CaptionLbl: label 'Authorised Signatory:';
    Item_code___nameCaptionLbl: label 'Item code & name';
    S_No_CaptionLbl: label 'S.No.';
}
