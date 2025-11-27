Codeunit 50023 "Integration for ItemVarient"
{
    // BUG ID 75167
    // 25.04.2016 :Specified as Not Mandatory field disscused with tech team
    trigger OnRun()
    begin
    end;
    var LengthErr: label 'The Length of the GST Registration Nos. must be 15.';
    StateCodeErr: label 'The GST Registration No. for the state %1 should start with %2.', Comment = '%1 and %2 = State Code and Initial State Code';
    OnlyAlphabetErr: label 'Only Alphabet is allowed in the position %1.', Comment = '%1 = Integer';
    OnlyNumericErr: label 'Only Numeric is allowed in the position %1.', Comment = '%1 = Integer';
    OnlyAlphaNumericErr: label 'Only AlphaNumeric is allowed in the position %1.', Comment = '%1 = Integer';
    procedure ItemMasterExport(ItemVariantRequest: XmlPort ItemVariant; ItemNo: Code[20]; VarientCode: Code[20])
    var
        Item: Record Item;
    begin
        ItemVariantRequest.Export;
        Commit;
    end;
}
