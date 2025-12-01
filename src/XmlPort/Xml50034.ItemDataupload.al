XmlPort 50034 "Item Data upload"
{
    Direction = Import;
    Format = VariableText;
    FormatEvaluate = Legacy;

    schema
    {
        textelement(Root)
        {
            tableelement(Item;
            Item)
            {
                AutoSave = false;
                AutoUpdate = true;
                XmlName = 'Payroll';
                UseTemporary = false;

                textelement(itemno)
                {
                    XmlName = 'ItemNo';
                }
                textelement(itemdes)
                {
                    XmlName = 'ItemDes';
                }
                textelement(pricevalidity)
                {
                    XmlName = 'PriceValidity';
                }
                trigger OnAfterGetRecord()
                begin
                    if firstline then begin
                        firstline := false;
                        currXMLport.Skip;
                    end;
                    Recitem.Reset;
                    Recitem.SetRange("No.", ItemNo);
                    if Recitem.FindFirst then begin
                        //Atul::01122025
                        // Recitem."No. of Price Valadity in Days":=PriceValidity;
                        //Atul::01122025
                        Recitem.Modify;
                    end;
                end;
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
    trigger OnPreXmlPort()
    begin
        firstline := true;
        LineCount := 0;
    end;

    var
        firstline: Boolean;
        RecSalaryupload: Record "SSD Salary Upload Staging";
        Num: Integer;
        Recsal: Record "SSD Salary Upload Staging";
        BankAcc: Integer;
        Window: Dialog;
        LineCount: Integer;
        PostDate: Date;
        Recsalary: Record "SSD Salary Upload Staging";
        UserSetup: Record "User Setup";
        Recitem: Record Item;
}
