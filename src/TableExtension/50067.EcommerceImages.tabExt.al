tableextension 50067 "Ecommerce Images Ext" extends "Ecommerce Images"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Image"; Media)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; PictureURL; Text[2048])
        {
            ExtendedDatatype = URL;
        }
    }

    var
        myInt: Integer;
}