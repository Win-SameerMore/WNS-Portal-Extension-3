tableextension 50069 "Reservation Entry Ext" extends "Reservation Entry"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "RM Alloted"; Boolean)
        {
            Caption = 'RM Alloted';
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}