report 50017 "Item Category Attribute"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Item Category Attribute';

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = sorting("No.") where("Item Category Code" = filter(<> ''));

            trigger OnAfterGetRecord()
            begin
                ItemCategory.GET(Item."Item Category Code");

                ItemAttributeValueMapping.RESET;
                ItemAttributeValueMapping.SETRANGE("Table ID", DATABASE::"Item Category");
                ItemAttributeValueMapping.SETRANGE("No.", ItemCategory.Code);
                IF ItemAttributeValueMapping.FINDSET THEN
                    REPEAT

                        ItemCategoryAttribute.INIT;
                        ItemCategoryAttribute."Entry No" := ItemCategoryAttribute."Entry No" + 1000;
                        ItemCategoryAttribute."Item No." := Item."No.";
                        ItemCategoryAttribute.Description := Item.Description;

                        ItemCategoryAttribute."Item Category Code" := Item."Item Category Code";
                        ItemCategoryAttribute."Item Category Description" := ItemCategory.Description;
                        ItemCategoryAttribute."Parent Category Code" := ItemCategory."Parent Category";

                        IF ItemAttributeValueMapping."Item Attribute ID" <> 0 THEN BEGIN
                            ItemAttribute.GET(ItemAttributeValueMapping."Item Attribute ID");

                            ItemCategoryAttribute."Item Attribute ID" := ItemAttribute.ID;
                            ItemCategoryAttribute."Ite Attribute Name" := ItemAttribute.Name;
                            ItemCategoryAttribute."Item Attribute Type" := ItemAttribute.Type;
                            ItemCategoryAttribute."Item Attribute UOM" := ItemAttribute."Unit of Measure";

                        END;

                        IF ItemAttributeValueMapping."Item Attribute Value ID" <> 0 THEN BEGIN

                            ItemAttributeValue.RESET;
                            ItemAttributeValue.SETRANGE("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                            ItemAttributeValue.SETRANGE(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                            IF ItemAttributeValue.FINDFIRST THEN
                                ItemCategoryAttribute."Item Attribute Value ID" := ItemAttributeValue.ID;
                            ItemCategoryAttribute."Item Attribute Value Name" := ItemAttributeValue.Value;

                        END;

                        ItemCategoryAttribute."Last Modified Date Time" := CURRENTDATETIME;

                        ItemCategoryAttribute.INSERT;
                    UNTIL ItemAttributeValueMapping.NEXT = 0;
            end;
        }
    }

    requestpage
    {
    }
    trigger OnPreReport()
    begin

        ItemCategoryAttribute.DELETEALL;
    end;

    var
        ItemCategoryAttribute: Record "Item Category Attribute";
        ItemCategory: Record "Item Category";
        ItemAttribute: Record "Item Attribute";
        ItemAttributeValue: Record "Item Attribute Value";
        ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
}