page 50050 "Minimum Order Value Setup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Minimum Order Value Setup";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Admin Minimum Order Value"; Rec."Admin Minimum Order Value")
                {
                    ApplicationArea = All;
                }
                field("Admin Charges"; Rec."Admin Charges")
                {
                    ApplicationArea = All;
                }
                field("Admin Charges G/L Acc."; Rec."Admin Charges G/L Acc.")
                {
                    ApplicationArea = All;
                }
                field("Admin Charges G/L Acc. Desc."; rec."Admin Charges G/L Acc. Desc.")
                {
                    ApplicationArea = All;
                }
                field("Delivery Minimum Value"; Rec."Delivery Minimum Value")
                {
                    ApplicationArea = All;
                }
                field("Delivery Charges"; Rec."Delivery Charges")
                {
                    ApplicationArea = All;
                }
                field("Delivery Charges G/L Acc."; Rec."Delivery Charges G/L Acc.")
                {
                    ApplicationArea = All;
                }
                field("Del. Charges G/L Acc. Desc."; Rec."Del. Charges G/L Acc. Desc.")
                {
                    ApplicationArea = All;
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
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}