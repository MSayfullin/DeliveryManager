
/****** Object:  UserDefinedFunction [dbo].[get_sold_entries_as_of]    Script Date: 02/06/2011 01:18:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- ==============================================
-- Author:		Marsel Sayfullin
-- Create date: 6 February 2011
-- Description:	Get all sold entries as of date
-- ==============================================
CREATE FUNCTION [dbo].[get_sold_entries_as_of]
(
	@as_of_date date
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
		*
	FROM
		dbo.get_sold_entries_for_range('1900-01-01', @as_of_date)
)

GO
