tableextension 50059 "Vendor Ext" extends Vendor
{
    fields
    {
        // Add changes to table fields here
        field(50050; "Vendor Category 1"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50051; "Vendor Category 2"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}