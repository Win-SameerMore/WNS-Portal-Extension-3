tableextension 50070 "Sales Header Archive Ext" extends "Sales Header Archive"
{
    fields
    {
        field(50013; "Date of Completion"; Date)
        {
            Caption = 'Date of Completion';
            DataClassification = ToBeClassified;
        }
        // Add changes to table fields here
        field(50100; "Sales Order Status"; Enum "Sales Order Status")
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales Order Status';
        }
        field(50101; "Sales Quote Status"; Enum "Sales Quote Status")
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales Quote Status';
        }
    }

    var
        myInt: Integer;
}