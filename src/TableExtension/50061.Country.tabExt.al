tableextension 50061 "Country Ext" extends "Country/Region"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Portal Country"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}