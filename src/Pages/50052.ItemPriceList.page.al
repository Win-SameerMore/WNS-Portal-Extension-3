page 50052 "Item Price List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Item With Price List";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;

                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = all;

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;

                }
                field("Search Description"; Rec."Search Description")
                {
                    ApplicationArea = All;
                }
                field("Portal Item Description"; rec."Portal Item Description")
                {
                    ApplicationArea = all;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = all;

                }
                field("Minimum Qty."; Rec."Minimum Qty.")
                {
                    ApplicationArea = All;
                }
                field("Original Price"; Rec."Original Price")
                {
                    ApplicationArea = All;
                }
                field("Promotional Item"; Rec."Promotional Item")
                {
                    ApplicationArea = All;
                    Caption = 'Promotional Item';
                }

                field("Available on ECommerce"; Rec."Available on ECommerce")
                {
                    ApplicationArea = all;
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    ApplicationArea = all;

                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = all;

                }
                field("Minimum Order Quantity"; Rec."Minimum Order Quantity")
                {
                    ApplicationArea = all;

                }
                field("Net Weight"; Rec."Net Weight")
                {
                    ApplicationArea = all;

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                field("Order Multiple"; Rec."Order Multiple")
                {
                    ApplicationArea = all;

                }
                field("Price Includes VAT"; Rec."Price Includes VAT")
                {
                    ApplicationArea = all;

                }
                field("Purch. Unit of Measure"; Rec."Purch. Unit of Measure")
                {
                    ApplicationArea = all;

                }
                field("Routing No."; Rec."Routing No.")
                {
                    ApplicationArea = all;

                }
                field("Standard Cost"; Rec."Standard Cost")
                {
                    ApplicationArea = all;

                }
                field("Unit Volume"; Rec."Unit Volume")
                {
                    ApplicationArea = all;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = all;
                }
                field("Vendor/Manufacturer item code"; Rec."Vendor/Manufacturer item code")
                {
                    ApplicationArea = all;
                }
                field("Quantity Available"; Rec."Quantity Available")
                {
                    ApplicationArea = all;
                }
                field("ETA Available Remarks"; Rec."ETA Available Remarks")
                {
                    ApplicationArea = all;

                }
                field("ETA Not Available Remarks"; Rec."ETA Not Available Remarks")
                {
                    ApplicationArea = all;

                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ApplicationArea = all;

                }
                field("Manufucturing Item Code"; Rec."Manufucturing Item Code")
                {
                    ApplicationArea = all;

                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = all;

                }
                field("Effective Date"; Rec."Effective Date")
                {
                    ApplicationArea = all;

                }
                field("Sales Unit Price"; Rec."Sales Unit Price")
                {
                    ApplicationArea = all;
                }
                field("Sales Unit of Measure"; rec."Sales Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(Dimension; rec.Dimension)
                {
                    ApplicationArea = All;
                }
                field(Colour; rec.Colour)
                {
                    ApplicationArea = All;
                }
                field("Depth"; rec.Depth)
                {
                    ApplicationArea = All;
                }
                field("Width"; rec.Width)
                {
                    ApplicationArea = All;
                }
                field("Height"; rec.Height)
                {
                    ApplicationArea = All;
                }
                field("Material Description"; rec."Material Description")
                {
                    ApplicationArea = All;
                }
                field("Model Year"; rec."Model Year")
                {
                    ApplicationArea = All;
                }
                field("Supply Voltage"; rec."Supply Voltage")
                {
                    ApplicationArea = All;
                }
                field("Body Colour"; rec."Body Colour")
                {
                    ApplicationArea = All;
                }
                field("Base Colour"; rec."Base Colour")
                {
                    ApplicationArea = All;
                }
                field("Lens Colour"; rec."Lens Colour")
                {
                    ApplicationArea = All;
                }
                field("Certification"; rec.Certification)
                {
                    ApplicationArea = All;
                }
                field("Operating Environment"; rec."Operating Environment")
                {
                    ApplicationArea = All;
                }
                field("Bulbs"; rec.Bulbs)
                {
                    ApplicationArea = All;
                }
                field("Products"; rec.Products)
                {
                    ApplicationArea = All;
                }
                field("Brands"; rec.Brands)
                {
                    ApplicationArea = All;
                }
                field("Series"; rec.Series)
                {
                    ApplicationArea = All;
                }
                field("Current"; rec.Current)
                {
                    ApplicationArea = All;
                }
                field("Sound Output"; rec."Sound Output")
                {
                    ApplicationArea = All;
                }
                field("Number of Tones"; rec."Number of Tones")
                {
                    ApplicationArea = All;
                }
                field("Alarm Stages"; rec."Alarm Stages")
                {
                    ApplicationArea = All;
                }
                field("Volume Control"; rec."Volume Control")
                {
                    ApplicationArea = All;
                }
                field("IP/NEMA Rating"; rec."IP/NEMA Rating")
                {
                    ApplicationArea = All;
                }
                field("Housing Materials"; rec."Housing Materials")
                {
                    ApplicationArea = All;
                }
                field("Housing Colour"; rec."Housing Colour")
                {
                    ApplicationArea = All;
                }
                field("Mounting Style"; rec."Mounting Style")
                {
                    ApplicationArea = All;
                }
                field("Base Diameter / Dimensions"; rec."Base Diameter / Dimensions")
                {
                    ApplicationArea = All;
                }
                field("Base Type"; rec."Base Type")
                {
                    ApplicationArea = All;
                }
                field("Comp. Sounder/Beacons for Base"; rec."Comp. Sounder/Beacons for Base")
                {
                    ApplicationArea = All;
                }
                field("Minimum Temperature"; rec."Minimum Temperature")
                {
                    ApplicationArea = All;
                }
                field("Maximum Temperature"; rec."Maximum Temperature")
                {
                    ApplicationArea = All;
                }
                field("Certification Standards"; rec."Certification Standards")
                {
                    ApplicationArea = All;
                }
                field("Hazardous Certification"; rec."Hazardous Certification")
                {
                    ApplicationArea = All;
                }
                field("Flash Colour"; Rec."Flash Colour")
                {
                    ApplicationArea = All;
                }
                field("Flash Rate"; Rec."Flash Rate")
                {
                    ApplicationArea = All;
                }
                field("Flash Power"; Rec."Flash Power")
                {
                    ApplicationArea = All;
                }
                field("Bulb Type"; Rec."Bulb Type")
                {
                    ApplicationArea = All;
                }
                field("Light Output"; Rec."Light Output")
                {
                    ApplicationArea = All;
                }
                field("Image URL"; Rec."Image URL")
                {
                    ApplicationArea = all;
                }
                field("Search Item"; Rec."Search Item")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action("Generate Item Lines")
            {
                ApplicationArea = All;
                Image = Insert;

                trigger OnAction();
                var
                    GenerateLineCdu: Codeunit "Generate Item Prices";
                begin
                    if Confirm('Do you want to generate item price list?') then
                        GenerateLineCdu.GenerateItemPriceList();
                end;
            }
        }
    }
}