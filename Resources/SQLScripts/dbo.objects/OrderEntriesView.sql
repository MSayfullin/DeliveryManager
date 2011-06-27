
/****** Object:  View [dbo].[OrderEntriesView]    Script Date: 02/06/2011 16:40:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[OrderEntriesView]
AS
SELECT     dbo.Entries.Id, dbo.Entries.Count, dbo.Entries.DeliveryEntityId, dbo.Entries_OrderEntry.OrderId, dbo.Orders.Number AS Order_Number, 
                      dbo.Orders.Date AS Order_Date, dbo.DeliveryEntitiesView.Name AS DeliveryEntity_Name, dbo.DeliveryEntitiesView.EntityType AS DeliveryEntity_Type, 
                      dbo.Entries_OrderEntry.Cost, dbo.Entries_OrderEntry.Price, dbo.Orders.ClientId
FROM         dbo.Entries INNER JOIN
                      dbo.Entries_OrderEntry ON dbo.Entries.Id = dbo.Entries_OrderEntry.Id INNER JOIN
                      dbo.Orders ON dbo.Entries_OrderEntry.OrderId = dbo.Orders.Id INNER JOIN
                      dbo.DeliveryEntitiesView ON dbo.Entries.DeliveryEntityId = dbo.DeliveryEntitiesView.Id

GO
