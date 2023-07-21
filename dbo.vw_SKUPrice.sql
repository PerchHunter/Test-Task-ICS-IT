CREATE VIEW dbo.infoOfProducts
AS
SELECT S.*, dbo.getCostOfProduct(S.ID_SKU) AS price
FROM dbo.SKU AS S
LEFT JOIN dbo.Basket AS B ON B.ID_SKU = S.ID_SKU
GROUP BY S.ID_SKU, S.Code, S.Name;


-- Вызываем представление
SELECT * FROM dbo.infoOfProducts;