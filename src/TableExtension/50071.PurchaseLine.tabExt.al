tableextension 50071 "Purchase Line Ext" extends "Purchase Line"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "PO Line Remarks"; text[200])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}