Table 50030 "SSD User Template Setup"
{
    LookupPageID = "User Templates";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "User ID"; Code[20])
        {
            TableRelation = User;
            DataClassification = CustomerContent;
            Caption = 'User ID';
        }
        field(2; Type; Option)
        {
            OptionCaption = 'General,Item,Requisition,BOM,Resource,Job';
            OptionMembers = General, Item, Requisition, BOM, Resource, Job;
            DataClassification = CustomerContent;
            Caption = 'Type';
        }
        field(3; "Template Code"; Code[20])
        {
            //SSD Comment Start
            // TableRelation = if (Type = const(General)) "Gen. Journal Template"
            // else
            // if (Type = const(Item)) "Item Journal Template"
            // else
            // if (Type = const(Requisition)) "Req. Wksh. Template"
            // else
            // if (Type = const(BOM)) Table297728
            // else
            // if (Type = const(Resource)) "Res. Journal Template"
            // else
            // if (Type = const(Job)) "Job Journal Template";
            //SSD Comment End;
            DataClassification = CustomerContent;
            Caption = 'Template Code';

            trigger OnValidate()
            begin
                case Type of Type::General: begin
                    GenJnlTemplate.Get("Template Code");
                    "General Sub Type":=GenJnlTemplate.Type;
                    Recurring:=GenJnlTemplate.Recurring;
                    "Responsibility Center":=GenJnlTemplate."Responsibility Center";
                    "Form ID":=GenJnlTemplate."Page ID";
                end;
                Type::Item: begin
                    ItemJnlTemplate.Get("Template Code");
                    "Item Sub Type":=ItemJnlTemplate.Type;
                    Recurring:=ItemJnlTemplate.Recurring;
                    "Responsibility Center":=ItemJnlTemplate."Responsibility Center";
                    "Form ID":=ItemJnlTemplate."Page ID";
                end;
                Type::Requisition: begin
                    ReqWorksheetTemplate.Get("Template Code");
                    "Req. Sub Type":=ReqWorksheetTemplate.Type;
                    Recurring:=ReqWorksheetTemplate.Recurring;
                    "Responsibility Center":=ReqWorksheetTemplate."Responsibility Center";
                    "Form ID":=ReqWorksheetTemplate."Page ID";
                end;
                Type::BOM: begin
                //BOMJnlTemplate.GET("Template Code"); // BIS 1145
                //Recurring:=BOMJnlTemplate.Recurring;// BIS 1145
                //"Responsibility Center":=BOMJnlTemplate."Responsibility Center";// BIS 1145
                //"Form ID":=BOMJnlTemplate."Form ID";// BIS 1145
                end;
                Type::Resource: begin
                    ResJnlTemplate.Get("Template Code");
                    Recurring:=ResJnlTemplate.Recurring;
                    "Responsibility Center":=ResJnlTemplate."Responsibility Center";
                    "Form ID":=ResJnlTemplate."Page ID";
                end;
                Type::Job: begin
                    JobJnlTemplate.Get("Template Code");
                    Recurring:=JobJnlTemplate.Recurring;
                    "Responsibility Center":=JobJnlTemplate."Responsibility Center";
                    "Form ID":=JobJnlTemplate."Page ID";
                end;
                end;
            end;
        }
        field(14; "General Sub Type"; Option)
        {
            OptionCaption = 'General,Sales,Purchases,Cash Receipts,Payments,Assets,Intercompany,TDS Adjustments,LC';
            OptionMembers = General, Sales, Purchases, "Cash Receipts", Payments, Assets, Intercompany, "TDS Adjustments", LC;
            DataClassification = CustomerContent;
            Caption = 'General Sub Type';
        }
        field(15; "Item Sub Type"; Option)
        {
            OptionCaption = 'Item,Transfer,Phys. Inventory,Revaluation,Consumption,Output,Capacity,Prod.Order,ItemIssue';
            OptionMembers = Item, Transfer, "Phys. Inventory", Revaluation, Consumption, Output, Capacity, "Prod.Order", ItemIssue;
            DataClassification = CustomerContent;
            Caption = 'Item Sub Type';
        }
        field(16; "Req. Sub Type"; Option)
        {
            OptionCaption = 'Req.,For. Labor,Planning';
            OptionMembers = "Req.", "For. Labor", Planning;
            DataClassification = CustomerContent;
            Caption = 'Req. Sub Type';
        }
        field(20; Recurring; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Recurring';
        }
        field(50001; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Description = 'CF001';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
        }
        field(50002; "Form ID"; Integer)
        {
            Caption = 'Form ID';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "User ID", Type, "Template Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var GenJnlTemplate: Record "Gen. Journal Template";
    ItemJnlTemplate: Record "Item Journal Template";
    ReqWorksheetTemplate: Record "Req. Wksh. Template";
    ResJnlTemplate: Record "Res. Journal Template";
    JobJnlTemplate: Record "Job Journal Template";
}
