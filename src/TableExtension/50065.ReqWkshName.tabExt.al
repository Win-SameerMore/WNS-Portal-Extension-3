tableextension 50065 "Req. Wksh Name Ext" extends "Requisition Wksh. Name"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }

    var
        myInt: Integer;
}