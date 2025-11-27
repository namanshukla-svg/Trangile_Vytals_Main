report 50007 GateOutFormat
{
    ApplicationArea = All;
    Caption = 'Gate Out Format';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/GateOutFormat.rdl';

    // PreviewMode = PrintLayout;
    dataset
    {
        dataitem(SSDGatePassHeader; "SSD Gate Pass Header")
        {
            DataItemTableView = sorting("No.");

            column(No; "No.")
            {
            }
            column(Date; "Date")
            {
            }
            column(VehicleNo; "Vehicle No.")
            {
            }
            column(DriverName; "Driver Name")
            {
            }
            column(TransporterCode; "Transporter Code")
            {
            }
            column(TransporterName; "Transporter Name")
            {
            }
            column(GatePassTime; Format("Gate Pass Time"))
            {
            }
            dataitem("SSD Gate Pass Line"; "SSD Gate Pass Line")
            {
                DataItemTableView = sorting("No.", "Line No.");
                DataItemLinkReference = SSDGatePassHeader;
                DataItemLink = "No."=field("No.");

                column(No_SSDGatePassLine; "No.")
                {
                }
                column(LineNo_SSDGatePassLine; "Line No.")
                {
                }
                column(InvoiceNo_SSDGatePassLine; "Invoice No.")
                {
                }
                column(InvoiceDate_SSDGatePassLine; "Invoice Date")
                {
                }
                column(InvoiceAmount_SSDGatePassLine; "Invoice Amount")
                {
                }
                column(CustomerNo_SSDGatePassLine; "Customer No.")
                {
                }
                column(CustomerName_SSDGatePassLine; "Customer Name")
                {
                }
                column(Transporter_No_CaptionLbl; Transporter_No_CaptionLbl)
                {
                }
                column(Transporter_Name_CaptionLbl; Transporter_Name_CaptionLbl)
                {
                }
                column(Line_No_; "Line No.")
                {
                }
                column(RegisterEntryNoCaptionLbl; RegisterEntryNoCaptionLbl)
                {
                }
                column(Register_Entry_Date_CaptionLbl; Register_Entry_Date_CaptionLbl)
                {
                }
                column(Vechile_No_CaptionLbl; Vechile_No_CaptionLbl)
                {
                }
                column(Gate_pass_Type_CaptionLbl; Gate_pass_Type_CaptionLbl)
                {
                }
                column(Document_Type_CaptionLbl; Document_Type_CaptionLbl)
                {
                }
                column(Document_No_CaptionLbl; Document_No_CaptionLbl)
                {
                }
                column(NRGPCaptionLbl; NRGPCaptionLbl)
                {
                }
                column(Document_Line_No_CaptionLbl; Document_Line_No_CaptionLbl)
                {
                }
                column(Party_Type_CaptionLbl; Party_Type_CaptionLbl)
                {
                }
                column(Party_No_CaptionLbl; Party_No_CaptionLbl)
                {
                }
                column(Party_Name_CaptionLbl; Party_Name_CaptionLbl)
                {
                }
                column(Challan_Bill_No_CaptionLbl; Challan_Bill_No_CaptionLbl)
                {
                }
                column(Challan_Bill_Date_CaptionLbl; Challan_Bill_Date_CaptionLbl)
                {
                }
                column(User_ID_CaptionLbl; User_ID_CaptionLbl)
                {
                }
                column(MRN_No_CaptionLbl; MRN_No_CaptionLbl)
                {
                }
                column(No__2_CaptionLbl; No__2_CaptionLbl)
                {
                }
                column(Gate_Entry_Date_CaptionLbl; Gate_Entry_Date_CaptionLbl)
                {
                }
                column(Gate_Entry_Time_CaptionLbl; Gate_Entry_Time_CaptionLbl)
                {
                }
                column(TypeCaption; TypeCaption)
                {
                }
                column(No_CaptionLbl; No_CaptionLbl)
                {
                }
                column(DescriptionCaptionLbl; DescriptionCaptionLbl)
                {
                }
                column(UomCaptionLbl; UomCaptionLbl)
                {
                }
                column(QtyCaptionLbl; QtyCaptionLbl)
                {
                }
                dataitem("Sales Invoice Line"; "Sales Invoice Line")
                {
                    DataItemLinkReference = "SSD Gate Pass Line";
                    DataItemTableView = sorting("Document No.", "Line No.");
                    DataItemLink = "Document No."=field("Invoice No.");

                    column(Type_SalesInvoiceLine; "Type")
                    {
                    }
                    column(No_SalesInvoiceLine; "No.")
                    {
                    }
                    column(DocumentNo_SalesInvoiceLine; "Document No.")
                    {
                    }
                    column(Description_SalesInvoiceLine; Description)
                    {
                    }
                    column(UnitofMeasure_SalesInvoiceLine; "Unit of Measure")
                    {
                    }
                    column(LocationCode_SalesInvoiceLine; "Location Code")
                    {
                    }
                    column(ShipmentDate_SalesInvoiceLine; "Shipment Date")
                    {
                    }
                    column(Quantity_SalesInvoiceLine; Quantity)
                    {
                    }
                    column(UnitPrice_SalesInvoiceLine; "Unit Price")
                    {
                    }
                    column(SIL;1)
                    {
                    }
                }
                dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
                {
                    DataItemLinkReference = "SSD Gate Pass Line";
                    DataItemTableView = sorting("Document No.", "Line No.");
                    DataItemLink = "Document No."=field("Invoice No.");

                    column(Type_SalesCrMemoLine; "Type")
                    {
                    }
                    column(DocumentNo_SalesCrMemoLine; "Document No.")
                    {
                    }
                    column(Quantity_SalesCrMemoLine; Quantity)
                    {
                    }
                    column(No_SalesCrMemoLine; "No.")
                    {
                    }
                    column(Description_SalesCrMemoLine; Description)
                    {
                    }
                    column(UnitofMeasure_SalesCrMemoLine; "Unit of Measure")
                    {
                    }
                    column(SCML;1)
                    {
                    }
                }
                dataitem("Transfer Shipment Line"; "Transfer Shipment Line")
                {
                    DataItemLinkReference = "SSD Gate Pass Line";
                    DataItemLink = "Document No."=field("Invoice No.");
                    DataItemTableView = sorting("Document No.", "Line No.");

                    column(ItemNo_TransferShipmentLine; "Item No.")
                    {
                    }
                    column(Quantity_TransferShipmentLine; Quantity)
                    {
                    }
                    column(UnitofMeasure_TransferShipmentLine; "Unit of Measure")
                    {
                    }
                    column(Description_TransferShipmentLine; Description)
                    {
                    }
                    column(TSL;1)
                    {
                    }
                }
                dataitem("Purch. Cr. Memo Line"; "Purch. Cr. Memo Line")
                {
                    DataItemLinkReference = "SSD Gate Pass Line";
                    DataItemTableView = sorting("Document No.", "Line No.");
                    DataItemLink = "Document No."=field("Invoice No.");

                    column(Type_PurchCrMemoLine; "Type")
                    {
                    }
                    column(No_PurchCrMemoLine; "No.")
                    {
                    }
                    column(Description_PurchCrMemoLine; Description)
                    {
                    }
                    column(UnitofMeasure_PurchCrMemoLine; "Unit of Measure")
                    {
                    }
                    column(Quantity_PurchCrMemoLine; Quantity)
                    {
                    }
                    column(PCML;1)
                    {
                    }
                }
                dataitem("Delivery Challan Line"; "Delivery Challan Line")
                {
                    DataItemLinkReference = "SSD Gate Pass Line";
                    DataItemLink = "Document No."=field("Invoice No.");
                    DataItemTableView = sorting("Delivery Challan No.", "Line No.");

                    column(ItemNo_DeliveryChallanLine; "Item No.")
                    {
                    }
                    column(UnitofMeasure_DeliveryChallanLine; "Unit of Measure")
                    {
                    }
                    column(QuantityBase_DeliveryChallanLine; "Quantity (Base)")
                    {
                    }
                    column(Description_DeliveryChallanLine; Description)
                    {
                    }
                    column(DCL;1)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        IF "Delivery Challan Line".Quantity = 0 THEN CurrReport.SKIP;
                    end;
                }
                dataitem("SSD RGP Shipment Line"; "SSD RGP Shipment Line")
                {
                    DataItemLinkReference = "SSD Gate Pass Line";
                    DataItemLink = "Document No."=field("Invoice No.");
                    DataItemTableView = sorting("Document No.", "Line No.");

                    column(Type_SSDRGPShipmentLine; "Type")
                    {
                    }
                    column(No_SSDRGPShipmentLine; "No.")
                    {
                    }
                    column(Description_SSDRGPShipmentLine; Description)
                    {
                    }
                    column(UnitOfMeasureCode_SSDRGPShipmentLine; "Unit Of Measure Code")
                    {
                    }
                    column(Quantity_SSDRGPShipmentLine; Quantity)
                    {
                    }
                    column(DocumentType_SSDRGPShipmentLine; "Document Type")
                    {
                    }
                    column(RSL;1)
                    {
                    }
                }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
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
    var Transporter_No_CaptionLbl: label 'Transporter No';
    Transporter_Name_CaptionLbl: label 'Transporter Name';
    DeliveryModeCaptionLbl: label 'Delivery Mode';
    RegisterEntryNoCaptionLbl: label 'Register  Entry  No.';
    Register_Entry_Date_CaptionLbl: label 'Register Entry  Date';
    Vechile_No_CaptionLbl: label 'Vechile No.';
    Gate_pass_Type_CaptionLbl: label 'Gate pass Type';
    Document_Type_CaptionLbl: label 'Document Type';
    Document_No_CaptionLbl: label ' Document No.';
    NRGPCaptionLbl: label ' NRGP';
    Document_Line_No_CaptionLbl: label '   Document Line No.';
    Party_Type_CaptionLbl: label 'Party Type';
    Party_No_CaptionLbl: label 'Party No';
    Party_Name_CaptionLbl: label 'Party Name';
    Challan_Bill_No_CaptionLbl: label 'Challan/Bill No.';
    Challan_Bill_Date_CaptionLbl: label 'Challan/Bill Date';
    User_ID_CaptionLbl: label 'User Id';
    MRN_No_CaptionLbl: label 'MRN No.';
    No__2_CaptionLbl: label 'No.2';
    TypeCaption: label 'Type';
    No_CaptionLbl: label 'No';
    DescriptionCaptionLbl: label 'Description';
    UomCaptionLbl: label 'Unit Of Measure';
    QtyCaptionLbl: label 'Qty';
    Gate_Entry_Date_CaptionLbl: label 'Gate Entry Date';
    Gate_Entry_Time_CaptionLbl: label 'Gate Entry Time';
    Outbound: Text[30];
    PSI: Record "Sales Invoice Line";
    PPI: Record "Purch. Inv. Line";
    Type: Option " ", "G/L Account", Item, Resource, "Fixed Asset", "Charge (Item)";
    No: Code[20];
}
