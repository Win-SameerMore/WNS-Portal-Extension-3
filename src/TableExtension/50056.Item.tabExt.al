tableextension 50056 "Item Ext" extends Item
{
    fields
    {
        // Add changes to table fields here
        field(50010; "Manufucturing Item Code"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "ETA Available Remarks"; text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "ETA Not Available Remarks"; text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Qty. on Trf. Shipment"; Decimal)
        {
            //AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            CalcFormula = Sum("Transfer Line"."Qty. to Ship" WHERE("item No." = FIELD("No."),
                                                                               "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                               "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                               "Transfer-from Code" = FIELD("Location Filter"),
                                                                               "Variant Code" = FIELD("Variant Filter"),
                                                                               "Shipment Date" = FIELD("Date Filter"),
                                                                               "Unit of Measure Code" = FIELD("Unit of Measure Filter")));
            Caption = 'Qty. on Trf. Shipment';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50014; "Qty. on Trf. Receipt"; Decimal)
        {
            //AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            CalcFormula = Sum("Transfer Line"."Qty. to Receive" WHERE("item No." = FIELD("No."),
                                                                               "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                               "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                               "Transfer-to Code" = FIELD("Location Filter"),
                                                                               "Variant Code" = FIELD("Variant Filter"),
                                                                               "Receipt Date" = FIELD("Date Filter"),
                                                                               "Unit of Measure Code" = FIELD("Unit of Measure Filter")));
            Caption = 'Qty. on Trf. Receipt';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50015; Dimension; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Portal Item Description"; text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Portal Item Description';
        }
        field(50017; "Image URL"; text[2048])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Ecommerce Images".PictureURL
            where("Item No." = field("No."), "Image Type" = filter('Main')));
        }
        field(50018; "Search Item"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Search Item';
        }
    }
    fieldgroups
    {
        addlast(DropDown; "Manufucturing Item Code") { }
    }
    trigger OnInsert()
    var
        rItem: Record Item;
        rSalesRecSetup: Record "Sales & Receivables Setup";
    begin
        rSalesRecSetup.Reset();
        rSalesRecSetup.get();
        rSalesRecSetup.TestField(rSalesRecSetup."ETA Available Remarks");
        rSalesRecSetup.TestField(rSalesRecSetup."ETA Not Available Remarks");

        "ETA Available Remarks" := rSalesRecSetup."ETA Available Remarks";
        "ETA Not Available Remarks" := rSalesRecSetup."ETA Not Available Remarks";
    end;

    var
        myInt: Integer;
}