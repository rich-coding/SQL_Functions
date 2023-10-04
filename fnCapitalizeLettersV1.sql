USE [Your Base Data]
GO
/* ============================================================
Author:	Rich-Coding
Create date: <03 Oct 2023>
Description: Change the firts letter of each word to Upper Case but
			remains the rest of the word in Lower Case.
Retorno: Capitalize Word like Names
Example: fnCapitalizeLettersV1('this IS A tEsT o')
		Returns: 'This Is A Test'
============================================================*/

CREATE FUNCTION fnCapitalizeLettersV1 ( @Text NVARCHAR(2000) )
RETURNS NVARCHAR(2000)
AS
BEGIN
	--Declaring variables
	DECLARE @Result NVARCHAR(2000), @j INT, @Stop INT
	--Testing zone
	--DECLARE @Text NVARCHAR(2000)
	--SET @Text = TRIM(LOWER('this IS a simple TEST that preTENds to demonstrate the use of this function r'))
	--Setting variables
	SET @Result = ''
	SET @j = 0
	SET @Stop = LEN(@Text)
	SET @Text = TRIM(LOWER(@Text))
	--Performing capitalizing process
	WHILE  @j <= @Stop
		BEGIN
            --Only upper casing first letter
            SET @Text = UPPER(LEFT(@Text,1)) + SUBSTRING(@Text,2,LEN(@Text))
            --Adding only capitalized word to result
            IF CHARINDEX(' ', @Text) > 0
                SET @Result = @Result + LEFT(@Text,CHARINDEX(' ', @Text)-1) + ' '
            --Removing capitalized word from the original text
            IF LEN(@Text)-CHARINDEX(' ',@Text) > 0
				SET @Text = RIGHT(@Text, LEN(@Text)-CHARINDEX(' ',@Text))
            --Increasing counter and continue looping
            SET @j = @j + 1
        END
    --Adding the last capitalized word to result
    SET @Result = @Result + UPPER(LEFT(@Text,1)) + SUBSTRING(@Text,2,LEN(@Text))
    --Removing possible spaces at the start and end of the result
    SET @Result = TRIM(@Result)
	--Testing zone
	--PRINT(@Result)
	--Returning final result
    RETURN @Result
END

