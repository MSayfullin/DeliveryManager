
/****** Object:  UserDefinedFunction [dbo].[combine_name]    Script Date: 01/23/2011 13:56:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Marsel Sayfullin
-- Create date: 23 January 2011
-- Description:	Combines Name Parts into one
-- =============================================
CREATE FUNCTION [dbo].[combine_name] 
(
	@name varchar(300),
	@middle_name varchar(300),
	@surname varchar(300)
)
RETURNS varchar(MAX)
AS
BEGIN
	DECLARE @combined_name varchar(MAX)

	SELECT @combined_name =
		CASE
			WHEN @middle_name IS NULL THEN @name + ' ' + @surname
			ELSE @name + ' ' + @middle_name + ' ' + @surname
		END

	RETURN @combined_name

END

GO


