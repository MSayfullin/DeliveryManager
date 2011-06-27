
/****** Object:  View [dbo].[DeliveryEntitiesView]    Script Date: 04/09/2011 22:03:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[DeliveryEntitiesView]
AS
SELECT     dbo.DeliveryEntities.Id, dbo.DeliveryEntities.Name, dbo.DeliveryEntities.Cost, dbo.DeliveryEntities.Price, CASE WHEN dbo.DeliveryEntities_Book.Id IS NOT NULL 
                      THEN 'Книга' WHEN dbo.DeliveryEntities_CD.Id IS NOT NULL THEN 'CD' END AS EntityType
FROM         dbo.DeliveryEntities LEFT OUTER JOIN
                      dbo.DeliveryEntities_Book ON dbo.DeliveryEntities.Id = dbo.DeliveryEntities_Book.Id LEFT OUTER JOIN
                      dbo.DeliveryEntities_CD ON dbo.DeliveryEntities.Id = dbo.DeliveryEntities_CD.Id

GO
