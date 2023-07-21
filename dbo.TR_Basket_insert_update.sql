CREATE TRIGGER dbo.basketUpdateDiscountValueWhenInserting
ON Basket AFTER INSERT
AS
BEGIN
	DECLARE @insertIDBasket INT;

	DECLARE rows_for_add_discount_cursor CURSOR
	FOR
		SELECT ID_Basket 
		FROM inserted 
		WHERE ID_SKU IN (
				SELECT ID_SKU
				FROM inserted
				GROUP BY ID_SKU
				HAVING COUNT(*) > 1
			);
	
	OPEN rows_for_add_discount_cursor;
	FETCH NEXT FROM rows_for_add_discount_cursor INTO @insertIDBasket;

	WHILE @@FETCH_STATUS = 0
		BEGIN
			UPDATE dbo.Basket SET DiscountValue = "Value" * 0.05 WHERE ID_Basket = @insertIDBasket;
			FETCH NEXT FROM rows_for_add_discount_cursor INTO @insertIDBasket;
		END;

	CLOSE rows_for_add_discount_cursor;
	DEALLOCATE rows_for_add_discount_cursor;
END;