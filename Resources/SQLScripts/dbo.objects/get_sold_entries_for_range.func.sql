
/****** Object:  UserDefinedFunction [dbo].[get_sold_entries_for_range]    Script Date: 02/06/2011 16:49:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- ==================================================
-- Author:		Marsel Sayfullin
-- Create date: 9 April 2011
-- Description:	Get all sold entries for date range
-- ==================================================
CREATE FUNCTION [dbo].[get_sold_entries_for_range]
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
		groupped.[Count],
		de.Cost,
		groupped.TotalCost,
		de.Price,
		groupped.TotalPrice
	FROM
		(SELECT
			DeliveryEntityId,
			SUM([Count]) AS [Count],
			SUM(TotalCost) AS TotalCost,
			SUM(TotalPrice) AS TotalPrice
		FROM
			(SELECT
				oe.DeliveryEntityId,
				d.[Date],
				oe.[Count],
				oe.Cost,
				oe.Price,
				oe.[Count] * oe.Cost as TotalCost,
				oe.[Count] * oe.Price as TotalPrice
			FROM OrderEntriesView AS oe
			INNER JOIN Orders AS o ON o.Id = oe.OrderId
			INNER JOIN Deliveries d ON d.Id = o.DeliveryId
			WHERE d.[Status] LIKE '%Доставлено%'

			UNION ALL

			SELECT
				oe.DeliveryEntityId,
				o.[Date],
				oe.[Count],
				oe.Cost,
				oe.Price,
				oe.[Count] * oe.Cost as TotalCost,
				oe.[Count] * oe.Price as TotalPrice
			FROM OrderEntriesView AS oe
			INNER JOIN Orders AS o ON o.Id = oe.OrderId
			WHERE o.WithoutDelivery = 1) AS unioned
		WHERE @start_date <= [Date] AND [Date] <= @finish_date
		GROUP BY DeliveryEntityId) AS groupped
	INNER JOIN DeliveryEntitiesView de ON de.Id = groupped.DeliveryEntityId
)

GO
