SET ANSI_NULLS ON
GO
SET XACT_ABORT ON -- Если выполнялась транзакция и произошла ошибка, произойдёт откат транзакции
GO
SET NOCOUNT ON -- Подавление сообщений типа "5 rows affected"
GO

CREATE PROCEDURE dbo.updateBudgetValue 
	@FamilySurName VARCHAR(255)
AS
BEGIN TRY
	IF @FamilySurName IS NULL
		RAISERROR (N'Передано не корректное значение фамилии семьи',16,1, @FamilySurName) WITH NOWAIT;

	DECLARE @BudgetValue MONEY, @SumValueInBasket MONEY = 0, @IDFamily INT = 0;

	SELECT @IDFamily = ID_Family, @BudgetValue = BudgetValue FROM dbo.Family WHERE SurName LIKE @FamilySurName

	IF @IDFamily > 0
		BEGIN
			SELECT @SumValueInBasket = SUM(Value) FROM dbo.Basket WHERE ID_Family = @IDFamily;

			IF @SumValueInBasket > 0
				UPDATE dbo.Family SET BudgetValue = @BudgetValue - @SumValueInBasket WHERE ID_Family = @IDFamily;
		END
	ELSE
		BEGIN
			DECLARE @messagetext NVARCHAR(255) = CONCAT(N'Семьи с фамилией "', @FamilySurName, N'" не существует');
		    RAISERROR (@messagetext,16,1, @FamilySurName) WITH NOWAIT;
		END
END TRY
BEGIN CATCH
	PRINT ERROR_MESSAGE();
END CATCH;