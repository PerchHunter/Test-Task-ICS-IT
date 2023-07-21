CREATE FUNCTION dbo.getCostOfProduct(@ID_SKU INT)
RETURNS DECIMAL(18,2)
WITH EXECUTE AS CALLER
AS
BEGIN
	DECLARE @costOfProduct DECIMAL(18,2);

	SELECT @costOfProduct = SUM("Value") / SUM(Quantity)
	FROM dbo.Basket
	WHERE ID_SKU = @ID_SKU;

	RETURN @costOfProduct;
END;


-- Вызов функции
 SELECT dbo.getCostOfProduct(3) AS costOfProduct;
