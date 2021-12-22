tableextension 50060 "Currency Ext" extends Currency
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Portal Currency"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}