
/****** Object:  UserDefinedFunction [dbo].[get_sold_entries_with_corrections_for_range]    Script Date: 02/06/2011 16:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- ===================================================================
-- Author:		Marsel Sayfullin
-- Create date: 9 April 2011
-- Description:	Get all sold entries with corrections for date range
-- ===================================================================
CREATE FUNCTION [dbo].[get_sold_entries_with_corrections_for_range]
(
	@start_date date,
	@finish_date date
)
RETURNS TABLE
AS
RETURN
(
	SELECT
		de.Id,
		de.Name,
		de.EntityType,
		groupped.SoldCount,
		de.Cost,
		groupped.SoldTotalCost,
		de.Price,
		groupped.SoldTotalPrice,
		groupped.CorrectedCount,
		groupped.CorrectedTotalCost
	FROM
		(SELECT
			DeliveryEntityId,
			SUM(SoldCount) AS SoldCount,
			SUM(CorrectedCount) AS CorrectedCount,
			SUM(SoldTotalCost) AS SoldTotalCost,
			SUM(SoldTotalPrice) AS SoldTotalPrice,
			SUM(CorrectedTotalCost) AS CorrectedTotalCost
		FROM
			(SELECT
				oe.DeliveryEntityId,
				d.[Date],
				oe.[Count] AS SoldCount,
				oe.Cost,
				oe.Price,
				oe.[Count] * oe.Cost as SoldTotalCost,
				oe.[Count] * oe.Price as SoldTotalPrice,
				0 AS CorrectedCount,
				0 AS CorrectedTotalCost
			FROM OrderEntriesView AS oe
			INNER JOIN Orders AS o ON o.Id = oe.OrderId
			INNER JOIN Deliveries d ON d.Id = o.DeliveryId
			WHERE d.[Status] LIKE '%Доставлено%'

			UNION ALL

			SELECT
				oe.DeliveryEntityId,
				o.[Date],
				oe.[Count] AS SoldCount,
				oe.Cost,
				oe.Price,
				oe.[Count] * oe.Cost as SoldTotalCost,
				oe.[Count] * oe.Price as SoldTotalPrice,
				0 AS CorrectedCount,
				0 AS CorrectedTotalCost
			FROM OrderEntriesView AS oe
			INNER JOIN Orders AS o ON o.Id = oe.OrderId
			WHERE o.WithoutDelivery = 1

			UNION ALL

			SELECT
				DeliveryEntityId,
				Correction_Date AS [Date],
				0 AS SoldCount,
				Cost,
				0 AS Price,
				0 AS SoldTotalCost,
				0 AS SoldTotalPrice,
				[Count] AS CorrectedCount,
				[Count] * Cost AS CorrectedTotalCost
			FROM CorrectionEntriesView
			WHERE CorrectionType LIKE '%Списание%') AS unioned
		WHERE @start_date <= [Date] AND [Date] <= @finish_date
		GROUP BY DeliveryEntityId) AS groupped
	INNER JOIN DeliveryEntitiesView de ON de.Id = groupped.DeliveryEntityId
)

GO
