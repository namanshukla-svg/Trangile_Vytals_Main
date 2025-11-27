page 50289 "ZD QUALITY EXECUTIVE"
{
    Caption = 'ZD QUALITY EXECUTIVE';
    PageType = RoleCenter;
    ApplicationArea = All;

    layout
    {
        area(RoleCenter)
        {
            part(Control100; "Headline RC Administrator")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
    actions
    {
        area(embedding)
        {
            ToolTip = 'Manage Administrator Processes.';

            action(PQualityOrderforApproval)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'P. Quality Order for Approval';
                RunObject = page "P. Quality Order for Approval";
            }
            action(RcptQualityOrderList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Rcpt. Quality Order List';
                RunObject = page "Rcpt. Quality Order List";
            }
            action(ManQualityOrderCardList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Man. Quality Order Card List';
                RunObject = page "Man. Quality Order Card List";
            }
            action(IndentList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Indent List';
                RunObject = page "Indent List";
            }
            action(ItemList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Item List';
                RunObject = page "Item List";
            }
            action(IndentListPending)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Pending Approval List';
                RunObject = page "Indent List Pending";
            }
            action(MaterialReceiptNoteList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Material Receipt Note List';
                RunObject = page "Material Receipt Note List";
            }
            action(SubcontractingOrderList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Subcontracting Order List';
                RunObject = page "Subcontracting Order List";
            }
            action(ItemIssueList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Issue List';
                RunObject = page "Item Issue List";
            }
            action(IssueSlipListForAppr)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Issue Slip List For Appr.';
                RunObject = page "Requests to Approve";
            }
            action(ItemReclassJournal)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Item Reclass. Journal';
                RunObject = page "Item Reclass. Journal";
            }
        }
        area(Sections)
        {
            group(History)
            {
                Caption = 'History';
                ToolTip = 'Showing Transaction History.';

                action(PostedManQOrderList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Man. Q.Order List';
                    RunObject = page "Posted Man. Q.Order List";
                }
                action(PostedRcptQualityOrderList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Rcpt Quality Order List';
                    RunObject = page "Posted Rcpt Quality Order List";
                }
            }
            group(Setup)
            {
                Caption = 'Setup';
                ToolTip = 'Showing Transaction History.';

                action(MeasurementTools)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Measurement Tools';
                    RunObject = page "Measurement Tools";
                }
                action(QualityMeasurements)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Measurement Tools';
                    RunObject = page "Quality: Measurements";
                }
                action(KindofSampling)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Kind of Sampling';
                    RunObject = page "Kind of Sampling";
                }
                action(SamplingTemplateList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sampling Template List';
                    RunObject = page "Sampling Template List";
                }
                action(SamplingTestList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sampling Test List';
                    RunObject = page "Sampling Test List";
                }
            }
            group(Reports)
            {
                Caption = 'Reports';
                ToolTip = 'Showing Reports';

                action(IncomingMaterialAnalysis)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Incoming Material Analysis';
                    RunObject = report "Incoming Material Analysis";
                }
                action(ProductSpecification)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Product Specification';
                    RunObject = report "Product Specification";
                }
                action(ProductionMaterialAnalysis)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Production Material Analysis';
                    RunObject = report "Production Material Analysis";
                }
                action(CertificateofAnalysis)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Certificate of Analysis';
                    RunObject = report "Certificate of Analysis";
                }
                action(QualityParameterDetails)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Quality Parameter Details';
                    RunObject = report "Quality Parameter Details";
                }
                action(UpdateQltOrderParameter)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Update Qlt Order Parameter';
                    RunObject = report "Update Qlt Order Parameter";
                }
                action(SamplingMenu)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sampling Template';
                    RunObject = report "Sampling Menu";
                }
                action(RejectionReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Rejection Report';
                    RunObject = report "Rejection Report";
                }
            }
        }
    }
}
