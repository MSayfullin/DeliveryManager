
/****** Object:  View [dbo].[CorrectionEntriesView]    Script Date: 02/06/2011 16:38:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[CorrectionEntriesView]
AS
SELECT     dbo.Entries.Id, dbo.Entries.Count, dbo.Entries_CorrectionEntry.CorrectionId, dbo.Corrections.Date AS Correction_Date, dbo.CorrectionTypes.Name AS CorrectionType, 
                      dbo.CorrectionTypes.IsNegative AS IsCorrectionNegative, dbo.Entries.DeliveryEntityId, dbo.DeliveryEntitiesView.Name AS DeliveryEntity_Name, 
                      dbo.DeliveryEntitiesView.EntityType AS DeliveryEntity_Type, dbo.Entries_CorrectionEntry.Cost
FROM         dbo.Entries INNER JOIN
                      dbo.Entries_CorrectionEntry ON dbo.Entries.Id = dbo.Entries_CorrectionEntry.Id INNER JOIN
                      dbo.Corrections ON dbo.Entries_CorrectionEntry.CorrectionId = dbo.Corrections.Id INNER JOIN
                      dbo.CorrectionTypes ON dbo.Corrections.CorrectionTypeId = dbo.CorrectionTypes.Id INNER JOIN
                      dbo.DeliveryEntitiesView ON dbo.Entries.DeliveryEntityId = dbo.DeliveryEntitiesView.Id

GO
