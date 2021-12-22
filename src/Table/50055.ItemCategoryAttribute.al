table 50055 "Item Category Attribute"
{
    Caption = 'Item Category Attribute';
    fields
    {
        field(1; "Entry No"; integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Item Category Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Parent Category Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Item Category Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Item Attribute ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Ite Attribute Name"; Text[250])
        {
            Caption = 'Item Attribute Name';
            DataClassification = ToBeClassified;
        }
        field(9; "Item Attribute Value ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Item Attribute Value Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Item Attribute Type"; Option)
        {
            Caption = 'Type';
            InitValue = Text;
            OptionCaption = 'Option,Text,Integer,Decimal,Date';
            OptionMembers = Option,Text,"Integer",Decimal,Date;
            DataClassification = ToBeClassified;
        }
        field(12; "Item Attribute UOM"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Last Modified Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(8000; ID; Guid)
        {
            DataClassification = ToBeClassified;
        }

    }
}