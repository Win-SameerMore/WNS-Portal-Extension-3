page 50053 "Currency Bank Setup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Currency Bank Setup";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Currency Code"; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                    ApplicationArea = all;
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    Caption = 'Bank Code';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}