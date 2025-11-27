Report 50276 "Issue Slip Detail"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Issue Slip Detail.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Requisition Line"; "SSD Indent Line2")
        {
            RequestFilterFields = "Document No.";

            column(ReportForNavId_1170000000;1170000000)
            {
            }
            column(ItemNo; "Requisition Line"."No.")
            {
            }
            column(Qty; "Requisition Line".Quantity)
            {
            }
            column(IssuedQty; "Requisition Line"."Issued Qty")
            {
            }
            column(InventoryMainStore; "Requisition Line"."Inventory Main Store")
            {
            }
            column(LocCode; "Requisition Line"."Location Code")
            {
            }
            column(UOM; "Requisition Line"."Unit Of Measure Code")
            {
            }
            column(VariantCode; ItemVariant.Description)
            {
            }
            column(Comp_Name; CompanyInformation.Name)
            {
            }
            column(Comp_Address; Location.Address + ' ' + Location."Address 2")
            {
            }
            column(Comp_City; Location.City + '-' + Location."Post Code")
            {
            }
            column(IndentNo; "Requisition Line"."Document No.")
            {
            }
            column(SINo; SINo)
            {
            }
            column(ItemName; Item.Description)
            {
            }
            column(OrderDate; "Requisition Line"."Indent Date")
            {
            }
            column(Remarks; "Requisition Line".Remarks)
            {
            }
            column(DeptHead; DeptHead)
            {
            }
            column(Prepared; Prepared)
            {
            }
            trigger OnAfterGetRecord()
            begin
                SINo+=1;
                Location.Get("Requisition Line"."Location Code");
                CompanyInformation.Get();
                if Item.Get("Requisition Line"."No.")then;
                if ItemVariant.Get(Item."No.", "Requisition Line"."Variant Code")then;
                IndentHeader2.Reset;
                IndentHeader2.SetRange("No.", "Requisition Line"."Document No.");
                if IndentHeader2.FindFirst then;
                UserSetup.Reset;
                UserSetup.SetRange("User ID", IndentHeader2."Indenter ID");
                if UserSetup.FindFirst then begin
                    Prepared:=UserSetup.Name;
                    ApproverId:=UserSetup."Approver ID";
                end;
                UserSetup.Reset;
                UserSetup.SetRange("User ID", ApproverId);
                if UserSetup.FindFirst then DeptHead:=UserSetup.Name;
            end;
            trigger OnPreDataItem()
            begin
                SINo:=0;
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
    var CompanyInformation: Record "Company Information";
    Item: Record Item;
    SINo: Integer;
    Location: Record Location;
    ItemVariant: Record "Item Variant";
    UserSetup: Record "User Setup";
    IndentHeader2: Record "SSD Indent Header2";
    Prepared: Text;
    ApproverId: Text;
    DeptHead: Text;
}
