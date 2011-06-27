
/****** Object:  StoredProcedure [dbo].[get_delivery_info]    Script Date: 02/06/2011 16:37:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Marsel Sayfullin
-- Create date: 19 January 2011
-- Description:	Total Delivery info
-- =============================================
CREATE PROCEDURE [dbo].[get_delivery_info]
	@delivery_id int
AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON;

SELECT
	d.Id,
	d.[Date],
	d.[Status],
	d.Notes,
	d.Address_Country,
	d.Address_City,
	d.Address_ZipCode,
	d.Address_Details,
	dbo.combine_name(courier.FullName_Name, courier.FullName_MiddleName, courier.FullName_Surname) AS Courier_FullName,
	courier.Phone AS Courier_Phone,
	courier.Email AS Courier_Email,
	dt.Name AS DeliveryType,
	dt.Cost AS DeliveryType_Cost,
	o.Number AS Order_Number,
	dbo.combine_name(client.FullName_Name, client.FullName_MiddleName, client.FullName_Surname) AS Client_FullName,
	client.Phone AS Client_Phone,
	client.Email AS Client_Email,
	oe.DeliveryEntity_Name,
	oe.[Count] AS DeliveryEntity_Count,
	oe.Cost AS DeliveryEntity_Cost,
	oe.Price AS DeliveryEntity_Price
FROM Deliveries d
INNER JOIN DeliveryTypes dt ON dt.Id = d.DeliveryTypeId
INNER JOIN Orders o ON o.DeliveryId = d.Id
INNER JOIN Users client ON client.Id = o.ClientId
INNER JOIN OrderEntriesView oe ON oe.OrderId = o.Id
LEFT JOIN Users courier ON courier.Id = d.CourierId
WHERE d.Id = @delivery_id

END

GO
