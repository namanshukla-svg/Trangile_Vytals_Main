Report 50077 "checking-Value Entry Vs G/l"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/checking-Value Entry Vs Gl.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Value Entry"; "Value Entry")
        {
            DataItemTableView = sorting("Item No.", "Posting Date", "Item Ledger Entry Type", "Entry Type", "Variance Type", "Item Charge No.", "Location Code", "Variant Code");
            RequestFilterFields = "Item No.", "Posting Date";

            column(ReportForNavId_8894;8894)
            {
            }
            column(Value_Entry__Value_Entry___Cost_Amount__Actual__; "Value Entry"."Cost Amount (Actual)")
            {
            }
            column(GLAMT; GLAMT)
            {
            }
            column(Value_Entry__Cost_Posted_to_G_L_; "Cost Posted to G/L")
            {
            }
            column(Value_Entry_Entry_No_; "Entry No.")
            {
            }
            dataitem("G/L - Item Ledger Relation"; "G/L - Item Ledger Relation")
            {
                DataItemLink = "Value Entry No."=field("Entry No.");
                DataItemTableView = sorting("G/L Entry No.", "Value Entry No.");

                column(ReportForNavId_7239;7239)
                {
                }
                column(G_L___Item_Ledger_Relation_G_L_Entry_No_; "G/L Entry No.")
                {
                }
                column(G_L___Item_Ledger_Relation_Value_Entry_No_; "Value Entry No.")
                {
                }
                dataitem("G/L Entry"; "G/L Entry")
                {
                    DataItemLink = "Entry No."=field("G/L Entry No.");
                    DataItemTableView = sorting("G/L Account No.", "Posting Date");
                    RequestFilterFields = "G/L Account No.";

                    column(ReportForNavId_7069;7069)
                    {
                    }
                    column(G_L_Entry__Document_No__; "Document No.")
                    {
                    }
                    column(G_L_Entry_Amount; Amount)
                    {
                    }
                    column(G_L_Entry__G_L_Account_No__; "G/L Account No.")
                    {
                    }
                    column(GLACC_Name; GLACC.Name)
                    {
                    }
                    column(G_L_Entry_Entry_No_; "Entry No.")
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
        }
        actions
        {
        }
    }
    labels
    {
    }
    var GLACC: Record "G/L Account";
    GLAMT: Decimal;
}
