page 50055 "Item Category Attribute"
{
    PageType = List;
    ApplicationArea = all;
    UsageCategory = Lists;
    SourceTable = "Item Category Attribute";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("Entry No"; Rec."Entry No")
                {
                    ToolTip = 'Specifies the value of the Entry No field.';
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ToolTip = 'Specifies the value of the Item Category Code field.';
                    ApplicationArea = All;
                }
                field("Item Category Description"; Rec."Item Category Description")
                {
                    ToolTip = 'Specifies the value of the Item Category Description field.';
                    ApplicationArea = All;
                }
                field("Item Attribute ID"; Rec."Item Attribute ID")
                {
                    ToolTip = 'Specifies the value of the Item Attribute ID field.';
                    ApplicationArea = All;
                }
                field("Item Attribute Name"; Rec."Ite Attribute Name")
                {
                    ToolTip = 'Specifies the value of the Ite Attribute Name field.';
                    ApplicationArea = All;
                }
                field("Item Attribute Value ID"; Rec."Item Attribute Value ID")
                {
                    ToolTip = 'Specifies the value of the Item Attribute Value ID field.';
                    ApplicationArea = All;
                }
                field("Item Attribute Value Name"; Rec."Item Attribute Value Name")
                {
                    ToolTip = 'Specifies the value of the Item Attribute Value Name field.';
                    ApplicationArea = All;
                }
                field("Item Attribute UOM"; Rec."Item Attribute UOM")
                {
                    ToolTip = 'Specifies the value of the Item Attribute UOM field.';
                    ApplicationArea = All;
                }
                field("Item Attribute Type"; Rec."Item Attribute Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                    ApplicationArea = All;
                }
                field("Last Modified Date Time"; Rec."Last Modified Date Time")
                {
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