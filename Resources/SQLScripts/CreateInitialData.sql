
----------------Create DeliveryTypes-------------------------
INSERT [dbo].[DeliveryTypes] ([Name], [Cost]) VALUES (N'Shipping', CAST(50 AS Decimal(18, 4)))
INSERT [dbo].[DeliveryTypes] ([Name], [Cost]) VALUES (N'Delivery', CAST(200 AS Decimal(18, 4)))
INSERT [dbo].[DeliveryTypes] ([Name], [Cost]) VALUES (N'Gift', CAST(0 AS Decimal(18, 4)))

----------------Create CorrectionTypes-------------------------
INSERT [dbo].[CorrectionTypes] ([Name], [IsNegative]) VALUES (N'Write-off', 'True')
INSERT [dbo].[CorrectionTypes] ([Name], [IsNegative]) VALUES (N'Stocking', 'False')


----------------Create Depots-------------------------
INSERT [dbo].[Depots] ([Name], [Address_Details], [Address_City], [Address_Country], [Address_ZipCode]) VALUES (N'Depot 1', N'Right Saint Pete''s corner', N'Saint Pete', N'Russia', NULL)
INSERT [dbo].[Depots] ([Name], [Address_Details], [Address_City], [Address_Country], [Address_ZipCode]) VALUES (N'Depot 2', N'Never Land', N'Saint Pete', N'Russia', NULL)