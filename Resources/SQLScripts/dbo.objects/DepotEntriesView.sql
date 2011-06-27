
/****** Object:  View [dbo].[DepotEntriesView]    Script Date: 01/23/2011 13:55:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[DepotEntriesView]
AS
SELECT     dbo.Entries.Id AS EntryId, dbo.Entries.Count, dbo.Entries_DepotEntry.DepotId, dbo.Depots.Name AS Depot_Name, 
                      dbo.Depots.Address_Details AS Depot_Address_Details, dbo.Depots.Address_City AS Depot_Address_City, dbo.Depots.Address_Country AS Depot_Address_Country, 
                      dbo.Depots.Address_ZipCode AS Depot_Address_ZipCode, dbo.Entries.DeliveryEntityId, dbo.DeliveryEntitiesView.Name AS DeliveryEntity_Name, 
                      dbo.DeliveryEntitiesView.Cost AS DeliveryEntity_Cost, dbo.DeliveryEntitiesView.Price AS DeliveryEntity_Price, 
                      dbo.DeliveryEntitiesView.EntityType AS DeliveryEntity_Type
FROM         dbo.Entries INNER JOIN
                      dbo.Entries_DepotEntry ON dbo.Entries.Id = dbo.Entries_DepotEntry.Id INNER JOIN
                      dbo.Depots ON dbo.Entries_DepotEntry.DepotId = dbo.Depots.Id INNER JOIN
                      dbo.DeliveryEntitiesView ON dbo.Entries.DeliveryEntityId = dbo.DeliveryEntitiesView.Id

GO
