table 50052 "Item With Price List"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item;
        }
        field(2; Description; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Available on ECommerce"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(5; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
        }
        field(6; "Minimum Order Quantity"; Decimal)
        {
            AccessByPermission = TableData "Req. Wksh. Template" = R;
            Caption = 'Minimum Order Quantity';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(7; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(8; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(9; "Order Multiple"; Decimal)
        {
            AccessByPermission = TableData "Req. Wksh. Template" = R;
            Caption = 'Order Multiple';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(10; "Price Includes VAT"; Boolean)
        {
            Caption = 'Price Includes VAT';
        }
        field(11; "Purch. Unit of Measure"; Code[10])
        {
            Caption = 'Purch. Unit of Measure';
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."));
        }
        field(12; "Routing No."; Code[20])
        {
            Caption = 'Routing No.';
            TableRelation = "Routing Header";
        }
        field(13; "Standard Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Standard Cost';
            MinValue = 0;
        }
        field(14; "Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price';
            MinValue = 0;
        }
        field(15; "Unit Volume"; Decimal)
        {
            Caption = 'Unit Volume';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(16; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;
            //This property is currently not supported
            //TestTableRelation = true;
            ValidateTableRelation = true;
        }
        field(17; "Vendor/Manufacturer item code"; Code[20])
        {
            Caption = 'Vendor/Manufacturer’s item code';
            Description = 'E-commerce';
        }
        field(18; "Quantity Available"; Decimal)
        {
            Caption = 'Quantity Available';
            Description = 'E-commerce';
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No.")));
        }
        field(19; "ETA Available Remarks"; text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "ETA Not Available Remarks"; text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Base Unit of Measure"; Code[10])
        {
            Caption = 'Base Unit of Measure';
            TableRelation = "Unit of Measure";
            ValidateTableRelation = false;
        }
        field(22; "Manufucturing Item Code"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(23; Blocked; Boolean)
        {
            Caption = 'Blocked';

            trigger OnValidate()
            begin
                if not Blocked then
                    "Block Reason" := '';
            end;
        }
        field(24; "Block Reason"; Text[250])
        {
            Caption = 'Block Reason';

            trigger OnValidate()
            begin
                TestField(Blocked, true);
            end;
        }
        field(25; "Currency Code"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency where("Portal Currency" = filter(true));
        }
        field(26; "Effective Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Sales Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(28; Dimension; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Sales Unit of Measure"; Code[10])
        {
            Caption = 'Sales Unit of Measure';
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."));
        }
        field(30; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(31; "Promotional Item"; Boolean)
        {
            Caption = 'Promotional Item';
            DataClassification = ToBeClassified;
        }
        field(32; "Original Price"; Decimal)
        {
            Caption = 'Original Price';
            DataClassification = ToBeClassified;
        }
        field(33; "Colour"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Depth"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Width"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Height"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Material Description"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Model Year"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Supply Voltage"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Body Colour"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Base Colour"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Lens Colour"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Certification"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Operating Environment"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Bulbs"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Products"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Brands"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Series"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Current"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Sound Output"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Number of Tones"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Alarm Stages"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Volume Control"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(54; "IP/NEMA Rating"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Housing Materials"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(56; "Housing Colour"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(57; "Mounting Style"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(58; "Base Diameter / Dimensions"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(59; "Base Type"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Comp. Sounder/Beacons for Base"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(61; "Minimum Temperature"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(62; "Maximum Temperature"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(63; "Certification Standards"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(64; "Hazardous Certification"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(65; "Flash Colour"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(66; "Flash Rate"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(67; "Flash Power"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(68; "Bulb Type"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(69; "Light Output"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Portal Item Description"; text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Portal Item Description';
        }
        field(71; "Search Description"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(72; "Minimum Qty."; Decimal)
        {
            Caption = 'Minimum Qty.';
            DataClassification = ToBeClassified;
        }
        field(73; "Image URL"; text[2048])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Ecommerce Images".PictureURL
            where("Item No." = field("No."), "Image Type" = filter('Main')));
        }
        field(74; "Search Item"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Search Item';
        }
    }

    keys
    {
        key(Key1; "No.", "Customer No.", "Currency Code", "Minimum Qty.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}